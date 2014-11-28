function list=get_list(values)

list={};
for i=1:size(values,1);
    str='';
    for j=1:size(values,2);
        if j>1
            str=[str,' '];
        end;
        str=[str,num2str(values(i,j),'%3.3f')];    
    end;
    list{end+1}=str;
end;
    