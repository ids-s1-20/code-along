# Load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(lubridate)

# Load function: scrape_speech() -----------------------------------------------

source("02-scrape-speech.R")

# Apply function ---------------------------------------------------------------

## 26 Oct

url_26_oct <- "https://www.gov.scot/publications/coronavirus-covid-19-update-first-ministers-speech-26-october/"

scrape_speech(url_26_oct) # apply

speech_26_oct <- scrape_speech(url_26_oct) # apply and save result

## 23 Oct

url_23_oct <- "https://www.gov.scot/publications/coronavirus-covid-19-update-first-ministers-speech-23-october/"

scrape_speech(url_23_oct) # apply

speech_23_oct <- scrape_speech(url_23_oct) # apply and save result

## Put it altogether

covid_speeches <- bind_rows(
  speech_26_oct,
  speech_23_oct
)
