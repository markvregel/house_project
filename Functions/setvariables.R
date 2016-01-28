OpenPythonGUI <- function(){
	#'Creates text file with  values obtained from python GUI
	#'		Args:
	#'		Return:
	#'			 text file with a table
	system('python Functions/housescoreGUI.pyw')
}	
	
SetVariables <- function(){
	#' Assign values to variables obtained from text file
	#' 		Args:
	#' 		Return:
	#' 			list with variables and names
	var_values <- read.table('Output/var_values.txt')
	railwayweight <- as.numeric(as.character(var_values[1,2]))
	roadweight <- as.numeric(as.character(var_values[2,2]))
	childrenboolean <- as.logical(as.character(var_values[3,2]))
	childrenweight <- as.numeric(as.character(var_values[4,2]))
	elderlyboolean <- as.logical(as.character(var_values[5,2]))
	elderlyweight <- as.numeric(as.character(var_values[6,2]))
	urbanityboolean <- as.logical(as.character(var_values[7,2]))
	urbanityweight <- as.numeric(as.character(var_values[8,2]))
	inconvenienceweight <- as.numeric(as.character(var_values[9,2]))
	demographicweight <- as.numeric(as.character(var_values[10,2]))
	facilitiesweight <- as.numeric(as.character(var_values[11,2]))
	ndviweight <- as.numeric(as.character(var_values[12,2]))
	waterweight <- as.numeric(as.character(var_values[13,2]))
	ptweight <- as.numeric(as.character(var_values[14,2]))
	weightlist <- list(railwayweight, roadweight, childrenboolean, childrenweight, elderlyboolean, 
										 elderlyweight, urbanityboolean, urbanityweight, inconvenienceweight, demographicweight, 
										 facilitiesweight, ndviweight, waterweight, ptweight)
	names(weightlist) <- c('railwayweight','roadweight','childrenboolean','childrenweight','elderlyboolean', 
													 'elderlyweight','urbanityboolean','urbanityweight','inconvenienceweight', 'demographicweight', 
													 'facilitiesweight', 'ndviweight', 'waterweight', 'ptweight')
	return(weightlist)
}