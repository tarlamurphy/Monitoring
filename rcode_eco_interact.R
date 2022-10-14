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
pairs(meuse) #a scatterplot matrix of all the interactions of each variables

