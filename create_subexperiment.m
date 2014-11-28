function handle=create_subexperiment(conn, eksp_id, opt_problem, ...
                 opt_algorithm, opt_eaalgorithm, number, options)
%function crteate subexperiment in DB using main eksperiment ID;
sql=sprintf('insert into ap_eksperiments(opt_uzdevums, opt_algoritms, opt_ealgoritms, atkartosanas_numurs, mutacijas_varbut, individu_sk, paaudze_sk, share_vertiba, eks_id,lielo_iter_skaits) values (%d, %d, %d, %d, %g, %d, %d, %g, %d, %d)',opt_problem,opt_algorithm, opt_eaalgorithm, number,options.m_propability, options.popsize, options.gencount, options.lambaShare,eksp_id, options.iter_count);
a=exec(conn,sql);

if not(isempty(a.Message));
    a.Message
    options
    eksp_id
    opt_problem
    opt_algorithm
    opt_eaalgorithm
    number
    options
    sql
    error('SQL error');
end;

a=exec(conn,'select max(apeks_id) from ap_eksperiments');
a=fetch(a);
handle=a.Data{(1)};
close(a);

