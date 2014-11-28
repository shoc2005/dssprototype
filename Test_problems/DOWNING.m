function DOWNING()
%first objective for  Binh(3) 226 (pdf) (Veldhuizen)
x1=[0:1:5];
x2=[0:1:5];
x3=[0:1:5];
x4=[0:1:5];
x5=[0:1:5];

pareto=[];
xvalues=[];
for i=1:size(x1,2);
    for j=1:size(x2,2);
        for k=1:size(x3,2);
            for k1=1:size(x4,2);
                for k2=1:size(x5,2);
                    x=[x1(i),x2(j),x3(k), x4(k1), x5(k2)];
                    in=inqualityDowning(x);
                    if (sum(in<=0)==size(in,2));
                        f1=downing1(x);
                        f2=downing2(x);
                        f3=downing3(x);
                        pareto(end+1,:)=[f1 f2 f3];
                        xvalues(end+1,:)=x;
                        plot3(f1,f2,f3);
                        drawnow();
                        hold on;
                    end;
                end;
            end; 
        end;
    end;
end;
xlabel('f_1(x)');
ylabel('f_2(x)');
zlabel('f_3(x)');

title('Downing`s function');
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

save('DOWNING', 'true_pareto','true_pareto_x');