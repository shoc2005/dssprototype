function [res,tendency]=changes(prev_cvals, cvals, goal)

cur=abs(goal-cvals);
prev=abs(goal-prev_cvals);


if satisfaction(goal,cvals)<satisfaction(goal,prev_cvals);
    tendency=1; %foward to the goal
elseif satisfaction(goal,cvals)>satisfaction(goal,prev_cvals);
    tendency=0; %torward to the goal
else
    tendency=-1;
end;

res=[];
for i=1:size(goal,2);
    if cur(i)<prev(i);
        res(i)=1;
    else
        res(i)=0;
    end;
end;


res
%{

c0=prev_cvals-goal;

for i=1:size(goal, 2);
    if c1(i)<c1(indx);
        res(i)=1; % the solution forward to goal or not changed
    else
        res(i)=0; % the solution unforward to goal
    end;
end;

%}
