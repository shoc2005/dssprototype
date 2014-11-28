function result=max_pareto_err(options)
%function measure the maximumu pareto using truePareto and current pareto
%vectors measure ME


yvals=[];
mi=[];
for i=1:size(options.metrics.objvals,1);
    yvals=options.metrics.objvals(i,:);
    n=[];
    for j=1:size(options.truePareto,1);
        n(j)=sqrt(sum((yvals-options.truePareto(j,:)).^2));
    end;
    mi(i)=min(n);
end;

result=max(mi);
if isnan(result)||isinf(result);
     result=-1;
end;
end