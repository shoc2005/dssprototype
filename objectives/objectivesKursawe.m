function y=objectivesKursawe(x,x0,w)
%test funtion Kursawe [189], pp.226, Veldhuizen for two variables

y=sum(( (-w(1).*[(2.0*x0(1))/(exp(0.2*(x0(1)^2 + x0(2)^2)^(1/2))*(x0(1)^2 + x0(2)^2)^(1/2));(2.0*x0(2))/(exp(0.2*(x0(1)^2 + x0(2)^2)^(1/2))*(x0(1)^2 + x0(2)^2)^(1/2))])...
    + (-w(2).*[((0.8*sign(x0(1)))/abs(x0(1))^0.2 - 15*cos(x0(1))*(cos(x0(1))^2 - 1));(0.8*sign(x0(2)))/abs(x0(2))^0.2 - 15*cos(x0(2))*(cos(x0(2))^2 - 1)]))'.*x);
y=y*-1;
