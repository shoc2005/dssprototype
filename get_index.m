function index=get_index(array,value)
for i=1:size(array);
    a=array(i,:);
    if a==value;
        index=i;
    end;
end;