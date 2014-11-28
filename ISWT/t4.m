function Binh1()
%first objective for Binh1 problem (pp226. Veldhuizen)
x1=[-5:0.1:10];
x2=[-5:0.1:10];

pareto=[];
x=[];
for i=1:size(x1,2);
    for j=1:size(x2,2);
        xx=[x1(i),x2(j)];
        x(end+1,:)=xx;
        
        f1=objectiveBinh1_1(xx);
        f2=objectiveBinh1_2(xx);
        pareto(end+1,:)=[f1 f2];
        %plot(f1,f2);
        %hold on;
    end;
end;
%xlabel('f_1(x)');
%ylabel('f_2(x)');
%title('Binh1 convex function');
%drawnow;

true_pareto=[];
true_pareto_x=[];
for i=1:size(pareto,1);
    if dominance1(i,pareto)==0;
        true_pareto(end+1,:)=pareto(i,:);
        true_pareto_x(end+1,:)=x(i,:);
    end;
end;

save('BINH1', 'true_pareto', 'true_pareto_x');function [c,ceq]=constraints_iswt(x,fnum,fhandles,ineqh, eqh, ub)
% x vector of problem variables, for example problem H1
%fnum - function what be minimizing
%ineqh - handle of inequality function for MOOP problem
%eqh - handle of equality function for MOOP problem
%up- upper value bounds for objective functions

c=[]; % c<=0
ceq=[]; %ceq=0;

objcount=size(fhandles,2);

for i=1:objcount;
    if i~=fnum;
        c(end+1)=feval(fhandles{i},x)-ub(i);  
    end;
end;


if isempty(ineqh)==0;
    ineq=feval(ineqh,x);
    c=[c,ineq];
end;

if isempty(eqh)==0;
    ceq=feval(eqh,x);
end;
   

end

function dom_count=dominance1(sol_index, set)
%function calculate dominated solutions by solution of index: sol_index;
dom_count=0;
y=set(sol_index,:);
parfor i=1:size(set,1);
    s=0;
    f=0;
    if i~=sol_index;
        for j=1:size(set,2);
            if (y(j)>=set(i,j));
                f=f+1;
            end;

            if (y(j)>set(i,j));
                s=s+1;
            end;
          end;
    end;

    if (f==size(set,2))&&(s>0);
        dom_count=dom_count+1;
    end;
end;function y=inqualityBinh1(x);
y(1)=-x(1)-5;
y(2)=x(2)-10;
endfunction [x,y,exitflag,output,lambda]=iswt_inicialize(x0,fnum,ub,problem) 
%function to solve MOOP with ISWT method
% arguments are: 
% x0 -inicial x value, mfnum- function number to minimize,
% upbound- upper value bounds of objective function except mfnum objecive
% opt - stucture of optimization necessary information 
%last edited 10.09.2009.

opt=optimset('fmincon');
opt.TolFun=0.2e+0;
opt.TolCon=0.2e-1;
%opt.Diagnostics='on';
%opt.Dispaly='iter';
%opt.MaxIter=50;
opt.UseParallel='always';
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
        x0
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
end;

        


% ineqh %handle of inequality function for MOOP
% eqh % handle of equality function for MOOP



%[x,y] = fmincon(obj_handles{mfnum},x0,[],[],[],[],[],[],@(x)constraints_iswt(x,fnum,fhandles,ineqh, eqh, ub));

endfunction y=m1(x)
y=x(1)^2+5;
endfunction y=m2(x)
y=x(1)^2+x(2);
endfunction y=m3(x)
y=x(1)^2+x(2)^2;
endfunction result=objectiveBinh1_1(x)
%first objective for Binh1 problem (pp226. Veldhuizen)

result=x(1)^2+x(2)^2;

endfunction result=objectiveBinh1_2(x)
%first objective for Binh1 problem (pp226. Veldhuizen)

result=(x(1)-5)^2+(x(2)-5)^2;

endfunction Binh1()
%first objective for Binh1 problem (pp226. Veldhuizen)
x1=[-5:0.1:10];
x2=[-5:0.1:10];

pareto=[];
x=[];
for i=1:size(x1,2);
    for j=1:size(x2,2);
        xx=[x1(i),x2(j)];
        x(end+1,:)=xx;
        
        f1=objectiveBinh1_1(xx);
        f2=objectiveBinh1_2(xx);
        pareto(end+1,:)=[f1 f2];
        %plot(f1,f2);
        %hold on;
    end;
end;
%xlabel('f_1(x)');
%ylabel('f_2(x)');
%title('Binh1 convex function');
%drawnow;

true_pareto=[];
true_pareto_x=[];
for i=1:size(pareto,1);
    if dominance1(i,pareto)==0;
        true_pareto(end+1,:)=pareto(i,:);
        true_pareto_x(end+1,:)=x(i,:);
    end;
end;

save('BINH1', 'true_pareto', 'true_pareto_x');function [c,ceq]=constraints_iswt(x,fnum,fhandles,ineqh, eqh, ub)
% x vector of problem variables, for example problem H1
%fnum - function what be minimizing
%ineqh - handle of inequality function for MOOP problem
%eqh - handle of equality function for MOOP problem
%up- upper value bounds for objective functions

c=[]; % c<=0
ceq=[]; %ceq=0;

objcount=size(fhandles,2);

for i=1:objcount;
    if i~=fnum;
        c(end+1)=feval(fhandles{i},x)-ub(i);  
    end;
end;


if isempty(ineqh)==0;
    ineq=feval(ineqh,x);
    c=[c,ineq];
end;

if isempty(eqh)==0;
    ceq=feval(eqh,x);
end;
   

end

function dom_count=dominance1(sol_index, set)
%function calculate dominated solutions by solution of index: sol_index;
dom_count=0;
y=set(sol_index,:);
parfor i=1:size(set,1);
    s=0;
    f=0;
    if i~=sol_index;
        for j=1:size(set,2);
            if (y(j)>=set(i,j));
                f=f+1;
            end;

            if (y(j)>set(i,j));
                s=s+1;
            end;
          end;
    end;

    if (f==size(set,2))&&(s>0);
        dom_count=dom_count+1;
    end;
end;function y=inqualityBinh1(x);
y(1)=-x(1)-5;
y(2)=x(2)-10;
endfunction [x,y,exitflag,output,lambda]=iswt_inicialize(x0,fnum,ub,problem) 
%function to solve MOOP with ISWT method
% arguments are: 
% x0 -inicial x value, mfnum- function number to minimize,
% upbound- upper value bounds of objective function except mfnum objecive
% opt - stucture of optimization necessary information 
%last edited 10.09.2009.

opt=optimset('fmincon');
opt.TolFun=0.2e+0;
opt.TolCon=0.2e-1;
%opt.Diagnostics='on';
%opt.Dispaly='iter';
%opt.MaxIter=50;
opt.UseParallel='always';
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
        x0
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
end;

        


% ineqh %handle of inequality function for MOOP
% eqh % handle of equality function for MOOP



%[x,y] = fmincon(obj_handles{mfnum},x0,[],[],[],[],[],[],@(x)constraints_iswt(x,fnum,fhandles,ineqh, eqh, ub));

endfunction y=m1(x)
y=x(1)^2+5;
endfunction y=m2(x)
y=x(1)^2+x(2);
endfunction y=m3(x)
y=x(1)^2+x(2)^2;
endfunction result=objectiveBinh1_1(x)
%first objective for Binh1 problem (pp226. Veldhuizen)

result=x(1)^2+x(2)^2;

endfunction result=objectiveBinh1_2(x)
%first objective for Binh1 problem (pp226. Veldhuizen)

result=(x(1)-5)^2+(x(2)-5)^2;

endfunction Binh1()
%first objective forfunction [y,x]=test_iswt()
opt=[];
opt.objcount=2;
opt.objhandles={@objectiveBinh1_1,@objectiveBinh1_2};
opt.ineq=@inqualityBinh1;
[y,x]=iswt_inicialize([0.3,0.4],2,[0.5,10],opt);
y(1)=objectiveBinh1_1(x);
y(2)=objectiveBinh1_2(x);

end