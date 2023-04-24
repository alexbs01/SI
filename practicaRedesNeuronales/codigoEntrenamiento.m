clear;

% Leemos los archivos de entrada y salida
input = csvread('input.csv')'; % Al final se ponde el apostrofe para hacer la traspuesta
target = csvread('output.csv')';

% Inicializamos variables
precisionEntrenamiento = [];
precisionValidacion = [];
precisionTest = [];
best_epoch = [];
neuronasPrimerBucle = [2];
neuronasSegundoBucle = [2 2];
iteraciones = 10;

% Creamos un bucle for que haga N iteraciones de la que se seleccionará la mejor
for i = 1 : iteraciones
    rna = patternnet(neuronasPrimerBucle); % Crea una RN con X capas ocultas y N neuronas en cada capa
    rna.trainParam.showWindow = false; % Establecemos que no se muestre la ventana de entrenamiento
    [rna, tr] = train(rna, input, target); % Entrenamos el modelo
    best_epoch(end + 1) = tr.best_epoch; % Almacena la mejor época del entrenamiento
    setasOutput = sim(rna, input); % Simula la salida de la red neuronal en el estado que dio mejores resultados
    precisionEntrenamiento(end + 1) = 1 - confusion(target(:, tr.trainInd), setasOutput(:, tr.trainInd));
    precisionValidacion(end + 1) = 1 - confusion(target(:, tr.valInd),setasOutput(:, tr.valInd));
    precisionTest(end + 1) = 1 - confusion(target(:, tr.testInd), setasOutput(:, tr.testInd));
end;

% Seleccionamos la iteración del bucle con mejor precision
iteracionElegida = find(precisionValidacion == max(precisionValidacion), 1, 'first');

% Mostramos datos
cabeceraTabla()
crearTabla(rna, sum(neuronasPrimerBucle), iteracionElegida, best_epoch, precisionEntrenamiento, precisionValidacion, precisionTest)

% Reseteamos los valores de los arrays
precisionEntrenamiento = [];
precisionValidacion = [];
precisionTest = [];
best_epoch = [];

% Repetimos pero con una segunda red neuronal
for i = 1 : iteraciones
    rna = patternnet(neuronasSegundoBucle);
    rna.trainParam.showWindow = false;
    [rna, tr] = train(rna, input, target);
    best_epoch(end + 1) = tr.best_epoch;
    setasOutput = sim(rna, input);
    precisionEntrenamiento(end + 1) = 1 - confusion(target(:, tr.trainInd), setasOutput(:, tr.trainInd));
    precisionValidacion(end + 1) = 1 - confusion(target(:, tr.valInd),setasOutput(:, tr.valInd));
    precisionTest(end + 1) = 1 - confusion(target(:, tr.testInd), setasOutput(:, tr.testInd));
end;

iteracionElegida = find(precisionValidacion == max(precisionValidacion), 1, 'first');

crearTabla(rna, sum(neuronasSegundoBucle), iteracionElegida, best_epoch, precisionEntrenamiento, precisionValidacion, precisionTest)

% ##############################################################################

% Funciones para la creación de las tablas

function cabeceraTabla()
    fprintf("NumsOcultas | NumNeur | Iter mejor prec vali | Mejor epoca | Prec entren | Prec valid | Prec test | Media    | Desvi\n");
end

function crearTabla(rna, neuronas, iter, best_epoch, precisionEntrenamiento, precisionValidacion, precisionTest)
    fprintf("\t%d \t\t| \t%d\t  | \t\t%d\t\t\t | \t\t%d\t   |   %f  | %f   | %f  | %f | %f \n", ...
    rna.numLayers - 1, ...
    neuronas, ...
    iter, ...
    best_epoch(iter), ...
    precisionEntrenamiento(iter), ...
    precisionValidacion(iter), ...
    precisionTest(iter), ...
    mean(precisionTest), ...
    std(precisionTest));
end
