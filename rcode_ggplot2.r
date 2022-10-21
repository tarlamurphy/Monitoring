##20/10/2022
#learning ggplot2

install.packages("ggplot2") #installs ggplot2 package

library(ggplot2) #opens ggplot2

virus <- c(10, 30, 40, 50, 60, 80)  #array of values measuring the virus in certain places
death <- c(100, 240, 310, 470, 580, 690) # array of values measuring deaths

plot(virus, death) #the old, simple way of doing it

#you can build a table where the data corresponds - called a dataframe

data.frame(virus, death) # puts the variables in a dataframe against each other

#because we want to use it, we assign the dataframe to an object so we can use the object

d <- data.frame(virus, death) #dataframe has been assigned to the object 'd, ready for more analysis

summary(d) #summary of the object, giving univariate statistical info

ggplot(d, aes(x = virus, y = death)) + #in ggplot, specify which data, the aesthetics are the variables we want to use
  geom_point(size = 2, col = "blue") # geom_point function creates scatterplots - this is to state we want to use points
#inside the geompoint fuction, you can change size/colour of the points. can still use pch for symbol
     
#can use geom_line to show lines connecting points
ggplot(d, aes(x = virus, y = death)) + 
  geom_line()

#can use geom_line and geom_point together
ggplot(d, aes(x = virus, y = death)) + 
  geom_point(col = "coral", size = 3) +
  geom_line()

#instead of line or point you can also use polygons
ggplot(d, aes(x = virus, y = death)) + 
  geom_point(col = "coral", size = 3) +
  geom_line() +
  geom_polygon(col = "orange")

     
###############

install.packages("spatstat") #install if necessary and load the required packages (
library(spatstat)
library(ggplot2)

#import data
#first create a folder in your computer
#put the data we will use in this folder - Lab

#set the working directory so r knows where to find the data
setwd()
#shortcut => session -> Set Working Directory -> Choose Directory -> ("~/Lab")

covid <- read.table("covid_agg.csv", header=TRUE, sep = ",") #to read the data table, name it and tell r that it does have headings
#sep = "," means that the data is displayed as comma-separated values
#assign the table to the object covid


