function options=selection_op(options)
%function use Stochastic Universal Sampling operator
%first we need to calculate cumulative probability
fit_sum=sum(options.scaled_fit);
parfor i=1:options.popsize;
    prob(i)=options.scaled_fit(i,1)/fit_sum;
end;

parfor i=1:options.popsize;
    s=0;
    for j=1:i;
        s=s+prob(j);
    end;
    cum_probability(i,1)=s;
end;

r=rand(1,1); 
r=set_r(options.class,cum_probability);
N_set(1)=r;

parfor i=1:options.popsize-1;
    N_set(i+1)=r+i/options.popsize;
end;

N_set=mod(N_set,1);

solutions_to_copy=zeros(1,options.popsize);
for i=1:options.popsize;
    [n,j]=min((cum_probability-N_set(i)).^2);
    solutions_to_copy(j)=solutions_to_copy(j)+1;
end;

i=1;
new_popolation={};
while i<=options.popsize;
    for j=1:solutions_to_copy(i);
        new_popolation{end+1}=options.population{i};
    end;
    i=i+1;
end;

options.population=new_popolation;



end
    

    
    