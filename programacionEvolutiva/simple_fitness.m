function fitness = simple_fitness(individual)
fitness = 100 *(individual(1)^2 - individual(2))^2 + (1-individual(1))^2;

end