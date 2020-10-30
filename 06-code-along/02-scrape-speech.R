# Load packages ----------------------------------------------------------------
library(tidyverse)
library(rvest)
library(lubridate)

# Define function: scrape_speech() ---------------------------------------------

scrape_speech <- function(url) {
  
  speech_page <- read_html(url)
  
  title <- speech_page %>%
    html_node(".article-header__title") %>%
    html_text()
  
  date <- speech_page %>%
    html_node(".content-data__list:nth-child(1) strong") %>%
    html_text() %>%
    dmy()
  
  location <- speech_page %>%
    html_node(".content-data__list+ .content-data__list strong") %>%
    html_text()
  
  abstract <- speech_page %>%
    html_node(".leader--first-para p") %>%
    html_text()
  
  text <- speech_page %>%
    html_nodes("#preamble p") %>%
    html_text() %>%
    list()
  
  tibble(
    title = title, 
    date = date, 
    location = location,
    abstract = abstract, 
    text = text, 
    url = url
  )
}
