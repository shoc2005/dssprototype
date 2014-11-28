function RENDON()
%first objective for  Binh(3) 226 (pdf) (Veldhuizen)
x1=[-6:0.2:6];
x2=[-6:0.2:6];

pareto=[];
xvalues=[];
for i=1:size(x1,2);
    for j=1:size(x2,2);       
        x=[x1(i),x2(j)];
        %in=inqualityTappeta(x);
        if (x(1)>=-3)&&(x(2)<=3);
            f1=rendon1(x);
            f2=rendon2(x);
            
            pareto(end+1,:)=[f1 f2];
            xvalues(end+1,:)=x;
            plot(f1,f2);
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
        plot(true_pareto(end,1),true_pareto(end,2),'-*r');
        drawnow();
    end;
end;

save('RENDON', 'true_pareto','true_pareto_x');