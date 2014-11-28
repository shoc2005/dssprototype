function get_truePareto(fun_num)
% function generate test values for problem fun_num

if fun_num==1;
    x=[0:0.05:7];
    
    k=1;
    y=[];
    for i=1:size(x,2);
        for j=1:size(x,2);
            y1=sqrt(x(i));
            y2=sqrt(x(j));
            if (x(i)+x(j))>=5;
               y(k,1)=y1;
               y(k,2)=y2;
               xx(k,1)=x(i);
               xx(k,2)=x(j);
               k=k+1;
            end;
        end;
    end;
subplot(2,1,1);
title('Problem T1, objective value space');
xlabel('f_1(x)');
ylabel('f_2(x)');
for i=1:size(y,1);    
    hold on;
    plot(y(i,1),y(i,2));
end;

for i=1:size(y,1);
    ranks(i)=dominance1(i,y);
end;

s=find(ranks==0);
T1=[];
T1x=[];
subplot(2,1,1);
for i=1:size(s,2);
    T1(i,:)=y(s(i),:);
    T1x(i,:)=xx(s(i),:);
    plot(T1(i,1),T1(i,2),'-*r');
end;

%save('T1_true', 'T1');
save('T1_truex', 'T1x');

subplot(2,1,2);
title('Problem T1, variable value space');
xlabel('x_1');
ylabel('x_2');
for j=1:size(x,2);
    for i=1:size(x,2);
        hold on;
        if x(j)+x(i)>=5;
            plot(x(j),x(i));
        end;
    end;
end;
end;


end




