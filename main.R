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
source('Functions/setvariables.R')
source('Functions/Extract_Index_Scores.R')
source('Functions/visualisation.R')
source('Functions/standardisation.R')
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
files <- list.files(path='Data')
if (length(files) == 0){ 
	getData()
}

# Set weights
OpenPythonGUI()
weightlist <- SetVariables()
railway_weight <- as.numeric(weightlist['railwayweight'])
roads_weight <- as.numeric(weightlist['roadweight'])
urban_boolean <- as.numeric(weightlist['urbanityboolean'])
urbanity_weight <-as.numeric(weightlist['urbanityweight'])
children_boolean <-as.numeric(weightlist['childrenboolean'])
children_weight <-as.numeric(weightlist['childrenweight'])
elderly_boolean <-as.numeric(weightlist['elderlyboolean'])
elderly_weight <-as.numeric(weightlist['elderlyweight'])

# Calculate indexes
substack <- ExecuteIndexes()

# Weights of indexes
PT_weight <- as.numeric(weightlist['ptweight'])
inconvenience_weight <- as.numeric(weightlist['inconvenienceweight'])
demographic_weight <- as.numeric(weightlist['demographicweight'])
facilities_weight <- as.numeric(weightlist['facilitiesweight'])
water_weight <- as.numeric(weightlist['waterweight'])
NDVI_weight <- as.numeric(weightlist['ndviweight'])

# weight x index
PT_result <- PT_weight * substack[[1]]
inconvenience_result <- inconvenience_weight * substack[[2]]
facilities_result <- facilities_weight * substack[[3]]
demographic_result <- demographic_weight * substack[[4]]
NDVI_result <- NDVI_weight * substack[[5]]
water_result <- water_weight * substack[[6]]
	
# calculate final scores and save to outputs
End_score <- overlay(PT_result, inconvenience_result, facilities_result, demographic_result, NDVI_result, water_result, fun=function(a,b,c,d,e,f){a+b+c+d+e+f})
Result_Output <- "Output/End_Score_Raster" 
End_score <- standardise(End_score)
writeRaster(x=End_score, filename=Result_Output, overwrite = TRUE)


# Extract values from raster to municipality polygon
Municipality_poly <- readOGR("Data", "gem_2015")
Municipality_Scores <- Extract_Index_Scores(End_score, Municipality_poly)

# Remove nans
Municipality_Scores <- subset(Municipality_Scores, layer!="NaN")

#save Municipality_Scores spatialdataframe
writeOGR(Municipality_Scores, 'Output', 'MunicipalityScores', driver = 'ESRI Shapefile')

# Visualise results in leaflet
visualise_results(substack,End_score,Municipality_Scores)
