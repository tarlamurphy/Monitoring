#point pattern analysis for population ecology

#set the working directory
setwd("~/Lab")

#retrieve the covid data
covid <- read.table("covid_agg.csv", header=TRUE, sep = "")


#point pattern analysis for population ecology
#load the needed libraries

library(spatstat)
library(ggplot2)

head(covid)

#planar point pattern
#ppp function in spatstat

#first, explain the x and y, then explain the extent you want
attach(covid)       #attach the covid dataset as ppp does not like having the dataset inside (otherwise use covid$lon)
covid_planar <- ppp(x = lon, y = lat, c(-180,180), c(-90,90)) #specify the range of x and y using the array function = c(...)

#plot the data
plot(covid_planar) 

#spatial density mapping
density_map <- density(covid_planar)

plot(density_map)   #plot the map
points(covid_planar, pch = 19) #adds the points to this map

#change the colour of the map
cl <- colorRampPalette(c('cyan','yellow','orange','red','red4'))(100) #makes an object containing the string of colour names
#the 100 means the amount of steps you take between colours is 100 total

plot(density_map, col = cl)
points(covid_planar, pch = 19, col = "purple")


#############################################

install.packages("vegan")

library(vegan)

load("biomes_multivar.RData")  # loads the required dataset
ls()   #what does ls() mean? - a list of what is in the dataset - bc this was a complete r project containing these tables

# plot per species matrix
head(biomes)

multivar <- decorana(biomes) #detrended correspondence analysis - similar to pca
#reduce dimensionality by using data that explains most of the information 
#simplifies by creating new datasets with new dimensions of data in a matrix
multivar # the DCA1 and DCA2 together explain 80% of the data

plot(multivar) #plot to view of correlations of the variables - interpret visually
#same quadrant, closer = increased correlation

# biomes names in the graph:
attach(biomes_types) #use the variables under the column types

ordiellipse(multivar, type, col = c("black","red","green","blue"), kind = "ehull", lwd = 3)  #ordiellipse function - data is multivar, variable is type
#kind means where on the plot?? Ellipse represents the points that are in the same biomes
ordispider(multivar, type, col = c("black","red","green","blue"), label = T)   #ordispider function labels the points in a spider web

pdf("multivar.pdf") #exports the plot as a pdf
plot(multivar)
ordiellipse(multivar, type, col = c("black","red","green","blue"), kind = "ehull", lwd = 3)
ordispider(multivar, type, col = c("black","red","green","blue"), label = T) #all of these get put in the pdf together
dev.off() #closes the pdf #can be used anywhere to close things off

#exercise
pdf("onlymultivar.pdf")
plot(multivar)
dev.off()


