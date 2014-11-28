function eval_metrics(subexpid)
conn = database('afrodita','postgres','postgres', 'org.postgresql.Driver', 'jdbc:postgresql://localhost:5432/afrodita');
if size(conn.Message,2)>0;
    error('No connection with database Afrodita',conn.Message);
    return;
end;

sql=['select me_id, uzdevums, kriteriju_sk, f1, f2, f3 from real_dm_values_full5 where subexpid=',num2str(subexpid)];
a=exec(conn,sql);
a=fetch(a);
metrics=[];
if strcmp(a.Data,'No Data')==1;
   return;
end;
for i=1:size(a.Data,1);
        yvals=[];
        for j=1:a.Data{i,3};
            yvals(j)=a.Data{i,3+j};
        end;
        opt.metrics.objvals=yvals;
        opt=problem_init(a.Data{i,2},opt);
        metrics.gendist(i)=generaldist(opt);
        if metrics.gendist(i)<1E-37;
            metrics.gendist(i)=1E-37;
        end;
        
        metrics.spacing(i)=spacing(opt);
        if metrics.spacing(i)<1E-37;
            metrics.spacing(i)=1E-37;
        end;
                
        metrics.mparetoer(i)=max_pareto_err(opt); 
        if metrics.mparetoer(i)<1E-37;
            metrics.mparetoer(i)=1E-37;
        end;
        
        metrics.conver(i)=progress_measure(opt,metrics.gendist(1),metrics.gendist(i)); 
         if metrics.conver(i)<1E-37;
            metrics.conver(i)=1E-37;
        end;
        
        metrics.stdgd(i)=stdgd(opt);
         if metrics.stdgd(i)<1E-37;
            metrics.stdgd(i)=1E-37;
        end;
        
        sql2=sprintf('update metrikas set gd=%g, sp=%g, mpe=%g, mp=%g, stgd=%g where me_id=%d',metrics.gendist(i),metrics.spacing(i),metrics.mparetoer(i),metrics.conver(i),metrics.stdgd(i),a.Data{i,1});
        b=exec(conn,sql2);
        if size(b.Message,2)>0;
            error(['Bad sql:',sql2, 'and ',b.Message]);
        end;
        close(b);
end;
close(a);
close(conn);
