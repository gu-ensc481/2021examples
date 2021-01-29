using Pkg
Pkg.activate(".")

using BenchmarkTools, Plots

include("Exp.jl")
using .Exp

# Compute some timings
@benchmark myexp( $( 10*(2*rand() - 1) ) )

# compute to built-in (and extremely optimized) exp
@benchmark exp( $( 10*(2*rand() - 1) ) )


# Let's make a plot to see how the number of iterations vary as a function of input number
xr = LinRange(-4, 4, 101)

iterations = Int64[]
for x in xr
    _, i, _ = myexp_simple(x, verbose=true)
    append!(iterations,i)
end

plt = plot( xr, iterations, xlabel="Input value x",
    ylabel="Number of iterations",
    label="Simple method")


iterations = Int64[]
for x in xr
    _, i, _ = myexp(x, verbose=true)
    append!(iterations,i)
end
plot!( xr, iterations, label="Improved method" )

