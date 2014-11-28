function options=update_share(options)

%maxx=max(options.objvals);
%minn=min(options.objvals);
%d=maxx-minn;

%options.lambaShare=sum(d)/(options.popsize-1);
x = fzero(@(x) my_roots(x,options.objcount, max(options.objvals),min(options.objvals),options.popsize),0.1);    
if x==NaN;
    x=0.0000001;
end;
options.lambaShare=x;%0.041;
end

function y=my_roots(x,objs,maxx,minn, N)

s=1;
m=1;
for i=1:objs;
    s=s*(maxx(1,i)-minn(1,i)+x);
    m=m*(maxx(1,i)-minn(1,i));
end;
    
y=((s-m)/x^objs)-N;
end
