function [options,objvals]=eval_objectives(options)
%function calculate values of objectives

%first we need to calculate values of all variables;
xvals=[];
if strcmp(options.type,'binary-coded');
    parfor j=1:options.popsize;
        x=[];
        for i=1:options.varcount;
            mask=options.varmasks{i};
            x(1,i)=bindecode(options.population{j},mask);
        end;
        xvals(j,:)=x;
        
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
        ostr.prev=options.y0;
        ostr.problem=options.problem;
        ostr.ideal=options.ideal;
        ostr.znad=options.znad;
        ostr.iter=options.iter;
        
        tmp=feval(options.objhandle{j},options.varvals(i,:),ostr);
        catch em
           % '======'
           em.message
           % em.identifier
           % em.stack.line
           % em.stack.file
           % em.stack.name
           % '======='
            
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

