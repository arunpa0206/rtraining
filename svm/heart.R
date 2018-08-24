library("e1071")
head(iris,5)

attach(iris)

x <- subset(iris, select=-Species)
y <- Species

#svm_model <- svm(Species ~ ., data=iris)
#summary(svm_model)

svm_model1 <- svm(x,y)
summary(svm_model1)

pred <- predict(svm_model1,x)
system.time(pred <- predict(svm_model1,x))

table(pred,y)
