function handle=crashedlines(objvals,taillen)
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
if ss>taillen+1;
    objvals=objvals(end-taillen+1:end,:);
else
    taillen=size(objvals,1)-1;
    objvals=objvals(end-taillen+1:end,:);
end;

maxval=max(max(objvals));
minval=min(min(objvals));
objcount=size(objvals,2);

step=[0];
forlegend={};

for i=1:objcount;
    line([minval-minval*0.2, maxval+maxval*0.2], [step(end), step(end)], 'Color', colorspec(10,:));
    text(maxval+maxval*0.25,step(end),sprintf('f_%d(x)',i)); 
    step(end+1)=step(end)+mean([maxval minval]);
    
end;
step=step(1:end-1);

for i=1:size(objvals,1);
    forlegend{i}=sprintf('Iteration %d.',(ss-size(objvals,1))+i-1); 
    
    for j=1:objcount-1;
        h(i)=line([objvals(i,j) objvals(i,j+1)], [step(j) step(j+1)],...
            'Color',colorspec(taillen-i+1,:),'ButtonDownFcn',{@show_labels,gca},...
        'LineWidth',2,'UserData', i, 'Marker','o','MarkerEdgeColor',colorspec(taillen-i+1,:), 'MarkerSize',5, 'MarkerFaceColor',colorspec(taillen-i+1,:));
        
        ht1=text(objvals(i,j),step(j),[' \leftarrow',sprintf('%0.3f',objvals(i,j))],'UserData', i);
        set(ht1,'Visible','off');
    end;
    
    ht1=text(objvals(i,end),step(end),[' \leftarrow',sprintf('%0.3f',objvals(i,end))],'UserData', i);
        set(ht1,'Visible','off');
    %text(objvals(i,end),step(end-1)+4.45,sprintf('i=%d',i));    
    %h(i)=line([objvals(i,end) objvals(i,1)], [0 0],...
    %    'Color',colorspec(taillen-i+1,:),'ButtonDownFcn',{@show_labels,gca},'UserData',i, 'LineWidth',2);
    
    %ht1=text(objvals(i,end),0,['\leftarrow',sprintf('f_%d=%0.3f',j,objvals(i,end))],'UserData', i);
    %set(ht1,'Visible','off');
        
    
end;

legend(h,forlegend);
%len=maxval+maxval*0.4;
%axis([0 len -len*0.25 len+len*0.4]);
grid on;
hold off;
handle=gca