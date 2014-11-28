function [c,ceq] = conn_stem(x,x0,prev_vals,satFuns,unsatFuns,e,funs,problem, iter)
c=[];
ceq=[];

%if iter~=1;
    for i=1:size(satFuns,2);
        c(end+1)=feval(funs{satFuns(i)},x)-e(satFuns(i));
    end;

    for i=1:size(unsatFuns,2);
        cn=feval(funs{unsatFuns(i)},x)-prev_vals(unsatFuns(i));
        %if cn~=0;
        c(end+1)=cn;  
        %end;

    end;
%end;

switch problem
    case 'HANNE'
        %c(end+1)=-x(1)-x(2)+5;
    case 'HANNE1'
        c(end+1)=(x(2)-5+0.5*x(1)*sin(4*x(1)))*-1;
    case 'BINH1'
        %c(end+1)=-x(1)-5;
        %c(end+1)=x(2)-10;
    case 'BINH2'
        c(end+1)=(x(1)-10^(-6))*-1;
        c(end+1)=(10^6-x(2))*-1;
    case 'TAPPETA'
        c(end+1)=-12+x(1)^2+x(2)^2+x(3)^2;
end;