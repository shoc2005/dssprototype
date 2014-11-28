function res=stem_problem(x,w,ideal,funs)


for i=1:size(funs,2);
    y(i)=w(i)*abs(feval(funs{i},x)-ideal(i));
end;

res=max(y);
