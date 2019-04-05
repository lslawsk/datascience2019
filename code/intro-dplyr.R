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

# select() use
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

# filter() use
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

# group() and summarize() use
str(gapminder %>% group_by(continent)) # what do you see? group_by treats dataframe as bins

#summarize gdp by continent
gdp_continent <- gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdp = mean(gdpPercap),
            mean_life = mean(lifeExp))
View(gdp_continent)

library(ggplot2)
summary_plot <- gdp_continent %>% 
  ggplot(aes(x = mean_gdp, y = mean_life, label = continent)) +
  geom_point(stat = "identity") + geom_text(aes(label = continent),hjust=0, vjust=-0.5)
  theme_bw()
summary_plot

# mean pop for continents
pop_continent <- gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_pop = mean(pop))

# count() use
# display how many counts of entries for the year (i.e. how many countries)
# use two equal signs == for search or comparison. one = is argument assignment or formula
gapminder %>% 
  filter(year == 2002) %>% 
  count(continent, sort = TRUE)

# n() use
# standard error for each continent but don't know how many obs within each there are
# n auto solves for the number of obs within each group
gapminder %>% 
  group_by(continent) %>% 
  summarize(se = sd(lifeExp)/sqrt(n()))

# mutate() use
# adds column for every observation into environment
xy <- data.frame(x = rnorm(100),
                 y = rnorm(100))
head(xy) # generates random numbers based on above
# adding to original data frame in HERE not in raw data
xyz <- xy %>%
  mutate(z = x * y)
head(xyz)
# add column for full gdp per continent, then sum by continent. Try to nest though.
fullgdp <- gapminder %>% 
  mutate(full_gdp = pop * gdpPercap)
head(fullgdp)

gdp_perCont <- gapminder %>% 
  mutate(full_gdp = pop * gdpPercap) %>% 
  group_by(continent) %>% 
  summarize(full_gdp_Cont = sum(full_gdp))
gdp_perCont


