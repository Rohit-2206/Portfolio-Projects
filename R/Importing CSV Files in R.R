#loading csv data
bookings_df <- read_csv("hotel_bookings.csv")
#preview data using head() function
head(bookings_df)
#summarizing data using str()
str(bookings_df)
#column names
colnames(bookings_df)
new_df <- select(bookings_df, `adr`, adults,company)
View(new_df)

mutate(new_df, total = `adr` / adults)

