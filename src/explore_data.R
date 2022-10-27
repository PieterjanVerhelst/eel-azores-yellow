# Create explorative plots
# by Pieterjan Verhelst
# pieterjan.verhelst@inbo.be

# Packages
library(sf)
library(tmap)


# Source 
source("./src/merge_eel_characteristics.R")
source("./src/remove_false.R")



# 1. Number of eels per station ####
# Create barplot
eels_per_station <- data %>%
  group_by(catch_year, station_name, acoustic_tag_id) %>%  # Include 'catch_year' for interactive plot
  summarise(ind_eel=n_distinct(acoustic_tag_id)) %>%
  summarise(eels = n())

eels_per_station$eels <- as.numeric(eels_per_station$eels)
eels_per_station$catch_year <- factor(eels_per_station$catch_year)
#par(mar=c(6,4.1,4.1,2.1))
#barplot(shads_per_station$eels, names.arg=eels_per_station$station_name, ylim = c(0,40), cex.names=0.8, las=2)
#title(ylab="Number of eels", line = 3, cex.lab=1)
#title(xlab="Station name", line = 4, cex.lab=1)


barplot <- ggplot(data = eels_per_station, aes(x=station_name, y=eels)) +
  geom_bar(stat="identity", width = 0.75) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  scale_fill_brewer(palette="Spectral")
  #scale_fill_manual(values = c("Green","Blue","Red","Yellow","Purple","Orange","Brown")) 
barplot


# Create html-widget
stations <- data %>%
  select(station_name, deploy_longitude, deploy_latitude) %>%
  unique()

eels_per_station <- left_join(eels_per_station, stations, by= "station_name")

# Set interactive view
ttm() # switches between static plot and interactive viewing

# Create sf
eels_per_station$eels <- factor(eels_per_station$eels)
spatial <- st_as_sf(eels_per_station,
                             coords = c(4:5),
                             crs = 4326)  # WGS84

# Create interactive map
eels_per_station_map <- tm_shape(spatial) + 
  tm_dots(col = "eels", id = "station_name", palette = "Spectral", size = 0.5) +
  tm_facets(by = "catch_year",  ncol = 2, nrow = 3, free.scales = FALSE) +
  tmap_options(limits = c(facets.view = 6), max.categories = 10) 
eels_per_station_map


# 2. Number of stations per eel ####
stations_per_eel <- data %>%
  group_by(acoustic_tag_id, station_name) %>%
  dplyr::select(acoustic_tag_id, station_name) %>%
  summarise(ind_station=n_distinct(station_name)) %>%
  summarise(stations = n())
stations_per_eel$stations=as.numeric(stations_per_eel$stations)

par(mar=c(7,4.1,4.1,2.1))
barplot(stations_per_eel$stations, names.arg=stations_per_eel$acoustic_tag_id, ylim = c(0,5), cex.names=0.8, las=2)
title(ylab="Number of stations", line = 3, cex.lab=1)
title(xlab="Transmitter ID", line = 6, cex.lab=1)


# 3. Calculate tracking period in days ####
period <- data %>%
    group_by(acoustic_tag_id)%>%
    dplyr::select(acoustic_tag_id, date_time) %>%
    summarise(min_date = min(date_time),
              max_date = max(date_time))
period$days <- round(difftime(period$max_date, period$min_date), 1)
period$days <- as.numeric(period$days)
period$days <- round(period$days/86400, 1)

par(mar=c(8,6.1,2.1,1.1))
barplot(period$days, names.arg=period$acoustic_tag_id, cex.names=0.8, ylim=c(0,1.3*max(period$days)),las=2)
title(ylab="Tracking days", line = 4, cex.lab=1)
title(xlab="Transmitter ID", line = 6, cex.lab=1) 



  