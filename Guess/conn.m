function [c,ceq] = conn(x,problem,lb,ub,funs, asp, nadir)
c=[];
ceq=[];
for i=1:size(funs,2);
    c(end+1)=feval(funs{i},x)-ub(i);
    c(end+1)=-feval(funs{i},x)+lb(i);
    %c(end+1)=((-feval(funs{i},x)+(asp(i)-nadir(i))*x(end)))+nadir(i);
end;

switch problem
    case 'HANNE'
       % c(end+1)=-x(1)-x(2)+5;
    case 'HANNE1'
        c(end+1)=(x(2)-5+0.5*x(1)*sin(4*x(1)))*-1;
    case 'BINH1'
        c(end+1)=-50;
        c(end+1)=0;
        %c(end+1)=-x(1)-5;
        %c(end+1)=x(2)-10;
    case 'BINH2'
        c(end+1)=(x(1)-10^(-6))*-1;
        c(end+1)=(10^6-x(2))*-1;
    case 'TAPPETA'
        c(end+1)=-12+x(1)^2+x(2)^2+x(3)^2;
end;