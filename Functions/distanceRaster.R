library(raster)
library(gdal)
library(maptools)
library(sp)


punten <- readShapePoints('data/points.shp')

latlong <- "+init=epsg:4326"
RD_new <- "+init=epsg:28992"
proj4string(punten) <- CRS(latlong)

puntenRD <- spTransform(punten, CRS(RD_new))


# Download Province boundaries
nlProvincie <- raster::getData('GADM',country='NLD', level=1,path=ifolder)
nlProvincie_sinu <- spTransform(nlProvincie, CRS("+init=epsg:28992")) # change projection Province data
Gelderland <- nlProvincie_sinu[4,]

#All point in the selected area(Gelderland)
GelderlandSub <- puntenRD[Gelderland,]

#Select variable(in this case 'pubs')
pubs <- subset(GelderlandSub, type == 'pub')

#Make an empty raster with value 0
EmptyRas <- setValues(raster(NDVIGelderland), 0)

#Distance grid
DistanceVar <- distanceFromPoints(EmptyRas, pubs)
