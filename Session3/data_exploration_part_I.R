install.packages("tidyverse")
library(tidyverse)

# https://github.com/owid/covid-19-data/tree/master/public/data
owid_covid = read.csv("https://covid.ourworldindata.org/data/owid-covid-data.csv", 
                      header = TRUE, stringsAsFactors = FALSE)

# owid_covid = read.csv("Session3/data/owid-covid-data.csv", header = TRUE, stringsAsFactors = FALSE)

dim(owid_covid)

unique(owid_covid$iso_code)
names(owid_covid)
unique(owid_covid$location)

owid_covid %>%
  select(icu_patients, location, date, population, icu_patients_per_million) %>%
  filter(!is.na(icu_patients)) %>%
  mutate(icu_per_million = 1000000 * icu_patients/population) %>%
  mutate(date = as.Date(date)) %>%
  ggplot(aes(x = date, y = icu_patients_per_million, group = location, colour = location)) +
    geom_line() +
    theme_bw() -> icu_plot

plotly::ggplotly(icu_plot)
