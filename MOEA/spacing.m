function result=spacing(options)
%function measure the spacing metric. This metric not requre the truePareto
%set.


m=[];
tp=options.truePareto;
y0=options.metrics.objvals;

nn=size(y0,1);

for j=1:nn;
   m(j)=(eucdist(y0(j,:),tp)-generaldist(options))^2;
end;


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
        d(i,j)=sum(abs(yvals(i,:)-yvals(j,:)));
    end;
end;

dm=[];
for i=1:l1; %get minimal distances from point i to others j
    dm(i)=min(d(i,:));
end;

%}       

me=mean(m); %calculate mean value of distances

s=0;
for i=1:nn;
    s=s+(me-m(i))^2;
end;

result=sqrt(s/(nn-1)); % The result is S

if isnan(result)||isinf(result);
     result=-1;
end;

end