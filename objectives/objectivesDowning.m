function y=objectivesDowning(x,x0,w)


%for tappeta function
y=sum(((-w(1).*[-1; -9; -10; -1; -3])...
    + (-w(2).*[9; -2; 2; 7; 4])...
    + (-w(3).*[-4; -6; -7; -4; -8]))'.*x);
y=y*-1;