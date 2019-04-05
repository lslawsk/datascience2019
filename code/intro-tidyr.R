# intro to tidyr
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)

# load bike data as sample messy dataset
# bikenet <- read.csv("data/bikenet-change.csv") in base r
bikenet <- read_csv("data/bikenet-change.csv") # in tidyr
head(bikenet)
summary(bikenet)
summary(factor(bikenet$facility2013)) # see as factor but does not convert to factor

# tidy table before being able to analyze
# gather facility columns into single year variable
colnames(bikenet) # show for reference for defining below
?gather
bikenet_2 <- bikenet %>% 
  gather(key = "year", value = "facility", facility2008:facility2013, na.rm = T) %>% 
  mutate(year = stringr::str_sub(year, start = -4)) # loads function from library stringr and grabs last 4 of string (the year)
head(bikenet_2)

## changing col names and joining example
## join/collapse columns for street and suffix into one
# bikenet_2 <- bikenet_2 %>% 
#  unite(col = "street", c("fname", "ftype"), sep = " ")
# head(bikenet_2)

## separate street and suffix back to two
# bikenet_2 <- bikenet_2 %>% 
#  separate(street, c("street_name", "street_suffix"))

bikenet_2 %>% filter(bikeid == 139730)

fac_lengths <- bikenet_2 %>% 
  filter(facility %in% c("BKE-LANE", "BKE-BLVD", "BKE-BUFF", "BKE-TRAK", "PTH-REMU")) %>% 
  group_by(year, facility) %>% 
  summarize(meters = sum(length_m)) %>% 
  mutate(miles = meters / 1609)
fac_lengths

# intro to graphing in ggplot2 as opposed to base r
plot <- ggplot(fac_lengths, aes(year, miles,
              group = facility,
              color = facility)) # data, coordinate frame, how to rep on graph
plot + geom_line()
plot + geom_point()
plot + geom_line() + scale_y_log10()
plot + geom_line() + labs(title = "Change in PDX Bikenet Facilities",
                          subtitle = "2008-2013",
                          caption = "source: Portland Metro") +
  xlab("Year") + ylab("Total Miles")

# new and separate plots
plot_2 <- ggplot(fac_lengths, aes(year, miles,
                                group = facility))
plot_2 + geom_line(size = 1, color = "blue") +
  facet_wrap( ~ facility)
