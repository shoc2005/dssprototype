function opt=setMethodOptions_ga(method, problem, options)
%for gamultiobj method, 12.12.2010.
% function sets the method initial parameters

opt=problem_init(problem,options);

for i=1:size(opt.y0,2);
    vals={};
    vals.min=min(opt.truePareto(:,i));
    vals.max=max(opt.truePareto(:,i));
    opt.objminmax{end+1}=vals;
end;

switch upper(method);
    case 'ISWT'
        
         
    case 'GDF'
        opt.varcount=size(opt.y0,2)+2; %2={1-step size, 2-main function}
        opt.objcount=2;
        %opt.gen_length=10*opt.varcount;
        %opt.Rmagnitude=ones(1,opt.objcount);
        %opt.crosspoint=opt.gen_length/2-5;
        opt.objhandle=[];%,@gdf_objective3}; % objectives for MOGA algorithm, GDF method executed

        %marginal rates
        for i=1:opt.varcount-2;          
        lo(i)=0.0001;
        up(i)=0.9999;
        end;
        
        %the main function 
        lo(end+1)=1;
        up(end+1)=opt.varcount-2;
             
         %step of GDF
        lo(end+1)=0.0001;
        up(end+1)=1;
        varmasks=[];
        varmasks.lo=lo;
        varmasks.up=up;
        opt.varmasks{1}=varmasks;
        
 
    case {'WSUM','GOALATT'}
                
    case 'GUESS'
        opt.varcount=size(opt.goal,2)*3; %
        opt.objcount=2;
        %opt.gen_length=opt.varcount*10;
        %opt.Rmagnitude=ones(1,opt.objcount);
        %opt.crosspoint=opt.gen_length/2-5;     
        opt.objhandle=[];
        
        opt.varmasks={};
        lo=[];
        up=[];
        start=1;
        for i=1:opt.varcount; %for pref info         
            %e1={}; %
            %e1.startbit=(i-1)*10+1;
            %e1.stopbit=i*10;
            lo(end+1)=opt.ideal(start);
            up(end+1)=opt.znad(start);
            %e1.lower=opt.ideal(start);
            %e1.upper=opt.znad(start);
            start=start+1;
            if start>size(opt.goal,2);
                start=1;
            end;
            %opt.varmasks{end+1}=e1;
            %start=i;
        end;
        varmasks.lo=lo;
        varmasks.up=up;
        opt.varmasks{1}=varmasks;
        
    case 'STEM'
        
        opt.varcount=size(opt.goal,2)*3; %
        opt.objcount=2;
        %opt.gen_length=opt.varcount*10;
        %opt.Rmagnitude=ones(1,opt.objcount);
        %opt.crosspoint=opt.gen_length/2-5;     
        opt.objhandle=[];
        
        opt.varmasks={};
        
        start=1;
        lo=[];
        up=[];
        for i=1:opt.varcount; %for pref info         
            %e1={}; %
            %e1.startbit=(i-1)*10+1;
            %e1.stopbit=i*10;
            if i>=(opt.varcount-size(opt.goal,2))+1;
                lo(end+1)=opt.ideal(start);
                up(end+1)=opt.znad(start);
                %e1.lower=opt.ideal(start);
                %e1.upper=opt.znad(start);
            else
                lo(end+1)=0;
                up(end+1)=size(opt.goal,2);
            end;
            start=start+1;
            if start>size(opt.goal,2);
                start=1;
            end;
            %opt.varmasks{end+1}=e1;
            %start=i;
        end;
        varmasks.lo=lo;
        varmasks.up=up;
        opt.varmasks{1}=varmasks;
        
        
  
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
        







        