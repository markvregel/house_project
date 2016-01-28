Extract_Index_Scores <- function(Index_Result, Municipality_poly){
	#' 
	
	Extract_Index_Scores_df <- extract(Index_Result, Municipality_poly,fun=mean, sp = TRUE, na.rm=TRUE)
	
	return(Extract_Index_Scores_df)
}