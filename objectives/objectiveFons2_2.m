function result=objectiveFons2_2(x)
%Fonseca function from Fonseca [111] pp.226

r=0;
n=size(x,2);
for i=1:n;
    r=r+(x(i)+sqrt(n))^2;
end;
result=1-exp(-r);

end