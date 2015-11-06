library("dplyr")

# remove columns from transaction_data.csv
trans_edit <- select(transaction_data, DAY, QUANTITY, TRANS_TIME, household_key, PRODUCT_ID)
# remove columns from product.csv
prod_edit <- select(product, PRODUCT_ID, DEPARTMENT, COMMODITY_DESC, SUB_COMMODITY_DESC)

# join transaction data with product
trans_prod <- left_join(trans_edit, prod_edit, by = "PRODUCT_ID")

# move household_key column to the last column
trans_prod <- trans_prod %>%
  select(-household_key, everything())

# inner join columns together (inner join removes rows that do not have values
# denoted by the "by" parameter)
complete <- inner_join(trans_prod, hh_demographic, by = "household_key")

# write data frame to csv file
write.csv(complete, "completeTransactions.csv", row.names=FALSE, na="")