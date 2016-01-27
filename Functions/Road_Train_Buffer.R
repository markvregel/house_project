road_train_buffer <- function(){
	#' Create a 100 meter buffer around main roads and traintracks in Gelderland
	#'      Arg:
	#'      Return:
	#'        Result of the MCA; Raster with values representing the importance of the above mentioned inconvenience features	
	
	# import modules
	library(raster)
	library(rgdal)
	library(rgeos)

	# download and unzip data
	if (length("Data/railway.zip") == 0){ 
		railways_url <- "http://www.mapcruzin.com/download-shapefile/netherlands-railways-shape.zip"
		download.file(railways_url, destfile="Data/railways.zip", method = "wget")
		unzip("Data/railways.zip", exdir="Data")
	}
	if (length("Data/roads.zip") == 0){ 
	roads_url <- "http://www.mapcruzin.com/download-shapefile/netherlands-roads-shape.zip"
	download.file(roads_url, destfile="Data/roads.zip", method = "wget")
	unzip("Data/roads.zip", exdir="Data")
	}
	# read data
	railway <- readOGR("Data", "railways")
	roads <- readOGR("Data", "roads")

	# subset data
	main_roads <- roads[ which(roads$type=='primary'),]
	writeOGR(main_roads, './Data', 'main_roads', drive="ESRI Shapefile", overwrite_layer=TRUE)
	main_roads_1 <- readOGR("Data", "main_roads")
	
	# Raster example
	gelderlandraster <- raster('Data/GelderlandRas.grd')
	
	RD_new <- "+init=epsg:28992"
	roadsRD <-  spTransform(main_roads_1,CRS(RD_new))
	railwayRD <-  spTransform(railway,CRS(RD_new))
	
	# rasterize data
	railway_raster <- rasterize(railwayRD, gelderlandraster)
	roads_raster <- rasterize(roadsRD, gelderlandraster)

	 # create buffer
	railway_buffer <- buffer(railway_raster, width=100) 
	roads_buffer <- buffer(roads_raster, width=100)

	# write Raster
	writeRaster(railway_buffer, 'Data/railway_buffer', overwrite=TRUE)
	writeRaster(roads_buffer, 'Data/roads_buffer', overwrite=TRUE)
	
}