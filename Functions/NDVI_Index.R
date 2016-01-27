NDVI_Index <- function(){
	
	source('Functions/standardisation.R')
	NDVI_G <- raster('Data/NDVIGelderland.grd')
	
	NDVIScore <- standardise(NDVI_G)
	return(NDVIScore)
}