library(shiny)
library(datasets)
library(spsurvey)

data <- reactiveValues()

# Define server logic

shinyServer(function(input,output) {
  

  ##########################################################################
  ## Set up UI fields
  ##########################################################################
  output$choose_indicator <- renderUI({
    if(is.null(input$file1))
      return()
    
    inFile <- input$file1
    data$data1 = read.csv(inFile$datapath,header=TRUE)
    
    fields <- names(data$data1)
    selectInput("indicator", "Select Indicator Field", choices = fields)
  })

  output$choose_weight <- renderUI({
    if(is.null(input$file1))
      return()
    
    fields <- names(data$data1)
    selectInput("weight", "Select Weight Field", choices = fields)
  })
  
  output$choose_x <- renderUI({
    if(is.null(input$file1))
      return()
    
    fields <- names(data$data1)
    selectInput("x", "Select X-coordinate Field", choices = fields)
  })
  
  output$choose_y <- renderUI({
    if(is.null(input$file1))
      return()
    
    fields <- names(data$data1)
    selectInput("y", "Select Y-coordinate Field", choices = fields)
  })

  output$choose_stratum_field <- renderUI({
    if(is.null(input$file1))
      return()
    
    fields <- names(data$data1)
    selectInput("stratum_field", "Select Stratum Field", choices = cbind("none",fields),selected="none")
  })
  
  output$choose_stratum <- renderUI({
    if(is.null(input$file1))
      return()
    
    tst = input$stratum_field
    if(is.null(input$stratum_field))
      return()
    
    strata <- levels(data$data1[[input$stratum_field]])
    selectInput("stratum", "Select Stratum", choices = strata)
  })

  
  ##########################################################################
  ## Render input data table
  ##########################################################################
  output$contents <- renderDataTable({
    # assign input file
    if(is.null(input$file1))
      return(NULL)
    data$data1
  }, options=list(pageLength=10))
  
  output$title <- renderText({
    if(is.null(input$file1))
      return()
    if(input$stratum_field=="none")
      return("Horwitz-Thompson Estimates")
    else
      return(paste("Horwitz-Thompson Estimates for stratum ",input$stratum,sep=""))
  })
  
  ##########################################################################
  ## Calc estimators and output results
  ##########################################################################
  output$HVestimate <- renderPrint({
    if(is.null(input$file1))
      return()
    
    wgt <- 10000/data$data1[[input$weight]]
    ind <- data$data1[[input$indicator]]
    x <- data$data1[[input$x]]
    y <- data$data1[[input$y]]
    
    strata <- data$data1[[input$stratum_field]]
    stratum <- input$stratum
    if(input$stratum_field=="none")
      obs <- seq(1,length(data$data1[,1]))
    else
      obs <- which(data$data1[[input$stratum_field]]==stratum)
    
    total.est(ind[obs], wgt[obs], x=x[obs], y=y[obs], vartype="local")
  })
  
  
  
  
  #Generate plot
  output$boxPlot <- renderPlot({
    boxplot(as.formula(formulaText()),
            data = mpgData,
            outline = input$outliers)
  })
  
})