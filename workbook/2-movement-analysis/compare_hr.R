library(sf)
library(dplyr)

# Merge 95% home range estimates
gps <- st_read('data/yt_caribou.gpkg', 'gps')
iakde <- NULL # for individual MCPs
akde <- NULL # for merged MCPs
for (i in 1:25) {
  akde1 <- st_read('data/yt/ew_hranges.gpkg', paste0('caribou',i))
  id <- substr(akde1$name[2], 1, 5)
  akde1_est <- filter(akde1, name==paste0(id, ' 95% est'))
  if (i==1) {
    iakde <- akde1_est
    akde <- akde1_est
  } else {
    iakde <- rbind(iakde, akde1_est)
    akde <- st_union(akde, akde1_est)
  }
}

# Modify fields
akde <- st_cast(akde, 'POLYGON') |>
  select(name) |>
  mutate(name='Little Rancheria')
iakde <- st_cast(iakde, 'MULTIPOLYGON') |>
  mutate(id=substr(name, 1, 5), name=NULL)

# Save
st_write(iakde, 'data/yt_caribou.gpkg', 'iakde', delete_layer=TRUE)
st_write(akde, 'data/yt_caribou.gpkg', 'akde', delete_layer=TRUE)
