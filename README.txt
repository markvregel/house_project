We know where your house lives!

Jos Goris, Mark ten Vregelaar and Bob Houtkooper

WUR geoscripting

Description

This repository contains the scripts and data for a project that can help you to find a suitable place to live. 
Some input data is included to the reduce running time(mainly downloading). 
This tool includes a GUI in which the user can give input about they area he/she would like to live. 
The tool can be used to find a suitable place to live in Gelderland.
 This can easily be changed to other areas but this not an option in the GUI. 
The tool uses both the python and R programming language. 

To find the perfect place to live for the user a index is used. 
This index is made up of 6 sub indexes:
 NDVI, water, public transport, facilities, demographic features and inconvenience features.
The tool returns an interactive map in which you can see the results.


How To run?

make sure you have these R libraries installed:
raster
rgdal
GISTools
maptools
rasterVis
sp
leaflet

Than simply run Main.R in R studio and fill in GUI questionnaire(be precise and check for typos). 
Finally press the write data button to continue running the script. 
The interactive map will be displayed in the Viewer. It should take about 15 minutes to run the script.

Two example outputs:

http://rpubs.com/JosGoris/greenfingers (person who likes nature and water)

http://rpubs.com/markvregel/Brick_Face (Old man who find facilities important.)