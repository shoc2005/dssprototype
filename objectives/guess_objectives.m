function value=guess_objectives(arg,opt)
%for method gamultiobj and GUESS method, 12.12.2010.
value(1)=guess_objective2(arg,opt);
value(2)=guess_objective1(arg,opt);