function y=test_objective3(w,opt)
% this function use penalty function to determine correct information from
% DM
%the main function 1 then w(1)=1;
y=0;
if w(1)~=1;
    y=exp(abs(w(1)));
end;

e=0.00001;
tol=0.0002;
m=1/sqrt(opt.x0(1)+e);
if (w(2)-m)>tol;
    y=y+exp(abs(w(2)-m));
end;

