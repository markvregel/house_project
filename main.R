## Project Week 4 Geoscripting
## Jos Goris, Mark ten Vregelaar and Bob Houtkooper
## "I know where your house lives"
## 29-01-2016

# Import modules
 
# Set working directory 
work_dir = '~/bin/house_project'
setwd(work_dir)

# Create directories
data_dir = 'Data'
output_dir = 'Functions'
functions_dir = 'Ouput'
download_dir = 'Downloads'
dir_list = list(data_dir, output_dir, functions_dir, download_dir)
for (i in dir_list)
	{if (!file.exists(i)){
		dir.create(i)
	} 
}

# Set preferences and weights

# Calculate indexes

# Create raster

