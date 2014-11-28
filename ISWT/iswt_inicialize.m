function [x,y,exitflag,output,lambda]=iswt_inicialize(x0,fnum,ub,problem) 
%function to solve MOOP with ISWT method
% arguments are: 
% x0 -inicial x value, mfnum- function number to minimize,
% upbound- upper value bounds of objective function except mfnum objecive
% opt - stucture of optimization necessary information 
%last edited 10.09.2009.

algol=get(findobj(gcf,'Tag','lowmeth'),'String');
algol=algol{get(findobj(gcf,'Tag','lowmeth'),'Value'),:};
opt=optimset('Algorithm',algol,'MaxIter',1500,'MaxFunEvals',1500,'Diagnostic','On' );

opt.TolFun=0.2e+0;
opt.TolCon=0.2e-1;
%opt.Diagnostics='on';
%opt.Dispaly='iter';
%opt.MaxIter=50;
opt.UseParallel='always';
%opt.Algorithm='interior-point';
%opt.Hessian='off';
opt.FunValCheck='on';

switch problem
    case  'HANNE'
        T1=load('T1_true.mat');
        tol=mean(std(T1.T1))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        fhandles={@objectiveT1_1,@objectiveT1_2};
        ineqh=@inqualityT1;
        eqh=[];
        
        [x,y] = fmincon(fhandles{round(fnum)},x0,[],[],[],[],[0.05 0.05],[5 5],@(x)constraints_iswt(x,round(fnum),fhandles,ineqh, eqh, ub),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveT1_1,x), feval(@objectiveT1_2,x)];
    case  'HANNE1'
        wv=load('HANNE1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@objectiveH1_1,@objectiveH1_2};
        ineqh=@inqualityH1;
        eqh=[];
        [x,y, exitflag,output,lambda] = fmincon(fhandles{round(fnum)},x0,[],[],[],[],[0, 0],[12 12],@(x)constraints_iswt(x,round(fnum),fhandles,ineqh, eqh, ub),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveH1_1,x), feval(@objectiveH1_2,x)];
    case 'DEB1'
        wv=load('DEB1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@objectiveDeb1_1,@ObjectiveDeb1_2};
        ineqh=[];
        eqh=[];
        [x,y] = fmincon(fhandles{round(fnum)},x0,[],[],[],[],[0.001, 0.0001],[1 1],@(x)constraints_iswt(x,round(fnum),fhandles,ineqh, eqh, ub),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveDeb1_1,x), feval(@ObjectiveDeb1_2,x)];
    case 'BINH1'
        wv=load('BINH1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@objectiveBinh1_1,@objectiveBinh1_2};
        ineqh=@inqualityBinh1;
        eqh=[];
        [x,y, exitflag,output,lambda] = fmincon(fhandles{round(fnum)},x0,[],[],[],[],[0 0],[5 5],@(x)constraints_iswt(x,round(fnum),fhandles,ineqh, eqh, ub),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveBinh1_1,x), feval(@objectiveBinh1_2,x)];
    case 'BINH2'
        wv=load('BINH2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@objectiveBinh2_1,@objectiveBinh2_2,@objectiveBinh2_3};
        ineqh=@inqualityBinh2;
        eqh=[];
        [x,y] = fmincon(fhandles{round(fnum)},x0,[],[],[],[],[],[],@(x)constraints_iswt(x,round(fnum),fhandles,ineqh, eqh, ub),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveBinh2_1,x), feval(@objectiveBinh2_2,x),feval(@objectiveBinh2_3,x)];
    case 'FONSECA1'
        wv=load('FONS1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@objectiveFons1_1,@objectiveFons1_2};
        ineqh=[];
        eqh=[];
        [x,y] = fmincon(fhandles{round(fnum)},x0,[],[],[],[],[],[],@(x)constraints_iswt(x,round(fnum),fhandles,ineqh, eqh, ub),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveFons1_1,x), feval(@objectiveFons1_2,x)];
    case 'FONSECA2'
        wv=load('FONS2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@objectiveFons2_1,@objectiveFons2_2};
        ineqh=[];
        eqh=[];
        [x,y] = fmincon(fhandles{round(fnum)},x0,[],[],[],[],[-4 -4 -4],[4 4 4],@(x)constraints_iswt(x,round(fnum),fhandles,ineqh, eqh, ub),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveFons2_1,x), feval(@objectiveFons2_2,x)];
    case 'KURSAWE'
        wv=load('KURSAWE.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@objectiveKursaw1,@objectiveFons2_2};
        ineqh=[];
        eqh=[];
        [x,y] = fmincon(fhandles{round(fnum)},x0,[],[],[],[],[-2 -2],[1 1],@(x)constraints_iswt(x,round(fnum),fhandles,ineqh, eqh, ub),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveKursaw1,x), feval(@objectiveKursaw2,x)];
    case 'TAPPETA'
        wv=load('TAPPETA.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@tappeta1,@tappeta2,@tappeta3};
        ineqh=[];
        eqh=[];
        [x,y] = fmincon(fhandles{round(fnum)},x0,[],[],[],[],[0 0 0],[10 10 10],@(x)constraints_iswt(x,round(fnum),fhandles,ineqh, eqh, ub),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@tappeta1,x), feval(@tappeta2,x),feval(@tappeta3,x)];
           
    case 'DOWNING'
        wv=load('DOWNING.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@downing1,@downing2,@downing3};
        ineqh=[];
        eqh=[];
        [x,y] = fmincon(fhandles{round(fnum)},x0,[],[],[],[],[0 0 0 0 0],[5 5 5 5 5],@(x)constraints_iswt(x,round(fnum),fhandles,ineqh, eqh, ub),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@downing1,x), feval(@downing2,x),feval(@downing3,x)];
        
    case 'VINNET'
        wv=load('VINNET.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@vinnet1,@vinnet2,@vinnet3};
        ineqh=[];
        eqh=[];
        [x,y] = fmincon(fhandles{round(fnum)},x0,[-1 0;0 1],[2;2],[],[],[-6 -6],[6 6],@(x)constraints_iswt(x,round(fnum),fhandles,ineqh, eqh, ub),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@vinnet1,x), feval(@vinnet2,x),feval(@vinnet3,x)];
        
    case 'VINNET2'
        wv=load('VINNET2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@vinnet2_1,@vinnet2_2,@vinnet2_3};
        ineqh=[];
        eqh=[];
        [x,y] = fmincon(fhandles{round(fnum)},x0,[-1 0;0 1],[4;4],[],[],[-6 -6],[6 6],@(x)constraints_iswt(x,round(fnum),fhandles,ineqh, eqh, ub),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@vinnet2_1,x), feval(@vinnet2_2,x),feval(@vinnet2_3,x)];
        
    case  'RENDON'
        wv=load('RENDON.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@rendon1,@rendon2};
        ineqh=[];
        eqh=[];
        [x,y, exitflag,output,lambda] = fmincon(fhandles{round(fnum)},x0,[-1 0;0 1],[3; 3],[],[],[-6, -6],[6 6],@(x)constraints_iswt(x,round(fnum),fhandles,ineqh, eqh, ub),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@rendon1,x), feval(@rendon2,x)];
end;

        


% ineqh %handle of inequality function for MOOP
% eqh % handle of equality function for MOOP



%[x,y] = fmincon(obj_handles{mfnum},x0,[],[],[],[],[],[],@(x)constraints_iswt(x,fnum,fhandles,ineqh, eqh, ub));

end