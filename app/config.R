################################################################################
# USER-DEFINED PARAMETERS
################################################################################

# Name of caribou geopackage
caribou_gpkg <- 'caribou.gpkg'

# Name of caribou gps layer
gps_lyr <- 'gps'

# Name of "caribou IDs" attribute
id_var <- 'ID'

# Name of "season" attribute
season_var <- 'season'

# Name of boundary polygon
bnd_lyr <- 'mcp_buff15k'

################################################################################
# PLEASE DO NOT MODIFY THE FOLLOWING LINES
################################################################################

gps <- st_read(caribou_gpkg, gps_lyr, quiet=TRUE) |>
  st_transform(4326) |>
  rename(id=id_var, season=season_var) |>
  mutate(year=as.numeric(substr(timestamp,1,4)))
caribou <- sort(unique(gps$id))
seasons <- unique(gps$season)
#years <- unique(substr(gps$timestamp,1,4))
bnd <- st_read(caribou_gpkg, bnd_lyr, quiet=TRUE) |>
  st_transform(4326)
