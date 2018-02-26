options(java.parameters = "-Xmx4g" )
library(dismo)
library(raster)
library(sp)

setwd("H:/IDMs/LALY")

hbr <- brick("Data/Hist_LALY.grd")

laly <- readOGR("Data", "LALY_points")

samp <- sample(length(laly), 5000)
laly.samp <- laly[samp,]

mod1 <- maxent(x = hbr, p = laly.samp, path = "Data/maxent", nbg = 10000)
# Training AUC = 0.818

# removing MAT, HMmax, PWQ, MDR, PCQ, MTDQ
hbr.2 <- subset(hbr, c( "ISO", "TS", "CMmin", "TAR", "MTWQ", "MTHQ", "MTCQ", 
                       "MAP", "PWM", "PDM", "PS", "PDQ", "PHQ"))

mod2 <- maxent(x = hbr.2, p = laly.samp, path = "Data/maxent", nbg = 10000)

