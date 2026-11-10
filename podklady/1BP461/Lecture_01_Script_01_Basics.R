# -----------------------------------------------------------------
# LECTURE 1 - PART 1 - INTRODUCTION AND BASIC OPERATIONS
# -----------------------------------------------------------------

# -----------------------------------------------------------------
# EXAMPLE 1: Script to write "Hello"
# -----------------------------------------------------------------

# Script to print 'Hello'
print('Hello')

# -----------------------------------------------------------------
# EXAMPLE 2: Variable assignment
# -----------------------------------------------------------------

# Create variable x as numeric
x <- 5
print(x)
class(x)
typeof(x)

# Create variable x as integer
x <- 5L
print(x)
class(x)
typeof(x)

# Create variable x as complex
x <- 5+2i
print(x)
class(x)
typeof(x)

# Create variable x as logical
x <- 'Hello'
print(x)
class(x)
typeof(x)

# Create variable x as raw
x <- charToRaw('Hello')
print(x)
class(x)
typeof(x)

# -----------------------------------------------------------------
# EXAMPLE 2: Basic mathematical operations
# -----------------------------------------------------------------

# Assign variables x and y
x <- 2
y <- 3

# Compute product into variable z
z <- x + y
print(z)

# Basic mathematical operations
x + y
x - y
x * y
x / y
x ^ y
x ** y

# Modulo
x %% y
19 %% 5

# Integer division
x %/% y
19 %/% 5

# Basic mathematical functions

# Absolute value
abs(-10)

# Square root
sqrt(9)

# Exponent
exp(1)
exp(2)

# Natural logarithm
log(exp(1))

# Decadic logarithm
log10(100)

# Logarithm with base 2
log2(8)

# Factorial
factorial(5)

# Check
1*2*3*4*5

# Combinations
choose(10,4)

# Check
factorial(10)/(factorial(4)*factorial(6))

# Sign
sign(100)
sign(-100)
sign(0)

# Rounding (try also with minus)
x <- 1.555
round(x)
floor(x)
ceiling(x)
trunc(x)

# Rounding to more digits
round(x,2)

# Trigonometric
sin(pi) # Not zero because of pi imprecision
cos(pi)
tan(pi)
sin(pi)/cos(pi)
1/tan(pi)

# Undefined numbers
0/0
Inf/Inf

# Take note that this gives NaN as -1 is viewed as real:
sqrt(-1)

# To get the correct (imaginary) result:
sqrt(-1+0i)

# Check for NaN
is.NaN(NaN)
is.NaN(NA)
is.NA(NaN)
is.NA(NA)

# -----------------------------------------------------------------
# EXAMPLE 2: Basic logical operations
# -----------------------------------------------------------------

# Assign variables x and y
x <- 2
y <- 3

# Logical statements
x < y
x > y
x == y
x != y

# Logical operators

# Negation
!T

# AND
T & T
T & F
F & T
F & F

# OR
T | T
T | F
F | T
F | F

# XOR
xor(T,T)
xor(T,F)
xor(F,T)
xor(F,F)

# NA values
F & NA
T & NA
T & isTRUE(T)

# All
all(T,T,T)
all(T,T,F)

# Any
any(T,T,T)
any(T,T,F)

# -----------------------------------------------------------------
# EXAMPLE 2: Other usefull functions
# -----------------------------------------------------------------

# Print
x < - 2
print(x)
x

# NULL
x <- 2
y <- 3
z <- NULL

# NULL means empty (cannot be joined with others)
c(x,y)
z
c(NULL,x,y)
c(NULL,NA,NaN,x,y)

# Sys.time
Sys.time()
Sys.Date()

# Help operator
?NULL
?all





