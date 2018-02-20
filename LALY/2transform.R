library(raster)
library(maptools)
library(maps)
library(grid)
library(animation)
library(rgdal)

states <- readOGR("/Users/Darwin/Google Drive/Shapefiles/US_States", "states") #,proj4string=CRS(projection(mat2020)))
provs <- readOGR("/Users/Darwin/Google Drive/Shapefiles/CAN_Provinces", "PROVINCE") #, proj4string=CRS(projection(mat2020)))

laly <- readOGR("/Users/Darwin/Desktop/Work data/Tree distribution shapefiles", "larilyal")
crs(laly) <- crs(states)
