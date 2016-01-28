standardise <- function(in_raster){
	#' Standardise values
	#'      Arg:
	#'          urbanity_raster (raster): A raster with values till a max_value
	#'      Return:
	#'        	A raster with standardised values between 0-1	
	
	# Takes the input raster and makes the scores between 0 and 1
	out_raster <- calc(in_raster, function(x) x/maxValue(in_raster))
	return(out_raster)
}

