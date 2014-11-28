function res=guess_problem(x,znad,zref,funs)

res=[];
for i=1:size(funs,2);
    res(i)=((znad(i)-feval(funs{i},x))/(znad(i)-zref(i)));
    
end;


res=min(res);
%res=-x(end);
res=res*-1;
%res=max(res);