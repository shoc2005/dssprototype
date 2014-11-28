function [x,z,exitflag]=geoff_inicialize(x0,w,problem) 

%nonconvex Hanne function
algol=get(findobj('Tag','lowmeth'),'String');
algol=algol{get(findobj('Tag','lowmeth'),'Value'),:};
maxiter_count=get(findobj('Tag','maxiter'),'String');
eawork=get(findobj('Tag','enableEA'),'UserData');
if eawork==0;
    maxiter_count=1500;
else 
   maxiter_count=str2num(maxiter_count);
end;
opt=optimset('Algorithm',algol,'MaxIter',maxiter_count,'MaxFunEvals',maxiter_count,'Diagnostic','On' );

opt.TolFun=0.01;
opt.TolCon=0.01;
%opt.MaxIter=50;
opt.UseParallel='always';
%opt.GradObj='on';
opt.Diagnostics='on';
nr=round(w(end-1));
w(nr)=1;
step=w(end);
w=w(1:end-2);

switch problem
    case 'HANNE'
        T1=load('T1_true.mat');
        tol=mean(std(T1.T1))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %if tol>opt.Tol;
        %    beep;
        %end;
        
        [x1,y,exitflag,output]=fmincon(@(x)objectives(x,x0,w),x0,[-1 -1],-5,[],[],[0.0 0.0],[inf inf],[],opt);
    
    case  'HANNE1'
        wv=load('HANNE1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y,exitflag,output]=fmincon(@(x)objectivesH1(x,x0,w),x0,[],[],[],[],[0.001 0.001],[12 12],@condH1,opt);
    
    case 'DEB1'
        wv=load('DEB1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y,exitflag,output]=fmincon(@(x)objectivesDeb1(x,x0,w),x0,[],[],[],[],[0 0],[1 1],[],opt);    
        
    case 'BINH1'
        wv=load('BINH1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y,exitflag,output]=fmincon(@(x)objectivesBinh1(x,x0,w),x0,[],[],[],[],[-5.0 -inf],[inf 10.0],[],opt);    
    
    case 'BINH2'
        wv=load('BINH2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y,exitflag,output]=fmincon(@(x)objectivesBinh2(x,x0,w),x0,[],[],[],[],[10^-6 10^-6],[10^6 10^6],[],opt); 
    
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
        
        [x1,y,exitflag,output]=fmincon(@(x)objectivesFons1(x,x0,w),x0,[],[],[],[],[0 0],[1 1],[],opt); 
        
    case 'FONSECA2'
        wv=load('FONS2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y,exitflag,output]=fmincon(@(x)objectivesFons2(x,x0,w),x0,[],[],[],[],[-4 -4 -4],[4 4 4],[],opt); 
        
    case 'KURSAWE'
        wv=load('KURSAWE.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        [x1,y,exitflag,output]=fmincon(@(x)objectivesKursawe(x,x0,w),x0,[],[],[],[],[-2 -2],[1 1],[],opt);
        
    case 'TAPPETA'
        wv=load('TAPPETA.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        [x1,y,exitflag,output]=fmincon(@(x)objectivesTappeta(x,x0,w),x0,[],[],[],[],[0 0 0],[10 10 10],[],opt);
        %[x1,y]=FMINUNC(@(x)objectivesKursawe(x,x0,w),x0,opt);
            
    case 'DOWNING'
        wv=load('DOWNING.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        opt.TolFun=0.0000001;
        opt.TolCon=0.0000001;
        %opt.MaxIter=50;
        [x1,y,exitflag,output]=fmincon(@(x)objectivesDowning(x,x0,w),x0,[],[],[],[],[0 0 0 0 0],[5 5 5 5 5],[],opt);
        
    case 'VINNET'
        wv=load('VINNET.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        [x1,y,exitflag,output]=fmincon(@(x)objectivesVinnet(x,x0,w),x0,[-1 0;0 1],[2;2],[],[],[-6 -6],[6 6],[],opt);
        
    case 'VINNET2'
        wv=load('VINNET2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        [x1,y,exitflag,output]=fmincon(@(x)objectivesVinnet2(x,x0,w),x0,[-1 0;0 1],[4;4],[],[],[-6 -6],[6 6],[],opt);
        
    case 'RENDON'
        wv=load('RENDON.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y,exitflag,output]=fmincon(@(x)objectivesRendon(x,x0,w),x0,[-1 0;0 1],[3; 3],[],[],[-6 -6],[6 6],@condH1,opt);
end;
%where d is direction for serch
%step=0.1;
%where t is step
set(findobj(gcf,'Tag','algol'),'String',output.algorithm);
set(findobj(gcf,'Tag','smaliter'),'String',num2str(output.iterations));
set(findobj(gcf,'Tag','evalcount'),'String',num2str(output.funcCount));
set(findobj(gcf,'Tag','stopr'),'String',num2str(exitflag));

exitflag
output

dir=x1-x0
x1
x0
x=x0+step*dir;


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





%where z is a new value of cuntion


end

