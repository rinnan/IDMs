library(raster)
library(maptools)
library(maps)
library(grid)
library(animation)
library(rgdal)

setwd("~/Google Drive/IDMs/LALY")
setwd("\\\\main.sefs.uw.edu\\main\\Space\\Lawler\\Shared\\Scott\\IDMs\\LALY")
setwd("H:/IDMs/LALY")


states <- readOGR("Data/US_States", "states") #,proj4string=CRS(projection(mat2020)))
provs <- readOGR("Data/CAN_Provinces", "PROVINCE") #, proj4string=CRS(projection(mat2020)))

laly <- readOGR("/Users/Darwin/Desktop/Work data/Tree distribution shapefiles", "larilyal")
crs(laly) <- crs(states)

# rename historical rasters to order them properly; only need to do this once
hist.files <- list.files("Data/wc0.5", full.names = T)
hist.files.new <- sub(pattern = "bio([1-9])_", replacement = "bio0\\1_", x = hist.files)
file.rename(from = hist.files, to = hist.files.new)

