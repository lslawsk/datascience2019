# to work with split-apply-combine RMarkdown file
# read in Excel bike count and tabular weather data

library(readxl)
library(lubridate)
library(dplyr)
library(readr)

input_file <- "data/Hawthorne Tilikum Steel daily bike counts 073118.xlsx"
bridge_names <- c("Hawthorne", "Tilikum", "Steel")

# define a function that loads excel sheets
load_data <- function(bridge_name, input_file){
  bikecounts <- read_excel(input_file, sheet = bridge_name,
                           skip = 1) %>%   # skips first row
    filter(total > 0) %>% 
    select(date, total) %>%
    mutate(bridge = bridge_name,
           date = as.Date(date))   # drops unneeded time
}

# h <- load_data("Hawthorne", input_file)  # test if data will load in

# load data from each sheet into list
# then combine all three into one dataframe
bikecounts <- lapply(bridge_names, load_data,
                     input_file = input_file) %>% 
  bind_rows()

# factorize bridge name, since here it makes sense
bikecounts <- bikecounts %>% mutate(bridge = factor(bridge))
head(bikecounts)

# read in weather data
wx <- read_csv("data/NCDC-CDO-USC00356750.csv")
head(wx)
