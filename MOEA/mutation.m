function options=mutation(options)
%function realize the bit-wise mutation operator for binary-codes and
%random for real-coded MOGA
if options.m_propability==0;
    return;
end;

new_population={};
for i=1:options.popsize;
   
    pos=1;
    a=true;
    gen=options.population{i};
    if strcmp(options.type,'binary-coded'); %for binary-coded MOGA
        change=find(rand(1,length(gen)) < options.m_propability);
        for ii=1:size(change,2);
            %ra=rand(1,1);
            %if ra<=options.m_propability;
                if strcmp(gen(change(ii)),'1');
                    gen(change(ii))='0';
                else
                    gen(change(ii))='1';
                end;
            %end;
        end;
        
    else %for real-coded MOGA
        parfor i=1:options.varcount;
            r=rand(1,1);
            b=0.1;
            r1=random('beta',1,1);
            if r1>0.5;
                feta=1;
            else
                feta=-1;
            end;
            gen(1,i)=gen(1,i)+feta*(options.varmasks{i}.upper-options.varmasks{i}.lower)*(1-r^(1-options.gen/options.gencount)^b);
        end;
    end; 
         new_population{end+1}=gen;
end;

options.population=new_population;

end
    
