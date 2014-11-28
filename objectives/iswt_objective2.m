function y=iswt_objective2(arg,opt)
% this function use penalty function to determine correct information from
% DM
%the main function 1 then w(1)=1;
y=0;
fnum=arg(1); % arg(1) the number of function to be minimized, from arg(2:..) upper bounds of objectives
fn=round(fnum);
count=size(opt.goal,2);

if (fn<1); 
    y=abs(1-fn);
elseif (fn>count);
    y=abs(fn-count);
end;

end
