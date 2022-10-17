#this is a code for investigating relationships among ecological variants

#install the needed package
install.packages("sp")

#retrieve the package within R
#the command require() can also be used for the same effect
library(sp)
#after clicking ctrl+enter nothing should happen, if something happens its an error

#we are dealing with the meuse dataset
#https://cran.r-project.org/web/packages/gstat/vignettes/gstat.pdf

data(meuse) #brings the dataset into r

meuse #very untidy way to view the dataset

View(meuse) #using the package Rcmdr to view the data - Case sensitive - Capital V

head(meuse) #gives a summary of the table with the headings and the first few rows

names(meuse) #shows only the names of the columns

summary(meuse) #quicker way to get the statistics, mean and median etc of each column

plot(meuse$cadmium, meuse$zinc) #to plot the x and y, need to isolate them within the meuse dataset

attach(meuse) #used often in datasets, easier than making objects or using $ function
#can also detach the dataset

#make a scatterplot matrix out of all the variables - 14x13 variables.
pairs(meuse) #a scatterplot matrix of all the interactions of each variables#

#Spatial R
#install the relevant package and find it in the library

install.packages("sp")
library(sp)

#get the dataset for meuse
data(meuse)
#look at the components of the dataset
head(meuse)

#
coordinates(meuse) = ~x+y

plot(meuse)

# spplot is used to plot elements like zinc, lead etc. spread in space
spplot(meuse, "zinc", main="Concentration of zinc")

meuse[,3:6] #this subsets the columns between 3 and 6
#this shows all the data, no matter what
pol <- meuse[,3:6] #the meuse object subset is assigned to the word pol

head(pol) #only shows the first 6 lines of pol

pairs(pol, col = "blue") #instead of showing all the pairs, just the ones contained in pol [pollution]

pairs(~cadmium + copper + lead + zinc,data=meuse) #the tilde (~) joins these non-numeric variables together

coordinates(meuse) = ~x+y # takes the x +y points of meuse, which is now a spatial dataset

#subsets: takes out the elements of choice
# spplot is used to plot elements like zinc, lead etc. spread in space
spplot(meuse, "zinc", main="Concentration of zinc") #main is the title of the plot

spplot(meuse, c("copper","zinc")) #this is an array, plotting several variables together. c is important when there are a number of variables

bubble(meuse, "zinc") #rather than using colours you can use bubbles that are sized by value


