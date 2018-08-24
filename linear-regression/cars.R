input <- mtcars[,c("mpg","disp","hp","wt")]
print(head(input))

# Create the relationship model.
model <- lm(mpg~disp+hp+wt, data = input)

# Show the model.
print(model)

cat("# # # # The Coefficient Values # # # ","\n")

a <- coef(model)[1]
print(a)

Xdisp <- coef(model)[2]
Xhp <- coef(model)[3]
Xwt <- coef(model)[4]

print(Xdisp)
print(Xhp)
print(Xwt)

cat("# # # # Prediction # # # ","\n")

#Y = a+Xdisp.x1+Xhp.x2+Xwt.x3
a<- data.frame(disp = 221, hp = 102, wt = 2.91)
result <-  predict(model,a)
print(result)
