function dw = syswobs(t,w,A,B,C,D,K,L,r)

n = size(A,1);

% w = [ x; xhat ];
x    = w(1:n);
xhat = w(n+1:2*n);

%% controller
u = -K*xhat + r(t);
% u = -K*x + r(t);

%% The 'real system'
xdot = A*x + B*u;
y    = C*x + D*u;


%% The observer
yhat = C*xhat + D*u;
xhatdot = A*xhat + B*u + L*(y - yhat);

%% Pack the output array
dw = [xdot; xhatdot];
