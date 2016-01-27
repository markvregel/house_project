source("Functions/standardisation.R")

kde.points_score <- function(mypoints, mytype, RasterTemp,bandwidth){
	#' This function calculates a raster with density values based on kernel density estimate and
	#' standardise the output to a raster with scores of 0 to 1 
	#' Args:
	#' 			mypoints(SPDT): spatial dataframe with the points
	#' 			mytype is a string or lost of strings
	#' 			RasterTemp(rasterlayer): raster template
	#' 			bandwidth(int): bandwidth of KDE
	#' Return: raster with density score for specific point features: e.g. pubs
	
	SelectedType <- subset(mypoints, type == mytype)
	KDE<-kde.points(SelectedType,bandwidth,n=100,lims=rasterTemp)
	density_r<-resample(raster(KDE),rasterTemp)
	density_stan_r<-standardise(mask(density_r,rasterTemp))
	return(density_stan_r)
}