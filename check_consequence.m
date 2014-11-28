function [res,diagnoze]=check_consequence(satisfy, pref_inf, method)
%%T1==forward to the goal
%%T1.1=increase step
%%T1.2=continue increasing preference importance
%%T1.3=continue process without preference inf. changes

%%T2==toward to the goal
%%T2.1=change the priorities of objectives
%%T2.2=return to previouse preference information values

%%T3==solutions stand on 
%%T3.1=T1.1
%%T3.2=T1.2
%%T3.3=T2.1

%%pref_type=1 are weights (WSUM)
%%pref_type=2 are e-constraints (ISWT)
%%pref_type=3 are marginal (GDF)
res=0;
if size(pref_inf,1)<3; %proverka iteracii>=2
    return;
end;

diagnoze=[];
diagnoze.method=method;
diagnoze.foward=-1; %forward to the goal: yes=1/no=0;
diagnoze.toward=-1; %torward from the goal: yes=1/no=0;
diagnoze.stayon=-1; %stay on point: yes=1/no=0
diagnoze.inc_step=-1;%increase step, yes=1/no=0
diagnoze.inc_imp=-1; %increase importance, yes=1/no=1
diagnoze.changes=-1; %changes for pref_inf, yes=1/no=1
diagnoze.priority=-1; %changes of objective priority
diagnoze.tendency=-1; % tendency of changes

%reshenija priblizhajutsja k celevim
pr_infc=pref_inf(end);
pr_infp=pref_inf(end-1);

if satisfy(end)<satisfy(end-1);
    diagnoze.foward=1;
    diagnoze.toward=0;
    diagnoze.stayon=0;
elseif satisfy(end)==satisfy(end-1);
    diagnoze.foward=0;
    diagnoze.toward=0;
    diagnoze.stayon=1;
else
    diagnoze.foward=0;
    diagnoze.toward=1;
    diagnoze.stayon=0;
end;
    
  
    switch method
        %check for step size increasing
        case 'ISWT' %varvals(1),varvals(2:end)
            if pr_infc(1)==pr_infp(1);
                diagnoze.priority=0;
            else
                diagnoze.priority=1;
            end;
               
            imp=pr_infc(2:end)-pr_infp(2:end);
            
        
            
        case 'GDF' %varvals
            if pr_infc(end)>pr_infp(end);
                diagnoze.inc_step=1;
            else
                diagnoze.inc_step=0; 
            end;
            
            if pr_infc(end)==pr_infp(end);
                diagnoze.priority=0;
            else
                diagnoze.priority=1; 
            end;
            
            imp=pr_infc(1:end-2)-pr_infp(1:end-2);
            
            
        case {'WSUM','GOALATT'} %varvals
            [mc,ic]=max(pr_infc);
            [mp,ip]=max(pr_infp);
            if ic==ip;
                diagnoze.priority=0;
            else
                diagnoze.priority=1;
            end;
            
            imp=pr_infc-pr_infp;
            
            %check tendency
            [r,ten]=tendency(pref_inf);
            diagnoze.tentency=r;
            
                
    end;

    
    if (sum(imp<0)==0)&&(sum(imp>0)>0);
        diagnoze.inc_imp=1;
    else
        diagnoze.inc_imp=0;
    end;
    
    if sum(imp==0)==0;
        diagnoze.changes=0;
    else
        diagnoze.changes=1;
    end;
    
    
    if (diagnoze.foward==1);
        if (diagnoze.priority==0&&(diagnoze.inc_step==1||diagnoze.inc_imp==1||diagnoze.changes==0||diagnoze.inc_imp==0));
            res=0;
        else
            res=1;
        end;
        
        
        if strcmp(method,'WSUM')||strcmp(method,'GOALATT');
            if (diagnoze.tendency==-1||diagnoze.tendency==1);
                res=0;
            else
                res=1;
            end;
        end;
        
    end;
    
    if (diagnoze.toward==1);
        if (diagnoze.priority==1)&&(diagnoze.inc_step==1||diagnoze.changes==1);
            res=0;
        else
            res=1;
        end;
        
        if strcmp(method,'WSUM')||strcmp(method,'GOALATT');
            if (diagnoze.tendency==-1||diagnoze.tendency==0);
                res=0;
            else
                res=1;
            end;
        end;
        
    end;
    
    if (diagnoze.stayon==1);
        if (diagnoze.priority==1||diagnoze.inc_step==1||diagnoze.changes==1);
            res=0;
        else
            res=1;
        end;
        
        
        if strcmp(method,'WSUM')||strcmp(method,'GOALATT');
            if (diagnoze.tendency==-1||diagnoze.tendency==0);
                res=0;
            else
                res=1;
            end;
        end;
    end;




