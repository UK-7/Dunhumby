#mtcars is a data set autoloaded with R
mtcars$wt
cond <- mtcars$wt < 3 #saving a conditional for weights less than 3
cond # so you can see it is a list of booleans based on the conditional and the column checked
mtcars$weight_class <- ifelse(cond, 'light', 'average') #creates a new column based on this ternary operator
mtcars$weight_class
cond <- mtcars$wt > 3.5 #saving a conditional for weights greather than 3.5
mtcars$weight_class <- ifelse(cond, 'heavy', mtcars$weight_class) # if true, change name, if not, leave it alone
mtcars$weight_class
#done