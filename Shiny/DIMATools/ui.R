library(shiny)

shinyUI(fluidPage(
  titlePanel("DIMA Database Analysis Tools"),
  sidebarLayout(
    sidebarPanel(
      fileInput('infile', h5('Choose DIMA File'),accept='application/x-msaccess'),
      submitButton("Update View")
      ), # close sidebarPanel
    
    mainPanel(
      tabsetPanel(
        tabPanel("Intro",
                 h4("Background"),
                 p("Say something cheeky here about how this is the coolest thing since titanium water bottle bolts and carbon fiber headset spacers - or at least the coolest thing since yesterday...")
                 ), # close tabPanel
        tabPanel("Table Viewer",
                 selectInput("selTable","Select a DIMA Table:",c("tblPlots","tblSites","tblPeople")),
                 h4("DIMA Table Viewer"),
                 dataTableOutput("tableView")
                 ), # close tabPanel
        tabPanel("Table Query",
                 textInput("queryString","Enter a SQL Query:", "SELECT PlotKey, PlotID FROM tblPlots"),
                 h4("Query Output Viewer"),
                 dataTableOutput("queryView")
        ),
        tabPanel("Test",
                 h4("Raw Output"),
                 verbatimTextOutput("test")
        ), # close tabPanel
        tabPanel("Plots",
                 h4("Plots"),
                 plotOutput("DIMAPlot", height="300px")
                 ) # close tabPanel
        ) # close tabsetPanel
    ) # close mainPanel
    
  )  
))