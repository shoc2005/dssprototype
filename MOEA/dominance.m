function dom_count=dominance(sol_index, options)
%function calculate dominated solutions by solution of index: sol_index;
dom_count=1;
y=options.objvals(sol_index,1:options.objcount);
parfor i=1:size(options.objvals,1);
    s=0;
    f=0;
    if i~=sol_index;
        for j=1:options.objcount;
            if (y(j)>=options.objvals(i,j));
                f=f+1;
            end;

            if (y(j)>options.objvals(i,j));
                s=s+1;
            end;
          end;
    end;

    if (f==options.objcount)&&(s>0);
        dom_count=dom_count+1;
    end;
end;


end

  
            
        
