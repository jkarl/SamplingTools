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
      tabPanel('Instructions',h4("Background"),
               div("The Horwitz-Thompson Estimator tool can be used to produce indicator estimates from survey data either 1) for a study area without strata or 2) within a stratum. Sample points can be individually weighted (i.e., unequal probability sampling) or unweighted (most typical).")),
      tabPanel('Input Data Table', h4("Input data table"), dataTableOutput('contents')),
      tabPanel('Results Table', h4(textOutput('title')), dataTableOutput('HTresults'), verbatimTextOutput('HVestimate'),plotOutput("boxPlot"))
    )
  )
))