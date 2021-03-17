##
using LinearAlgebra

nx = 5
ny = nx

T_south = 0
T_east  = 50
T_north = 100
T_west  = 75


T0 = zeros(nx,ny)

## Apply BC
T0[:,1]   .= T_south
T0[end,:] .= T_east
T0[:,end] .= T_north
T0[1,:]   .= T_west

##
tol = 1e-6
maxIter = 1000

function jacobi(nx,ny, tol, maxIter, T0)

    T = copy(T0)
    Tnew = copy(T0)
    residuals = zeros(nx,ny)

    flag = 0
    iter = 0
    while flag == 0
        iter += 1 # iter = iter + 1

        # update all the open values of T
        # T[i,j] = 1/4*( T[i+1,j] + T[i-1,j] + T[i,j+1] + T[i,j-1]  )

        for i = 2:nx-1
            for j = 2:ny-1
                Tnew[i,j] = 1/4*( T[i+1,j] + T[i-1,j] + T[i,j+1] + T[i,j-1]  )
            end
        end
        T = copy(Tnew)
        # T = Tnew % if using Matlab

        for i = 2:nx-1
            for j = 2:ny-1
                residuals[i,j] = T[i+1,j] + T[i-1,j] + T[i,j+1] + T[i,j-1] - 4*T[i,j]
            end
        end

        if norm(residuals) <= tol
            flag = 1
        elseif iter >= maxIter
            flag = -1
            error("Failed to converge")
        end

    end

    return (T, iter)
end

##
T, iter = jacobi(nx,ny,tol, maxIter, T0)


##
include("gs.jl")
T, iter = gaussSeidel(nx,ny,tol, maxIter, T0)