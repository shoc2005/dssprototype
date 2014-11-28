function result=waves(options)
%function calculate the Max Rank Pareto for PPF, measure function
result=max(options.ranks);

if isnan(result)||isinf(result);
     result=-1;
end;
end