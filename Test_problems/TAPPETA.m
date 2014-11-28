function TAPPETA()
%first objective for  Binh(3) 226 (pdf) (Veldhuizen)
x1=[0:0.8:10];
x2=[0:0.8:10];
x3=[0:0.8:10];

pareto=[];
xvalues=[];
for i=1:size(x1,2);
    for j=1:size(x2,2);
        for k=1:size(x3,2);
            x=[x1(i),x2(j),x3(k)];
            in=inqualityTappeta(x);
            if in(1)<=0;
                f1=tappeta1(x);
                f2=tappeta2(x);
                f3=tappeta3(x);
                pareto(end+1,:)=[f1 f2 f3];
                xvalues(end+1,:)=x;
                plot3(f1,f2,f3);
                drawnow();
                hold on;
            end;
        end;
    end;
end;
xlabel('f_1(x)');
ylabel('f_2(x)');
zlabel('f_3(x)');

title('Tappeta function');
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

save('TAPPETA', 'true_pareto','true_pareto_x');