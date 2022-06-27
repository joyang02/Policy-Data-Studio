library(tidyverse)
library(janitor)

mex_migration <- read_csv("mig174.csv")
mex_migration_clean <- clean_names(mex_migration)
mex_mig_select <- select(mex_migration_clean, surveyyr, legyrapp, legyrrec)
mex_mig_filter <- filter(mex_mig_select, surveyyr >= 2012, !legyrapp %in% c(8888 , 9999) | !legyrrec %in% c(8888 , 9999))
#2012 was when DACA was implemented but not set on the reference year yet
#also need to figure out a more effecitve way to filter this! (like we talked about in class)
mex_mig_mutate <- mutate(mex_mig_filter, legy_change = legyrrec - legyrapp)
#need to figure out how to best show the number of years it takes to obtain legalization and citizenship
#in context so the individual numbers make sense relative to others

change_by_year <- mex_mig_mutate %>%group_by(legyrapp) %>% 
                  summarise(average_wait = mean(legy_change))