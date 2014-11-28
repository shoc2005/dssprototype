function opt=select_solution_ga(xvals,fvals,opt)


if size(fvals,1)~=0;
    %index=solutions_to_copy(list(1));
    [index,cres]=find(fvals(:,2)==0);
    %[v,index]=min(fvals(:,2));
end;

val=inf;
n=0;

for i=1:size(index,1);
    if fvals(index(i))<val;
        val=fvals(index(i));
        n=index(i);
    end;
end;    
    if n>0
        opt.bestsolution=xvals(n,:);
        dist=fvals(n,1);
        set(findobj('Tag','dist_g'),'String',num2str(dist,2));
    end;
    
end
    