function dom_count=dominance1(sol_index, set)
%function calculate dominated solutions by solution of index: sol_index;
dom_count=0;
y=set(sol_index,:);
parfor i=1:size(set,1);
    s=0;
    f=0;
    if i~=sol_index;
        for j=1:size(set,2);
            if (y(j)>=set(i,j));
                f=f+1;
            end;

            if (y(j)>set(i,j));
                s=s+1;
            end;
          end;
    end;

    if (f==size(set,2))&&(s>0);
        dom_count=dom_count+1;
    end;
end;