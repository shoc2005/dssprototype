function [x,z,exitflag]=stem_inicialize(x0,prev_vals,satFuns,unsatFuns,econs,problem,iter, ideal) 
%satFuns is vector of indexes (for example [1,3]) for objectives in I>
%unsatFuns is vector of indexes for objectives in I< 
%e-constraints defined for I>

algol=get(findobj('Tag','lowmeth'),'String');
algol=algol{get(findobj('Tag','lowmeth'),'Value'),:};
maxiter_count=get(findobj('Tag','maxiter'),'String');
eawork=get(findobj('Tag','enableEA'),'UserData');
if isempty(maxiter_count);
    maxiter_count=1500;
else 
   maxiter_count=str2num(maxiter_count);
end;

s1=satFuns>0;
tmp=[];
for i=1:size(s1,2);
    if s1(i)>0
        tmp(end+1)=satFuns(i);
    end;
end;
satFuns=tmp;

s1=unsatFuns>0;
tmp=[];
for i=1:size(s1,2);
    if s1(i)>0
        tmp(end+1)=unsatFuns(i);
    end;
end;
unsatFuns=tmp;

opt=optimset('Algorithm',algol,'MaxIter',maxiter_count,'MaxFunEvals',maxiter_count,'Diagnostic','On' );
%opt=optimset('Algorithm','interior-point','MaxIter',1500,'MaxFunEvals',1500,'Diagnostic','On' );
%opt.UseParallel='always';
problem=upper(problem);
switch problem
    case 'HANNE'
        T1=load('T1_true.mat');
        tol=mean(std(T1.T1))/(1e+5);
        opt.TolFun=tol;
        opt.TolCon=tol;
        nadir=[max(T1.T1(:,1)),max(T1.T1(:,2))];
        %ideal=get_ideal(T1.T1,2);
        funs={@objectiveT1_1,@objectiveT1_2};
        w=eval_weights(nadir, ideal);
        [x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,[-1 -1],[-5],[],[],[0.0 0.0],[7 7],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);
        exitflag
        output
       
    case  'HANNE1'
        wv=load('HANNE1.mat');
        tol=mean(std(wv.true_pareto))/(1e+5);
        opt.TolFun=tol;
        opt.TolCon=tol;
        nadir=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        %ideal=get_ideal(wv.true_pareto,2);
        w=eval_weights(nadir, ideal);
        funs={@objectiveH1_1,@objectiveH1_2};
        [x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,[],[],[],[],[0.001 0.001],[12 12],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);
        exitflag
        output
        %[x1,y]=fmincon(@(x)objectivesH1(x,x0,w),x0,[],[],[],[],[0.001 0.001],[12 12],@condH1,opt);
    
    case 'DEB1'
        wv=load('DEB1.mat');
        tol=mean(std(wv.true_pareto))/(1e+5);
        opt.TolFun=tol;
        opt.TolCon=tol;
        nadir=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        %ideal=get_ideal(wv.true_pareto,2);
        w=eval_weights(nadir, ideal);
        funs={@objectiveDeb1_1,@objectiveDeb1_2};
        [x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,[],[],[],[],[0 0],[1 1],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);
        exitflag
        output
        
%        [x,y]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[0 0],[1 1],@(x)conn(x,problem,lb,ub,funs),opt);                               
    case 'BINH1'
        wv=load('BINH1.mat');
        tol=mean(std(wv.true_pareto))/(1e+5);
        opt.TolFun=tol;
        opt.TolCon=tol;
        opt.TolFun=0.0000001;
        opt.TolCon=0.0000001;
        nadir=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        %ideal=get_ideal(wv.true_pareto,2);
        %ideal=[] ;%get_ideal(wv.true_pareto,2);
        
        w=eval_weights(nadir, ideal);
        
        funs={@objectiveBinh1_1,@objectiveBinh1_2};
        %[x,y]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[0 0],[200 200],@(x)conn(x,problem,lb,ub,funs),opt);                               
        %[x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,[1 0; 0 1 ],[5; 10],[],[],[-5 -5],[10 10],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);
        
        [x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,[-1 0; 0 1 ],[5; 10],[],[],[],[],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);
        %[x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,);%,[],[],[-5 -5],[10 10],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);
        
        exitflag
        output
        
    case 'BINH2'
        wv=load('BINH2.mat');
        tol=mean(std(wv.true_pareto))/(1e+5);
        opt.TolFun=tol;
        opt.TolCon=tol;
        nadir=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2)),max(wv.true_pareto(:,3))];    
        %ideal=get_ideal(wv.true_pareto,3);
        w=eval_weights(nadir, ideal);       
        funs={@objectiveBinh2_1,@objectiveBinh2_2,@objectiveBinh2_3};
        %[x,y]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[10^-6 10^-6],[10^6 10^6],@(x)conn(x,problem,lb,ub,funs),opt);                               
        [x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,[],[],[],[],[10^-6 10^-6],[10^6 10^6],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);
        exitflag
        output
        
        %[x1,y]=fmincon(@(x)objectivesBinh2(x,x0,w),x0,[],[],[],[],[10^-6 10^-6],[10^6 10^6],[],opt); 
    
    case 'FONSECA1'
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        %[x1,y]=FMINUNC(@(x)objectivesFons1(x,x0,w),x0,opt);
        wv=load('FONS1.mat');
        tol=mean(std(wv.true_pareto))/(1e+5);
        opt.TolFun=tol;
        opt.TolCon=tol;
        nadir=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        %ideal=get_ideal(wv.true_pareto,2);
        w=eval_weights(nadir, ideal);           
        funs={@objectiveFons1_1,@objectiveFons1_2};
        [x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,[],[],[],[],[0 0],[1 1],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);               
        exitflag
        output
        %[x,y]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[0 0],[1 1],@(x)conn(x,problem,lb,ub,funs),opt);                                             
        %[x1,y]=fmincon(@(x)objectivesFons1(x,x0,w),x0,[],[],[],[],[0 0],[1 1],[],opt); 
        
    case 'FONSECA2'
        wv=load('FONS2.mat');
        tol=mean(std(wv.true_pareto))/(1e+5);
        opt.TolFun=tol;
        opt.TolCon=tol;
        nadir=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        %ideal=get_ideal(wv.true_pareto,2);
        w=eval_weights(nadir, ideal);           
        funs={@objectiveFons2_1,@objectiveFons2_2};
        [x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,[],[],[],[],[-4 -4 -4],[4 4 4],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);               
        exitflag
        output
        %[x,y]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[-4 -4 -4],[4 4 4],@(x)conn(x,problem,lb,ub,funs),opt);                               
        %[x1,y]=fmincon(@(x)objectivesFons2(x,x0,w),x0,[],[],[],[],[-4 -4 -4],[4 4 4],[],opt); 
        
    case 'KURSAWE'
        wv=load('KURSAWE.mat');
        tol=mean(std(wv.true_pareto))/(1e+5);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        nadir=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        %ideal=get_ideal(wv.true_pareto,2);
        w=eval_weights(nadir, ideal);           
        funs={@objectiveKursaw1,@objectiveKursaw2};
        [x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,[],[],[],[],[-2 -2],[1 1],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);               
        exitflag
        output
        %[x,y]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[-2 -2],[1 1],@(x)conn(x,problem,lb,ub,funs),opt);                                       
        %[x1,y]=fmincon(@(x)objectivesKursawe(x,x0,w),x0,[],[],[],[],[-2 -2],[1 1],[],opt);
        
    case 'TAPPETA'
        wv=load('TAPPETA.mat');
        tol=mean(std(wv.true_pareto))/(1e+5);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        nadir=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2)),max(wv.true_pareto(:,3))];    
        %ideal=get_ideal(wv.true_pareto,3);
        w=eval_weights(nadir, ideal);                   
        funs={@tappeta1,@tappeta2,@tappeta3};
        [x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,[],[],[],[],[0 0 0],[inf inf inf],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);                       
        exitflag
        output
        %[x,y]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[0 0 0],[10 10 10],@(x)conn(x,problem,lb,ub,funs),opt);                                       
        %[x1,y]=fmincon(@(x)objectivesTappeta(x,x0,w),x0,[],[],[],[],[0 0 0],[10 10 10],[],opt);
        %[x1,y]=FMINUNC(@(x)objectivesKursawe(x,x0,w),x0,opt);
            
    case 'DOWNING'
        wv=load('DOWNING.mat');
        tol=mean(std(wv.true_pareto))/(1e+5);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        nadir=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2)),max(wv.true_pareto(:,3))];    
        %ideal=get_ideal(wv.true_pareto,3);
        w=eval_weights(nadir, ideal);                          
        funs={@downing1,@downing2,@downing3};
        [x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,[],[],[],[],[0 0 0 0 0],[5 5 5 5 5],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);                       
        exitflag
        output
        %[x,y]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[],[],[],[],[0 0 0 0 0],[5 5 5 5 5],@(x)conn(x,problem,lb,ub,funs),opt);                                     
        %[x1,y]=fmincon(@(x)objectivesDowning(x,x0,w),x0,[],[],[],[],[0 0 0 0 0],[5 5 5 5 5],[],opt);
        
    case 'VINNET'
        wv=load('VINNET.mat');
        tol=mean(std(wv.true_pareto))/(1e+5);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        nadir=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2)),max(wv.true_pareto(:,3))];    
        %ideal=get_ideal(wv.true_pareto,3);
        w=eval_weights(nadir, ideal);                          
        funs={@vinnet1,@vinnet2,@vinnet3};
        [x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,[],[],[],[],[-4 -6],[6 4],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);                           
        exitflag
        output
        %[x,y]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[-1 0;0 1],[2;2],[],[],[-6 -6],[6 6],@(x)conn(x,problem,lb,ub,funs),opt);                                      
        %[x1,y]=fmincon(@(x)objectivesVinnet(x,x0,w),x0,[-1 0;0 1],[2;2],[],[],[-6 -6],[6 6],[],opt);
        
    case 'VINNET2'
        wv=load('VINNET2.mat');
        tol=mean(std(wv.true_pareto))/(1e+5);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        
        nadir=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2)),max(wv.true_pareto(:,3))];    
        %ideal=get_ideal(wv.true_pareto,3);
        w=eval_weights(nadir, ideal);                          
        
        funs={@vinnet2_1,@vinnet2_2,@vinnet2_3};
        [x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,[-1 0;0 1],[4;4],[],[],[-6 -6],[6 6],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);                           
        exitflag
        output
        %[x,y]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[-1 0;0 1],[4;4],[],[],[-6 -6],[6 6],@(x)conn(x,problem,lb,ub,funs),opt);                               
        
        %[x1,y]=fmincon(@(x)objectivesVinnet2(x,x0,w),x0,[-1 0;0 1],[4;4],[],[],[-6 -6],[6 6],[],opt);
        
    case 'RENDON'
        wv=load('RENDON.mat');
        tol=mean(std(wv.true_pareto))/(1e+5);
        opt.TolFun=tol;
        opt.TolCon=tol;
        nadir=[max(wv.true_pareto(:,1)),max(wv.true_pareto(:,2))];    
        %ideal=get_ideal(wv.true_pareto,2);
        w=eval_weights(nadir, ideal);                          
        
        funs={@rendon1,@rendon2};
        [x,y,exitflag,output]=fmincon(@(x)stem_problem(x,w,ideal,funs),x0,[],[],[],[],[-3 -6],[6 3],@(x)conn_stem(x,x0,prev_vals,satFuns,unsatFuns,econs,funs,problem,iter),opt);                           
         exitflag
        output
        %[x,y]=fmincon(@(x)guess_problem(x,znad,zref,funs),x0,[-1 0;0 1],[3; 3],[],[],[-6 -6],[6 6],@(x)conn(x,problem,lb,ub,funs),opt);                               
        
        
        %[x1,y]=fmincon(@(x)objectivesRendon(x,x0,w),x0,[-1 0;0 1],[3; 3],[],[],[-6 -6],[6 6],@condH1,opt);
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

ea=get(findobj(gcf,'Tag','enableEA'),'UserData');
if not(ea==1);
    
    set(findobj(gcf,'Tag','algol'),'String',output.algorithm);
    set(findobj(gcf,'Tag','smaliter'),'String',num2str(output.iterations));
    set(findobj(gcf,'Tag','evalcount'),'String',num2str(output.funcCount));
    set(findobj(gcf,'Tag','stopr'),'String',num2str(exitflag));
    set(findobj(gcf,'Tag','methmess'),'String',num2str(output.message));
end;

%where z is a new value of cuntion

end

function w=eval_weights(nadir, ideal)
%weights
nadir=nadir+0.1E-23;
ideal=ideal-0.1E-23;
e=[];
for i=1:size(nadir,2);
    e(i)=(1/ideal(i))*((nadir(i)-ideal(i))/nadir(i));
end;

w=[];
for i=1:size(nadir,2);
    w(i)=e(i)/sum(e);
end;

end

function ideal=get_ideal(array,dim)
array=sort(array);
ideal=[];
for i=1:dim;
    s=0;
    j=1;
    while s==0;
        if array(j,dim)~=0;
            ideal(i)=array(j,dim);
            s=1;
        else
            j=j+1;
        end;
    end;
end;

end
