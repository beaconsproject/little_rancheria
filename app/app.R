library(sf)
library(dplyr)
library(leaflet)
library(shinydashboard)
library(shinycssloaders)
library(shinyjs)
options(shiny.maxRequestSize=100*1024^2) 
source('config.R')

ui = dashboardPage(skin="blue",
    dashboardHeader(title = "Caribou Explorer"),
    dashboardSidebar(
        sidebarMenu(id="tabs",
            menuItem("Mapview", tabName = "mapview", icon = icon("th")),
            selectInput("caribou", "Select caribou:", choices=c("All caribou", caribou), selected="All caribou"),
            selectInput("season", "Select season:", choices=c("All seasons", seasons), selected="All seasons")#,
            #selectInput("season", "Select year:", choices=c("All years", years), selected="All years")
            #numericInput("size", "Size of gps locations", 1, min = 1, max = 5, step = 1)
      )
    ),
  dashboardBody(
    useShinyjs(),
    tags$head(tags$style(".skin-blue .sidebar a { color: #8a8a8a; }")),
    tabItems(
      tabItem(tabName="mapview",
            fluidRow(
                tabBox(id = "one", width="12",
                    tabPanel("Mapview", leafletOutput("map1", height=750) %>% withSpinner())
                )
            )
        )
    )
  )
)

server = function(input, output, session) {

  output$map1 <- renderLeaflet({
    season_pal <- colorFactor(topo.colors(5), gps$season)
    caribou_pal <- colorFactor(topo.colors(25), gps$id)
    #year_cols <- c('#ffffb2','#fecc5c','#fd8d3c','#f03b20','#bd0026')
    year_cols <- c('#2b83ba','#abdda4','#ffffbf','#fdae61','#d7191c')
    year_pal <- colorNumeric(palette=year_cols, domain=gps$year)
    m <- leaflet(options = leafletOptions(attributionControl=FALSE)) %>%
      addProviderTiles("Esri.WorldImagery", group="Esri.WorldImagery") %>%
      addProviderTiles("Esri.WorldTopoMap", group="Esri.WorldTopoMap") %>%
      addProviderTiles("Esri.WorldShadedRelief", group="Esri.WorldShadedRelief") %>%
      addProviderTiles("Esri.WorldGrayCanvas", group="Esri.WorldGrayCanvas") %>%
      addPolygons(data=bnd, color='black', fill=F, weight=1, group='MCP + 15k')
      
      # ALL CARIBOU + ALL SEASONS + ALL YEARS
      if (input$caribou=='All caribou' & input$season=='All seasons') {
        m <- m %>% addCircles(data=gps, fill=T, weight=1, stroke=F, fillColor='black', fillOpacity=1, group='Locations')
      
      # ALL CARIBOU + ONE SEASON + ALL YEARS
      } else if (input$caribou=='All caribou' & !input$season=='All seasons') {
        gps1 <- filter(gps, season==input$season)
        m <- m %>% addCircles(data=gps1, fill=T, radius=10, weight=1, stroke=F, fillColor=~year_pal(year), fillOpacity=1, group='Locations') %>%
          addLegend("topleft", colors=year_cols, labels=unique(gps$year), title="Year")
      
      # ONE CARIBOU + ALL SEASONS + ALL YEARS
      } else if (!input$caribou=='All caribou' & input$season=='All seasons') {
        gps1 <- filter(gps, id==input$caribou)
        m <- m %>% addCircles(data=gps1, fill=T, radius=50, weight=3, stroke=F, fillColor=~year_pal(year), fillOpacity=1, group='Locations') %>%
          addLegend("topleft", colors=year_cols, labels=unique(gps$year), title="Year")
      
      # ONE CARIBOU + ONE SEASON + ALL YEARS
      } else {
        gps1 <- filter(gps, id==input$caribou & season==input$season)
        #m <- m %>% addCircles(data=gps1, fill=T, weight=5, stroke=F, fillColor='black', fillOpacity=1, group='Locations')
        m <- m %>% addCircles(data=gps1, fill=T, radius=100, weight=5, stroke=F, fillColor=~year_pal(year), fillOpacity=1, group='Locations') %>%
          addLegend("topleft", colors=year_cols, labels=unique(gps$year), title="Year")
      }
      
      m <- m %>% addLayersControl(position = "topright",
        baseGroups=c("WorldGrayCanvas","Esri.WorldShadedRelief","Esri.WorldTopoMap", "Esri.WorldImagery"),
        overlayGroups = c('MCP + 15k', 'Locations'),
        options = layersControlOptions(collapsed = FALSE)) %>%
      hideGroup(c(''))
      m
  })

}
shinyApp(ui, server)
