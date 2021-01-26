install.packages("tidyverse")
library(tidyverse)

# DATASET ####
# Our World in Data - COVID dataset
# https://github.com/owid/covid-19-data/tree/master/public/data

# load the csv file directly from the website
# owid_covid = read.csv("https://covid.ourworldindata.org/data/owid-covid-data.csv", 
#                      header = TRUE, stringsAsFactors = FALSE)

# OR load the csv file that is in your Session3/data folder
owid_covid = read.csv("Session3/data/owid-covid-data.csv", header = TRUE, 
                      stringsAsFactors = FALSE)



# LOOK at the data ####
dim(owid_covid)
names(owid_covid)
View(owid_covid)
str(owid_covid)

owid_covid$location
# DATA TYPES - do all the columns look okay, does anything need to be changed?
?Dates
owid_covid$date = as.Date(owid_covid$date)
new_year = "2021-01-01"

# MISSING DATA - are there any missing data? Do you want to remove/replace them? ####


# SUBSET DATA - which columns should we keep? ####

names(owid_covid)

owid_covid %>%
  select() -> owid_covid_selected

# FILTER DATA - should we filter data? What criteria should we use? ####

owid_covid %>%
  filter(location == "United Kingdom") -> owid_covid_uk

owid_covid %>%
  filter(location == "Belgium") -> owid_covid_belgium

plot(x = owid_covid_uk$date, y = owid_covid_uk$total_cases_per_million)
plot(x = owid_covid_uk$date, y = owid_covid_uk$total_cases_per_million, type = "l")

# Q: Plot the total deaths in the US across time


# Exploring - TO DELETE

owid_covid %>%
  mutate(hdi_class = if_else(human_development_index < 0.5, "low", if_else(human_development_index > 0.9, "high", "moderate"))) %>%
  select(date, population, population_density, total_cases_per_million, total_deaths, location, hdi_class) %>%
  filter(hdi_class != "moderate") %>%
  ggplot(aes(x = date, y = total_cases_per_million, group = location, colour = hdi_class)) +
    geom_line() +
    theme_bw()

# PROBLEM SET ####


