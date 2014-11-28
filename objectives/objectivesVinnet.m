function y=objectivesVinnet(x,x0,w)


%for vinner function
y=sum(((-w(1).*[2*x(1); 2*(x(2)-1)])...
    + (-w(2).*[2*x(1); 2*(x(2)+1)])...
    + (-w(3).*[2*(x(1)-1); 2*x(2)]))'.*x);
y=y*-1;