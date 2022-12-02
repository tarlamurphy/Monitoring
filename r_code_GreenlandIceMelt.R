##TIME SERIES ANALYSIS OF GREENLAND ICE MELT 

# IMPORTANT FUNCTIONS
# L apply function
# stack funtion

#
# install.packages("rasterVis")
library(raster) # helps us import
library(ggplot2) # graphs and plots
library(RStoolbox) 
library(viridis)
library(patchwork)
library(rasterVis) # 
library(rgdal) # 

# import the images from the lab folder

lst_2000 <- raster("lst_2000.tif")
# lst_2005 <- raster("lst_2005.tif")
# lst_2010 <- raster("lst_2010.tif")
# lst_2015 <- raster("lst_2015.tif")


#exercise: plot lst_2000 with ggplot

lst_2000 # recall the object for a summary and to find the name of the "fill"

ggplot() + geom_raster(lst_2000, mapping =aes(x=x, y=y, fill=lst_2000)) + # use ggplot to plot the data as before
  scale_fill_viridis(option="mako", direction=1, alpha=0.8) + # using direction = -1, the direction of the colour scale is reversed
  ggtitle("Greenland Temperature 2000")

# alpha controls the transparency of the image - closer to zero extremely transparent

# this is an image at 16 bit - we are seeing temperature measurements

# upload the rest of the data

lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

par(mfrow=c(2,2))

g2000 <- ggplot() + geom_raster(lst_2000, mapping =aes(x=x, y=y, fill=lst_2000)) + # use ggplot to plot the data as before
  scale_fill_viridis(option="mako", direction=1, alpha=0.8) + # using direction = -1, the direction of the colour scale is reversed
  ggtitle("Greenland Temperature 2000")

g2005 <- ggplot() + geom_raster(lst_2005, mapping =aes(x=x, y=y, fill=lst_2005)) + # use ggplot to plot the data as before
  scale_fill_viridis(option="mako", direction=1, alpha=0.8) + # using direction = -1, the direction of the colour scale is reversed
  ggtitle("Greenland Temperature 2005")
  
  
g2010 <- ggplot() + geom_raster(lst_2010, mapping =aes(x=x, y=y, fill=lst_2010)) + # use ggplot to plot the data as before
  scale_fill_viridis(option="mako", direction=1, alpha=0.8) + # using direction = -1, the direction of the colour scale is reversed
  ggtitle("Greenland Temperature 2010")

g2015 <- ggplot() + geom_raster(lst_2015, mapping =aes(x=x, y=y, fill=lst_2015)) + # use ggplot to plot the data as before
  scale_fill_viridis(option="mako", direction=1, alpha=0.8) + # using direction = -1, the direction of the colour scale is reversed
  ggtitle("Greenland Temperature 2015")

(g2000 + g2005) / (g2010 + g2015)


# IMPORTANT - using the lapply function
# list.files 

rlist <- list.files(pattern="lst") # this will make a list of files that start with 'lst'
rlist # shows what files are included in the list

#lapply takes the list and applies any function you want
# use the lapply function to the list

import <- lapply(rlist, raster) # specify the list and the function to import the data
import # here it is

TGr <- stack(import)  # a raster stack - all the four layers in a single file - named 'greenland temperature'
plot(TGr) # to plot all this data in a straightforward fast way

# now that we have all the data together we can 

g1 <- ggplot() + geom_raster(TGr[[1]], mapping =aes(x=x, y=y, fill=lst_2000)) + # use ggplot to plot the data as before
  scale_fill_viridis(option="magma", direction=-1, alpha=0.8) + # using direction = -1, the direction of the colour scale is reversed
  ggtitle("Greenland Temperature 2000")

# can use the object name, eg TGr$lst_2000 or use the element number, TGr[[1]]

g2 <-  ggplot() + geom_raster(TGr[[4]], mapping =aes(x=x, y=y, fill=lst_2015)) + # use ggplot to plot the data as before
  scale_fill_viridis(option="magma", direction=-1, alpha=0.8) + # using direction = -1, the direction of the colour scale is reversed
  ggtitle("Greenland Temperature 2015")

g1 + g2

## plot the difference in temperature between 2000 and 2015

dift <- TGr[[4]] - TGr[[1]]
dift

g3 <- ggplot() + geom_raster(dift, mapping =aes(x=x, y=y, fill=layer)) + # use ggplot to plot the data as before
  scale_fill_viridis(option="magma", direction=-1) + # using direction = -1, the direction of the colour scale is reversed
  ggtitle("Greenland Temperature Difference 2015")

g1 + g2 + p3


#exercise: plot RGB with TGr, 

plotRGB(TGr, r=1, g=2, b=4, stretch="lin")v#veverything becoming green/blue is getting warmer
