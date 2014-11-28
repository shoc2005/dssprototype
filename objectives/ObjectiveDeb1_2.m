function result=ObjectiveDeb1_2(x)
%deb non-convex function (198 pp)
g=1;

if (x(2)>=0) && (x(2)<=0.4);
    g=4-3*exp(-((x(2)-0.2)/0.02)^2);
elseif (x(2)>0.4)&& (x(2)<=1);
    g=4-3*exp(-((x(2)-0.7)/0.2)^2);
end;



B=1;
A=0.25+3.75*(g-1)
f=objectiveDeb1_1(x);
if f<=B*g;
    h=1-(f/(B*g))^A;
else
    h=0;
end;
    
result=h*g;

if ~isreal(result);
    result=0;
end;

