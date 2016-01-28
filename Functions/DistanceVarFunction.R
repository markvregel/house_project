DistVarFunction <- function(mypoints, mytype, rasterTemp){
  #' This function makes a raster with distancevalues for a certain type
  #' 		Args:
  #' 			mypoints (Point shapefile): All OSM points of Gelderland 
  #' 			mytype (string or list of strings): OSM points you want to select
  #' 			rasterTemp (Raster): Empty base raster
  #' 		Returns:
  #' 		 DistStand(raster): Standardised raster of distance
  
	source('Functions/standardisation.R')
	#Select variable
	SelectedType <- subset(mypoints, type == mytype)

	#Distance grid
	DistanceVar <- distanceFromPoints(rasterTemp, SelectedType)

	#Grid with scores
	DistStand <- 1-standardise(mask(DistanceVar,rasterTemp))

	return(DistStand)
}
