function y=marginal(x,step,num)
% new marginal 18.03.2010.
y=[objectiveBinh1_1(x+step) objectiveBinh1_2(x+step)]-[objectiveBinh1_1(x) objectiveBinh1_2(x)];
m(1)=(y(1)/y(2));
m(2)=(y(2)/y(1));
m(num)=1;

y=[m num];
