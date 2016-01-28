Water_Index <- function(){
	#' Makes a raster with scores close to the water up untill 3 km, after this distance every area scores the same
	#' 			Returns:
	#' 						WaterScore(raster)
	
	# Load the standardisation function and the water shapefile
	source('Functions/standardisation.R')
	water <- readOGR('Data','waterways_OSM')
	
	# Example Raster
	gelderlandraster <- raster('Data/GelderlandRas.grd')
	
	#Rasterize data
	WaterRas <- rasterize(water, gelderlandraster)
	
	#Give the waterways value 1
	WaterRas[WaterRas>0] <- 1
	
	#Calculate the distance from the water.
	DisWater <- distance(WaterRas)
	
	# Everything furter away than 3000m gets the value 3000
	DisWater[DisWater>3000] <- 3000
	
	#standardise the raster
	WaterScore <- standardise(DisWater)
	WaterScore <- 1-WaterScore
	
	# Mask
	WaterScore <- mask(WaterScore, gelderlandraster)
	
	#return the waterscore
	return(WaterScore)
}












