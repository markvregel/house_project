# Hakken en zagen
# Mark ten Vregelaar and Jos Goris
# 12 January 2016
# Greenest city: find the city with the highest NDVI

# Start with empty environment
rm(list=ls())

# Get required libraries
library(raster)
library(rgdal)
library(rasterVis)
library(sp)

#set input and output folder
ifolder <- "./data/"
ofolder <- "./output/"
dir.create(ifolder, showWarnings = FALSE)
dir.create(ofolder, showWarnings = FALSE)
# Read R Code from function in map R

# Download data -----------------------------------------------------------------

# Download NDVI data
NDVIURL <- "https://github.com/GeoScripting-WUR/VectorRaster/raw/gh-pages/data/MODIS.zip"
inputZip <- list.files(path=ifolder, pattern= '^.*\\.zip$')
if (length(inputZip) == 0){ ##only download when not alrady downloaded
  download.file(url = NDVIURL, destfile = 'data/NDVI_data.zip', method = 'wget')
  
}

# Download Province boundaries
nlProvincie <- raster::getData('GADM',country='NLD', level=1,path=ifolder)

# Data pre-processing -----------------------------------------------------------

unzip('data/NDVI_data.zip', exdir=ifolder)  # unzip NDVI data
NDVIlist <- list.files(path=ifolder,pattern = '+.grd$', full.names=TRUE) # list NDVI raster
NDVI_12 <- stack(NDVIlist) # NDVI rasters

NDVI_RD <- projectRaster(NDVI_12, crs = "+init=epsg:28992")

nlProvincie_sinu <- spTransform(nlProvincie, CRS("+init=epsg:28992")) # change projection Province data
Gelderland <- nlProvincie_sinu[4,]


# Select and calculate NDVI mean of the year
NDVI_mean <- calc(NDVI_RD,mean)

NDVIGelderland <- crop(NDVI_mean, Gelderland)
NDVIGelderland <- mask(NDVIGelderland, Gelderland)

# Visualization-----------------------------------------------------------------
plot(NDVIGelderland)
