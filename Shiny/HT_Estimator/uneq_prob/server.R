library(shiny)
library(datasets)
library(spsurvey)

data <- reactiveValues()

# Define server logic

shinyServer(function(input,output) {
  
  output$contents <- renderTable({
    
    # assign input file
    inFile <- input$file1
    
    if(is.null(inFile))
      return(NULL)
    
    data$data1 <- read.csv(inFile$datapath, header=input$header, sep=input$sep)
    
  })

  output$choose_indicator <- renderUI({
    if(is.null(input$file1))
      return()
    
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
    selectInput("stratum_field", "Select Stratum Field", choices = as.list(c("none",fields)))
  })
  
  output$choose_stratum <- renderUI({
    if(is.null(input$file1))
      return()
    
    if(input$stratum_field=="none")
      return()
    
    strata <- levels(data$data1[[input$stratum_field]])
    selectInput("stratum", "Select Stratum", choices = strata)
  })

  output$title <- renderText({
    if(is.null(input$file1))
      return()
    if(input$stratum_field=="none")
      return("Horwitz-Thompson Estimates")
    else
      return(paste("Horwitz-Thompson Estimates for stratum ",input$stratum,sep=""))
  })
  
  #calc estimators and print
  
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
  output$mpgPlot <- renderPlot({
    boxplot(as.formula(formulaText()),
            data = mpgData,
            outline = input$outliers)
  })
  
})