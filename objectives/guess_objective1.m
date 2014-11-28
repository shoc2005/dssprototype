function y=guess_objective1(arg,opt)
% this function use penalty function to determine correct information from
% DM
%the main function 1 then w(1)=1;
stop=size(opt.goal,2);
ref=arg(1:stop);
y=0;

zref_end=size(opt.goal,2);

lb_start=zref_end+1;
lb_end=zref_end+size(opt.goal,2);
lb=arg(lb_start:lb_end);
ub_start=lb_end+1;
ub=arg(ub_start:end);


for i=1:size(ref,2);
    if (ref(i)<opt.ideal(i))||(ref(i)>opt.znad(i));
        y=y+1;
    end;
    
end;

%y=y+sqrt((ref(i)-opt.goal(i))^2)-0.5;

for i=1:size(ub,2);
    %%if (ref(i)~=ub(i) || ref(i)~=lb(i));
    %%    y=y+1;
    %%end;
    
    if (ref(i)>ub(i) || ref(i)<lb(i));
        y=y+0.5;
    end;
    
    if ub(i)<=lb(i);
        y=y+1;
    end;
    
    if ub(i)>opt.znad(i);
        y=y+1;
    end;
    
    if lb(i)<opt.ideal(i);
        y=y+1;
    end;
    %if ref(i)<lb(i) ||ref(i)>ub(i);
    %    y=y+1;
    %end;

end;
global flag_stop;
if flag_stop<0;
    y=y+abs(flag_stop);
end;
