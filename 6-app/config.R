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
  st_transform(4326)
gps <- rename(gps, id=id_var, season=season_var)
caribou <- unique(gps$id)
seasons <- unique(gps$season)
bnd <- st_read(caribou_gpkg, bnd_lyr, quiet=TRUE) |>
  st_transform(4326)
