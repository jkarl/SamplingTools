library(shiny)

shinyUI(fluidPage(
  tags$head(includeScript='google_analytics.js'),
  titlePanel("Optimal Error Rate Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      HTML("This tool calculates the optimal Type I error rate (alpha) that minimizes overall error (Type I and II) for different kinds of t-Tests. 
          Optimal alpha is calculated from sample size, effect size, ratio of the costs of making Type I vs. Type II errors, and prior probabilities of the null hypothesis (i.e., no change) being true.
          Click the <strong>Effect Size</strong> tab for help calculating effect size for your data.
           Click the <strong>More Info</strong> tab for background and references."),
      hr(),
      h4("Input parameters"),
      numericInput("n1",label="Sample size for group 1",value=10,min=0,step=1),
      numericInput("n2",label="Sample size for group 2",value=10,min=0,step=1),
      numericInput("d",label="Effect size",value=1.2,min=0,step=0.01),
      selectInput("type",label="Test type",choices=list("One sample test"="one.sample","Two sample test"="two.sample","Paired test"="paired"),selected="one.sample"),
      selectInput("tails",label="Tails",choices=list("Single-sided (one-tailed) test"="one.tailed","Two-sided (two-tailed) test"="two.tailed"),selected="one.tailed"),
      numericInput("T1T2cratio",label="Cost ratio for Type I/Type II Errors",value=1,min=0,max=5,step=0.05),
      numericInput("HaHopratio",label="Prior probability ratio for Ho/Ha",value=1,min=0,max=10,step=0.05)
      ), # close sidebarPanel
    
    
    mainPanel(
      tabsetPanel(
        tabPanel("Optimal Alpha",h3("Optimal Alpha Output"),
              verbatimTextOutput("optabOut"),
              h3("Optimal Alpha Graph"),
              plotOutput("optabPlot",width="100%",height="400px")),
        tabPanel("Effect Size",h4("Effect Size Explained"),p("Effect size is the magnitude of difference between two groups. For a useful statistical test, you should first determine what a meaningful effect size is. 
                                                           There are many different ways to calculate effect size. The optimal error rate tool uses the Cohen's D standardized effect size which is a
                                                           unitless number that is a difference in means divided by a pooled standard deviation. Depending on the test and options, there are different forumulas for
                                                           calculating Cohen's D. You can use the calculator below and input the result in the Effect Size box at the left."),
                 hr(),
                 h4("Effect Size Inputs"),
                 selectInput("EStype",label="Select Type",choices=list("Percent Change of a Mean"="pct","Test Against a Threshold"="threshold","Compare Two Samples"="two.sample")),
                 fluidRow(
                   column(6,numericInput("x1",label="Sample Mean",value=10,step=0.01),
                          numericInput("esn1",label="Sample Size",min=0,step=1,value=10),
                          numericInput("s1",label="Sample Variance",value=5,min=0,step=0.01)),
                 column(6,
                        conditionalPanel("input.EStype=='two.sample'",
                            numericInput("x2",label="Sample Mean Group 2",value=20,step=0.01),
                            numericInput("esn2",label="Sample Size Group 2",min=0,step=1,value=10),
                            numericInput("s2",label="Sample Variance Group 2",value=9,min=0,step=0.01)),
                        conditionalPanel("input.EStype!='two.sample'",
                            conditionalPanel("input.EStype=='pct'",
                                             numericInput("pctChg",label="Percent Change",min=0,max=100,step=1,value=25)),
                            conditionalPanel("input.EStype=='threshold'",
                                             numericInput("threshold",label="Threshold Value",step=0.01,value=15)),                            
                            checkboxInput("paired",label="Repeated measures (i.e., paired)?")))
                 ),                          
                 h4("Calculated effect size is: ",textOutput("CohensD",inline=TRUE)),
                 hr(),
                 h4("Helpful Links"),
                 a(src="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3444174/","Using Effect Size-or Why the P Value Is Not Enough, Journal of Graduate Medical Education article"),br(),
                 a(src="http://en.wikipedia.org/wiki/Effect_size", "Wikipedia: Effect Size"),br(),
                 a(src="http://en.wikiversity.org/wiki/Cohen%27s_d", "Wikiversity: Cohen's D")),
        tabPanel("More Info", "Lorem ipsum...",
                 h4("References"),
                 HTML("<ul><li>Mudge, Joseph F., Leanne F. Baker, Christopher B. Edge, and Jeff E. Houlahan. “Setting an Optimal Α That Minimizes Errors in Null Hypothesis Significance Tests.” Edited by Zheng Su. PLoS ONE 7, no. 2 (February 28, 2012): e32734. doi:<a href='http://dx.doi.org/10.1371/journal.pone.0032734' target='_blank'>10.1371/journal.pone.0032734</a>.
</li><li>Mudge, Joseph F., Timothy J. Barrett, Kelly R. Munkittrick, and Jeff E. Houlahan. “Negative Consequences of Using Α = 0.05 for Environmental Monitoring Decisions: A Case Study from a Decade of Canada’s Environmental Effects Monitoring Program.” Environmental Science & Technology 46, no. 17 (September 4, 2012): 9249–55. doi:<a href='http://dx.doi.org/10.1021/es301320n' target='_blank'>10.1021/es301320n</a>.
</li></ul>"))
              )) # Close mainPanel and tabsetPanel
    ) # close sidebarLayout
  
  ))  # close fluidPage and shinyUI