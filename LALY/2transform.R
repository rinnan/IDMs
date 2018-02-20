library(raster)
library(maptools)
library(maps)
library(grid)
library(animation)
library(rgdal)

setwd("~/Google Drive/IDMs/LALY")
#setwd("\\\\main.sefs.uw.edu\\main\\Space\\Lawler\\Shared\\Scott\\IDMs\\LALY")
#setwd("H:/IDMs/LALY")

states <- readOGR("Data/US_States", "states") #,proj4string=CRS(projection(mat2020)))
provs <- readOGR("Data/CAN_Provinces", "PROVINCE") #, proj4string=CRS(projection(mat2020)))

laly <- readOGR("/Users/Darwin/Desktop/Work data/Tree distribution shapefiles", "larilyal")
crs(laly) <- crs(states)
