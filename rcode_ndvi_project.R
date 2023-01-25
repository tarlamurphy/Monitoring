## Ecosystems Monitoring Project
## Time Series Analysis of Land Use Change and Deforestation in Europe (1999 - 2019)
## January 2023
## Tarla Murphy

# set working directory


############
# To do:
# raster maps of 99, 09, 19 /
# map of 19 - 99 = difference
# Amazon 99, 09, 19
# time series comparison of both
# amazon 19 - 99 = dif
# global difference
# ?????



# call up some useful packages

library(ncdf4)  #This package is used for reading .nc files, (fancy files!) like from copernicus
library(raster) # raster functions directly process the rater pixels, different from geoprocessing which makes a new raster to work on
library(ggplot2) #classic ggplot
library(RStoolbox) #RStoolbox always has to go with ggplot2
library(viridis) # for the colour schemes - colorRampPalette
library(patchwork) # multiframe ggplot
library(rasterVis) # helps with visualizing raster data
library(rgdal) # ? spatial software - sp package


# upload the rasters
ndvi1999 <- brick("ndvi1999.nc") #upload as a raster brick instead of raster layer
ndvi2009 <- brick("ndvi2009.nc")
ndvi2019 <- brick("ndvi2019.nc")


plot(ndvi1999)

ndvi1999
n1999.eu

plotRGB(, r=1, g=2, b=3, stretch='lin')
##############################

# plot the raster maps using ggplot
ggplot()+
  geom_raster(ndvi1999, mapping = aes(x=x, y=y, 
                                      fill = X1999.06.11))+
  scale_fill_viridis(option="viridis") + # using the viridis colour scheme and function
  ggtitle("NDVI 1999")

ext <- c(-20, 70, 20, 75) #put the minimum x and y to cover europe ( min x, max x, min y, max y)

n1999.eu <- crop(ndvi1999, ext) # this will crop the dataset to the specified area
n2009.eu <- crop(ndvi2009, ext)
n2019.eu <- crop(ndvi2019, ext)


plotRGB(ndvi1999, r=1, g=2, b=3, stretch='lin')

# now plot the map of just europe 1999
e99 <- ggplot()+
  geom_raster(n1999.eu, mapping = aes(x=x, y=y, 
                                      fill = X1999.06.11))+
  scale_fill_viridis(option="magma") + # using the viridis colour scheme and function
  ggtitle("NDVI 1999") 
 
e99 <- e99 + labs(fill = "NDVI")

e99
# plot of europe 2009
e09 <- ggplot() +
  geom_raster(n2009.eu, mapping = aes(x=x, y=y, 
                                      fill = X2009.06.11))+
  scale_fill_viridis(option="magma") + # using the viridis colour scheme and function
  labs(colour = "NDVI") +
  ggtitle("NDVI 2009")
e09 <- e09 + labs(fill = "NDVI")

e19 <- ggplot() +
  geom_raster(n2019.eu, mapping = aes(x=x, y=y, 
                                      fill = X2019.06.11))+
  scale_fill_viridis(option="magma") + # using the viridis colour scheme and function
  labs(colour = "NDVI") +
  ggtitle("NDVI 2019")
e19 <- e19 + labs(fill = "NDVI")

e99 + e09 + e19

##################
# difference between 99 and 19

rlist <- list.files(pattern="ndvi")
rlist

#lapply takes the list and applies any function you want
# use the lapply function to the list

import <- lapply(rlist, raster) # specify the list and the function to import the data
import # here it is

NdEu <- stack(import)  # a raster stack - all the four layers in a single file - named 'greenland temperature'
plot(NdEu) # to plot all this data in a straightforward fast way

dift <- NdEu[[3]] - NdEu[[1]]
dift
eu.dift <- crop(dift, ext)

#cl <- colorRampPalette(c('#440154','#3b528b','#21918c','#5ec962', '#fde725'))(200)

ggplot() + geom_raster(eu.dift, mapping =aes(x=x, y=y, fill=layer)) + # use ggplot to plot the data as before
  scale_fill_viridis(option="viridis", direction=1) + # using direction = -1, the direction of the colour scale is reversed
  ggtitle("NDVI Difference")


