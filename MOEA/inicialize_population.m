function options=inicialize_population(options)
%function inicialize population in random way
if strcmp(options.type,'binary-coded');
    gen='';
    for j=1:options.popsize;
        for i=1:options.gen_length;
            if strcmp(options.class,'stohastic'); %for stohastiv class
                bit=num2str(round(rand(1,1)));
                gen=strcat(gen,bit);    
            else %for deterministic class
                if i==1;
                    bit='0';
                    gen=bit;
                else
                    if strcmp(bit,'0');
                        bit='1';
                    else
                        bit='0';
                    end;
                    gen=strcat(gen,bit);
                end;
            end;
        end;
        options.population{j}=gen;
        gen='';
    end;
else %for real-coded MOGA
    for j=1:options.popsize;
        gen=[];
        for i=1:options.varcount;
            gen(i)=rand(1,1);
        end;
        options.population{j}=gen;
    end;
end;
end