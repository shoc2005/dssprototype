function y=guess_objective2(arg,opt)
%y=(x-2)^2;

global flag_stop;
zref_end=size(opt.goal,2);
zref=arg(1:zref_end);
lb_start=zref_end+1;
lb_end=zref_end+size(opt.goal,2);
lb=arg(lb_start:lb_end);

ub_start=lb_end+1;
ub=arg(ub_start:end);

algol=get(findobj('Tag','lowmeth'),'Value');

[x,y,exitf]=guess_inicialize(opt.x0,zref,lb,ub,opt.problem);

if exitf<0;
    if algol==1;
        set(findobj('Tag','lowmeth'),'Value',2);
    else
        set(findobj('Tag','lowmeth'),'Value',1);
    end;
    [x,y,exitf]=guess_inicialize(opt.x0,zref,lb,ub,opt.problem);
    
end;
flag_global=exitf;

%arg
count=size(opt.goal,2);

if count==2;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2);
elseif count==3;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2+(y(3)-opt.goal(3))^2);

end

%1.8348   13.6852    0.7820