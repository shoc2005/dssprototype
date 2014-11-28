function y=objectivesRendon(x,x0,w)


%for Binh1 function
y=sum(((-w(1).*[-2*x(1)*(x(1)^2+x(2)^2+1)^-1; -2*x(2)*(x(1)^2+x(2)^2+1)^-1])  + (-w(2).*[2*x(1); 6*x(2)]))'.*x);
y=y*-1;
