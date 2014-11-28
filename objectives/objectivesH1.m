function y=objectivesH1(x,x0,w)


%fun={'sqrt(x1)', 'sqrt(x2)'};
%x_var={'x1','x2'};

%for HANN function
y=sum(((-w(1).*[1*x0(1);0])  + (-w(2).*[0;1*x0(2)]))'.*x);
y=y*-1;
