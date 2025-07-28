# Remove false detections on networks outside of Flores, Azores
# These false detections have been evaluated by Jan Reubens (VLIZ), Dana Allen (InnovaSea) and myself (PJ; INBO)
# By Pieterjan Verhelst
# Pieterjan.Verhelst@inbo.be

unique(data$acoustic_project_code)
unique(data$station_name)


data <- data[!(data$acoustic_project_code == "MOBEIA"),]
data <- data[!(data$acoustic_project_code == "Walloneel"),]
data <- data[!(data$acoustic_project_code == "FISHINTEL"),]
data <- data[!(data$acoustic_project_code == "ws1"),]
data <- data[!(data$acoustic_project_code == "FISP"),]
data <- data[!(data$acoustic_project_code == "Danish_Straits"),]
data <- data[!(data$acoustic_project_code == "BTN-IMEDEA"),]
data <- data[!(data$acoustic_project_code == "FISHOWF"),]
data <- data[!(data$acoustic_project_code == "FISHINTEL"),]
data <- data[!(data$acoustic_project_code == "GTN"),]
data <- data[!(data$acoustic_project_code == "PTN/ATLAZUL"),]


# Remove likely false detections at station 155 FLO CRUZ
data <- data[!(data$acoustic_tag_id == "A69-1303-2692" & data$station_name == "155 FLO CRUZ"),]
data <- data[!(data$acoustic_tag_id == "A69-1303-2698" & data$station_name == "155 FLO CRUZ"),]
data <- data[!(data$acoustic_tag_id == "A69-1303-2699" & data$station_name == "155 FLO CRUZ"),]
data <- data[!(data$acoustic_tag_id == "A69-1303-2706" & data$station_name == "155 FLO CRUZ"),]
data <- data[!(data$acoustic_tag_id == "A69-1303-2707" & data$station_name == "155 FLO CRUZ"),]

# Remove likely false detections at station 152 FLO CRUZ
data <- data[!(data$acoustic_tag_id == "A69-1303-2713" & data$station_name == "152 FLO CRUZ"),]
data <- data[!(data$acoustic_tag_id == "A69-1303-2714" & data$station_name == "152 FLO CRUZ"),]
data <- data[!(data$acoustic_tag_id == "A69-1303-2715" & data$station_name == "152 FLO CRUZ"),]
data <- data[!(data$acoustic_tag_id == "A69-1303-2716" & data$station_name == "152 FLO CRUZ"),]
data <- data[!(data$acoustic_tag_id == "A69-1303-2717" & data$station_name == "152 FLO CRUZ"),]
data <- data[!(data$acoustic_tag_id == "A69-1303-2719" & data$station_name == "152 FLO CRUZ"),]



