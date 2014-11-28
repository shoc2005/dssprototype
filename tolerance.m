function [result,why]=tolerance(Tol,satisfvals, taillength)
% function return the stop criteria of search process by using Tolerance
% if changes in satisfvalues are lower than Tol then return=1 else return=0


s=size(satisfvals,2);

%l=mod(s,taillength);

if taillength>s;
    result=0;
    return;
end;

%p=[];
nc=[];
di=[];
tow=[]; %risin�jumi st�v uz vietas

start=s-taillength+1;
for i=start:s-1;
     %p(i)=abs(satisfvals(i)-satisfvals(i+1));
     if satisfvals(i)<satisfvals(i+1);
         nc(end+1)=1; %notiek att�lin��ana
     end;
     
     if satisfvals(i)>satisfvals(i+1);
         tow(end+1)=1;
     end;
     
     di(i)=abs(satisfvals(i)-satisfvals(i+1));
     
     
end;

nc
di

result=0; %continue 
len=taillength-1;

if sum(nc)==len;
    why=2; %att�lin�s no m�r�a
    result=1;
end;

if (abs(min(di)-max(di))<=Tol)&& (sum(nc)~=len)&&(sum(tow)~=len);
    why=1; % risin�jumi st�v uz vietas
    result=1;
end;

if (sum(tow)==len)&&(abs(min(di)-max(di))<=Tol);
    why=8; %kover�ence notiek �oti l�ni;
    result=1;
end;

   




