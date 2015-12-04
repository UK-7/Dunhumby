products = read.csv("/Users/utkarsh/Developer/dunnhumby_The-Complete-Journey/dunnhumby - The Complete Journey CSV/product.csv", head=TRUE, sep=',')
transactions = read.csv("/Users/utkarsh/Developer/dunnhumby_The-Complete-Journey/dunnhumby - The Complete Journey CSV/transaction_data.csv", head = TRUE, sep = ',')
totalTrans = merge(products, transactions, by = "PRODUCT_ID", all = FALSE)

wines = subset(totalTrans, grepl("WINE", totalTrans$COMMODITY_DESC))
wines = subset(wines, wines$QUANTITY != 0)
wines$UNIT_PRICE <- wines$SALES_VALUE / wines$QUANTITY
wines = wines[!duplicated(wines$PRODUCT_ID), ]

SubComAvg <- aggregate(wines["UNIT_PRICE"], wines["SUB_COMMODITY_DESC"], mean)
ComAvg <- aggregate(wines["UNIT_PRICE"], wines["COMMODITY_DESC"], mean)

#Wines classified as cheapWines(<5), modWines(5-10), expWines (>10)
cheapWines <- wines[which(wines$UNIT_PRICE < 5.00), ]
modWines <- subset(wines, UNIT_PRICE > 5.00 & UNIT_PRICE <= 10.00)
expWines <- subset(wines, UNIT_PRICE > 10.00)

#merging wine categories
cheapWineTrans <- merge(transactions, cheapWines, by = "PRODUCT_ID")
modWineTrans <- merge(transactions, modWines, by = "PRODUCT_ID")
expWineTrans <- merge(transactions, expWines, by = "PRODUCT_ID")

#write.csv(ComAvg, "ComAvg.csv", append = FALSE)
#write.csv(SubComAvg, "SubComAvg.csv", append = FALSE)