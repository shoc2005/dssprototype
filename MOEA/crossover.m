function options=crossover(options)
%function realize single-point crossover operator for binary-coded MOGA
%or function realize Bland crossover (BLX-alfa) for real-coded MOGA

%first we need to choose pairs solutions to crossover
pairs=combnk(1:options.popsize,2);
pairs(:,3)=0;
si=size(pairs,1);
new_population={};
i=0;
%ii=1;
%ij=2;
while size(new_population,2)<=options.popsize;
    if strcmp(options.type,'binary-coded');
        
        if strcmp(options.class,'stohastic');
            i=round(rand(1)*(size(pairs,1)-1))+1;
        else %for deterministic class
            %i=round(set_r(options.class,[ii ij])*(size(pairs,1)-1))+1;
            i=i+1;
            %ij=ij/ii;
        end;
        
        
        if (pairs(i,3)~=1);
            x1=options.population{pairs(i,1)};
            x2=options.population{pairs(i,2)};
            x11=x1(options.crosspoint:end);
            x22=x2(options.crosspoint:end);
            x1(options.crosspoint:end)=x22;
            %x2(options.crosspoint:end)=x11;
            p=true;
            pairs(i,3)=1;
            new_population{end+1}=x1;
        end;
     else %for real-coded MOGA, the solution need to be x1<x2
       while size(new_population,2)<=options.popsize;
           % i
           % size(new_population,2)
           if (pairs(i,3)==0);
                x1=options.population{pairs(i,1)};
                x2=options.population{pairs(i,2)};
                if sum(x1<x2)~=options.varcount;
                   tmp=x1;
                   x1=x2;
                   x2=tmp;
                end;
                if sum(x1<x2)~=options.varcount;
                   pairs(i,3)=2; 
                else
                   p=true;
                   pairs(i,3)=1;
                   u=rand(1,1);
                   y=(1+2*options.alfa)*u-options.alfa;
                   x1=(1-y).*x1+y.*x2;
                   new_population{end+1}=x1;
                end;
            else %need to detect that no other x1<x2 exists in set pairs
                if size(find(pairs(:,3)==0),1)==0;
                    p=true;
                    k=round(rand(1)*(size(pairs,1)-1))+1;
                    x1=options.population{pairs(k,1)};
                    new_population{end+1}=x1;
                    %'stupid!'
                end;
            end;
            if ((i)<=si-1);
                i=i+1;
            end;
        end;
    end;
end;
    

options.population=new_population;

end
