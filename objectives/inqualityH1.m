function y=inqualityH1(x); % all inequalities ...<=0
y(1)=-x(1);
y(2)=-x(2);
y(3)=(x(2)-5+0.5*x(1)*sin(4*x(1)))*-1;

end