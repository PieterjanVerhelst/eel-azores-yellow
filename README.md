# eel-azores-yellow
Analysis of tracking study on yellow eels at Flores, Azores.

## Project structure

### Data

<mark>Data last updated on 23/08/2024</mark>

* `/raw:`
	+ `raw_detection_data.csv`: dataset containing the raw detection data obtained from the ETN database
	+ `flores_eels_meta_data.csv`: dataset containing the meta-data on the tagged eels obtained from the ETN database
	+ `deployments.csv`: dataset containing the station names and positions of the receivers from ETN

* `/interim:`
	+ `receivernetwork_cruz.csv`: network of receivers with detections in the River Cruz
	+ `residency.csv`: dataset with detections binned per station within a specific time (1h) and distance (100 m) threshold, calculated via the `smooth_eel_tracks.R` code
	+ `speed.csv`: datas with the swim speeds between detection stations, calculated via the `calculate_speed.R` code

* `/external:`
	+ `release_locations_stations.csv`: file with the release locations and the abbreviated release station names.
	+ `distancematrix_cruz.csv`: matrix with the river distances between detection stations
	+ `station_order.csv`: file containing the stations upstream the release location. This file is needed in `calculate_speed.R`



### Scripts

* `/src:`

1. `download_data.R`: Download twaite shad acoustic telemetry data from ETN database via RStudio LifeWatch server
	* obtain detection dataset `raw_detection_data.csv`
	* obtain meta-data on tagged eels `flores_eels_meta_data.csv`
	* obtain meta-data on deployments `deployments.csv` (station names and positions)
2. `attach_release.R`: Add eel release positions and date-time to detection dataset
3. `merge_eel_characteristics.R`: Add eel meta data to the detection dataset
4. `remove_false.R`: Remove false detections from dataset
5. `explore_data.R`: Plot number of eels per station, number of stations per eel and tracking time
6. `extract_network.R`: Extract receiver networks based on detection data
	* This serves as input to calculate the distance matrices at https://github.com/inbo/fish-tracking
7. `smooth_eel_tracks.R`: Smooths duplicates and calculates residencies per eel per station. Therefore, it calls the following two functions:
	+ 7a. `get_nearest_stations.R`: general function to extract the smoothed track for one eel (via its `transmitter ID`)
	+ 7b. `get_timeline.R`: function to get the stations which are near a given station (where near means that the distance is smaller than a certain given limit, e.g. detection range).
		- --> Generate residency datasets per project and store them in `/interim/residencies`
8. `calculate_speed.R`: Calculate movement speeds between consecutive detection stations. Also calculates swim distance, swim time, cumulative swim distance and station distance from source station.
	+ 8a. `calculate_speed_function.R`: function to calculate speed between consecutive displacements; based on a function in Hugo Flavio's `actel` package
	+ 8b. `calculate_sourcedistance_function.R`: function to calculate the station distance from a 'source' station; based on a function in Hugo Flavio's `actel` package
		- --> Generate speed datasets per project and store them in `/interim/speed`
9. `create_distance_plot.R`: Create plots with travelled distance per eel and store as .pdf


### Figures

* `/figures:`
	+ `/distance_tracks.pdf`: pdf-file with traveled distances per eel



