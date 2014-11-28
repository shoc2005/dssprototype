function w=new_weights(x)

delta=0.01;
fun={'sqrt(x1)', 'sqrt(x2)'};
x_var={'x1','x2'};

x1=x(1);
x2=x(2);
f1=eval(fun{1});
f2=eval(fun{2});

x1=x(1)+delta;
x2=x(2)+delta;

f1_1=eval(fun{1});
f2_1=eval(fun{2});


w(1)=abs(f1_1-f1)/abs(f2_1-f2);
w(2)=1;

w=w*-1;
end