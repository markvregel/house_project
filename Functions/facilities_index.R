facilities_index <- function() {
	#' function that calcualtes the score of the facilities index
	#' 
	
	source("Functions/DistanceVarFunction.R")
	source("Functions/standardisation.R")
	source("Functions/kde.points_score.R")
	library(rgdal)
	library(raster)
	library(GISTools)
	
	points <-readOGR('Data','points_OSM')
	rasterTemp <- raster('Data/GelderlandRas.grd')
	
	cafe_score<-kde.points_score(points,'cafe',rasterTemp,28000)
	restaurant_score<-kde.points_score(points,'restaurant',rasterTemp,28500)
	supermarket_score<-kde.points_score(points,'supermarket',rasterTemp,28500)
	
	
	swim_score <-DistVarFunction(points,'swimming_pool',rasterTemp)
	hospital_score <-DistVarFunction(points,'hospital',rasterTemp)
	
	facility_index_sum <-overlay(cafe_score,restaurant_score,supermarket_score,swim_score,hospital_score, fun=function(a,b,c,d,e){(a+b+c+d+e)})
	facility_index <- standardise(facility_index_sum)
	return(facility_index)
}