function options=inicializeMOEA(str)
%function inicialize base structure for EA 
%if type='default' then returned structure is empty
% else structure parameters define user
options=[];
options.type='binary-coded'; %represents that works with binary-coder functions
options.varcount=[]; %number of variables
options.objcount=[]; %number of objectives
options.objhandle={}; %handles of objective functions
options.eq_constr=[]; %number of equality constraints =0
options.in_constr=''; %function handle number of inequality constraints >=0
options.in_count=0; % number of inequality constraints >=0
options.popsize=50; % population size
options.gencount=50; % number of generations
options.varmasks={}; % lower and upper bounds of variables
options.gen_length=10; %genome length in bits if type is binary-coded
options.population={}; %population size
options.objvals=[]; %options values
options.varvals=[]; %variable values
options.ranks=[]; %rank values for generation t
options.niche_coutv=[]; %niche count values for generation t
options.objminmax={};% objective function`s min and max values;
options.avgfitness=[]; %average fitness values for generation t
options.shared_fitness=[]; %shared fitness values for generation t
options.scaled_fit=[] %scaled fitness values for geneeration t
options.crosspoint=0; %cross point for binary-coded single crossover operator
options.m_propability=0; %mutation propability
options.lambaShare=0.45; %lambda share value static or dinamic
options.Rmagnitude=zeros(1,options.objcount); % Penalty for inequality constraint magnitude coefs
options.alfa=0.5; %for real-coded MOGA in crossover operator the best value is 0.5
options.gen=0; % current generation number
options.plots={} % plot information structure: 'obj', 'xvals', 'error_ratio','spacing','gen_dist', 
%'max_error', 'hyp_ratio', 'onvgr', 'onvg', 'nvia', 'dist_from_pareto', 'gen_distance_from_pareto'
options.gendist=0; % Generar distance (MOGA measure)
options.erratio=0; %Error Ratio for population (MOGA measure)
options.spacing=0; %Spacing for population (MOGA measure)
options.mparetoer=0; %Max pareto error measure for population (MOGA measure) 
options.ovng=0;% Overall Non-dominated Vector Generation and ratio (MOGA measure)
options.ovngr=0;% Overall Non-dominated Vector Generation Ratio (MOGA measure)
optioms.conver=0; % Progress measure or convergence measure (MOGA measure)
options.waves=0; % Measure Waves
options.stdgd=0; % Standart General Distance measure
options.class='stohastic'; % or determ -deterministic 

options.truePareto=[]; %truePareto solution set




if not(strcmp(str,'default'));
    %options.type='real-coded';
    options.type='binary-coded';
    options.gencount=50;
    options.popsize=50;
    options.crosspoint=12;
    options.m_propability=0.95;%1/0.042;
    options.varcount=2;
    options.objcount=2;
    options.lambaShare=0.42;
    options.objhandle={@objectiveDeb1_1,@objectiveDeb1_2}; %@test_objective0,@test_objective1,
    options.Rmagnitude=[1 1];
    options.gen_length=20;
    options.in_count=4;%3; % number of inequality constraints >=0
    options.in_constr=@inqualityDeb1;%@test_inquality;
    
    %load 'T1_true.mat'; %load variable pareto with truePareto solutions
    %options.truePareto=T1;
    
    mask1=[]; %variable x1 or x(1)
    mask1.startbit=1;
    mask1.stopbit=10;
    mask1.lower=0;
    mask1.upper=1;
    
    
   
   mask2=[]; %variable x2 or x(2)
    mask2.startbit=11;
    mask2.stopbit=20;
    mask2.lower=0;
    mask2.upper=1;
    
    
    mask3=[]; %variable w1
    mask3.startbit=21;
    mask3.stopbit=30;
    mask3.lower=-1;
    mask3.upper=1;
    
    mask4=[]; %variable w2
    mask4.startbit=31;
    mask4.stopbit=40;
    mask4.lower=-1;
    mask4.upper=1;
    
    options.varmasks={mask1,mask2};%, mask3,mask4};
    %}
    
    obj1=[];
    obj1.min=0;
    obj1.max=4;
    
    obj2=[];
    obj2.min=0;
    obj2.max=4;
    
    obj3=[];
    obj3.min=0;
    obj3.max=50;
    
    options.objminmax={obj1,obj2};
    
    p.x=0;
    p.ya=1;
    p.yb=2;
    
    options.plots{1,1}='obj';
    options.plots{1,2}=1;
    options.plots{1,3}=p;
    
    p.xa=1;
    p.xb=1;
    %{    
    options.plots{2,1}='gd';
    options.plots{2,2}=3;
    options.plots{2,3}=[];
    
    options.plots{3,1}='mparerror';
    options.plots{3,2}=7;
    options.plots{3,3}=[];
    
    options.plots{4,1}='stdgd';
    options.plots{4,2}=11;
    options.plots{4,3}=[];
    
        
 
     options.plots{5,1}='conver';
    options.plots{5,2}=10;
    options.plots{5,3}=[];
    
    
     options.plots{6,1}='waves';
    options.plots{6,2}=9;
    options.plots{6,3}=[];
    %}
    
    
end;

end