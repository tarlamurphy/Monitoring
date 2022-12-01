
################################
# SPECTRAL INDICES

library(raster)
library(RStoolbox)

#upload the data - 1992 and 2006 pictures of Brazil - deforestation in a region of the amazon

l1992 <- brick("defor1.png") #unknown extent means they have no reference system, but n this case is ok
l1992 #look at the bands - Bands: 1 NIR, 2 red, 3 green


plotRGB(l1992, r=1, g=2, b=3, stretch='lin')

#use the near infra red as it is very sensitive to changes and shows up well in vegetation

l2006 <- brick("defor2.png")
l2006

plotRGB(l2006, r=1, g=2, b=3, stretch='lin')

# plot one on top of the other
par(mfrow=c(2,1)) # 2 rows 1 column
plotRGB(l1992, r=1, g=2, b=3, stretch='lin')
plotRGB(l2006, r=1, g=2, b=3, stretch='lin')

#look at the dvi - differenciated vegetation index
#remember: nir - red = dvi

dvi1992 <- l1992[[1]] - l1992[[2]]
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)
plot(dvi1992, col = cl)

dvi2006 <-l2006[[1]] - l2006[[2]]
plot(dvi2006, col = cl)

#classify the images
library(ggplot2)
library(RStoolbox) # for classification
#install.packages("patchwork")
library(patchwork) # for grid arrange plotting

#unsupervised classification is when we do not state the threshhold, the software decides itself
d1c <- unsuperClass(l1992, nClasses=2) # d1c = deforestation 1st period classification
plot(d1c$map) #only 2 classes in this map - we can know the amount of pixels containing vegetation or other

#how to know the amount of things that have changed in time
freq(d1c$map) #shows for class 1:human impact+water and class 2: forest
#1: 34597
#2: 306695

#proportion
34597/(306695 + 34597)
# 0.1013707
1 - 0.1013707
#so in 1992 the area was 89.86% forest
f1992 <- 306695/(306695 + 34597)
h1992 <- 34597/(306695 + 34597)

#and now the same process for 2006 - watch out for the classes
d2c <- unsuperClass(l2006, nClasses=2)
plot(d2c$map)
freq(d2c$map)
#forest:value 1: 179281
#human impact: value 2: 163445

#proportion
179281/(179281 + 163445)
#forest made up 52.31% of the area

f2006 <- 179281/(179281 + 163445)
h2006 <- 163445/(179281 + 163445)

############################################

#make a table - function is called data.frame

#will be 3 columns - class:forest, human impacts, then proportions for 1992 and 2006
landcover <- c("Forest", "Humans")  # array of two text elements
percent_1992 <- c(89.86, 10.13)
percent_2006 <- c(52.31, 47.68)

percentages <- data.frame(landcover, percent_1992, percent_2006)
percentages

library(ggplot2) #to manage the aethetics of the plot

p1 <- ggplot(percentages, aes(x=landcover, y=percent_1992, color=landcover)) +
  geom_bar(stat="identity", fill="darkseagreen")

p2 <- ggplot(percentages, aes(x=landcover, y=percent_2006, color=landcover)) + 
  geom_bar(stat="identity", fill="darkseagreen")

# first in ggplot, you put the name of the object to be plotted,
# aes explains how you will build the histogram
# we are using geom_bar to make bars for the histogram
# we are using the identity, which corresponds to the numbers

#now to put them all in the same graph
# use a package called patchwork to make a multiframe

library(patchwork)

# go back and assign the plots to an object eg p1 and p2 
# add them together

p1 + p2

# now put one plot on top of the other

p1 / p2

# ggplot examples
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

ggRGB(l1992, 1, 2, 3) # plot using gg instead

library("viridis")

dev.off()
dvi1992 = l1992[[1]] - l1992[[2]] #get the dvi
plot(dvi1992)

ggplot() + geom_raster(dvi1992, mapping =aes(x=x, y=y, fill=layer)) + # we want to make a plot, using raster data, check inside the object dvi to find which
  scale_fill_viridis(option="magma") + # using the viridis colour scheme and function
  ggtitle("DVI 1992")

ggplot() + geom_raster(dvi2006, mapping =aes(x=x, y=y, fill=layer)) + # we want to make a plot, using raster data, check inside the object dvi to find which
  scale_fill_viridis(option="viridis") + # using the viridis colour scheme and function
  ggtitle("DVI 2006")


#exercise: with the patchwork package put 2 graphs one beside the other with 2 different viridis colour schems

gp1 <- ggplot() + geom_raster(dvi1992, mapping =aes(x=x, y=y, fill=layer)) + # we want to make a plot, using raster data, check inside the object dvi to find which
  scale_fill_viridis(option="magma") + # using the viridis colour scheme and function
  ggtitle("DVI 1992")

gp2 <- ggplot() + geom_raster(dvi2006, mapping =aes(x=x, y=y, fill=layer)) + # we want to make a plot, using raster data, check inside the object dvi to find which
  scale_fill_viridis(option="viridis") + # using the viridis colour scheme and function
  ggtitle("DVI 2006")

gp1 + gp2



