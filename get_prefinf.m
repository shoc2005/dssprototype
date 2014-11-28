function [vals,strvals,all_vals,for_method]=get_prefinf

[method,method_i,problem,funcount, varcount]=get_params;

vri={};
his={};
for_method=[];

switch method_i
    case 1 %GDF
        for i=1:funcount;
            obj_name=['w',num2str(i)];
            vri{1,i}=get(findobj('Tag',obj_name),'String');
            for_method(i)=str2double(vri{1,i});
        end;
        for_method(end+1)=get(findobj('Tag','main_obj'),'Value');
        for_method(end+1)=str2double(get(findobj('Tag','step'),'String'));
        
        vri{1,end+1}=get(findobj('Tag','step'),'String');
        vri{1,get(findobj('Tag','main_obj'),'Value')}='1';
        
        vals=[];
        for i=1:size(vri,2);
            vals(i)=str2double(vri{i});
        end;
        
        
        all_vals=[];
        
        data=get(findobj('Tag','vri'),'Data');
        for i=1:size(data,1);
            for j=1:size(data,2)-1;
                all_vals(i,j)=str2double(data{i,j});
            end;
        end;
    case 2 %ISWT
        
        
        for_method(1)=get(findobj('Tag','main_obj'),'Value');
        for i=1:funcount;
            obj_name=['w',num2str(i)];
            vri{1,i}=get(findobj('Tag',obj_name),'String');
            for_method(end+1)=str2double(vri{1,i});
        end;
         all_vals=[];
         data=get(findobj('Tag','vri'),'Data');
        for i=1:size(data,1);
            for j=1:size(data,2);
                if ~strcmp(data{i,j},'*');
                    all_vals(i,j)=str2double(data{i,j});
                else
                    all_vals(i,j)=1;
                end;
            end;
        end;
         
         vals=[];
        vri{1,get(findobj('Tag','main_obj'),'Value')}='*';
         
    case 3 %WSUM
        for i=1:funcount;
            obj_name=['w',num2str(i)];
            vri{1,i}=get(findobj('Tag',obj_name),'String');
            for_method(i)=str2double(vri{1,i});
        end;
         all_vals=[];
         data=get(findobj('Tag','vri'),'Data');
        for i=1:size(data,1);
            for j=1:size(data,2);
                all_vals(i,j)=str2double(data{i,j});
            end; 
        end;
         
         vals=[];
    case 4 %STEM
        uzlabot=get(findobj('Tag','w1'),'String');
        uzlabot=cellstr(uzlabot);
        pasliktinat=get(findobj('Tag','w2'),'String');
        pasliktinat=cellstr(pasliktinat);
        
        data=get(findobj('Tag','w2'),'UserData');
        e=[];
        e=zeros(1,funcount);
        for i=1:size(pasliktinat,1);
            e(str2num(pasliktinat{i}))=data{1,str2num(pasliktinat{i})};
        end;
        all_vals=[];
        all_vals.uzlabot=cell_to_num(uzlabot);
        all_vals.pasliktinat=cell_to_num(pasliktinat);
        all_vals.e=e;
        
        vri{1}=num2str(cell_to_num(uzlabot));
        vri{2}=num2str(cell_to_num(pasliktinat));
        vri{3}=num2str(all_vals.e);
        vals=[];
        for_method={};
        
    case 5% GUESS
        velamas=[];
        upper=[];
        lower=[];
        for i=1:funcount;
            velamas(end+1)=str2num(get(findobj('Tag',['w',num2str(i)]),'String'));
            upper(end+1)=str2num(get(findobj('Tag',['up',num2str(i)]),'String'))
            lower(end+1)=str2num(get(findobj('Tag',['lo',num2str(i)]),'String'));
        end;
        vri{1}=num2str(upper);
        vri{2}=num2str(lower);
        vri{3}=num2str(velamas);
        all_vals=[];
        all_vals.velamas=velamas;
        all_vals.upper=upper;
        all_vals.lower=lower;
        vals=[];
        for_method=[];
end;

if method_i>=4;
    strvals=vri;
    return;
end;
n=[];
p=size(all_vals,1);
while p~=0;
    n(end+1,:)=all_vals(p,:);
    p=p-1;
end;
all_vals=n;


strvals=vri;






