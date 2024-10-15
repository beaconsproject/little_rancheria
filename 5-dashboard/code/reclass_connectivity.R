library(sf)
library(terra)
library(maptiles)
library(tidyverse)
library(tidyterra)

folder <- list.dirs('omniscape300')[-1]

# Get tile
v <- vect('yt_caribou.gpkg', 'mcp_buff15k')
rgb_tile <- get_tiles(v,
  crop = TRUE, provider = "Esri.WorldShadedRelief",
  zoom = 8, project = FALSE, cachedir = "."
)

# Reclass normalized_cum_currmap
m <- c(0, 0.7, 1,
       0.7, 1.3, 2,
       1.4, 1.7, 3,
       1.7, 9999, 4)
rclmat <- matrix(m, ncol=3, byrow=TRUE)
for (i in folder) {
  print(i); flush.console()
  r <- rast(paste0(i,'/normalized_cum_currmap.tif'))
  rc <- as.factor(classify(r, rclmat, include.lowest=TRUE))
  writeRaster(rc, paste0(i,'/categorized_connectivity.tif'))
}

# Generate plots and save as png files
for (i in folder) {
  for (j in c('cum_currmap', 'flow_potential', 'normalized_cum_currmap', 'categorized_connectivity')) {
    cat(i, ' --- ', j, '\n'); flush.console()
    r = rast(paste0(i, '/', j, '.tif'))
    if (j=='categorized_connectivity') {
      p <- ggplot(v) +
        geom_spatraster_rgb(data=rgb_tile, alpha=1) +
        geom_spatraster(data=as.factor(r)) +
        #geom_spatvector(fill=NA) +
        coord_sf(expand=FALSE) +
        scale_fill_whitebox_d(palette = "muted", alpha = 0.5, labels = c("Impeded", "Diffuse", "Intensified", "Channelized")) +
        theme_minimal() +
        labs(fill="Category", title = "Early winter")
    } else {
      p <- ggplot() +
        geom_spatraster(data = r) +
        scale_fill_grass_c("inferno") +
        theme_grey() + labs(title="Early winter")
    }
    png(paste0(i, '/', j, '.png'))
    print(p)
    dev.off()
  }
}
