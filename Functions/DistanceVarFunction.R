DistVarFunction <- function(mypoints, mytype, RasterTemp){
  #' This function makes a raster with distancevalues for a certain type
  #' mytype is a string
  #' returns a raster
  

#Select variable
SelectedType <- subset(mypoints, type == mytype)

#Distance grid
DistanceVar <- distanceFromPoints(RasterTemp, SelectedType)


return(DistanceVar)
}
