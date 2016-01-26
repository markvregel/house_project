DistVarFunction <- function(mypoints, mytype, RasterTemp){
  #' This function makes a raster with distancevalues for a certain type
  #' mytype is a string
  #' returns a raster
  

#Select variable
SelectedType <- subset(mypoints, type == mytype)

#Make an empty raster with value 0
EmptyRas <- setValues(raster(RasterTemp), 0)

#Distance grid
DistanceVar <- distanceFromPoints(EmptyRas, SelectedType)
return(DistanceVar)
}
