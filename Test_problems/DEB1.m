function DEB1()

x1=[0:0.005:1];
x2=[0:0.005:1];

pareto=[];
x_pareto=[];
for i=1:size(x1,2);
    for j=1:size(x2,2);
        x=[x1(i),x2(j)];
        f1=objectiveDeb1_1(x);
        f2=objectiveDeb1_2(x);
        pareto(end+1,:)=[f1 f2];
        x_pareto(end+1,:)=x;
        plot(f1,f2);
        hold on;
    end;
end;
xlabel('f_1(x)');
ylabel('f_2(x)');
title('DEB1 nonconvex function');

true_pareto=[];
true_pareto_x=[];
for i=1:size(pareto,1);
    if dominance1(i,pareto)==0;
        true_pareto(end+1,:)=pareto(i,:);
        true_pareto_x(end+1,:)=x_pareto(i,:);
        plot(true_pareto(end,1),true_pareto(end,2),'-*r');
    end;
end;

save('DEB1', 'true_pareto','true_pareto_x');