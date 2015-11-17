products <- select(product, COMMODITY_DESC, SUB_COMMODITY_DESC)
sub_commodities<-unique(prod_edit[,c("COMMODITY_DESC","SUB_COMMODITY_DESC")])
attach(sub_commodities)
ordered <- sub_commodities[order(COMMODITY_DESC),]
detach(sub_commodities)
write.csv(ordered, "sub_commidities.csv", row.names=FALSE, na="")

