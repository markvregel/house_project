DistVarFunction <- function(mypoints, mytype, rasterTemp){
  #' This function makes a raster with distancevalues for a certain type
  #' mytype is a string or list of strings
  #' returns a raster with the score of the distance
  
	source('Functions/standardisation.R')
	#Select variable
	SelectedType <- subset(mypoints, type == mytype)

	#Distance grid
	DistanceVar <- distanceFromPoints(rasterTemp, SelectedType)

	#Grid with scores
	DistStand <- 1-standardise(mask(DistanceVar,rasterTemp))

	return(DistStand)
}
