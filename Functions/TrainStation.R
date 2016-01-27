TrainStat_index <- function() {
	#' function that calcualtes the score of the facilities index
	#' 
	
	source("Functions/DistanceVarFunction.R")
	library(rgdal)
	library(raster)
	
	
	points <-readOGR('Data','points_OSM')
	rasterTemp <- raster('Data/GelderlandRas.grd')
	
	TrainStat <- DistVarFunction(points,'station', rasterTemp)
	return(TrainStat)
}

