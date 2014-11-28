function new_vri=compensate_new(vri, last_record)
%for WSUM method mainly

method='WSUM';
new_vri=vri;

switch method
    case 'WSUM'

        
        
            %changes of weights
            corrected_w_plus=[]; %list of indeces of corrected weights
            corrected_w_minus=[]; %list of indeces of corrected weights
            percent=0.15; %of changes.
            tolerace=0.025; %1-tol and 0+tol
            %indexes=find(last_record==1);
            count_w=size(vri,2);
            count_w_minus=size(find(last_record==0),2);
            %new_vri=[];
            %increase weights
            for i=1:count_w;
                if last_record(i)==1;
                    if vri(i)+percent<(1-sum_of_corrected(corrected_w_plus,new_vri)-tolerace);
                        new_vri(i)=vri(i)+percent;
                        
                    else
                        new_vri(i)=1-sum_of_corrected(corrected_w_plus,new_vri)-tolerace;
                        
                    end;
                    corrected_w_plus(end+1)=i;
                end;
            
            end;
            
            %growing weghts
           
            minus=find(last_record==0);
            %step=abs(x-sum_of_corrected(minus,vri));
            y=sum_of_corrected(corrected_w_plus,new_vri);
            x=1-y;
            step=abs(x-sum_of_corrected(corrected_w_minus,new_vri));
                                
            if size(minus,2)==1;
                new_vri(minus(1))=step;
                return;
            end;
            for i=1:count_w;
                if last_record(i)==0;
                    
                    
                    
                    if (vri(i)-step)<(tolerace);
                        new_vri(i)=tolerace;
                        step=abs(vri(i)-step)+tolerace;
                    else
                        new_vri(i)=vri(i)-step;
                        %step=0;
                    end;
                    %corrected_w_minus(end+1)=i;
                    if step==0;
                        break;
                    end;
                end;
            end;
            
            new_vri=round(new_vri*1000)/1000;
            if sum(new_vri)~=1;
                error('Summ of weights is not equal to 1');
            end;

    case 'ISWT'
    case 'GDF'
end

end


function summ=sum_of_corrected(indexes,vri)
    summ=0;
    for i=1:size(indexes,2);
        summ=summ+vri(indexes(i));
    end;
end


function [irt,way]=compensate_irt(irt,perc,main,way)

    obj_count=size(irt,2);
    
    
    s=size(irt,2)-1;
    if (irt(main)+irt(main)*perc*way)>1-(0.01*(s+1));
        way=way*-1;
    end;


    changes_size=irt(main)*perc;
    new_val=irt(main)+changes_size*way;
    changes_kvant=changes_size/(size(irt,2)-1);
    
    if (new_val>0&&new_val<1);
        for i=1:size(irt,2);
        end;
    end;
            
    
    irt(main)=irt(main)+irt(main)*perc*way;

    for i=1:size(irt,2);
        if i~=main;
            irt(i)=irt(i)+(changes_size/s)*(way*(-1));
        end;

    end;
   
    
    
    
end