function [c, ceq]=constraints_wsum(x,ineqh,eqh)
%common constraint function fro weighted method

c=[];
ceq=[];

if not(isempty(ineqh));
    c=feval(ineqh,x);
end;

if not(isempty(eqh));
    ceq=feval(eqh,x);
end;

end
function [c, ceq]=constraints_wsum(x,ineqh,eqh)
%common constraint function fro weighted method

c=[];
ceq=[];

if not(isempty(ineqh));
    c=feval(ineqh,x);
end;

if not(isempty(eqh));
    ceq=feval(eqh,x);
end;

end
function y=wsum_comfun(x,w,fhandles)
%common function for all problems solved by Weighted sum method
%where fhandles is a handles of objectives, count of objectives is equalent
%with w-weight vector element count

y=0;
for i=1:size(w,2);
    y=y+feval(fhandles{i},x)*w(i);
end;function y=wsum_constr(w)
%constration function for MOGA algorithm
y=sum(w)-1;function [x,y]=wsum_inicialize(x0,w,problem) 
%function to solve MOOP with ISWT method
% arguments are: 
% x0 -inicial x value, mfnum- function number to minimize,
% upbound- upper value bounds of objective function except mfnum objecive
% opt - stucture of optimization necessary information 
%last edited 10.09.2009.

opt=optimset('fmincon');
opt.TolFun=0.001;
opt.TolCon=0.001;
opt.MaxIter=50;
opt.UseParallel='always';

switch problem
    case  'HANNE'
        T1=load('T1_true.mat');
        tol=mean(std(T1.T1))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        
        fhandles={@objectiveT1_1,@objectiveT1_2};
        ineqh=@inqualityT1;
        eqh=[];
        
        [x,y] = fmincon(@(x0)wsum_comfun(x0,w,fhandles),x0,[],[],[],[],[0.5,0.5],[7,7],@(x)constraints_wsum(x,ineqh,eqh),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveT1_1,x), feval(@objectiveT1_2,x)];
        
    case  'HANNE1'
        wv=load('HANNE1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        
        fhandles={@objectiveH1_1,@objectiveH1_2};
        ineqh=@inqualityH1;
        eqh=[];
        [x,y] = fmincon(@(x0)wsum_comfun(x0,w,fhandles),x0,[],[],[],[],[0, 0],[12 12],@(x)constraints_wsum(x,ineqh,eqh),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveH1_1,x), feval(@objectiveH1_2,x)];
    case 'DEB1'
        wv=load('DEB1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        
        fhandles={@objectiveDeb1_1,@ObjectiveDeb1_2};
        ineqh=[];
        eqh=[];
        [x,y] = fmincon(@(x0)wsum_comfun(x0,w,fhandles),x0,[],[],[],[],[0, 0],[1 1],@(x)constraints_wsum(x,ineqh,eqh),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveDeb1_1,x), feval(@ObjectiveDeb1_2,x)];
    case 'BINH1'
        
        wv=load('BINH1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@objectiveBinh1_1,@objectiveBinh1_2};
        ineqh=@inqualityBinh1;
        eqh=[];
        [x,y] = fmincon(@(x0)wsum_comfun(x0,w,fhandles),x0,[],[],[],[],[],[],@(x)constraints_wsum(x,ineqh,eqh),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveBinh1_1,x), feval(@objectiveBinh1_2,x)];
    case 'BINH2'
        wv=load('BINH2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
             
        
        fhandles={@objectiveBinh2_1, @objectiveBinh2_2, @objectiveBinh2_3};
        ineqh=@inqualityBinh2;
        eqh=[];
        [x,y] = fmincon(@(x0)wsum_comfun(x0,w,fhandles),x0,[],[],[],[],[],[],@(x)constraints_wsum(x,ineqh,eqh),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveBinh2_1,x), feval(@objectiveBinh2_2,x),feval(@objectiveBinh2_3,x)];
    case 'FONSECA1'
        wv=load('FONS1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
                
        fhandles={@objectiveFons1_1,@objectiveFons1_2};
        ineqh=[];
        eqh=[];
        [x,y] = fmincon(@(x0)wsum_comfun(x0,w,fhandles),x0,[],[],[],[],[],[],@(x)constraints_wsum(x,ineqh,eqh),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveFons1_1,x), feval(@objectiveFons1_2,x)];
    case 'FONSECA2'
        
        wv=load('FONS2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@objectiveFons2_1,@objectiveFons2_2};
        ineqh=[];
        eqh=[];
        [x,y] = fmincon(@(x0)wsum_comfun(x0,w,fhandles),x0,[],[],[],[],[-4 -4 -4],[4 4 4],@(x)constraints_wsum(x,ineqh,eqh),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveFons2_1,x), feval(@objectiveFons2_2,x)];
    case 'KURSAWE'
        
        wv=load('KURSAWE.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        fhandles={@objectiveKursaw1,@objectiveFons2_2};
        ineqh=[];
        eqh=[];
        [x,y] = fmincon(@(x0)wsum_comfun(x0,w,fhandles),x0,[],[],[],[],[-2 -2],[1 1],@(x)constraints_wsum(x,ineqh,eqh),opt); %x,fnum,fhandles,ineqh, eqh, ub
        y=[feval(@objectiveKursaw1,x), feval(@objectiveKursaw2,x)];   
end;