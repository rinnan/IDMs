options(java.parameters = "-Xmx4g" )
library(dismo)
library(raster)

setwd("H:/IDMs")

hbr <- brick("OCPR/Data/Hist_OCPR.grd")

ocpr <- readOGR("OCPR/Data", "ochotona_princeps")
ocpr.pt <- read.csv("H:/Conservation investment paper/Species Occurrences/Mammals/Ochotona princeps occurrence.csv")
ocpr.sp <- SpatialPoints(ocpr.pt) %>% crop(extent(ocpr))

mod1 <- maxent(x = hbr, p = ocpr.sp, path = "OCPR/Data/maxent1")

# removing PDQ, MTCQ, MTDQ, PWQ, PS, PWM, MAP, MDR  
hbr.2 <- subset(hbr, c( "ISO", "TS", "CMmin", "TAR", "MTWQ", "MTHQ", 
                        "PDM", "PHQ", "MAT", "HMmax", "PCQ"))

mod2 <- maxent(x = hbr.2, p = ocpr.sp, path = "OCPR/Data/maxent2")
ocpr.predict <- predict(mod2, hbr.2, filename = "OCPR/Data/OCPR_predict_hist_prob.grd")
