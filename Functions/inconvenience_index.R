# create demographic index function
inconvenience_index <- function(railway_weight,roads_weight){
	#' Create inconvenience index raster with a Multi-Criteria Analyses
	#'      Arg:
	#'     		railway_weight (int): weight of railway noise(1-5)
	#'     		roads_weight (int): weight of road noise(1-5)
	#'      Return:
	#'        Result of the MCA; Raster with values representing the importance of the above mentioned inconvenience features	
	
	# import modules
	source('Functions/Road_Train_Buffer.R')
	source('Functions/standardisation.R')

	## road_train_buffer() #not executed because of the largeness of the roads file; buffer data in Data map
	gelderlandraster <- raster('Data/GelderlandRas.grd')
	
	#
	buffertest <- 'roads_buffer.grd'
	files <- list.files(path='Data')
	if (!buffertest %in% files)	{ 
		road_train_buffer()
	}
	
	# load buffer data
	railway_buffer1 = raster("./Data/railway_buffer")
	roads_buffer1 = raster("./Data/roads_buffer")
	
	# No data cells get value 0
	railway_buffer1[is.na(railway_buffer1)] <- 0
	roads_buffer1[is.na(roads_buffer1)] <- 0
	
	# turn values around
	railway_buffer1 <- 1 - railway_buffer1
	roads_buffer1<- 1 - roads_buffer1

	# overlay
	railway_result <- railway_weight * railway_buffer1
	roads_result <- roads_weight * roads_buffer1
	
	# Combine and standardise the rasters
	Raster_inconvenience_features <- overlay(railway_result, roads_result, fun=function(x,y){x+y}) 
	inconvenience_index <- standardise(Raster_inconvenience_features)
	
	# Mask the raster
	inconvenience_index <- mask(inconvenience_index, gelderlandraster)
	
	return(inconvenience_index)
}