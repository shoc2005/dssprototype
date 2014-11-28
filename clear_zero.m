function res=clear_zero(my_set)
res=[];
for i=1:size(my_set,2);
    if my_set(i)~=0;
       res(end+1)=my_set(i);
    end;
end;