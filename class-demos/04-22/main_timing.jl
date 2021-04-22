## Timing
using Pkg
Pkg.activate(".")
using Plots, LinearAlgebra, Printf
using BenchmarkTools

##
ζ = 0.3
x0 = [0.1, 0.2]
tf = 10.

## Exact solution
x_exact(t) = exp(-ζ*t)*( x0[1]*cos( sqrt(1-ζ^2)*t ) + (x0[2] + ζ*x0[1])/sqrt(1-ζ^2)*sin(sqrt(1-ζ^2)*t) )
f(z,t) = [z[2], -z[1] - 2*ζ*z[2]  ]

## Setup the error function
function soln_err(x,t)
    return norm( x[:,1] - x_exact.(t) )
end

function costtime(bmark)
    return median(bmark.times)*1e-6 #[ms]
end

function compute_results(ODE_METHOD, h_range, f, tf, x0)
    err = Float64[]
    ctime= Float64[]
    for h in h_range
        x,t = ODE_METHOD(f, tf, h, x0)
        push!(err, soln_err(x,t) )
        bmark = @benchmark $ODE_METHOD($f, $tf, $h, $x0)
        push!(ctime, costtime(bmark))
    end

    return ( err, ctime )
end

## Let's run this over a range of h:
h_range = 2 .^-(2.0:16.0)
# h_range = 2 .^-(2.0:4.0)

##
include("AM3.jl")
err, ctime = compute_results(AM3.am3, h_range, f, tf, x0)
plt = plot( err, ctime, marker=:square, label="AM3",
     xscale=:log10, yscale=:log10,
    xlabel="Norm of error |x - x_true|_2",
    ylabel="Median Wall Time [ms]",
    legend=:bottomright)

## Add AB2
include("AB2.jl")
err, ctime = compute_results(AB2.ab2, h_range, f, tf, x0)
plot!(plt, err, ctime, marker=:star5, label="AB2")

## Forword Euler:
include("ForwardEuler.jl")
err, ctime = compute_results(ForwardEuler.feuler, h_range, f, tf, x0)
plot!(plt, err, ctime, marker=:hexagon, label="Forward Euler")

## Backward Euler:
include("BackwardEuler.jl")
err, ctime = compute_results(BackwardEuler.beuler, h_range, f, tf, x0)
plot!(plt, err, ctime, marker=:star4, label="Backward Euler")

## RK2
include("RK2.jl")
err, ctime = compute_results(RK2.rk2, h_range, f, tf, x0)
plot!(plt, err, ctime, marker=:dtriangle, label="RK-2")

## Save the figure
savefig(plt, "relative_timing.pdf")
