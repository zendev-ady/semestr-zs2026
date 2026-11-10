# -----------------------------------------------------------------------
# LECTURE 2.1. - Introduction to Tidyverse packages
# -----------------------------------------------------------------------

# -----------------------------------------------------------------------
# Tidyverse summary
# -----------------------------------------------------------------------

# Load tidyverse
library(tidyverse)
library(readxl)

# Functions to read data
# Package readr: read_csv, read_tsv, read_delim
# Package haven: read_sas, read_spss, read_dta
# Package readxl: read_xls, read_xlsx, read_excel

# Data transformation
# Package: dplyr
# Functions: filter, arrange, select, mutate, group_by, summarise
# Simple functions: pull, n, count, glimpse
# Advanced iterations: summarize_at, mutate_at
# More info: dplyr.tidyverse.org
# Another source: R for Data Science
# Another source: RStudio Cloud Primers

# Data cleaning
# Package: tidyr
# Functions: gather, spread, separate, unite
# (goal is to move between "wide" and "long" data)
# gather: gathers multiple columns into a long data format
# spread: spreads two coluzmns (key and value) into multiple format (wide data format)
# separate: separates one column into multiple columns
# unite: unites multiple columns into a single column

# Data plotting
# Package: ggplot2
# Base function: ggplot
# Shape functions: geom_point, geom_line, geom_bar, geom_boxplot
# Aesthetic function: aes
# (aes determines the color, shape, size, transparenc, etc.)

# -----------------------------------------------------------------------
# Data transformation with dplyr package
# -----------------------------------------------------------------------

# -----------------------------------------------------------------------
# Tibble format
# -----------------------------------------------------------------------

# mtcars dataset (data.frame format)
mtcars_orig <- mtcars
class(mtcars_orig)

# Load mtcars (tibble format)
mtcars_tbl <- as_tibble(mtcars)
class(mtcars_tbl)

# -----------------------------------------------------------------------
# Head, tail, slice and glimpse functions
# -----------------------------------------------------------------------

# Head, tail and slice function
head(mtcars_tbl,5)
tail(mtcars_tbl,5)
slice(mtcars_tbl,1:3)
slice(mtcars_tbl,1,3,5)

# Glimpse function
glimpse(mtcars)
glimpse(mtcars_tbl)

# Summary function
summary(mtcars)
summary(mtcars_tbl)

# -----------------------------------------------------------------------
# Filter function (dplyr)
# -----------------------------------------------------------------------

# Filter function
filter(mtcars_tbl,cyl==8)

# Filter multiple values
filter(mtcars_tbl, cyl %in% c(4,6))

# Filter based on multiple variables
filter(mtcars_tbl,(cyl %in% c(4,6)) & (carb %in% c(1,2)))

# Filter using a not statement
filter(mtcars_tbl,cyl != 4)

# Filter by using a pipe
mtcars_tbl %>%
  filter(cyl %in% c(4,6))

# Filter using multiple variables
mtcars_tbl %>%
  filter((cyl %in% c(4,6)) & (carb %in% c(1,2)))

# Two stacked filters
mtcars_tbl %>%
  filter(cyl %in% c(4,6)) %>%
  filter(carb %in% c(1,2))

# Filter using not function
mtcars_tbl %>%
  filter(cyl != 4)

# -----------------------------------------------------------------------
# Arrange function (dplyr)
# -----------------------------------------------------------------------

# Sort the dataset using the arrange function
mtcars_s <- arrange(mtcars,mpg)
mtcars_s <- arrange(mtcars_tbl,mpg)

# Sort using arrange and the pipe operator
mtcars_s <- mtcars_tbl %>%
  arrange(mpg)

# Sort in descending order
mtcars_s <- mtcars_tbl %>%
  arrange(desc(mpg))

# Sort based on multiple variables
mtcars_s <- mtcars_tbl %>%
  arrange(desc(cyl),desc(hp))

# -----------------------------------------------------------------------
# Select function (dplyr)
# -----------------------------------------------------------------------

# Select function
x <- select(mtcars,cyl,mpg)
x <- select(mtcars_tbl,cyl,mpg)

# Select using the pipe operator
x <- mtcars_tbl %>%
  select(cyl,mpg)

# Show data
glimpse(x)

# Select, arrange and drop the sorting variable
x <- mtcars_tbl %>%
  select(disp,cyl,hp,mpg) %>%
    arrange(mpg) %>%
    select(-mpg)

# Show data
glimpse(x)

# Rearrange data using everything()
x <- mtcars_tbl %>%
  select(cyl,hp,everything())

# Show data
glimpse(x)

# Select columns based on condition
x <- mtcars_tbl %>%
  select(starts_with("c"),starts_with("h"))

# Show data
glimpse(x)

# -----------------------------------------------------------------------
# Mutate function (dplyr)
# -----------------------------------------------------------------------

# Convert numeric variable into factor
mtcars_2 <- mtcars_tbl %>%
  mutate(cyl = factor(cyl,
                      levels = c(4,6,8),
                      labels = c("4 Cyl","6 Cyl","8 Cyl")))

glimpse(select(mtcars_tbl,cyl))
glimpse(select(mtcars_2,cyl))

# Convert miles to liters
mtcars_2 <- mtcars_tbl %>%
  mutate(miles_per_liter = mpg * 3.78541,
         miles_per_galon = miles_per_liter / 3.78541)

# Convert miles to liters
mtcars_2 <- mtcars_tbl %>%
  transmute(miles_per_liter = mpg * 3.78541,
         miles_per_galon = miles_per_liter / 3.78541)

glimpse(select(mtcars_2,mpg,miles_per_galon,miles_per_liter))

# -----------------------------------------------------------------------
# Group by function (dplyr)
# -----------------------------------------------------------------------

# Assing groups and take the first observations
x <- mtcars_tbl %>%
  group_by(cyl) %>%
   slice(1)

# Show result
print(x)

# Filter by group to find the maximum of each group
x <- mtcars_tbl %>%
  group_by(cyl) %>%
    filter(hp == max(hp))

# Show result
print(x)

# Find the maximum values of the groups with the top_n function
x <- mtcars_tbl %>%
  group_by(cyl) %>%
    top_n(3,hp)

# Show result
print(x)

# Find the maximum of the groups using arrange and slice
x <- mtcars_tbl %>%
  group_by(cyl) %>%
    arrange(desc(hp)) %>%
      slice(1)

# Show result
print(x)

# Group by two variables and compute counts
x <- mtcars_tbl %>%
  group_by(cyl,am) %>%
    count()

# Show result
print(x)

# -----------------------------------------------------------------------
# Summarize function (dplyr)
# -----------------------------------------------------------------------

# Compute the mean of the mpg
mtcars_tbl %>%
  summarize(mean = mean(mpg))

# This works
mean(mtcars_tbl$mpg)

# This also works
mtcars_tbl %>%
  pull(mpg) %>%
    mean()

# Compute the mean and median of mpg
mtcars_tbl %>%
  summarize(mean = mean(mpg),
            median = median(mpg))

# Compute mean, standard deviation and count for different groups
mtcars_tbl %>%
  group_by(cyl) %>%
    summarize(mean_mpg = mean(mpg),
              sd_mpg = sd(mpg),
              n = n())

# -----------------------------------------------------------------------
# Mutate_at function (dplyr)
# -----------------------------------------------------------------------

# Mutate multiple variables
mtcars_tbl %>%
  mutate_at(.vars = vars(cyl,am),factor) %>%
    select(cyl,am) %>%
      glimpse()

# Vs. original data
mtcars_tbl %>%
  select(cyl,am) %>%
    glimpse()

# -----------------------------------------------------------------------
# Summarize_at function (dplyr)
# -----------------------------------------------------------------------

# Means of multiple variables
mtcars_tbl %>%
  group_by(cyl) %>%
   summarize_at(.vars = vars(mpg,disp,qsec),.funs = mean)

# Which is quicker than doing
mtcars_tbl %>%
  group_by(cyl) %>%
    summarise(mean_mpg = mean(mpg),
              mean_disp = mean(disp),
              mean_qsec = mean(qsec))

# Means and standard deviations of multiple variables
mtcars_tbl %>%
  group_by(cyl) %>%
  summarize_at(.vars = vars(mpg,disp,qsec),.funs = funs(mean,sd))

# -----------------------------------------------------------------------
# Data cleaning with tidyr package
# -----------------------------------------------------------------------

# -----------------------------------------------------------------------
# Data loading with readxl
# -----------------------------------------------------------------------

# Load test data
#untidy_df <- read_excel('Tibble_Test.xlsx')

# Create a tibble of stock returns
untidy_df <- tibble("year" = c(2018,2019,2020),
             "A" = c(0.1,-0.05,0.15),
             "B" = c(0.05,-0.1,0.1),
             "C" = c(0.2,-0.2,0.3)) 

# Untidy dataset
print(untidy_df)

# -----------------------------------------------------------------------
# Conversion to tidy format with gather (tidyr)
# -----------------------------------------------------------------------

# Convert to tidy (long) format
tidy_df <- untidy_df %>%
  gather(stock,return,A:C)

# Tidy dataset
print(tidy_df)

# -----------------------------------------------------------------------
# Conversion to untidy format with spread (tidyr)
# -----------------------------------------------------------------------

# Convert to untidy (wide) format
untidy_df_2 <- tidy_df %>%
  spread(stock,return)

# Untidy dataset
print(untidy_df_2)

# -----------------------------------------------------------------------
# Join columns with unite
# -----------------------------------------------------------------------

# Join columns with unite
tidy_df <- tidy_df %>%
  unite("stock_year",c("stock","year"),sep = "_") 

# Tidy dataset with merged columns
print(tidy_df)

# -----------------------------------------------------------------------
# Divide columns with separate
# -----------------------------------------------------------------------

# Separate columns with separate
tidy_df <- tidy_df %>%
  separate(stock_year, into = c("stock","year"),sep = "_")

# Tidy dataset with divided columns
print(tidy_df)

# -----------------------------------------------------------------------
# Data plotting with ggplot2 package
# -----------------------------------------------------------------------

# -----------------------------------------------------------------------
# geom_point - point chart (ggplot2)
# -----------------------------------------------------------------------

# Point chart
ggplot(mtcars,aes(x = cyl, y = mpg)) +
  geom_point()

# -----------------------------------------------------------------------
# Application to Gapminder dataset
# -----------------------------------------------------------------------

# Load Gapminder dataset
gapminder_df <- gapminder::gapminder
glimpse(gapminder_df)

# Linechart and pointchart of life expectancy for Malawi
gapminder_df %>%
  filter(country == "Malawi") %>%
  ggplot(aes(x = year, y = lifeExp)) +
  geom_line(colour = "#1380A1", size = 1) +
  geom_point(size = 2)

# Linechart of two countries
gapminder_df %>%
  filter(country == "China" | country == "United States") %>%
  ggplot(aes(x = year, y = lifeExp, colour = country)) +
  geom_line(size = 1)

# Chart with varying point size
gapminder_df %>%
  filter(country == "China" | country == "United States") %>%
  ggplot(aes(x = year, y = country, colour = country, size = lifeExp)) +
  geom_point() +
  theme_minimal() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank())

# Bar plot - Select dataset
bar_df <- gapminder_df %>%
  filter(year == 2007 & continent == "Africa") %>%
  arrange(desc(lifeExp)) %>%
  head(5)

# Bar chart
(bars <- ggplot(bar_df,aes(x = reorder(country,-lifeExp), y = lifeExp)) +
    geom_bar(stat = "identity"))

# Bar chart - Alternative
(bars <- ggplot(bar_df,aes(x = reorder(country,-lifeExp), y = lifeExp)) +
    geom_col())

# Vertical bar chart
bar_vdf <- gapminder_df %>%
  filter(year == 2007 & continent == "Africa") %>%
  arrange(desc(lifeExp)) %>%
  head(20)

(bars <- ggplot(bar_vdf,aes(x = reorder(country,lifeExp), y = lifeExp)) +
    geom_col() +
    coord_flip())

# Note: you can call it again with "bars"

# Grouped bar plot - Select dataset
grouped_bar_df <- gapminder_df %>%
  filter((year == 2007 | year == 1967) & continent == "Africa") %>%
  arrange(desc(country)) %>%
  head(10)

# Grouped bar plot
grouped_bars <- ggplot(grouped_bar_df,
                       aes(x = reorder(country,-lifeExp),
                           y = lifeExp,
                           fill = as.factor(year))) +
                geom_bar(stat="identity",
                         position="dodge")
# Show chart
grouped_bars

# Histogram
hist_plot <- gapminder_df %>%
  filter(year == 2007) %>%
  ggplot(aes(x = lifeExp)) +
  geom_histogram(binwidth=5,color="white")

# Show chart
hist_plot

# Add labels and title to the Histogam

# Histogram
hist_plot <- hist_plot +
  labs(x = "Life Expectancy (years)",
       y = "Count",
       title = "Life expectancy",
       subtitle = "Year = 2007",
       caption = "Source: Gapminder")

# Show chart
hist_plot

# Save the chart as png
ggsave("life_exp_2007.png",hist_plot,
       height = 4, width = 6, units = "in", dpi = 450)

#knitr::include_graphics("life_exp_2007.png")

# Plot themes
# Examples: theme_grey(), theme_bs(), theme_minimal(), theme_classic()
# Packages: bblot, urbnthemes, ggthemes

# Grey theme
gapminder_df %>%
  filter(country =="China" | country =="United States") %>%
  ggplot(aes(x = year, y = lifeExp, colour = country)) + 
  geom_line(size = 1) +
  theme_gray()

# Black and White theme
gapminder_df %>%
  filter(country =="China" | country =="United States") %>%
  ggplot(aes(x = year, y = lifeExp, colour = country)) + 
  geom_line(size = 1) +
  theme_bw()

# Minimal theme
gapminder_df %>%
  filter(country =="China" | country =="United States") %>%
  ggplot(aes(x = year, y = lifeExp, colour = country)) + 
  geom_line(size = 1) +
  theme_minimal()

# Classic theme
gapminder_df %>%
  filter(country =="China" | country =="United States") %>%
  ggplot(aes(x = year, y = lifeExp, colour = country)) + 
  geom_line(size = 1) +
  theme_classic()

# Economist theme
gapminder_df %>%
  filter(country =="China" | country =="United States") %>%
  ggplot(aes(x = year, y = lifeExp, colour = country)) + 
  geom_line(size = 1) +
  ggthemes::theme_economist_white()

# Theme few
gapminder_df %>%
  filter(country =="China" | country =="United States") %>%
  ggplot(aes(x = year, y = lifeExp, colour = country)) + 
  geom_line(size = 1) +
  ggthemes::theme_few()

# Changing a theme 1
gapminder_df %>%
  filter(country =="China" | country =="United States") %>%
  ggplot(aes(x = year, y = lifeExp, colour = country)) + 
  geom_line(size = 1) +
  geom_hline(yintercept = 0, size = 1, color = "#333333") +
  theme_minimal()

# Changing a theme 2
gapminder_df %>%
  filter(country =="China" | country =="United States") %>%
  ggplot(aes(x = year, y = lifeExp, colour = country)) + 
  geom_line(size = 1) +
  geom_hline(yintercept = 0, size = 1, color = "#333333") +
  theme_minimal() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank())

