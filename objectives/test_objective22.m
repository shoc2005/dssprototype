function y=test_objective2(w,opt)
%y=(x-2)^2;

[x1,y]=geoff_inicialize(opt.x0,w,opt.problem);
y=sqrt(sum((y-opt.goal).^2));

end