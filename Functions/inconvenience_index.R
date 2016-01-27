

# create demographic index function
inconvenience_index <- function(railway_buffer_boolean,railway_weight,roads_buffer_boolean,roads_weight){
	#' Create inconvenience index raster with a Multi-Criteria Analyses
	#'      Arg:
	#'     		railway_buffer_boolean (boolean): True or False
	#'     		railway_weight (int): weight of railway noise(1-5)
	#'     		roads_buffer_boolean(boolean): True or False
	#'     		roads_weight (int): weight of road noise(1-5)
	#'      Return:
	#'        Result of the MCA; Raster with values representing the importance of the above mentioned inconvenience features	
	
	# import modules
	source('Functions/Road_Train_Buffer.R')
	source('Functions/standardisation.R')
	library(raster)
	library(rgdal)
	
	railway_buffer1 = raster("./Data/railway_buffer")
	roads_buffer1 = raster("./Data/roads_buffer")
	
	railway_buffer1[is.na(railway_buffer1)] <- 0
	roads_buffer1[is.na(railway_buffer1)] <- 0
	
	# turn values around when boolean is false
	if(railway_buffer_boolean==FALSE){
		railway_buffer1 <- 1 - railway_buffer1
	}
	if(roads_buffer_boolean==FALSE){
		roads_buffer1<- 1 - roads_buffer1
	}
	
	# overlay
	railway_result <- railway_weight * railway_buffer1
	roads_result <- roads_weight * roads_buffer1
	
	Raster_inconvenience_features <- overlay(railway_result, roads_result, fun=function(x,y){x+y}) 
	inconvenience_index <- standardise(Raster_inconvenience_features)
	
	return(inconvenience_index)
}