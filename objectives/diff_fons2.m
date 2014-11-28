function s=diff_fons2(x);
%this function is needed for evaluatio the differentials for Fonseca
%function [109], pp.226.

% example diff_fons2({'x01','x02','x03'})

syms r result_f1 result_f2;

n=size(x,2);
for i=1:n;
    c=x{i};
    eval(['syms ',c]);
    r=r+(eval(x{i})-sqrt(n))^2;
end;

result_f1=1-exp(-r);

clear r;
syms r;
for i=1:n;
    c=x{i};
    eval(['syms ',c]);
    r=r+(eval(x{i})+sqrt(n))^2;
end;

result_f2=1-exp(-r);

res={result_f1,result_f2};

s={};
for i=1:2; % only two objectives
    for j=1:n; % n variables
        s{j,i}=simplify(diff(res{i},x{j}));
    end;
end;


%{ 
result for 3 variables
==1
%for first objective by diff by x1
(2*(x01 - 3^(1/2)))/exp((x01 - 3^(1/2))^2 + (x02 - 3^(1/2))^2 + (x03 - 3^(1/2))^2)

%for first objective by diff by x2
(2*(x02 - 3^(1/2)))/exp((x01 - 3^(1/2))^2 + (x02 - 3^(1/2))^2 + (x03 - 3^(1/2))^2)

%for first objective by diff by x3
(2*(x03 - 3^(1/2)))/exp((x01 - 3^(1/2))^2 + (x02 - 3^(1/2))^2 + (x03 - 3^(1/2))^2)

===2
%for second objective by diff by x1
(2*(x01 + 3^(1/2)))/exp((x01 + 3^(1/2))^2 + (x02 + 3^(1/2))^2 + (x03 + 3^(1/2))^2)

%for second objective by diff by x2
(2*(x02 + 3^(1/2)))/exp((x01 + 3^(1/2))^2 + (x02 + 3^(1/2))^2 + (x03 + 3^(1/2))^2)

%for second objective by diff by x3
(2*(x03 + 3^(1/2)))/exp((x01 + 3^(1/2))^2 + (x02 + 3^(1/2))^2 + (x03 + 3^(1/2))^2)






