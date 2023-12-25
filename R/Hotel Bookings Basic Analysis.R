#Step-1 Loading packages
library(tidyverse)
install.packages("skimr")
library(skimr)
install.packages("janitor")
library(janitor)

#Step-2 Importing Data using readr
bookings_df <- read_csv("hotel_bookings.csv")

#Step-3 Overall look of Data
head(bookings_df)
str(bookings_df)
glimpse(bookings_df)
colnames(bookings_df)
skim_without_charts(bookings_df) #gives a whole summary of data

#Step-4 Organizing Data
trimmed_df <- bookings_df %>% 
  select('hotel','is_canceled','lead_time')
View(trimmed_df)

trimmed_df %>% 
  select(hotel, is_canceled, lead_time) %>% 
  rename( hotel_id = hotel)

example_df <- bookings_df %>%
  select(arrival_date_year, arrival_date_month) %>% 
  unite(arrival_month_year, c("arrival_date_month", "arrival_date_year"), sep = " ")
View(example_df)

#Step-5 Organizing and Filtering Data
examples_df <- bookings_df %>%
  mutate(guests = adults + children + babies)

examples_df %>%
  select(guests) 

example2_df <- bookings_df %>%
  summarise(number_canceled = sum(is_canceled),
            average_lead_time= mean(lead_time))
View(example2_df)

