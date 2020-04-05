# ui.R
library(shiny)
library(plotly)

# Define a variable `map_sidebar_content` that is a `sidebarPanel()` for your
# first (map) page that contains:
map_sidebar_content <- sidebarPanel(
  
  # An input to select variable to map
  selectInput(
    inputId = "map_var",
    label = "Variable to Map",
    choices = list(
      "Population" = "population",
      "Electoral Votes" = "votes",
      "Votes / Population" = "ratio"
    )
  )
)

# Define a variable `map_main_content` that is a `mainPanel()` for your
# first (map) page that contains the `plotlyOutput()` of your map
map_main_content <- mainPanel(
  plotlyOutput(outputId = "map")
)

# Create a variable `map_panel` that stores a `tabPanel()` for your first page
# It should include the following:
map_panel <- tabPanel(
  "Map",
  
  # Add a titlePanel to your tab
  titlePanel("Electoral College Votes"),
  
  # A `sidebarLayout()` that contains...
  sidebarLayout(

    # Your `map_sidebar_content`
    map_sidebar_content,
    
    # Your `map_main_content`
    map_main_content
  )
)

# Define a variable `scatter_sidebar_content` that is a `sidebarPanel()` for 
# your second (scatter) page that contains:
# - a `textInput()` widget for searching for a state in your scatter plot
scatter_sideband_content <- sidebarPanel(
  textInput(
    inputId = "search",
    label = "Find a State",
    value = ""
  )
)

# Define a variable `scatter_main_content` that is a `mainPanel()` for your
# second (scatter) page that contains the `plotlyOutput()` of your scatter
scatter_main_content <- mainPanel(
  plotlyOutput(outputId = "scatter")
)

# Create a variable `scatter_panel` that stores a `tabPanel()` for your 2nd page
# It should include the following:
scatter_panel <- tabPanel(
  "Scatter",
  
  # Add a titlePanel to your tab
  titlePanel("Population v.s. Vote Power"),
  
  # Create a sidebar layout for this tab (page)
  sidebarLayout(
    
    # Display your `scatter_sidebar_content`
    scatter_sideband_content,
    
    # Display your `scatter_main_content`
    scatter_main_content
  )
)
    
# Define a variable `ui` storing a `navbarPage()` element containing
# your two pages defined above
ui <- navbarPage(
  "Electoral College",
  map_panel,
  scatter_panel
)
