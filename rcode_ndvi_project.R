## Ecosystems Monitoring Project
## Time Series Analysis of Land Use Change and Deforestation in Europe (1999 - 2019)
## January 2023
## Tarla Murphy

# set working directory

# call up some useful packages

library(ncdf4)  #This package is used for reading .nc files, like from copernicus
library(raster) # raster functions directly process the rater pixels, different from geoprocessing which makes a new raster to work on
library(ggplot2) #classic ggplot
library(RStoolbox) #RStoolbox always has to go with ggplot2
library(viridis) # for the colour schemes - colorRampPalette
library(patchwork) # multiframe ggplot
library(rasterVis) # ?
library(rgdal) # ?


# upload the rasters
ndvi1999 <- raster("ndvi1999.nc")
plot(ndvi1999)

ndvi2009 <- raster("ndvi2009.nc")
ndvi2019 <- raster("ndvi2019.nc")

getValues(ndvi2009)

# plot the raster map using ggplot
ggplot()+
  geom_raster(ndvi1999, mapping = aes(x=x, y=y, 
                                      fill = Normalized.Difference.Vegetation.Index.1km))+
  scale_fill_viridis(option="viridis") + # using the viridis colour scheme and function
  ggtitle("NDVI 1999")
