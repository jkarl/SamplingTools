library(shiny)

# Define UI
shinyUI(pageWithSidebar(

  #App title
  headerPanel("Horwitz-Thompson Estimator of Unequal Probability Sampling"),
  
  # sidebar with controls
  sidebarPanel(
    fileInput('file1', h5('Choose CSV File'),
              accept=c('text/csv', 'text/comma-separated-values,text/plain')),
    tags$hr(),
    checkboxInput('header', h5('Header'), TRUE),
    br(),
    radioButtons('sep', h5('Separator'),
                 c(Comma=',',
                   Semicolon=';',
                   Tab='\t'),
                 'Comma'),
    tags$hr(),
    uiOutput("choose_indicator"),
    uiOutput("choose_weight"),
    uiOutput("choose_x"),
    uiOutput("choose_y"),
    uiOutput("choose_stratum_field"),
    uiOutput("choose_stratum")
  ),
  
  
  mainPanel(
    
    h4(textOutput('title')),
    verbatimTextOutput('HVestimate'),
    
    h4("Input data table"),
    tableOutput('contents')
    )
))