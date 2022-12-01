#USING COPERNICUS DATA


#install.packages("ncdf4")
 
library(ncdf4)  #This package is used for reading .nc files, like from copernicus
library(raster) # raster functions directly process the rater pixels, different from geoprocessing which makes a new raster to work on
library(ggplot2) 
library(RStoolbox) #RStoolbox always has to go with ggplot2
library(viridis) # for the colour schemes - colorRampPalette
library(patchwork) # multiframe ggplot

# also in cv - git hub, analysis of Copernicus data (and Latex , which we will use in the future)

snow <- raster("c_gls_SCE_202012210000_NHEMI_VIIRS_V1.0.1.nc")

snow 

#exercise
#based on your previous code plot the snow cover with ggplot and viridis

ggplot() + geom_raster(snow, mapping =aes(x=x, y=y, fill=Snow.Cover.Extent)) + # we want to make a plot, using raster data, check inside the object to find what fill should be - names
  scale_fill_viridis(option="viridis") + # using the viridis colour scheme and function
  ggtitle("Snow Cover")

# now we only want to use only the european data
# if you want to monitor ecosystems you should use coordinates to be more precisse and reproduceable
# avoid "draw extent" at all costs
ext <- c(-20, 70, 20, 75) #put the minimum x and y to cover europe ( min x, max x, min y, max y)

snow.europe <- crop(snow, ext) # this will crop the dataset to the specified area

ggplot() + geom_raster(snow.europe, mapping =aes(x=x, y=y, fill=Snow.Cover.Extent)) + # we want to make a plot, using raster data, check inside the object to find what fill should be - names
  scale_fill_viridis(option="viridis") + # using the viridis colour scheme and function
  ggtitle("Snow Cover")



# exercise: plot together the two sets with patchwork package

s <- ggplot() + geom_raster(snow, mapping =aes(x=x, y=y, fill=Snow.Cover.Extent)) + # we want to make a plot, using raster data, check inside the object to find what fill should be - names
  scale_fill_viridis(option="viridis") + # using the viridis colour scheme and function
  ggtitle("Snow Cover")

se <- ggplot() + geom_raster(snow.europe, mapping =aes(x=x, y=y, fill=Snow.Cover.Extent)) + # we want to make a plot, using raster data, check inside the object to find what fill should be - names
  scale_fill_viridis(option="viridis") + # using the viridis colour scheme and function
  ggtitle("Snow Cover")

s + se
