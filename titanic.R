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
