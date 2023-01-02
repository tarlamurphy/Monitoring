## R Stats Project - Piero Zannini Class
## January 2023
## Global Change Ecology and Sustainable Development Goals
## Tarla Murphy, Lola Neuert, Emilija Zubac

# Measurement data of polar bears captured in the Chukchi
# and Southern Beaufort seas, 1981 - 2017

### Data
# Data is available from the Alaska Science Center at https://alaska.usgs.gov/products/data.php?dataid=315
# alternatively from data.world at https://data.world/us-doi-gov/581f789d-efa1-45db-a542-4812bed49004
# Data is made available by the Department of the Interior, US Government

### Data Upload
# set working directory, eg. setwd("~/R_Stats")

polar <- read.csv("polar.csv", header = TRUE)
head(polar)


