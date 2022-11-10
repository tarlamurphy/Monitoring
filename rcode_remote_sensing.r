##REMOTE SENSING!!!!!

#download zip file Landsat Data
#extract files and put them in Lab folder

#install relevent packages if needed
#or else use library
install.packages("raster")
install.packages("RToolkit")

#make an object for the first picture we want- 
p224r63_2011 <- brick("p224r63_2011_masked.grd") # assign the file to an object #.grd means grid #masked means the data had been cleaned and abmormalities have been masked
#brick function collects together the layers (bands) into a raster brick

p224r63_2011 #recall the object

plot(p224r63_2011)

cl <- colorRampPalette(c('black','grey','light grey'))(100) #rmember 100 is the ramp/gradient between colours, bigger= smoother
plot(p224r63_2011, col=cl) #how much the objects are reflecting this colour

par(mfrow=c(2,2))

clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # array of colours - greyscale 
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c('dark green','green','light green'))(100) # 
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100) # 
plot(p224r63_2011$B3_sre, col=clr)
