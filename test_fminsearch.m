n = 4;
a = repmat(1:n, n, 1);
b = rand(4);


fun = @(w) sum(sum((abs(b.*repmat(w,size(b,1),1) - a))));

w0 = ones(1,n);

options = optimset('PlotFcns',@optimplotfval);
w = fminsearch(fun,w0,options)

disp(b.*repmat(w,size(b,1),1))
disp(a)