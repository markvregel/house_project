ExecuteIndexes <- function(){	
	# Source functions
	source('Functions/demographic_index.R')
	source('Functions/facilities_index.R')
	source('Functions/inconvenience_index.R')
	source('Functions/PublicTrans_Index.R')
	source('Functions/NDVI_Index.R')
	source('Functions/ReadInputUser.R')
	
	# Set variables
	print("Would you mind living closer than 100 meter from a traintrack?")
	railway_weight <- readinteger_weight()
	
	print("Would you mind living closer than 100 meter from a highway?")
	roads_weight <- readinteger_weight()
	
	print("Do you want to live in a rural area?")
	urban_boolean <-readinteger_bool()
	
	print("Is this important to you?")
	urbanity_weight <- readinteger_weight()
	
	print("You want to live among children?")
	children_boolean <- readinteger_bool()
	
	print("Is this important to you?")
	children_weight <- readinteger_weight()
	
	print("You want to live among elderly people?")
	elderly_boolean <- readinteger_bool()
	
	print("Is this important to you?")
	elderly_weight <- readinteger_weight()
	
	#Execute indexes
	PublicTrans_Index()
	inconvenience_index(railway_weight, roads_weight)
	facilities_index()
	demographic_index(urban_boolean, urbanity_weight, children_boolean, children_weight, elderly_boolean, elderly_weight)
	NDVI_Index()
	Water_Index()
}


