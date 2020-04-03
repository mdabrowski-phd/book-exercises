# Libraries
library(plotly)
library(shiny)

# ui.R
ui <- fluidPage(
  mainPanel(
    # Add a selectInput that allows you to select a variable to map
    selectInput(
      inputId = "map_var",
      label = "Variable to Map", 
      choices = list("Population" = "population", 
                     "Electoral Votes" = "votes", 
                     "Votes per 100k Population" = "ratio"
                     )
    ),
    
    # Use `plotlyOutput()` to show your map
    plotlyOutput(outputId = "map")
  )
)