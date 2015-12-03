products = read.csv("/Users/utkarsh/Developer/dunnhumby_The-Complete-Journey/dunnhumby - The Complete Journey CSV/product.csv", head=TRUE, sep=',')
transactions = read.csv("/Users/utkarsh/Developer/dunnhumby_The-Complete-Journey/dunnhumby - The Complete Journey CSV/transaction_data.csv", head = TRUE, sep = ',')
totalTrans = merge(products, transactions, by = "PRODUCT_ID", all = FALSE)

wines = subset(totalTrans, grepl("WINE", totalTrans$COMMODITY_DESC))
wines = subset(wines, wines$QUANTITY != 0)
wines$UNIT_PRICE <- wines$SALES_VALUE / wines$QUANTITY
wines = wines[!duplicated(wines$PRODUCT_ID), ]

SubComAvg <- aggregate(wines["UNIT_PRICE"], wines["SUB_COMMODITY_DESC"], mean)
ComAvg <- aggregate(wines["UNIT_PRICE"], wines["COMMODITY_DESC"], mean)

#write.csv(ComAvg, "ComAvg.csv", append = FALSE)
#write.csv(SubComAvg, "SubComAvg.csv", append = FALSE)