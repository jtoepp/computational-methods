function [R,count] = newton(f,df,x0,tol,count)
%R is the root found according to the tolerance level
%count is how many times the program went through the calculations to find
%and you must define count = 0 when you call the function in the MATLAB
%command window.
%x0 is your initial guess.
%df is the derivative of your function.


if abs(f(x0)) < tol
    R = x0;
else
    count = count + 1;
    R = newton(f,df,x0-f(x0)/df(x0),tol,count);
end
  
end

%end myNewton