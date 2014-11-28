function options=average_fitness(options)
% function calculate the avarage fitness
parfor i=1:options.popsize;
    s=0;
    for j=1:options.ranks(i,1);
        s=s+size(find(options.ranks==(j-1)),1);
    end;
    avgfitness(i,1)=options.popsize-s-0.5*(size(find(options.ranks==options.ranks(i,1)),1)-1);
end;
options.avgfitness=avgfitness;