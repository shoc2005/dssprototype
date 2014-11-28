function y=objectivesBinh2(x,x0,w)


%for Binh2 function
y=sum(((-w(1).*[1;0])+ (-w(2)*[0;1])+(-w(3).*[x0(2);x0(1)]))'.*x);
y=y*-1;
