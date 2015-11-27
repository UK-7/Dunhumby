#completeTransactions$timeBin <- cut(completeTransactions$TRANS_TIME, seq(0, 2400, 100), 
                                    #seq(0, 23, 1))

completeTransactions$INCOME_DESC <- factor(completeTransactions$INCOME_DESC,  
                                           levels = c("Under 15K", "15-24K", "25-34K", 
                                                      "35-49K", "50-74K", "75-99K", 
                                                      "100-124K", "125-149K", "150-174K", 
                                                      "175-199K", "200-249K", "250K+"), 
                                           ordered = TRUE)

hh_comp_counts <- completeTransactions %>%
  group_by(HH_COMP_DESC) %>%
  summarize(count = n())
hh_comp_counts$p <- round(hh_comp_counts$count/sum(hh_comp_counts$count),4)

income_counts <- completeTransactions %>%
  group_by(INCOME_DESC) %>%
  summarize(count = n())
income_counts$p <- round(income_counts$count/sum(income_counts$count), 4)

age_counts <- completeTransactions %>%
  group_by(AGE_DESC) %>%
  summarize(count = n())
age_counts$p <- round(age_counts$count/sum(age_counts$count), 4)

age.distro <- age_counts$p
hh.distro <- hh_comp_counts$p
income.distro <- income_counts$p

####################

chicheck_inc <- function(subcomm) {
  
  temp <- completeTransactions %>% 
    group_by(INCOME_DESC) %>% 
    summarise(sum = sum(SUB_COMMODITY_DESC == subcomm))
  
  chisq.test(temp$sum, p= income.distro, rescale.p = TRUE)$p.value
}

chicheck_hh <- function(subcomm) {
  
  temp <- completeTransactions %>% 
    group_by(HH_COMP_DESC) %>% 
    summarise(sum = sum(SUB_COMMODITY_DESC == subcomm))
  
  chisq.test(temp$sum, p = hh.distro, rescale.p = TRUE)$p.value
}

chicheck_age <- function(subcomm) {
  
  temp <- completeTransactions %>% 
    group_by(AGE_DESC) %>% 
    summarise(sum = sum(SUB_COMMODITY_DESC == subcomm))
  
  chisq.test(temp$sum, p = age.distro, rescale.p = TRUE)$p.value
}

oldw <- getOption("warn") ## save old warning values
options(warn = -1) ## turn off warnings

result_age <- lapply(sub_comms$SUB_COMMODITY_DESC, chicheck_age) # makes list of p-values by age
result_hh <- lapply(sub_comms$SUB_COMMODITY_DESC, chicheck_hh) # makes list of p-values by household composition
result_income <- lapply(sub_comms$SUB_COMMODITY_DESC, chicheck_inc) # makes list of p-values by income

# creates a data frame with all of the p-values
chi_results <- data.frame(sum_commodity = sub_comms$SUB_COMMODITY_DESC, age = unlist(result_age), hh_comp = unlist(result_hh), income = unlist(result_income))

options(warn = oldw)  ## restore old warning values

# this function creates three graphs showing distributions based on age, income, and household composition
# subcomm is the the sub commodity string - example: graphDescript("BOX WINES") - produces three graphs of distributions based on Box Wine sales
graphDescript <- function(subcomm) {
  print(ggplot(aes(x = AGE_DESC), 
         data = completeTransactions[completeTransactions$SUB_COMMODITY_DESC == subcomm, ]) +
    geom_histogram() + xlab(paste("Age - ", subcomm, sep = " ")))
  
  print(ggplot(aes(x = HH_COMP_DESC), 
         data = completeTransactions[completeTransactions$SUB_COMMODITY_DESC == subcomm, ]) +
    geom_histogram() + xlab(paste("HH - ", subcomm, sep = " ")))
  
  print(ggplot(aes(x = INCOME_DESC), 
         data = completeTransactions[completeTransactions$SUB_COMMODITY_DESC == subcomm, ]) +
    geom_histogram() + xlab(paste("Income - ", subcomm, sep = " ")))
}

graphDescript("BOX WINES")

####################################

