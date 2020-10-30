# Load packages ----------------------------------------------------------------
library(tidyverse)
library(rvest)
library(lubridate)

# 26 OCT -----------------------------------------------------------------------

# Set URL of page to scrape ----------------------------------------------------
url <- "https://www.gov.scot/publications/coronavirus-covid-19-update-first-ministers-speech-26-october/"

# Read page -------------------------------------------------------------------- 
speech_page <- read_html(url)

# Extract titles --------------------------------------------------------------- 
title <- speech_page %>%
  html_node(".article-header__title") %>%
  html_text()

# Extract dates ----------------------------------------------------------------
date <- speech_page %>%
  html_node(".content-data__list:nth-child(1) strong") %>%
  html_text() %>%
  dmy() # convert to date

# Extract locations ------------------------------------------------------------
location <- speech_page %>%
  html_node(".content-data__list+ .content-data__list strong") %>%
  html_text()

# Extract abstracts ------------------------------------------------------------ 
abstract <- speech_page %>%
  html_node(".leader--first-para p") %>%
  html_text()

# Extract text -----------------------------------------------------------------
text <- speech_page %>% 
  html_nodes("#preamble p") %>%
  html_text() %>%
  list()

# Put it altogether ------------------------------------------------------------
speech_26_oct <- tibble(
  title    = title,
  date     = date,
  location = location,
  abstract = abstract,
  text     = text,
  url      = url
)

# 23 OCT -----------------------------------------------------------------------

# Set URL of page to scrape ----------------------------------------------------
url <- "https://www.gov.scot/publications/coronavirus-covid-19-update-first-ministers-speech-23-october/"

# Read page -------------------------------------------------------------------- 
speech_page <- read_html(url)

# Extract titles --------------------------------------------------------------- 
title <- speech_page %>%
  html_node(".article-header__title") %>%
  html_text()

# Extract dates ----------------------------------------------------------------
date <- speech_page %>%
  html_node(".content-data__list:nth-child(1) strong") %>%
  html_text() %>%
  dmy() # convert to date

# Extract locations ------------------------------------------------------------
location <- speech_page %>%
  html_node(".content-data__list+ .content-data__list strong") %>%
  html_text()

# Extract abstracts ------------------------------------------------------------ 
abstract <- speech_page %>%
  html_node(".leader--first-para p") %>%
  html_text()

# Extract text -----------------------------------------------------------------
text <- speech_page %>% 
  html_nodes("#preamble p") %>%
  html_text() %>%
  list()

# Put it altogether ------------------------------------------------------------
speech_23_oct <- tibble(
  title    = title,
  date     = date,
  location = location,
  abstract = abstract,
  text     = text,
  url      = url
)

# 23 and 26 OCT ----------------------------------------------------------------

covid_speeches <- bind_rows(
  speech_26_oct,
  speech_23_oct
)
