function y=wsum_comfun(x,w,fhandles)
%common function for all problems solved by Weighted sum method
%where fhandles is a handles of objectives, count of objectives is equalent
%with w-weight vector element count

y=0;
for i=1:size(w,2);
    y=y+feval(fhandles{i},x)*w(i);
end;