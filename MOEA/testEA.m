function [opt, yvals]=testEA(opt)

%opt=inicializeMOEA('user');

opt=inicialize_population(opt); %random configuration for sthohastic or deterministic using 1010101 shema
'Initial values of objectives are:\n'
[opt, yvals]=eval_objectives(opt); 
%opt.objvals=normc(opt.objvals);
%yvalsdist
dist=inf;
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

i=1;
while (i<=opt.gencount)%;||((opt.objvals(select_solution(opt),2)>0.5)&&(i>=opt.gencount));
%for i=1:opt.gencount; //TESTING new IdeA 11.02.2010. jornal
    tic
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
    
    opt=selection_op(opt); %random Stohastic operator or Deterministic based on Normal distribution using cumulative propability
    opt=crossover(opt); %random side or Determ based on Normal distribution using ranks
    opt=mutation(opt); %random mutation or zero
    [opt,yvals]=eval_objectives(opt);
%    opt.objvals=normc(opt.objvals);
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
    i=i+1;
    opt.mean(i)=mad(opt.objvals(:,2),0);
    normobj=opt.objvals; %normc(opt.objvals);
    f1mn=[min(normobj(:,1)),max(normobj(:,1))];
    f2mn=[min(normobj(:,2)),max(normobj(:,2))];
    opt.lambaShare=(f2mn(2)-f2mn(1)+f1mn(2)-f1mn(1))/(opt.popsize-1);
    if isnan(opt.lambaShare);
        opt.lambaShare=0.3;
    end;
    
    ts=toc;
    set(findobj('Tag','cptime'),'String',sprintf('%1.2f',ts));
    set(findobj('Tag','cpop'),'String',[num2str(i-1),'/',get(findobj('Tag','pop_count'),'String')]);
    prog_time=str2num(get(findobj('Tag','pop_count'),'String'))*ts;
    set(findobj('Tag','aproxtime'),'String',sprintf('%5.0f',prog_time));
    set(findobj('Tag','rem'),'String',sprintf('%5.0f',prog_time-ts*(i-1)));
    
    
    index=select_solution(opt);
    
    %dist=opt.objvals(index,1);
    if index>0
        if opt.objvals(index,1)<dist;
            %opt.selected_index=index;
            if opt.objvals(index,1)<1;
                opt.objvals(index,1)
                opt
            end;
            opt.bestsolution=opt.varvals(index,:);
            dist=opt.objvals(index,1);
            set(findobj('Tag','dist_g'),'String',num2str(dist,2));
        end;
    end;
    
    figure(gcf);
    br=get(findobj('Tag','enableEA'),'UserData');
    if br==0;
        break;
    end;
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
%opt.cgencount=i;
end