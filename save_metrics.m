function res=save_metrics(conn, apeks_id, algol, gd, stgd, er, sp, mp, ovng, ovngr, wa, mpe, satisfaction, iter_num, cpu_time, small_iters, consequence, vri_c);
%function saves the metrics about subexperiment 
if gd<-1E-37;
    gd=-1E-37;
elseif gd>1E+37;
    gd=1E+37;
end;


if stgd<-1E-37;
    stgd=-1E-37;
elseif stgd>1E+37;
    stgd=1E+37;
end;


if sp<-1E-37;
    sp=-1E-37;
elseif gd>1E+37;
    sp=1E+37;
end;


sql=sprintf('insert into metrikas (algoritma_veids, gd, er, sp, mp, ovng, ovngr, wa, apmierinatiba, iter_num, cpu_laiks, mazas_iter, konsekvence, ap_eksperiments, mpe, stgd, vric) values (%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)', algol, gd, er, sp, mp, ovng, ovngr, wa, satisfaction, iter_num, cpu_time, small_iters,consequence,apeks_id, mpe, stgd, vri_c);
a=exec(conn,sql);

if size(a.Message,2)==0;
    res=1;
    
else
    res=0;
    a.Message
    sql
end;
sql
end

