getData <- function(){
	
	source("Functions/pre-processing.R")
	source("Functions/downloadlist.R")
	source("Functions/CreateRasterTemp.R")

	# define folders for the raw data
	OSM_F <-'Rawdata/OSM/'
	municipalities_F <- 'Rawdata/municipalities/'
	provinces_F <- 'Rawdata/provinces/'
	NDVI_F <- 'Rawdata/NDVI/'
	railways_F <- 'Rawdata/railways/'
	roads_F <- 'Rawdata/roads/'

	# create folder in map rawdata

	dir.create(OSM_F,showWarnings = F)
	dir.create(municipalities_F,showWarnings = F)
	dir.create(provinces_F,showWarnings = F)
	dir.create(NDVI_F, showWarnings = F)
	dir.create(railways_F, showWarnings = F)
	dir.create(roads_F, showWarnings = F)

	# Download data -----------------------------------------------------------
	
	# deifne URLs
	OSMURL = 'http://download.geofabrik.de/europe/netherlands-latest.shp.zip'
	municipalitiesURL = 'www.cbs.nl/nl-NL/menu/themas/dossiers/nederland-regionaal/links/wijk-en-buurtkaart-shape-2015.htm'
	provincesURL = 'www.imergis.nl/shp/Bestuurlijkegrenzen-provincies-actueel-shp.zip'
	NDVIURL <- "https://github.com/GeoScripting-WUR/VectorRaster/raw/gh-pages/data/MODIS.zip"
	railwaysURL <- "http://www.mapcruzin.com/download-shapefile/netherlands-railways-shape.zip"
	roadsURL <- "http://www.mapcruzin.com/download-shapefile/netherlands-roads-shape.zip"
	
	# put in list
	URLlist = list(list('NDVI',NDVIURL),list('OSM',OSMURL),list('municipalities',municipalitiesURL),
								 list('provinces',provincesURL),list('railways',railwaysURL),list('roads',roadsURL))

	URLlist = list(list('municipalities',municipalitiesURL))
	
	# dowload data
	inputZip <- list.files(path='Downloads', pattern= '^.*\\.zip$')
	if (length(inputZip) == 0){ ##only download when not alrady downloaded (safes time to debug the whole script)
	lapply(URLlist, downloadlist)
	}
	
	# Unzip data
	
	unzip('Downloads/OSM.zip', exdir=OSM_F)
	unzip('Downloads/municipalities.zip', exdir=municipalities_F)
	unzip('Downloads/provinces.zip', exdir=provinces_F)
	unzip('Downloads/NDVI.zip', exdir = NDVI_F)
	unzip('Downloads/roads.zip', exdir = roads_F)
	unzip('Downloads/railways.zip', exdir = railways_F)
	
	# data pre-processing--------------------------------------------------------
	
	# define projections
	
	latlong = "+init=epsg:4326"
	RD_new = "+init=epsg:28992"
	
	## Gelderland
	
	# get shape of gelderland and store as shapefile
	provinces <- readShapeSpatial("Rawdata/provinces/TopGrenzen-prov-actueel.shp")
	proj4string(provinces)= CRS(RD_new)
	Gelderland <- subset(provinces,Provincien=='Gelderland')
	writeOGR(Gelderland, './Data', 'Gelderland', driver="ESRI Shapefile", overwrite_layer=TRUE)
	
	## raster template
	
	# create and save raster template used by many functions in the project
	RasterTemp <- CreateRasterTemp(Gelderland)
	
	## NDVI pre-processing
	
	#list the NDVI raster
	NDVIlist <- list.files(path=NDVI_F,pattern = '+.grd$', full.names=TRUE) 
	NDVI_12 <- stack(NDVIlist) #Stack the list
	
	#Project the stack to RD_new
	NDVI_RD <- projectRaster(NDVI_12, crs = RD_new)
	
	# Select and calculate NDVI mean of the year
	NDVI_mean <- calc(NDVI_RD,mean)
	
	#Crop and Mask the NDVI to Gelderland
	NDVIGelderland <- crop(NDVI_mean, Gelderland)
	NDVIGelderland <- mask(NDVIGelderland, Gelderland)
	
	#Resample the NDVI to the  raster template
	
	NDVIGeld <- resample(NDVIGelderland, RasterTemp)
	
	#write the NDVI raster to data
	writeRaster(NDVIGeld, 'Data/NDVIGelderland.grd', overwrite = TRUE)
	
	## roads and railways
	
	# read data
	roads <- readOGR(roads_F, "roads")
	railway <- readOGR(railways_F, "railways")
	
	# subset data
	main_roads <- roads[ which(roads$type=='primary'),]
	
	roadsRD <-  spTransform(main_roads,CRS(RD_new))
	railwayRD <-  spTransform(railway,CRS(RD_new))
	
	# clip
	roads_G = roadsRD[Gelderland,]
	railway_G = railwayRD[Gelderland,]
	
	# write data
	writeOGR(roads_G, './Data', 'roads', driver="ESRI Shapefile", overwrite_layer=TRUE)
	writeOGR(railway_G, './Data', 'railways', driver="ESRI Shapefile", overwrite_layer=TRUE)
	
	## OSM
	
	# re-project, clip and save OSM shapefiles
	shplist_OSM = list.files(path=OSM_F, pattern= '^.*\\.shp$')[c(4,7)]
	lapply(shplist_OSM, function(x) reproject_convert_OSM_shp(paste0('Rawdata/OSM/',x),name=substr(x,1,nchar(x)-4),clip=Gelderland))
	
	## municipalities
	
	# clip and save municipalities shapefiles
	shplist_mun = list.files(path='./Rawdata/municipalities/uitvoer_shape', pattern= '^.*\\.shp$')
	lapply(shplist_mun, function(x) clip_save_mun_shp(shp=paste0('Rawdata/municipalities/uitvoer_shape/',x),clip=Gelderland,name=substr(x,1,nchar(x)-4)))
}
