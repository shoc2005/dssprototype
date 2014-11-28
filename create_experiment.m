function handle=create_experiment(conn, name, vards, kods)
%function create the main eksperiment and retur eksperiment ID in DB
if nargin==2;
    vards='';
    kods='';
elseif nargin==3;
    kods='';
end;

sql=sprintf('insert into eksperiments(nosaukums,vards_uzvards,kods) values (''%s'',''%s'',''%s'')',name,vards,kods);
a=exec(conn,sql);

a=exec(conn,'select max(eks_id) from eksperiments');
a=fetch(a);
handle=a.Data{(1)};
close(a);

end


