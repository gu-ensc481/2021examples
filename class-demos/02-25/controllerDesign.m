function K = controllerDesign(A,B,sx)

n = size(A,1);

d = poly(sx);

Cont_X = buildContMatrix(A,B);


a = poly(eig(A));

Abar = diag(ones(n-1,1),1);
Abar(n,:) = -a(end:-1:2);


Bbar = zeros(n,1);
Bbar(end) = 1;

Cont_Z = buildContMatrix(Abar,Bbar);

P = Cont_X/Cont_Z;

%% Design the controller:
temp = flip(d - a);
Kz = temp(1:n);
K = Kz/P;

end

function Cm = buildContMatrix(A,B)

    n = size(A,1);
    Cm = zeros(n,n);
    
    Cm(:,1) = B;
    for i = 2:n
        Cm(:,i) = A*Cm(:,i-1);
    end
end