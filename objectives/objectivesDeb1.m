function y=objectivesDeb1(x,x0,w)


%fun={'sqrt(x1)', 'sqrt(x2)'};
%x_var={'x1','x2'};

%for HANN function

if objectiveDeb1_1(x0)<(4-3*exp(-((x0(2)-0.7)/0.02)^2));
    df2=-46.0*x(1)^10.5;
else
    df2=0;
end;
    
    
y=sum(((-w(1).*[4;0])  + (-w(2).*[0;df2]))'.*x);
y=y*-1;
