function result=satisfaction(sol,goal)
%function calculate LPP satisfaction for obtined solution by calculating
%Euclidian distance
for j=1:size(sol,1);

m=[];
for i=1:size(sol,2);
    m(i)=(goal(i)-sol(j,i))^2;
end;

result(j)=sqrt(sum(m));
end;