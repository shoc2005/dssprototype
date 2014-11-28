function vector=cell_to_num(cell)
vector=[];
if isempty(cell);
    return;
end;
[a,b]=size(cell);
c=max([a,b]);

for i=1:c;
  vector(i)=str2num(cell{i});
end;