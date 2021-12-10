setwd("C:/Users/91970/Documents")
mydata <- read.csv("dividendinfo.csv")
attach(mydata)

scaleddata<-scale(mydata)

normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

maxmindf <- as.data.frame(lapply(mydata, normalize))

# Training and Test Data
trainset <- maxmindf[1:160, ]
testset <- maxmindf[161:200, ]

#Neural Network
install.packages("neuralnetwork")
library("neuralnetwork")
install.packages("remotes")
library(remotes)
install_github("cran/neuralnet")
nn <- neuralnet(dividend ~ fcfps + earnings_growth + de + mcap + current_ratio, data=trainset, hidden=c(2,1), linear.output=FALSE, threshold=0.01)
nn$result.matrix
plot(nn)


#Test the resulting output
temp_test <- subset(testset, select = c("fcfps","earnings_growth", "de", "mcap", "current_ratio"))
head(temp_test)
nn.results <- compute(nn, temp_test)
results <- data.frame(actual = testset$dividend, prediction = nn.results$net.result)

roundedresults<-sapply(results,round,digits=0)
roundedresultsdf=data.frame(roundedresults)
attach(roundedresultsdf)
table(actual,prediction)

