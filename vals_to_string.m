function str=vals_to_string(vals,prec)

prec=size(num2str(prec),2)-2;

s=size(vals,2);

str='[';
for i=1:s;
    n=sprintf(['%.',num2str(prec),'f'],vals(i));
    %n=num2str(vals(i),3);
    if i<s;
        comma=', ';
    else
        comma='';
    end;
    str=[str,n,comma];
end;

str=[str,']'];
    

