function buildX( x, f, n )

p = length(x);

X = zeros(p,n);

J = zeros(1,n);
for i = 1:p
   
    for j = 1:n
        J(j) = 1;
        X(i,j) = f( x(i), J );
        J(j) = 0;
    end
end