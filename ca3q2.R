getwd()
heart <- read.csv(file.choose())
str(heart)
head(heart)
set.seed(3033)
intrain <- createDataPartition(y=heart$target, p=0.8, list=FALSE)
training <- heart[intrain,]
testing <- heart[-intrain,]
dim(training);
dim(testing);
anyNA(heart)
summary(heart)
training[["target"]] = factor(training[["target"]])
trctrl <- trainControl(method = "repeatedcv",number = 10,repeats = 3)
svm_linear <- train(target ~., data=training,method="svmLinear",
                    trainControl=trctrl,
                    preProcess=c("center","scale"),
                    tunelength=10)
svm_linear

test_pred <- predict(svm_linear,newdata=testing)
test_pred
confusionMatrix(table(tesr_pred,testing$heart.disease))