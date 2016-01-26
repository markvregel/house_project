source("pre-processing.R")
source("downloadlist.R")
library(rgdal)
library(maptools)

dir.create('downloads',showWarnings = F)
dir.create('rawdata',showWarnings = F)
dir.create('data',showWarnings = F)
OSM_F <-'rawdata/OSM/'
CBS_square_F <- 'rawdata/CBS_square/'
municipalities_F <- 'rawdata/municipalities/'
provinces_F <- 'rawdata/provinces/'


dir.create(OSM_F,showWarnings = F)
dir.create(CBS_square_F,showWarnings = F)
dir.create(municipalities_F,showWarnings = F)
dir.create(provinces_F,showWarnings = F)
# Download data -----------------------------------------------------------

# deifne URLs
OSMURL = 'http://download.geofabrik.de/europe/netherlands-latest.shp.zip'
CBS_squareURL = 'www.cbs.nl/nl-NL/menu/themas/dossiers/nederland-regionaal/links/2013-kaart-vierkanten-el.htm'
municipalitiesURL = 'www.cbs.nl/nl-NL/menu/themas/dossiers/nederland-regionaal/links/wijk-en-buurtkaart-shape-2015.htm'
provincesURL = 'www.imergis.nl/shp/Bestuurlijkegrenzen-provincies-actueel-shp.zip'

# put in list
URLlist = list(list('OSM',OSMURL),list('CBS_square',CBS_squareURL),list('municipalities',municipalitiesURL),list('provinces',provincesURL))

# dowload data
inputZip <- list.files(path='downloads', pattern= '^.*\\.zip$')
if (length(inputZip) == 0){ ##only download when not alrady downloaded (safes time to debug the whole script)
lapply(URLlist, downloadlist)
}

# Unzip data

unzip('downloads/OSM.zip', exdir=OSM_F)
unzip('downloads/CBS_square.zip', exdir=CBS_square_F)
unzip('downloads/municipalities.zip', exdir=municipalities_F)
unzip('downloads/provinces.zip', exdir=provinces_F)

# define projections

latlong = "+init=epsg:4326"
RD_new = "+init=epsg:28992"

# get shape of gelderland and store as shapefile
provinces <- readShapeSpatial("rawdata/provinces/TopGrenzen-prov-actueel.shp")
proj4string(provinces)= CRS(RD_new)
Gelderland = subset(provinces,Provincien=='Gelderland')
writeOGR(Gelderland, './data', 'Gelderland', driver="ESRI Shapefile", overwrite_layer=TRUE)

# re-project, clip and save OSM shapefiles
shplist_OSM = list.files(path=OSM_F, pattern= '^.*\\.shp$')[c(3:5,7)]
lapply(shplist_OSM, function(x) reproject_convert_OSM_shp(paste0('rawdata/OSM/',x),name=substr(x,1,nchar(x)-4),clip=Gelderland))

# clip and save municipalities shapefiles
shplist_mun = list.files(path='./rawdata/municipalities/uitvoer_shape', pattern= '^.*\\.shp$')
lapply(shplist_mun, function(x) clip_save_mun_shp(shp=paste0('rawdata/municipalities/uitvoer_shape/',x),clip=Gelderland,name=substr(x,1,nchar(x)-4)))
