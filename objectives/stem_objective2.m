function y=stem_objective2(arg,opt)
% this function use penalty function to determine correct information from
% DM
%the main function 1 then w(1)=1;
sz=size(opt.goal,2);
st=sz;
satFuns=arg(1:st);
st=sz+1;
unsatFuns=arg(st:sz*2);
st=sz*2+1;
econs=arg(st:sz*3);

%satFuns=unique(fix(satFuns));
%unsatFuns=unique(fix(unsatFuns));

satFuns=(round(satFuns));
unsatFuns=(round(unsatFuns));

etalon=[1:size(opt.goal,2)];
y=0;

%if sum(unsatFuns,2)>1;
%    y=1;
%end;

if sum(unsatFuns)==0||sum(satFuns)==0;
    y=y+1;
end;

for i=1:size(etalon,2);
    if  (unsatFuns(i)==satFuns(i))%&&satFuns(i)==1;
        y=y+2;
    end;
    %x=find(unsatFuns==etalon(i));
    %x2=find(satFuns==etalon(i));
    %if ~isempty(x)&&~isempty(x2);
    %    y=y+2;
    %end;
    
    %if sum(unsatFuns)==0&&sum(satFuns)==0;
    %    y=y+2;
        
    %end;
    %if isempty(x)&&isempty(x2);
    %    y=y+1;
    %end;
end;

global flag_stop;
if flag_stop<0;
    y=y+abs(flag_stop);
end;
    
end
