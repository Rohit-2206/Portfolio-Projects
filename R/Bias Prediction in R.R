install.packages("SimDesign")
library(SimDesign)

actual_data <- c(32.8 , 90, 76, 95 , 103)
predicted_temp <- c(18, 30, 61, 43, 87)
bias(actual_data,predicted_temp)

actual <- c(23.7,21.2,33,29)
pred <- c(22.9,22,32.8,28.7)
bias(actual,pred)