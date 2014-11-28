function options=scaled_fitness(options)
%function calculate scaled fitness
scaled_fit=[];
parfor i=1:options.popsize;
    m=find(options.ranks==options.ranks(i));
    s=0;
    for j=1:size(m,1);
        s=s+options.shared_fitness(m(j));
    end;
    scaled_fit(i,1)=(options.avgfitness(i)*size(m,1)/s)*options.shared_fitness(i);
end;

options.scaled_fit=scaled_fit;
end