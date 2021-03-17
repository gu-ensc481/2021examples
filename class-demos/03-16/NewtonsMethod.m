function [xn,i] = NewtonsMethod(f,J,x0)

tol = 1e-12;

maxIter = 1000;
i = 0;

flag = 0;

fn = f(x0);
xn = x0;
while flag == 0
   
    i = i + 1;
    
    Jn = J(xn);
    delta_x = -Jn\fn;
    
    xn = xn + delta_x;
    
    fn = f(xn);
    
    if norm(fn) <= tol
        flag = 1;
        
    elseif i >= maxIter
        flag = -1;
        error('Failed to converge')
    end
    
end
