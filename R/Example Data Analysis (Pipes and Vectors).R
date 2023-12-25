#creating a atomic vector
name <- c("Abcd","Defg","Hijk","Klmn")
#creating a numeric vector
age <- c(21,76,20,69)
#creating a data frame
family <- data.frame(name , age)

head(family)
str(family)
glimpse(family)

mutate(family, age_in_20 = age + 20)
View(family)
filter_age <- filter(family,age < 50)
View(filter_age)

new_family <- family %>%
  arrange(desc(name))%>%
  filter(age>=21)
View(new_family)
