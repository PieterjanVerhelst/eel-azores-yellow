# Extract receiver networks based on detections per project
# by Pieterjan Verhelst
# Pieterjan.Verhelst@inbo.be

# Packages
library(tidyverse)
library(lubridate)




receivernetwork_cruz <- data %>%
  distinct(station_name, .keep_all = TRUE) %>%
  select(animal_project_code, station_name, deploy_latitude, deploy_longitude) %>%
  rename(latitude = deploy_latitude,
         longitude = deploy_longitude)

write.csv(receivernetwork_cruz, "./data/interim/receivernetwork_cruz.csv", row.names=FALSE)


