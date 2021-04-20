##
using Pkg
Pkg.activate(".")

using ForwardDiff, LinearAlgebra, DifferentialEquations

## Setup the system
m = 1.
g = 9.81
l = 0.5

M = diagm(0=>[m,m])
Qex = [0, -m*g]
ϕ(q) = -l^2 + q[1]^2 + q[2]^2

## Built UK equations
A(q) = ForwardDiff.gradient( ϕ, q)'
b(q,qd) = -qd'*ForwardDiff.hessian(ϕ,q)*qd

p = (M, Qex, A, b )
function sysode!(dz, z, p, t)
    M, Qex, A, b = p
    n = size(M,1)

    # z = [q; qd]
    q = z[1:n]
    qd = z[n+1:2*n]

    Ms = sqrt(M)
    a = M\Qex
    An = A(q)
    bn = b(q,qd)

    qddot = a + Ms\( (An/Ms)\( bn - An*a ) )

    dz[1:n] .= qd
    dz[n+1:2*n] .= qddot

end

## check to make sure that the syntax is working
zd = zeros(4,1)
sysode!(zd, [1,2,3,4], p, 0)
zd