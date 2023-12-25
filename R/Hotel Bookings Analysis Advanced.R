#loading required packages
library(tidyverse)
library(skimr)
library(janitor)

#loading data
hotel_bookings <- read_csv("hotel_bookings.csv")
#looking at a glimpse of data
head(hotel_bookings)
str(hotel_bookings)
glimpse(hotel_bookings)
colnames(hotel_bookings)

#organizing data
arrange(hotel_bookings,-lead_time )

max(hotel_bookings$lead_time)

min(hotel_bookings$lead_time)

mean(hotel_bookings$lead_time)

hotel_summary <- 
  hotel_bookings %>%
  group_by(hotel) %>%
  summarise(average_lead_time=mean(lead_time),
            min_lead_time=min(lead_time),
            max_lead_time=max(lead_time))

head(hotel_summary)
