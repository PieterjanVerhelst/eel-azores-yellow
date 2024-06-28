# Download data from Flores eel study from ETN database via RStudio LifeWatch server
# by Pieterjan Verhelst
# pieterjan.verhelst@inbo.be


library(tidyverse)
library(lubridate)
library(etn)


# Database connection
my_con <- connect_to_etn("pieterjan.verhelst@inbo.be",
                         "FFS5SDWoXL")
my_con


# 1. Download detection data ####
data <- get_acoustic_detections(my_con, scientific_name = "Anguilla anguilla",
                                animal_project_code = "2021_YEELAZ",
                                limit = FALSE)

# Select relevant columns
data <- select(data, animal_project_code, scientific_name, date_time, acoustic_tag_id, station_name, acoustic_project_code, receiver_id, deploy_latitude, deploy_longitude)


# 2. Download eel meta-data ####
eels <- get_animals(my_con, scientific_name = "Anguilla anguilla", 
                    animal_project_code = "2021_YEELAZ")

# Select relevant columns
eels <- select(eels, animal_project_code, scientific_name, acoustic_tag_id,
               capture_date_time, capture_location, capture_latitude, capture_longitude, capture_method,
               release_date_time, release_location, release_latitude, release_longitude,
               length1_type, length1, length1_unit,
               length2_type, length2, length2_unit,
               length3_type, length3, length3_unit,
               length4_type, length4, length4_unit,
               weight, weight_unit,
               age, age_unit, sex, life_stage, 
               treatment_type)


# 3. Download deployment positions ####
network_projects <- c("AZO")

deployments <- get_acoustic_deployments(my_con, acoustic_project_code = network_projects, open_only = FALSE)
deployments$station_name <- factor(deployments$station_name)

# Get unique deployments
#unique_deployments <- deployments %>% 
#  group_by(acoustic_project_code) %>%
#  distinct(station_name, .keep_all = TRUE) 

# Select relevant columns
deployments <- select(deployments, acoustic_project_code, station_name, receiver_id, deploy_latitude, deploy_longitude, deploy_date_time, recover_date_time)


# write csv
write.csv(data, "raw_detection_data.csv")
write.csv(eels, "flores_eels_meta_data.csv")
write.csv(deployments, "deployments.csv")


