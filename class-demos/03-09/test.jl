using Pkg
Pkg.activate(".")
using ForwardDiff

f(x) = sin(x)
fprime(x) = ForwardDiff.derivative(f,x)
f(pi)
fprime(pi)

fpprime(x) = ForwardDiff.derivative( fprime, x)
