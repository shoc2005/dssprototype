function result=stdgd(options)
%function calculate Standart Deviation from General Distance) measure

m=[];
tp=options.truePareto;
y0=options.metrics.objvals;

nn=size(y0,1);

for j=1:nn;
   m(j)=(eucdist(y0(j,:),tp)-generaldist(options))^2;
end;

result=sum(m)/nn;



%{
m=find((options.ranks-1)==0);
yvals=[];

l1=size(m,1);
parfor i=1:l1;
    yvals(i,:)=options.objvals(m(i),:);
end;

d=[];
for i=1:l1; %calculate absolute distance eby every point or solution
    for j=1:l1;
        if i==j;
            d(i,j)=inf;
        else
            d(i,j)=sum(abs(yvals(i,:)-yvals(j,:)));
        end;
    end;
end;

dm=[];
for i=1:l1; %get minimal distances from point i to others j
    dm(i)=min(d(i,:));
end;

s=0;
for i=1:l1;
    s=s+(dm(i)-generaldist(options))^2;
end;

result=s/l1;

%}
if isnan(result)||isinf(result);
     result=-1;
end;