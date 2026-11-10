# ------------------------------------------------------------------------------
# PORTFOLIO OPTIMIZATION BASED ON ETFs - UPDATED
# ------------------------------------------------------------------------------

# LOAD TIDYQUANT PACKAGES
library(e1071)
library(MASS)
library(glmnet)
library(tidyverse)
library(readxl)
library(writexl)
library(tidyquant)
library(broom)

# LOAD ETF PRICES

# ETF tickers
# SPY = SPDR S&P 500 ETF Trust (SPY)
# IWM = iShares Russell 2000 ETF (IWM)
# EFA = iShares MSCI EAFE ETF (EFA)
# EEM = iShares MSCI Emerging Markets ETF (EEM)
# VNQ = Vanguard Real Estate Index Fund (VNQ)
# DBC = Invesco DB Commodity Index Tracking Fund (DBC)
# IEF = iShares 7-10 Year Treasury Bond ETF (IEF)
# TLT = iShares 20+ Year Treasury Bond ETF (TLT)
# IAU = iShares Gold Trust (IAU)
# QQQ = Invesco QQQ Trust (QQQ)
# HYG = iShares High Yield Corporate Bond ETF (HYG)

# Settings:
symbols = c("SPY","VNQ","TLT")
symbols = c("SPY","EFA","EEM","VNQ","TLT","IAU","HYG")
tStart <- "1990-01-01"
tEnd   <- today() - 1

# Load stock prices
data <- tq_get(symbols, get = "stock.prices", from = tStart, to = tEnd)

# Find the common dataset start
startDate <- data %>%
  group_by(symbol) %>%
  summarize(date = min(date))

# Filter the dataset
tStart <- max(startDate$date)
data2 <- data %>%
  filter(date>=tStart)

# Compute returns
data2 <- data2 %>%
  group_by(symbol) %>%
  mutate(logprice = log(adjusted),
         return = logprice - lag(logprice,1),
         return = ifelse(is.na(return),0,return),
         returnS = exp(return)-1,
         cumreturn = cumprod(1+returnS),
         drawdown = (cumreturn/cummax(cumreturn))-1)

# Dataset bounds
dStart <- min(data2$date)
dEnd <- max(data2$date)

# Plot cumulative returns
gChart01 <- data2 %>%
  ungroup() %>%
  ggplot(aes(x = date, y = cumreturn, color = symbol)) +
  geom_line(size = 1) +
  labs(title = paste0("Selected ETF returns - Daily (",dStart," to ",dEnd,")"),
       subtitle = paste0("Selected ETF returns - Daily, Source: YahooFinance.com")) +
  scale_y_continuous(labels = scales::percent)
print(gChart01)

# Plot drawdowns
gChart02 <- data2 %>%
  ungroup() %>%
  ggplot(aes(x = date, y = drawdown, color = symbol)) +
  geom_line(size = 1) +
  labs(title = paste0("Selected ETF return drawdowns - Daily (",dStart," to ",dEnd,")"),
       subtitle = paste0("Selected ETF return drawdowns - Daily , Source: YahooFinance.com")) +
  scale_y_continuous(labels = scales::percent)
print(gChart02)

# Convert to monthly
mdata <- data2 %>%
  mutate(year = year(date),
         month = month(date)) %>%
  group_by(symbol,year,month) %>%
  summarize(date = max(date),
            return = sum(return),
            rvar = sum(return^2)) %>%
  ungroup() %>%
  mutate(returnS = exp(return)-1)

# Plot cumulative returns
gChart03 <- mdata %>%
  ungroup() %>%
  group_by(symbol) %>%
  mutate(cumreturn = cumprod(1+returnS)) %>%
  ggplot(aes(x = date, y = cumreturn, color = symbol)) +
  geom_line(size = 1) +
  labs(title = paste0("Selected ETF returns - Monthly (",dStart," to ",dEnd,")"),
       subtitle = paste0("Selected ETF returns - Monthly, Source: YahooFinance.com")) +
  scale_y_continuous(labels = scales::percent)
print(gChart03)

# Compute mean and st.dev of returns
# NOTE: CHECK IF ITS BETTER TO DO IT BASED ON SIMPLE VS. LOG RETURNS
msummary <- mdata %>%
  group_by(symbol) %>%
  summarize(mju = mean(returnS),
            sigma = sd(returnS))

# Extract return data
mreturns <- mdata %>%
  select(symbol,date,returnS) %>%
  spread(symbol,returnS) %>%
  select(date,symbols)
mreturns2 <- mreturns %>%
  select(symbols)

# Convert to matrix
ret <- mreturns2 %>%
  select(symbols)
ret <- as.matrix(ret)

# Compute parameters
mju <- colMeans(ret)
covmat <- cov(ret)
cormat <- cor(ret)
sigma <- diag(covmat)^(1/2)

# In-Sample estimation
if (FALSE) {
  
  # Extract return data - In-Sample
  sYear <- 2019
  mreturnsIn <- mdata %>%
    filter(year(date)<=sYear) %>%
    select(symbol,date,returnS) %>%
    spread(symbol,returnS) %>%
    select(date,symbols)
  mreturnsIn2 <- mreturnsIn %>%
    select(symbols)
  
  # Convert to matrix - In-Sample
  retIn <- mreturnsIn2 %>%
    select(symbols)
  retIn <- as.matrix(retIn)
  
  # Compute parameters
  mju <- colMeans(retIn)
  covmat <- cov(retIn)
  cormat <- cor(retIn)
  sigma <- diag(covmat)^(1/2)
  
}

# Compute benchmark portfolios:
w_ew <- rep(1/length(mju),length(mju)) # Equal-weight portfolio
w_rp <- (1/sigma)/sum(1/sigma) # Naive risk-parity portfolio

# Compute Markowitz portfolios:
rf <- 0.03/12
w_mv <- (ginv(covmat) %*% rep(1,length(mju))) / sum(ginv(covmat) %*% rep(1,length(mju)))
w_ta <- (ginv(covmat) %*% (as.vector(mju)-rf)) / sum(ginv(covmat) %*% (as.vector(mju)-rf))

# Compute Kelly portfolio
w_ke <- (1+rf)*ginv(covmat) %*% (mju-rf)

# ------------------------------------------------------------------------------
# Constrained optimization (long-only) - START
# ------------------------------------------------------------------------------

# Load pracma library
library(pracma)

# Sharpe ratio function
mysharpe = function(w,mju,covmat,rf) {
  mw <- as.vector(t(w) %*% mju)
  sw <- as.vector((t(w) %*% covmat %*% w)^(1/2))
  Sharpe <- (mw-rf)/sw
  return(Sharpe)
}

# Objective function
objective = function(w) {
  obj <- -mysharpe(w,mju,covmat,rf)
  return(obj)
}

# Set constrains - Maximum and minimum weights
wmin <- numeric(length(mju))
wmax <- numeric(length(mju))+1

# Set constrains - Sum of weights equals to one
Aeq = t(rep(1,length(mju)))
beq = 1

# Run optimization
opt <- fmincon(w_ew, objective, Aeq = Aeq, beq = beq, lb = wmin, ub = wmax)

# Save long-only tangency portfolio weights
w_tc <- opt$par

# Check - Numerical optimization - Tangency portfolio without constrains
optTest <- fmincon(w_ew, objective, Aeq = Aeq, beq = beq)
w_ta_check <- optTest$par
t(w_ta)
w_ta_check

# ------------------------------------------------------------------------------
# Constrained optimization (long-only) - END
# ------------------------------------------------------------------------------

# Compute portfolio characteristics
m_ew <- mju %*% w_ew
m_rp <- mju %*% w_rp
m_mv <- mju %*% w_mv
m_ta <- mju %*% w_ta
m_tc <- mju %*% w_tc
v_ew <- sqrt(w_ew %*% covmat %*% w_ew)
v_rp <- sqrt(w_rp %*% covmat %*% w_rp)
v_mv <- sqrt(as.vector(w_mv) %*% covmat %*% as.vector(w_mv))
v_ta <- sqrt(as.vector(w_ta) %*% covmat %*% as.vector(w_ta))
v_tc <- sqrt(as.vector(w_tc) %*% covmat %*% as.vector(w_tc))
c_port <- c("Equal_Weighted","Naive_Risk_Parity","Minimum_Variance","Tangency_Portfolio","Tangency_Long_Only")
mju_vec <- c(m_ew,m_rp,m_mv,m_ta,m_tc)
sigma_vec <- c(v_ew,v_rp,v_mv,v_ta,v_tc)
port_char <- tibble(strategy = c_port, mju = mju_vec, sigma = sigma_vec)
port_char$rf <- rf
port_char$sharpe <- (port_char$mju - port_char$rf)/port_char$sigma
port_char$sharpe_pa <- port_char$sharpe * sqrt(12)
port_char

# Compute portfolio weight matrix
port_weights <- as.tibble(round(rbind(w_ew,w_rp,t(w_mv),t(w_ta),w_tc),4))
port_weights$strategy <- c_port
port_weights <- port_weights %>%
  relocate(strategy)
port_weights

# Add stock characteristics
stock_char <- tibble(strategy = symbols, mju = mju, sigma = sigma)
stock_char$rf <- rf
stock_char$sharpe <- (stock_char$mju - stock_char$rf)/stock_char$sigma
stock_char$sharpe_pa <- stock_char$sharpe * sqrt(12)
stock_char

# Combined stock and portfolio characteristics
port_char2 <- rbind(stock_char,port_char)
port_char2

# Add risk-free asset
temp <- tibble(strategy = "Risk_Free", mju = rf, sigma = 0, rf = rf, sharpe = NA, sharpe_pa = NA)
port_char3 <- rbind(port_char2,temp)
port_char3

# Construct efficient frontier
lambda_vec <- 1*(1.1^(0:200))
w_eff <- NULL
mju_eff <- NULL
sigma_eff <- NULL
V1 <- rep(1,length(mju))
for (lambda in lambda_vec) {
  v <- (2*lambda-(V1 %*% ginv(covmat) %*%mju))/(V1 %*% ginv(covmat) %*% V1)
  w <- (1/(2*lambda))*ginv(covmat) %*% (mju + as.numeric(v)*V1)
  w_eff <- rbind(w_eff,as.vector(w))
  mju_eff <- rbind(mju_eff,mju %*% w)
  sigma_eff <- rbind(sigma_eff,sqrt(as.vector(w) %*% covmat %*% as.vector(w)))
}

# Characteristics of the efficient frontier portfolios
port_eff <- tibble(strategy = paste0("lambda_",lambda_vec), mju = as.vector(mju_eff), sigma = as.vector(sigma_eff))
port_eff$rf <- rf
port_eff$sharpe <- (port_eff$mju - port_eff$rf)/port_eff$sigma
port_eff$sharpe_pa <- port_eff$sharpe * sqrt(12)
port_eff

# Construct capital market line
v_cml_vec <- seq(0,0.05,0.001)
m_cml_vec <- rf + v_cml_vec*((m_ta[1]-rf)/v_ta[1])

# Capital market line portfolios
port_cml <- tibble(strategy="Capital_Market_Line",mju = m_cml_vec,sigma = v_cml_vec)
port_cml$rf <- rf
port_cml$sharpe <- (port_cml$mju - port_cml$rf)/port_cml$sigma
port_cml$sharpe_pa <- port_cml$sharpe * sqrt(12)
port_cml

# Plot characteristics on a chart
temp <- port_eff
temp$strategy = "Efficient_Frontier"
gChart04 <- port_char3 %>%
  ungroup() %>%
  group_by(strategy) %>%
  ggplot(aes(x = sigma, y = mju, color = strategy, label = strategy)) +
  geom_point(size = 3) +
  geom_text(size=4,nudge_y = -0.0002) +
  labs(title = paste0("Efficient portfolios (",dStart," to ",dEnd,")"),
       subtitle = paste0("Efficient portfolios, Source: YahooFinance.com")) +
  scale_x_continuous(labels = scales::percent) +
  scale_y_continuous(labels = scales::percent) +
  geom_line(size = 1, data = temp, aes(x = sigma, y = mju)) +
  geom_line(size = 1, data = port_cml, aes(x = sigma, y = mju))
print(gChart04)

# Compute performance
ret_ew <- ret %*% w_ew
ret_rp <- ret %*% w_rp
ret_mv <- ret %*% as.vector(w_mv)
ret_ta <- ret %*% as.vector(w_ta)
ret_tc <- ret %*% w_tc

# Compute portfolio returns
ret_port <- cbind(ret_ew,ret_rp,ret_mv,ret_ta,ret_tc)
mreturns_port <- as.tibble(ret_port) 
names(mreturns_port) <- c_port
mreturns_port <- cbind(mreturns,mreturns_port)

# Convert into long format
mreturns_long <- mreturns_port %>%
  gather(strategy,returnS,-date) %>%
  group_by(strategy) %>%
  mutate(cumreturn = cumprod(1+returnS))

# Plot cumulative returns - Log-scale
dStart <- min(mreturns_long$date)
dEnd <- max(mreturns_long$date)
gChart05 <- mreturns_long %>%
  filter(strategy %in% c_port) %>%
  ungroup() %>%
  group_by(strategy) %>%
  mutate(cumreturn = cumprod(1+returnS)) %>%
  ggplot(aes(x = date, y = cumreturn, color = strategy)) +
  geom_line(size = 1) +
  labs(title = paste0("Efficient portfolios - In-sample returns (",dStart," to ",dEnd,")"),
       subtitle = paste0("Efficient portfolios - In-sample returns, Source: YahooFinance.com")) +
  scale_y_continuous(labels = scales::percent,trans='log10')
print(gChart05)

# Plot cumulative returns
dStart <- min(mreturns_long$date)
dEnd <- max(mreturns_long$date)
gChart06 <- mreturns_long %>%
  filter(strategy %in% c_port) %>%
  ungroup() %>%
  group_by(strategy) %>%
  mutate(cumreturn = cumprod(1+returnS)) %>%
  ggplot(aes(x = date, y = cumreturn, color = strategy)) +
  geom_line(size = 1) +
  labs(title = paste0("Efficient portfolios - In-sample returns (",dStart," to ",dEnd,")"),
       subtitle = paste0("Efficient portfolios - In-sample returns, Source: YahooFinance.com")) +
  scale_y_continuous(labels = scales::percent)
print(gChart06)

# Plot cumulative returns - Out-Sample
if (FALSE) {
  
  # Out-sample cumulative returns
  dStart <- min(mdata$date[year(mdata$date)>sYear])
  dEnd <- max(mdata$date)
  gChart07 <- mreturns_long %>%
    filter(strategy %in% c_port) %>%
    filter(year(date)>sYear) %>%
    ungroup() %>%
    group_by(strategy) %>%
    mutate(cumreturn = cumprod(1+returnS)) %>%
    ggplot(aes(x = date, y = cumreturn, color = strategy)) +
    geom_line(size = 1) +
    labs(title = paste0("Efficient portfolios - Out-sample returns (",dStart," to ",dEnd,")"),
         subtitle = paste0("Efficient portfolios - Out-sample returns, Source: YahooFinance.com")) +
    scale_y_continuous(labels = scales::percent)
  print(gChart07) 
  
  # Save figure
  ggsave(paste0(gFolder,"/gChart07.png"),gChart07,
         height = 5, width = 8, units = "in", dpi = 450)
  
  # Compute realized Sharpe ratios
  results_summary <- mreturns_long %>%
    filter(year(date)>sYear) %>%
    group_by(strategy) %>%
    summarize(mju = mean(returnS),
              sigma = sd(returnS)) %>%
    mutate(sharpe = (mju-rf)/sigma,
           sharpe_pa = sharpe*sqrt(12))
  results_summary
  
}

# Save charts
gFolder <- "Portfolio_Optimization_3"
dir.create(gFolder)
ggsave(paste0(gFolder,"/gChart01.png"),gChart01,
       height = 5, width = 8, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/gChart02.png"),gChart02,
       height = 5, width = 8, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/gChart03.png"),gChart03,
       height = 5, width = 8, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/gChart04.png"),gChart04,
       height = 5, width = 8, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/gChart05.png"),gChart05,
       height = 5, width = 8, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/gChart06.png"),gChart06,
       height = 5, width = 8, units = "in", dpi = 450)

