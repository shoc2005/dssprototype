function index=select_solution(options)
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

%[v,index]=max(solutions_to_copy);
[v,index]=min(options.ranks);
%list=find(solutions_to_copy==v);
list=find(options.ranks==v);


obj=[];
for j=1:size(list,1);
    obj(j,:)=[options.objvals(list(j),:),options.ranks(list(j)),list(j),solutions_to_copy(list(j))];
end;
%list2=find(obj(:,end-2)==1); %prev
list2=find(obj(:,2)==0); %new by 11.02.2010. jornal, find where VRI is precize

obj2=[];
for j=1:size(list2,1);
    obj2(j,:)=obj(list2(j),:);
end;

try
    
if size(obj2,1)==0;
    %[v,ix]=min(obj(:,2))
    %index=list(ix);
    index=-1;
else
    [v,ix]=max(obj2(:,end))
    index=obj2(ix,end-1);
    
end;

catch
'error'    
end;


end
    