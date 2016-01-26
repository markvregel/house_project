# functions to pre-process the data

reproject_convert_OSM_shp <- function(shp,name,clip) {
	#' function that: -reads OSM shapefiles
	#' 							  -transforms the projections to RD_new
	#' 							  -clips to clip layer
	#' 							  -saves result as a shapefile in data folder
	#'Args: shp(str): path and name of shapefile 
	#'			name(str): name of new output shapefile
	#'			clip(SPDF): polygon to which input will is clipped
	#'			
	vector = readShapeSpatial(shp)
	proj4string(vector) = CRS(latlong)
	vector_RD <- spTransform(vector,CRS(RD_new))
	result = vector_RD[clip,]
	writeOGR(result, './data',paste0(name,"_OSM"), driver="ESRI Shapefile", overwrite_layer=TRUE)
}

clip_save_mun_shp <- function(shp,clip,name) {
	#' function that:-reads a shapefile
	#' 							 -clips to clip layer
	#' 							 -and save result as a shapefile in data folder
	#'Args: shp(str): path and name of shapefile 
	#'			clip(SPDF): polygon to which input will is clipped
	#'			name(str): name of new output shapefile
	vector = readShapeSpatial(shp)
	proj4string(vector) = CRS(RD_new)
	result = vector[clip,]
	writeOGR(result, './data',name, driver="ESRI Shapefile", overwrite_layer=TRUE)
}