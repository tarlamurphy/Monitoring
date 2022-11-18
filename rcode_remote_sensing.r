##REMOTE SENSING!!!!! 

Hi jacob
Hi Lola

#download zip file Landsat Data
#extract files and put them in Lab folder

#install relevent packages if needed
#or else use library
install.packages("raster")
install.packages("RStoolbox")

library(raster)
  library(RStoolbox)

#make an object for the first picture we want- 
p224r63_2011 <- brick("p224r63_2011_masked.grd") # assign the file to an object #.grd means grid #masked means the data had been cleaned and abmormalities have been masked
#brick function collects together the layers (bands) into a raster brick

p224r63_2011 #recall the object

plot(p224r63_2011)

cl <- colorRampPalette(c('black','grey','light grey'))(100) #rmember 100 is the ramp/gradient between colours, bigger= smoother
plot(p224r63_2011, col=cl) #how much the objects are reflecting this colour

par(mfrow=c(2,2))

clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # array of colours - greyscale 
plot(p224r63_2011$B1_sre, col=clb) #assigned to $B1_sre - means band 1 or remote sensing data

clg <- colorRampPalette(c('dark green','green','light green'))(100) # 
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100) # 
plot(p224r63_2011$B3_sre, col=clr)





#################

par(mfrow=c(2,2)) #mfrow means

clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) #colorRampPalette puts colour elements in an array
plot(p224r63_2011$B1_sre, col=clb) #we now plot the colours in the array onto the plot

#now do for all the bands

clg <- colorRampPalette(c('dark green','green','light green'))(100) # 
plot(p224r63_2011$B2_sre, col=clg) # information for how much green is reflected in this area

clr <- colorRampPalette(c('dark red','red','pink'))(100) # 
plot(p224r63_2011$B3_sre, col=clr)




# Exercise: plot the final band, namely the NIR, band number 4
# red, orange, yellow
clnir <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(p224r63_2011$B4_sre, col=clnir)

#exercise - do it with a random colour scale
clpur <- colorRampPalette(c('darkorchid1','deeppink2','darkorchid4'))(100) 
plot(p224r63_2011$B4_sre, col=clpur)


#now we mount them together
#manner to mount them in a natural way, as you might see it with your eyes
#rgb colours - can only mount 3 bands at once in a single image
#assign each band to an element of rgb
#mount blue to blue, etc
#function is called plotRGB

dev.off() #use devoff to close the previous window and see only this image

#multilayered colours
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="lin" )   #r means red, g means green, etc
#stretch function stretches the values in order to see better the difference between the colours
#in this case we do a linear stretch

#one is to be removed to fit in the near infrared, b4, so the others scoot up

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") # this one has near infrared on top - now vegetation will be red
                                                    #you can see inside the forest this way
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") # in this one red and green have been inverted
                                                    #in this colour scheme all the bare soil will be violet - also called false colouring, as it is different from our eyes
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin") # b4 goes in the blue channel, this makes everything reflecting nir in blue
# this is powerful for detecting areas without vegetation. everything yellow is without vegetation
#eg. agricultural areas
#rectangular shapes will always be human intervention

#now we need to plot all these single frames in one multiframe

par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off() # close the multiframe

#histogram stretching
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist") # stretches the values so you can look inside the forest better
#for example seeing better openings in the forest and bare soil

#switch the different layers to see different things. 

#essential - time series. 
#see the changes over time in the same place

