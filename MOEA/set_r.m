function r=set_r(class,values)
if strcmp(class,'determ'); 
    % calculates r by using normal distribution formula
    %[u,d]=normfit(values);
    %r=normpdf(u, u, d);
    r=mean(values)/sum(values);
else
    r=rand(1,1);
end;
end