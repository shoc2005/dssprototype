function y=objectives(x,x0,w)


%fun={'sqrt(x1)', 'sqrt(x2)'};
%x_var={'x1','x2'};

%for HANN function
y=sum(((-w(1)*[(1/(2*x0(1)^(1/2)))*x0(1)*x(1);0])  + (-w(2)*[0;(1/(2*x0(2)^(1/2)))*x0(2)*x(2)]))'.*x);
y=y*-1;

%y=sum(sum(.*x)*w(1)+sum([0,(1/(2*x0(2)^(1/2)))*x0(2)*x(2)].*x)*w(1))*-1;

%y=sum((sum([(1/(2*x0(1)^(1/2)))*x0(1)*x(1),0])*w(1)+sum([0,(1/(2*x0(2)^(1/2)))*x0(2)*x(2)])*w(2)).*x);

%{
for j=1:size(fun,2);
    m={};
    for i=1:size(x_var,2);
        m{i}=diff(fun{j},x_var{i});
    end;
    x1=(point(1));%
    x2=(point(2));%;
    
    for i=1:size(x_var,2);
        m1(i)=eval(m{i});
    end;
    m1=(m1*w(j)).*delta;
        
    y=y+m1;

end;
%
%syms x1 x2;
y=sum(y);
y=y*-1;
%y=eval(y);
%}

end    