function handle_axis=show_plots(pr,ll,zd,sdh,sdv,pareto, lppvi,alm, values, len)
% pp=Progresa grafiks
% ll=lauzto lîniju grafiks
% zd=zirnekïa tîkla diagramma
% sdh= stabiòu diagramma (horisintâlâ)
% sdv= stabiòu diagramma (vertikâlâ)
% pareto= Pareto grafiks
% values= kritçriju vârtîbu saraksts (matrica)


apexp_id=get(findobj('Tag','start_problem'),'UserData');
data1=[pareto,pr,ll,sdv,sdh,zd, lppvi,alm];
history_size=size(get(findobj(gcf,'Tag','vri'),'Data'),1);

data2=[apexp_id,history_size];
save_to_db(3, data1,data2);

pos=[];
cam=[];
target=[];

h=findobj('Name','Grafiki');
if h==1;
    pos=get(findobj('Name','Grafiki'),'position');
    a=findobj('Type','axes','UserData','pareto');
    if ~isempty(a);
        cam=get(a,'CameraPosition');
        target=get(a,'CameraTarget');
    end;
%    cam=get(get(findobj('Tag','pareto'),'UserData'),'CameraPosition');
%    target=get(get(findobj('Tag','pareto'),'UserData'),'CameraTarget');
    close(h);
end;


m=pr+ll+zd+sdh+sdv+pareto+lppvi+alm;
if m==0;
    return;
end;




h=figure('Name','Grafiki');
if ~isempty(pos);
    set(findobj('Name','Grafiki'),'position',pos);
    
%    set(get(findobj('Tag','pareto'),'UserData'),'CameraPosition',cam);
%    set(get(findobj('Tag','pareto'),'UserData'),'CameraTarget',target);
end;

if m==2;
    v=2;
    h=1;
elseif m==1;
    v=1;
    h=1;
end;

n=round(m/2);

if n>=2;
    v=2;
    h=n;
end;

list=[pr,ll,zd,sdh,sdv,pareto,lppvi,alm];

pln=1;
for i=1:size(list,2);
    
    if list(i)==1;
        subplot(v,h,pln);
        pln=pln+1;
        switch i;
            case 1
               
                handle=plusminus(values,len);
            case 2
                handle=crashedlines(values,len);     
            case 3
                handle=spiderweb(values,len);
            case 4
                handle=mybar(values,len, 1);
            case 5
                handle=mybar(values,len, 2);
            case 6
                opt=[];
                [method,method_i,problem,funcount, varcount]=get_params;
                opt=problem_init(problem,opt);
                goal=get(findobj('Tag','goal_y'),'UserData');
                goal=goal(1,:);
                start=get(findobj('Tag','start_y'),'UserData');
                start=start(1,:);
                opt.goal=goal
                opt.y0=start
                
                ss=size(values,1);
                if ss>len;
                    opt.objvals=values(end-len+1:end,:);
                else
                    len=size(values,1);
                    opt.objvals=values;
                end;
                
                opt.iter_count=size(get(findobj('Tag','vri'),'Data'),1);
                
                opt.plots={};
                opt.gen=1;
                opt.ref=1;
                
                p=[];
                p.x=0;
                p.ya=1;
                p.yb=2;
                opt.plots{1,1}='steps';
                opt.plots{1,2}=13;
                opt.plots{1,3}=p;
                p1=plots(opt);
                
                set(p1,'UserData','pareto');
                
                a=findobj('Type','axes','UserData','pareto');
                if ~isempty(a)&&~isempty(cam)&&~isempty(target);
                    set(a,'CameraPosition',cam);
                    set(a,'CameraTarget',target);
                end;
            case 7
                opt=[];
                [method,method_i,problem,funcount, varcount]=get_params;
                opt=problem_init(problem,opt);
                opt.objvals=values;
                opt.plots={};
                opt.gen=1;
                opt.ref=1;
                opt.method=method;
                
                opt.plots{1,1}='pref_inf';
                opt.plots{1,2}=14;
                opt.plots{1,3}=[];
                opt.iter_count=size(get(findobj('Tag','vri'),'Data'),1);
                
                             
                %[vals,strvals]=get_prefinf;
                [vals,strvals,all_vals]=get_prefinf;
                
                ss=size(all_vals,1);
               
                if ss>len;
                    opt.pref_inf=all_vals(end-len+1:end,:);      
                else
                    len=size(all_vals,1);
                    opt.pref_inf=all_vals;    
                end;
                 opt.xstick=(ss-len+1:1:ss);
                      
                p1=plots(opt);
                
              
            
            case 8
                opt=[];
                [method,method_i,problem,funcount, varcount]=get_params;
                opt=problem_init(problem,opt);
                opt.objvals=values;
                opt.plots={};
                opt.gen=1;
                opt.ref=1;
                opt.iter_count=size(get(findobj('Tag','vri'),'Data'),1);
                
                sf=get(findobj('Tag','uipanel11'),'UserData');
                
                ss=size(sf,2);
                
                if ss-1>=len;
                    opt.satisf=sf(end-len+1:end);
                    opt.xstick=(ss-len+1:1:ss);
                else
                    len=size(sf,2);
                    opt.satisf=sf;
                     opt.xstick=(ss-len:1:ss-1);
                end;
               
                
                opt.plots{1,1}='satisf';
                opt.plots{1,2}=12;
                opt.plots{1,3}=[];
                
                
                
                p1=plots(opt);
                
                
        end;
    end;
end;

