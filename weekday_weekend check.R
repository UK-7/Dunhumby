# bin time by hour and label by hour
completeTransactions$timeBin <- cut(completeTransactions$TRANS_TIME, seq(0, 2400, 100), 
                                    seq(0, 23, 1))

# separate weekend from weekday
dayCheck <- ((completeTransactions$DAY - 1) %% 7 == 0 | completeTransactions$DAY %% 7 == 0)
completeTransactions$DAY.type <- ifelse(dayCheck, "weekend", "weekday")

# convert the time bins into integers so that I can make the graph
completeTransactions$timeBin <- as.integer(completeTransactions$timeBin)

library("ggplot2")

ggplot(aes(x = timeBin, color = DAY.type), data = completeTransactions) +
  geom_freqpoly(binwidth = 1) +
  scale_x_continuous(limits = c(0, 24), breaks = seq(0, 24, 4))

## Based on this plot, time trends in shopping does not change between the 
## weekeday and the weekend.