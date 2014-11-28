function result=bindecode(gen,mask)
%function represents x values in binary coded string
% variable gen is encoded binary string
% variable mask is gen stucture description
start=mask.startbit;
stop=mask.stopbit;
len=length(gen);
if (stop>len) ||(start<1);
    MException(10,'The stop or start bit is out from gen length',stop,gen);
end;
substr='';
for i=start:stop;
    substr=strcat(substr,gen(i));
end;
int=bin2dec(substr);
len=length(substr);
result=mask.lower+((mask.upper-mask.lower)/((2^len)-1))*int;

end