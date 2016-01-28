NDVI_Index <- function(){
	#'  Standardise the NDVI raster
	
	# Load the standardise function
	source('Functions/standardisation.R')
	
	# Load the NDVI raster
	NDVI_G <- raster('Data/NDVIGelderland.grd')
	
	# Standardise the raster
	NDVIScore <- standardise(NDVI_G)
	return(NDVIScore)
}