function mdist=eucdist(solution,tset)
%this is measure function General Distance (GD) for MOGA
%function calculate minimal Euclidean distanc between curent solution
%solutios form Tset

for i=1:size(tset,1);
    a=tset(i,:);
    t(i)=sum(abs((solution-a)).^2);
end;
mdist=min(t);
    
   
            
