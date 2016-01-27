PublicTrans_Index <- function(){
	#' Create a raster with values depending on the distance to public transport
	#' arg:
	#' Return: RasterLayer with values between 0 and 1
	
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