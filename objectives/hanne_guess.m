function res=guess_problem(x,znad,zref,funs)

funs={@objectiveT1_1,@objectiveT1_2};
for i=1:size(funs,2);
    y(i)=(znad(i)-feval(funs{i},x))/(znad(i)-zref(i));
end;

res=min(y);
res=res*-1;