# Import the training and testing sets
train_url <- "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/train.csv"
test_url <- "http://s3.amazonaws.com/assets.datacamp.com/course/Kaggle/test.csv"
# Create the dataframes
train <- read.csv(train_url)
test <- read.csv(test_url)

# Investigate the data  

## Two-way comparison: Sex and Survived  
table(train$Sex, train$Survived)
## Two-way comparison: row-wise proportions  
prop.table(table(train$Sex, train$Survived),1)

## Create the column child, and indicate whether child or no child  
train$Child <- NA
train$Child[train$Age < 18] <- 1
train$Child[train$Age >= 18] <- 0
## Two-way comparison  
prop.table(table(train$Child, train$Survived),1)

# Build the decision tree
my_tree <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")

## Visualize the decision tree using plot() and text()
plot(my_tree)
text(my_tree)
## Load in the packages to build a fancy plot
library(rattle)
library(rpart.plot)
library(RColorBrewer)
## Time to plot your fancy tree
fancyRpartPlot(my_tree)

# Another decision tree
my_tree2 <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked,
                     data = train, method = "class", control = rpart.control(minsplit = 50, cp = 0))
## Visualize my_tree2
fancyRpartPlot(my_tree2)

# Make predictions on the test set
my_prediction <- predict(my_tree, newdata = test, type = "class")
my_prediction2 <- predict(my_tree2, newdata = test, type = "class")
my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)
## Finish the write.csv() call
write.csv(my_solution, file = "my_solution.csv", row.names = FALSE)
