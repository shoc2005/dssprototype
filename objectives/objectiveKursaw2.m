function result=objectiveKursaw2(x)
%Fonseca function from Fonseca [111] pp.226

n=size(x,2);
s=0;
for i=1:n;
    s=s+((abs(x(i))^0.8)+5*(sin(x(i)))^3);
end;
result=s;

end