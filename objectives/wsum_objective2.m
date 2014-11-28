function y=wsum_objective2(arg,opt)
% this function use penalty function to determine correct information from
% DM
%the main function 1 then w(1)=1;

weights=arg; % all weights

if sum(weights)==1;
    y=0;
else
    y=abs(1-sum(weights));
end;

end
