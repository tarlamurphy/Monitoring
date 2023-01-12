##Species Distribution Modelling

#install.packages("sdm")
library(sdm)
library(raster) # for predictors
library(rgdal) # for species (geospatial data)

#GBIF database - global biodiversity information facility - ecological datasets free to use

file <- system.file("external/species.shp", package="sdm") #looking for a shapefile external to R, but contained within the sdm package
file # the system file function reports the pathway to the data within your computer

#now we need to give it a path into r
species <- shapefile(file)
plot(species)

#the species is a frog (rana temporaria)
# subset the data to show only the presence data 

species$Occurrence
# presence = 1, absence = 0

# managing databases - sql is useful to subset the data - called 'sequel'
# double == is used in sequel to 

presence <- species[species$Occurrence == 1,]
absence <-  species[species$Occurrence == 0,]

plot(presence, col = "blue", pch = 18)
points(absence, col = "red", pch = 19)

#now to add the environmental raster data
# and the ndvi as a proxy for how much vegetation
# called a 'stack of predictors' in modeling

##  predictors
# upload the stack

path <- system.file("external", package = "sdm")
# look for the file with the .asc extension - image extension like a csv file

# list the predictors
lst <- list.files(path=path,pattern='asc$',full.names = T) # the $ is used as the .asc is an extension

lst # this shows all the files with the .asc extension

# stack the predictors
preds <- stack(lst) 

plot(preds)

# now plot all four conditions of the model into a distribution map

# plot predictors
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# model

datasdm <- sdmData(train = species, predictors = preds) #the train are the points- the species
datasdm # tells us some information about the contents of the model

# make a logistic model - a general linear model model
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")
# function is sdm, we list the predictors and what kind of model we want
# model is in the fourth dimension (?)
# must include where to find the data
# for a model, always use the tilde ~

# plot the output
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# add to the stack
s1 <- stack(preds,p1)
plot(s1, col=cl)
# this final one is all of the combined modeled with the glm
# a relationship of all the predictors (factors) with the occurances
