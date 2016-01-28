PublicTrans_Index <- function(){
	#' Create a raster with values depending on the distance to public transport
	#' 	
	#' 		Return:
	#' 				 PublicTransScore (raster)
	
	source("Functions/TrainStation.R")
	source("Functions/busstations.R")
	source("Functions/standardisation.R")
	
	# Get the bus and train stations
	bus <- Bus_index()
	train <- TrainStat_index()
	
	# Combine the two rasters and standardise 
	PublicTrans <- overlay(train,bus, fun=function(a,b){a+b})
	PublicTransScore <- standardise(PublicTrans)
	return(PublicTransScore)
}