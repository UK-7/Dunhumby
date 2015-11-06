library("dplyr")
transaction_data<-read.csv('D:/IIT/math-474/completeTransactions.csv',header=T, sep=",", fill = TRUE)

#Get a snapshot of the data
tbl_df(transaction_data)
summary(transaction_data)

#What are the possible values for the attributes?
unique(transaction_data$AGE_DESC)
unique(transaction_data$MARITAL_STATUS_CODE)
unique(transaction_data$TRANS_TIME)
unique(transaction_data$DAY)

#bucket transaction time
transaction_data$TRANS_TIME = cut(transaction_data$TRANS_TIME, breaks = c(-Inf,0000,0800,1200,1600,2000,Inf), labels = c("Error", "Early Morning", "Morning", "Afternoon", "Evening","Late vening"))

#get frequency of purchases per day, buy calculating the mean
transactions_by_day<-transaction_data %>% group_by(DAY) %>% summarise(n())
mean_transactions_by_day<-((colMeans(purchases_by_day))[2])

#what's the probability that less that 2000 transactions occur in a day
ppois(2000,mean_transactions_by_day)
