# practice after Part 1
install.packages("fivethirtyeight")
library(fivethirtyeight)
library(dplyr)
library(tidyr)
library(ggplot2)

d <- bob_ross
summary(d)
colnames(d)
View(d)
str(d)

str(d %>% group_by(season)) # group_by treats dataframe as bins
#summarize clouds by season
season_clouds <- d %>% 
  group_by(season) %>% 
  summarize(sum_clouds = sum(clouds))
View(season_clouds)

# bar chart of cloud counts
p_clouds <- ggplot(season_clouds, aes(season, sum_clouds), group = season)
p_clouds + geom_col()+
  labs(title = "Cloud Count by Season",
       caption = "source: FiveThirtyEight") +
  xlab("Season") + ylab("Cloud Count")

# cloud image sum by season
c_by_season <- d %>% 
  group_by(season) %>% 
  summarize(s_cirrus = sum(cirrus),
            s_clouds = sum(clouds),
            s_cumulus = sum(cumulus),
            s_fog = sum(fog))
s_c_all <- c_by_season %>%
  group_by(season) %>%
  mutate(s_c_all = s_cirrus + s_clouds + s_cumulus + s_fog)
View(c_by_season)

# https://stackoverflow.com/questions/40916252/ggplot-stacked-bar-graph-with-2-columns
# doesnt work
s_c_all_2 <- rbind(
  data.frame(season, "count" = s_cirrus, "type"="Cirrus"),
  data.frame(season, "count" = s_clouds, "type"="Clouds"),
  data.frame(season, "count" = s_cumulus, "type"="Cumulus"),
  data.frame(season, "count" = s_fog, "type"="Fog")
)
# doesnt work
p_c <- ggplot(s_c_all_2, aes(season, count, fill = type))
p_c + geom_bar(stat = "identity")
