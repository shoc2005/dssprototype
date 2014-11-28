function options=average_fitness(options)
% function calculate the avarage fitness
parfor i=1:options.popsize;
    s=0;
    for j=1:options.ranks(i,1);
        s=s+size(find(options.ranks==(j-1)),1);
    end;
    avgfitness(i,1)=options.popsize-s-0.5*(size(find(options.ranks==options.ranks(i,1)),1)-1);
end;
options.avgfitness=avgfitness;function result=bindecode(gen,mask)
%function represents x values in binary coded string
% variable gen is encoded binary string
% variable mask is gen stucture description
start=mask.startbit;
stop=mask.stopbit;
len=length(gen);
if (stop>len) ||(start<1);
    MException(10,'The stop or start bit is out from gen length',stop,gen);
end;
substr='';
for i=start:stop;
    substr=strcat(substr,gen(i));
end;
int=bin2dec(substr);
len=length(substr);
result=mask.lower+((mask.upper-mask.lower)/((2^len)-1))*int;

endfunction options=crossover(options)
%function realize single-point crossover operator for binary-coded MOGA
%or function realize Bland crossover (BLX-alfa) for real-coded MOGA

%first we need to choose pairs solutions to crossover
pairs=combnk(1:options.popsize,2);
pairs(:,3)=0;
si=size(pairs,1);
new_population={};
i=1;
while size(new_population,2)<=options.popsize;
    if strcmp(options.type,'binary-coded');
        i=round(rand(1)*(size(pairs,1)-1))+1;
        if (pairs(i,3)~=1);
            x1=options.population{pairs(i,1)};
            x2=options.population{pairs(i,2)};
            x11=x1(options.crosspoint:end);
            x22=x2(options.crosspoint:end);
            x1(options.crosspoint:end)=x22;
            %x2(options.crosspoint:end)=x11;
            p=true;
            pairs(i,3)=1;
            new_population{end+1}=x1;
        end;
     else %for real-coded MOGA, the solution need to be x1<x2
       while size(new_population,2)<=options.popsize;
           % i
           % size(new_population,2)
           if (pairs(i,3)==0);
                x1=options.population{pairs(i,1)};
                x2=options.population{pairs(i,2)};
                if sum(x1<x2)~=options.varcount;
                   tmp=x1;
                   x1=x2;
                   x2=tmp;
                end;
                if sum(x1<x2)~=options.varcount;
                   pairs(i,3)=2; 
                else
                   p=true;
                   pairs(i,3)=1;
                   u=rand(1,1);
                   y=(1+2*options.alfa)*u-options.alfa;
                   x1=(1-y).*x1+y.*x2;
                   new_population{end+1}=x1;
                end;
            else %need to detect that no other x1<x2 exists in set pairs
                if size(find(pairs(:,3)==0),1)==0;
                    p=true;
                    k=round(rand(1)*(size(pairs,1)-1))+1;
                    x1=options.population{pairs(k,1)};
                    new_population{end+1}=x1;
                    %'stupid!'
                end;
            end;
            if ((i)<=si-1);
                i=i+1;
            end;
        end;
    end;
end;
    

options.population=new_population;

end
function dom_count=dominance(sol_index, options)
%function calculate dominated solutions by solution of index: sol_index;
dom_count=1;
y=options.objvals(sol_index,1:options.objcount);
parfor i=1:options.popsize;
    s=0;
    f=0;
    if i~=sol_index;
        for j=1:options.objcount;
            if (y(j)>=options.objvals(i,j));
                f=f+1;
            end;

            if (y(j)>options.objvals(i,j));
                s=s+1;
            end;
          end;
    end;

    if (f==options.objcount)&&(s>0);
        dom_count=dom_count+1;
    end;
end;


end

  
            
        
function result=error_ration(options)
%function measure Error Ration for current population MOGA

ranks=(options.ranks-1);
set=find(ranks==0); %result in one column
n=size(set,1); % number of non-dominated solutions


m=[];
e=0;
for i=1:n; %first we need to get all non-dominated solutions from current population
    m=options.objvals(set(i),:); 
    if not(is_member(m,options.truePareto));
        e=e+1;
    end;
end;
    
result=e/n;

if isnan(result)||isinf(result);
     result=-1;
end;

end

function res=is_member(elem, set) %is m member of set truePareto
elem_l=size(elem,2);
set_l=size(set,1);
res=false;
for i=1:set_l;
    s=0;
    for z=1:elem_l;
        if elem(z)==set(i,z);
            s=s+1;
        end;
    end;
    if s==elem_l;
        res=true;
    end;
end;

end




function mdist=eucdist(solution,tset)
%this is measure function General Distance (GD) for MOGA
%function calculate minimal Euclidean distanc between curent solution
%solutios form Tset

for i=1:size(tset,1);
    a=tset(i,:);
    t(i)=sum((solution-a).^2);
end;
mdist=min(t);
    
   
            
function [options,objvals]=eval_objectives(options)
%function calculate values of objectives

%first we need to calculate values of all variables;
xvals=[];
if strcmp(options.type,'binary-coded');
    parfor j=1:options.popsize;
        for i=1:options.varcount;
            mask=options.varmasks{i};
            x(1,i)=bindecode(options.population{j},mask);
        end;
        xvals(j,:)=x;
        x=[];
    end;
    options.varvals=xvals;
else %for real-coded MOGA
    for j=1:options.popsize;
        options.varvals(j,:)=options.population{j};
    end;
end;

%at next we calculate values of all objectives
objvals(1,:)=zeros(1,options.objcount);
for i=1:options.popsize;
    for j=1:options.objcount;
        ostr=[];
        try
        ostr.goal=options.goal;
        ostr.x0=options.x0;
        ostr.problem=options.problem;
        tmp=feval(options.objhandle{j},options.varvals(i,:),ostr);
        catch em
            '======'
            em.message
            em.identifier
            em.stack.line
            em.stack.file
            em.stack.name
            '======='
            
            tmp=feval(options.objhandle{j},options.varvals(i,:));
        end;
        
        if imag(tmp)==0;
            objvals(i,j)=tmp+options.Rmagnitude(j)*eval_constraints(i,options);
        else
            objvals(i,j)=abs(imag(tmp)+real(tmp))+options.Rmagnitude(j)*eval_constraints(i,options);
        end;
    end;
end;


options.objvals=objvals;
end

function penalty=eval_constraints(ind, options)

s=[];
penalty=0;

if (options.in_count>0);
        s=feval(options.in_constr,options.varvals(ind,:));
        parfor j=1:options.in_count;
            if (s(j)<0);
                penal(j)=abs(s(j));
            else
                penal(j)=0;
            end;
        end;
        penalty=sum(penal);
       
   
else
    penalty=0;
end;



if not(isempty(options.eq_constr));
    s=feval(options.eq_constr,options.varvals(ind,:));
    for j=1:size(s,2);
        if s(j)~=0;
            penalty=penalty+abs(s(j));
        end;
    end;
end;

end

function result=generaldist(options)
%function calculates general distance between true Pareto set and
%nondominated solutions in current population
%this function is perormance measure function GD

%ranks=(options.ranks-1);
%set=find(ranks==0); %result in one column
% number of non-dominated solutions

m=[];
tp=options.truePareto;
y0=options.metrics.objvals;

nn=size(y0,1);

parfor j=1:nn;
   m(j)=eucdist(y0(j,:),tp)^2;
end;

%{

gd=0; %deneral distace
for i=1:n;
    euc(i,i)=inf;
    x=euc(i,n+1:end);
    % we need to change i-element value to maximum value, becouse i-element value is 0
    gd=gd+min(x);
end;
%}
result=sqrt(sum(m))/nn;
if isnan(result)||isinf(result);
     result=-1;
end;
endfunction options=inicializeMOEA(str)
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

options.truePareto=[]; %truePareto solution set




if not(strcmp(str,'default'));
    %options.type='real-coded';
    options.type='binary-coded';
    options.gencount=500;
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

endfunction options=inicialize_population(options)
%function inicialize population in random way
if strcmp(options.type,'binary-coded');
    gen='';
    for j=1:options.popsize;
        for i=1:options.gen_length;
            bit=num2str(round(rand(1,1)));
            gen=strcat(gen,bit);    
        end;
        options.population{j}=gen;
        gen='';
    end;
else %for real-coded MOGA
    for j=1:options.popsize;
        gen=[];
        for i=1:options.varcount;
            gen(i)=rand(1,1);
        end;
        options.population{j}=gen;
    end;
end;
endfunction result=max_pareto_err(options)
%function measure the maximumu pareto using truePareto and current pareto
%vectors measure ME


yvals=[];
mi=[];
for i=1:size(options.metrics.objvals,1);
    yvals=options.metrics.objvals(i,:);
    n=[];
    for j=1:size(options.truePareto,1);
        n(j)=sqrt(sum((yvals-options.truePareto(j,:)).^2));
    end;
    mi(i)=min(n);
end;

result=max(mi);
if isnan(result)||isinf(result);
     result=-1;
end;
endfunction options=mutation(options)
%function realize the bit-wise mutation operator for binary-codes and
%random for real-coded MOGA

new_population={};
for i=1:options.popsize;
   
    pos=1;
    a=true;
    gen=options.population{i};
    if strcmp(options.type,'binary-coded'); %for binary-coded MOGA
        while a==true;
            r=rand(1);
            skip=round((-options.m_propability)*log(1-r));
            pos=pos+skip;
            if pos>options.gen_length;
                a=false;
            else
                gen(pos)=int2str(not(str2num(gen(pos))));
            end;
         end;
    else %for real-coded MOGA
        parfor i=1:options.varcount;
            r=rand(1,1);
            b=0.1;
            r1=random('beta',1,1);
            if r1>0.5;
                feta=1;
            else
                feta=-1;
            end;
            gen(1,i)=gen(1,i)+feta*(options.varmasks{i}.upper-options.varmasks{i}.lower)*(1-r^(1-options.gen/options.gencount)^b);
        end;
    end; 
         new_population{end+1}=gen;
end;

options.population=new_population;

end
    
function options=niche_count(options)

%this function uses the normalized distance between two solutions (Deb, page 202)

%minvals=min(options.objvals,[],1);
%maxvals=max(options.objvals,[],1);

%options=update_share(options); %update share value;
niche_coutv=zeros(options.popsize,1);
for i=1:options.popsize;
  rank=options.ranks(i);
  solutions_in_rank=find(options.ranks==rank);
  matrix=zeros(size(solutions_in_rank,1));
  for l=1:size(matrix,1);
      for c=1:size(matrix,2);
          dist=0;
          parfor obj=1:options.objcount;
            dist=dist+((options.objvals(solutions_in_rank(l),obj)-options.objvals(solutions_in_rank(c),obj))/(options.objminmax{obj}.max-options.objminmax{obj}.min))^2;
          end;
          matrix(l,c)=share(sqrt(dist),options.lambaShare);  
      end;
      niche_coutv(solutions_in_rank(l))=sum(matrix(l,:));
   
  end;
end;
options.niche_coutv=niche_coutv;
end
  


function res=share(distance,lambaShare)


if distance<lambaShare;
    res=1-distance/lambaShare;
else
    res=0;
end;
endfunction result=ovng(options)
%function measure non-dominated solution count in population this metric
%name is Overall Nondominated Vector Generation amd Ratio

m=find((options.ranks-1)==0);
result=size(m,1);

if isnan(result)||isinf(result);
     result=-1;
end;
endfunction result=ovngr(options)
%function measure non-dominated solution count in population this metric
%name is Overall Nondominated Vector Generation amd Ratio

m=find((options.ranks-1)==0);
result=size(m,1)/size(options.truePareto,1);
if isnan(result)||isinf(result);
     result=-1;
end;

endfunction handle=plots(options)

last_iteration='-og'; %for last iteration
first_iteration='-ob'; %for first iteration
proc_iteration='-or'; %for run process
selected='-or'; % for best selected from population


x=size(options.plots,1);
n=round(x/2);
m=fix(x/2);

if n>m;
    row=2;
    col=n;
else
    row=n;
    col=2;
end;

if x==1;
    row=1;
    col=1;
end;
    handle=subplot(row,col,1);


for i=1:row;
   for j=1:col;
        for p=1:x; % used selected plots
            subplot(row,col,p);
            %structure that represent plot information
            %options.plots{p,2} - represent plot number
            %options.plots{p,3}- return structure of plot values
            
            if options.gen==1;
                gr_opt=first_iteration;
            elseif options.gen==options.gencount;
                gr_opt=last_iteration;
            else 
                gr_opt=proc_iteration;
            end;
            
            
            
            if (strcmp(options.plots{p,1},'obj'))||(options.plots{p,2}==1); %plot values of objectives {2}-x axis and {3}-y axis
                %example of 'obj' sturcture number Nr.1
                %plot_elem.x -variable number
                %plot_elem.ya -objective number for x axis
                %plot_elem.yb -objective number for y axis
                %title(sprintf('Generation count=%d, Share value=%3.3f',options.gen, options.lambaShare)); 
                indx=options.plots{p,4};
                
                plot_elem=options.plots{p,3};
                
                if plot_elem.x~=0; 
                   xlabel(sprintf('x_%d',plot_elem.x)); 
                   ylabel(sprintf('f_%d',plot_elem.ya)); 
                else
                   xlabel(sprintf('f_%d',plot_elem.ya));
                   ylabel(sprintf('f_%d',plot_elem.yb));
                end;
                hold on;
%                axis([options.objminmax{plot_elem.ya}.min options.objminmax{plot_elem.ya}.max options.objminmax{plot_elem.yb}.min options.objminmax{plot_elem.yb}.max]);
               
                for i=1:options.popsize;
                    
                    if indx==i;
                        gr_opt=selected;
                    else
                        gr_opt=last_iteration;
                    end;
                    
                    hold on;
                    if plot_elem.x~=0; %if only one objective exists
                        plot(options.varvals(i,plot_elem.x),options.objvals(i,plot_elem.ya),gr_opt);
                        drawnow;
                    else
                        plot(options.objvals(i,plot_elem.ya),options.objvals(i,plot_elem.yb),gr_opt);
                        drawnow;
                    end;
                    
                end;
                
                %if options.gen==options.gencount;
                %    if options.truePareto~=size(options.truePareto,1);
                %        parfor i=1:size(options.truePareto,1);
                %            plot(options.truePareto(i,plot_elem.ya),options.truePareto(i,plot_elem.yb),'-or');
                %        end;
                %    end;
                %end;
            end; % end 'obj'

             if (strcmp(options.plots{p,1},'xvals'))||(options.plots{p,2}==2); %plot values of objectives {2}-x axis and {3}-y axis
                %example of 'xvals' sturcture number Nr.2
                %plot_elem.xa -variable number fo x axis
                %plot_elem.xb -variable number for y axis
                %title(sprintf('Generation=%d, Share value=%3.3f',options.gen, options.lambaShare)); 
                plot_elem=options.plots{p,3};
                
                
                xlabel(sprintf('x_%d',plot_elem.xa));
                ylabel(sprintf('x_%d',plot_elem.xb));
                hold on;
                
                
                indx=options.plots{p,4};
                
                parfor i=1:options.popsize;
                    if indx==i;
                        gr_opt=selected;
                    else
                        gr_opt=last_iteration;
                    end;
                    plot(options.varvals(i,plot_elem.xa),options.varvals(i,plot_elem.xb),gr_opt);
                    drawnow; 
                end;

            end; % end 'xvals
            
              if (strcmp(options.plots{p,1},'gd'))||(options.plots{p,2}==3); %plot general distance value for population
                
                title('General Distance (GD)'); 
                xlabel('generation number/iteration');
                ylabel('GD');
                hold on;
                
                plot(options.gendist,'-bs');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                drawnow; 
                
            end; % end 'geberal distance'
            
              if (strcmp(options.plots{p,1},'bestvalue'))||(options.plots{p,2}==4); %plot individuals un print a best solution by scaled fitness
                
                %hold on;
                
                bar(options.scaled_fit','b');
                title(sprintf('Values of Solutions and best value is %d',min(options.scaled_fit))); 
                xlabel('solutios');
                ylabel('values');
                
                drawnow; 
                
              end; % end 'geberal distance'
              
             if (strcmp(options.plots{p,1},'erratio'))||(options.plots{p,2}==5); %plot error ratio
                
                %hold on;
                
                
                plot(options.erratio,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Error Ratio'); 
                xlabel('generation number/iteration');
                ylabel('ER');
                
                drawnow; 
                
              end; % end 'plot error ratio'
              
              if (strcmp(options.plots{p,1},'spacing'))||(options.plots{p,2}==6); %plot error ratio
                
                %hold on;
                
                
                plot(options.spacing,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Spacing'); 
                xlabel('generation number/iteration');
                ylabel('SP');
                
                drawnow; 
                
              end; % end 'spacing'
              
              if (strcmp(options.plots{p,1},'mparerror'))||(options.plots{p,2}==7); %plot error ratio
                
                %hold on;
                
                
                plot(options.mparetoer,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Max Pareto Front Error'); 
                xlabel('generation number/iteration');
                ylabel('ME');
                
                drawnow; 
                
              end; % end 'max pareto front error'
              
              if (strcmp(options.plots{p,1},'ovng'))||(options.plots{p,2}==8); %plot error ratio
                %if options.gen==options.gencount;
                    %hold on;
                    r=[options.ovng(:),options.ovngr(:)];
                    %r=[sum(options.ovng),sum(options.ovngr)];
                    bar(r,'group');
                    title('Overall Nondominated Vector Generation and Ratio'); 
                    legend('OVNG','OVNGR');
                    xlabel('1-ONVG, 2-ONVGR');
                    ylabel('count/value');
                    %                   drawnow; 
                %end;

              end; % end 'Overall Nondominated Vector Generation'
              
              if (strcmp(options.plots{p,1},'waves'))||(options.plots{p,2}==9); %plot error ratio ====reserved for
                
                %hold on;
                
                plot(options.waves,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                axis([0 options.gencount 0 (max(options.waves)+max(options.waves)*0.1)]);
                title('Waves'); 
                xlabel('generation number/iteration');
                ylabel('W');
                
                drawnow; 
                
              end; % end 'Waves'
              
              if (strcmp(options.plots{p,1},'conver'))||(options.plots{p,2}==10); %plot error ratio
                
                hold on;
                plot(options.conver,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Progress measure -absolute convergence'); 
                xlabel('generation number/iteration');
                ylabel('PM');
                
                drawnow; 
                
              end; % end 'Progress measure -absolute convergence'
              
                 if (strcmp(options.plots{p,1},'stdgd'))||(options.plots{p,2}==11); %plot error ratio
                
                hold on;
                plot(options.stdgd,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Standart Deviation from General Distance'); 
                xlabel('generation number/iteration');
                ylabel('STDGD');
                
                drawnow; 
                
              end; % end 'stdgd'
              
              
               if (strcmp(options.plots{p,1},'satisf'))||(options.plots{p,2}==12); %DM satisfacion
                
                hold on;
                plot(options.satisf,'-bs','LineWidth',2,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','r',...
                'MarkerSize',5);
                set(findobj(gca,'Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Euclidean distance from the current solution to the goal'); 
                xlabel('generation number/iteration');
                ylabel('Distance');
                
                drawnow; 
                
              end; % end 'stdgd'
              
               if (strcmp(options.plots{p,1},'steps'))||(options.plots{p,2}==13); %plot error ratio ====reserved for
                
                hold on;
                plot_elem=options.plots{p,3};
                for i=1:size(options.truePareto,1);
                    plot(options.truePareto(i,plot_elem.ya), options.truePareto(i,plot_elem.yb),'-or');
                end;
                
                plot(options.goal(1, plot_elem.ya),options.goal(1, plot_elem.yb),'--rs','LineWidth',1,...
                                                                                'MarkerEdgeColor','k',...
                                                                                'MarkerFaceColor','r',...
                                                                                'MarkerSize',5);
                %text(options.goal(1, plot_elem.ya)+0.02,options.goal(1, plot_elem.yb)+0.02,'goal');
                
                plot(options.y0(1, plot_elem.ya),options.y0(1, plot_elem.yb),'--rs','LineWidth',1,...
                                                                                'MarkerEdgeColor','k',...
                                                                                'MarkerFaceColor','g',...
                                                                                'MarkerSize',5);
              %  text(options.goal(1, plot_elem.ya)+0.02,options.goal(1, plot_elem.yb)+0.02,'start');
                
                
                obj=options.objvals;
                parfor i=1:size(obj,1);
                    plot(obj(i, plot_elem.ya),obj(i, plot_elem.yb),'-og');
                    text(obj(i, plot_elem.ya)+0.02,obj(i, plot_elem.yb)+0.02,num2str(i));
                end;
                title('True Pareto front and obtained solutions');
                xlabel(sprintf('f_%d',plot_elem.ya));
                ylabel(sprintf('f_%d',plot_elem.yb));
                    
                                
              end; % end 'steps'
              
              %plot preference information from DM
              if (strcmp(options.plots{p,1},'pref_inf'))||(options.plots{p,2}==14); %plot DM preference information
                  
                          ml={};             
                  switch options.method;
                      case 'GDF'
                          
                            for i0=1:size(options.pref_inf,2);
                                ml{i0}=sprintf('Marginal rate of m_%d',i0);
                            end;
                         
                            
                      case 'WSUM'
                          pos=size(options.pref_inf,2)+1;
                          for i0=1:size(options.pref_inf,1);
                             options.pref_inf(i0,pos)=sum(options.pref_inf(i0,:));
                          end;
                          for i0=1:size(options.pref_inf,2)-1;
                                ml{i0}=sprintf('w_%d',i0);
                          end;
                          ml{end+1}='Sum of Weights';
                         
                      case 'ISWT'
                          ml{1}='Fun number';
                          for i0=1:size(options.pref_inf,2);
                                ml{end+1}=sprintf('Upper value for f_%d',i0);
                          end;
                         
                            
                  end;
                  if size(options.pref_inf,1)==1;
                      options.pref_inf(2,:)=0;
                      bar(options.pref_inf);
                  else
                    bar(options.pref_inf);
                  end;
                  %title('Values of DM`s preference information');
                  xlabel('iterations');
                  ylabel('values of preferences');
                  legend(ml,'Location','best');
                  title(['Values of DM`s preference information',' (',options.method,')']);  
                        
                      
                  
                  
                  drawnow;
                                    
              end;
              
              if (strcmp(options.plots{p,1},'opt_params'))||(options.plots{p,2}==15); %plot DM preference information
                  
                  title({sprintf('Method %s',options.method);...       
                  sprintf('Problem %s',options.problem);...
                  'Decison Maker type MOGA binary-coded';...
                  'MOGA options:';...
                  sprintf('  Lambda share value=%d',options.lambaShare);...
                  sprintf('  Population size=%d',options.popsize);...
                  sprintf('  Generation count=%d',options.gencount);... 
                  sprintf('  Mutation probability=%.2f',options.m_propability);...
                  sprintf('  Genom length=%d',options.gen_length);...
                  sprintf('  Crosspoint=%d',options.crosspoint);...
                  sprintf('  Variable count=%d',options.varcount);...
                  sprintf('Noise of goal %d%%',options.noise);...
                  sprintf('Current goal [%2.3f, %2.3f]',options.goal(1),options.goal(2));...
                  sprintf('Current solution in objectives space [%2.3f, %2.3f]',options.metrics.objvals(end,1),options.metrics.objvals(end,2));...
                  sprintf('Current solution in variable space [%2.3f, %2.3f]',options.x0(1),options.x0(2));...
                  sprintf('Tolerance for objectives= %2.3f',options.Tol);...
                  sprintf('Iterarion number= %d of %d (optional)',options.iter, options.iter_count);...
                  sprintf('Repeat number= %d of %d',options.repeat, options.repeat_count)},'HorizontalAlignment','Left','Position',[0 0 0]);
                  %h = gca;
                  axis (handle,'off');
                  axis (handle,'tight');
              end;
                  
                  
                  
   end;
end;

            
endfunction result=progress_measure(options, g0, g)
%function measure the progress of optimization Progress neasure for single
%and multi-objective problem this function need to run after general
%distance function run


if (isnan(g0))||(isnan(g));
    result=0;
else
    result=log(sqrt(g0/g));
end;

if isnan(result)||isinf(result);
     result=-1;
end;
    
endfunction options=scaled_fitness(options)
%function calculate scaled fitness
scaled_fit=[];
parfor i=1:options.popsize;
    m=find(options.ranks==options.ranks(i));
    s=0;
    for j=1:size(m,1);
        s=s+options.shared_fitness(m(j));
    end;
    scaled_fit(i,1)=(options.avgfitness(i)*size(m,1)/s)*options.shared_fitness(i);
end;

options.scaled_fit=scaled_fit;
endfunction options=selection_op(options)
%function use Stochastic Universal Sampling operator
%first we need to calculate cumulative probability
fit_sum=sum(options.scaled_fit);
parfor i=1:options.popsize;
    prob(i)=options.scaled_fit(i,1)/fit_sum;
end;

parfor i=1:options.popsize;
    s=0;
    for j=1:i;
        s=s+prob(j);
    end;
    cum_probability(i,1)=s;
end;

r=rand(1,1);
N_set(1)=r;

parfor i=1:options.popsize-1;
    N_set(i+1)=r+i/options.popsize;
end;

N_set=mod(N_set,1);

solutions_to_copy=zeros(1,options.popsize);
for i=1:options.popsize;
    [n,j]=min((cum_probability-N_set(i)).^2);
    solutions_to_copy(j)=solutions_to_copy(j)+1;
end;

i=1;
new_popolation={};
while i<=options.popsize;
    for j=1:solutions_to_copy(i);
        new_popolation{end+1}=options.population{i};
    end;
    i=i+1;
end;

options.population=new_popolation;



end
    function options=shared_fitness(options)
% function calculate shared fitness value
parfor i=1:options.popsize;
    shared_fitness(i,1)=options.avgfitness(i)/options.niche_coutv(i);
end;

options.shared_fitness=shared_fitness;
endfunction result=spacing(options)
%function measure the spacing metric. This metric not requre the truePareto
%set.


m=[];
tp=options.truePareto;
y0=options.metrics.objvals;

nn=size(y0,1);

for j=1:nn;
   m(j)=(eucdist(y0(j,:),tp)-generaldist(options))^2;
end;


%{
m=find((options.ranks-1)==0);
yvals=[];

l1=size(m,1);
parfor i=1:l1;
    yvals(i,:)=options.objvals(m(i),:);
end;

d=[];
for i=1:l1; %calculate absolute distance eby every point or solution
    for j=1:l1;
        d(i,j)=sum(abs(yvals(i,:)-yvals(j,:)));
    end;
end;

dm=[];
for i=1:l1; %get minimal distances from point i to others j
    dm(i)=min(d(i,:));
end;

%}       

me=mean(m); %calculate mean value of distances

s=0;
for i=1:nn;
    s=s+(me-m(i))^2;
end;

result=sqrt(s/(nn-1)); % The result is S

if isnan(result)||isinf(result);
     result=-1;
end;

endfunction result=stdgd(options)
%function calculate Standart Deviation from General Distance) measure

m=[];
tp=options.truePareto;
y0=options.metrics.objvals;

nn=size(y0,1);

for j=1:nn;
   m(j)=(eucdist(y0(j,:),tp)-generaldist(options))^2;
end;

result=sum(m)/nn;



%{
m=find((options.ranks-1)==0);
yvals=[];

l1=size(m,1);
parfor i=1:l1;
    yvals(i,:)=options.objvals(m(i),:);
end;

d=[];
for i=1:l1; %calculate absolute distance eby every point or solution
    for j=1:l1;
        if i==j;
            d(i,j)=inf;
        else
            d(i,j)=sum(abs(yvals(i,:)-yvals(j,:)));
        end;
    end;
end;

dm=[];
for i=1:l1; %get minimal distances from point i to others j
    dm(i)=min(d(i,:));
end;

s=0;
for i=1:l1;
    s=s+(dm(i)-generaldist(options))^2;
end;

result=s/l1;

%}
if isnan(result)||isinf(result);
     result=-1;
end;function options=average_fitness(options)
% function calculate the avarage fitness
parfor i=1:options.popsize;
    s=0;
    for j=1:options.ranks(i,1);
        s=s+size(find(options.ranks==(j-1)),1);
    end;
    avgfitness(i,1)=options.popsize-s-0.5*(size(find(options.ranks==options.ranks(i,1)),1)-1);
end;
options.avgfitness=avgfitness;function result=bindecode(gen,mask)
%function represents x values in binary coded string
% variable gen is encoded binary string
% variable mask is gen stucture description
start=mask.startbit;
stop=mask.stopbit;
len=length(gen);
if (stop>len) ||(start<1);
    MException(10,'The stop or start bit is out from gen length',stop,gen);
end;
substr='';
for i=start:stop;
    substr=strcat(substr,gen(i));
end;
int=bin2dec(substr);
len=length(substr);
result=mask.lower+((mask.upper-mask.lower)/((2^len)-1))*int;

endfunction options=crossover(options)
%function realize single-point crossover operator for binary-coded MOGA
%or function realize Bland crossover (BLX-alfa) for real-coded MOGA

%first we need to choose pairs solutions to crossover
pairs=combnk(1:options.popsize,2);
pairs(:,3)=0;
si=size(pairs,1);
new_population={};
i=1;
while size(new_population,2)<=options.popsize;
    if strcmp(options.type,'binary-coded');
        i=round(rand(1)*(size(pairs,1)-1))+1;
        if (pairs(i,3)~=1);
            x1=options.population{pairs(i,1)};
            x2=options.population{pairs(i,2)};
            x11=x1(options.crosspoint:end);
            x22=x2(options.crosspoint:end);
            x1(options.crosspoint:end)=x22;
            %x2(options.crosspoint:end)=x11;
            p=true;
            pairs(i,3)=1;
            new_population{end+1}=x1;
        end;
     else %for real-coded MOGA, the solution need to be x1<x2
       while size(new_population,2)<=options.popsize;
           % i
           % size(new_population,2)
           if (pairs(i,3)==0);
                x1=options.population{pairs(i,1)};
                x2=options.population{pairs(i,2)};
                if sum(x1<x2)~=options.varcount;
                   tmp=x1;
                   x1=x2;
                   x2=tmp;
                end;
                if sum(x1<x2)~=options.varcount;
                   pairs(i,3)=2; 
                else
                   p=true;
                   pairs(i,3)=1;
                   u=rand(1,1);
                   y=(1+2*options.alfa)*u-options.alfa;
                   x1=(1-y).*x1+y.*x2;
                   new_population{end+1}=x1;
                end;
            else %need to detect that no other x1<x2 exists in set pairs
                if size(find(pairs(:,3)==0),1)==0;
                    p=true;
                    k=round(rand(1)*(size(pairs,1)-1))+1;
                    x1=options.population{pairs(k,1)};
                    new_population{end+1}=x1;
                    %'stupid!'
                end;
            end;
            if ((i)<=si-1);
                i=i+1;
            end;
        end;
    end;
end;
    

options.population=new_population;

end
function dom_count=dominance(sol_index, options)
%function calculate dominated solutions by solution of index: sol_index;
dom_count=1;
y=options.objvals(sol_index,1:options.objcount);
parfor i=1:options.popsize;
    s=0;
    f=0;
    if i~=sol_index;
        for j=1:options.objcount;
            if (y(j)>=options.objvals(i,j));
                f=f+1;
            end;

            if (y(j)>options.objvals(i,j));
                s=s+1;
            end;
          end;
    end;

    if (f==options.objcount)&&(s>0);
        dom_count=dom_count+1;
    end;
end;


end

  
            
        
function result=error_ration(options)
%function measure Error Ration for current population MOGA

ranks=(options.ranks-1);
set=find(ranks==0); %result in one column
n=size(set,1); % number of non-dominated solutions


m=[];
e=0;
for i=1:n; %first we need to get all non-dominated solutions from current population
    m=options.objvals(set(i),:); 
    if not(is_member(m,options.truePareto));
        e=e+1;
    end;
end;
    
result=e/n;

if isnan(result)||isinf(result);
     result=-1;
end;

end

function res=is_member(elem, set) %is m member of set truePareto
elem_l=size(elem,2);
set_l=size(set,1);
res=false;
for i=1:set_l;
    s=0;
    for z=1:elem_l;
        if elem(z)==set(i,z);
            s=s+1;
        end;
    end;
    if s==elem_l;
        res=true;
    end;
end;

end




function mdist=eucdist(solution,tset)
%this is measure function General Distance (GD) for MOGA
%function calculate minimal Euclidean distanc between curent solution
%solutios form Tset

for i=1:size(tset,1);
    a=tset(i,:);
    t(i)=sum((solution-a).^2);
end;
mdist=min(t);
    
   
            
function [options,objvals]=eval_objectives(options)
%function calculate values of objectives

%first we need to calculate values of all variables;
xvals=[];
if strcmp(options.type,'binary-coded');
    parfor j=1:options.popsize;
        for i=1:options.varcount;
            mask=options.varmasks{i};
            x(1,i)=bindecode(options.population{j},mask);
        end;
        xvals(j,:)=x;
        x=[];
    end;
    options.varvals=xvals;
else %for real-coded MOGA
    for j=1:options.popsize;
        options.varvals(j,:)=options.population{j};
    end;
end;

%at next we calculate values of all objectives
objvals(1,:)=zeros(1,options.objcount);
for i=1:options.popsize;
    for j=1:options.objcount;
        ostr=[];
        try
        ostr.goal=options.goal;
        ostr.x0=options.x0;
        ostr.problem=options.problem;
        tmp=feval(options.objhandle{j},options.varvals(i,:),ostr);
        catch em
            '======'
            em.message
            em.identifier
            em.stack.line
            em.stack.file
            em.stack.name
            '======='
            
            tmp=feval(options.objhandle{j},options.varvals(i,:));
        end;
        
        if imag(tmp)==0;
            objvals(i,j)=tmp+options.Rmagnitude(j)*eval_constraints(i,options);
        else
            objvals(i,j)=abs(imag(tmp)+real(tmp))+options.Rmagnitude(j)*eval_constraints(i,options);
        end;
    end;
end;


options.objvals=objvals;
end

function penalty=eval_constraints(ind, options)

s=[];
penalty=0;

if (options.in_count>0);
        s=feval(options.in_constr,options.varvals(ind,:));
        parfor j=1:options.in_count;
            if (s(j)<0);
                penal(j)=abs(s(j));
            else
                penal(j)=0;
            end;
        end;
        penalty=sum(penal);
       
   
else
    penalty=0;
end;



if not(isempty(options.eq_constr));
    s=feval(options.eq_constr,options.varvals(ind,:));
    for j=1:size(s,2);
        if s(j)~=0;
            penalty=penalty+abs(s(j));
        end;
    end;
end;

end

function result=generaldist(options)
%function calculates general distance between true Pareto set and
%nondominated solutions in current population
%this function is perormance measure function GD

%ranks=(options.ranks-1);
%set=find(ranks==0); %result in one column
% number of non-dominated solutions

m=[];
tp=options.truePareto;
y0=options.metrics.objvals;

nn=size(y0,1);

parfor j=1:nn;
   m(j)=eucdist(y0(j,:),tp)^2;
end;

%{

gd=0; %deneral distace
for i=1:n;
    euc(i,i)=inf;
    x=euc(i,n+1:end);
    % we need to change i-element value to maximum value, becouse i-element value is 0
    gd=gd+min(x);
end;
%}
result=sqrt(sum(m))/nn;
if isnan(result)||isinf(result);
     result=-1;
end;
endfunction options=inicializeMOEA(str)
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

options.truePareto=[]; %truePareto solution set




if not(strcmp(str,'default'));
    %options.type='real-coded';
    options.type='binary-coded';
    options.gencount=500;
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

endfunction options=inicialize_population(options)
%function inicialize population in random way
if strcmp(options.type,'binary-coded');
    gen='';
    for j=1:options.popsize;
        for i=1:options.gen_length;
            bit=num2str(round(rand(1,1)));
            gen=strcat(gen,bit);    
        end;
        options.population{j}=gen;
        gen='';
    end;
else %for real-coded MOGA
    for j=1:options.popsize;
        gen=[];
        for i=1:options.varcount;
            gen(i)=rand(1,1);
        end;
        options.population{j}=gen;
    end;
end;
endfunction result=max_pareto_err(options)
%function measure the maximumu pareto using truePareto and current pareto
%vectors measure ME


yvals=[];
mi=[];
for i=1:size(options.metrics.objvals,1);
    yvals=options.metrics.objvals(i,:);
    n=[];
    for j=1:size(options.truePareto,1);
        n(j)=sqrt(sum((yvals-options.truePareto(j,:)).^2));
    end;
    mi(i)=min(n);
end;

result=max(mi);
if isnan(result)||isinf(result);
     result=-1;
end;
endfunction options=mutation(options)
%function realize the bit-wise mutation operator for binary-codes and
%random for real-coded MOGA

new_population={};
for i=1:options.popsize;
   
    pos=1;
    a=true;
    gen=options.population{i};
    if strcmp(options.type,'binary-coded'); %for binary-coded MOGA
        while a==true;
            r=rand(1);
            skip=round((-options.m_propability)*log(1-r));
            pos=pos+skip;
            if pos>options.gen_length;
                a=false;
            else
                gen(pos)=int2str(not(str2num(gen(pos))));
            end;
         end;
    else %for real-coded MOGA
        parfor i=1:options.varcount;
            r=rand(1,1);
            b=0.1;
            r1=random('beta',1,1);
            if r1>0.5;
                feta=1;
            else
                feta=-1;
            end;
            gen(1,i)=gen(1,i)+feta*(options.varmasks{i}.upper-options.varmasks{i}.lower)*(1-r^(1-options.gen/options.gencount)^b);
        end;
    end; 
         new_population{end+1}=gen;
end;

options.population=new_population;

end
    
function options=niche_count(options)

%this function uses the normalized distance between two solutions (Deb, page 202)

%minvals=min(options.objvals,[],1);
%maxvals=max(options.objvals,[],1);

%options=update_share(options); %update share value;
niche_coutv=zeros(options.popsize,1);
for i=1:options.popsize;
  rank=options.ranks(i);
  solutions_in_rank=find(options.ranks==rank);
  matrix=zeros(size(solutions_in_rank,1));
  for l=1:size(matrix,1);
      for c=1:size(matrix,2);
          dist=0;
          parfor obj=1:options.objcount;
            dist=dist+((options.objvals(solutions_in_rank(l),obj)-options.objvals(solutions_in_rank(c),obj))/(options.objminmax{obj}.max-options.objminmax{obj}.min))^2;
          end;
          matrix(l,c)=share(sqrt(dist),options.lambaShare);  
      end;
      niche_coutv(solutions_in_rank(l))=sum(matrix(l,:));
   
  end;
end;
options.niche_coutv=niche_coutv;
end
  


function res=share(distance,lambaShare)


if distance<lambaShare;
    res=1-distance/lambaShare;
else
    res=0;
end;
endfunction result=ovng(options)
%function measure non-dominated solution count in population this metric
%name is Overall Nondominated Vector Generation amd Ratio

m=find((options.ranks-1)==0);
result=size(m,1);

if isnan(result)||isinf(result);
     result=-1;
end;
endfunction result=ovngr(options)
%function measure non-dominated solution count in population this metric
%name is Overall Nondominated Vector Generation amd Ratio

m=find((options.ranks-1)==0);
result=size(m,1)/size(options.truePareto,1);
if isnan(result)||isinf(result);
     result=-1;
end;

endfunction handle=plots(options)

last_iteration='-og'; %for last iteration
first_iteration='-ob'; %for first iteration
proc_iteration='-or'; %for run process
selected='-or'; % for best selected from population


x=size(options.plots,1);
n=round(x/2);
m=fix(x/2);

if n>m;
    row=2;
    col=n;
else
    row=n;
    col=2;
end;

if x==1;
    row=1;
    col=1;
end;
    handle=subplot(row,col,1);


for i=1:row;
   for j=1:col;
        for p=1:x; % used selected plots
            subplot(row,col,p);
            %structure that represent plot information
            %options.plots{p,2} - represent plot number
            %options.plots{p,3}- return structure of plot values
            
            if options.gen==1;
                gr_opt=first_iteration;
            elseif options.gen==options.gencount;
                gr_opt=last_iteration;
            else 
                gr_opt=proc_iteration;
            end;
            
            
            
            if (strcmp(options.plots{p,1},'obj'))||(options.plots{p,2}==1); %plot values of objectives {2}-x axis and {3}-y axis
                %example of 'obj' sturcture number Nr.1
                %plot_elem.x -variable number
                %plot_elem.ya -objective number for x axis
                %plot_elem.yb -objective number for y axis
                %title(sprintf('Generation count=%d, Share value=%3.3f',options.gen, options.lambaShare)); 
                indx=options.plots{p,4};
                
                plot_elem=options.plots{p,3};
                
                if plot_elem.x~=0; 
                   xlabel(sprintf('x_%d',plot_elem.x)); 
                   ylabel(sprintf('f_%d',plot_elem.ya)); 
                else
                   xlabel(sprintf('f_%d',plot_elem.ya));
                   ylabel(sprintf('f_%d',plot_elem.yb));
                end;
                hold on;
%                axis([options.objminmax{plot_elem.ya}.min options.objminmax{plot_elem.ya}.max options.objminmax{plot_elem.yb}.min options.objminmax{plot_elem.yb}.max]);
               
                for i=1:options.popsize;
                    
                    if indx==i;
                        gr_opt=selected;
                    else
                        gr_opt=last_iteration;
                    end;
                    
                    hold on;
                    if plot_elem.x~=0; %if only one objective exists
                        plot(options.varvals(i,plot_elem.x),options.objvals(i,plot_elem.ya),gr_opt);
                        drawnow;
                    else
                        plot(options.objvals(i,plot_elem.ya),options.objvals(i,plot_elem.yb),gr_opt);
                        drawnow;
                    end;
                    
                end;
                
                %if options.gen==options.gencount;
                %    if options.truePareto~=size(options.truePareto,1);
                %        parfor i=1:size(options.truePareto,1);
                %            plot(options.truePareto(i,plot_elem.ya),options.truePareto(i,plot_elem.yb),'-or');
                %        end;
                %    end;
                %end;
            end; % end 'obj'

             if (strcmp(options.plots{p,1},'xvals'))||(options.plots{p,2}==2); %plot values of objectives {2}-x axis and {3}-y axis
                %example of 'xvals' sturcture number Nr.2
                %plot_elem.xa -variable number fo x axis
                %plot_elem.xb -variable number for y axis
                %title(sprintf('Generation=%d, Share value=%3.3f',options.gen, options.lambaShare)); 
                plot_elem=options.plots{p,3};
                
                
                xlabel(sprintf('x_%d',plot_elem.xa));
                ylabel(sprintf('x_%d',plot_elem.xb));
                hold on;
                
                
                indx=options.plots{p,4};
                
                parfor i=1:options.popsize;
                    if indx==i;
                        gr_opt=selected;
                    else
                        gr_opt=last_iteration;
                    end;
                    plot(options.varvals(i,plot_elem.xa),options.varvals(i,plot_elem.xb),gr_opt);
                    drawnow; 
                end;

            end; % end 'xvals
            
              if (strcmp(options.plots{p,1},'gd'))||(options.plots{p,2}==3); %plot general distance value for population
                
                title('General Distance (GD)'); 
                xlabel('generation number/iteration');
                ylabel('GD');
                hold on;
                
                plot(options.gendist,'-bs');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                drawnow; 
                
            end; % end 'geberal distance'
            
              if (strcmp(options.plots{p,1},'bestvalue'))||(options.plots{p,2}==4); %plot individuals un print a best solution by scaled fitness
                
                %hold on;
                
                bar(options.scaled_fit','b');
                title(sprintf('Values of Solutions and best value is %d',min(options.scaled_fit))); 
                xlabel('solutios');
                ylabel('values');
                
                drawnow; 
                
              end; % end 'geberal distance'
              
             if (strcmp(options.plots{p,1},'erratio'))||(options.plots{p,2}==5); %plot error ratio
                
                %hold on;
                
                
                plot(options.erratio,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Error Ratio'); 
                xlabel('generation number/iteration');
                ylabel('ER');
                
                drawnow; 
                
              end; % end 'plot error ratio'
              
              if (strcmp(options.plots{p,1},'spacing'))||(options.plots{p,2}==6); %plot error ratio
                
                %hold on;
                
                
                plot(options.spacing,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Spacing'); 
                xlabel('generation number/iteration');
                ylabel('SP');
                
                drawnow; 
                
              end; % end 'spacing'
              
              if (strcmp(options.plots{p,1},'mparerror'))||(options.plots{p,2}==7); %plot error ratio
                
                %hold on;
                
                
                plot(options.mparetoer,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Max Pareto Front Error'); 
                xlabel('generation number/iteration');
                ylabel('ME');
                
                drawnow; 
                
              end; % end 'max pareto front error'
              
              if (strcmp(options.plots{p,1},'ovng'))||(options.plots{p,2}==8); %plot error ratio
                %if options.gen==options.gencount;
                    %hold on;
                    r=[options.ovng(:),options.ovngr(:)];
                    %r=[sum(options.ovng),sum(options.ovngr)];
                    bar(r,'group');
                    title('Overall Nondominated Vector Generation and Ratio'); 
                    legend('OVNG','OVNGR');
                    xlabel('1-ONVG, 2-ONVGR');
                    ylabel('count/value');
                    %                   drawnow; 
                %end;

              end; % end 'Overall Nondominated Vector Generation'
              
              if (strcmp(options.plots{p,1},'waves'))||(options.plots{p,2}==9); %plot error ratio ====reserved for
                
                %hold on;
                
                plot(options.waves,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                axis([0 options.gencount 0 (max(options.waves)+max(options.waves)*0.1)]);
                title('Waves'); 
                xlabel('generation number/iteration');
                ylabel('W');
                
                drawnow; 
                
              end; % end 'Waves'
              
              if (strcmp(options.plots{p,1},'conver'))||(options.plots{p,2}==10); %plot error ratio
                
                hold on;
                plot(options.conver,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Progress measure -absolute convergence'); 
                xlabel('generation number/iteration');
                ylabel('PM');
                
                drawnow; 
                
              end; % end 'Progress measure -absolute convergence'
              
                 if (strcmp(options.plots{p,1},'stdgd'))||(options.plots{p,2}==11); %plot error ratio
                
                hold on;
                plot(options.stdgd,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Standart Deviation from General Distance'); 
                xlabel('generation number/iteration');
                ylabel('STDGD');
                
                drawnow; 
                
              end; % end 'stdgd'
              
              
               if (strcmp(options.plots{p,1},'satisf'))||(options.plots{p,2}==12); %DM satisfacion
                
                hold on;
                plot(options.satisf,'-bs','LineWidth',2,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','r',...
                'MarkerSize',5);
                set(findobj(gca,'Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Euclidean distance from the current solution to the goal'); 
                xlabel('generation number/iteration');
                ylabel('Distance');
                
                drawnow; 
                
              end; % end 'stdgd'
              
               if (strcmp(options.plots{p,1},'steps'))||(options.plots{p,2}==13); %plot error ratio ====reserved for
                
                hold on;
                plot_elem=options.plots{p,3};
                for i=1:size(options.truePareto,1);
                    plot(options.truePareto(i,plot_elem.ya), options.truePareto(i,plot_elem.yb),'-or');
                end;
                
                plot(options.goal(1, plot_elem.ya),options.goal(1, plot_elem.yb),'--rs','LineWidth',1,...
                                                                                'MarkerEdgeColor','k',...
                                                                                'MarkerFaceColor','r',...
                                                                                'MarkerSize',5);
                %text(options.goal(1, plot_elem.ya)+0.02,options.goal(1, plot_elem.yb)+0.02,'goal');
                
                plot(options.y0(1, plot_elem.ya),options.y0(1, plot_elem.yb),'--rs','LineWidth',1,...
                                                                                'MarkerEdgeColor','k',...
                                                                                'MarkerFaceColor','g',...
                                                                                'MarkerSize',5);
              %  text(options.goal(1, plot_elem.ya)+0.02,options.goal(1, plot_elem.yb)+0.02,'start');
                
                
                obj=options.objvals;
                parfor i=1:size(obj,1);
                    plot(obj(i, plot_elem.ya),obj(i, plot_elem.yb),'-og');
                    text(obj(i, plot_elem.ya)+0.02,obj(i, plot_elem.yb)+0.02,num2str(i));
                end;
                title('True Pareto front and obtained solutions');
                xlabel(sprintf('f_%d',plot_elem.ya));
                ylabel(sprintf('f_%d',plot_elem.yb));
                    
                                
              end; % end 'steps'
              
              %plot preference information from DM
              if (strcmp(options.plots{p,1},'pref_inf'))||(options.plots{p,2}==14); %plot DM preference information
                  
                          ml={};             
                  switch options.method;
                      case 'GDF'
                          
                            for i0=1:size(options.pref_inf,2);
                                ml{i0}=sprintf('Marginal rate of m_%d',i0);
                            end;
                         
                            
                      case 'WSUM'
                          pos=size(options.pref_inf,2)+1;
                          for i0=1:size(options.pref_inf,1);
                             options.pref_inf(i0,pos)=sum(options.pref_inf(i0,:));
                          end;
                          for i0=1:size(options.pref_inf,2)-1;
                                ml{i0}=sprintf('w_%d',i0);
                          end;
                          ml{end+1}='Sum of Weights';
                         
                      case 'ISWT'
                          ml{1}='Fun number';
                          for i0=1:size(options.pref_inf,2);
                                ml{end+1}=sprintf('Upper value for f_%d',i0);
                          end;
                         
                            
                  end;
                  if size(options.pref_inf,1)==1;
                      options.pref_inf(2,:)=0;
                      bar(options.pref_inf);
                  else
                    bar(options.pref_inf);
                  end;
                  %title('Values of DM`s preference information');
                  xlabel('iterations');
                  ylabel('values of preferences');
                  legend(ml,'Location','best');
                  title(['Values of DM`s preference information',' (',options.method,')']);  
                        
                      
                  
                  
                  drawnow;
                                    
              end;
              
              if (strcmp(options.plots{p,1},'opt_params'))||(options.plots{p,2}==15); %plot DM preference information
                  
                  title({sprintf('Method %s',options.method);...       
                  sprintf('Problem %s',options.problem);...
                  'Decison Maker type MOGA binary-coded';...
                  'MOGA options:';...
                  sprintf('  Lambda share value=%d',options.lambaShare);...
                  sprintf('  Population size=%d',options.popsize);...
                  sprintf('  Generation count=%d',options.gencount);... 
                  sprintf('  Mutation probability=%.2f',options.m_propability);...
                  sprintf('  Genom length=%d',options.gen_length);...
                  sprintf('  Crosspoint=%d',options.crosspoint);...
                  sprintf('  Variable count=%d',options.varcount);...
                  sprintf('Noise of goal %d%%',options.noise);...
                  sprintf('Current goal [%2.3f, %2.3f]',options.goal(1),options.goal(2));...
                  sprintf('Current solution in objectives space [%2.3f, %2.3f]',options.metrics.objvals(end,1),options.metrics.objvals(end,2));...
                  sprintf('Current solution in variable space [%2.3f, %2.3f]',options.x0(1),options.x0(2));...
                  sprintf('Tolerance for objectives= %2.3f',options.Tol);...
                  sprintf('Iterarion number= %d of %d (optional)',options.iter, options.iter_count);...
                  sprintf('Repeat number= %d of %d',options.repeat, options.repeat_count)},'HorizontalAlignment','Left','Position',[0 0 0]);
                  %h = gca;
                  axis (handle,'off');
                  axis (handle,'tight');
              end;
                  
                  
                  
   end;
end;

            
endfunction result=progress_measure(options, g0, g)
%function measure the progress of optimization Progress neasure for single
%and multi-objective problem this function need to run after general
%distance function run


if (isnan(g0))||(isnan(g));
    result=0;
else
    result=log(sqrt(g0/g));
end;

if isnan(result)||isinf(result);
     result=-1;
end;
    
endfunction options=scaled_fitness(options)
%function calculate scaled fitness
scaled_fit=[];
parfor i=1:options.popsize;
    m=find(options.ranks==options.ranks(i));
    s=0;
    for j=1:size(m,1);
        s=s+options.shared_fitness(m(j));
    end;
    scaled_fit(i,1)=(options.avgfitness(i)*size(m,1)/s)*options.shared_fitness(i);
end;

options.scaled_fit=scaled_fit;
endfunction options=selection_op(options)
%function use Stochastic Universal Sampling operator
%first we need to calculate cumulative probability
fit_sum=sum(options.scaled_fit);
parfor i=1:options.popsize;
    prob(i)=options.scaled_fit(i,1)/fit_sum;
end;

parfor i=1:options.popsize;
    s=0;
    for j=1:i;
        s=s+prob(j);
    end;
    cum_probability(i,1)=s;
end;

r=rand(1,1);
N_set(1)=r;

parfor i=1:options.popsize-1;
    N_set(i+1)=r+i/options.popsize;
end;

N_set=mod(N_set,1);

solutions_to_copy=zeros(1,options.popsize);
for i=1:options.popsize;
    [n,j]=min((cum_probability-N_set(i)).^2);
    solutions_to_copy(j)=solutions_to_copy(j)+1;
end;

i=1;
new_popolation={};
while i<=options.popsize;
    for j=1:solutions_to_copy(i);
        new_popolation{end+1}=options.population{i};
    end;
    i=i+1;
end;

options.population=new_popolation;



end
    function options=shared_fitness(options)
% function calculate shared fitness value
parfor i=1:options.popsize;
    shared_fitness(i,1)=options.avgfitness(i)/options.niche_coutv(i);
end;

options.shared_fitness=shared_fitness;
endfunction result=spacing(options)
%function measure the spacing metric. This metric not requre the truePareto
%set.


m=[];
tp=options.truePareto;
y0=options.metrics.objvals;

nn=size(y0,1);

for j=1:nn;
   m(j)=(eucdist(y0(j,:),tp)-generaldist(options))^2;
end;


%{
m=find((options.ranks-1)==0);
yvals=[];

l1=size(m,1);
parfor i=1:l1;
    yvals(i,:)=options.objvals(m(i),:);
end;

d=[];
for i=1:l1; %calculate absolute distance eby every point or solution
    for j=1:l1;
        d(i,j)=sum(abs(yvals(i,:)-yvals(j,:)));
    end;
end;

dm=[];
for i=1:l1; %get minimal distances from point i to others j
    dm(i)=min(d(i,:));
end;

%}       

me=mean(m); %calculate mean value of distances

s=0;
for i=1:nn;
    s=s+(me-m(i))^2;
end;

result=sqrt(s/(nn-1)); % The result is S

if isnan(result)||isinf(result);
     result=-1;
end;

endfunction result=stdgd(options)
%function calculate Standart Deviation from General Distance) measure

m=[];
tp=options.truePareto;
y0=options.metrics.objvals;

nn=size(y0,1);

for j=1:nn;
   m(j)=(eucdist(y0(j,:),tp)-generaldist(options))^2;
end;

result=sum(m)/nn;



%{
m=find((options.ranks-1)==0);
yvals=[];

l1=size(m,1);
parfor i=1:l1;
    yvals(i,:)=options.objvals(m(i),:);
end;

d=[];
for i=1:l1; %calculate absolute distance eby every point or solution
    for j=1:l1;
        if i==j;
            d(i,j)=inf;
        else
            d(i,j)=sum(abs(yvals(i,:)-yvals(j,:)));
        end;
    end;
end;

dm=[];
for i=1:l1; %get minimal distances from point i to others j
    dm(i)=min(d(i,:));
end;

s=0;
for i=1:l1;
    s=s+(dm(i)-generaldist(options))^2;
end;

result=s/l1;

%}
if isnan(result)||isinf(result);
     result=-1;
end;function options=average_fitness(options)
% function calculate the avarage fitness
parfor i=1:options.popsize;
    s=0;
    for j=1:options.ranks(i,1);
        s=s+size(find(options.ranks==(j-1)),1);
    end;
    avgfitness(i,1)=options.popsize-s-0.5*(size(find(options.ranks==options.ranks(i,1)),1)-1);
end;
options.avgfitness=avgfitness;function [opt, yvals]=testEA(opt)

%opt=inicializeMOEA('user');

opt=inicialize_population(opt);
'Initial values of objectives are:\n'
[opt, yvals]=eval_objectives(opt);
%yvals


%for i=1:size(yvals,1);
    
%    plot(opt.varvals(i,1),yvals(i,1),'-ob');
%    drawnow;
%    hold on;
%end;
%plots(opt);
    
%{
opt.varvals=[0.31 0.89; 
    0.43 1.92;
    0.22 0.56;
    0.59 3.63;
    0.66 1.41;
    0.83 2.51];

opt.objvals=[0.31 6.10;
        0.43 6.79;
        0.22 7.09;
        0.59 7.85;
        0.66 3.65;
        0.83 4.23];
yvals=opt.objvals; 
%}

for i=1:opt.popsize;
    yvals(i,opt.objcount+1)=dominance(i,opt);
    opt.ranks(i,1)=yvals(i,opt.objcount+1);
end;

opt=niche_count(opt);
opt=average_fitness(opt);
opt=shared_fitness(opt);
opt=scaled_fitness(opt);


for i=1:opt.gencount;
    opt.gen=i;
    %opt.erratio(opt.gen)=error_ration(opt); %new
    %opt.gendist(opt.gen)=generaldist(opt); %new
    %opt.spacing(opt.gen)=spacing(opt); % new
    %opt.mparetoer(opt.gen)=max_pareto_err(opt); %new
    %opt.ovng(opt.gen)=ovng(opt); %new
    %opt.ovngr(opt.gen)=ovngr(opt); %new
    %opt.conver(opt.gen)=progress_measure(opt); %new
    %opt.waves(opt.gen)=waves(opt); %new
    %opt.stdgd(opt.gen)=stdgd(opt); %new
    
    opt=selection_op(opt);
    opt=crossover(opt);
    opt=mutation(opt);
    [opt,yvals]=eval_objectives(opt);
    
    %assign ranks for solutions;
    
    for z=1:opt.popsize;
        yvals(z,opt.objcount+1)=dominance(z,opt);
        opt.ranks(z,1)=yvals(z,opt.objcount+1);
    end;
    opt=niche_count(opt);
    opt=average_fitness(opt);
    opt=shared_fitness(opt);
    opt=scaled_fitness(opt);
    %yvals=opt.objvals;
    
   
      %  drawnow;

%    for j=1:size(yvals,1);
%        hold on;
%        plot(opt.varvals(j,1),yvals(j,1),'-or');
%         xlabel(sprintf('Generation %d, share is %3.3f',i, opt.lambaShare)); 
%        drawnow;
    %plots(opt);
   % end;
    
end;
'After optimization values of objectives are:\n'
%yvals=opt.objvals
%for i=1:size(yvals,1);
%    hold on;
%    plot(opt.varvals(i,1),yvals(i,1),'-og');
%    drawnow;
%     xlabel(sprintf('Generation %d',opt.gencount)); 
%end;
%plots(opt);
%s=find(opt.ranks(:,1)==1);
%y1=1.51657
%y2=1.64316

%for i=1:opt.popsize;
%    [xxxx,yyyyy]=geoff_inicialize([2,2],[opt.varvals(i,1), opt.varvals(i,2)]);
%    xxxx
%    [sqrt(xxxx(1)),sqrt(xxxx(2))]
%    plot(sqrt(xxxx(1)),sqrt(xxxx(2)),'-or');
%      hold on;
%end;
  
%plot(y1,y2,'-ob');

endfunction y=test_inquality(x);
y(1)=x(1);
y(2)=x(2);
y(3)=x(1)+x(2)-5;

endfunction test_obj

x=[-10000:1:10000];

y1=x.^2;
y2=(x-2).^3;

plot(y1,y2);


endfunction y=test_objective0(x)
%y=x^2;
y=sqrt(x(1));
endfunction y=test_objective1(x)
%y=(x-2)^2;
y=sqrt(x(2));
endfunction y=test_objective2(w,opt)
%y=(x-2)^2;

%n=w(1);
%w(round(n)+1)=1;

[x1,y]=geoff_inicialize(opt.x0,w, opt.problem);

count=size(opt.goal,2); %count of objectives

if count==2;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2);
end;

if count==3;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2+(y(3)-opt.goal(3))^2);
end;

endfunction y=test_objective3(w,opt)
% this function use penalty function to determine correct information from
% DM
%the main function 1 then w(1)=1;
y=0;
count=size(opt.goal,2);

%w(round(w(1))+1)=1;

if count==3;
    if (w(1)~=1)||(w(2)~=1)||(w(3)~=1);
        y=exp(abs(w(1)+w(2)+w(3)));
    end;
elseif count==2;
    %if not(w(1)~=w(2)&&((w(1)==1)||(w(2)==1)));%not(((w(1)==1)&&(w(2)~=1))||((w(1)~=1)&&(w(2)==1)))
       
    %    y=exp(abs(1-w(1))+abs(1-w(2))+abs(w(1)+w(2)));
    %end;
    if w(1)==w(2);
        y=exp(abs(w(1))+abs(w(2)));
    end;
    if (w(1)~=1)||(w(2)~=1);
       y=y+exp(abs(1-w(1))+abs(1-w(2)));
    end;

    
    
end;

end

function options=update_share(options)

%maxx=max(options.objvals);
%minn=min(options.objvals);
%d=maxx-minn;

%options.lambaShare=sum(d)/(options.popsize-1);
x = fzero(@(x) my_roots(x,options.objcount, max(options.objvals),min(options.objvals),options.popsize),0.1);    
if x==NaN;
    x=0.0000001;
end;
options.lambaShare=x;%0.041;
end

function y=my_roots(x,objs,maxx,minn, N)

s=1;
m=1;
for i=1:objs;
    s=s*(maxx(1,i)-minn(1,i)+x);
    m=m*(maxx(1,i)-minn(1,i));
end;
    
y=((s-m)/x^objs)-N;
end
function result=waves(options)
%function calculate the Max Rank Pareto for PPF, measure function
result=max(options.ranks(:,1));

if isnan(result)||isinf(result);
     result=-1;
end;
end