function y = myexp(x)


%%
i = 0;
flag = 0;
y = 1;
newterm = 1;
maxIter = 300;
tol = 1e-14;

while flag==0
    i = i + 1;

    newterm = newterm*x/i;
    y = y + newterm;
    
    rel_error = abs( newterm );
    
    if rel_error <= tol
        flag = 1;
        
    elseif i >= maxIter
        flag = -1;
        error("Failed to converge.");        
    end
    
end

