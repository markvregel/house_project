# import modules
source("Functions/standardisation.R")
library(raster)

# standardise 
urbanity_index = standardise(urbanity_raster)
children_index = standardise(children_raster)
income_index = standardise(income_raster)

# create demographic index function
demographic_index <- function(urbanity_index, urbanity_weight, children_index, children_weight, low_income_index, low_income_index_weight){
	#' Create raster with values between 1-5 using a MCA for demographic features
  #'      Arg:
  #'          in_raster (raster): extent of research area
  #'          urbanity (int): urbanity factor, based on OAD --> CBS data
  #'          urbanity_weight (int): population density weight
  #'          children_index(int): index of the number of children in the area (0 -15 years)
  #'          children_weight(int): weight of the children index
  #'          income_index(int)
  #'          
  #'      Return:
  #'        	Raster with values representing the importance of the above mentioned demographic features
 
	# calculate  
	Raster_urbanity_index <- overlay(urbanity_index, urbanity_weight, fun=function(x,y){x*y})
	Raster_children_index <- overlay(children_index, children_weight, fun=function(x,y){x*y})
	Raster_income_index <- overlay(low_income_index, low_income_weight, fun=function(x,y){x*y})
  Raster_index_brick <- stack(Raster_urbanity_index, Raster_children_index, Raster_income_index)
	
	return(Raster_index_stack)
}

