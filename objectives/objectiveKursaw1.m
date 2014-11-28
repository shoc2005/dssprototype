function result=objectiveKursaw1(x)
%Fonseca function from Fonseca [111] pp.226

n=size(x,2);
s=0;
for i=1:n-1;
    s=s-10*exp(-0.2*sqrt(x(i)^2+x(i+1)^2));
end;
result=s;

end