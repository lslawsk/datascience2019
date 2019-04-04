# plotting Biketown data with base R
install.packages("tidyverse")
library(tidyverse)
library(lubridate) # for hour

# read in data
biketown <- read.csv("data/biketown-2018-trips.csv")
str(biketown)

# statistical summary in base R
summary(biketown)

# in tidyverse
# add column to dataset that is hour of the day
biketown$hour <- 
  hms(biketown$StartTime) %>% # creates time it can work with
  hour() # hour

# same as above in base R
# add column to dataset that is hour of the day
stime <- hms(biketown$StartTime)
biketown$hour <- hour(stime)

#investigating data using charts
freq_by_hour <- table(biketown$hour)
barplot(freq_by_hour) # bar chart to visualize for quick answer

hist(biketown$hour, breaks = seq(0, 24, 3)) # histogram by 3 hour blocks

am_peak <- subset(biketown, hour >= 7 & hour < 10) # subset to focus on morning peak
hist(am_peak$hour, breaks = seq(7, 10, 1)) # histogram of morning peak is not great
barplot(table(am_peak$hour)) # bar chart of morning peak, use table to lump entries into one bar

