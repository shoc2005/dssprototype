function [x,z]=goalatt_inicialize(x0,w,goal,problem) 

%nonconvex Hanne function
opt=optimset('fgoalattain');
%opt.TolFun=0.01;
%opt.TolCon=0.01;
%opt.MaxIter=50;
opt.UseParallel='always';
problem=upper(problem);
switch problem
    case 'HANNE'
        T1=load('T1_true.mat');
        tol=mean(std(T1.T1))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %if tol>opt.Tol;
        %    beep;
        %end;
        [x,y] = fgoalattain(@hanne_goal,x0,goal,w, [],[],[],[],[0.001 0.001],[7 7],[],opt);
        
    
    case  'HANNE1'
        wv=load('HANNE1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        tol
        opt.TolFun=tol;
        opt.TolCon=tol;
        [x,y]=fgoalattain(@hanne1_goal,x0,goal,w,[],[],[],[],[0.001 0.001],[12 12],@condH1,opt);
    
    case 'DEB1'
        wv=load('DEB1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        [x,y]=fgoalattain(@deb1_goal,x0,goal,w,[],[],[],[],[0 0],[1 1],[],opt);    
        
    case 'BINH1'
        wv=load('BINH1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x,y]=fgoalattain(@binh1_goal,x0,goal,w,[],[],[],[],[0 0],[200 200],[],opt);    
    
    case 'BINH2'
        wv=load('BINH2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x,y]=fgoalattain(@binh2_goal,x0,goal,w,[],[],[],[],[10^-6 10^-6],[10^6 10^6],[],opt); 
    
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
        
        [x,y]=fgoalattain(@fons1_goal,x0,goal,w,[],[],[],[],[0 0],[1 1],[],opt); 
        
    case 'FONSECA2'
        wv=load('FONS2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x,y]=fgoalattain(@fons2_goal,x0,goal,w,[],[],[],[],[-4 -4 -4],[4 4 4],[],opt); 
        
    case 'KURSAWE'
        wv=load('KURSAWE.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        [x,y]=fgoalattain(@kursw_goal,x0,goal,w,[],[],[],[],[-2 -2],[1 1],[],opt);
        
    case 'TAPPETA'
        wv=load('TAPPETA.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        [x,y]=fgoalattain(@tappeta_goal,x0,goal,w,[],[],[],[],[0 0 0],[10 10 10],[],opt);
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
        [x,y]=fgoalattain(@downing_goal,x0,goal,w,[],[],[],[],[0 0 0 0 0],[5 5 5 5 5],[],opt);
        
    case 'VINNET'
        wv=load('VINNET.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        [x,y]=fgoalattain(@vinnet_goal,x0,goal,w,[-1 0;0 1],[2;2],[],[],[-6 -6],[6 6],[],opt);
        
    case 'VINNET2'
        wv=load('VINNET2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        [x,y]=fgoalattain(@vinnet2_goal,x0,goal,w,[-1 0;0 1],[4;4],[],[],[-6 -6],[6 6],[],opt);
        
    case 'RENDON'
        wv=load('RENDON.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x,y]=fgoalattain(@rendon_goal,x0,goal,w,[-1 0;0 1],[3; 3],[],[],[-6 -6],[6 6],[],opt);
end;


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

