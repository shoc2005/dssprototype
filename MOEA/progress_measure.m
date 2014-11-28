function result=progress_measure(options, g0, g)
%function measure the progress of optimization Progress neasure for single
%and multi-objective problem this function need to run after general
%distance function run


if (isnan(g0))||(isnan(g));
    result=0;
else
    result=log(sqrt(g0/g));
end;

if isnan(result)||isinf(result);
     result=-1;
end;
    
end