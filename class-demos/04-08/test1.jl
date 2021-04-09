
f(x) = x+1


y = zeros(3)
x = ones(3)

function f!(y,x)
    y .= x .+ y .+1
end

function g(x; verbose=false)
    y = x+2
    if verbose
        return y,x
    else
        return y
    end
end
