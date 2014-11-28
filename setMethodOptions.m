function opt=setMethodOptions(method, problem, options)
% function sets the method initial parameters

opt=problem_init(problem,options);




if strcmp(method,'GDF');
    opt.x0=get(findobj('Tag','curr_x'),'UserData');
    opt.y0=get(findobj('Tag','curr_y'),'UserData');
    opt.goal=get(findobj('Tag','goal_y'),'UserData');
    opt.goalx=get(findobj('Tag','goal_x'),'UserData');
end;

if strcmp(method,'GUESS');
    opt.x0=get(findobj('Tag','curr_x'),'UserData');
    opt.y0=get(findobj('Tag','curr_y'),'UserData');
    opt.goal=get(findobj('Tag','goal_y'),'UserData');
    opt.goalx=get(findobj('Tag','goal_x'),'UserData');
    %{
    cr_cout=size(get(findobj('Tag','goal_y'),'UserData'),2);
    if cr_cout==2;
        opt.goal=[str2num(get(findobj('Tag','w1'),'String')), str2num(get(findobj('Tag','w2'),'String'))];
    elseif cr_cout==3;
        opt.goal=[str2num(get(findobj('Tag','w1'),'String')), str2num(get(findobj('Tag','w2'),'String')), str2num(get(findobj('Tag','w3'),'String'))];
    end;
    opt.goal=get(findobj('Tag','goal_y'),'UserData');
    opt.goalx=get(findobj('Tag','goal_x'),'UserData');
    %}
end;

if strcmp(method,'STEM');
    opt.y0=get(findobj('Tag','curr_y'),'UserData');
    opt.prev=opt.y0;
    opt.x0=get(findobj('Tag','curr_x'),'UserData');
    opt.goal=get(findobj('Tag','goal_y'),'UserData');
    opt.goalx=get(findobj('Tag','goal_x'),'UserData');
end;
opt.bestsolution=[];

new_goal=get(findobj('Tag','new_goal'),'Value');

if (isempty(new_goal)==0);
    if new_goal==2;
        new_goal=[str2num(get(findobj('Tag','g1'),'String')),str2num(get(findobj('Tag','g2'),'String')),str2num(get(findobj('Tag','g3'),'String'))];
         %%opt.goal=get(findobj('Tag','goal_y'),'UserData');
         s=size(opt.goal,2);
         opt.goal=new_goal(1:s);
    end;
end;

for i=1:size(opt.y0,2);
    vals={};
    vals.min=min(opt.truePareto(:,i));
    vals.max=max(opt.truePareto(:,i));
    opt.objminmax{end+1}=vals;
end;

switch upper(method);
    case 'ISWT'
        opt.varcount=size(opt.y0,2)+1; %{1=main function}
        opt.objcount=2;
        opt.gen_length=opt.varcount*10;
        opt.Rmagnitude=ones(1,opt.objcount);
        opt.crosspoint=opt.gen_length/2-5;     
        opt.objhandle={@iswt_objective1,@iswt_objective2};%, @iswt_objective3}; % objectives for MOGA algorithm ISWT method executed
        
        opt.varmasks={};
        mainf={}; %choose the main function 
        mainf.startbit=1;
        mainf.stopbit=10;
        mainf.lower=1;
        mainf.upper=opt.varcount-1;
        opt.varmasks{1}=mainf;
        
        for i=1:opt.varcount-1;          
            e1={}; %variable marginal rate
            e1.startbit=i*10+1;
            e1.stopbit=(i+1)*10;
            e1.lower=min(opt.truePareto(:,i));
            e1.upper=max(opt.truePareto(:,i));
            opt.varmasks{end+1}=e1;
        end;
         
    case 'GDF'
        opt.varcount=size(opt.y0,2)+2; %2={1-step size, 2-main function}
        opt.objcount=2;
        opt.gen_length=10*opt.varcount;
        opt.Rmagnitude=ones(1,opt.objcount);
        opt.crosspoint=opt.gen_length/2-5;
        opt.objhandle={@test_objective2,@test_objective3};%,@gdf_objective3}; % objectives for MOGA algorithm, GDF method executed

        opt.varmasks={};
        for i=1:opt.varcount-2;          
        
            m={}; %variable marginal rate
            m.startbit=(i-1)*10+1;
            m.stopbit=i*10;
            m.lower=0;
            m.upper=0.9999;
            opt.varmasks{end+1}=m;
        end;
 
        mainf=[]; %choose the main function 
        mainf.startbit=(opt.varcount-1)*10-9;
        mainf.stopbit=(opt.varcount-1)*10;
        mainf.lower=1;
        mainf.upper=opt.varcount-2;
        
        step=[]; %choose step of GDF
        step.startbit=opt.varcount*10-9;
        step.stopbit=opt.varcount*10;
        step.lower=0.01;
        step.upper=1;
        
        opt.varmasks{opt.varcount}=step;
        opt.varmasks{opt.varcount-1}=mainf;
        
 
    case {'WSUM','GOALATT'}
        opt.varcount=size(opt.y0,2);
        opt.objcount=2; %prev 3, 11.02.2010. jornal
        opt.gen_length=opt.varcount*10;
        opt.Rmagnitude=[0.3 0.7];%ones(1,opt.objcount);
        opt.crosspoint=opt.gen_length/2-5;
        opt.eq_constr=@wsum_constr;
        opt.objhandle={@wsum_objective1,@wsum_objective2}; %, @wsum_objective3}; % objectives for MOGA algorithm ISWT method executed
        
    
        opt.varmasks={};
        for i=1:opt.varcount;          
        
            w={}; %variable marginal rate
            w.startbit=(i-1)*10+1;
            w.stopbit=i*10;
            w.lower=0.0001;
            w.upper=0.9999;
            opt.varmasks{end+1}=w;
        end;
        
    case 'GUESS'
        opt.varcount=size(opt.goal,2)*3; %
        opt.objcount=2;
        opt.gen_length=opt.varcount*10;
        opt.Rmagnitude=ones(1,opt.objcount);
        opt.crosspoint=opt.gen_length/2;     
        opt.objhandle={@guess_objective2,@guess_objective1};%
        
        opt.varmasks={};
        
        start=1;
        for i=1:opt.varcount; %for pref info         
            e1={}; %
            e1.startbit=(i-1)*10+1;
            e1.stopbit=i*10;
            e1.lower=opt.ideal(start);
            e1.upper=opt.znad(start);
            start=start+1;
            if start>size(opt.goal,2);
                start=1;
            end;
            opt.varmasks{end+1}=e1;
            %start=i;
        end;
        
    case 'STEM'
        
        opt.varcount=size(opt.goal,2)*3; %
        opt.objcount=2;
        varlength=10;
        opt.gen_length=opt.varcount*varlength;
        opt.Rmagnitude=ones(1,opt.objcount);
        opt.crosspoint=opt.gen_length/2;     
        opt.objhandle={@stem_objective1,@stem_objective2};%
        
        opt.varmasks={};
        
        start=1;
        for i=1:opt.varcount; %for pref info         
            e1={}; %
            e1.startbit=(i-1)*varlength+1;
            e1.stopbit=i*varlength;
            if i>=(opt.varcount-size(opt.goal,2))+1;
                e1.lower=opt.ideal(start);
                e1.upper=opt.znad(start);
            else
                e1.lower=0.4;
                e1.upper=0.6;
            end;
            start=start+1;
            if start>size(opt.goal,2);
                start=1;
            end;
            opt.varmasks{end+1}=e1;
            %start=i;
        end;
        
        
  
end;

p.x=0;
p.ya=1;
p.yb=2;

opt.plots{1,1}='obj';
opt.plots{1,2}=1;
opt.plots{1,3}=p;
opt.plots{1,4}=0;

opt.plots{2,1}='satisf';
opt.plots{2,2}=12;
opt.plots{2,3}=[];
        







        