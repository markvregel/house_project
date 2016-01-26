## Project Week 4 Geoscripting
## Jos Goris, Mark ten Vregelaar and Bob Houtkooper
## "I know where your house lives"
## 29-01-2016

# Import modules
 
# Set working directory 


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

# Set preferences and weights

# Calculate indexes

# Create raster

