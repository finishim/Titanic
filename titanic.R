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
my_tree_two <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")
