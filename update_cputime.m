function res=update_cputime(conn, seconds, sexpid, stop_iem, share)
%function saves a subexperiment cpu_time
sql=sprintf('update ap_eksperiments set cpu_laiks=%g, stop_iem=%d, share_vertiba=%g where apeks_id=%d',seconds,stop_iem, share, sexpid);

a=exec(conn, sql);

if size(a.Message,2)==0;
    res=1;
else
    res=0;
end;

end