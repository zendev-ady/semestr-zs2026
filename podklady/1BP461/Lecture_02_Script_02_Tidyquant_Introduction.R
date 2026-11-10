# -----------------------------------------------------------------------
# LECTURE 2.2. - Introduction to Tidyquant packages
# -----------------------------------------------------------------------

# Set working directory
#setwd("~/R/Case_Studies_Lectures_2024")
setwd("E:/Users/Ficura/Documents/R/Case_Studies_Lectures_2024")

# Load tidyquant
library(tidyverse)
library(quantmod)
library(tidyquant)

# -----------------------------------------------------------------------
# DOWNLOAD STOCK PRICES FOR A SINGLE STOCK
# -----------------------------------------------------------------------

# Settings:
symbol <- "MO"
symbol <- "AAPL"
tStart <- "2011-01-01"
tEnd   <- today()

# Load stock prices
prices <- tq_get(symbol, get = "stock.prices", from = tStart, to = tEnd)

# Show the result
head(prices)

# -----------------------------------------------------------------------
# PLOT STOCK PRICE EVOLUTION FOR A SINGLE STOCK
# -----------------------------------------------------------------------

# Plot the evolution of adjusted close prices
c01 <- prices %>%
  ggplot(aes(x = date, y = adjusted)) +
  geom_line(size = 1) +
  labs(title = paste0(symbol, " - Adjusted daily close prices"),
       subtitle = paste0("In period from ",tStart," to ",tEnd),
       caption = "Source: Yahoo finance")
print(c01)

# Plot the evolution of  adjusted close prices - Log scale
c02 <- prices %>%
  ggplot(aes(x = date, y = adjusted)) +
  geom_line(size = 1) +
  scale_y_log10() +
  labs(title = paste0(symbol, " - Adjusted daily close prices (logarithmic scale)"),
       subtitle = paste0("In period from ",tStart," to ",tEnd),
       caption = "Source: Yahoo finance")
print(c02)

# Plot the evolution of  adjusted close prices - Log scale with linear trend
c03 <- prices %>%
  ggplot(aes(x = date, y = adjusted)) +
  geom_line(size = 1) +
  scale_y_log10() +
  geom_smooth(method = "lm") +
  labs(title = paste0(symbol, " - Adjusted daily close prices (log-scale with trend)"),
       subtitle = paste0("In period from ",tStart," to ",tEnd),
       caption = "Source: Yahoo finance")
print(c03)

# Plot the evolution of trading volumes (in number of stocks)
c04 <- prices %>%
  ggplot(aes(x = date, y = volume)) +
  geom_line(size = 1) +
  labs(title = paste0(symbol, " - Daily trading volumes (in number of stocks)"),
       subtitle = paste0("In period from ",tStart," to ",tEnd),
       caption = "Source: Yahoo finance")
print(c04)

# Plot the evolution of trading volumes (in USD)
c05 <- prices %>%
  mutate(volumeUSD = volume*close) %>%
  ggplot(aes(x = date, y = volumeUSD)) +
  geom_line(size = 1) +
  labs(title = paste0(symbol, " - Daily trading volumes (in USD)"),
       subtitle = paste0("In period from ",tStart," to ",tEnd),
       caption = "Source: Yahoo finance")
print(c05)

# Plot OHLC candlestick stock prices (last 100 days)
kDays <- 100
c06 <- prices %>%
  filter(date >= tEnd-kDays) %>%
  ggplot(aes(x = date)) +
  geom_candlestick(aes(open = open, high = high, low = low, close = close)) +
  labs(title = paste0(symbol, " - OHLC candlestick chart"),
       subtitle = paste0("In period from ",tEnd-kDays," to ",tEnd),
       caption = "Source: Yahoo finance")
print(c06)

# Save the prices:
gFolder <- symbol
dir.create(gFolder)
ggsave(paste0(gFolder,"/c01.png"),c01,
       height = 5, width = 6, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c02.png"),c02,
       height = 5, width = 6, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c03.png"),c03,
       height = 5, width = 6, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c04.png"),c04,
       height = 5, width = 6, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c05.png"),c05,
       height = 5, width = 6, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c06.png"),c06,
       height = 5, width = 6, units = "in", dpi = 450)

# -----------------------------------------------------------------------
# DOWNLOAD DIVIDEND AND STOCK SPLIT DATA FOR A SINGLE STOCK
# -----------------------------------------------------------------------

# Settings:
symbol <- "AAPL"
symbol <- "MO"
tStart <- "2001-01-01"
tEnd   <- today()

# Load stock prices
prices <- tq_get(symbol, get = "stock.prices", from = tStart, to = tEnd)

# Load dividends
dividends <- tq_get(symbol, get = "dividends", from = tStart, to = tEnd)

# Load stock splits
splits <- tq_get(symbol, get = "splits", from = tStart, to = tEnd)

# Plot dividend data (unadjusted)
c07 <- dividends %>%
  ggplot(aes(x = date, y = value)) +
  geom_line(size = 1) +
  labs(title = paste0(symbol, " - Dividends per share (unadjusted)"),
       subtitle = paste0("In period from ",tStart," to ",tEnd),
       caption = "Source: Yahoo finance")
print(c07)

# Plot stock split data
c08 <- splits %>%
  ggplot(aes(x = date, y = value)) +
  geom_point(size=2) +
  labs(title = paste0(symbol, " - Stock splits"),
       subtitle = paste0("In period from ",tStart," to ",tEnd),
       caption = "Source: Yahoo finance")
print(c08)

# Not relevant anymore (Yahoo Finance adjusts the dividends automatically)
if (FALSE) {
  
  # Computing stock-split adjusted dividends
  if (is.na(splits)==F) {
    kSplits <- nrow(splits)
    dividends$adj_dividend <- dividends$value
    for (i in (1:kSplits)) {
      splitDate <- splits$date[i]
      splitValue <- splits$value[i]
      dividends <- dividends %>%
        mutate(adj_dividend = ifelse(date<=splitDate,adj_dividend/splitValue,adj_dividend))
    } 
  } else {
    dividends$adj_dividend = dividends$value
  }
  
  # Plot dividend data - Adjusted for stock splits
  c09 <- dividends %>%
    ggplot(aes(x = date, y = adj_dividend)) +
    geom_line(size = 1) +
    labs(title = paste0(symbol, " - Dividends per share (stock-split adjusted)"),
         subtitle = paste0("In period from ",tStart," to ",tEnd),
         caption = "Source: Yahoo finance")
  print(c09) 
  
}

# Calculate dividend yield
temp <- prices %>%
  select(date, close)
dividends2 <- dividends %>%
  left_join(temp,by="date") %>%
  mutate(div_yield_pa = (value / close)*4)

# Plot dividend yield
c10 <- dividends2 %>%
  ggplot(aes(x = date, y = div_yield_pa)) +
  geom_line(size = 1) +
  labs(title = paste0(symbol, " - Dividend yield (p.a.)"),
       subtitle = paste0("In period from ",tStart," to ",tEnd),
       caption = "Source: Yahoo finance")
print(c10)

# Joining of the dividend and stock price data
temp <- dividends %>%
  select(date, value)
prices2 <- prices %>%
  left_join(temp, by="date") %>%
  mutate(mark = open*(value>0))

# Plot OHLC candlestick stock prices (last 200 days)
kDays <- 200
c11 <- prices2 %>%
  filter(date >= tEnd-kDays) %>%
  ggplot(aes(x = date)) +
  geom_candlestick(aes(open = open, high = high, low = low, close = close)) +
  geom_point(aes(y = mark),size = 3, color="yellow") +
  labs(title = paste0(symbol, " - OHLC candlestick chart"),
       subtitle = paste0("In period from ",tEnd-kDays," to ",tEnd),
       caption = "Source: Yahoo finance")
print(c11)

# Dividend-adjusted OHLC prices
prices2 <- prices2 %>%
  mutate(adjfactor = adjusted/close,
         adjopen = adjfactor * open,
         adjhigh = adjfactor * high,
         adjlow = adjfactor * low,
         adjclose = adjusted,
         adjmark = adjopen*(value>0))
c12 <- prices2 %>%
  filter(date >= tEnd-kDays) %>%
  ggplot(aes(x = date)) +
  geom_candlestick(aes(open = adjopen, high = adjhigh, low = adjlow, close = adjclose)) +
  geom_point(aes(y = adjmark),size = 3, color="yellow") +
  labs(title = paste0(symbol, " - OHLC candlestick chart (dividend-adjusted)"),
       subtitle = paste0("In period from ",tEnd-kDays," to ",tEnd),
       caption = "Source: Yahoo finance")
print(c12)

# Save the prices:
#gFolder <- symbol
#dir.create(gFolder)
ggsave(paste0(gFolder,"/c07.png"),c07,
       height = 5, width = 6, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c08.png"),c08,
       height = 5, width = 6, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c09.png"),c09,
       height = 5, width = 6, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c10.png"),c10,
       height = 5, width = 6, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c11.png"),c11,
       height = 5, width = 6, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c12.png"),c12,
       height = 5, width = 6, units = "in", dpi = 450)

# -----------------------------------------------------------------------
# DOWNLOAD MULTIPLE STOCKS AT ONCE
# -----------------------------------------------------------------------

# Settings:
symbols <- c("AAPL","MSFT","GOOG","AMZN")
tStart <- "2015-01-01"
tEnd   <- today()

# Load stock prices
prices <- tq_get(symbols, get = "stock.prices", from = tStart, to = tEnd)

# Show the result
head(prices)

# Unique
unique(prices$symbol)

# Plot adjusted stock price evolution
c13 <- prices %>%
  group_by(symbol) %>%
  ggplot(aes(x = date, y = adjusted, color = symbol)) +
  geom_line(size = 1) +
  labs(title = "Daily Stock Prices",
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       x = "", y = "Adjusted Prices") +
  facet_wrap(~ symbol, ncol = 2, scales = "free_y") +
  scale_y_continuous(labels = scales::dollar)
print(c13)

# Plot USD volume evolution
prices <- prices %>%
  group_by(symbol) %>%
  mutate(volumeUSD = volume*close)
c14 <- prices %>%
  group_by(symbol) %>%
  ggplot(aes(x = date, y = volumeUSD, color = symbol)) +
  geom_line(size = 1) +
  labs(title = "Daily USD volumes",
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       x = "", y = "USD volume") +
  facet_wrap(~ symbol, ncol = 2, scales = "free_y") +
  scale_y_continuous(labels = scales::dollar)
print(c14)

# Compute USD returns
prices <- prices %>%
  group_by(symbol) %>%
  mutate(return_USD = adjusted - lag(adjusted))
c15 <- prices %>%
  group_by(symbol) %>%
  ggplot(aes(x = date, y = return_USD, color = symbol)) +
  geom_line(size = 1) +
  labs(title = "Daily Stock Returns (USD)",
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       x = "", y = "USD returns") +
  facet_wrap(~ symbol, ncol = 2, scales = "free_y") +
  scale_y_continuous(labels = scales::dollar)
print(c15)

# Compute and daily % returns
prices <- prices %>%
  group_by(symbol) %>%
  mutate(return = (adjusted - lag(adjusted)) / lag(adjusted))
c16 <- prices %>%
  group_by(symbol) %>%
  ggplot(aes(x = date, y = return, color = symbol)) +
  geom_line(size = 1) +
  labs(title = "Daily Returns (%)",
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       x = "", y = "Returns") +
  facet_wrap(~ symbol, ncol = 2, scales = "free_y") +
  scale_y_continuous(labels = scales::percent)
print(c16)

# Compute logarithmic stock prices
prices <- prices %>%
  group_by(symbol) %>%
  mutate(logprice = log(adjusted))
c17 <- prices %>%
  group_by(symbol) %>%
  ggplot(aes(x = date, y = logprice, color = symbol)) +
  geom_line(size = 1) +
  labs(title = "Daily Logarithmic Prices",
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       x = "", y = "Log-prices") +
  facet_wrap(~ symbol, ncol = 2, scales = "free_y")
print(c17)

# Compute daily logarithmic returns
prices <- prices %>%
  group_by(symbol) %>%
  mutate(logreturn = logprice - lag(logprice))
c18 <- prices %>%
  group_by(symbol) %>%
  ggplot(aes(x = date, y = logreturn, color = symbol)) +
  geom_line(size = 1) +
  labs(title = "Daily Logarithmic Returns",
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       x = "", y = "Log-returns") +
  facet_wrap(~ symbol, ncol = 2, scales = "free_y") +
  scale_y_continuous(labels = scales::percent)
print(c18)

# Cumulative logarithmic returns
prices <- prices %>%
  group_by(symbol) %>%
  mutate(logreturn = ifelse(is.na(logreturn),0,logreturn),
         cumlogret = cumsum(logreturn))
c19 <- prices %>%
  group_by(symbol) %>%
  ggplot(aes(x = date, y = cumlogret, color = symbol)) +
  geom_line(size = 1) +
  labs(title = "Cumulative Logarithmic Returns",
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       x = "", y = "Cumulative log-returns") +
  facet_wrap(~ symbol, ncol = 2, scales = "free_y") +
  scale_y_continuous(labels = scales::percent)
print(c19)

# Cumulative returns
prices <- prices %>%
  group_by(symbol) %>%
  mutate(cumreturn = exp(cumlogret)-1)
c20 <- prices %>%
  group_by(symbol) %>%
  ggplot(aes(x = date, y = cumreturn, color = symbol)) +
  geom_line(size = 1) +
  labs(title = "Cumulative Returns",
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       x = "", y = "Cumulative returns") +
  facet_wrap(~ symbol, ncol = 2, scales = "free_y") +
  scale_y_continuous(labels = scales::percent)
print(c20)

# Calculate annual logarithmic returns
yprices <- prices %>%
  mutate(year = year(date)) %>%
  group_by(symbol,year) %>%
  summarize(return = sum(logreturn))
c21 <- yprices %>%
  ggplot(aes(x = year, y = return, fill = symbol)) +
  geom_col() +
  labs(title = "Annual Returns",
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       x = "",y = "Annual Returns") + 
  facet_wrap(~ symbol, ncol = 2, scales = "free_y") +
  scale_y_continuous(labels = scales::percent)
print(c21)

# Save the prices:
gFolder <- "Multiple_Stocks"
dir.create(gFolder)
ggsave(paste0(gFolder,"/c13.png"),c13,
       height = 5, width = 7, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c14.png"),c14,
       height = 5, width = 7, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c15.png"),c15,
       height = 5, width = 7, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c16.png"),c16,
       height = 5, width = 7, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c17.png"),c17,
       height = 5, width = 7, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c18.png"),c18,
       height = 5, width = 7, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c19.png"),c19,
       height = 5, width = 7, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c20.png"),c20,
       height = 5, width = 7, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/c21.png"),c21,
       height = 5, width = 7, units = "in", dpi = 450)

# -----------------------------------------------------------------------
# DOWNLOAD STOCK INDEX COMPONENTS
# -----------------------------------------------------------------------

# GET STOCK INDEX COMPONENTS

# Supported stock indices
tq_index_options()

# Get DJIA components
info <- tq_index("DOW")
head(info)

# Get S&P 500 components
#info <- tq_index("SP500")
#head(info)

# GET DOW JONES STOCK PRICES

# Get DJIA components
info <- tq_index("DOW")
head(info)

# Settings:
tStart <- "2011-01-01"
tEnd   <- today()

# Load DJIA stock prices
prices <- tq_get(info$symbol, get = "stock.prices", from = tStart, to = tEnd)

# Load DJIA stock prices (+ include info about each stock)
prices <- info %>% tq_get(get = "stock.prices", from = tStart, to = tEnd)

# Compute average yearly returns for all of the stocks:
stats <- prices %>%
  mutate(year = year(date)) %>%
  group_by(symbol) %>%
  mutate(logprice = log(adjusted),
         return = logprice - lag(logprice),
         return = ifelse(is.na(return),0,return)) %>%
  group_by(symbol,year) %>%
  summarize(return_pa = sum(return)) %>%
  ungroup() %>%
  group_by(symbol) %>%
  summarize(avg_return_pa = mean(return_pa))

# Plot the average annual returns on chart
c22 <- stats %>%
  ggplot(aes(x = reorder(symbol,avg_return_pa), y = avg_return_pa)) +
  geom_col() +
  labs(title = paste0("Best performing stocks in the DJIA index"), 
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       y = "Average return p.a.", x = "Symbol", color = "") +
  scale_y_continuous(labels = scales::percent) +
  coord_flip()
print(c22)

gFolder = "DJIA"
dir.create(gFolder)
ggsave(paste0(gFolder,"/c22.png"),c22,
       height = 6, width = 5, units = "in", dpi = 450)

# Compute average yearly returns for all of the stocks (+sector):
stats <- prices %>%
  mutate(year = year(date)) %>%
  group_by(sector,symbol,year) %>%
  mutate(logprice = log(adjusted),
         return = logprice - lag(logprice),
         return = ifelse(is.na(return),0,return)) %>%
  summarize(return_pa = sum(return)) %>%
  ungroup() %>%
  group_by(sector,symbol) %>%
  summarize(avg_return_pa = mean(return_pa))

# Plot the average annual returns on chart (+sector)
c23 <- stats %>%
  ggplot(aes(x = reorder(symbol,avg_return_pa), y = avg_return_pa, fill = sector)) +
  geom_col() +
  labs(title = paste0("Best performing stocks in the DJIA index"), 
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       y = "Average return p.a.", x = "Symbol", color = "") +
  scale_y_continuous(labels = scales::percent) +
  coord_flip()
print(c23)

gFolder = "DJIA"
dir.create(gFolder)
ggsave(paste0(gFolder,"/c23.png"),c23,
       height = 6, width = 6, units = "in", dpi = 450)

# Compute average sector returns
stats <- prices %>%
  mutate(year = year(date)) %>%
  group_by(sector,symbol,year) %>%
  mutate(logprice = log(adjusted),
         return = logprice - lag(logprice),
         return = ifelse(is.na(return),0,return)) %>%
  summarize(return_pa = sum(return)) %>%
  ungroup() %>%
  group_by(sector) %>%
  summarize(avg_return_pa = mean(return_pa))

# Plot the average annual sector returns on chart
c24 <- stats %>%
  ggplot(aes(x = reorder(sector,avg_return_pa), y = avg_return_pa)) +
  geom_col() +
  labs(title = paste0("Best performing sectors in the DJIA index"), 
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       y = "Average return p.a.", x = "Sector", color = "") +
  scale_y_continuous(labels = scales::percent) +
  coord_flip()
print(c24)

gFolder = "DJIA"
dir.create(gFolder)
ggsave(paste0(gFolder,"/c24.png"),c24,
       height = 6, width = 5, units = "in", dpi = 450)

# Average yearly returns in-sample vs. out-sample:
stats <- prices %>%
  mutate(year = year(date),
         sample = ifelse(year<=2015,"InSample","OutSample")) %>%
  group_by(sector,symbol,year,sample) %>%
  mutate(logprice = log(adjusted),
         return = logprice - lag(logprice),
         return = ifelse(is.na(return),0,return)) %>%
  summarize(return_pa = sum(return)) %>%
  ungroup() %>%
  group_by(sector,symbol,sample) %>%
  summarize(avg_return_pa = mean(return_pa))

# Join the in-sample result to the table
temp <- stats %>%
  filter(sample == "InSample") %>%
  mutate(criterion = avg_return_pa) %>%
  ungroup() %>%
  select(symbol, criterion)
stats <- stats %>%
  left_join(temp, by="symbol")

# Plot average yearly returns in-sample vs. out-sample:
c25 <- stats %>%
  filter(is.na(criterion)==0) %>%
  ggplot(aes(x = reorder(symbol,criterion), y = avg_return_pa, color = sample)) +
  geom_point(size=3) +
  labs(title = paste0("Best performing stocks in the DJIA index"), 
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       y = "Average return p.a.", x = "Symbol", color = "") +
  scale_y_continuous(labels = scales::percent) +
  coord_flip()
print(c25)

gFolder = "DJIA"
dir.create(gFolder)
ggsave(paste0(gFolder,"/c25.png"),c25,
       height = 6, width = 6, units = "in", dpi = 450)

# Plot single stock on a chart
cSymbol <- "AAPL"
cYear <- 2011
prices %>%
  mutate(logprice = log(adjusted),
         year = year(date)) %>%
  filter(symbol==cSymbol) %>%
  filter(year==cYear) %>%
  ggplot(aes(x = date, y = logprice, color = symbol)) +
  geom_line(size = 1) +
  labs(title = paste0("Daily Logarithmic Prices of ", cSymbol),
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       x = "", y = "Log-prices")

# -----------------------------------------------------------------------
# FACTOR INVESTING STRATEGY IMPLEMENTATION - PAST RETURNS
# -----------------------------------------------------------------------

# Get DJIA components
info <- tq_index("DOW")
head(info)

# Settings:
tStart <- "2011-01-01"
tEnd   <- today()

# Load DJIA stock prices (+ include info about each stock)
prices <- info %>% tq_get(get = "stock.prices", from = tStart, to = tEnd)

# Compute log-returns
prices <- prices %>%
  group_by(symbol) %>%
  mutate(logprice = log(adjusted),
         return = logprice - lag(logprice),
         return = ifelse(is.na(return),0,return))

# Compute annual log-returns
yprices <- prices %>%
  ungroup() %>%
  mutate(year = year(date)) %>%
  group_by(symbol,year) %>%
  summarize(return = sum(return))

# Compute lagged annual log-returns
yprices <- yprices %>%
  ungroup() %>%
  group_by(symbol) %>%
  mutate(lag_return = lag(return))

# Remove rows with no observations
yprices <- yprices[complete.cases(yprices),]

# Assign cross-sectional statistics
yprices <- yprices %>%
  ungroup() %>%
  group_by(year) %>%
  mutate(return_rank = rank(lag_return),
         relative_rank = (return_rank-1)/(max(return_rank)-1))

# Construct quintile portfolios
yprices <- yprices %>%
  mutate(quintile = round(relative_rank*5))

# Compute quintile portfolio returns
qreturns <- yprices %>%
  ungroup() %>%
  group_by(year,quintile) %>%
  summarize(return = mean(return))

# Compute average quintile portfolio annual returns
stats <- qreturns %>%
  ungroup() %>%
  group_by(quintile) %>%
  summarize(return_pa = mean(return),
            return_total = sum(return),
            return_exp = exp(return_total)-1)

# Plot average annual returns of the momentum based quintile portfolios
c26 <- stats %>%
  ggplot(aes(x = quintile, y = return_pa)) +
  geom_col() +
  labs(title = "Quintile portfolio average annual returns - Momentum",
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       x = "",y = "Average return") + 
  scale_y_continuous(labels = scales::percent)
print(c26)
  
# Compute quintile portfolio cumulative returns
qreturns <- qreturns %>%
  ungroup() %>%
  group_by(quintile) %>%
  mutate(cumreturn = cumsum(return))

# Plot cumulative returns on a chart (logarithmic returns)
c27 <- qreturns %>%
  mutate(quintile = as.character(quintile)) %>%
  ungroup() %>%
  group_by(quintile) %>%
  ggplot(aes(x = year, y = cumreturn, color = quintile)) +
  geom_line(size = 1) +
  labs(title = "Cumulative logarithmic returns - Momentum portfolios",
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       x = "", y = "Cumulative returns") +
  scale_y_continuous(labels = scales::percent)
print(c27)

# Save the chart
gFolder = "DJIA"
dir.create(gFolder)
ggsave(paste0(gFolder,"/c27.png"),c27,
       height = 6, width = 6, units = "in", dpi = 450)

# Plot cumulative returns on a chart (exponential returns)
c28 <- qreturns %>%
  mutate(cumreturn = exp(cumreturn)-1) %>%
  mutate(quintile = as.character(quintile)) %>%
  ungroup() %>%
  group_by(quintile) %>%
  ggplot(aes(x = year, y = cumreturn, color = quintile)) +
  geom_line(size = 1) +
  labs(title = "Cumulative returns - Momentum portfolios",
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       x = "", y = "Cumulative returns") +
  scale_y_continuous(labels = scales::percent)
print(c28)

# Save the chart
gFolder = "DJIA"
dir.create(gFolder)
ggsave(paste0(gFolder,"/c28.png"),c28,
       height = 6, width = 6, units = "in", dpi = 450)

# -----------------------------------------------------------------------
# FACTOR INVESTING STRATEGY IMPLEMENTATION - MULTIPLE FACTORS
# -----------------------------------------------------------------------

# Factors: 1) Momentum, 2) Volume, 3) Volatility, 4) Skewness

# Get DJIA components
info <- tq_index("DOW")

# Settings:
tStart <- "2011-01-01"
tEnd   <- today()

# Load DJIA stock prices (+ include info about each stock)
prices <- info %>% tq_get(get = "stock.prices", from = tStart, to = tEnd)

# Compute daily log-returns and USD volumes
prices <- prices %>%
  group_by(symbol) %>%
  mutate(logprice = log(adjusted),
         return = logprice - lag(logprice),
         return = ifelse(is.na(return),0,return),
         volumeUSD = volume*close)

# Compute annual statistics
yprices <- prices %>%
  ungroup() %>%
  mutate(year = year(date)) %>%
  group_by(symbol,year) %>%
  summarize(volatility = sd(return),
            skewness = skewness(return),
            return = sum(return),
            volumeUSD = sum(volumeUSD))

# Compute lagged values of the factors
yprices <- yprices %>%
  ungroup() %>%
  group_by(symbol) %>%
  mutate(lag_return = lag(return),
         lag_volume = lag(volumeUSD),
         lag_skewness = lag(skewness),
         lag_volatility = lag(volatility))

# Remove rows with missing observations
yprices <- yprices[complete.cases(yprices),]

# Gather the predictors
tprices <- yprices %>%
  gather(factor,value,lag_return:lag_volatility)

# Assign cross-sectional ranks
tprices <- tprices %>%
  ungroup() %>%
  group_by(year,factor) %>%
  mutate(factor_rank = rank(value),
         relative_rank = (factor_rank-1)/(max(factor_rank)-1),
         relative_rank = ifelse(relative_rank==0,1/1000000,relative_rank))

# Construct quintile portfolios
tprices <- tprices %>%
  mutate(quintile = ceiling(relative_rank*5))

# Compute quintile portfolio returns
qreturns <- tprices %>%
  ungroup() %>%
  group_by(year,factor,quintile) %>%
  summarize(return = mean(return))

# Compute average quintile portfolio returns p.a.
stats <- qreturns %>%
  ungroup() %>%
  group_by(factor,quintile) %>%
  summarize(return_pa = mean(return),
            return_total = sum(return),
            return_exp = exp(return_total)-1)

# Plot average average returns of the quintile portfolios
c29 <- stats %>%
  group_by(factor,quintile) %>%
  ggplot(aes(x = quintile, y = return_pa, fill = factor)) +
  geom_col() +
  labs(title = "Quintile portfolio average returns",
       subtitle = paste0("In the period from ",tStart," to ",tEnd),
       x = "",y = "Average return") + 
  facet_wrap(~ factor, ncol = 2, scales = "free_y") +
  scale_y_continuous(labels = scales::percent)
print(c29)

# Save result
gFolder = "DJIA"
dir.create(gFolder)
ggsave(paste0(gFolder,"/c29.png"),c29,
       height = 6, width = 7, units = "in", dpi = 450)

