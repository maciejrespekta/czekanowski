

library(shiny)
library(tidyverse)
library(readr)
library(sf)
library(leaflet)
library(geosphere)  # For smooth great-circle paths

# Function to generate smooth great-circle segments
generate_gc_lines <- function(lon, lat, n = 50) {
  gc_list <- list()
  
  for (i in 1:(length(lon) - 1)) {
    segment <- gcIntermediate(
      p1 = c(lon[i], lat[i]),  # Start point
      p2 = c(lon[i + 1], lat[i + 1]),  # End point
      n = n, 
      addStartEnd = TRUE
    )
    
    # Convert to data frame
    segment_df <- as.data.frame(segment)
    segment_df$group <- i  # Add group identifier
    
    gc_list[[i]] <- segment_df
  }
  
  # Combine all segments into one data frame
  gc_data <- bind_rows(gc_list)
  
  return(gc_data)
}


ui <- fluidPage(
  
  tags$head(
    tags$style(HTML("
    html, body {
      height: 100%;
      width: 100%;
      margin: 0;
      padding: 0;
      overflow: hidden;
    }
    .container-fluid {
      padding: 0 !important;
      margin: 0 !important;
      width: 100% !important;
    }
    #map {
      height: 100vh;
      width: 100vw;
      position: absolute;
      top: 0;
      left: 0;
    }
  "))
  ),
  leafletOutput("map", width = "100%", height = "100%")
)



# Define UI for application that draws a histogram
ui <- fluidPage(
  #tags$style(type = "text/css", "html, body {width:100%;height:100%;}"),
  # Application title
  #titlePanel("Podróż Jana Czekanowskiego"),
  tags$style(HTML("
    html, body {
      height: 100%;
      width: 100%;
      margin: 0;
      padding: 0;
      overflow: hidden;
    }
    .container-fluid {
      padding: 0 !important;
      margin: 0 !important;
      width: 100% !important;
    }
    #map {
      height: 100vh;
      width: 100vw;
      position: absolute;
      top: 0;
      left: 0;
    }
            #title-overlay {
          position: absolute;
          bottom: 10px;
          left: 10px;
          background-color: rgba(255, 255, 255, 0.8);
          padding: 10px 15px;
          border-radius: 5px;
          font-size: 18px;
          font-weight: bold;
          z-index: 1000; /* Ensure it stays on top of the map */
      }
        ")),
  # Title overlay
  div(id = "title-overlay", "Podróż Jana Czekanowskiego"),
  leafletOutput("map", width = "100%", height = "100%")
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  czekanowski_clean <- read_csv("Jan_Czekanowski.csv") %>%
    drop_na(Data, Nazwa, GPS) %>%
    mutate(GPS = str_remove_all(GPS, "\\(|\\)")) %>%  # Remove parentheses
    separate(
      GPS,
      into = c("latitude", "longitude"),
      sep = ", ",
      convert = TRUE  # Automatically converts to numeric
    ) 
  
  
  czekanowski_sp <-  czekanowski_clean %>%
    st_as_sf(coords = c("longitude", "latitude"), crs = 4326)
  

  
  # Get smoothed lines
  gc_data <- generate_gc_lines(czekanowski_clean$longitude, czekanowski_clean$latitude)
  
  # Convert to sf object
  gc_sf <- st_as_sf(gc_data, coords = c("lon", "lat"), crs = 4326)
  
  gc_line <- gc_sf %>%
    summarise(geometry = st_combine(geometry)) %>%  # Combine points
    st_cast("LINESTRING")  # Convert to LINESTRING
  
  
  output$map <- renderLeaflet({
    leaflet(data = czekanowski_sp) %>%
      addTiles(group = "OpenStreetMap") %>%
      addProviderTiles("CartoDB.Positron", group = "CartoDB Positron") %>%
      addProviderTiles("Esri.WorldImagery", group = "Esri World Imagery") %>%
      addProviderTiles("Esri.WorldTopoMap", group = "Esri Topographic") %>%
      addProviderTiles("OpenTopoMap", group = "OpenTopoMap") %>%
      addProviderTiles("Esri.WorldImagery", group = "Esri Satellite") %>%
      addMarkers(data = czekanowski_sp, popup = ~paste("<b>", Nazwa, "</b><br>", Data)) %>%
      addPolylines(data = gc_line, color = "blue", weight = 3, opacity = 0.8, dashArray = "5,5") %>%
      addLayersControl(
        baseGroups = c("OpenStreetMap", 
                       "CartoDB Positron", 
                       "Esri World Imagery",
                       "Esri Topographic", 
                       "OpenTopoMap",
                       "Esri Satellite"),
        options = layersControlOptions(collapsed = FALSE)
      )
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)