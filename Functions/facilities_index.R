facilities_index() <- function() {
	#' function that calcualtes the score of the facilities index
	#' 
	
	source("Functions/DistanceVarFunction.R")
	source("Functions/standardisation.R")
	library(rgdal)
	library(raster)
	
	
	points <-readOGR('Data','points_OSM')
	rasterTemp <- raster('Data/GelderlandRas.grd')
	
	pubs_dist <-DistVarFunction(points,'pub',rasterTemp)
	pubs_score <- 1-standardise(mask(pubs_dist,rasterTemp))
	

	rest_dist <-DistVarFunction(points,'restaurant',rasterTemp)
	rest_score <- 1-standardise(mask(rest_dist,rasterTemp))
	
	
	
	
	
}