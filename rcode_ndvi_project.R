## Ecosystems Monitoring Project
## Time Series Analysis of Land Use Change and Deforestation in Europe (1999 - 2019)
## January 2023
## Tarla Murphy

# set working directory eg. ("C:/Lab")

# call up some useful packages

library(ncdf4)  #This package is used for reading .nc files, (fancy files!) like from copernicus
library(raster) # raster functions directly process the rater pixels, different from geoprocessing which makes a new raster to work on
library(ggplot2) #classic ggplot
library(RStoolbox) #RStoolbox always has to go with ggplot2
library(viridis) # for the colour schemes - colorRampPalette
library(patchwork) # multiframe ggplot
library(rasterVis) # helps with visualizing raster data
library(rgdal) # spatial software - sp package
library(maps) # makes it possible to overlay country borders on maps

# upload the rasters
ndvi1999 <- brick("ndvi1999.nc") #upload as a raster brick instead of raster layer
ndvi2009 <- brick("ndvi2009.nc")
ndvi2019 <- brick("ndvi2019.nc")

ndvi1999 #view the metadata

##############################

# plot the raster maps using ggplot
w <- ggplot()+
  geom_raster(ndvi1999, mapping = aes(x=x, y=y, 
                                      fill = X1999.06.11))+ #check the name of the fill layer
  scale_fill_viridis(option="viridis") + # using the viridis colour scheme and function
  ggtitle("NDVI 1999")
w <- w + labs(fill = "NDVI")  # add the legend
w # show the map (world)

ggsave("worldNDVI99.tiff", w, width=21, height=12, units="cm", dpi=300) # to export plots


ext <- c(-20, 65, 30, 75) #put the minimum x and y to cover europe ( min x, max x, min y, max y)


n1999.eu <- crop(ndvi1999, ext) # this will crop the dataset to the specified area
n2009.eu <- crop(ndvi2009, ext)
n2019.eu <- crop(ndvi2019, ext)


####################################
#NDVI Changes

# now plot the map of just europe 1999
e99 <- ggplot()+
  geom_raster(n1999.eu, mapping = aes(x=x, y=y, 
                                      fill = X1999.06.11), show.legend = FALSE)+
  scale_fill_viridis(option="magma") + # using the viridis colour scheme and function
  ggtitle("NDVI 1999") 
 
e99 <- e99 + labs(fill = "NDVI") # remove the extremely long original label
  
e99 # display the plot to check it's how it should look

# plot of europe 2009
e09 <- ggplot() +
  geom_raster(n2009.eu, mapping = aes(x=x, y=y, 
                                      fill = X2009.06.11), show.legend = FALSE)+
  scale_fill_viridis(option="magma") + 
  labs(colour = "NDVI") +
  ggtitle("NDVI 2009")
#e09 <- e09 + labs(fill = "NDVI") 

# plot of Europe 2019
e19 <- ggplot() +
  geom_raster(n2019.eu, mapping = aes(x=x, y=y, 
                                      fill = X2019.06.11))+
  scale_fill_viridis(option="magma") + 
  labs(colour = "NDVI") +
  ggtitle("NDVI 2019")
#e19 <- e19 + labs(fill = "NDVI")
e19
# plot all of them together using patchwork
e <- e99 + e09 + e19
e


ggsave("euNDVI.png", e, width=35, height=12, units="cm", dpi=300)


##################
# difference between 99 and 19

rlist <- list.files(pattern="ndvi") #make a list of the files that start with "ndvi"
rlist 

#lapply takes the list and applies any function you want
# use the lapply function to the list

import <- lapply(rlist, raster) # specify the list and the function to import the data
import # here it is


NdEu <- stack(import)  # a raster stack - all the four layers in a single file - named 'NDVI Europe'
plot(NdEu) # to plot all this data in 3 simple plots 

dift <- NdEu[[3]] - NdEu[[1]] # what is the difference between 2019 and 1999
dift
eu.dift <- crop(dift, ext) # crop to just show Europe
eu.dift <- brick(eu.dift) # convert to raster brick format


eu.dift1 <- eu.dift; eu.dift1[eu.dift1 == 0] <- NA # set all values that equal zero to NA

# plot the difference
eudif <- ggplot() +
  geom_raster(eu.dift1, mapping =aes(x=x, y=y, fill=layer)) + # use ggplot to plot the data as before
  scale_fill_viridis(option="magma", direction=1,na.value=NA)
  #annotation_map(map_data("world"), fill=NA, colour="gray20", linewidth=0.3)  #could add country borders using this 
eudif

ggsave("eudifborders.png", eudif, width=18, height=12, units="cm", dpi=300)

##
# to plot the rgb of the timesteps
plotRGB(NdEu, r=1, g=2, b=3, ext=ext, stretch='lin') # cropped to europe extent
# r = 1999, g = 2009, b = 2019

plotRGB(NdEu, r=3, g=2, b=1, ext=ext, stretch='lin') #in this one red is 2019


########################

# percentages
#unsupervised classification is when we do not state the threshhold, the software decides itself
n991c <- unsuperClass(n1999.eu, nClasses=2) # d1c = ndvi 1st period classification
plot(n991c$map) #only 2 classes in this map - shows a min/max of ndvi

#how to know the amount of things that have changed in time
freq(n991c$map) #shows for class 1:human impact+water and class 2: forest
# 1 14260774
# 2 32514010
# NA 1206016
# these are for 1999

#proportion
white99 <- 14260774/(14260774 + 32514010)
#0.30488
green99 <- 32514010/(14260774 + 32514010)
#0.69511

# the same for 2009
n091c <- unsuperClass(n2009.eu, nClasses=2)
plot(n091c$map)
freq(n091c$map)
#1 14362963
#2 32651723
#NA 966114

#proportion
white09 <- 14362963/(14362963 + 32651723)
#0.305499
green09 <- 32651723/(14362963 + 32651723)
#0.6945

#the same for 2019
n191c <- unsuperClass(n2019.eu, nClasses=2)
plot(n191c$map)
freq(n191c$map)

# 1 34878203
# 2 11855470
# NA 1247127

# proportion
white19 <- 11855470/(11855470 + 34878203)
#0.2536
green19 <- 34878203/(11855470 + 34878203)
#0.74


# plot them all together with ggplot, as before
n19 <- ggplot() +
  geom_raster(n191c$map, mapping = aes(x=x, y=y, 
                                          fill = class), show.legend = F)+
  scale_fill_viridis(option="viridis", direction=1)+
  ggtitle("2019")

n09 <- ggplot() +
  geom_raster(n091c$map, mapping = aes(x=x, y=y, 
                                       fill = class), show.legend = F)+
  scale_fill_viridis(option="viridis", direction=-1)+
  ggtitle("2009")

n99 <- ggplot() +
  geom_raster(n991c$map, mapping = aes(x=x, y=y, 
                                       fill = class), show.legend = F)+
  scale_fill_viridis(option="viridis", direction=1)+
  ggtitle("1999")

 n <- n99 + n09 + n19
n
  
ggsave("impact.png", n, width=35, height=12, units="cm", dpi=300)
 
#green = nature, white = barren/urban


