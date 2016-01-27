PublicTrans_Index <- function(){
	
	source("Functions/TrainStation.R")
	source("Functions/busstations.R")
	source("Functions/standardisation.R")
	
	bus <- Bus_index()
	train <- TrainStat_index()
	
	PublicTrans <- overlay(train,bus, fun=function(a,b){a+b})
	PublicTransScore <- standardise(PublicTrans)
	return(PublicTransScore)
}