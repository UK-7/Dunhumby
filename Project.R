#read data
transaction_data<-read.csv('D:/IIT/math-474/dunnhumby - The Complete Journey CSV/transaction_data.csv',header=T, sep=",", fill = TRUE)
product_data<-read.csv('D:/IIT/math-474/dunnhumby - The Complete Journey CSV/product.csv',header=T, sep=",", fill = TRUE)

#merge data, just an example
merged<-merge(transaction_data[c("BASKET_ID","PRODUCT_ID","QUANTITY","TRANS_TIME")],product_data[c("PRODUCT_ID","COMMODITY_DESC","DEPARTMENT")])