function options=shared_fitness(options)
% function calculate shared fitness value
parfor i=1:options.popsize;
    shared_fitness(i,1)=options.avgfitness(i)/options.niche_coutv(i);
end;

options.shared_fitness=shared_fitness;
end