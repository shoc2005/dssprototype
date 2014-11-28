function [r,ten]=tendency(pref_inf)
%r=1 where is tendency and 0 overwice
%ten present tendecy for earch element of pref_inf 
ten=[];
if size(pref_inf,1)<3;
    r=-1;
    return;
end;

plast2=pref_inf(end-1,:)-pref_inf(end-2,:);
plast1=pref_inf(end,:)-pref_inf(end-1,:);


for i=1:size(plast2,2);
    if (plast1(i)>0&&plast2(i)>0)||(plast1(i)<0&&plast2(i)<0)||...
        plast1(i)==0&&plast2(i)==0;
        ten(i)=1;
    else
        ten(i)=0;
    end;
end;

if sum(ten)==size(ten,2);
    r=1;
else
    r=0;
end;
