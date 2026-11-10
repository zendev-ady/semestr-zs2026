# -----------------------------------------------------------------
# LECTURE 1 - PART 5 - MATRIX OPERATIONS
# -----------------------------------------------------------------

# Create a NA matrix
matrix(nrow=3,ncol=4)

# Convert vector into a matrix
matrix(1:6,2,3)

# Create a diagonal matrix
diag(5)
diag(c(1:5))

# Bind vectors into a matrix
x <- c(1,2,3)
y <- c(4,5,6)
cbind(x,y)
rbind(x,y)

# Dimensions of a matrix
z <- cbind(x,y)
print(z)
dim(z)
nrow(z)
ncol(z)
length(z)

# Extract matrix diagonal
diag(z)
x <- diag(c(1:3))
diag(x)

# Bind matrices columnwise
x <- diag(c(1:3))
y <- diag(c(4:6))
cbind(x,y)
rbind(x,y)

# Convert matrix to vector
as.vector(x)

# Matrix referencing
z <- matrix(1:6,2,3)
print(z)

z[1,2]
z[2,3]
z[2,]
z[,2]
z[-2,]
z[,-2]
z[,1:2]

# Naming matrix rows and columns
rownames(z) <- c('a','b')
colnames(z) <- c('A','B','C')
z['b',]
z[,'B']

# Matrix operations
x <- matrix(1:9,3,3) 
y <- matrix(10:18,3,3)
x
y
x + y
x - y
x * y
x / y
x %*% y
x %o% y

# Matrix times vector
x <- matrix(1:9,3,3)
y <- (1:3)
x %*% y
y %*% x
x %o% y
y %o% x

# Matrix operations
x <- matrix(rnorm(9),3,3)
print(x)
t(x)
solve(x)
eigen(x)
svd(x)
chol(x)
qr(x)

# Some other functions
rowSums(x)
colSums(x)
rowMeans(x)
colMeans(x)
apply(x,1,max)
apply(x,2,max)
apply(x,1,min)
apply(x,2,min)

# --------------------------------------------------------------------------
# EXAMPLE 1: MULTIVARIATE LINEAR REGRESSION FUNCTION
# --------------------------------------------------------------------------

# True parameters
b <- c(1.2,0.9,-0.7) # Parameter vector
sigma <- 0.3 # Error variance

# Number of parameters  (1st is for constant)
k <- length(b)

# Simulate the dataset (assuming std. norm. distribution for X)
N <- 10000                   # Number of observations
X <- matrix(rnorm((k-1)*N),nrow=N,ncol=(k-1))  # Predictors
X <- cbind(rep(1,N),X)    # Add constant to the matrix
e <- rnorm(N)*sigma       # Random noise in y
y <- X %*% b + e          # Compute output

# You can check that the procedure indeed applies the model:
b[1]*X[1,1] + b[2]*X[1,2] + b[3]*X[1,3] + e[1]
b[1]*X[2,1] + b[2]*X[2,2] + b[3]*X[2,3] + e[2]

# Linear regression function to estimate b from the noisy data
mylinreg = function(X,y) {
  be <- solve(t(X) %*% X) %*% t(X) %*% y 
  return(be)
}

# Alternative using inline function
mylinreg2 = function(X,y) solve(t(X) %*% X) %*% t(X) %*% y 

# Apply the model:
be <- mylinreg(X,y)
print(as.vector(be))

# Compare the true parameters and the fit
comp <- cbind(b,round(be,4),round(b-be,4))
colnames(comp) <- c('b','be','err')
print(comp)

# Alternative 1 - Use the R lm function
fit <- lm(y ~ X[,-1])
fit#coefficients

# Alternative 2 - Use the R lm function
fit <- lm(y ~ 1 + X[,-1])
fit#coefficients

# Alternative 3 - Use the R lm function
fit <- lm(y ~ 0 + X)
fit#coefficients
