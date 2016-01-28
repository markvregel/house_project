# create demographic index function
demographic_index <- function(urban_boolean, urbanity_weight, children_boolean, children_weight, elderly_boolean, elderly_weight){
	#' Create demographic index raster with a Multi-Criteria Analyses
  #'      Arg:
  #'          urban_boolean (boolean): True or False
  #'          urbanity_weight (int): population density weight (1-5)
  #'          children_boolean(boolean): True or False
  #'          children_weight(int): weight of the children index (1-5)
  #'          elderly_boolean(boolean): True or False
  #'          elderly_weight(int): weight of the elderly index(1-5)
  #'      Return:
  #'        	Result of the MCA; Raster with values representing the importance of the above mentioned demographic features
 
	# source functions
	source("Functions/standardisation.R")

	# Read OSM data
	OSM_data <- readOGR("Data", "Buurt_2015")
	urbanity <- OSM_data[9]
	children <- OSM_data[13]
	elderly <- OSM_data[17]
	
	# Delete strange values
	urbanity1 <- subset(urbanity, urbanity@data[,1] >= 1) 
	children1 <- subset(children, children@data[,1] >= 0 & children@data[,1]<= 100)
	elderly1 <- subset(elderly, elderly@data[,1] >= 0 & elderly@data[,1]<= 100)
	
	# example raster
	gelderlandraster <- raster('Data/GelderlandRas.grd')

		# rasterize
	urbanity_raster <- rasterize(urbanity1, gelderlandraster, field="STED")
	children_raster <- rasterize(children1, gelderlandraster, field="P_00_14_JR")
	elderly_raster <- rasterize(elderly1, gelderlandraster, field="P_65_EO_JR")
	
	# standardise raster values
	urbanity_index <- standardise(urbanity_raster)
	children_index <- standardise(children_raster)
	elderly_index <- standardise(elderly_raster)
	
	# turn values around when boolean is false
	if(urban_boolean==FALSE){
		urbanity_index <- 1 - urbanity_index
		 }
	if(children_boolean==FALSE){
		children_index <- 1 - children_index
		 }
	if(elderly_boolean==FALSE){
		elderly_index <- 1 - elderly_index
		 }
	
	# calculate  the values for the demographic features
	urbanity_result <- urbanity_index * urbanity_weight
	children_result <- children_index * children_weight
	elderly_result <- elderly_index * elderly_weight
	Raster_demographic_features <- overlay(urbanity_result, children_result, elderly_result, fun=function(a,b,c){a+b+c})
	demographic_index <- standardise(Raster_demographic_features)
	
	# return MCA based raster
	return(demographic_index)
}

