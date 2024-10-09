library(sf)
library(leaflet)
library(tidyverse)
library(shinydashboard)
library(shinycssloaders)
library(shinyjs)
library(terra)
library(maptiles)
options(shiny.maxRequestSize=100*1024^2) 

v <- vect('mcp15k.gpkg', 'mcp_buff15k')
bg <- get_tiles(v,
  crop = TRUE, provider = "Esri.WorldShadedRelief",
  zoom = 8, project = TRUE, cachedir = "."
)

ui = dashboardPage(skin="blue",
    dashboardHeader(title = "Little Rancheria"),
    dashboardSidebar(
        sidebarMenu(id="tabs",
            menuItem("Habitat", tabName = "habitat", icon = icon("th")),
            selectInput("model", "Model type:", choices=c("GLM","GLMM","RandomForest")),
            menuItem("Connectivity", tabName = "connectivity", icon = icon("th")),
            selectInput("type", "Map type:", choices=c("Cumulative current flow", "Flow potential", "Normalized current flow", "Categorized connectivity")),
            selectInput("c", "c-value", choices = c(0.25, 2, 8))
      )
    ),
  dashboardBody(
    useShinyjs(),
    tags$head(tags$style(".skin-blue .sidebar a { color: #8a8a8a; }")),
    tabItems(
      tabItem(tabName="habitat",
            fluidRow(
                tabBox(id = "one", width="12",
                    tabPanel("Habitat", plotOutput("map1", height=750)), #%>% withSpinner())
                    tabPanel("Connectivity", plotOutput("map2", height=750)) #%>% withSpinner())
                )
            )
        )
    )
  )
)

server = function(input, output, session) {


}
shinyApp(ui, server)
