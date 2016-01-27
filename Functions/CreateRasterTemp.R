#Create an empty raster with the extent of gelderland in the RD New projection
CreateRasterTemp <- function(Gelderland){

library(raster)

#first make a random matrix
xy <- matrix(nrow = 881, ncol = 1263)

# Turn the matrix into a raster
rast <- raster(xy)

# Give it the extent of gelderland (this extent is coming from the province boundaries)
extent(rast) <- c(128017.2, 254361.2, 416123.1, 504188.1)

# ... and assign a projection(RD New)
projection(rast) <- CRS("+init=epsg:28992")

# resample the cell size to 100 by 100
res(rast)<-100

#give the rastercells the value 0
GelderlandRas <- setValues(rast, 0)

#mask it to gelderland (maybe not useful now)
GelderlandRas <- mask(GelderlandRas, Gelderland)

#save the raster
writeRaster(GelderlandRas, 'Data/GelderlandRas.grd', overwrite = TRUE)

return(GelderlandRas)
}