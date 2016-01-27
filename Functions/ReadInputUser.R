readinteger_weight <- function()
{ 
	n <- readline(prompt="Enter a weight indicator(1-5): ")
	n <- as.integer(n)
}

readinteger_bool <- function()
{ 
	n <- readline(prompt="Enter TRUE or FALSE: ")
	n <- as.logical(n)
}
