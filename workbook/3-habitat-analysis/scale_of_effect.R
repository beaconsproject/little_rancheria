# Influence of buffer size on caribou response to human disturbance
# Pierre Vernier
# 2024-09-01

library(sf)
library(terra)
library(tidyverse)


# Create a distance to human disturbance raster (linear + areal)
bpdata <- 'C:/Users/PIVER37/Documents/github/beaconsproject/geopackage_creator/www/bp_datasets.gpkg'
bnd <- st_read('data/yt_caribou.gpkg', 'mcp_buff15k')
nalc <- rast('data/raster30/nalc2020.tif')
rast30m <- subst(nalc, 1:19, 1)
line <- vect(bpdata, 'sd_line') |>
  crop(vect(bnd)) |>
  rasterize(rast30m)
line <- subst(line, NA, 0)
line <- mask(line, rast30m)
poly <- vect(bpdata, 'sd_poly') |>
  crop(vect(bnd)) |>
  rasterize(rast30m)
poly <- subst(poly, NA, 0)
poly <- mask(poly, rast30m)
polyline <- line + poly
polyline <- subst(polyline, 2, 1)
#polyline0 <- subst(polyline, NA, 0) # needed to avoid boundary issues with distance

# Create landcover proportion of neighbourhood variable
cv <- 'shrubland'
dir.create(paste0('output/scale/',cv,'/'), recursive=TRUE)
x <- rast('data/raster30/landcov.tif')[[cv]]

# For each season
for (sea in c('earlywinter','latewinter','summer','fallrut')) {
  cat('Season:',sea,'\n'); flush.console()
  
  # Select seasonal locations
  gps <- st_read('data/yt_caribou.gpkg', 'gps_vars') |>
    filter(season==sea) |>
    select(individual, occurrence)

  # For each buffer size
  buffer_list <- seq(3,70,4)
  dist_tib <- tibble(buffer=buffer_list*30, b1=0, se=0, z=0, p=0, aic=0)
  for (i in 1:length(buffer_list)) {
    cat('...buffer size:', buffer_list[i], '\n'); flush.console()
    lp_buff <- terra::focal(x , buffer_list[i])
    xdata <- terra::extract(lp_buff, gps, ID=FALSE)
    xdata$focal_sum <- xdata$focal_sum/buffer_list[i]^2
    gpsx <- cbind(gps, xdata) |> rename(disturbance=focal_sum)
    model <- glm(occurrence ~ disturbance, family=binomial, data=gpsx)
    dist_tib$buffer[i] <- i*30
    dist_tib$b1[i] <- coef(model)[2]
    dist_tib$se[i] <- summary(model)$coefficients[[4]]
    dist_tib$z[i] <- summary(model)$coefficients[[6]]
    dist_tib$p[i] <- summary(model)$coefficients[[8]]
    dist_tib$aic[i] <- AIC(model)
  }
  
  # Save seasonal table
  dist_tib <- mutate(dist_tib, daic=aic-min(aic))
  write_csv(dist_tib, paste0('output/scale/',cv,'/',sea,'.csv'))
  
  # Save seasonal b1+se plot
  ggplot(dist_tib, aes(x = buffer, y = b1, group = 1)) +
    geom_point(size = 3) +
    geom_line() +
    geom_errorbar(aes(ymin = b1 - se, ymax = b1 + se), width = .1)
  ggsave(paste0('output/scale/',cv,'/',sea,'_b1.png'))
  
  # Save seasonal dAIC plot
  ggplot(dist_tib, aes(x = buffer, y = daic, group = 1)) +
    geom_point(size = 3) +
    geom_line()
  ggsave(paste0('output/scale/',cv,'/',sea,'_aic.png'))
}

