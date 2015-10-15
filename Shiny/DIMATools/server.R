library(shiny)
library(sqldf)

# List all tables in the MDB
# tables <- read.table(pipe("mdb-tables -d '|' '/Users/Jason/Desktop/NorCal 2013 3.1.mdb'"),sep="|",header=TRUE)

options(shiny.maxRequestSize = 50*1024^2)

shinyServer(function(input,output) {
  
  dima <- reactiveValues()
  
  observe({
    # read input file
    inFile <- input$infile
    if(is.null(inFile))
      return(NULL)
    tables <- c("tblPlots","tblSites","tblPeople")
    for (table in tables) {
      table <- tables[i]
      read.string <- paste("mdb-export -d '|' '",datapath,"' ",table,sep="")
      print(read.string)
      assign(paste(table),read.table(pipe(read.string),sep="|",header=TRUE))
    }
    dima$tblPlots <- tblPlots
    dima$tblSites <- tblSites
    dima$tblPeople <- tblPeople
    #read.string <- paste("mdb-export -d '|' '",inFile$datapath,"' tblPlots",sep="")
    #print(read.string)
    #data$table <- read.table(pipe(read.string), sep="|", header=TRUE)
  })
  
  output$test <- renderPrint({
    print(tblSites[1:10,1:5])
  })
  
  output$tableView <- renderDataTable({
    switch(input$selTable,
      tblPlots = dima$tblPlots,
      tblSites = dima$tblSites,
      tblPeople = dima$tblPeople)
  }, options=list(pageLength=10))
  
  output$queryView <- renderDataTable({
    sqldf(input$queryString)
  })
  
})