function VINNET2()
%first objective for  Binh(3) 226 (pdf) (Veldhuizen)
x1=[-6:0.2:6];
x2=[-6:0.2:6];

pareto=[];
xvalues=[];
for i=1:size(x1,2);
    for j=1:size(x2,2);       
        x=[x1(i),x2(j)];
        %in=inqualityTappeta(x);
        if (x(1)>=-4)&&(x(2)<=4);
            f1=vinnet2_1(x);
            f2=vinnet2_2(x);
            f3=vinnet2_3(x);
            pareto(end+1,:)=[f1 f2 f3];
            xvalues(end+1,:)=x;
            plot3(f1,f2,f3);
            drawnow();
            hold on;
        end;
        
    end;
end;
xlabel('f_1(x)');
ylabel('f_2(x)');
zlabel('f_3(x)');

title('Rendon`s function');
drawnow;

true_pareto=[];
true_pareto_x=[];
for i=1:size(pareto,1);
    if dominance1(i,pareto)==0;
        true_pareto(end+1,:)=pareto(i,:);
        true_pareto_x(end+1,:)=xvalues(i,:);
        plot3(true_pareto(end,1),true_pareto(end,2),true_pareto(end,3),'-*r');
        drawnow();
    end;
end;

save('VINNET2', 'true_pareto','true_pareto_x');