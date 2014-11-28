function y=test_objective2(w,opt)
%y=(x-2)^2;

%n=w(1);
%w(round(n)+1)=1;
global flag_stop;

algol=get(findobj('Tag','lowmeth'),'Value');

[x1,y,exitf]=geoff_inicialize(opt.x0,w, opt.problem);

if exitf<0;
    if algol==1;
        set(findobj('Tag','lowmeth'),'Value',2);
    else
        set(findobj('Tag','lowmeth'),'Value',1);
    end;
    [x1,y,exitf]=geoff_inicialize(opt.x0,w, opt.problem);
    
end;

flag_stop=exitf;


count=size(opt.goal,2); %count of objectives

if count==2;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2);
end;

if count==3;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2+(y(3)-opt.goal(3))^2);
end;

end