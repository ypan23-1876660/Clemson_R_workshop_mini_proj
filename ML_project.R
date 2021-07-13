#You could try P vs E or L vs H for the two classes. Probably better wtih P v E. (placentae vs endometrium)
rm(list=ls())

library(data.table)
library(stringr)
library(randomForest)
library(caret)

#Read in data
data = read.delim("Normalized_transcriptome_counts.txt")

#Set the first column as row name 
rownames(data) <- data[,1] #Assigning row names from 1st column 
data[,1] <- NULL #Removing the first column


#Transpose data
df <- transpose(data)
rownames(df) <- colnames(data)
colnames(df) <- rownames(data)

#Create a vector that is factor for category 
category <- rownames(df)
df1 <- cbind(category, df)
PE <- substring(df1$category, 1, 1)
df1$category <- as.factor(PE)

#Create training and testing set
parsing <- createDataPartition(y=df1$category, p=0.6, list = FALSE)
training <- df1[parsing,]
testing <- df1[-parsing,]

#Separating out the predictor: category
train_class <- training$category
train_data <- training[,-1]
install.packages("e1071")

#Building the model
#model <- train(train_data,train_class,method = 'rf',prox = TRUE)
model2 <- randomForest(train_data, train_class, proximity = TRUE)


#Applying model to predict the output on testing data set
testing_class <- testing$category
testing_data <- testing[,-1]
predict_df <- predict(model2, testing_data)


#Evaluating accuracy 
confusionMatrix(predict_df, testing_class)
#predict_model <- predict(model, testing)
