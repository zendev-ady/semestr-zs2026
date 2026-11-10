# --------------------------------------------------------------------------
# LECTURE 1 - PART 6 - LISTS AND DATA FRAMES
# --------------------------------------------------------------------------

# -----------------------------------------------------------------
# EXAMPLE 1: Creating lists and list indexing
# -----------------------------------------------------------------

# Create a list of elements of different types:
x <- list(5, 3L, 2+1i, NULL, 'Hello', TRUE, c(3,6,9), matrix(1:9,3,3))
print(x)

# List indexing - Select part of a list
y <- x[1]
print(y)
typeof(y)
class(y)

# List indexing - Select element in a list
z <- x[[1]]
print(z)
typeof(z)
class(z)

# You can also select elements from a vector in a list as follows
x[[4]][2]

# Or change then
x[[4]][2] <-12
print(x[4])

# List can also contain other lists
w <- list(list(10,20,30),list('Hello',NULL,c(5,10,15)))
print(w)

# And then access them with
w[[1]][[3]]
w[[2]][[2]]
w[[2]][[3]][1]

# Take note that this is different from joining of two lists
v <- c(list(10,20,30),list('Hello',NULL,c(5,10,15)))

# -----------------------------------------------------------------
# EXAMPLE 2: Lists with named variables vs. data frames
# -----------------------------------------------------------------

# Let us create an illustratory scoring model dataset
ID <- c(1,2,3,4,5)
LoanType <- c('Consumer','Mortgage','CreditCard','Consumer','Consumer')
LoanSize <- c(100000,1000000,50000,70000,20000)

# Create a named list with the dataset
Data <- list('ID'=ID,'LoanType'=LoanType,'LoanSize'=LoanSize)
print(Data)

# You can then reference the elements in the list by name:
Data$ID
Data$LoanType
Data$LoanSize

Data$LoanSize[3:5]

Data['LoanSize']

# Take note:

# This will produce a list
Data[3]
Data['LoanSize']

# This will produce a vector
Data[[3]]
Data$LoanSize

# To select a single element you can use:
Data[[3]][3]
Data$LoanSize[3]

# Save the variables instead into a data frame
DataF <- data.frame(ID, LoanType, LoanSize)
print(DataF)

# Compare
print(Data)
print(DataF)

# R views data frames as a type of list
typeof(Data)
class(Data)
typeof(DataF)
class(DataF)

# Referencing data frame is similar as for named lists
DataF$ID
DataF$LoanType
DataF$LoanSize

# Take note
x <- DataF$LoanSize
y <- DataF['LoanSize']
print(x)
print(y)
class(x)
class(y)

# Benefit of data frames vs. lists is that you can reference by row

# Referencing by column
DataF[3]   # To get a data frame
DataF[[3]] # To get vector
DataF[,3]  # To also get a vector

# Referencing by row
DataF[3,]  # To get data frame (as the variables are of differenty type)

# You can transform the row to vector like this (but only for numeric values)
as.numeric(DataF[3,])

# Or like this to get everything as character
as.character(DataF[3,])

# -----------------------------------------------------------------
# EXAMPLE 3: Regression function with multiple outputs
# -----------------------------------------------------------------

# True parameters
b <- c(1.2,0.9,-0.7) # Parameter vector
sigma <- 0.3 # Error variance

# Number of parameters  (1st is for constant)
k <- length(b)

# Simulate the dataset (assuming std. norm. distribution for X)
N <- 50                   # Number of observations
X <- matrix(rnorm((k-1)*N),nrow=N,ncol=(k-1))  # Predictors
X <- cbind(rep(1,N),X)    # Add constant to the matrix
e <- rnorm(N)*sigma       # Random noise in y
y <- X %*% b + e          # Compute output

# Linear regression function to estimate b from the noisy data
mylinreg = function(X,y) {
  
  # System time
  t1 <- Sys.time()
  
  # Compute the coefficients
  XXi <- solve(t(X) %*% X)
  be <- XXi %*% t(X) %*% y 
  
  # Compute predictions
  yf <- X %*% be
  
  # Compute residuals
  res <- y - yf
  
  # Standard error of residuals
  n <- dim(X)[1]
  k <- dim(X)[2]
  s <- sqrt(sum(res^2)/(n-k)) 
  
  # Parameter standard errors, t-values and p-values
  stdMat <- (s^2)*XXi
  se <- sqrt(diag(stdMat))
  t <- be/se
  p <- 2*(1-pt(abs(t),n-k))
  
  # Summary
  stats <- cbind(be,se,t,p)
  colnames(stats) <- c('coeff','se','t','p')
  
  # Calculation time
  t2 <- Sys.time()
  
  # System time
  tcalc <- t2-t1
  
  # Save outputs to a list
  Results <- list('coeff'=be, 'se'=se, 't'=t, 'p'=p, 'stats'=stats,
                  'fit'=yf, 'res'=res, 'sigma'=s, 'tcalc'=tcalc)
  
  # Save results
  return(Results)
  
}

# Apply the function
Results <- mylinreg(X,y)

# You can then access the variables from the list
Results$coeff
Results$p
Results$stats

# Check of the result
fit <- lm(y ~ 0 + X)
summary(fit)

Results$stats