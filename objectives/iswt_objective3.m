function y=iswt_objective3(arg,opt)

fnum=arg(1);
ub=arg(2:end);

[x1,y]=iswt_inicialize(opt.x0,fnum,ub,opt.problem);

switch upper(opt.problem)
    case 'HANNE'
        T1=load('T1_true.mat'); %load variable pareto with truePareto solutions
        options.truePareto=T1.T1;
        
    case  'HANNE1'     
        wv=load ('HANNE1.mat'); %load variable pareto with truePareto solutions
        options.truePareto=wv.true_pareto;
        
    case 'DEB1'
        wv=load ('DEB1.mat'); %load variable pareto with truePareto solutions
        options.truePareto=wv.true_pareto;
        
    case 'BINH1'
        wv=load('BINH1.mat'); %load variable pareto with truePareto solutions
        options.truePareto=wv.true_pareto;
        
    case 'FONSECA1'
        wv=load('FONS1.mat'); %load variable pareto with truePareto solutions
        options.truePareto=wv.true_pareto;
        
    case 'FONSECA2'
        wv=load('FONS2.mat'); %load variable pareto with truePareto solutions
        options.truePareto=wv.true_pareto;
        
    case 'KURSAWE'
        wv=load('KURSAWE.mat'); %load variable pareto with truePareto solutions
        options.truePareto=wv.true_pareto;
        
end;

options.metrics.objvals=y;
y=generaldist(options);
