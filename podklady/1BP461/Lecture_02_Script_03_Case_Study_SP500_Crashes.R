# -----------------------------------------------------------------------
# LECTURE 2.3. - CASE STUDY - BEHAVIOUR OF S&P 500 AFTER 1-DAY CRASHES
# -----------------------------------------------------------------------

# GOALS:
# -> Analyse the expected behavior after a large 1-day crashes of the S&P500
# -> Compute the expected return in day t+1 following a crash in day t
# -> Verify the statistical significance of the results
# -> Verify the presence of a monday-reversal effect

# Set working directory
#setwd("~/R/Case_Studies_Lectures_2024")
setwd("E:/Users/Ficura/Documents/R/Case_Studies_Lectures_2024")

# Load tidyquant
library(tidyverse)
library(quantmod)
library(tidyquant)
library(writexl)
library(readxl)

# *************************************************
# STEP 1 - LOAD S&P 500 STOCK PRICES
# *************************************************

# Settings:
symbol = "^GSPC"           # S&P500 time-series (longer, not dividend adjusted)
# symbol = "SPY"           # SPY ETF time-series (shorter, dividend adjusted)
tStart <- "1900-01-01"
tEnd   <- today()

# Load stock prices
data <- tq_get(symbol, get = "stock.prices", from = tStart, to = tEnd)

# Compute returns
# logprice = logarithm of the stock index price
# logreturn = logarithmic return
# return = simple return
# cumret = cumulative return (for visualization)
# drawdown = drawdown (for visualization)
data <- data %>%
  mutate(logprice = log(adjusted),
         logreturn = logprice - lag(logprice,1),
         logreturn = ifelse(is.na(logreturn),0,logreturn),
         return = exp(logreturn)-1,
         cumreturn = cumprod(1+return),
         drawdown = (cumreturn/cummax(cumreturn))-1)

# Identify dataset start and end (for the charts)
dStart <- min(data$date)
dEnd <- max(data$date)

# Plot cumulative returns
gChart01 <- data %>%
  ungroup() %>%
  ggplot(aes(x = date, y = cumreturn)) +
  geom_line(size = 1) +
  labs(title = paste0("S&P500 stock index returns (",dStart," to ",dEnd,")"),
       subtitle = paste0("Long-term S&P500 returns (without dividends), Source: YahooFinance.com")) +
  scale_y_continuous(labels = scales::percent,trans='log10')
print(gChart01)

# Plot drawdowns
gChart02 <- data %>%
  ungroup() %>%
  ggplot(aes(x = date, y = drawdown)) +
  geom_line(size = 1) +
  labs(title = paste0("S&P500 stock index drawdowns (",dStart," to ",dEnd,")"),
       subtitle = paste0("S&P500 drawdowns (without dividends), Source: YahooFinance.com")) +
  scale_y_continuous(labels = scales::percent)
print(gChart02)

# S&P500 long-term
gFolder <- "SP500_LongTerm_New"
dir.create(gFolder)
ggsave(paste0(gFolder,"/gChart01.png"),gChart01,
       height = 3, width = 8, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/gChart02.png"),gChart02,
       height = 3, width = 8, units = "in", dpi = 450)
write_xlsx(data,paste0(gFolder,"/SP500_LongTerm_New.xlsx"))

# *************************************************
# STEP 2 - FILTER OUT LARGE 1-DAY S&P 500 CRASHES
# *************************************************

# Compute lagged and lead returns
# return = return in day t             (return in the day of the crash)
# target = return in day t+1           (return in the following day)
# lagreturn = return in day t-1        (return in the previous day)
# lagreturn2 = return in day t-2       (return in the following day)
# lagdrawdown = drawdown in day t-1    (used to filter out non-crisis periods) 
data <- data %>%  
  mutate(target = lead(return, default = 0),
         lagreturn = lag(return, default = 0),
         lagreturn2 = lag(return, 2, default = 0),
         lagdrawdown = lag(drawdown, default = 0),
         wday = weekdays(date))

# Sort dataset by return in day t
dataS <- data %>%
  select(date,wday,lagdrawdown,drawdown,
         lagreturn2,lagreturn,return,target) %>%
  arrange(return)

# --------------------------------------------------------------
# ANALYSIS 1 - CHECK THE RETURNS AFTER LARGEST 1-DAY CRASHES
# --------------------------------------------------------------

# Specify threshold
threshold <- -0.05 # threshold on return(t)

# Filter out relevant crashes
temp <- dataS %>%
  filter(return<=threshold)

# Compute dataset size
nCrash <- nrow(temp)
nCrash

# Show data
print(temp,n=nCrash)

# Prepare function to compute summary statistics
# Including a t-test with H0: E(target)=0 and H1: E(target)!=0 
csummary <- function(temp) {
  crash_summary <- temp %>%
    summarize(nObs = n(),                              # Observations
              mju = mean(target),                      # Average return
              sigma = sd(target),                      # St. deviation
              tStat = mju/(sigma/(sqrt(nObs))),        # t-statistics
              pValue = 2*(1-pt(abs(tStat),df=nObs-1))) # p-value
  return(crash_summary)
}

# Compute summary
crash_summary <- csummary(temp)
crash_summary

# Check of the t-test with R
# t.test(temp$target)

# VERIFY ROBUSTNESS ON RECENT DATA

# Start date
dThreshold <- "1990-01-01"

# Filter dataset
temp2 <- temp %>%
  filter(date>=dThreshold)

# Compute dataset size
nCrash <- nrow(temp2)
nCrash

# Show data
print(temp2,n=nCrash)

# Compute summary
crash_summary <- csummary(temp2)
crash_summary

# ---------------------------------------------------------------------
# ANALYSIS 2 - CHECK THE RETURNS AFTER LARGEST 1-DAY CRASHES ON MONDAY
# ---------------------------------------------------------------------

# Note:
# Monday effect -> Monday returns tend to be worst
# Monday reversal effect -> Monday crashes often tend to revert on tuesday

# *****************************
# MONDAY EFFECT
# *****************************

# Illustration - Monday effect
weekday_returns <- data %>%
  group_by(wday) %>%
  summarize(nObs = n(),
            mju = mean(return),
            sigma = sd(return),
            tStat = mju/(sigma/(sqrt(nObs))),
            pValue = 2*(1-pt(abs(tStat),df=nObs-1)))
weekday_returns

# Illustration - Monday effect - Since 1990
dThreshold <- "1990-01-01"
weekday_returns <- data %>%
  filter(date>=dThreshold) %>%
  group_by(wday) %>%
  summarize(nObs = n(),
            mju = mean(return),
            sigma = sd(return),
            tStat = mju/(sigma/(sqrt(nObs))),
            pValue = 2*(1-pt(abs(tStat),df=nObs-1)))
weekday_returns

# *****************************
# MONDAY REVERSAL EFFECT
# *****************************

# Specify thresholds
threshold <- -0.02    # threshold on return(t)
xwday <- "Monday"     # select day

# Show largest crashes
temp <- dataS %>%
  filter(return<=threshold) %>%
  filter(wday==xwday)

# Compute dataset size
nCrash <- nrow(temp)
nCrash

# Show data
print(temp,n=nCrash)

# Compute summary
crash_summary <- csummary(temp)
crash_summary

# VERIFY ROBUSTNESS ON RECENT DATA

# Start date
dThreshold <- "1990-01-01"

# Filter dataset
temp2 <- temp %>%
  filter(date>=dThreshold)

# Compute dataset size
nCrash <- nrow(temp2)
nCrash

# Show data
print(temp2,n=nCrash)

# Compute summary
crash_summary <- csummary(temp2)
crash_summary

# ---------------------------------------------------------------------
# COMPUTE CUMULATIVE PERFORMANCE
# ---------------------------------------------------------------------

# Compute strategy returns
# entry = binary indicator of days when we enter position
# profit = profit per entered position in t+1
# cumprofit = cumulative profit from the strategy
# ddprofit = drawdown of the strategy
data2 <- data %>%
  filter(date>=dThreshold) %>%
  mutate(entry = (return<=threshold) & (wday==xwday),
         profit = entry*target,
         cumprofit = cumprod(1+profit),
         ddprofit = (cumprofit/cummax(cumprofit))-1)

# Plot cumulative returns
dStart <- min(data2$date)
dEnd <- max(data2$date)
gChart03 <- data2 %>%
  ungroup() %>%
  ggplot(aes(x = date, y = cumprofit)) +
  geom_line(size = 1) +
  labs(title = paste0("S&P500 monday reversal strategy (",dStart," to ",dEnd,")"),
       subtitle = paste0("Cumulative returns, Source: YahooFinance.com")) +
  scale_y_continuous(labels = scales::percent)
print(gChart03)

# Plot drawdowns
gChart04 <- data2 %>%
  ungroup() %>%
  ggplot(aes(x = date, y = ddprofit)) +
  geom_line(size = 1) +
  labs(title = paste0("S&P500 monday reversal strategy (",dStart," to ",dEnd,")"),
       subtitle = paste0("Drawdowns, Source: YahooFinance.com")) +
  scale_y_continuous(labels = scales::percent)
print(gChart04)

# Save charts
ggsave(paste0(gFolder,"/gChart03.png"),gChart03,
       height = 3, width = 8, units = "in", dpi = 450)
ggsave(paste0(gFolder,"/gChart04.png"),gChart04,
       height = 3, width = 8, units = "in", dpi = 450)
