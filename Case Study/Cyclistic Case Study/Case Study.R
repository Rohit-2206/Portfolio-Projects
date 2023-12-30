library(tidyverse)
library(ggplot2)
library(dplyr)
library(lubridate)

june <- read.csv("06-2023.csv")
july <- read.csv("07-2023.csv")
aug <- read.csv("08-2023.csv")
sep <- read.csv("09-2023.csv")
oct <- read.csv("10-2023.csv")
nov <- read.csv("11-2023.csv")

ride_details <- bind_rows(june,july,aug,sep,oct,nov)

remove(june,july,aug,sep,oct,nov)

ride_details    <-  mutate(ride_details, ride_id = as.character(ride_id)
                   ,rideable_type = as.character(rideable_type)) 

ride_details <- janitor::remove_empty(ride_details,which = c("cols"))
ride_details <- janitor::remove_empty(ride_details,which = c("rows"))

ride_details <- ride_details %>%  
  select(-c(WeekDays))

ride_details <- na.omit(ride_details)

ride_details <- distinct(ride_details)

table(ride_details$member_casual)


ride_details$date <- format(as.Date(ride_details$started_at, 
                                    format = "%d-%m-%Y %H:%M"), "%d %m %Y")


ride_details$month <- format(as.Date(ride_details$date, "%m"))
ride_details$day <- format(as.Date(all_trips$date), "%d")
ride_details$year <- format(as.Date(all_trips$date), "%Y")

ride_details$ride_length <- difftime(ride_details$ended_at,
                                     ride_details$started_at)

ride_details$starts_at <- strptime(ride_details$started_at, format = "%d-%m-%Y %H:%M")
ride_details$ends_at <- strptime(ride_details$ended_at, format = "%d-%m-%Y %H:%M")

ride_details$ride_lengths <- difftime(ride_details$ends_at, 
                                      ride_details$starts_at,unit="mins")

is.factor(ride_details$ride_lengths)
ride_details$ride_lengths <- as.numeric(as.character(ride_details$ride_lengths))
is.numeric(ride_details$ride_lengths)

mean(ride_details$ride_lengths) 
median(ride_details$ride_lengths) 
max(ride_details$ride_lengths) 
min(ride_details$ride_lengths) 
table(ride_details$member_casual)

aggregate(ride_details$ride_lengths ~ ride_details$member_casual, FUN = mean)
aggregate(ride_details$ride_lengths ~ ride_details$member_casual, FUN = median)
aggregate(ride_details$ride_lengths ~ ride_details$member_casual, FUN = max)
aggregate(ride_details$ride_lengths ~ ride_details$member_casual, FUN = min)

aggregate(ride_details$ride_lengths ~ ride_details$member_casual + 
            ride_details$weekday, FUN = mean)

ride_details%>% 
  mutate(weekday = wday(starts_at, label = TRUE)) %>%  
  group_by(member_casual, weekday) %>%  
  summarise(number_of_rides = n(),average_duration = 
              mean(ride_lengths)) %>% 		
  arrange(member_casual, weekday)	

ride_details %>% 
  mutate(weekday = wday(starts_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")

ride_details%>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_lengths)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")




            


               

  

