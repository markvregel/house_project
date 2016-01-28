# funstion to dowload a list of URLs

downloadlist <- function(myURL) {
	#' function that downloads files from a URL
	#' 		Arg: myURL(str): URL of where files are dowloaded from
	#'
	download.file(url = myURL[[2]], destfile = paste0('Downloads/',myURL[[1]],'.zip'), method = 'wget')
	
}