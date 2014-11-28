function [c,ceq] = con(x,problem,lb,ub,funs)
c=[];
ceq=[];
switch problem
    case 'HANNE'
        funs={@objectiveT1_1,@objectiveT1_2};
        for i=1:size(funs,2);
            c(end+1)=feval(funs{i},x)-ub(i);
            c(end+1)=-feval(funs{i},x)+lb(i);
        end;
end;
