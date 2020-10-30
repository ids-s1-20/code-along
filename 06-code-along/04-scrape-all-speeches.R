# Load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(lubridate)

# Load function: scrape_speech() -----------------------------------------------

source("02-scrape-speech.R")

# Get URLs of all speeches -----------------------------------------------------

all_speeches_page <- read_html("https://www.gov.scot/collections/first-ministers-speeches/")

covid_speech_urls <- all_speeches_page %>%
  html_nodes(".collections-list a") %>%
  html_attr("href") %>%
  str_subset("covid-19") %>%
  str_c("https://www.gov.scot", .)

# Map function over URLs of all speeches ---------------------------------------

covid_speeches <- map_dfr(covid_speech_urls, scrape_speech)

# Save data --------------------------------------------------------------------

write_rds(covid_speeches, file = "data/covid_speeches.rds")
