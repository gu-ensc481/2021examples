##
using LinearAlgebra

##
A = [ 0 1.;
      -1 0]

e1 = eigen(A)
e1.values

A = diagm(1=>[1,1.])
A[end,:] = [-23., -304., -732. ]
A
e2 = eigen(A)
e2.values