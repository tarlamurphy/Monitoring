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
