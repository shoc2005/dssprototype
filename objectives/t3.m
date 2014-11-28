function [c,eq]=condH1(x);
c=(x(2)-5+0.5*x(1)*sin(4*x(1)))*-1;
eq=[];
endfunction s=diff_fons2(x);
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






function y=gdf_objective3(w,opt)

[x1,y]=geoff_inicialize(opt.x0,w, opt.problem);
options.metrics.objvals=y;
m=load('T1_true.mat');
options.truePareto=m.T1;
y=generaldist(options);
function y=inqualityBinh1(x);
y(1)=-x(1)-5;
y(2)=x(2)-10;
endfunction y=inqualityBinh2(x);
y(1)=(x(1)-10^(-6))*-1;
y(2)=(10^6-x(2))*-1;
endfunction y=inqualityDeb1(x);
y(1)=x(1);
y(2)=x(2);
y(3)=(x(1)-1)*-1;
y(4)=(x(2)-1)*-1;
endfunction y=inqualityH1(x); % all inequalities ...<=0
y(1)=-x(1);
y(2)=-x(2);
y(3)=(x(2)-5+0.5*x(1)*sin(4*x(1)))*-1;

endfunction y=inqualityT1(x);
%y(1)=-x(1);
%y(2)=-x(2);
y(1)=-x(1)-x(2)+5;

endfunction y=iswt_objective1(arg,opt)
%y=(x-2)^2;


fnum=arg(1);
ub=arg(2:end);
count=size(opt.goal,2);

[x1,y]=iswt_inicialize(opt.x0,fnum,ub,opt.problem);

%arg


if count==2;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2);
elseif count==3;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2+(y(3)-opt.goal(3))^2);

end

%1.8348   13.6852    0.7820function y=iswt_objective2(arg,opt)
% this function use penalty function to determine correct information from
% DM
%the main function 1 then w(1)=1;
y=0;
fnum=arg(1); % arg(1) the number of function to be minimized, from arg(2:..) upper bounds of objectives
fn=round(fnum);
count=size(opt.goal,2);

if (fn<1) || (fn>count);
    y=exp(abs(abs(1-fn)+abs(fn-count)));
end;

end
function result=objectiveBinh1_1(x)
%first objective for Binh1 problem (pp226. Veldhuizen)

result=x(1)^2+x(2)^2;

endfunction result=objectiveBinh1_2(x)
%first objective for Binh1 problem (pp226. Veldhuizen)

result=(x(1)-5)^2+(x(2)-5)^2;

endfunction result=objectiveBinh2_1(x)
%binh function Binh(3) 226 (pdf)

result=x(1)-10^6;

end
function result=objectiveBinh2_2(x)
%binh function Binh(3) 226 (pdf)

result=x(2)-2*10^(-6);

end
function result=objectiveBinh2_3(x)
%binh function Binh(3) 226 (pdf)

result=x(1)*x(2)-2;

end
function result=objectiveDeb1_1(x)
%deb non-convex function (198 pp)
result=4*x(1);


function result=ObjectiveDeb1_2(x)
%deb non-convex function (198 pp)
g=1;

if (x(2)>=0) && (x(2)<=0.4);
    g=4-3*exp(-((x(2)-0.2)/0.02)^2);
elseif (x(2)>0.4)&& (x(2)<=1);
    g=4-3*exp(-((x(2)-0.7)/0.2)^2);
end;



B=1;
A=0.25+3.75*(g-1)
f=objectiveDeb1_1(x);
if f<=B*g;
    h=1-(f/(B*g))^A;
else
    h=0;
end;
    
result=h*g;

if ~isreal(result);
    result=0;
end;

function result=objectiveFons1_1(x)
%Fonseca function from Fonseca [111] pp.226

result=1-exp(-((x(1)-1)^2)-((x(2)+1)^2));

endfunction result=objectiveFons1_2(x)
%Fonseca function from Fonseca [111] pp.226

result=1-exp(-((x(1)+1)^2)-((x(2)-1)^2));

endfunction result=objectiveFons2_1(x)
%Fonseca function from Fonseca [111] pp.226

r=0;
n=size(x,2);
for i=1:n;
    r=r+(x(i)-sqrt(n))^2;
end;
result=1-exp(-r);

endfunction result=objectiveFons2_2(x)
%Fonseca function from Fonseca [111] pp.226

r=0;
n=size(x,2);
for i=1:n;
    r=r+(x(i)+sqrt(n))^2;
end;
result=1-exp(-r);

endfunction result=objectiveH1_1(x)
%first objective function for HANNES function H1 or HANNES1

result=x(1);

function result=objectiveH1_2(x)
%second objective function for HANNES function H1 or HANNES1

result=x(2);

function result=objectiveKursaw1(x)
%Fonseca function from Fonseca [111] pp.226

n=size(x,2);
s=0;
for i=1:n-1;
    s=s-10*exp(-0.2*sqrt(x(i)^2+x(i+1)^2));
end;
result=s;

endfunction result=objectiveKursaw2(x)
%Fonseca function from Fonseca [111] pp.226

n=size(x,2);
s=0;
for i=1:n;
    s=s+((abs(x(i))^0.8)+5*(sin(x(i)))^3);
end;
result=s;

endfunction y=objectives(x,x0,w)
%fun={'sqrt(x1)', 'sqrt(x2)'};
%x_var={'x1','x2'};
%version 1;

%for HANN function
%w(w(1)+1)=1;

y=sum(((-w(1)*[(1/(2*x0(1)^(1/2)))*x0(1)*x(1);0])  + (-w(2)*[0;(1/(2*x0(2)^(1/2)))*x0(2)*x(2)]))'.*x);
y=y*-1;

%y=sum(sum(.*x)*w(1)+sum([0,(1/(2*x0(2)^(1/2)))*x0(2)*x(2)].*x)*w(1))*-1;

%y=sum((sum([(1/(2*x0(1)^(1/2)))*x0(1)*x(1),0])*w(1)+sum([0,(1/(2*x0(2)^(1/2)))*x0(2)*x(2)])*w(2)).*x);

%{
for j=1:size(fun,2);
    m={};
    for i=1:size(x_var,2);
        m{i}=diff(fun{j},x_var{i});
    end;
    x1=(point(1));%
    x2=(point(2));%;
    
    for i=1:size(x_var,2);
        m1(i)=eval(m{i});
    end;
    m1=(m1*w(j)).*delta;
        
    y=y+m1;

end;
%
%syms x1 x2;
y=sum(y);
y=y*-1;
%y=eval(y);
%}

end    function y=objectivesBinh1(x,x0,w)


%for Binh1 function
y=sum(((-w(1).*[2*x0(1);2*x0(2)])  + (-w(2).*[2*x0(1)-10;2*x0(2)-10]))'.*x);
y=y*-1;
function y=objectivesBinh2(x,x0,w)


%for Binh2 function
y=sum(((-w(1).*[1;0])+ (-w(2)*[0;1])+(-w(3).*[x0(2);x0(1)]))'.*x);
y=y*-1;
function y=objectivesDeb1(x,x0,w)


%fun={'sqrt(x1)', 'sqrt(x2)'};
%x_var={'x1','x2'};

%for HANN function

if objectiveDeb1_1(x0)<(4-3*exp(-((x0(2)-0.7)/0.02)^2));
    df2=-46.0*x(1)^10.5;
else
    df2=0;
end;
    
    
y=sum(((-w(1).*[4;0])  + (-w(2).*[0;df2]))'.*x);
y=y*-1;
function y=objectivesFons1(x,x0,w)

y=sum(((-w(1).*[(2*x0(1) - 2)*exp(-(x0(1) - 1)^2 -(x0(2) + 1)^2);(2*x0(2) + 2)*exp(-(x0(1) - 1)^2 -(x0(2) + 1)^2)])...
    + (-w(2).*[(2*x0(1) + 2)*exp(-(x0(1) + 1)^2 -(x0(2) - 1)^2);(2*x0(2) - 2)*exp(-(x0(1) + 1)^2-(x0(2) - 1)^2)]))'.*x);
y=y*-1;
function y=objectivesFons2(x,x0,w)

y=sum(((-w(1).*[(2*(x0(1) - 3^(1/2)))/exp((x0(1) - 3^(1/2))^2 + (x0(2) - 3^(1/2))^2 + (x0(3) - 3^(1/2))^2);(2*(x0(2) - 3^(1/2)))/exp((x0(1) - 3^(1/2))^2 + (x0(2) - 3^(1/2))^2 + (x0(3) - 3^(1/2))^2);(2*(x0(3) - 3^(1/2)))/exp((x0(1) - 3^(1/2))^2 + (x0(2) - 3^(1/2))^2 + (x0(3) - 3^(1/2))^2)])...
    + (-w(2).*[(2*(x0(1) + 3^(1/2)))/exp((x0(1) + 3^(1/2))^2 + (x0(2) + 3^(1/2))^2 + (x0(3) + 3^(1/2))^2);(2*(x0(2) + 3^(1/2)))/exp((x0(1) + 3^(1/2))^2 + (x0(2) + 3^(1/2))^2 + (x0(3) + 3^(1/2))^2);(2*(x0(3) + 3^(1/2)))/exp((x0(1) + 3^(1/2))^2 + (x0(2) + 3^(1/2))^2 + (x0(3) + 3^(1/2))^2)]))'.*x);
y=y*-1;
function y=objectivesH1(x,x0,w)


%fun={'sqrt(x1)', 'sqrt(x2)'};
%x_var={'x1','x2'};

%for HANN function
y=sum(((-w(1).*[1*x0(1);0])  + (-w(2).*[0;1*x0(2)]))'.*x);
y=y*-1;
function y=objectivesKursawe(x,x0,w)
%test funtion Kursawe [189], pp.226, Veldhuizen for two variables

y=sum(( (-w(1).*[(2.0*x0(1))/(exp(0.2*(x0(1)^2 + x0(2)^2)^(1/2))*(x0(1)^2 + x0(2)^2)^(1/2));(2.0*x0(2))/(exp(0.2*(x0(1)^2 + x0(2)^2)^(1/2))*(x0(1)^2 + x0(2)^2)^(1/2))])...
    + (-w(2).*[((0.8*sign(x0(1)))/abs(x0(1))^0.2 - 15*cos(x0(1))*(cos(x0(1))^2 - 1));(0.8*sign(x0(2)))/abs(x0(2))^0.2 - 15*cos(x0(2))*(cos(x0(2))^2 - 1)]))'.*x);
y=y*-1;
function y=objectiveT1_1(x)
y=sqrt(abs(x(1)));

end

%fun={'sqrt(x1)', 'sqrt(x2)'};
%x_var={'x1','x2'};function y=objectiveT1_2(x)
y=sqrt(abs(x(2)));

endfunction [c,eq]=condH1(x);
c=(x(2)-5+0.5*x(1)*sin(4*x(1)))*-1;
eq=[];
endfunction s=diff_fons2(x);
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






function y=gdf_objective3(w,opt)

[x1,y]=geoff_inicialize(opt.x0,w, opt.problem);
options.metrics.objvals=y;
m=load('T1_true.mat');
options.truePareto=m.T1;
y=generaldist(options);
function y=inqualityBinh1(x);
y(1)=-x(1)-5;
y(2)=x(2)-10;
endfunction y=inqualityBinh2(x);
y(1)=(x(1)-10^(-6))*-1;
y(2)=(10^6-x(2))*-1;
endfunction y=inqualityDeb1(x);
y(1)=x(1);
y(2)=x(2);
y(3)=(x(1)-1)*-1;
y(4)=(x(2)-1)*-1;
endfunction y=inqualityH1(x); % all inequalities ...<=0
y(1)=-x(1);
y(2)=-x(2);
y(3)=(x(2)-5+0.5*x(1)*sin(4*x(1)))*-1;

endfunction y=inqualityT1(x);
%y(1)=-x(1);
%y(2)=-x(2);
y(1)=-x(1)-x(2)+5;

endfunction y=iswt_objective1(arg,opt)
%y=(x-2)^2;


fnum=arg(1);
ub=arg(2:end);
count=size(opt.goal,2);

[x1,y]=iswt_inicialize(opt.x0,fnum,ub,opt.problem);

%arg


if count==2;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2);
elseif count==3;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2+(y(3)-opt.goal(3))^2);

end

%1.8348   13.6852    0.7820function y=iswt_objective2(arg,opt)
% this function use penalty function to determine correct information from
% DM
%the main function 1 then w(1)=1;
y=0;
fnum=arg(1); % arg(1) the number of function to be minimized, from arg(2:..) upper bounds of objectives
fn=round(fnum);
count=size(opt.goal,2);

if (fn<1) || (fn>count);
    y=exp(abs(abs(1-fn)+abs(fn-count)));
end;

end
function result=objectiveBinh1_1(x)
%first objective for Binh1 problem (pp226. Veldhuizen)

result=x(1)^2+x(2)^2;

endfunction result=objectiveBinh1_2(x)
%first objective for Binh1 problem (pp226. Veldhuizen)

result=(x(1)-5)^2+(x(2)-5)^2;

endfunction result=objectiveBinh2_1(x)
%binh function Binh(3) 226 (pdf)

result=x(1)-10^6;

end
function result=objectiveBinh2_2(x)
%binh function Binh(3) 226 (pdf)

result=x(2)-2*10^(-6);

end
function result=objectiveBinh2_3(x)
%binh function Binh(3) 226 (pdf)

result=x(1)*x(2)-2;

end
function result=objectiveDeb1_1(x)
%deb non-convex function (198 pp)
result=4*x(1);


function result=ObjectiveDeb1_2(x)
%deb non-convex function (198 pp)
g=1;

if (x(2)>=0) && (x(2)<=0.4);
    g=4-3*exp(-((x(2)-0.2)/0.02)^2);
elseif (x(2)>0.4)&& (x(2)<=1);
    g=4-3*exp(-((x(2)-0.7)/0.2)^2);
end;



B=1;
A=0.25+3.75*(g-1)
f=objectiveDeb1_1(x);
if f<=B*g;
    h=1-(f/(B*g))^A;
else
    h=0;
end;
    
result=h*g;

if ~isreal(result);
    result=0;
end;

function result=objectiveFons1_1(x)
%Fonseca function from Fonseca [111] pp.226

result=1-exp(-((x(1)-1)^2)-((x(2)+1)^2));

endfunction result=objectiveFons1_2(x)
%Fonseca function from Fonseca [111] pp.226

result=1-exp(-((x(1)+1)^2)-((x(2)-1)^2));

endfunction result=objectiveFons2_1(x)
%Fonseca function from Fonseca [111] pp.226

r=0;
n=size(x,2);
for i=1:n;
    r=r+(x(i)-sqrt(n))^2;
end;
result=1-exp(-r);

endfunction result=objectiveFons2_2(x)
%Fonseca function from Fonseca [111] pp.226

r=0;
n=size(x,2);
for i=1:n;
    r=r+(x(i)+sqrt(n))^2;
end;
result=1-exp(-r);

endfunction result=objectiveH1_1(x)
%first objective function for HANNES function H1 or HANNES1

result=x(1);

function result=objectiveH1_2(x)
%second objective function for HANNES function H1 or HANNES1

result=x(2);

function result=objectiveKursaw1(x)
%Fonseca function from Fonseca [111] pp.226

n=size(x,2);
s=0;
for i=1:n-1;
    s=s-10*exp(-0.2*sqrt(x(i)^2+x(i+1)^2));
end;
result=s;

endfunction result=objectiveKursaw2(x)
%Fonseca function from Fonseca [111] pp.226

n=size(x,2);
s=0;
for i=1:n;
    s=s+((abs(x(i))^0.8)+5*(sin(x(i)))^3);
end;
result=s;

endfunction y=objectives(x,x0,w)
%fun={'sqrt(x1)', 'sqrt(x2)'};
%x_var={'x1','x2'};
%version 1;

%for HANN function
%w(w(1)+1)=1;

y=sum(((-w(1)*[(1/(2*x0(1)^(1/2)))*x0(1)*x(1);0])  + (-w(2)*[0;(1/(2*x0(2)^(1/2)))*x0(2)*x(2)]))'.*x);
y=y*-1;

%y=sum(sum(.*x)*w(1)+sum([0,(1/(2*x0(2)^(1/2)))*x0(2)*x(2)].*x)*w(1))*-1;

%y=sum((sum([(1/(2*x0(1)^(1/2)))*x0(1)*x(1),0])*w(1)+sum([0,(1/(2*x0(2)^(1/2)))*x0(2)*x(2)])*w(2)).*x);

%{
for j=1:size(fun,2);
    m={};
    for i=1:size(x_var,2);
        m{i}=diff(fun{j},x_var{i});
    end;
    x1=(point(1));%
    x2=(point(2));%;
    
    for i=1:size(x_var,2);
        m1(i)=eval(m{i});
    end;
    m1=(m1*w(j)).*delta;
        
    y=y+m1;

end;
%
%syms x1 x2;
y=sum(y);
y=y*-1;
%y=eval(y);
%}

end    function y=objectivesBinh1(x,x0,w)


%for Binh1 function
y=sum(((-w(1).*[2*x0(1);2*x0(2)])  + (-w(2).*[2*x0(1)-10;2*x0(2)-10]))'.*x);
y=y*-1;
function y=objectivesBinh2(x,x0,w)


%for Binh2 function
y=sum(((-w(1).*[1;0])+ (-w(2)*[0;1])+(-w(3).*[x0(2);x0(1)]))'.*x);
y=y*-1;
function y=objectivesDeb1(x,x0,w)


%fun={'sqrt(x1)', 'sqrt(x2)'};
%x_var={'x1','x2'};

%for HANN function

if objectiveDeb1_1(x0)<(4-3*exp(-((x0(2)-0.7)/0.02)^2));
    df2=-46.0*x(1)^10.5;
else
    df2=0;
end;
    
    
y=sum(((-w(1).*[4;0])  + (-w(2).*[0;df2]))'.*x);
y=y*-1;
function y=objectivesFons1(x,x0,w)

y=sum(((-w(1).*[(2*x0(1) - 2)*exp(-(x0(1) - 1)^2 -(x0(2) + 1)^2);(2*x0(2) + 2)*exp(-(x0(1) - 1)^2 -(x0(2) + 1)^2)])...
    + (-w(2).*[(2*x0(1) + 2)*exp(-(x0(1) + 1)^2 -(x0(2) - 1)^2);(2*x0(2) - 2)*exp(-(x0(1) + 1)^2-(x0(2) - 1)^2)]))'.*x);
y=y*-1;
function y=objectivesFons2(x,x0,w)

y=sum(((-w(1).*[(2*(x0(1) - 3^(1/2)))/exp((x0(1) - 3^(1/2))^2 + (x0(2) - 3^(1/2))^2 + (x0(3) - 3^(1/2))^2);(2*(x0(2) - 3^(1/2)))/exp((x0(1) - 3^(1/2))^2 + (x0(2) - 3^(1/2))^2 + (x0(3) - 3^(1/2))^2);(2*(x0(3) - 3^(1/2)))/exp((x0(1) - 3^(1/2))^2 + (x0(2) - 3^(1/2))^2 + (x0(3) - 3^(1/2))^2)])...
    + (-w(2).*[(2*(x0(1) + 3^(1/2)))/exp((x0(1) + 3^(1/2))^2 + (x0(2) + 3^(1/2))^2 + (x0(3) + 3^(1/2))^2);(2*(x0(2) + 3^(1/2)))/exp((x0(1) + 3^(1/2))^2 + (x0(2) + 3^(1/2))^2 + (x0(3) + 3^(1/2))^2);(2*(x0(3) + 3^(1/2)))/exp((x0(1) + 3^(1/2))^2 + (x0(2) + 3^(1/2))^2 + (x0(3) + 3^(1/2))^2)]))'.*x);
y=y*-1;
function y=objectivesH1(x,x0,w)


%fun={'sqrt(x1)', 'sqrt(x2)'};
%x_var={'x1','x2'};

%for HANN function
y=sum(((-w(1).*[1*x0(1);0])  + (-w(2).*[0;1*x0(2)]))'.*x);
y=y*-1;
function y=objectivesKursawe(x,x0,w)
%test funtion Kursawe [189], pp.226, Veldhuizen for two variables

y=sum(( (-w(1).*[(2.0*x0(1))/(exp(0.2*(x0(1)^2 + x0(2)^2)^(1/2))*(x0(1)^2 + x0(2)^2)^(1/2));(2.0*x0(2))/(exp(0.2*(x0(1)^2 + x0(2)^2)^(1/2))*(x0(1)^2 + x0(2)^2)^(1/2))])...
    + (-w(2).*[((0.8*sign(x0(1)))/abs(x0(1))^0.2 - 15*cos(x0(1))*(cos(x0(1))^2 - 1));(0.8*sign(x0(2)))/abs(x0(2))^0.2 - 15*cos(x0(2))*(cos(x0(2))^2 - 1)]))'.*x);
y=y*-1;
function y=objectiveT1_1(x)
y=sqrt(abs(x(1)));

end

%fun={'sqrt(x1)', 'sqrt(x2)'};
%x_var={'x1','x2'};function y=objectiveT1_2(x)
y=sqrt(abs(x(2)));

endfunction [c,eq]=condH1(x);
c=(x(2)-5+0.5*x(1)*sin(4*x(1)))*-1;
eq=[];
endfunction s=diff_fons2(x);
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
    function y=test_objective0(x)
%y=x^2;
y=sqrt(x(1));
endfunction y=test_objective1(x)
%y=(x-2)^2;
y=sqrt(x(2));
endfunction y=test_objective2(w,opt)
%y=(x-2)^2;

[x1,y]=geoff_inicialize(opt.x0,w,opt.problem);
y=sqrt(sum((y-opt.goal).^2));

endfunction y=test_objective3(w,opt)
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

function y=wsum_objective1(arg,opt)
%y=(x-2)^2;

weights=arg;

count=size(opt.goal,2);

[x1,y]=wsum_inicialize(opt.x0,weights,opt.problem);


if count==2;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2);
elseif count==3;
    y=sqrt((y(1)-opt.goal(1))^2+(y(2)-opt.goal(2))^2+(y(3)-opt.goal(3))^2);

endfunction y=wsum_objective2(arg,opt)
% this function use penalty function to determine correct information from
% DM
%the main function 1 then w(1)=1;

weights=arg; % all weights

if sum(weights)==1;
    y=0;
else
    y=exp(1-sum(weights));
end;

end
