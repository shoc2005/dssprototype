function [c, ceq]=constraints_wsum(x,ineqh,eqh)
%common constraint function fro weighted method

c=[];
ceq=[];

if not(isempty(ineqh));
    c=feval(ineqh,x);
end;

if not(isempty(eqh));
    ceq=feval(eqh,x);
end;

end
