ExecuteIndexes <- function(){	
	# Source functions
	source('Functions/demographic_index.R')
	source('Functions/facilities_index.R')
	source('Functions/inconvenience_index.R')
	source('Functions/PublicTrans_Index.R')
	source('Functions/Water_Index.R')
	source('Functions/NDVI_Index.R')

	#Execute indexes
	publicTrans <- PublicTrans_Index()
	print('publicTrans done!')
	inconvenience <- inconvenience_index(railway_weight, roads_weight)
	print('Inconvenience done!')
	facilities <- facilities_index()
	print('Facilities done!')
	demographic <- demographic_index(urban_boolean, urbanity_weight, children_boolean, children_weight, elderly_boolean, elderly_weight)
	print('Demographics done!')
	NDVI <- NDVI_Index()
	print('NDVI done!')
	Water <-Water_Index()
	print('Water done!')
	
	Stack_output <- "Output/TotalIndex.grd"
	Total_Indexes <- stack(publicTrans, inconvenience, facilities, demographic, NDVI, Water)
	names(Total_Indexes) <- c("Public Transport Index", "Inconvenience Index", "Facilities Index", "Demographic Index", "NDVI Index", "Water Index")
	writeRaster(x=Total_Indexes, filename=Stack_output, overwrite = TRUE)
	return(Total_Indexes)
}


