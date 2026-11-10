# -----------------------------------------------------------------
# LECTURE 1 - PART 4 - USER DEFINED FUNCTIONS
# -----------------------------------------------------------------

# ---------------------------------------------------------------------------
# EXAMPLE 1:  INLINE FUNCTION TO COMPUTE COTANGENS - NOT USED IN PRESENTATION
# ---------------------------------------------------------------------------

# Cotangens function
mycot = function(x) 1/tan(x)

# Define x
x=pi*0.3

# Run the function
mycot(x)

# Result check
1/tan(x)

# Result check 2
cos(x)/sin(x)

# --------------------------------------------------------------------------
# EXAMPLE 2 :  INLINE FUNCTION TO COMPUTE LOGIT
# --------------------------------------------------------------------------

# Define x
x <- 1

# Logit function
mylogit <- function(x) 1/(1+exp(-x))

# Calculate result
mylogit(x)

# Vector input
x <- seq(-5,5,by=0.1)
y <- mylogit(x)

# Draw chart of the logit function
plot(x,y)
title('Logit')

# --------------------------------------------------------------------------
# EXAMPLE 3 :  USER DEFINED FUNCTION TO COMPUTE LOGIT
# --------------------------------------------------------------------------

# Define x
x <- 1

# Logit function
mylogit2 = function(x) {
  z <- 1/(1+exp(-x))
  return(z)  
}

# Calculate result
mylogit2(x)

# --------------------------------------------------------------------------
# EXAMPLE 4 :  USER DEFINED FUNCTION TO COMPUTE GENERALIZED LOGIT
# --------------------------------------------------------------------------

# Note: Parameters x0, k an L are set as non-obligatory

# Define x
x <- 1

# Logit function
mylogit2 = function(x,x0=0,k=1,L=1) {
  z <- L/(1+exp(-k*(x-x0)))
  return(z)  
}

# Calculate result
mylogit2(x)

# Set additional parameters
x0 <- 2
k <- 3
L <- 5

# Calculate result
mylogit2(x,x0,k,L)

# Vector input
x <- seq(-5,5,by=0.1)

# FIGURE 1 - Standard logit
y <- mylogit2(x)
plot(x,y)
title('Logit (x0=0, k=1, L=1)')

# FIGURE 2 - Shifted midpoint
y <- mylogit2(x,2)
plot(x,y)
title('Logit (x0=2, k=1, L=1)')


# FIGURE 3 - Changed steepness
y <- mylogit2(x,0,3)
plot(x,y)
title('Logit (x0=0, k=3, L=1)')


# FIGURE 4 - Changed maximum
y <- mylogit2(x,0,1,5)
plot(x,y)
title('Logit (x0=0, k=1, L=5)')

# --------------------------------------------------------------------------
# EXAMPLE 5: FIBONACCI SEQUENCE
# --------------------------------------------------------------------------

# Function to compute the Fibonacci sequence of order k
myfibonacci = function(k) {
  
  # Start of calculation time
  t1 <- Sys.time()
  
  # Create an empty vector of size k+1 (as we start with the 0-th term)
  fibonacci = numeric(k+1)
  
  # Cycle to compute the Fibonacci sequence
  for (i in 1:(k+1)) {
    if (i==1) {
      fibonacci[i] <- 0
    } else if (i==2) {
      fibonacci[i] <- 1
    } else {
      fibonacci[i] <- fibonacci[i-1] + fibonacci[i-2] 
    }
  }   
  
  # End of calculation time
  t2 <- Sys.time()
  
  # Save the calculation time to the global enviroment
  t <<- t2-t1
  
  # Return result
  return(fibonacci) 
  
}

# Compute result:
k=15
myfibonacci(k)
print(t)

# Calculation time check:
k=10000
myfibonacci(k)
print(t)

# Note: Most of the numbers in the above calculation get sadly rounded to Inf
