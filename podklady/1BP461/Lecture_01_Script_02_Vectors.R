# -----------------------------------------------------------------
# LECTURE 1 - PART 2 - VECTORS AND SEQUENCES
# -----------------------------------------------------------------

# -----------------------------------------------------------------
# EXAMPLE 1: Creating vectors and vector indexing
# -----------------------------------------------------------------

# Create numeric vector (of zeros) of size 6
numeric(6)

# Create logical vector (of FALSE) of size 6
logical(6)

# Create empty character vector of size 6
character(6)

# Create custom vector
c(1,2,-2,5,3.5,pi) 
c(T,T,F,T,F,F)  
c('A','B','C','D','E','F')

# You can also try:
LETTERS
letters
month.name
month.abb

# Vector as a sequence
1:10
seq(1,10,2)
seq(2,10,2)
seq(20,-20,-5)

# Repeating numbers or vectors
rep(5,5)
rep(1:3,3)
rep(1:3,each=3)

# Vector indexing
z <- c(10,20,30,40,50)
z[2]
z[2:4]
z[c(1,3,5)]
z[-3]
z[c(F,T,F,T,F)]

# -----------------------------------------------------------------
# EXAMPLE 2: Vector operations and functions
# -----------------------------------------------------------------

# Concaneate
x <- c(10,20,30)
y <- c(40,50)
z <- c(x,y) 
print(z)

# Replicate
rep(x,3)
rep(x,each=3)

# Length, sum, prod, max, min, cumsum, cumprod,cummax,cummin,diff
length(x)
sum(x)
prod(x)
max(x)
min(x)
cumsum(x)
cumprod(x)
cummax(x)
cummin(x)
diff(x)

# Sort, rank and order
z <- c(20,30,50,10,40)
print(z)
sort(z)
rank(z)
order(z)

# Other types of sort
sort(z)
sort(z, decreasing=TRUE)

# Take note that
z[order(z)]
z[order(-z)]

# Which can be used to get the n largest and n smallest values
z[order(z)[1:3]]
z[order(-z)[1:3]]

# Unique function
z <- c(1,2,5,3,2,1,2,4,2,NA,NA,NaN,NaN,Inf,-Inf)
unique(z)

# Head and tail
head(z,3)
tail(z,3)

# sapply
x <- c(1,4,9,16,25,36)
sqrt(x)
sapply(x,sqrt)

# -----------------------------------------------------------------
# EXAMPLE 3: Logical functions
# -----------------------------------------------------------------

# Relational vector relations
x <- c(1,2,2)
y <- c(2,1,2)
x > y
y < x
y == x

# Logical vector operations
x <- c(T,T,F,F)
y <- c(T,F,T,F)
x & y
!(x & y)
x | y
!(x | y)
xor(x,y)
!xor(x,y)

# All and Any
z <- c(T,T,T,T,F)
all(z)
any(z)

# %IN% operator and which function

# Create some variables (try also with two vectors)
x <- 3
y <- c(1,2,3,1,2,3)

# Contains operator
x %in% y
y %in% x

# Which
which(y==x)

# Try with vectors
x <- c(1,3,5)
y <- c(1,2,3,4)

# Contains operator
x %in% y
y %in% x

# Which
which(y %in% x)

# %notin% operator
'%notin%' <- Negate('%in%')

# Try with vectors
x <- c(1,3,5)
y <- c(1,2,3,4)

# Which elements of x are (or are not) in y
x %in% y
x %notin% y

# Which elements of y are (or are not) in x
y %in% x
y %notin% x

# -----------------------------------------------------------------
# EXAMPLE 4: Mathematical operations on vectors
# -----------------------------------------------------------------

# Addition
x <- c(1,2,3,4,5)
y <- c(2,4,6,8,10)

# Element-wise operations
x + y
x - y
x * y
x / y
x ^ y
x ^ (1/y)

# Vector operations
x * y
x %*% y
x %o% y

# Check
sum(x*y)

# Create vector x
x <- seq(0.01,10,by=0.1)
plot(x)
title('Line')

# Logarithm
y <- log(x)
plot(x,y)
title('Natural logarithm')

# Exponent
y <- exp(x)
plot(x,y)
title('Natural exponent')

# Square root
y <- sqrt(x)
plot(x,y)
title('Square root')

# Second power
y <- x^2
plot(x,y)
title('Second power')

# Sine
y <- sin(x)
plot(x,y)
title('Sine')

# Cosine
y <- cos(x)
plot(x,y)
title('Cosine')

# Tangens
y <- tan(x)
plot(x,y)
title('Tangens')

# Cotangens
y <- 1/tan(x)
plot(x,y)
title('Cotangens')

# -----------------------------------------------------------------
# EXAMPLE 5: Statistical functions
# -----------------------------------------------------------------

# Statistical distributions
x <- seq(-5,5,by=0.1)

# Gaussian pdf
y <- dnorm(x)
plot(x,y,type='l')
title('Standard Gaussian pdf')

# Gaussian cdf
y <- pnorm(x)
plot(x,y,type='l')
title('Standard Gaussian cdf')

# Quantile function
p <- seq(0.01,0.99,by=0.01)
y <- qnorm(p)
plot(p,y,type='l')
title('Standard Gaussian quantile function')

# Generate random numbers

# Size
k <- 1000

# Standard normal
x <- rnorm(k)
hist(x)

# Gaussian (non-standard)
mju=2
sigma=3
x <- rnorm(k,2,3)
hist(x)

# Uniform
x <- runif(k)
hist(x)

# Exponential
x <- rexp(k,0.01)
hist(x)

# Summary statistics
x <- rnorm(k,2,3)
mean(x)
median(x)
sd(x)
var(x)
scale(x)

# Check
(x-mean(x))/sd(x)

# Quantiles
quantile(x)
quantile(x,c(0.1,0.5,0.9))

# t-test (try for different k)
k <- 10
x <- rnorm(k,2,3)
hist(x)
t.test(x,mu=0)
t.test(x,mu=1)
t.test(x,mu=2)
t.test(x,mu=3)

# CORRELATION

# Correlation
k=1000

# Positive correlation
rho=0.6
x <- rnorm(k)
y <- rho*x + sqrt(1-rho^2)*rnorm(k)
plot(x,y)
title(paste0("Correlation: ",rho))
cor(x,y)
cor.test(x,y)

# Negative correlation
rho=-0.6
x <- rnorm(k)
y <- rho*x + sqrt(1-rho^2)*rnorm(k)
plot(x,y)
title(paste0("Correlation: ",rho))
cor(x,y)
cor.test(x,y)

# No correlation
rho= 0
x <- rnorm(k)
y <- rho*x + sqrt(1-rho^2)*rnorm(k)
plot(x,y)
title(paste0("Correlation: ",rho))
cor(x,y)
cor.test(x,y)

# Properties of correlation
x <- seq(-3,3,by=0.1)
k <- length(x)

# Positive correlation
y <- 2 + 3*x
cor(x,y)
plot(x,y)
title(paste0("Correlation: ",round(cor(x,y),2)))
y <- 2 + 3*x + rnorm(k)
cor(x,y)
plot(x,y)
title(paste0("Correlation: ",round(cor(x,y),2)))
y <- 2 + 3*x + 5*rnorm(k)
cor(x,y)
plot(x,y)
title(paste0("Correlation: ",round(cor(x,y),2)))

# Negative correlation
y <- 2 - 3*x
cor(x,y)
plot(x,y)
title(paste0("Correlation: ",round(cor(x,y),2)))
y <- 2 - 3*x + rnorm(k)
cor(x,y)
plot(x,y)
title(paste0("Correlation: ",round(cor(x,y),2)))

# Non-Linear dependencies
y <- 2 + 3*exp(x)
cor(x,y)
plot(x,y)
title(paste0("Correlation: ",round(cor(x,y),2)))

# Pearson vs. Rank correlation
# Pearson correlation
cor(x,y)
cov(x,y)/(sd(x)*sd(y))
cor(x,y,method="pearson")
# Spearman rank correlation
cor(rank(x),rank(x))
cor(x,y,method="spearman")
# Kendall rank correlation
cor(x,y,method="kendall")

# Monotonic dependencies
y <- 2 + 3*(sign(x)*abs(x)^3)
cor(x,y)
plot(x,y)
title(paste0("Correlation: ",round(cor(x,y),2)))
cor(x,y,method="pearson")
cor(x,y,method="spearman")
cor(x,y,method="kendall")

# Non-monotonic dependencies
y <- 2 + 3*(x^2)
cor(x,y)
plot(x,y)
title(paste0("Correlation: ",round(cor(x,y),2)))
cor(x,y,method="pearson")
cor(x,y,method="spearman")
cor(x,y,method="kendall")

y <- 2 + 3*sin(x)
cor(x,y)
plot(x,y)
title(paste0("Correlation: ",round(cor(x,y),2)))
cor(x,y,method="pearson")
cor(x,y,method="spearman")
cor(x,y,method="kendall")


# A. Linear regression - Univariate with constant

# Data preparation
k=500
b0 = 1
b1 = 2
sigma = 3
x <- rnorm(k)
y <- b0 + b1*x + sigma*rnorm(k)
plot(x,y)
title(paste0("y = ",b0," + ",b1," + ",sigma,"*e"))

# Compute regression coefficients
be <- lm(y~x)
be$coefficients
summary(be)

# We can also estimate sigma with
sd(be$residuals)

# Take note that this gives the same result
be <- lm(y~1+x)
be$coefficients
summary(be)

# But this give different
be <- lm(y~0+x)
be$coefficients
summary(be)

# B. Linear regression - Univariate without constant
k=10
b1 = 2
sigma = 3
x <- rnorm(k)
y <- b1*x + sigma*rnorm(k)

# Compute regression coefficients
be <- lm(y~0+x)
be$coefficients
summary(be)

# C. Multivariate linear regression with constant
k=10000
b0 = 1
b1 = 2
b2 = -3
sigma = 3
x1 <- rnorm(k)
x2 <- rnorm(k)
y <- b0 + b1*x1 +b2*x2 + sigma*rnorm(k)

# Compute regression coefficients
be <- lm(y ~ x1 + x2)
be$coefficients

# To get p-values and other statistis, you can use
summary(be)

# ---------------------------
# Linear regression plot
# ---------------------------

# Data preparation
k=100
b0 = 1
b1 = 2
sigma = 3
x <- rnorm(k)
y <- b0 + b1*x + sigma*rnorm(k)

# Compute regression coefficients
be <- lm(y~x)
be$coefficients
summary(be)

yf <- be$coefficients[1] + be$coefficients[2]*x

plot(x,y,col=2)
lines(x,yf,col=1)
title('OLS regression fit')

# -------------------------------
# Non-Linear regression
# -------------------------------

# Generate data
x <- seq(0.1,30,0.2)
b <- c(3,3,0.2)
ye <- b[1]*exp(-b[2]*exp(-b[3]*x))
plot(x,ye,type="l")
title("Gompertz curve")

# Generate noisy data
n <- length(x)
s <- 0.3
e <- rnorm(n)*s
y <- ye + e

# Plot on chart (signal+noisy)
plot(x,y,col=2)
lines(x,ye,col=4,lty=2)
title("Gompertz curve dataset")

# Raw dataset
plot(x,y)
title("Raw data sample")

# OLS based methods

# Linear fit
fit <- lm(y ~ x)
summary(fit)
yf <- predict(fit)
# Fit chart
plot(x,y,col=2)
lines(x,yf,col=1)
title("Linear fit")
lines(x,ye,col=4,lty=2)
legend(25, 0.3, legend=c("Fit", "Reality"), 
       col=c(1,4),lty = c(1,2), cex=0.8)

# Residual chart
plot(fit$residuals,col=2)
abline(h=0,col=1)
title("Linear fit - Residuals")

# Quadratic fit
x2 <- x^2
fit <- lm(y ~ x + x2)
summary(fit)
yf <- predict(fit)
# Fit chart
plot(x,y,col=2)
lines(x,yf,col=1)
title("Quadratic fit")
lines(x,ye,col=4,lty=2)
legend(25, 0.3, legend=c("Fit", "Reality"), 
       col=c(1,4),lty = c(1,2), cex=0.8)

# Cubic fit
x3 <- x^3
fit <- lm(y ~ x + x2 + x3)
summary(fit)
yf <- predict(fit)
# Fit chart
plot(x,y,col=2)
lines(x,yf,col=1)
title("Cubic fit")
lines(x,ye,col=4,lty=2)
legend(25, 0.3, legend=c("Fit", "Reality"), col=c(1,4),lty = c(1,2), cex=0.8)

# Drawback of polynomial models - Extrapolation
if (FALSE) {
  xOut <- seq(0.1,40,0.2)
  be <- fit$coefficients
  yOut <- be[1] + be[2]*xOut + be[3]*(xOut^2) + be[4]*(xOut^3)
  plot(xOut,yOut,type="l")
  points(x,y,col=2)
  title("Cubic fit extrapolation") 
}

# Logarithmic fit
logx <- log(x)
fit <- lm(y ~ logx)
summary(fit)
yf <- predict(fit)
# Fit chart
plot(x,y,col=2)
lines(x,yf,col=1)
title("Logarithmic fit")
lines(x,ye,col=4,lty=2)
legend(25, 0.3, legend=c("Fit", "Reality"), col=c(1,4),lty = c(1,2), cex=0.8)

# Logarithmic fit - Modified
logx <- log(x+1)
fit <- lm(y ~ logx)
summary(fit)
yf <- predict(fit)
# Fit chart
plot(x,y,col=2)
lines(x,yf,col=1)
title("Shifted logarithmic fit")
lines(x,ye,col=4,lty=2)
legend(25, 0.3, legend=c("Fit", "Reality"), col=c(1,4),lty = c(1,2), cex=0.8)


# Square root fit
sqrtx <-sqrt(x)
fit <- lm(y ~ sqrtx)
summary(fit)
yf <- predict(fit)
# Fit chart
plot(x,y,col=2)
lines(x,yf,col=1)
title("Square root fit")
lines(x,ye,col=4,lty=2)
legend(25, 0.3, legend=c("Fit", "Reality"), col=c(1,4),lty = c(1,2), cex=0.8)

# Approximation 2 - Piecewise linear fit
x2 <- x
x2[x<15] <- 0
x2[x>=15] <- x2[x>=15]-15
x
x2
fit <- lm(y ~ x + x2)
summary(fit)
yf <- predict(fit)
# Fit chart
plot(x,y,col=2)
lines(x,yf,col=1)
title("Piecewise linear fit")
lines(x,ye,col=4,lty=2)
legend(25, 0.3, legend=c("Fit", "Reality"), col=c(1,4),lty = c(1,2), cex=0.8)

# Non-parametric regression

# LOWESS
fit <- lowess(x, y)
summary(fit)
yf <- fit$y
plot(x,y,col=2)
lines(x,yf,col=1)
title("LOWESS fit")
lines(x,ye,col=4,lty=2)
legend(25, 0.3, legend=c("Fit", "Reality"), col=c(1,4),lty = c(1,2), cex=0.8)

# Non-Linear regression

# R function
b0 <- list(b1=1,b2=1,b3=0.5)
fit = nls(y ~ b1*exp(-b2*exp(-b3*(x))), start=b0)
summary(fit)
b0
b
coef(fit)
yf <- predict(fit)
# Fit chart
plot(x,y,col=2)
lines(x,yf,col=1)
title("Non-Linear regression fit")
lines(x,ye,col=4,lty=2)
legend(25, 0.3, legend=c("Fit", "Reality"), col=c(1,4),lty = c(1,2), cex=0.8)


