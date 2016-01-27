road_train_buffer <- function(){
	#' Create a 100 meter buffer around main roads and traintracks in Gelderland
	#'      Arg:
	#'      Return:
	#'        Result of the MCA; Raster with values representing the importance of the above mentioned inconvenience features	
	
	# import modules
	library(raster)
	library(rgdal)
	library(rgeos)


	# read data
	railwayRD <- readOGR("Data", "railways")
	roadsRD <- readOGR("Data", "roads")
	gelderlandraster <- raster('Data/GelderlandRas.grd')
	
	# rasterize data
	railway_raster <- rasterize(railwayRD, gelderlandraster)
	roads_raster <- rasterize(roadsRD, gelderlandraster)

	# create buffer
	railway_buffer <- buffer(railway_raster, width=100) 
	roads_buffer <- buffer(roads_raster, width=100)

	# write Raster
	writeRaster(railway_buffer, 'Data/railway_buffer', overwrite=TRUE)
	writeRaster(roads_buffer, 'Data/roads_buffer', overwrite=TRUE)
	
}