# Add eel release positions and date-time to detection dataset
# by Pieterjan Verhelst
# Pieterjan.Verhelst@inbo.be


# Packages
library(tidyverse)
library(lubridate)

# 1. Load detection data ####
data <- read_csv("./data/raw/raw_detection_data.csv")
data$...1 <- NULL
data$scientific_name <- NULL
data$acoustic_project_code <- NULL

# Set consistent prefix for tag protocol
data$acoustic_tag_id <- gsub("R64K", "A69-1303", data$acoustic_tag_id)

# 2. Read eel meta data ####
eel <- read_csv("./data/raw/flores_eels_meta_data.csv")
eel$acoustic_tag_id <- gsub("R64K", "A69-1303", eel$acoustic_tag_id)

eel <- select(eel, 
              animal_project_code, 
              release_date_time, 
              acoustic_tag_id, 
              release_location, 
              release_latitude, 
              release_longitude)

eel$release_location <- factor(eel$release_location)


# 3. Read file with release location and station
release <- read_csv("./data/external/release_locations_stations.csv")

release$release_location <- factor(release$release_location)
release$release_station <- factor(release$release_station)

# 4. Merge release station with eel data
eel <- left_join(eel, release, by = "release_location")

summary(eel$release_station)  # May not contain any NAs!


# 5. Process eel dataset column names
eel$receiver_id <- "none"

eel <- select(eel,
              animal_project_code,
              release_date_time, 
              acoustic_tag_id, 
              release_station,
              receiver_id,
              release_latitude, 
              release_longitude)

eel <- rename(eel,
              date_time = release_date_time,
              station_name = release_station,
              deploy_latitude = release_latitude,
              deploy_longitude = release_longitude)


# 6. Merge eel releases to the detection dataset
data <- rbind(data, eel)








