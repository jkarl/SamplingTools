library(shiny)

shinyUI(fluidPage(
  titlePanel("Optimal Error Rate Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Input parameters"),
      numericInput("n1",label="n1",value=10),
      numericInput("n2",label="n2",value=10),
      numericInput("d",label="effect size",value=1.2),
      selectInput("type",label="Test type",choices=list("one.sample","two.sample","paired"),selected="one.sample"),
      selectInput("tails",label="tails",choices=list("one.tailed","two.tailed"),selected="one.tailed"),
      numericInput("T1T2cratio",label="Error cost ratio",value=1),
      numericInput("HaHopratio",label="Null hypothesis prior probability",value=1)
      ), # close sidebarPanel
    
    
    mainPanel(h3("Optimal Alpha Output"),
              verbatimTextOutput("optabOut"),
              h3("Optimal Alpha Graph"),
              plotOutput("optabPlot",width="100%",height="400px")
              )
    ) # close sidebarLayout
  
  ))  # close fluidPage and shinyUI