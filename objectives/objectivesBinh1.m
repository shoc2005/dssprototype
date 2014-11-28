function y=objectivesBinh1(x,x0,w)


%for Binh1 function
y=(-w(1).*[2*x0(1);2*x0(2)])  + (-w(2).*[2*x0(1)-10;2*x0(2)-10]);
y=y'.*x;
y=sum(y);
y=y*-1;
