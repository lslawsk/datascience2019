# Intro to dplyr in certain functions
library(dplyr)

stats::filter # differentiate between packages that have the same function

# load gapminder data as sample dataset
gapminder <- read.csv("data/gapminder_data.csv",
                      stringsAsFactors = F) # no factors (levels), just text

# to change back to factors use below and check
# gapminder$continent <- as.factor(gapminder$continent)
# is.factor(gapminder$continent)

# mean GDP per capita for Africa in base R
mean(gapminder[gapminder$continent == "Africa", "gdpPercap"])

# dplyr functions we will learn: select(), filter(), group_by(), summarize(), mutate()

# Pipe function to get there faster %>%. in dplyr.
# shortcut for %>%: control, shift, m
# shortcut for <-: alt, -

# attributes in gapminder
colnames(gapminder)

# select use
# select three attributes
subset_1 <- gapminder %>%
  select(country, continent, lifeExp)
# select every attribute except two
subset_2 <- gapminder %>% 
  select(-lifeExp, -pop)
str(subset_2)
# select some attributes but rename a few for clarity
subset_3 <- gapminder %>% 
  select(country, population = pop, lifeExp, gdp = gdpPercap)
str(subset_3)

# filter use
africa <- gapminder %>% 
  filter(continent == "Africa") %>% 
  select(country, population = pop, lifeExp)
table(africa$country) # if factors were on (changed above) then would show other countries as 0

# pipe carries left forward. if did not use:
# africa <- filter(gapminder, continent == "Africa")
# africa <-  select(africa, country, population = pop, LifeExp)

#display list for reference
africa_countryList <- table(africa$country)
View(africa_countryList)

# select year, pop, country for Europe
europe <- gapminder %>% 
  filter(continent == "Europe") %>% 
  select(country, year, population = pop)