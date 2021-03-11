##
using Pkg
Pkg.activate(".")
using MonteCarloMeasurements, StatsPlots

##
v = 2 ± 0.05
m = 1 ± 0.02

T = 1/2*m*v^2

plot(T)

## Let's make the magnitude portion of a Bode Diagram
ωₙ = 1 ± 0.05
ζmean = 0.05
ζ = Particles(2000, Gamma(10,ζmean/10 ) )
# ζ = ζmean ± 0.005
# histogram of the samples of zeta:
plot(ζ, xlabel="Value of \\zeta", ylabel="Number of samples")
# density plot of zeta:
density(ζ, xlabel="Value of \\zeta", ylabel="Density of \\zeta")

MdB(ω) = 20*log10(1/abs( -ω^2 + 2*ζ*ω*ωₙ*1im + ωₙ^2 ))

w = exp10.(LinRange(-0.5,0.5,200))
ribbonplot(w, MdB.(w), 0.2 , xscale=:log10, xlabel="Forcing frequency \\omega [rad per s]", ylabel="Magnitude [dB]")  

