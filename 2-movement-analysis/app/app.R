library(sf)
library(terra)
library(shiny)
library(tidyverse)
#library(maptiles)

#opentopomap <- create_provider(
#  name = "otm",
#  url = "https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png",
#  sub = c("a", "b", "c"),
#  citation = "map data: @ OpenStreetMap contributors, SRTM | map style: @ OpenTopoMap (CC-BY-SA)"
#)

caribou <- sort(c("43161","43147","43146","43144","43159","43141","43158",
  "43164","43150","43154","43145","43143","43140","43155","43156","43160",
  "43152","43148","43151","43142","43149","43162","43153","43157","43163"))
bnd <- st_read('yt_caribou.gpkg', 'mcp_buff15k') |>
  st_transform(4326)
bnd <- vect(bnd)
bnd50 <- buffer(bnd, 50000)
#bg <- get_tiles(ext(bnd), provider=opentopomap)
#bg <- crop(bg, bnd50)
pts <- st_read('yt_caribou.gpkg', 'gps') |>
  st_transform(4326)

ui <- fluidPage(
  titlePanel("Little Rancheria Caribou Herd"),
  sidebarLayout(
    sidebarPanel(
      selectInput("id", "Collar ID:", choices = caribou),
      checkboxInput('type', 'Confidence intervals', value = FALSE, width = NULL)
    ),
    mainPanel(
      plotOutput(outputId = "distPlot", width = "100%", height = "600px")
    )
  )
)

server <- function(input, output) {

  akde <- reactive({
    x <- readRDS(paste0('home_ranges/akde_',input$id,'.RDS'))
  })

  akde_ud <- reactive({
    x <- rast(paste0('home_ranges/akde_',input$id,'.tif'))
  })

  output$distPlot <- renderPlot({
    if (input$type) {
      hr_isopleths(akde()) |> 
        mutate(type = case_when(
          what == "estimate" ~ "Estimate",
          TRUE ~ "Conf. Int.")) |> 
        ggplot() +
        geom_raster(data = as.data.frame(akde_ud(), xy = TRUE),
                    aes(x = x, y = y, fill = layer)) +
        geom_point(data = akde()$data, aes(x = x_, y = y_),
                   color = "gray30", alpha = 0.5) +
        geom_sf(aes(linetype = type, linewidth = type), color = "blue", fill = NA) +
        xlab(NULL) +
        ylab(NULL) +
        scale_linetype_manual(name = "aKDE",
                              breaks = c("Estimate", "Conf. Int."),
                              values = c("solid", "dashed")) +
        scale_linewidth_manual(name = "aKDE",
                          breaks = c("Estimate", "Conf. Int."),
                          values = c(1.75, 0.75)) +
        scale_fill_viridis_c(name = "aKDE UD", option = "A") +
        theme_bw()
    } else {
      pts1 <- filter(pts, ID==input$id)
      r=project(akde_ud(), "+proj=longlat +datum=WGS84") |>
        crop(bnd) |>
        mask(bnd)
      #plotRGB(bg)
      plot(r, alpha=0.5) #, add=TRUE)
      lines(bnd, col="blue", lwd=3)
      points(pts1, pch=20, col="black", cex=1)
    }
  })
}

shinyApp(ui = ui, server = server)
