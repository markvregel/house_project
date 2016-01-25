# import modules
source("Functions/standardisation.R")
library(raster)

# create demographic index function
demographic_index <- function(urbanity_raster, urbanity_weight, children_raster, children_weight, low_income_raster, low_income_weight){
	#' Create demographic index raster with a Multi-Criteria Analyses
  #'      Arg:
  #'          urbanity_raster (raster): OAD values of Gelderland --> CBS data
  #'          urbanity_weight (int): population density weight
  #'          children_raster(raster): index of the number of children in the area (0 -15 years)
  #'          children_weight(int): weight of the children index
  #'          low_income_raster(raster)
  #'          low_income_weight(int)
  #'      Return:
  #'        	Result of the MCA; Raster with values representing the importance of the above mentioned demographic features
 
	# standardise raster values
	urbanity_index = standardise(urbanity_raster)
	children_index = standardise(children_raster)
	income_index = standardise(low_income_raster)
	
	# calculate  the values for the demographic features
	Raster_demographic_features <- overlay(urbanity_index, urbanity_weight, children_index, children_weight, low_income_index, low_income_weight, fun=function(a,b,c,d,e,f){(a*b)+(c*d)+(e*f)})
	
	# return MCA based raster
	return(Raster_demographic_features)
}

