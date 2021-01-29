module Exp

e = 2.71828182845904523536

max_input_value = log( floatmax(Float64) )


export myexp, myexp_simple

function myexp(n::Int)

    output = 1.0

    for i = 1:n
        output *= e
    end

    return output

end

function myexp(x::Real; tol=1e-13, maxIter = 30, verbose=false)

    # alway compute the positive side
    if x < 0
        w = -x
    else
        w = x
    end

    # check to ensure that the answer isn't Inf
    if w >= max_input_value
        if x < 0
            return 0.
        else
            return Inf
        end
    end
    
    # break into exp(x) = exp(n)*exp(z)
    n = floor(Int, w)
    exp_n = myexp(n)
    z = w - n

    exp_z = 1.0

    i = 0
    flag = 0
    newterm = 1.0

    while flag == 0
        i += 1
        newterm *= z/i
        exp_z   += newterm
        if abs(newterm) <= tol
            flag = 1
        elseif i >= maxIter
            flag = -1
            error("Failed to converge")
        end

    end

    output = exp_n*exp_z

    if x < 0
        output = 1/output
    end

    if verbose
        return output, i, flag
    else
        return output
    end

end

function myexp_simple(x::Real; tol=1e-13, maxIter = 500, verbose=false)

    exp_x = 1.0

    i = 0
    flag = 0
    newterm = 1.0

    while flag == 0
        i += 1
        newterm *= x/i
        exp_x   += newterm
        if abs(newterm) <= tol
            flag = 1
        elseif i >= maxIter
            flag = -1
            error("Failed to converge")
        end

    end

    if verbose
        return exp_x, i, flag
    else
        return exp_x
    end

end


end