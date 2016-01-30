visualise_results <- function(subindex_stack,final_index,mun_index){
#'function that Visualizes the output rasters and the municipalities
#'		Arg:
#'			subindex_stack(Rasterstack): stack of sub-indexes
#'			final_index(Rasterlayer): raster of final index
#'			mun_index(SPDF): spatialdataframe with city data of Municipalities

	# change coordinate system of spatialdataframe Municipalities
	mun_index<-spTransform(mun_index, CRS("+init=epsg:4326"))
	
	# create pop up for spatialdataframe Municipalities
	gem_popup <- paste0("<table><tr><td bgcolor=#E0E0E0><strong>Name: </strong></td><td>",mun_index$GM_NAAM,"</td></tr><tr><td bgcolor=#E0E0E0><strong>Surface area(m2): </strong></td><td>",
											mun_index$OPP_TOT,"</td></tr><tr><td bgcolor=#E0E0E0><strong>Population: </strong></td><td>",
											format(mun_index$AANT_INW, big.mark = ".", decimal.mark = ","),"</td></tr></table>")
	# create color schemes for visulisation
	pal <- colorNumeric("YlGn", mun_index$layer)
	pal1 <- colorNumeric(c('Brown',"red", "yellow",'green' ,"Darkgreen"), c(0,1),
											 na.color = "transparent")
	# create leaflet with rasterdatasets and city polygons
	results_vis <-leaflet() %>%   addTiles(group = "Openstreetmap") %>%
		addProviderTiles("Stamen.TonerLite", group = "Stamen Toner Lite") %>%
		addProviderTiles("Esri.WorldImagery", group = "Esri WorldImagery") %>%
		addRasterImage(final_index, colors = pal1, opacity = 1,group = "Final score") %>%
		addRasterImage(subindex_stack[['Public.Transport.Index']], colors = pal1, opacity = 1,group = "Public Transport") %>%
		addRasterImage(subindex_stack[['Inconvenience.Index']], colors = pal1, opacity = 1,group = "Inconvenience") %>%
		addRasterImage(subindex_stack[['Facilities.Index']], colors = pal1, opacity = 1,group = "Facilities") %>%
		addRasterImage(subindex_stack[['Demographic.Index']], colors = pal1, opacity = 1,group = "Demographic") %>%
		addRasterImage(subindex_stack[['NDVI.Index']], colors = pal1, opacity = 1,group = "NDVI") %>%
		addRasterImage(subindex_stack[['Water.Index']], colors = pal1, opacity = 1,group = "Water") %>%
		addLegend(pal = pal1, values = c(0,1), title = "Raster score") %>% # legend for rasters

			addPolygons(
			data=mun_index,
			group = "Municipalities",
			popup = gem_popup,
			fillOpacity = 0.7,
			color = pal(mun_index$layer), 
			weight = 2)%>%
		addLegend(pal = pal, values = c(min(mun_index$layer),max(mun_index$layer)),
							title = "Mean score per Municipality",position = 'bottomright') %>% #legend of Municipalities
		# Layers control
		addLayersControl(
			baseGroups = c("Openstreetmap", "Stamen Toner Lite", "Esri WorldImagery"),
			overlayGroups = c("Final score", "Municipalities","Public Transport", 
												"Inconvenience","Facilities","Demographic","NDVI","Water"),
			options = layersControlOptions(collapsed = FALSE),position='bottomleft')%>% 
		hideGroup(c("Municipalities","Public Transport","Inconvenience","Facilities","Demographic","NDVI","Water"))
	#start leaflet interface
	results_vis
	
	
}