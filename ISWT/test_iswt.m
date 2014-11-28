function [y,x]=test_iswt()
opt=[];
opt.objcount=2;
opt.objhandles={@objectiveBinh1_1,@objectiveBinh1_2};
opt.ineq=@inqualityBinh1;
[y,x]=iswt_inicialize([0.3,0.4],2,[0.5,10],opt);
y(1)=objectiveBinh1_1(x);
y(2)=objectiveBinh1_2(x);

end