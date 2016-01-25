# import modules
source("Functions/standardisation.R")
library(raster)

# create demographic index function
demographic_index <- function(urban_boolean, urbanity_raster, urbanity_weight, children_boolean, children_raster, children_weight, low_income_boolean, low_income_raster, low_income_weight){
	#' Create demographic index raster with a Multi-Criteria Analyses
  #'      Arg:
  #'          urban_boolean (boolean): True or False
  #'          urbanity_raster (raster): OAD values of Gelderland --> CBS data
  #'          urbanity_weight (int): population density weight
  #'          children_boolean(boolean): True or False
  #'          children_raster(raster): index of the number of children in the area (0 -15 years)
  #'          children_weight(int): weight of the children index
  #'          low_income_boolean(boolean): True or False
  #'          low_income_raster(raster)
  #'          low_income_weight(int)
  #'      Return:
  #'        	Result of the MCA; Raster with values representing the importance of the above mentioned demographic features
 
	# standardise raster values
	urbanity_index <- standardise(urbanity_raster)
	children_index <- standardise(children_raster)
	low_income_index <- standardise(low_income_raster)
	
	# turn values around when boolean is false
	if(urban_boolean==FALSE){
		urbanity_index <- 1 - urbanity_index
		 }
	if(children_boolean==FALSE){
		children_index <- 1 - children_index
		 }
	if(low_income_boolean==FALSE){
		low_income_index <- 1 - low_income_index
		 }
	# calculate  the values for the demographic features
	Raster_demographic_features <- overlay(urbanity_index, urbanity_weight, children_index, children_weight, low_income_index, low_income_weight, fun=function(a,b,c,d,e,f){(a*b)+(c*d)+(e*f)})
	
	# return MCA based raster
	return(Raster_demographic_features)
}

