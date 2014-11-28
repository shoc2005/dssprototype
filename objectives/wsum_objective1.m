function y=wsum_objective1(arg,opt)
%y=(x-2)^2;

weights=arg;

count=size(opt.goal,2);

[x1,y]=wsum_inicialize(opt.x0,weights,opt.problem);


if count==2;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2);
elseif count==3;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2+(y(3)-opt.goal(3))^2);

end