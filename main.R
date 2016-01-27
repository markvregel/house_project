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

# source functions

source('Functions/ExecuteIndexes.R')

# Create directories
data_dir = 'Data'
output_dir = 'Ouput'
functions_dir = 'Functions'
download_dir = 'Downloads'
rawdata_dir = 'Rawdata'
dir_list = list(data_dir, output_dir, functions_dir, download_dir,rawdata_dir)
for (i in dir_list)
	{if (!file.exists(i)){
		dir.create(i)
	} 
}

# Calculate indexes
ExecuteIndexes()

# Weights of indexes


# Create raster

