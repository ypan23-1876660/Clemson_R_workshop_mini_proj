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

#Building the model
model <- train(category~., 
               data = training,
               method = 'rf',
               prox = TRUE)

#predict_model <- predict(model, testing)
