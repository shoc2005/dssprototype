function [x1,y1,pareto]=geoffrion

x0=[2.7, 2.7];
%w0=[1   0.0631];
%delta0=[0.2, 0.1]; %DM 1

subplot(1,2,1);
hold on;
l=[0:0.5:30];
l1=[0:0.5:30];
xlabel('f1');
ylabel('f2');
objvals=[];

for i=1:size(l,2);
    for j=1:size(l1,2);
        if (l(i)+l1(j)>=5)
            objvals(end+1,1:2)=[sqrt(l(i)),sqrt(l1(j))];
            plot(sqrt(l(i)),sqrt(l1(j)),'-r');
        end;
    end;
end;

for i=1:size(objvals,1);
    objvals(i,3)=dominate(i,objvals);
end;

tmp=find(objvals(:,3)==0);

for i=1:size(tmp,1);
    pareto(i,1:2)=objvals(tmp(i),1:2);
    plot(pareto(i,1),pareto(i,2),'-or');
end;


subplot(1,2,2);

l=[0:0.5:30];
l1=[0:0.5:30];
hold on;
for i=1:size(l,2);
    for j=1:size(l1,2);
        if (l(i)+l1(j)>=5)
            plot(l(i),l1(j),'-r');
        end;
    end;
end;
xlabel('x1');
ylabel('x2');

subplot(1,2,1);
x=x0;
for i=1:1;
    w0=new_weights(x)
    [x,y]=geoff_inicialize(x,w0);
    x1(1,1)=x(1);
    x1(1,2)=x(2);
    y1(1,1)=sqrt(x(1));
    y1(1,2)=sqrt(x(2));
    
    plot(sqrt(x(1)),sqrt(x(2)),'-o');
    %hold on;
    %delta0=[random('beta',1,1)*2,random('beta',1,1)*2];
    y1(i,1)=sqrt(x(1));
    y1(i,2)=sqrt(x(2));
    x1(i,1)=x(1);
    x1(i,2)=x(2);

end;





%{
    
delta0=[0.5, 0.5]; %DM 2
[x,y]=geoff_inicialize(x0,delta0,w0);
x1(2,1)=x(1);
x1(2,2)=x(2);
y1(2,1)=sqrt(x(1));
y1(2,2)=sqrt(x(2));


w0=new_weights(x);

delta0=[0.4, 0.6]; %DM 2
[x,y]=geoff_inicialize(x0,delta0,w0);
x1(3,1)=x(1);
x1(3,2)=x(2);
y1(3,1)=sqrt(x(1));
y1(3,2)=sqrt(x(2));

plot(y1(1,1),y1(1,2),'-o');
hold on;
plot(y1(2,1),y1(2,2),'-o');
plot(y1(3,1),y1(3,2),'-o'     );

%}


end

function dom_count=dominate(index,vals)

dom_count=0;
y=vals(index,1:2);
for i=1:size(vals,1);
    s=0;
    f=0;
    if i~=index;
        for j=1:2;
            if (y(j)>=vals(i,j));
                f=f+1;
            end;

            if (y(j)>vals(i,j));
                s=s+1;
            end;
        end;
    end;

    if (f==2)&&(s>0);
        dom_count=dom_count+1;
    end;
end;

end
    
    