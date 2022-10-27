# Merge eel meta data to tracking dataset
# By Pieterjan Verhelst
# pieterjan.verhelst@inbo.be

library(tidyverse)
library(lubridate)


# 1. Load detection data ####
data <- read_csv("./data/raw/raw_detection_data.csv")
data$...1 <- NULL

# Set consistent prefix for tag protocol
data$acoustic_tag_id <- gsub("R64K", "A69-1303", data$acoustic_tag_id)


# 2. Load eel metadata ####
eel <- read.csv("./data/raw/flores_eels_meta_data.csv")
eel$X <- NULL
eel$animal_project_code <- NULL
eel$scientific_name <- NULL
eel$age <- NULL
eel$age_unit <- NULL
eel$acoustic_tag_id <- factor(eel$acoustic_tag_id)
eel$acoustic_tag_id <- gsub("R64K", "A69-1303", eel$acoustic_tag_id)   # Set consistent prefix for tag protocol
eel$capture_date_time  <- as_datetime(eel$capture_date_time)
eel$release_date_time  <- as_datetime(eel$release_date_time)

# Return number of tagged eels per year ####
eel$catch_year <- year(eel$capture_date_time)

eel %>%
  group_by(catch_year) %>%
  summarise(tot_eels = n_distinct(acoustic_tag_id))


# 3. Merge eel characteristics with dataset ####
data <- merge(data, eel, by="acoustic_tag_id")


# Return number of detected eels per year ####
data %>%
  group_by(catch_year) %>%
  summarise(tot_eels = n_distinct(acoustic_tag_id))


