library(shiny)
library(xlsx)

a <- reactiveValues()

#Define server logic for Shiny app
shinyServer(function(input,output) {
 
  #######################################################################################
  ## Load the data and display messages for errors
  #######################################################################################
  output$testText <- renderPrint({
    infile = input$file1
    
    if(is.null(infile))
      return("No file selected.")
    
    if(infile$type=="text/csv") {
      a$data = read.csv(infile$datapath,header=TRUE)
    } else {
      if(infile$type=="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
        a$data = read.xlsx(infile$datapath,sheetName="Line Totals")
      } else {
        return(paste("Cannot load file type:",infile$type,sep=' '))
      }
    }    
    return("Data file successfully loaded.")
    
  })
  
  #######################################################################################
  ## Finish UI Setup - populate combo boxes depending on file upload
  #######################################################################################
  output$ChooseStrata <- renderUI({
    if(is.null(input$file1))
      { fields <- '' }
    else
    { fields <- names(a$data) }
    selectInput("StrataField", "Strata Field", choices = cbind("None",fields), multiple=FALSE,selected="Site")
  })
  
  output$ChoosePlotID <- renderUI({
    if(is.null(input$file1))
    { fields <- '' }
    else
    { fields <- names(a$data) }
    selectInput("PlotIDField", "Plot ID Field", choices = cbind("None",fields),selected="Plot")
  })
  
  output$ChooseIndicatorField <- renderUI({
    if(is.null(input$file1))
    { fields <- '' }
    else
    { fields <- names(a$data) }
    selectInput("IndicatorField", "Field with Indicator Values", choices = (fields),selected="Indicator")
  })
  
  output$ChooseIndicator <- renderUI({
    if(is.null(input$file1))
      { fields <- ''}
    else
    { if(is.null(input$IndicatorField))
      { fields <- '' }
      else
      { fields <- levels(a$data[[input$IndicatorField]])
      selectInput("Indicator","Select Indicator",choices=(cbind("All",fields)))}
    }
  })
  
  output$ChooseValueField <- renderUI({
    if(is.null(input$IndicatorField)) {
      fields <- ''
    } else {
      fields <- names(a$data)
    }
    selectInput("Values","Indicator Value Field",choices=fields)
  })

  
  #######################################################################################
  ## Run the sample sufficiency calculations and display the results as a table
  #######################################################################################
  
  ## Display the loaded data table
  output$DataTable <- renderDataTable({
    if(is.null(input$file1)) {
      return(NULL)
    }
    a$data
    }, options = list(pageLength = 10))
  
  ## Display the sample sufficiency analysis results
  output$ssResults <- renderDataTable({
    
  }, options=list(pageLength=10))
  
  ## Display the power analysis results
  output$powerPlot <- renderPlot({
    x <- faithful[,2]
    bins <- seq(min(x),max(x),length.out=input$bins+1)
    hist(x,breaks=bins,col="darkgray",border='white')
  })
  
  
})