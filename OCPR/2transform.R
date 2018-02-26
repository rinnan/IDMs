library(raster)
library(rgdal)
library(sp)
library(magrittr)

setwd("~/Google Drive/IDMs")
setwd("\\\\main.sefs.uw.edu\\main\\Space\\Lawler\\Shared\\Scott\\IDMs")
setwd("H:/IDMs")

ocpr <- readOGR("OCPR/Data", "ochotona_princeps")

states <- readOGR("Data/US_States", "states") %>% spTransform(crs(ocpr))
provs <- readOGR("Data/CAN_Provinces", "PROVINCE") %>% spTransform(crs(ocpr))


# rename historical rasters to order them properly; only need to do this once
hist.files <- list.files("Data/wc0.5", full.names = T)
hist.files.new <- sub(pattern = "bio([1-9])_", replacement = "bio0\\1_", x = hist.files)
file.rename(from = hist.files, to = hist.files.new)

# construct historical brick

hist.files <- list.files("Data/wc0.5", full.names = T, pattern = "11.bil$")
hist.br11 <- brick(as.list(hist.files))

hist.files <- list.files("Data/wc0.5", full.names = T, pattern = "12.bil$")
hist.br12 <- brick(as.list(hist.files))

hist.br <- merge(hist.br11, hist.br12)
names(hist.br) <- c("MAT", "MDR", "ISO", "TS", "HMmax", "CMmin", "TAR", "MTWQ", "MTDQ", "MTHQ", "MTCQ", 
                    "MAP", "PWM", "PDM", "PS", "PWQ", "PDQ", "PHQ", "PCQ")

# crop to ocpr distribution plus buffer region
ext <- extent(ocpr) + 10
#plot(ext,add=T)
hist.br.crop <- crop(hist.br, ext)

# save raster
writeRaster(hist.br.crop, filename = "OCPR/Data/Hist_OCPR.grd")

# construct future bricks

mg60bi50.files <- list.files("Data/cmip5/30s", full.names = T, pattern = "mg60bi50\\d+.tif$")
mg60bi50.files.new <- sub(pattern = "bi50([1-9]).tif", replacement = "bi500\\1.tif", x = mg60bi50.files)
file.rename(from = mg60bi50.files, to = mg60bi50.files.new)

mg60bi50.files <- list.files("Data/cmip5/30s", full.names = T, pattern = "mg60bi50\\d+.tif$")
ras <- list()
for(i in 1:length(mg60bi50.files)){
  print(i)
  temp <- raster(mg60bi50.files[i])
  ras[[i]] <- crop(temp, ext)
}
mg60bi50.br <- brick(ras)
names(mg60bi50.br) <- c("MAT", "MDR", "ISO", "TS", "HMmax", "CMmin", "TAR", "MTWQ", "MTDQ", "MTHQ", "MTCQ", 
                        "MAP", "PWM", "PDM", "PS", "PWQ", "PDQ", "PHQ", "PCQ")

writeRaster(mg60bi50.br, filename = "Data/mg60bi50_LALY.grd")



mg60bi70.files <- list.files("Data/cmip5/30s", full.names = T, pattern = "mg60bi70\\d+.tif$")
mg60bi70.files.new <- sub(pattern = "bi70([1-9]).tif", replacement = "bi700\\1.tif", x = mg60bi70.files)
file.rename(from = mg60bi70.files, to = mg60bi70.files.new)

mg60bi70.files <- list.files("Data/cmip5/30s", full.names = T, pattern = "mg60bi70\\d+.tif$")
ras <- list()
for(i in 1:length(mg60bi70.files)){
  print(i)
  temp <- raster(mg60bi70.files[i])
  ras[[i]] <- crop(temp, ext)
}
mg60bi70.br <- brick(ras)
names(mg60bi70.br) <- c("MAT", "MDR", "ISO", "TS", "HMmax", "CMmin", "TAR", "MTWQ", "MTDQ", "MTHQ", "MTCQ", 
                        "MAP", "PWM", "PDM", "PS", "PWQ", "PDQ", "PHQ", "PCQ")

writeRaster(mg60bi70.br, filename = "Data/mg60bi70_LALY.grd")


#############

fixPoly <- function(pgn){
  tp <- which(pgn@data$CODE == 0)
  if(length(tp) > 0){
    pgn[-tp,]} else
    {pgn}
}

laly <- fixPoly(laly)
plot(laly, col = "green")
laly.sp <- rasterize(x = laly, y = hist.br.crop, field = "CODE")
laly.sp <- rasterToPoints(laly.sp, spatial = T)
plot(laly.sp)
writeOGR(obj = laly.sp, dsn = "Data", layer = "LALY_points", driver = "ESRI Shapefile")


# .csv
hbr <- brick("Data/Hist_LALY.grd")
laly.sp <- rasterize(x = laly, y = hbr, field = "CODE")
laly.sp <- rasterToPoints(laly.sp)
laly.sp <- cbind("LALY", as.data.frame(laly.sp), stringsAsFactors = F)
write.csv(laly.sp[, -4], file = "Data/LALY_points.csv", row.names = F)
