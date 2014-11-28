function Binh1()
%first objective for Binh1 problem (pp226. Veldhuizen) 66
x1=[-5:0.1:10];
x2=[-5:0.1:10];

pareto=[];
xvalues=[];
for i=1:size(x1,2);
    for j=1:size(x2,2);
        x=[x1(i),x2(j)];
        f1=objectiveBinh1_1(x);
        f2=objectiveBinh1_2(x);
        pareto(end+1,:)=[f1 f2];
        xvalues(end+1,:)=x;
        plot(f2,f1);
        %drawnow;
        hold on;
    end;
end;
xlabel('f_1(x)');
ylabel('f_2(x)');
title('Binh1 convex function');
drawnow;

true_pareto=[];
true_pareto_x=[];
for i=1:size(pareto,1);
    if dominance1(i,pareto)==0;
        true_pareto(end+1,:)=pareto(i,:);
        true_pareto_x(end+1,:)=xvalues(i,:);
        plot(true_pareto(end,1),true_pareto(end,2),'-*r');
    end;
end;

%save('BINH1', 'true_pareto','true_pareto_x');