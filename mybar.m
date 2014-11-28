function handle=mybar(objvals, taillen, type);

if nargin==2;
    type=1;
end;

ss=size(objvals,1);

if ss>taillen+1;
    objvals=objvals(end-taillen+1:end,:);
    xx=(ss-taillen:1:ss-1);
else
    taillen=size(objvals,1);
    objvals=objvals(end-taillen+1:end,:);
    xx=(0:1:ss-1);
end;

maxval=max(max(objvals));
minval=min(min(objvals));
objcount=size(objvals,2);

if type==1;
    tt='group';
    handle=barh(xx,objvals,tt);
    
else
    tt='stack';
    handle=bar(xx,objvals,tt);
end;




leg={};
for i=1:objcount;
   leg{i}=sprintf('f_%d(x)',i);
end;

legend(handle,leg);
xlabel('iteration');

colormap copper;
%len=maxval+maxval*0.4;
%axis([-len len -len len]);
hold off;