library("dplyr")

# Find out how many of each Commodity
countsComm <- completeTransactions %>%
  group_by(COMMODITY_DESC) %>%
  summarize(n = n())


# Find out how many of each Sub-Commodity
countsSubComm <- completeTransactions %>%
  group_by(SUB_COMMODITY_DESC) %>%  
  summarize(n = n())

# You can sort all of these alphabetically or by count in RStudio