function [new_vri,collection]=compensate(collection,last_record)


%perc=init_percent/100; %init %% values changes for IRT
history=collection{1};

tendency=collection{2};
method=collection{3};
percent=collection{4};
vri=collection{5};
prev_record=collection{6};
type=collection{7};
        
percent=percent/100;

s=size(history,1);
new_vri=vri;
if (s==0)&&(type==1);
       return;
end;


switch method
    case 'WSUM'
        
        if type==1;
            [r3,r1]=changes_is(history,1); %check is history empty
            if r3==-1;
                last_record=zeros(1,size(vri,2));
                last_record(1)=1;
            else
                %r=0; %no changes no all
                %r=1; %are changes all
                %r=2; %are changes, but not all
                
                [r3,r1]=changes_is(history,3);
                if r3==-1; %tail is too small
                    if tendency==1; %forward to goal and tail is too small
                        if r1==1||r1==0;
                            last_record=prev_record; %history(end,1:end-1);
                            %last_record(1)=0;
                        elseif r1==2;
                            last_record=history(end,1:end-1);
                        end;
                    else % toward to goal and tail is too small
                        if r1==0;
                            last_record=xor(prev_record, ones(1,size(vri,2)))
                            %last_record(1)=1;
                        elseif r1==2;
                            last_record=history(end,1:end-1);
                            
                        end;
                    end;
                else
                    %r=0; %no changes no all
                    %r=1; %are changes all
                    %r=2; %are changes, but not all
                    if tendency==1; %forward to goal and tail is too small
                        if r1==1;
                            last_record=prev_record;
                            %last_record(1)=0;
                        elseif r1==2;
                            last_record=history(end,1:end-1);
                        elseif r1==0;
                            last_record=xor(prev_record, ones(1,size(vri,2)));
                            
                        end;
                    else % toward to goal and tail is too small
                        if r1==0;
                            last_record=prev_record; %xor(prev_record, ones(1,size(vri,2)));
                            %last_record(1)=1;
                        elseif r1==2;
                            last_record=history(end,1:end-1);
                            
                        end;
                    end;
                end;
                
            end;
        end;
        
        
            %changes of weights
            corrected_w_plus=[]; %list of indeces of corrected weights
            corrected_w_minus=[]; %list of indeces of corrected weights
            
            tolerace=0.025; %1-tol and 0+tol
            %indexes=find(last_record==1);
            count_w=size(vri,2);
            count_w_minus=size(find(last_record==0),2);
            %increase weights
            for i=1:count_w;
                if last_record(i)==1;
                    if vri(i)+percent<(1-sum_of_corrected(corrected_w_plus,new_vri)-tolerace/count_w);
                        new_vri(i)=vri(i)+percent;
                        
                    else
                        new_vri(i)=1-sum_of_corrected(corrected_w_plus,new_vri)-tolerace/count_w_minus;
                        
                    end;
                    corrected_w_plus(end+1)=i;
                end;
            
            end;
            
            %growing weghts
           
            minus=find(last_record==0);
            for i=1:count_w;
                if last_record(i)==0;
                    y=sum_of_corrected(corrected_w_plus,new_vri);
                    x=1-y;
                    step=abs(x-sum_of_corrected(minus,vri));
                    
                    if (vri(i)-step)<(tolerace/count_w_minus);
                        new_vri(i)=tolerace/count_w_minus;
                        step=step-abs(vri(i)-step);
                    else
                        new_vri(i)=vri(i)-step;
                        step=0;
                    end;
                    corrected_w_minus(end+1)=i;
                    if step==0;
                        break;
                    end;
                end;
            end;
            
            if sum(new_vri)~=1;
                error('Summ of weights is not equal to 1');
            end;
              
               
           
            
      % end;
        
        
            
            
            
        
        
        
    
   
    case 'ISWT'
    case 'GDF'
end

main=0;
way=0;
perc=percent;

collection{3}=main;
collection{2}=way;
collection{4}=perc;
collection{5}=last_record;
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

function main=change_main(main,history)
    s=size(history,2);
    if main+1>s;
        main=1;
    else
        main=main+1;
    end;
end
        
        


