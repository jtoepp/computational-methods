function [xm,count] = bisection(f,a,b,tol)
%[xm,count] = bisection(f,a,b,tol)
%Approximates a root, xm, of function f bounded by a and b to within
%tolerance
%To help you understand the code, here is a explanation of some of the
%variables:
%a is the lower guess
%b is the uppper guess
%tol is the pre-specified tolerance level.
%count will return how many times the code had to be run through before
%finding an acceptable root.

if f(a)*f(b)>0 
    disp('The scalars a and b do not bound a root')
else
    xm = (a + b)/2;
    err = abs(f(xm));
   
    count=0;
    while err > tol
   if f(a)*f(xm)<0 
       b = xm;
   else
       a = xm;          
   end
    xm = (a + b)/2; 
   err = abs(f(xm));
   count=count+1;
    end
end