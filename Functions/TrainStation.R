TrainStat_index <- function() {
	#' function that calculates the scores depending on the distance to the trainstation
	#' 		Returns:
	#' 					TrainStat(raster)
	
	# Load the Distance value function
	source("Functions/DistanceVarFunction.R")
	
	# Read the shapefile and empty raster
	points <-readOGR('Data','points_OSM')
	rasterTemp <- raster('Data/GelderlandRas.grd')
	
	# Calculate scores
	TrainStat <- DistVarFunction(points,'station', rasterTemp)
	return(TrainStat)
}

