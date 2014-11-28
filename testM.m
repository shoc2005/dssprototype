function [opt,yvals]=testM(method,problem,rcount, icount,noise,subexpid)
%syntax  [opt,yvals]=testM(problem,method,rcount/noise, icount)
% Agruments are:
% -problem (string) of optimization, example 'BINH1', by default all 'T1','H1','DEB1', 'BINH1', 'BINH2', 'FONSECA1','FONSECA2','KURSAWE';
% -method (string) of optimization example 'ISWT', by default all 'GDF','ISWT';
% if funcion gets three arguments then third is a noise in %
% if function gets four erguments then in the noise plase need to write
% repeat count 
% -rcount (number) of experiment repeat count, default 2
% -icont (number) of iteration count with DM, default 5
% noise level 0-100%
%last modified 11 september of 2009.

%Set options by Default
global flag_stop;
flag_stop=0;

%database names %{HANNE, HANNE1, DEB1, BINH1, FONSECA1, FONSECA2, KURSAWE
test_problems={ 'HANNE', 'HANNE1','DEB1', 'BINH1', 'FONSECA1','FONSECA2','KURSAWE', 'TAPPETA', 'DOWNING','VINNET','VINNET2','RENDON'};
opt_methods={'GDF','ISWT','WSUM','GOALATT','GUESS','STEM'}; %opt_methods={'GDF','ISWT','WSUM'};
opt=inicializeMOEA('default'); %create default structure
exp_name=['EA_',num2str(subexpid)];



opt.repeat_count=1; % experiment repeating number
repeat_count=opt.repeat_count;

opt.iter_count=12; %Maximum iterations for testing 
iter_count=opt.iter_count;

opt.noise=0; %by default the noise level of goal is 0%


if ~iscell(method);
    method={method};
end;
if ~iscell(problem);
    problem={problem};
end;


%Firstly we check for argument count
if nargin==1;
    opt_methods=method;
    
elseif nargin==2;
    test_problems=problem;
    opt_methods=method;
elseif nargin==3;
    test_problems=problem;
    opt_methods=method;
    opt.noise=rcount;
    %opt.repeat_count=rcount;
    %repeat_count=opt.repeat_count;
    
    
elseif nargin==4;
    test_problems=problem;
    opt_methods=method;
    opt.repeat_count=rcount;
    repeat_count=opt.repeat_count;
    opt.iter_count=icount;
    iter_count=opt.iter_count;
    
elseif nargin==5||nargin==6;
    test_problems=problem;
    opt_methods=method;
    opt.repeat_count=rcount;
    repeat_count=opt.repeat_count;
    opt.iter_count=icount;
    iter_count=opt.iter_count;
    opt.noise=noise;
end;




opt.type='binary-coded';
opt.gencount=str2num( get(findobj('Tag','pop_count'),'String'));
opt.popsize=str2num( get(findobj('Tag','ind_count'),'String'));

opt.class='stohastic';
opt.m_propability=str2num( get(findobj('Tag','mut'),'String')); %df 0.23
opt.lambaShare=0.9;
opt.in_count=0;%3; % number of inequality constraints >=0
opt.in_constr=[];%@test_inquality;

opt.plotpath=[]; %the path to save plots
opt.ref=0; % for this application

%setpref('Internet','E_mail','matlab@itf.llu.lv');
%setpref('Internet','SMTP_Server','mail.llu.lv');
if strcmp(computer,'PCWIN64');
    opt.plotpath='C:\Users\Administrator\Desktop\next_step\plots\';
else
    opt.plotpath='C:\Users\sholc\Desktop\next_step\next_testing\next_testing\plots\';
end;


for meth=1:size(opt_methods,2); %number of optimization methods witch are going continuously
opt.method=opt_methods{meth};
method=opt.method;

num_of_problems=size(test_problems,2);
for pr=1:num_of_problems;
%for pr=1:num_of_problems;
opt.problem=test_problems{pr};
problem=opt.problem;

for ii=1:opt.repeat_count; %repeat count for problem

opt.repeat=ii;

% concrete Method's parameters:

switch method %configure optimization method parameters
    case 'GDF'
        methodID=3;
                  
    case 'ISWT'
        methodID=4;
     
    case 'WSUM'
        methodID=7;
    
    case 'GOALATT'
        methodID=8;
    
    case 'GUESS'
        methodID=9;
    
    case 'STEM'
        methodID=10;
end;

true_pareto=[];

opt=setMethodOptions(method, problem, opt);
    

% the option structure is created!

time_start=clock; %for subexperiment
metrics=[]; %stucture for metrics
metrics.gendist=0; % Generar distance (MOGA measure) +
metrics.erratio=0; %Error Ratio for population (MOGA measure)+
metrics.spacing=0; %Spacing for population (MOGA measure)+
metrics.mparetoer=0; %Max pareto error measure for population (MOGA measure)+ 
metrics.ovng=0;% Overall Non-dominated Vector Generation and ratio (MOGA measure)+
metrics.ovngr=0;% Overall Non-dominated Vector Generation Ratio (MOGA measure)+
metrics.conver=0; % Progress measure or convergence measure (MOGA measure)+
metrics.waves=0; % Measure Waves+
metrics.stdgd=0; % Standart General Distance measure
metrics.satisf=satisfaction(opt.y0,opt.goal); % Satisfication of DM is value is 0 then goal was obtained
metrics.xvals=opt.x0;
metrics.objvals=opt.y0;
metrics.pref_inf=init_varvals(problem,method); % preference information metrics for all iterations
metrics.goal=[]; %goal of optimization problem
metrics.y0=[]; %y0 values
metrics.method=method;
metrics.conseq=[]; %consequence of DM

satf_val=inf;
ea_algol=get(findobj('Tag','ea_m'),'Value');

    i=1;    
    while (i<=opt.iter_count);
    %for i=1:opt.iter_count; %this is large iteration count that is stop criteria for testing T1
        opt.iter=i;
        obj_vals=[];
        var_values=[];
        
            tic;
            
            if ea_algol==1;
                [opt, yvals]=testEA(opt);
            elseif ea_algol==2;
                lo=[];
                up=[];
                for ms=1:size(opt.varmasks,2);
                    lo(end+1)=opt.varmasks{ms}.lower;
                    up(end+1)=opt.varmasks{ms}.upper;
                end;
                ga_opt=[];
                %ga_opt = gaoptimset('PlotFcns',{@gaplotpareto,@gaplotscorediversity, @gaplotstopping});
                ga_opt = gaoptimset('Generations',opt.gencount);
                ga_opt = gaoptimset(ga_opt,'UseParallel','always');
                %ga_opt = gaoptimset(ga_opt,'PlotInterval',10);
                %ga_opt = gaoptimset(ga_opt,'StallGenLimit',20);
                ga_opt = gaoptimset(ga_opt,'PopulationSize',opt.popsize);
                %ga_opt = gaoptimset(ga_opt,'CrossoverFcn',{@crossovertwopoint});
                ga_opt = gaoptimset(ga_opt,'OutputFcn',@eval_state);
                %ga_opt = gaoptimset(ga_opt,'EliteCount',4);
                ga_opt = gaoptimset(ga_opt,'TolFun',1.0e-45);
                %ga_opt= gaoptimset(ga_opt,'CrossoverFcn',@crossoversinglepoint);
                %ga_opt= gaoptimset(ga_opt,'ParetoFraction',0.5);
                %ga_opt= gaoptimset(ga_opt,'PopulationType','bitstring');
                %DEFAULT good works
                %{
'SelectionFcn', {{@selectiontournament,2}}, ...
 'CrossoverFcn',@crossoverintermediate, ...
 'MutationFcn',@mutationadaptfeasible, ...
                %}
                switch opt.method
                    case 'STEM'
                        opt.objhandle=@(x)stem_objectives(x,opt);
                    case 'GDF'
                        opt.objhandle=@(x)gdf_objectives(x,opt);
                    case 'GUESS'
                        opt.objhandle=@(x)guess_objectives(x,opt);%
                end;
                
                [X,FVAL,EXITFLAG,OUTPUT,POPULATION,SCORE] = gamultiobj(opt.objhandle,opt.varcount,[],[],[],[],lo,up, ga_opt);
                opt=select_solution_ga(X,FVAL,opt);
                yvals=FVAL;
            end;
            
             
             varvals=opt.bestsolution
             if ~isempty(varvals);
                 cpu_time=toc;
                 
                 
                 %varvals=setNoise(method,opt.noise,varvals);
                 
                 switch opt.method %choose optimization method
                     case 'GDF'
                         [x_x,y_y]=geoff_inicialize(opt.x0,varvals, opt.problem); %GDF method
                     case 'ISWT'
                         [x_x,y_y]=iswt_inicialize(opt.x0,varvals(1),varvals(2:end), opt.problem); %ISWT method vars: x0,fnum,ub,problem
                     case 'WSUM'
                         [x_x,y_y]=wsum_inicialize(opt.x0,varvals,opt.problem); %ISWT method vars: x0,weights,problem
                     case 'GOALATT'
                         [x_x,y_y]=goalatt_inicialize(opt.x0,varvals,opt.goal,opt.problem);
                     case 'GUESS'
                         zref_end=size(opt.goal,2);
                         zref=varvals(1:zref_end);
                         lb_start=zref_end+1;
                         lb_end=zref_end+size(opt.goal,2);
                         lb=varvals(lb_start:lb_end);
                         
                         ub_start=lb_end+1;
                         ub=varvals(ub_start:end);
                         [x_x,y_y]=guess_inicialize(opt.x0,zref,lb,ub,opt.problem);
                         %[x_x,y_y]=goalatt_inicialize(opt.x0,varvals,opt.goal,opt.problem);
                     case 'STEM'
                         sz=size(opt.goal,2);
                         st=sz;
                         satFuns=varvals(1:st);
                         st=sz+1;
                         unsatFuns=varvals(st:sz*2);
                         st=sz*2+1;
                         econs=varvals(st:sz*3);
                         %satFuns=unique(fix(satFuns));
                         %unsatFuns=unique(fix(unsatFuns));
                         satFuns=(round(satFuns));
                         unsatFuns=(round(unsatFuns));
                         
                         satFuns=find(satFuns==1);
                         unsatFuns=find(unsatFuns==1);
                         
                         prev=opt.y0;
                         [x_x,y_y,exitf]=stem_inicialize(opt.x0,prev,satFuns,unsatFuns,econs,test_problems{pr},opt.iter, opt.ideal);
                 end;
                 x0_values=x_x; %This is x values of concrete problem, for example T1
                 y0_values=y_y;
                 
                 
                 
                 %[v,index]=max(opt.scaled_fit);
                 %index=select_solution(opt);
                 %x0_values=var_values(index,:)
                 %y0_values=obj_vals(index,:)
                 
                 %varvals=opt.varvals(index,:);
                 %varvals=opt.bestsolution
                 %end;
                 opt.x0=x0_values;
                 %opt.selected_index=index;
                 
                 
                 
                 
                 
                 
                 step='';
                 switch opt.method
                     case 'GDF'
                         varvals(end-1)=round(varvals(end-1));
                         
                         varvals(varvals(end-1))=1;
                         viv=['Main criterion: ',num2str(varvals(end-1)),char(10),'Step: ',num2str(varvals(end)), char(10)];
                         step=varvals(end);
                         vri=(varvals(1:(end-2)));
                         for kl=1:size(vri,2);
                             mi=[' m',num2str(kl),'=',num2str(vri(kl)),'; '];
                             viv=[viv,mi];
                         end;
                         set(findobj('Tag','viv_desc'),'String',viv);
                         set(findobj('Tag','viv_desc'),'UserData',varvals);
                     case 'ISWT'
                         varvals(1)=round(varvals(1));
                         varvals(varvals(1)+1)=999.999;% %main function
                         vri=(varvals(2:end));
                     case {'WSUM','GOALATT'};
                         kl=sum(varvals);
                         if kl~=1;
                             tmp=varvals;
                             tmp=tmp./kl;
                             tmp=round(tmp*100)/100;
                             varvals=tmp;
                         end;
                         
                         vri=(varvals);
                     case 'GUESS'
                         vri=varvals;
                         zref_end=size(opt.goal,2);
                         zref=vri(1:zref_end);
                         lb_start=zref_end+1;
                         lb_end=zref_end+size(opt.goal,2);
                         lb=vri(lb_start:lb_end);
                         
                         ub_start=lb_end+1;
                         ub=vri(ub_start:end);
                         viv=['Atsauces punkts: ',num2str(zref),char(10),'Kritçriju augðçjâs vçrtîbas: ',num2str(ub), char(10),'Kritçriju apakðçjâs vçrtîbas: ',num2str(lb)];
                         set(findobj('Tag','viv_desc'),'String',viv);
                         set(findobj('Tag','viv_desc'),'UserData',vri);
                     case 'STEM'
                         viv=varvals;
                         relax='';
                         sz=size(opt.goal,2);
                         
                         st=sz;
                         satFuns=viv(1:st);
                         st=sz+1;
                         unsatFuns=viv(st:sz*2);
                         st=sz*2+1;
                         econs=viv(st:sz*3);
                         
                         %satFuns=unique(sort(fix(satFuns)));
                         %unsatFuns=unique(sort(fix(unsatFuns)));
                         satFuns=(round(satFuns));
                         unsatFuns=(round(unsatFuns));
                         
                         satFuns=find(satFuns==1);
                         unsatFuns=find(unsatFuns==1);
                         
                         for r=1:size(satFuns,2);
                             relax=[relax,'F',num2str(satFuns(r)),'<=',num2str(econs(satFuns(r))),char(10)];
                         end;
                         viv=['Kritçriji,kas jâuzlabo: ',num2str(unsatFuns),char(10),'Kritçriji, kas relaksç: ',char(10), relax];
                         set(findobj('Tag','viv_desc'),'String',viv);
                         set(findobj('Tag','viv_desc'),'UserData',varvals);
                         vri=varvals;
                         
                 end;
                 
                 %tmp={};
                 fvri={'','','','','','','','',''};
                 for p=1:size(vri,2);
                     fvri{p}=num2str(vri(p));
                 end;
                 vri=fvri;
                 
                 %if size(vri,2)<3;
                 %    vri{end+1}='';
                 %end;
                 
                 objectives=zeros(1,3);
                 variables=zeros(1,5);
                 objectives(1:size(y0_values,2))=y0_values;
                 variables(1:size(x0_values,2))=x0_values;
                 
                 
                 
                 
                 %opt=setNoise(opt)
                 
             end;
             i=i+1;
             %===! for gendist and stdist ===! need objvals
             
           
             
             
            
             
             time_stop=clock; %for subexperiment
             
    end;
end;


end; %for problems

end; % for methods


