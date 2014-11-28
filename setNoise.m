function varvals=setNoise(method,noise,varvals)
%goal=opt.goal;

%if rand(1)<0.5;
%    goal=goal-goal*(opt.noise/100);
%else
%    goal=goal+goal*(opt.noise/100);
%end;
%opt.goal=goal;
%if sum(varvals)<1;
%    p=(1-sum(varvals))/size(varvals,2);
%    varvals=varvals+p;
%elseif sum(varvals)>1;
%    p=(sum(varvals)-1)/size(varvals,2);
%    varvals=varvals+p;
%end;



if noise==0;
    return;
end;

noise=noise/100;


switch upper(method);
    case 'ISWT'
        %we need to choose the main function with probality by Noise
        len=size(varvals,2)-1;
        c=round(rand(1)*(len-1)+noise)+1;
        e=varvals;
        p=randn(1);    
        
        if (p>=(0-noise))&&(p<=(0+noise)); %main function normal distribution
            e(1)=c;
        end;
        
        for i=2:len+1;
            %p=randn(1);
            %if (p>=(0-noise))&&(p<=(0+noise)); %correction of e-values by noise level in %
                if rand(1)>=0.5;
                    e(i)=e(i)-e(i)*noise;
                else
                    e(i)=e(i)+e(i)*noise;
                end;
            %end;
        end;
        
        varvals=e;
        
        
    case 'GDF'
        
        len=size(varvals,2)-2;
        c=round(rand(1)*(len-1)+noise)+1;
        e=varvals;
        p=randn(1);    
        
        if (p>=(0-noise))&&(p<=(0+noise)); %main function normal distribution
            e(end-1)=c;
        end;
        
        for i=1:len;
            %p=randn(1);
            %if (p>=(0-noise))&&(p<=(0+noise)); %correction of marginal alues by noise level in %
                if rand(1)>=0.5;
                    e(i)=e(i)-e(i)*noise;
                else
                    e(i)=e(i)+e(i)*noise;
                end;
            %end;
        end;
        
        varvals=e;
        
    case {'WSUM','GOALATT'}
        

        
        %we need to choose the main function with probality by Noise
        len=size(varvals,2);
        c=round(rand(1)*(len-1)+noise)+1;
        w=varvals;
        p=randn(1);    
        to_change=[];
        
        %if (p>=0); %choose the criterion for changes
            to_change(end+1)=c;
        %end;
        
        p=randn(1);    
         if p>=0; %choose the criterion for changes
            way=1;
         else
             way=-1;
         end;
        tolerance=0.01;
        if w(to_change)+noise*way<=tolerance;
            
            noise=(w(to_change)-tolerance);
            w(to_change)=tolerance;
        elseif w(to_change)+noise*way>=1-tolerance;
            
            noise=(1-tolerance)-w(to_change);
            w(to_change)=1-tolerance;
        else
            w(to_change)=w(to_change)+noise*way;
        end;
        
        comp=noise;
        for i=1:len;
            if i~=to_change;
                if w(i)+comp*way*-1>=1-tolerance;
                    
                    comp=comp-(1-tolerance-w(i));
                    w(i)=1-tolerance;
                elseif w(i)+comp*way*-1<=tolerance;
                    
                    comp=comp-(w(i)-tolerance);
                    w(i)=tolerance;
                else
                    w(i)=w(i)+comp*way*-1;
                    break;
                end;
            end;
        end;
                
               
        varvals=round(w.*1000)./1000;
        if sum(varvals)~=1;
            1-sum(varvals)
        end;
         
        
        
end;