# Part 2. functions to fetch public Biketown trip data.
# see: https://www.biketownpdx.com/system-data

# pacman allows checking for and installing missing packages
# if package is not installed, then install
# sidenote: try restarting R sometimes to clear environment to get to run if having problems
if (!require("pacman")) {install.packages("pacman")}; library(pacman)
pacman::p_load("lubridate")
pacman::p_load("dplyr")
pacman::p_load("stringr")
pacman::p_load("readr")

# another way to install multiple packages (without checking if already dl)
# install.packages(c("lubridate", "dplyr", "stringr", "readr"))

get_data <- function(start = "7/2016", end = NULL,
                     base_url = "https://s3.amazonaws.com/biketown-tripdata-public/",
                     outdir = "data/biketown/") {
  # takes start and end in mm/yyyy format, and tries to dl resulting files
  
  # if no end date given, set to now to get all most recent
  end <- ifelse(is.null(end), format(lubridate::now(), "%m/%Y"), end)
  
  # make url function only available within get_data
  make_url <- function(date, base_url) {
    url <- paste0(base_url,format(date, "%Y_%m"), ".csv")
    return(url)
  }
  
  # parse date range
  start_date <- lubridate::myd(start, truncated = 2)
  end_date <- lubridate::myd(end, truncated = 2)
  date_range <- seq(start_date, end_date, by = "months")
  
  # use apply functions instead of for loops
  # lapply(a, b) applies a function b to a sequence a and returns list of modified seq.
  # urls <- lapply(date_range, make_url, base_url = base_url)
  
  # 3 different ways to do the same thing, 1) and 2) use urls from above
  
  # 1) for loop over named list of urls; can be easier for early devel. since more readable
  # for(u in urls) {
  #   download.file(u, destfile = paste0(outdir,
  #                                      str_sub(u, -11)))
  # }
  
  # 2) as apply with inline function
  # result <- lapply(urls, function(u) {
  #   download.file(u, destfile = paste0(outdir, str_sub(u, -11)))
  # })
  
  # 3) tidy piped function that combines creating urls to download files
  lapply(date_range, make_url, base_url = base_url) %>% 
    lapply(function(u) {download.file(u, destfile = paste0(outdir,
                                                           str_sub(u, -11)))
    })
}

## manual run ## test ##
# params
start = "11/2018"
end = "8/2018"

get_data(start)
