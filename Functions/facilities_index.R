facilities_index <- function() {
	#' function that calcualtes the score of the facilities index
	#' 		Returns:
	#' 					A raster with the values based on the distance of facilities and the density of facilities
	#' 			
	
	source("Functions/DistanceVarFunction.R")
	source("Functions/standardisation.R")
	source("Functions/kde.points_score.R")

	# Read the shapefile and base raster
	points <-readOGR('Data','points_OSM')
	rasterTemp <- raster('Data/GelderlandRas.grd')
	
	# Make rasters with scores based on density of facilities
	cafe_score<-kde.points_score(points,'cafe',rasterTemp,28000)
	restaurant_score<-kde.points_score(points,'restaurant',rasterTemp,28500)
	supermarket_score<-kde.points_score(points,'supermarket',rasterTemp,28500)
	
	# Make rasters with scores based on distance
	swim_score <-DistVarFunction(points,'swimming_pool',rasterTemp)
	hospital_score <-DistVarFunction(points,'hospital',rasterTemp)
	
	# Combine the rasters and standardise the result
	facility_index_sum <-overlay(cafe_score,restaurant_score,supermarket_score,swim_score,hospital_score, fun=function(a,b,c,d,e){(a+b+c+d+e)})
	facility_index <- standardise(facility_index_sum)
	return(facility_index)
}