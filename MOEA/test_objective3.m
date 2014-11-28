function y=test_objective3(w,opt)
% this function use penalty function to determine correct information from
% DM
%the main function 1 then w(1)=1;
y=0;
count=size(opt.goal,2);

%w(round(w(1))+1)=1;

if count==3;
    %if (w(1)~=1)&&(w(2)~=1)&&(w(3)~=1);
        %y=abs(w(1)+w(2)+w(3));
    %    y=1;
    %end;
elseif count==2;
    %if not(w(1)~=w(2)&&((w(1)==1)||(w(2)==1)));%not(((w(1)==1)&&(w(2)~=1))||((w(1)~=1)&&(w(2)==1)))
       
    %    y=exp(abs(1-w(1))+abs(1-w(2))+abs(w(1)+w(2)));
    %end;
    if w(1)==w(2);
        %y=abs(w(1))+abs(w(2));
        y=1;%abs(w(1))+abs(w(2));
    end;
    %if (w(1)~=1)&&(w(2)~=1);
       %y=y+abs(1-w(1))+abs(1-w(2));
    %   y=y+1;%y+abs(1-w(1))+abs(1-w(2));
    %end;

    
    
end;

global flag_stop;
if flag_stop<0;
    y=y+abs(flag_stop);
end;

end

