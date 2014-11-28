function [x1,y1,pareto]=geoffrion

x0=[2.7, 2.7];
%w0=[1   0.0631];
%delta0=[0.2, 0.1]; %DM 1

subplot(1,2,1);
hold on;
l=[0:0.5:30];
l1=[0:0.5:30];
xlabel('f1');
ylabel('f2');
objvals=[];

for i=1:size(l,2);
    for j=1:size(l1,2);
        if (l(i)+l1(j)>=5)
            objvals(end+1,1:2)=[sqrt(l(i)),sqrt(l1(j))];
            plot(sqrt(l(i)),sqrt(l1(j)),'-r');
        end;
    end;
end;

for i=1:size(objvals,1);
    objvals(i,3)=dominate(i,objvals);
end;

tmp=find(objvals(:,3)==0);

for i=1:size(tmp,1);
    pareto(i,1:2)=objvals(tmp(i),1:2);
    plot(pareto(i,1),pareto(i,2),'-or');
end;


subplot(1,2,2);

l=[0:0.5:30];
l1=[0:0.5:30];
hold on;
for i=1:size(l,2);
    for j=1:size(l1,2);
        if (l(i)+l1(j)>=5)
            plot(l(i),l1(j),'-r');
        end;
    end;
end;
xlabel('x1');
ylabel('x2');

subplot(1,2,1);
x=x0;
for i=1:1;
    w0=new_weights(x)
    [x,y]=geoff_inicialize(x,w0);
    x1(1,1)=x(1);
    x1(1,2)=x(2);
    y1(1,1)=sqrt(x(1));
    y1(1,2)=sqrt(x(2));
    
    plot(sqrt(x(1)),sqrt(x(2)),'-o');
    %hold on;
    %delta0=[random('beta',1,1)*2,random('beta',1,1)*2];
    y1(i,1)=sqrt(x(1));
    y1(i,2)=sqrt(x(2));
    x1(i,1)=x(1);
    x1(i,2)=x(2);

end;





%{
    
delta0=[0.5, 0.5]; %DM 2
[x,y]=geoff_inicialize(x0,delta0,w0);
x1(2,1)=x(1);
x1(2,2)=x(2);
y1(2,1)=sqrt(x(1));
y1(2,2)=sqrt(x(2));


w0=new_weights(x);

delta0=[0.4, 0.6]; %DM 2
[x,y]=geoff_inicialize(x0,delta0,w0);
x1(3,1)=x(1);
x1(3,2)=x(2);
y1(3,1)=sqrt(x(1));
y1(3,2)=sqrt(x(2));

plot(y1(1,1),y1(1,2),'-o');
hold on;
plot(y1(2,1),y1(2,2),'-o');
plot(y1(3,1),y1(3,2),'-o'     );

%}


end

function dom_count=dominate(index,vals)

dom_count=0;
y=vals(index,1:2);
for i=1:size(vals,1);
    s=0;
    f=0;
    if i~=index;
        for j=1:2;
            if (y(j)>=vals(i,j));
                f=f+1;
            end;

            if (y(j)>vals(i,j));
                s=s+1;
            end;
        end;
    end;

    if (f==2)&&(s>0);
        dom_count=dom_count+1;
    end;
end;

end
    
    function [x,z]=geoff_inicialize(x0,w,problem) 

%nonconvex Hanne function
opt=optimset('fmincon');
opt.TolFun=0.01;
opt.TolCon=0.01;
opt.MaxIter=50;
opt.UseParallel='always';

nr=round(w(3));
w(nr)=1;
step=w(4);
w=w(1:2);

switch problem
    case 'HANNE'
        T1=load('T1_true.mat');
        tol=mean(std(T1.T1))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y]=fmincon(@(x)objectives(x,x0,w),x0,[-1 -1],-5,[],[],[0.001 0.001],[7 7],[],opt);
    
    case  'HANNE1'
        wv=load('HANNE1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y]=fmincon(@(x)objectivesH1(x,x0,w),x0,[],[],[],[],[0.001 0.001],[12 12],@condH1,opt);
    
    case 'DEB1'
        wv=load('DEB1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y]=fmincon(@(x)objectivesDeb1(x,x0,w),x0,[],[],[],[],[0 -1],[1 10],[],opt);    
        
    case 'BINH1'
        wv=load('BINH1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y]=fmincon(@(x)objectivesBinh1(x,x0,w),x0,[],[],[],[],[0 0],[200 200],[],opt);    
    
    case 'BINH2'
        wv=load('BINH2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y]=fmincon(@(x)objectivesBinh2(x,x0,w),x0,[],[],[],[],[10^-6 10^-6],[10^6 10^6],[],opt); 
    
    case 'FONSECA1'
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        %[x1,y]=FMINUNC(@(x)objectivesFons1(x,x0,w),x0,opt);
        wv=load('FONS1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y]=fmincon(@(x)objectivesFons1(x,x0,w),x0,[],[],[],[],[0 0],[1 1],[],opt); 
        
    case 'FONSECA2'
        wv=load('FONS2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y]=fmincon(@(x)objectivesFons2(x,x0,w),x0,[],[],[],[],[-4 -4 -4],[4 4 4],[],opt); 
        
    case 'KURSAWE'
        wv=load('KURSAWE.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        [x1,y]=fmincon(@(x)objectivesKursawe(x,x0,w),x0,[],[],[],[],[-2 -2],[1 1],[],opt); 
        %[x1,y]=FMINUNC(@(x)objectivesKursawe(x,x0,w),x0,opt);
end;
%where d is direction for serch
%step=0.1;
%where t is step
dir=x1-x0
x=x0+step*dir;

switch problem
    case 'HANNE'
        z(1)=sqrt(x(1));
        z(2)=sqrt(x(2));
    
    case  'HANNE1'
        z(1)=objectiveH1_1(x);
        z(2)=objectiveH1_2(x);
    
    case 'DEB1'
        z(1)=objectiveDeb1_1(x);
        z(2)=objectiveDeb1_2(x);    
        
    case 'BINH1'
        z(1)=objectiveBinh1_1(x);
        z(2)=objectiveBinh1_2(x);    
        
    case 'BINH2'
        z(1)=objectiveBinh2_1(x);
        z(2)=objectiveBinh2_2(x);   
        z(3)=objectiveBinh2_3(x);
    
    case 'FONSECA1'
        z(1)=objectiveFons1_1(x);
        z(2)=objectiveFons1_2(x); 
        
    case 'FONSECA2'
        z(1)=objectiveFons2_1(x);
        z(2)=objectiveFons2_2(x); 
        
    case 'KURSAWE'
        z(1)=objectiveKursaw1(x);
        z(2)=objectiveKursaw2(x); 
end;





%where z is a new value of cuntion


end

function w=new_weights(x)

delta=0.01;
fun={'sqrt(x1)', 'sqrt(x2)'};
x_var={'x1','x2'};

x1=x(1);
x2=x(2);
f1=eval(fun{1});
f2=eval(fun{2});

x1=x(1)+delta;
x2=x(2)+delta;

f1_1=eval(fun{1});
f2_1=eval(fun{2});


w(1)=abs(f1_1-f1)/abs(f2_1-f2);
w(2)=1;

w=w*-1;
endfunction y=objectives(x,x0,w)


%fun={'sqrt(x1)', 'sqrt(x2)'};
%x_var={'x1','x2'};

%for HANN function
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

end    function [x1,y1,pareto]=geoffrion

x0=[2.7, 2.7];
%w0=[1   0.0631];
%delta0=[0.2, 0.1]; %DM 1

subplot(1,2,1);
hold on;
l=[0:0.5:30];
l1=[0:0.5:30];
xlabel('f1');
ylabel('f2');
objvals=[];

for i=1:size(l,2);
    for j=1:size(l1,2);
        if (l(i)+l1(j)>=5)
            objvals(end+1,1:2)=[sqrt(l(i)),sqrt(l1(j))];
            plot(sqrt(l(i)),sqrt(l1(j)),'-r');
        end;
    end;
end;

for i=1:size(objvals,1);
    objvals(i,3)=dominate(i,objvals);
end;

tmp=find(objvals(:,3)==0);

for i=1:size(tmp,1);
    pareto(i,1:2)=objvals(tmp(i),1:2);
    plot(pareto(i,1),pareto(i,2),'-or');
end;


subplot(1,2,2);

l=[0:0.5:30];
l1=[0:0.5:30];
hold on;
for i=1:size(l,2);
    for j=1:size(l1,2);
        if (l(i)+l1(j)>=5)
            plot(l(i),l1(j),'-r');
        end;
    end;
end;
xlabel('x1');
ylabel('x2');

subplot(1,2,1);
x=x0;
for i=1:1;
    w0=new_weights(x)
    [x,y]=geoff_inicialize(x,w0);
    x1(1,1)=x(1);
    x1(1,2)=x(2);
    y1(1,1)=sqrt(x(1));
    y1(1,2)=sqrt(x(2));
    
    plot(sqrt(x(1)),sqrt(x(2)),'-o');
    %hold on;
    %delta0=[random('beta',1,1)*2,random('beta',1,1)*2];
    y1(i,1)=sqrt(x(1));
    y1(i,2)=sqrt(x(2));
    x1(i,1)=x(1);
    x1(i,2)=x(2);

end;





%{
    
delta0=[0.5, 0.5]; %DM 2
[x,y]=geoff_inicialize(x0,delta0,w0);
x1(2,1)=x(1);
x1(2,2)=x(2);
y1(2,1)=sqrt(x(1));
y1(2,2)=sqrt(x(2));


w0=new_weights(x);

delta0=[0.4, 0.6]; %DM 2
[x,y]=geoff_inicialize(x0,delta0,w0);
x1(3,1)=x(1);
x1(3,2)=x(2);
y1(3,1)=sqrt(x(1));
y1(3,2)=sqrt(x(2));

plot(y1(1,1),y1(1,2),'-o');
hold on;
plot(y1(2,1),y1(2,2),'-o');
plot(y1(3,1),y1(3,2),'-o'     );

%}


end

function dom_count=dominate(index,vals)

dom_count=0;
y=vals(index,1:2);
for i=1:size(vals,1);
    s=0;
    f=0;
    if i~=index;
        for j=1:2;
            if (y(j)>=vals(i,j));
                f=f+1;
            end;

            if (y(j)>vals(i,j));
                s=s+1;
            end;
        end;
    end;

    if (f==2)&&(s>0);
        dom_count=dom_count+1;
    end;
end;

end
    
    function [x,z]=geoff_inicialize(x0,w,problem) 

%nonconvex Hanne function
opt=optimset('fmincon');
opt.TolFun=0.01;
opt.TolCon=0.01;
opt.MaxIter=50;
opt.UseParallel='always';

nr=round(w(3));
w(nr)=1;
step=w(4);
w=w(1:2);

switch problem
    case 'HANNE'
        T1=load('T1_true.mat');
        tol=mean(std(T1.T1))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y]=fmincon(@(x)objectives(x,x0,w),x0,[-1 -1],-5,[],[],[0.001 0.001],[7 7],[],opt);
    
    case  'HANNE1'
        wv=load('HANNE1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y]=fmincon(@(x)objectivesH1(x,x0,w),x0,[],[],[],[],[0.001 0.001],[12 12],@condH1,opt);
    
    case 'DEB1'
        wv=load('DEB1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y]=fmincon(@(x)objectivesDeb1(x,x0,w),x0,[],[],[],[],[0 -1],[1 10],[],opt);    
        
    case 'BINH1'
        wv=load('BINH1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y]=fmincon(@(x)objectivesBinh1(x,x0,w),x0,[],[],[],[],[0 0],[200 200],[],opt);    
    
    case 'BINH2'
        wv=load('BINH2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y]=fmincon(@(x)objectivesBinh2(x,x0,w),x0,[],[],[],[],[10^-6 10^-6],[10^6 10^6],[],opt); 
    
    case 'FONSECA1'
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        %[x1,y]=FMINUNC(@(x)objectivesFons1(x,x0,w),x0,opt);
        wv=load('FONS1.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y]=fmincon(@(x)objectivesFons1(x,x0,w),x0,[],[],[],[],[0 0],[1 1],[],opt); 
        
    case 'FONSECA2'
        wv=load('FONS2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        
        [x1,y]=fmincon(@(x)objectivesFons2(x,x0,w),x0,[],[],[],[],[-4 -4 -4],[4 4 4],[],opt); 
        
    case 'KURSAWE'
        wv=load('KURSAWE.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
        opt.TolFun=tol;
        opt.TolCon=tol;
        %opt=optimset('FMINUNC');
        %opt.TolFun=0.01;
        %opt.TolCon=0.01;
        %opt.MaxIter=50;
        [x1,y]=fmincon(@(x)objectivesKursawe(x,x0,w),x0,[],[],[],[],[-2 -2],[1 1],[],opt); 
        %[x1,y]=FMINUNC(@(x)objectivesKursawe(x,x0,w),x0,opt);
end;
%where d is direction for serch
%step=0.1;
%where t is step
dir=x1-x0
x=x0+step*dir;

switch problem
    case 'HANNE'
        z(1)=sqrt(x(1));
        z(2)=sqrt(x(2));
    
    case  'HANNE1'
        z(1)=objectiveH1_1(x);
        z(2)=objectiveH1_2(x);
    
    case 'DEB1'
        z(1)=objectiveDeb1_1(x);
        z(2)=objectiveDeb1_2(x);    
        
    case 'BINH1'
        z(1)=objectiveBinh1_1(x);
        z(2)=objectiveBinh1_2(x);    
        
    case 'BINH2'
        z(1)=objectiveBinh2_1(x);
        z(2)=objectiveBinh2_2(x);   
        z(3)=objectiveBinh2_3(x);
    
    case 'FONSECA1'
        z(1)=objectiveFons1_1(x);
        z(2)=objectiveFons1_2(x); 
        
    case 'FONSECA2'
        z(1)=objectiveFons2_1(x);
        z(2)=objectiveFons2_2(x); 
        
    case 'KURSAWE'
        z(1)=objectiveKursaw1(x);
        z(2)=objectiveKursaw2(x); 
end;





%where z is a new value of cuntion


end

function w=new_weights(x)

delta=0.01;
fun={'sqrt(x1)', 'sqrt(x2)'};
x_var={'x1','x2'};

x1=x(1);
x2=x(2);
f1=eval(fun{1});
f2=eval(fun{2});

x1=x(1)+delta;
x2=x(2)+delta;

f1_1=eval(fun{1});
f2_1=eval(fun{2});


w(1)=abs(f1_1-f1)/abs(f2_1-f2);
w(2)=1;

w=w*-1;
endfunction y=objectives(x,x0,w)


%fun={'sqrt(x1)', 'sqrt(x2)'};
%x_var={'x1','x2'};

%for HANN function
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

end    function [x1,y1,pareto]=geoffrion

x0=[2.7, 2.7];
%w0=[1   0.0631];
%delta0=[0.2, 0.1]; %DM 1

subplot(1,2,1);
hold on;
l=[0:0.5:30];
l1=[0:0.5:30];
xlabel('f1');
ylabel('f2');
objvals=[];

for i=1:size(l,2);
    for j=1:size(l1,2);
        if (l(i)+l1(j)>=5)
            objvals(end+1,1:2)=[sqrt(l(i)),sqrt(l1(j))];
            plot(sqrt(l(i)),sqrt(l1(j)),'-r');
  