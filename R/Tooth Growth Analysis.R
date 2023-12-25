data("ToothGrowth")
install.packages("dplyr")
library(dplyr)
#filtering data based on a column
filtered_tg <- filter(ToothGrowth,dose==0.5)
#viewing loaded data
View(filtered_tg)
#sort function
arrange(filtered_tg,desc(len))
#nested function
arrange(filter(Toothgrowth,dose==0.5),len)

#pipes example
filter_tooth <- ToothGrowth %>%
  filter(dose==0.5)%>%
  arrange(len)
View(filter_tooth)