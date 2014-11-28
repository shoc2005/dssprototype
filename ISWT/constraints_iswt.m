function [c,ceq]=constraints_iswt(x,fnum,fhandles,ineqh, eqh, ub)
% x vector of problem variables, for example problem H1
%fnum - function what be minimizing
%ineqh - handle of inequality function for MOOP problem
%eqh - handle of equality function for MOOP problem
%up- upper value bounds for objective functions

c=[]; % c<=0
ceq=[]; %ceq=0;

objcount=size(fhandles,2);

for i=1:objcount;
    if i~=fnum;
        c(end+1)=feval(fhandles{i},x)-ub(i);  
    end;
end;


if isempty(ineqh)==0;
    ineq=feval(ineqh,x);
    c=[c,ineq];
end;

if isempty(eqh)==0;
    ceq=feval(eqh,x);
end;
   

end

