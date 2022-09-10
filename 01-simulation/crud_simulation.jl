# activate and instantiate the environment
import Pkg
Pkg.activate(dirname(@__FILE__))
Pkg.instantiate()

using Plots # plotting library
using Distributions # work with probability distributions

# use this as a scratch space for your code for the exercise.

# variables
v= 25; #km/d
C0= 0.2; # mg/L CRUD
Q0= 500000; # m^3/d
d= 10; # km 

Q1= 100000; # m^3/d
C1= 10; # mg/L 

Q2= 60000; # m^3/d 
C2= 20; # mg/L 

k= 0.45; # 1/d 

function massCRUD(x, E1, E2)
    M= zeros(length(x));
    for i= 1:length(x)
        if x[i]<=10
            M[i]= (1100 - 1000*E1)*exp(-.45*x[i]/25); #kg/d 
        else
            M[i]= ((1100 - 1000*E1)*exp(-.18) + 1200*(1 - E2))*exp(-.45*(x[i] - 10)/25); # kg/d 
        end
    end
    return M
end

function costCRUD(E1, E2)
    C= 5000*E1^2 + 3000*E2^2;
    return C
end

# running situation 1
E1= 0; E2= 0;
x= [0:1:15]; 
M= massCRUD(x, E1, E2);
plot(x, M)
savefig("file name")

[I, Mmax]= findmax(M); # where I is the index of the max and Mmax is the max M value
