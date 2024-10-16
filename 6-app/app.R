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
            selectInput("season", "Select season:", choices=c("All seasons", seasons), selected="All seasons")
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
    m <- leaflet(options = leafletOptions(attributionControl=FALSE)) %>%
      addProviderTiles("Esri.WorldImagery", group="Esri.WorldImagery") %>%
      addProviderTiles("Esri.WorldTopoMap", group="Esri.WorldTopoMap") %>%
      addPolygons(data=bnd, color='black', fill=F, weight=1, group='MCP + 15k')
      if (input$caribou=='All caribou' & input$season=='All seasons') {
        m <- m %>% addCircles(data=gps, fill=T, weight=1, stroke=F, fillColor='black', fillOpacity=1, group='Locations')
      } else if (input$caribou=='All caribou' & !input$season=='All seasons') {
        gps1 <- filter(gps, season==input$season)
        m <- m %>% addCircles(data=gps1, fill=T, weight=2, stroke=F, fillColor=~caribou_pal(id), fillOpacity=1, group='Locations')
      } else if (!input$caribou=='All caribou' & input$season=='All seasons') {
        gps1 <- filter(gps, id==input$caribou)
        m <- m %>% addCircles(data=gps1, fill=T, weight=2, stroke=F, fillColor=~season_pal(season), fillOpacity=1, group='Locations')
      } else {
        gps1 <- filter(gps, id==input$caribou & season==input$season)
        m <- m %>% addCircles(data=gps1, fill=T, weight=1, stroke=F, fillColor='black', fillOpacity=1, group='Locations')
      }
      m <- m %>% addLayersControl(position = "topright",
        baseGroups=c("Esri.WorldTopoMap", "Esri.WorldImagery"),
        overlayGroups = c('MCP + 15k', 'Locations'),
        options = layersControlOptions(collapsed = FALSE)) %>%
      hideGroup(c(''))
      m
  })

}
shinyApp(ui, server)
