function handle=plusminus(objvals,taillen);

ss=size(objvals,1);
if ss>taillen+1;
    objvals=objvals(end-taillen+1:end,:);
else
    taillen=size(objvals,1);
    objvals=objvals(end-taillen+1:end,:);
end;

ch={}; % consist of two parts: +/-/0, changes%
for i=1:size(objvals,1)-1;
    t1=objvals(i,:);
    t2=objvals(i+1,:);
    t3=t2-t1;
    for j=1:size(objvals,2);
        proc=t3(j);%round((abs(t3(j))/abs(t1(j)))*100);
        if t3<0;
            ch{i,j}={-1,proc};
        elseif t3==0;
            ch{i,j}={0,0};
        else
            ch{i,j}={1,proc};
        end;
    end;
end;

string='';
stepy=0;
stepx=0;
axis auto;
hold on;
for i=1:size(ch,1);
    for j=1:size(ch,2);
        vals=ch{i,j};
        if vals{1,1}==-1;
            sing='-';
        elseif vals{1,1}==0;
            sing='0';
        else
            sing='+';
        end;
        text(stepx, stepy, sprintf('%5.4f%\t',vals{1,2}),'FontSize',10);
        if i==1;
            text(stepx,0.25, sprintf('f_%d(x)',j),'FontSize',10);
        end;
        
        if j==1;
           text(stepx-0.6,stepy,  sprintf('%d. iter.',(ss-size(objvals,1))+i),'FontSize',10);
        end;
        
        stepx=stepx+1;
    end;
    stepx=0;
    stepy=stepy-0.4;
end;
line([-1 1*size(objvals,2)],[0+0.1 0+0.1]);
line([-1 size(objvals,2)],[stepy+0.3 stepy+0.3]);

axis([-0.9 size(objvals,2) stepy 0.5]);
sum=zeros(1,size(objvals,2));
for j=1:size(ch,2);
    for i=1:size(ch,1);
        elem=ch{i,j};
        sum(j)=sum(j)+elem{1,1}*elem{1,2};
    end;
end;

stepx=0;

text(stepx-0.6,stepy+0.1,'TOTAL:','FontSize',10, 'FontWeight', 'Bold');
for i=1:size(sum,2);
    text(stepx, stepy+0.1, sprintf('%5.3f%',sum(i)),'FontSize',10, 'FontWeight', 'Bold');
    stepx=stepx+1;
end;
            
        
    
axis off;
hold off;
handle=sum;
  
