function FONS1()
%first objective for  Binh(3) 226 (pdf) (Veldhuizen)
x1=[0:0.01:1];
x2=[0:0.01:1];

pareto=[];
xvalues=[];
for i=1:size(x1,2);
    for j=1:size(x2,2);
        x=[x1(i),x2(j)];
        f1=objectiveFons1_1(x);
        f2=objectiveFons1_2(x);
        
        pareto(end+1,:)=[f1 f2];
        xvalues(end+1,:)=x;
        plot(f1,f2);
        hold on;
    end;
end;
xlabel('f_1(x)');
ylabel('f_2(x)');


title('Fonseca1 connected and concave function');
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

save('FONS1', 'true_pareto','true_pareto_x');