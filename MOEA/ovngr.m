function result=ovngr(options)
%function measure non-dominated solution count in population this metric
%name is Overall Nondominated Vector Generation amd Ratio

m=find((options.ranks-1)==0);
result=size(m,1)/size(options.truePareto,1);
if isnan(result)||isinf(result);
     result=-1;
end;

end