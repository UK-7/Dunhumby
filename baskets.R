library("dplyr")

transaction_data<-read.csv('D:/IIT/math-474/dunnhumby - The Complete Journey CSV/transaction_data.csv',header=T, sep=",", fill = TRUE)
product<-read.csv('D:/IIT/math-474/dunnhumby - The Complete Journey CSV/product.csv',header=T, sep=",", fill = TRUE)
hh_demographic<-read.csv('D:/IIT/math-474/dunnhumby - The Complete Journey CSV/hh_demographic.csv',header=T, sep=",", fill = TRUE)
campaign<-read.csv('D:/IIT/math-474/dunnhumby - The Complete Journey CSV/campaign_table.csv',header=T, sep=",", fill = TRUE)
campaign_desc<-read.csv('D:/IIT/math-474/dunnhumby - The Complete Journey CSV/campaign_desc.csv',header=T, sep=",", fill = TRUE)

# remove columns from transaction_data.csv
trans_edit <- select(transaction_data, DAY, QUANTITY, TRANS_TIME, household_key, PRODUCT_ID, BASKET_ID, SALES_VALUE, RETAIL_DISC, COUPON_DISC, COUPON_MATCH_DISC,WEEK_NO)

# remove columns from hh_demographic.csv
demo_edit <- select(hh_demographic, INCOME_DESC, HH_COMP_DESC, AGE_DESC, MARITAL_STATUS_CODE, household_key)

# join transaction and demographic
trans_demo <- inner_join(trans_edit, demo_edit, by = "household_key")

#calculate discount attr
#trans_demo$SPENT_BY_CUSTOMER = trans_demo$SALES_VALUE + trans_demo$COUPON_DISC
#trans_demo$RECEIVED_BY_RETAILER = trans_demo$SALES_VALUE

#get baskets
baskets <- trans_demo %>%
  group_by(BASKET_ID,INCOME_DESC, household_key,AGE_DESC,HH_COMP_DESC,MARITAL_STATUS_CODE) %>%
  summarize(SPENT_BY_CUSTOMER = sum(SALES_VALUE + COUPON_DISC), RECEIVED_BY_RETAILER= sum(SALES_VALUE))

attach(baskets)
fit<-lm(SPENT_BY_CUSTOMER~HH_COMP_DESC+INCOME_DESC, data=baskets)
summary(fit)
detach(baskets)

predict(fit,newdata = unique(baskets[,c("HH_COMP_DESC","INCOME_DESC")]),interval='confidence')

#group baskets by household key_day
baskets_per_day <- trans_demo %>%
  group_by(INCOME_DESC, household_key,AGE_DESC,HH_COMP_DESC,MARITAL_STATUS_CODE, DAY) %>%
  summarize(SPENT_BY_CUSTOMER = sum(SALES_VALUE + COUPON_DISC), RECEIVED_BY_RETAILER= sum(SALES_VALUE))

fit<-lm(baskets_per_day$SPENT_BY_CUSTOMER~baskets_per_day$HH_COMP_DESC+baskets_per_day$INCOME_DESC, data=baskets)
summary(fit)

#group baskets by household key_week
  
baskets_per_week <- trans_demo %>%
  group_by(INCOME_DESC, household_key,AGE_DESC,HH_COMP_DESC,MARITAL_STATUS_CODE, WEEK_NO) %>%
  summarize(SPENT_BY_CUSTOMER = sum(SALES_VALUE + COUPON_DISC), RECEIVED_BY_RETAILER= sum(SALES_VALUE))

fit<-lm(baskets_per_week$SPENT_BY_CUSTOMER~baskets_per_week$HH_COMP_DESC+baskets_per_week$INCOME_DESC, data=baskets)
summary(fit)

