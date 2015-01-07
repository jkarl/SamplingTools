library(shiny)
source('optimal_alpha.R')

shinyServer(function(input,output) {
  output$optabOut <- renderPrint(optab(n1=input$n1,n2=input$n2,d=input$d,type=input$type,tails=input$tails,T1T2cratio=input$T1T2cratio,HaHopratio=input$HaHopratio)$output)
  output$optabPlot <- renderPlot(optab.plot(n1=input$n1,n2=input$n2,d=input$d,type=input$type,tails=input$tails,T1T2cratio=input$T1T2cratio,HaHopratio=input$HaHopratio))
  
})