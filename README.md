# eel-azores-yellow
Analysis of tracking study on yellow eels at Flores, Azores.

## Project structure

### Data

<mark>Data last updated on 27/10/2022</mark>

* `/raw:`
	+ `raw_detection_data.csv`: dataset containing the raw detection data obtained from the ETN database
	+ `flores_eels_meta_data.csv`: dataset containing the meta-data on the tagged eels obtained from the ETN database
	+ `deployments.csv`: dataset containing the station names and positions of the receivers from ETN

* `/interim:`
	+ `receivernetwork_cruz.csv`: network of receivers with detections in the River Cruz

* `/external:`


### Scripts

* `/src:`

1. `download_data.R`: Download twaite shad acoustic telemetry data from ETN database via RStudio LifeWatch server
	* obtain detection dataset `raw_detection_data.csv`
	* obtain meta-data on tagged eels `flores_eels_meta_data.csv`
	* obtain meta-data on deployments `deployments.csv` (station names and positions)
2. `merge_eel_characteristics.R`: Add eel meta data to the detection dataset
3. `remove_false.R`: Remove false detections from dataset
4. `extract_network.R`: Extract receiver networks based on detection data
	* This serves as input to calculate the distance matrices at https://github.com/inbo/fish-tracking
5. `explore_data.R`: Plot number of eels per station, number of stations per eel and tracking time



