function y=wsum_constr(w)
%constration function for MOGA algorithm
y=abs(sum(w)-1);