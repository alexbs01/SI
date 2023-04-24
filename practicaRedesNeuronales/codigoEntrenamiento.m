clear;

% Leemos los archivos de entrada y salida
input = csvread('input.csv')'; % Al final se ponde el apostrofe para hacer la traspuesta
target = csvread('output.csv')';

% Inicializamos los arrays que almacenarán la precisión de la red en la
% iteración i
precisionEntrenamiento = [];
precisionValidacion = [];
precisionTest = [];
best_epoch = [];
media = [];
desviacionTipica = [];
neuronas = 1;

% Creamos un bucle for que haga 50 iteraciones
for i=1:50,
    rna = patternnet([neuronas]); % Crea una RN X neuronas en la capa oculta, más columnas -> más capas
    rna.trainParam.showWindow = false; % Establecemos que no se muestre la ventana de entrenamiento
    [rna, tr] = train(rna, input, target); % Entrena el modelo
    best_epoch(end + 1) = tr.best_epoch; % Almacena la mejor época del entrenamiento
    setasOutput = sim(rna, input); % Simula la salida de la red neuronal en el estado que dio mejores resultados
    precisionEntrenamiento(end+1) = 1-confusion(target(:,tr.trainInd), setasOutput(:,tr.trainInd));
    precisionValidacion(end+1) = 1-confusion(target(:,tr.valInd),setasOutput(:,tr.valInd));
    precisionTest(end+1) = 1-confusion(target(:,tr.testInd), setasOutput(:,tr.testInd));
end;

media(end + 1) = mean(precisionTest);
desviacionTipica(end + 1) = std(precisionTest);
iteracionElegida = find(precisionValidacion == max(precisionValidacion), 1, 'first');
% fprintf("Número de capas ocultas: %d\n" + ...
%         "Número de neuronas en la o las capas ocultas: %d\n", rna.numLayers - 1, neuronas);
% fprintf("Iteración con mejor precisión en validación: %d\n", iteracionElegida);
% fprintf("Mejor época de la iteración: %d\n", best_epoch(iteracionElegida));
% fprintf("Precisión del entrenamiento: %f\n", precisionEntrenamiento(iteracionElegida));
% fprintf("Precisión de la validación: %f\n", precisionValidacion(iteracionElegida));
% fprintf("Precisión de los test: %f\n", precisionTest(iteracionElegida));
% fprintf("Media global de acierto: %f\n" + ...
%         "Desviación típica global: %f\n\n", media(1), desviacionTipica(1));

fprintf("NumsOcultas | NumNeur | Iter mejor prec vali | Mejor epoca | Prec entren | Prec valid | Prec test | Media    | Desvi\n");
fprintf("\t%d \t\t| \t%d\t  | \t\t%d\t\t\t | \t\t%d\t   |   %f  | %f   | %f  | %f | %f \n", ...
    rna.numLayers - 1, ...
    neuronas, ...
    iteracionElegida, ...
    best_epoch(iteracionElegida), ...
    precisionEntrenamiento(iteracionElegida), ...
    precisionValidacion(iteracionElegida), ...
    precisionTest(iteracionElegida), ...
    media(1), ...
    desviacionTipica(1));


precisionEntrenamiento = [];
precisionValidacion = [];
precisionTest = [];

for i=1:50,
    rna = patternnet([neuronas neuronas]); % Crea una RN X neuronas en la capa oculta, más columnas -> más capas
    rna.trainParam.showWindow = false; % Establecemos que no se muestre la ventana de entrenamiento
    [rna tr] = train(rna, input, target); % Entrena el modelo
    setasOutput = sim(rna, input); % Simula la salida de la red neuronal
    precisionEntrenamiento(end+1) = 1-confusion(target(:,tr.trainInd), setasOutput(:,tr.trainInd));
    precisionValidacion(end+1) = 1-confusion(target(:,tr.valInd),setasOutput(:,tr.valInd));
    precisionTest(end+1) = 1-confusion(target(:,tr.testInd), setasOutput(:,tr.testInd));
end;

media(end + 1) = mean(precisionTest);
desviacionTipica(end + 1) = std(precisionTest);
iteracionElegida = find(precisionValidacion == max(precisionValidacion), 1, 'first');
fprintf("\t%d \t\t| \t%d\t  | \t\t%d\t\t\t | \t\t%d\t   |   %f  | %f   | %f  | %f | %f \n\n", ...
    rna.numLayers - 1, ...
    neuronas, ...
    iteracionElegida, ...
    best_epoch(iteracionElegida), ...
    precisionEntrenamiento(iteracionElegida), ...
    precisionValidacion(iteracionElegida), ...
    precisionTest(iteracionElegida), ...
    media(2), ...
    desviacionTipica(2));

