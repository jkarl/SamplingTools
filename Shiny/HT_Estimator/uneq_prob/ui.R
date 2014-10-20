library(shiny)

# Define UI
shinyUI(pageWithSidebar(

  #App title
  headerPanel("Horwitz-Thompson Estimator for Unequal Probability Sampling"),
  
  # sidebar with controls
  sidebarPanel(
    fileInput('file1', h5('Choose CSV File'),
              accept=c('text/csv', 'text/comma-separated-values,text/plain')),
    tags$hr(),
    uiOutput("choose_indicator"),
    uiOutput("choose_weight"),
    uiOutput("choose_x"),
    uiOutput("choose_y"),
    uiOutput("choose_stratum_field"),
    uiOutput("choose_stratum"),
    img(src="http://jornada.nmsu.edu/sites/jornada.nmsu.edu/files/JornadaLogo.png")
  ),
  
  
  mainPanel(
    tabsetPanel(
      tabPanel('Instructions',HTML("Lorem ipsum...")),
      tabPanel('Input Data Table', h4("Input data table"), dataTableOutput('contents')),
      tabPanel('Results Table', h4(textOutput('title')), dataTableOutput('HTresults'), verbatimTextOutput('HVestimate'),plotOutput("boxPlot"))
    )
  )
))