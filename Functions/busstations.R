Bus_index <- function() {
	#' function that calcualtes the score of the facilities index
	#' 		return:
	#' 				A raster with the distances values depending on the distance from bus stations
	
	# Import the Distance value function
	source("Functions/DistanceVarFunction.R")

	# Read the shapefiles
	points <-readOGR('Data','points_OSM')
	rasterTemp <- raster('Data/GelderlandRas.grd')
	
	# Make the raster
	busStat <-DistVarFunction(points,'bus_stop',rasterTemp)
	return(busStat)
}
	
	
	
	
	
	
	