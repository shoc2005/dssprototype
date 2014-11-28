function result=generaldist(options)
%function calculates general distance between true Pareto set and
%nondominated solutions in current population
%this function is perormance measure function GD

%ranks=(options.ranks-1);
%set=find(ranks==0); %result in one column
% number of non-dominated solutions

m=[];
tp=options.truePareto;
y0=options.metrics.objvals;

nn=size(y0,1);

parfor j=1:nn;
   m(j)=eucdist(y0(j,:),tp)^2;
end;

%{

gd=0; %deneral distace
for i=1:n;
    euc(i,i)=inf;
    x=euc(i,n+1:end);
    % we need to change i-element value to maximum value, becouse i-element value is 0
    gd=gd+min(x);
end;
%}
result=sqrt(sum(m))/nn;
if isnan(result)||isinf(result);
     result=-1;
end;
end