library(shiny)

# Define UI for application that calculates sample sizes and sampling sufficiency from a set of input data
shinyUI(fluidPage(
  
  #Application Title
  titlePanel("Sample Sufficiency Calculator"),
  
  #######################################################################################
  ## Sidebar for inputs and options
  #######################################################################################
  sidebarLayout(   #Tells Shiny that we're using a page layout with a Sidebar
    sidebarPanel(  #Initializes the sidebar
      fileInput("file1",h4("Load DIMA Indicator File"), multiple=FALSE),
      
      h4("Input Options"),
      uiOutput("ChooseStrata"),
      uiOutput("ChoosePlotID"),
      uiOutput("ChooseIndicatorField"),
      uiOutput("ChooseIndicator"),
      uiOutput("ChooseValueField"),
      HTML("<br>"),
      h4("Analysis Options"),
      #selectInput("AnalysisType","Analysis Type",c("Threshold Test","Two Independent Samples","Repeated Measures")),
      checkboxInput("PropData","Proportion Data?",value=FALSE),
      numericInput("MDD","Desired MDD (% change)",0.15,min=0.01,max=9999,step=0.01),
      numericInput("Alpha","Significance Level (Alpha)",0.05,min=0.01,max=0.99,step=0.01),
      numericInput("Rho","Intraobservation Correlation",0.6,min=0.0,max=0.99,step=0.01),
      
      HTML("<br>"),
      actionButton("goButton","Rerun Analysis")
      #h4("Output Options"),
      #sliderInput("bins","Number of Bins:",min=1,max=50,value=30)
      
      
      ),
  #######################################################################################
  ## Main panel for outputs
  #######################################################################################
  mainPanel(  #Initializes the main panel
    tabsetPanel(
      tabPanel('Instructions',HTML("Lorem ipsum...")),
      tabPanel('Input Data Table', dataTableOutput("DataTable")),
      tabPanel('Results Table', dataTableOutput("ssResults"),
               plotOutput("powerPlot"),
               HTML("<hr>"),
               downloadButton("downloadTable","Download Tabular Results"),
               downloadButton("downloadPlot","Save Plot to Image")
               )
      ),
    #HTML("<hr>"),
    #plotOutput("powerPlot"),

    HTML("<hr>"),
    wellPanel(h5("Output Messages"),
    textOutput("testText"))   
    )
  ) 
  ))