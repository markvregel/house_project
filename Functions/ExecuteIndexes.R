ExecuteIndexes <- function(){	
	# Source functions
	source('Functions/demographic_index.R')
	source('Functions/facilities_index.R')
	source('Functions/inconvenience_index.R')
	source('Functions/PublicTrans_Index.R')
	source('Functions/WaterIndex.R')
	source('Functions/NDVI_Index.R')

	#Execute indexes
	publicTrans <- PublicTrans_Index()
	inconvenience <- inconvenience_index(railway_weight, roads_weight)
	facilities <- facilities_index()
	demographic <- demographic_index(urban_boolean, urbanity_weight, children_boolean, children_weight, elderly_boolean, elderly_weight)
	NDVI <- NDVI_Index()
	Water <-Water_Index()
	
	Stack_output <- "Output/TotalIndex.grd"
	Total_Indexes <- stack(publicTrans, inconvenience, facilities, demographic, NDVI, Water)
	Names(Total_Indexes) <- c("Public Transport Index", "Inconvenience Index", "Facilities Index", "Demographic Index", "NDVI Index", "Water Index")
	writeRaster(x=Total_Indexes, filename=Stack_output)
	return(Total_Indexes)
}


