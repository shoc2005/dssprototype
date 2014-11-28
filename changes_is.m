    function [r3,r1]=changes_is(history,tlength)
        %r=0; %no changes no all
        %r=1; %are changes all
        %r=2; %are changes, but not all
        %r=-1; %cannot analize, tail is too small!
        % r3- all history records without last
        % r1- last history record
        
        
        
                
        if tlength>size(history,1);
            r3=-1;
            'cannot analize, tail is too small!'
            if size(history,1)>=1;
                r1=part_b(history);
            else
                r1=-1;
            end;
            return;
       end;
        
        tlength=tlength-1;
        history=history(end-tlength:end,1:end-1); %check out tails fragments
        
        r3=part_a(history); %all history records without last
        r1=part_b(history); %last history record
      
        
    end
    
    function r=part_a(history)
        partA=history(1:end-1,:);
        if sum(sum(partA))==(size(partA,2)*size(partA,1)); %calculate r3
            r=1;
        elseif sum(sum(partA))==0;
            r=0;
        else
            r=2;
        end;
    end
    
    function r=part_b(history)
        partB=history(end,:);
        if sum(partB)==size(partB,2); %calculate r1
            r=1;
        elseif sum(partB)==0;
            r=0;
        else
            r=2;
        end;
    end