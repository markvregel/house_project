Waterindex <- function(){
	
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
	
	#return the waterscore
	return(WaterScore)
}












