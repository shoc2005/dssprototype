function y=iswt_objective1(arg,opt)
%y=(x-2)^2;


fnum=arg(1);
ub=arg(2:end);
count=size(opt.goal,2);

[x1,y]=iswt_inicialize(opt.x0,fnum,ub,opt.problem);

%arg


if count==2;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2);
elseif count==3;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2+(y(3)-opt.goal(3))^2);

end

%1.8348   13.6852    0.7820