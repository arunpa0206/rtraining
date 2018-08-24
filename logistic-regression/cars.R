# Select some columns form mtcars.
input <- mtcars[,c("am","cyl","hp","wt")]

print(head(input))


am.data = glm(formula = am ~ cyl + hp + wt, data = input, family = binomial)

print(am.data)
