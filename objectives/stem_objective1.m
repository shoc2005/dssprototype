function y=stem_objective1(arg,opt)
%y=(x-2)^2;
global flag_stop;
flag_stop=0;

%fnum=arg(1);
%ub=arg(2:end);
count=size(opt.goal,2);

%[x1,y]=iswt_inicialize(opt.x0,fnum,ub,opt.problem);

sz=size(opt.goal,2);
st=sz;
satFuns=arg(1:st);
st=sz+1;
unsatFuns=arg(st:sz*2);
st=sz*2+1;
%satFuns=unique(fix(satFuns));
%unsatFuns=unique(fix(unsatFuns));

satFuns=(round(satFuns));
unsatFuns=(round(unsatFuns));
satFuns=find(satFuns==1);
unsatFuns=find(unsatFuns==1);

econs=arg(st:sz*3);


algol=get(findobj('Tag','lowmeth'),'Value');

%satFuns<=econs
%unsatFuns<prev
[x1,y,exitf]=stem_inicialize(opt.x0,opt.prev,satFuns,unsatFuns,econs,opt.problem,opt.iter, opt.ideal);
if exitf<0;
    if algol==1;
        set(findobj('Tag','lowmeth'),'Value',2);
    else
        set(findobj('Tag','lowmeth'),'Value',1);
    end;
    [x1,y,exitf]=stem_inicialize(opt.x0,opt.prev,satFuns,unsatFuns,econs,opt.problem,opt.iter, opt.ideal);
    
end;

flag_stop=exitf;

if count==2;
    yd=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2);
elseif count==3;
    yd=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2+(y(3)-opt.goal(3))^2);

end

if yd<0.0005;
    a=1
end;
y=yd;

%1.8348   13.6852    0.7820

