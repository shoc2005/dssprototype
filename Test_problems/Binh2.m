function Binh2()
%first objective for  Binh(3) 226 (pdf) (Veldhuizen)
x1=[10^-6:7000:10^6];
x2=[10^-6:7000:10^6];

pareto=[];
xvalues=[];
for i=1:size(x1,2);
    for j=1:size(x2,2);
        x=[x1(i),x2(j)];
        f1=objectiveBinh2_1(x);
        f2=objectiveBinh2_2(x);
        f3=objectiveBinh2_3(x);
        pareto(end+1,:)=[f1 f2 f3];
        xvalues(end+1,:)=x;
        plot3(f1,f2,f3);
        hold on;
    end;
end;
xlabel('f_1(x)');
ylabel('f_2(x)');
zlabel('f_3(x)');

title('Binh2 convex function');
drawnow;

true_pareto=[];
true_pareto_x=[];
for i=1:size(pareto,1);
    if dominance1(i,pareto)==0;
        true_pareto(end+1,:)=pareto(i,:);
        true_pareto_x(end+1,:)=xvalues(i,:);
        plot3(true_pareto(end,1),true_pareto(end,2),true_pareto(end,3),'-*r');
    end;
end;

save('BINH2', 'true_pareto','true_pareto_x');