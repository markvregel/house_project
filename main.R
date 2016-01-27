## Project Week 4 Geoscripting
## Jos Goris, Mark ten Vregelaar and Bob Houtkooper
## "I know where your house lives"
## 28-01-2016

# Import modules
library(raster)
library(rgdal)
library(GISTools)
library(maptools)
library(rasterVis)
library(sp)
library(leaflet)

# source functions
source('Functions/getData.R')
source('Functions/ExecuteIndexes.R')

# Create directories
data_dir = 'Data'
output_dir = 'Output'
functions_dir = 'Functions'
download_dir = 'Downloads'
rawdata_dir = 'Rawdata'
dir_list = list(data_dir, output_dir, functions_dir, download_dir,rawdata_dir)
for (i in dir_list)
	{if (!file.exists(i)){
		dir.create(i)
	} 
}

# get the data
getData()

# Set weights
railway_weight <- 1
roads_weight <- 1 
urban_boolean <- TRUE
urbanity_weight <-1 
children_boolean <-TRUE
children_weight <-1 
elderly_boolean <-TRUE
elderly_weight <-1 

# Calculate indexes
substack <- ExecuteIndexes()

# Weights of indexes
PT_weight <- 1
inconvenience_weight <- 1
demographic_weight <- 1
facilities_weight <- 1
water_weight <- 1
NDVI_weight <- 1

# weight x index
PT_result <- PT_weight * substack[[1]]
inconvenience_result <- inconvenience_weight * substack[[2]]
facilities_result <- facilities_weight * substack[[3]]
demographic_result <- demographic_weight * substack[[4]]
NDVI_result <- NDVI_weight * substack[[5]]
water_result <- water_weight * substack[[6]]
	
# Create raster
End_score<- overlay(PT_result, inconvenience_result, facilities_result, demographic_result, NDVI_result, water_result, fun=function(a,b,c,d,e,f){a+b+c+d+e+f})
