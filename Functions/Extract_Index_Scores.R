Extract_Index_Scores <- function(Index_Result, Municipality_poly){
	#' 
	
	Extract_Index_Scores_df <- extract(Index_Result, Municipality_poly,fun=mean, sp = TRUE, na.rm=TRUE)
# 	print(class(Extract_Index_Scores_df))
# 	print('------------------------------------')
# 	print(Extract_Index_Scores_df[2])
# 	View(Extract_Index_Scores_df)
# 	plot()
# 	Municipality_score <- Municipality_poly
# 	Municipality_score$MeanScore <- Extract_Index_Scores_df[1]

	
	return(Extract_Index_Scores_df)
}