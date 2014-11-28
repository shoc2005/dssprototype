function HANN1()
%discontonuous function 
%function for for image
x1=[0:0.05:12];
x2=[0:0.05:12];

hold on;
subplot(2,1,1);
xlabel('f_1(x)');
ylabel('f_2(x)');
title('HANNE1 discontinuous (objective value space)');

subplot(2,1,2);
xlabel('x_1');
ylabel('x_2');
title('HANNE1 discontinuous (variable value space)');
pareto=[];
x_pareto=[];
for i=1:size(x1,2);
    for j=1:size(x2,2);
        if x2(j)-5+0.5*x1(i)*sin(4*x1(i))>=0;
            subplot(2,1,1);
            hold on;
            plot(x1(i),x2(j));
            pareto(end+1,:)=[x1(i) x2(j)];
            x_pareto(end+1,:)=[x1(i) x2(j)];
            subplot(2,1,2);
            hold on;
            plot(x1(i),x2(j));
            
        end;
    end;
end;

true_pareto=[];
true_pareto_x=[];
subplot(2,1,1);
for i=1:size(pareto,1);
    if dominance1(i,pareto)==0;
        true_pareto(end+1,:)=pareto(i,:);
        true_pareto_x(end+1,:)=x_pareto(i,:);
        plot(true_pareto(end,1),true_pareto(end,2),'-*r');
    end;
end;

save('HANNE1', 'true_pareto','true_pareto_x');

end

    

