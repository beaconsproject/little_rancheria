library(sf)
library(terra)
library(maptiles)
library(tidyverse)
library(tidyterra)

v <- vect('yt_caribou.gpkg', 'mcp_buff15k')

rgb_tile <- get_tiles(v,
  crop = TRUE, provider = "Esri.WorldShadedRelief",
  zoom = 8, project = TRUE, cachedir = "."
)

r1 <- rast('images/test.tif')
levels(r1) <- data.frame(value=1:4, connectivity=c("Impeded", "Diffuse", "Intensified", "Channelized"))
plotRGB(rgb_tile)
plot(r1, main="Early winter", col=c('#8dd3c7','#ffffb3','#bebada','#fb8072'), alpha=0.5, add=TRUE)

r2 <- rast('images/earlywinter_RF300_C200_R1000_T50/cum_currmap.tif')
plot(r2, breaks=10, breakby='cases')
