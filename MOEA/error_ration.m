function result=error_ration(options)
%function measure Error Ration for current population MOGA

ranks=(options.ranks-1);
set=find(ranks==0); %result in one column
n=size(set,1); % number of non-dominated solutions


m=[];
e=0;
for i=1:size(options.metrics.objvals,1); %first we need to get all non-dominated solutions from current population
    m=options.metrics.objvals(i,:); 
    if not(is_member(m,options.truePareto));
        e=e+1;
    end;
end;
    
result=e/n;

if isnan(result)||isinf(result);
     result=-1;
end;

end

function res=is_member(elem, set) %is m member of set truePareto
elem_l=size(elem,2);
set_l=size(set,1);
res=false;
for i=1:set_l;
    s=0;
    for z=1:elem_l;
        if elem(z)==set(i,z);
            s=s+1;
        end;
    end;
    if s==elem_l;
        res=true;
    end;
end;

end




