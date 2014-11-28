function opt=problem_init(problem,opt)


switch upper(problem)
    case  'HANNE'
        T1=load('T1_true.mat'); %load variable pareto with truePareto solutions
        opt.truePareto=T1.T1;
        opt.x0=[0.4, 4.6]; %in variable space
        opt.y0=opt.truePareto(7,:);
        opt.goal=opt.truePareto(86,:);
        %tol=mean(std(T1.T1))/(1e+1);
        T1=load('T1_truex.mat');
        opt.trueParetox=T1.T1x;
        opt.goalx=T1.T1x(86,:);
        opt.Tol=0.1;
        opt.problemID=5;
        opt.znad=[max(opt.truePareto(:,1)),max(opt.truePareto(:,2))];
        opt.ideal=[min(opt.truePareto(:,1)),min(opt.truePareto(:,2))];
        
    case  'HANNE1'
        opt.goal=[4.95, 3]; %in objective space
        opt.goalx=opt.goal;
        opt.x0=[9.8, 0.15]; %in variable space
        opt.y0=[9.8, 0.15]; %in objective space
        wv=load ('HANNE1.mat'); %load variable pareto with truePareto solutions
        opt.truePareto=wv.true_pareto;
        opt.trueParetox=wv.true_pareto_x;
        opt.Tol=0.3;
        opt.problemID=6;
        opt.znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        opt.ideal=[min(wv.true_pareto(:,1)),min(wv.true_pareto(:,2))];
    case 'DEB1'
        opt.goal=[0.42, 0.195];
        opt.goalx=[0.105,0.2];
        opt.x0=[0.01,0.2];
        opt.y0=[0.04,0.553]; %in objective space
        wv=load ('DEB1.mat'); %load variable pareto with truePareto solutions
        opt.truePareto=wv.true_pareto;
        opt.trueParetox=wv.true_pareto_x;
        opt.Tol=0.015;
        opt.problemID=17;
        opt.znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))]; 
        opt.ideal=[min(wv.true_pareto(:,1)),min(wv.true_pareto(:,2))];
    case 'BINH1'
        opt.goal=[0.13, 45.13]; %in objective space
        opt.goalx=[0.30,0.2];
        opt.x0=[5, 5]; %in variable space
        opt.y0=[50, 0]; %in objective space
        wv=load('BINH1.mat'); %load variable pareto with truePareto solutions
        opt.truePareto=wv.true_pareto;
        opt.trueParetox=wv.true_pareto_x;
        opt.Tol=0.065;
        opt.problemID=18;
        opt.znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];
        opt.ideal=[min(wv.true_pareto(:,1)),min(wv.true_pareto(:,2))];
    case 'FONSECA1'
        opt.goal=[0.8829,0.8451]; %in objective space
        opt.goalx=[0,0.07];
        opt.x0=[0.990,0]; %in variable space
        opt.y0=[0.632,0.992]; %in objective space
        wv=load('FONS1.mat'); %load variable pareto with truePareto solutions
        opt.truePareto=wv.true_pareto;
        opt.trueParetox=wv.true_pareto_x;
        opt.Tol=0.01;
        opt.problemID=22;
        opt.znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        opt.ideal=[min(wv.true_pareto(:,1)),min(wv.true_pareto(:,2))];
    case 'FONSECA2'
        opt.goal=[0.9997,0.9999]; %in objective space
        opt.goalx=[0.1,0.1,0.05];
        opt.x0=[0.95,0.95,1]; %in variable space
        opt.y0=[0.8278,1]; %in objective space
        wv=load('FONS2.mat'); %load variable pareto with truePareto solutions
        opt.truePareto=wv.true_pareto;
        opt.trueParetox=wv.true_pareto_x;
        opt.Tol=0.1;
        opt.problemID=23;
        opt.znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        opt.ideal=[min(wv.true_pareto(:,1)),min(wv.true_pareto(:,2))];
    case 'KURSAWE'
        opt.goal=[-9.045,0.0998]; %in objective space
        opt.goalx=[0.04,-0.5];
        opt.x0=[-1.040,-1.130]; %in variable space
        opt.y0=[-7.355,-4.771]; %in objective space
        wv=load('KURSAWE.mat'); %load variable pareto with truePareto solutions
        opt.truePareto=wv.true_pareto;
        opt.trueParetox=wv.true_pareto_x;
        opt.Tol=0.3;
        opt.problemID=24;
        opt.znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        opt.ideal=[min(wv.true_pareto(:,1)),min(wv.true_pareto(:,2))];
        
    case 'TAPPETA'
        opt.goal=[-123.185 83.707 -335.740]; %in objective space
        opt.goalx=[5.6,2.4,9.6];
        opt.x0=[0.8 0 6.4]; %in variable space
        opt.y0=[-1.739 -8.734 -44.259]; %in objective space
        wv=load('TAPPETA.mat'); %load variable pareto with truePareto solutions
        opt.truePareto=wv.true_pareto;
        opt.trueParetox=wv.true_pareto_x;
        opt.Tol=0.12;
        opt.problemID=26;
        opt.znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2)),max(wv.true_pareto(:,3))];    
        opt.ideal=[min(wv.true_pareto(:,1)),min(wv.true_pareto(:,2)),min(wv.true_pareto(:,3))];
        
    case 'DOWNING'
        opt.goal=[-118 102 -137]; %in objective space
        opt.goalx=[3,5,5,5,5];
        opt.x0=[0 0 1 0 0]; %in variable space
        opt.y0=[10 2 -7]; %in objective space
        wv=load('DOWNING.mat'); %load variable pareto with truePareto solutions
        opt.truePareto=wv.true_pareto;
        opt.trueParetox=wv.true_pareto_x;
        opt.Tol=0.5;
        opt.problemID=28;
        opt.znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2)),max(wv.true_pareto(:,3))]; 
        opt.ideal=[min(wv.true_pareto(:,1)),min(wv.true_pareto(:,2)),min(wv.true_pareto(:,3))];
        
    case 'VINNET'
        opt.goal=[1.96 1.36 3.16]; %in objective space
        opt.goalx=[0,-0.399];
        opt.x0=[0.8 0.4]; %in variable space
        opt.y0=[1.0 3.6	2.2]; %in objective space
        wv=load('VINNET.mat'); %load variable pareto with truePareto solutions
        opt.truePareto=wv.true_pareto;
        opt.trueParetox=wv.true_pareto_x;
        opt.Tol=0.04;
        opt.problemID=31;
        opt.znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2)),max(wv.true_pareto(:,3))];    
        opt.ideal=[min(wv.true_pareto(:,1)),min(wv.true_pareto(:,2)),min(wv.true_pareto(:,3))];
        
    case 'VINNET2'
        opt.goal=[3.2769,-16.995,-12.8766]; %in objective space
        opt.goalx=[2.4,0.6];
        opt.x0=[2.6 0.6]; %in variable space
        opt.y0=[3.376 -16.998 -12.839]; %in objective space
        wv=load('VINNET2.mat'); %load variable pareto with truePareto solutions
        opt.truePareto=wv.true_pareto;
        opt.trueParetox=wv.true_pareto_x;
        opt.Tol=0.0045;
        opt.problemID=32;
        opt.znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2)),max(wv.true_pareto(:,3))];    
        opt.ideal=[min(wv.true_pareto(:,1)),min(wv.true_pareto(:,2)),min(wv.true_pareto(:,3))];
    case 'RENDON'
        opt.goal=[0.227	4.720]; %in objective space
        opt.goalx=[-1.8,-0.3999];
        opt.x0=[6 1]; %in variable space
        opt.y0=[0.026 40]; %in objective space
        wv=load('RENDON.mat'); %load variable pareto with truePareto solutions
        opt.truePareto=wv.true_pareto;
        opt.trueParetox=wv.true_pareto_x;
        opt.Tol=0.07;
        opt.problemID=33;
        opt.znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        opt.ideal=[min(wv.true_pareto(:,1)),min(wv.true_pareto(:,2))];
end;