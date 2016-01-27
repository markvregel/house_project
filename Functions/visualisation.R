visualise_results <- function(subindex_stack,final_index,mun_index){
	
	library(leaflet)
	library(raster)
	library(rgdal)
	test <- raster('Data/GelderlandRas.grd')

	test[]<-runif(ncell(test),0,100)
	pal <- colorNumeric(c("red", "#41B6C4", "#FFFFCC"), values(test),
											na.color = "transparent")
	gem_2015 <- readOGR("Data", "gem_2015.shp")
	
	gem_popup <- paste0("<table><tr><td bgcolor=#E0E0E0><strong>Naam: </strong></td><td>",gem_2015$GM_NAAM,"</td></tr><tr><td bgcolor=#E0E0E0><strong>Oppervlak: </strong></td><td>",
											gem_2015$OPP_TOT,"</td></tr><tr><td bgcolor=#E0E0E0><strong>Inwoners: </strong></td><td>",
											format(gem_2015$AANT_INW, big.mark = ".", decimal.mark = ","),"</td></tr></table>")
	t<-leaflet() %>%   addTiles(group = "Openstreetmap") %>%
		addProviderTiles("Stamen.TonerLite", group = "Stamen Toner Lite") %>%
		addProviderTiles("Stamen.Watercolor", group = "Stamen Watercolor") %>%
		addRasterImage(test, colors = pal, opacity = 1) %>%
		addLegend(pal = pal, values = values(test),
							title = "housing score")	%>%
	addPolygons(
		data=spTransform(gem_2015, CRS("+init=epsg:4326")),
		group = "Gemeenten (2015)",
		popup = gem_popup,
		fillOpacity = 0,
		color = "#900000",
		weight = 2)%>%
	# Layers control
	addLayersControl(
		baseGroups = c("Openstreetmap", "Stamen Toner Lite", "Stamen Watercolor"),
		overlayGroups = c("Stations", "Spoorwegen", "Gemeenten (2015)"),
		options = layersControlOptions(collapsed = FALSE))
		
	
	
}