# Factorial Example Script
## This is a script in Julia, so I'm not using functions, modules, etc.
## I'm going to compute the factorial value in a very simple way (avoiding recursion)

using Printf

## input
x = 5

## compute the results
output = 1

for i = 1:x
   global output *= i
end

## Print out the results
@printf("%d! = %d\n", x, output)
