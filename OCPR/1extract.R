library(raster)

setwd("~/Google Drive/IDMs/LALY")
setwd("\\\\main.sefs.uw.edu\\main\\Space\\Lawler\\Shared\\Scott\\IDMs\\LALY")
setwd("H:/IDMs/LALY")

# Historical data: download by tile; need tiles 11 and 12
histmat <- getData("worldclim", var = "bio", res = 0.5, lon = -115, lat = 48, download = T, path = "Data")
histmat11 <- getData("worldclim", var = "bio", res = 0.5, lon = -125, lat = 48, download = T, path = "Data")


# Future data: MRI-CGCM3 scenario, RCP6.0 for 2050 and 2070
mg60bi50 <- getData("CMIP5", var = "bio", res = 0.5, download = T, path = "Data", model = "MG", year = 50, rcp = 60)
mg60bi70 <- getData("CMIP5", var = "bio", res = 0.5, download = T, path = "Data", model = "MG", year = 70, rcp = 60)

