# Remove false detections on networks outside of Flores, Azores
# These false detections have been evaluated by Jan Reubens (VLIZ), Dana Allen (InnovaSea) and myself (PJ; INBO)
# By Pieterjan Verhelst
# Pieterjan.Verhelst@inbo.be

unique(data$acoustic_project_code)
unique(data$station_name)


data <- data[!(data$acoustic_project_code == "MOBEIA"),]
data <- data[!(data$acoustic_project_code == "Walloneel"),]
data <- data[!(data$acoustic_project_code == "FISHINTEL"),]

