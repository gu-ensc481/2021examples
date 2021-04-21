##
using Pkg
Pkg.activate(".")

using ForwardDiff, LinearAlgebra, DifferentialEquations
using Plots

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

## z = [x, y, xdot, ydot]
tspan = (0, 30.)
θ0 = 30*pi/180
x0 = l*sin(θ0)
y0 = -l*cos(θ0)
z0 = [x0, y0, 0, 0]
prob = ODEProblem( sysode!, z0, tspan, p)
##
sol = solve( prob )

#matlab: deval( sol, 1.3)
#julia: sol(1.3)

##
x(t) = sol(t)[1]
y(t) = sol(t)[2]

plot( x, tspan[1], tspan[2], label="x [m]" )
plot!( y, tspan[1], tspan[2], label="y [m]" , 
    xlabel="Time t [s]", ylabel="Position [m]")

##
err(t) = (sqrt(x(t)^2 + y(t)^2) - l)/l
plot( err, tspan[1], tspan[2])