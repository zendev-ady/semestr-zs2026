# -----------------------------------------------------------------
# LECTURE 1 - PART 3 - BASIC CONDITIONS AND CYCLES
# -----------------------------------------------------------------

# -----------------------------------------------------------------
# EXAMPLE 1: Script to evaluate whether number x is even or odd 
# By using an ifelse statement and a modulo (%%) operator
# -----------------------------------------------------------------

# Input your number here
x <- 6

# Calculate result
y <- ifelse(x%%2==0,'Even Number','Odd Number')

# Print result
print(y)

# -----------------------------------------------------------------
# EXAMPLE 2: Script to evaluate whether number x is positive,
# negative or zero by using an if-else if-else statement
# NOTE: Input must be a number and not NaN or NA
# -----------------------------------------------------------------

# Input your number here:
x <- 6

# If-else if-else statement:
if (x > 0){
  print ('Positive Number')
} else if (x < 0){
  print ('Negative Number')
} else {
  print ('Zero Number')
}

# -----------------------------------------------------------------
# EXAMPLE 3: For loop to compute the k-th factorial
# -----------------------------------------------------------------

# Order of the factorial
k <- 6

# For loop to compute the factorial
x <- 1
for (i in 1:k) {
  x <- x*i
}

# Print the result
print(x)

# Check of the result
factorial(k)

# Alternative check
sum(prod(1:k))

# -----------------------------------------------------------------
# EXAMPLE 4: Foor loop to simulate the random walk process
# of the stock price with drift mju and volatility sigma
# -----------------------------------------------------------------

# Parameters
S0 <- 100   # Current stock price
mju <- 0.5   # Drift rate per day
sigma <- 3  # Volatility per day
t <- 252    # Number of days of the simulation

# Empty vector to which we will write the stock price evolution
S <- rep(NaN,t+1)
S[1] <- S0

# For loop to simulate the stock price evolution
for (i in 2:(t+1)){
  # Simulate the stock price in day i
  S[i] <-  S[i-1] + rnorm(1,mju,sigma)
}

# Draw the stock price evolution
plot(S)
title('Stock price - Arithmetic Brownian Motion')

# --------------------------------------------------------------------
# ALTERNATIVE: Simulate the random walk process using cumsum function
# --------------------------------------------------------------------
S <- c(S0,S0+cumsum(rnorm(t,mju,sigma)))
plot(S)
title('Stock price - Arithmetic Brownian Motion')

# ---------------------------------------------------------------------
# EXAMPLE 5: For lopp with break statement to identify the firm default
# ---------------------------------------------------------------------

# Parameters
S0 <- 100   # Current stock price
mju <- 0.5   # Drift rate per day
sigma <- 3  # Volatility per day
t <- 252    # Number of days of the simulation

# Empty vector to which we will write the stock price evolution
S <- rep(NaN,t+1)
S[1] <- S0

# For loop to simulate the stock price evolution
for (i in 2:(t+1)){
  # Simulation:
  S[i] <-  S[i-1] + rnorm(1,mju,sigma)
  # Evaluation of the default event:
  if (S[i] <= 0){
    print(paste('Company defaulted on day', i-1))
    break
  }
}

# Draw the stock price evolution
plot(S)
title('Stock price - Arithmetic Brownian Motion')

# --------------------------------------------------------------------------
# EXAMPLE 6: While loop to simulate the stock price evolution
# until default or until or until a profit target (PT) is reached
# --------------------------------------------------------------------------

# Parameters
S0 <- 100   # Current stock price
mju <- 0.5   # Drift rate per day
sigma <- 3  # Volatility per day
PT <- 1000 # Profit target

# While loop to simulate the stock price evolution until default or reaching of PT
S <- S0
Si <- S0 
while ((Si>=0) & (Si<=PT)) {
  # Simulate the stock price on day i
  Si <-  Si + rnorm(1,mju,sigma)
  # Append Si to the price evolution
  S <- c(S,Si)
}

# Draw the stock price evolution
plot(S,type="l")
title('Stock price - Arithmetic Brownian Motion')

# --------------------------------------------------------------------------
# EXAMPLE 7: Repeat-Break loop to simulate the stock price evolution
# until default or until or until a profit target (PT) is reached
# --------------------------------------------------------------------------

# Parameters
S0 <- 100   # Current stock price
mju <- 0.5   # Drift rate per day
sigma <- 3  # Volatility per day
PT <- 1000 # Profit target

# Repeat-Break loop to simulate the stock price evolution until default or reaching of PT
S <- S0
Si <- S0
i <- 0
repeat {
  # Counter
  i <- i+1
  # Simulate the stock price on day i
  Si <-  Si + rnorm(1,mju,sigma)
  # Append Si to the price evolution
  S <- c(S,Si)
  # Break the loop
  if (Si <= 0){
    print(paste('Company defaulted on day', i))
    break
  } else if (Si >= PT){
    print(paste('Company reached PT on day', i))
    break
  }
}

# Draw the stock price evolution
plot(S,type="l")
title('Stock price - Arithmetic Brownian Motion')

