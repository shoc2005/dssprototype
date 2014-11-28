function [x,z,exitflag]=guess_inicialize(x0,zref,lb,ub,problem, ideal)

algol=get(findobj('Tag','lowmeth'),'String');
algol=algol{get(findobj('Tag','lowmeth'),'Value'),:};
maxiter_count=get(findobj('Tag','maxiter'),'String');
eawork=get(findobj('Tag','enableEA'),'UserData');
if eawork==0;
    maxiter_count=1500;
else 
   maxiter_count=str2num(maxiter_count);
end;
opt=optimset('Algorithm',algol,'MaxIter',maxiter_count,'Diagnostic','On','MaxSQPIter',maxiter_count,'MaxRLPIter',maxiter_count,'MaxPCGIter',maxiter_count );
%opt=optimset('fminimax');
opt.UseParallel='always';

switch problem
    case 'HANNE'
        T1=load('T1_true.mat');
        tol=mean(std(T1.T1))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        opt.TolFun=0.0000000000000001;
        opt.TolCon=0.00000000000000001;
        opt.MaxFunEvals=1000;
        znad=[max(T1.T1(:,1)),max(T1.T1(:,2))];
        funs={@objectiveT1_1,@objectiveT1_2};
        [x,y,exitflag,output]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[-1 -1],[-5],[],[],[0.0 0.0],[7 7],@(x)conn(x,problem,lb,ub,funs),opt);
        %x=x*-1;
        
    case  'HANNE1'
        wv=load('HANNE1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        opt.TolFun=0.0000000000000001;
        opt.TolCon=0.00000000000000001;
        
        znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        funs={@objectiveH1_1,@objectiveH1_2};
        [x,y,exitflag,output]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[0.001 0.001],[12 12],@(x)conn(x,problem,lb,ub,funs),opt);
        %x=x*-1;
        %[x1,y]=fmincon(@(x)objectivesH1(x,x0,w),x0,[],[],[],[],[0.001 0.001],[12 12],@condH1,opt);
    
    case 'DEB1'
        wv=load('DEB1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        funs={@objectiveDeb1_1,@objectiveDeb1_2};
        [x,y,exitflag,output]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[0 0],[1 1],@(x)conn(x,problem,lb,ub,funs),opt);                               
    case 'BINH1'
        wv=load('BINH1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        opt.TolFun=0.000000000000001;
        opt.TolCon=0.000000000000001;
        %opt.MaxFunEvals=1000;
        znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        funs={@objectiveBinh1_1,@objectiveBinh1_2};
        %x0(end+1)=1;
        [x,y,exitflag,output]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[-1 0; 0 1],[5; 10],[],[],[-5 -inf],[inf 10],@(x)conn(x,problem,lb,ub,funs,zref,znad ),opt);       
        %x=x*-1;
        %x

        %x=x*-1;
        %[x1,y]=fmincon(@(x)objectivesBinh1(x,x0,w),x0,[],[],[],[],[0 0],[200 200],[],opt);    
    
    case 'BINH2'
        wv=load('BINH2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2)),max(wv.true_pareto(:,3))];    
        funs={@objectiveBinh2_1,@objectiveBinh2_2,@objectiveBinh2_3};
        [x,y,exitflag,output]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[10^-6 10^-6],[10^6 10^6],@(x)conn(x,problem,lb,ub,funs),opt);                               
        %y=y*-1;
        
        %[x1,y]=fmincon(@(x)objectivesBinh2(x,x0,w),x0,[],[],[],[],[10^-6 10^-6],[10^6 10^6],[],opt); 
    
    case 'FONSECA1'
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        %[x1,y]=FMINUNC(@(x)objectivesFons1(x,x0,w),x0,opt);
        wv=load('FONS1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        funs={@objectiveFons1_1,@objectiveFons1_2};
        [x,y,exitflag,output]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[0 0],[1 1],@(x)conn(x,problem,lb,ub,funs),opt);                               
        
        
        %[x1,y]=fmincon(@(x)objectivesFons1(x,x0,w),x0,[],[],[],[],[0 0],[1 1],[],opt); 
        
    case 'FONSECA2'
        wv=load('FONS2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        funs={@objectiveFons2_1,@objectiveFons2_2};
        [x,y,exitflag,output]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[-4 -4 -4],[4 4 4],@(x)conn(x,problem,lb,ub,funs),opt);                               
        
        
        %[x1,y]=fmincon(@(x)objectivesFons2(x,x0,w),x0,[],[],[],[],[-4 -4 -4],[4 4 4],[],opt); 
        
    case 'KURSAWE'
        wv=load('KURSAWE.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        funs={@objectiveKursaw1,@objectiveKursaw2};
        [x,y,exitflag,output]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[-2 -2],[1 1],@(x)conn(x,problem,lb,ub,funs),opt);                               
        
        %[x1,y]=fmincon(@(x)objectivesKursawe(x,x0,w),x0,[],[],[],[],[-2 -2],[1 1],[],opt);
        
    case 'TAPPETA'
        wv=load('TAPPETA.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2)),max(wv.true_pareto(:,3))];    
        funs={@tappeta1,@tappeta2,@tappeta3};
        [x,y,exitflag,output]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[0 0 0],[10 10 10],@(x)conn(x,problem,lb,ub,funs),opt);                               
        
        %[x1,y]=fmincon(@(x)objectivesTappeta(x,x0,w),x0,[],[],[],[],[0 0 0],[10 10 10],[],opt);
        %[x1,y]=FMINUNC(@(x)objectivesKursawe(x,x0,w),x0,opt);
            
    case 'DOWNING'
        wv=load('DOWNING.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2)),max(wv.true_pareto(:,3))];    
        funs={@downing1,@downing2,@downing3};
        [x,y,exitflag,output]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[0 0 0 0 0],[5 5 5 5 5],@(x)conn(x,problem,lb,ub,funs),opt);                               
        
        %[x1,y]=fmincon(@(x)objectivesDowning(x,x0,w),x0,[],[],[],[],[0 0 0 0 0],[5 5 5 5 5],[],opt);
        
    case 'VINNET'
        wv=load('VINNET.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2)),max(wv.true_pareto(:,3))];    
        funs={@vinnet1,@vinnet2,@vinnet3};
        [x,y,exitflag,output]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[-4 -6],[6 4],@(x)conn(x,problem,lb,ub,funs),opt);                               
        
        %[x1,y]=fmincon(@(x)objectivesVinnet(x,x0,w),x0,[-1 0;0 1],[2;2],[],[],[-6 -6],[6 6],[],opt);
        
    case 'VINNET2'
        wv=load('VINNET2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2)),max(wv.true_pareto(:,3))];    
        funs={@vinnet2_1,@vinnet2_2,@vinnet2_3};
        [x,y,exitflag,output]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[-1 0;0 1],[4;4],[],[],[-6 -6],[6 6],@(x)conn(x,problem,lb,ub,funs),opt);                               
        
        %[x1,y]=fmincon(@(x)objectivesVinnet2(x,x0,w),x0,[-1 0;0 1],[4;4],[],[],[-6 -6],[6 6],[],opt);
        
    case 'RENDON'
        wv=load('RENDON.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        znad=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        funs={@rendon1,@rendon2};
        [x,y,exitflag,output]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[-3 -6],[6 3],@(x)conn(x,problem,lb,ub,funs),opt);                               
        
        
        %[x1,y]=fmincon(@(x)objectivesRendon(x,x0,w),x0,[-1 0;0 1],[3; 3],[],[],[-6 -6],[6 6],@condH1,opt);
end;
set(findobj(gcf,'Tag','algol'),'String',output.algorithm);
set(findobj(gcf,'Tag','smaliter'),'String',num2str(output.iterations));
set(findobj(gcf,'Tag','evalcount'),'String',num2str(output.funcCount));
set(findobj(gcf,'Tag','stopr'),'String',num2str(exitflag));
set(findobj(gcf,'Tag','methmess'),'String',num2str(output.message));

exitflag

output
switch problem
    case 'HANNE'
        x=abs(x);
        z(1)=sqrt(x(1));
        z(2)=sqrt(x(2));
    case  'HANNE1'
        z(1)=objectiveH1_1(x);
        z(2)=objectiveH1_2(x);
         case 'DEB1'
        z(1)=objectiveDeb1_1(x);
        z(2)=objectiveDeb1_2(x);    
        
    case 'BINH1'
        z(1)=objectiveBinh1_1(x);
        z(2)=objectiveBinh1_2(x);    
        
    case 'BINH2'
        z(1)=objectiveBinh2_1(x);
        z(2)=objectiveBinh2_2(x);   
        z(3)=objectiveBinh2_3(x);
    
    case 'FONSECA1'
        z(1)=objectiveFons1_1(x);
        z(2)=objectiveFons1_2(x); 
        
    case 'FONSECA2'
        z(1)=objectiveFons2_1(x);
        z(2)=objectiveFons2_2(x); 
        
    case 'KURSAWE'
        z(1)=objectiveKursaw1(x);
        z(2)=objectiveKursaw2(x); 
        
    case 'TAPPETA'
        z(1)=tappeta1(x);
        z(2)=tappeta2(x);
        z(3)=tappeta3(x);
        
    case 'DOWNING'
        z(1)=downing1(x);
        z(2)=downing2(x);
        z(3)=downing3(x);
        
    case 'VINNET'
        z(1)=vinnet1(x);
        z(2)=vinnet2(x);
        z(3)=vinnet3(x);
        
    case 'VINNET2'
        z(1)=vinnet2_1(x);
        z(2)=vinnet2_2(x);
        z(3)=vinnet2_3(x);
          
    case  'RENDON'
        z(1)=rendon1(x);
        z(2)=rendon2(x);
end;

end