function handle=spiderweb(objvals,taillen)
%function plots objvals presented in columns for n iterations presented in
%rows.
colorspec=[];
colorspec(1,:)=[1 0 0]; %red - last iteration
colorspec(2,:)=[0.8 0 0]; %red - last iteration
colorspec(3,:)=[0 1 0]; %green - previous iteration
colorspec(4,:)=[0 0.5 0]; %green- previous iteration
colorspec(5,:)=[0 0 1]; %blue- previous-1 iteration
colorspec(6,:)=[0 0 0.5]; %blue- previous-1 iteration
colorspec(7,:)=[1 0 1]; %magenta- previous-2 iteration
colorspec(8,:)=[0 1 1]; %cyan- previous-3 iteration
colorspec(9,:)=[1 1 0]; %yellow- previous-4 iteration
colorspec(10,:)=[0 0 0]; %black- axis and others

ss=size(objvals,1);
if ss>taillen;
    objvals=objvals(end-taillen+1:end,:);
else
    taillen=size(objvals,1);
end;

maxval=max(max(objvals));
minval=min(min(objvals));
objcount=size(objvals,2);

centerx=0;
centery=centerx;
step=0;
coners=[];
for i=0:0.01:2*pi;
    step=step+0.01;
    if step>=pi*2/objcount||i==0;
        coners(end+1)=i;
        line([centerx, cos(i)*(maxval+maxval*0.2)+centerx], [centery, sin(i)*(maxval+maxval*0.2)+centery],'Color',colorspec(10,:));
        text(cos(i)*(maxval+maxval*0.25)+centerx, sin(i)*(maxval+maxval*0.25)+centery, sprintf('f_%d(x)',size(coners,2)));
        step=0;
    end;
    hold on;
    
end;
orig_objvals=objvals;
objvals=abs(objvals);
forlegend={};
for i=1:size(objvals,1);
    for j=1:size(coners,2)-1;
        line([cos(coners(j))*objvals(i,j)+centerx, cos(coners(j+1))*objvals(i,j+1)+centerx],...
           [sin(coners(j))*objvals(i,j)+centerx, sin(coners(j+1))*objvals(i,j+1)+centerx],'LineWidth',2, ...
       'Color',colorspec(taillen-i+1,:),'ButtonDownFcn',{@show_labels,gca},'UserData',i);
        
       ht1=text(cos(coners(j))*objvals(i,j)+centerx, sin(coners(j))*objvals(i,j)+centerx,['\leftarrow',...
           sprintf('f_%d=%0.3f',j,objvals(i,j))],'UserData', [i]);
       set(ht1,'Visible','off');
    end;
    h(i)=line([cos(coners(end))*objvals(i,end)+centerx, cos(coners(1))*objvals(i,1)+centerx],...
           [sin(coners(end))*objvals(i,end)+centerx, sin(coners(1))*objvals(i,1)+centerx],'LineWidth',2,...
           'Color',colorspec(taillen+1-i,:),'ButtonDownFcn',{@show_labels,gca},'UserData',i);
    
       ht1=text(cos(coners(end))*objvals(i,end)+centerx, sin(coners(end))*objvals(i,end)+centerx,['\leftarrow',...
           sprintf('f_%d=%0.3f',size(coners,2),orig_objvals(i,end))],'UserData', [i]);
       
       set(ht1,'Visible','off');
forlegend{i}=sprintf('Iterâcija Nr. %d',(ss-size(objvals,1))+i-1);    
end;
forlegend{end}=sprintf('Pçdçjâ iterâcija');

legend(h,forlegend);
len=maxval+maxval*0.4;
axis([-len len -len len]);
hold off;
handle=gca;
%h=annotation('arrow',[0.5 0.5],[0.5 0.9]);
%h=annotation('arrow',[0.5,0.9],[0.5,0.5]);
%h=annotation('arrow',[0.5,0.1],[0.5 0.1]); %sin(0), sin(pi*0.5)

%set(h,'Position',[0.5 0.5 0.5 0.5]);