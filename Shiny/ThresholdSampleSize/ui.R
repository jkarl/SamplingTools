library(shiny)

shinyUI(fluidPage(
#tags$head(includeScript('google_analytics.js')),
  titlePanel("Sampling Sufficiency for Landscape Thresholds"),
  
  sidebarLayout(
    sidebarPanel(
      HTML("To use this tool, you need to specify for a given indicator: the observed/estimated proporiton that meets some benchmark criterion, the landscape threshold value, the desired Type I (false change) error rate, power (1 - missed change error rate), and desired margin of error."),
      hr(),
      h4("Input parameters"),
      numericInput("p",label="Landscape Threshold Proportion",value=0.25,min=0,max=1,step=0.01),
      numericInput("p0",label="Observed/estimated Proportion",value=0.05,min=0,max=1,step=0.01),
      numericInput("alpha",label="Desired Type I Error rate",value=0.2,min=0,max=1,step=0.01),
      numericInput("power",label="Desired Power",value=0.8,min=0,max=1,step=0.01),
      numericInput("moe",label="Desired Margin of Error",value=0.1,min=0,max=1,step=0.01)
      ), # close sidebarPanel
    
    
    mainPanel(
      tabsetPanel(
        tabPanel("Sampling Sufficiency",
              p("This tool is intended for evaluating how many sample sites (i.e., plots) are needed to determine if an observed or estimated proporiton of sample sites meets a given threshold value. 
                For example, is the estimated proportion of potential sage grouse habitat that is in unsuitable condition in a BLM Field Office less than 20% of total acres? 
                The estimated proportion/area/length from sampling is compared against a specified threshold value for the reporting unit with the idea that meeting or crossing 
                the threshold could result in determining the indicator does not meet a standard or trigger management action."),
              hr(),
              h3("Sample Size Estimates"),
              p("Sample size based on testing difference between proportions: ", textOutput("nEst", inline=TRUE)),
              p("Sample size based on achieving target margin of error: ", textOutput("mEst", inline=TRUE)),
              h4("Recommended sample size is: ",textOutput("recommendedN",inline=TRUE)),
              p("Recommended sample sizes are the smaller of two calculations: 1) the sample size needed to detect a difference between the observed and target proportions, and 2) the sample size required to meet the desired margin of error. 
                In both cases, recommended sample sizes assume that your sampling sites are independent."),
              hr(),
              h3("Sampling Sufficiency Graph"),
              plotOutput("sampPlot",width="100%",height="400px")),
        
        
        tabPanel("More Info", p("In the context of natural resource monitoring, failing to detect a change (Type II error) can be more harmful and costly than falsely claiming that a change occurred (Type I error).
                                Rather than using arbitrary error rates (e.g., alpha = 0.05) for statitical analyses and tests which may lead to increased likelihood of making Type II errors, both error rates should be set at levels that minimize the chance of making any type of error.
                                Because Type I and II error rates are related, the optimal error rate is the alpha level (Type I error rate) that minimizes the probability of Type I and Type II errors for given sample and effect sizes
                                (see Mudge et al. 2012a, 2012b). The optimal error rate can be adjusted to account for differential costs of the different types of errors and for expectations 
                                (i.e., prior probabilities) of the likelihood of change occurring (or not occurring)."),
                 p("This tool uses R code provided by Mudge et al. (2012a) to calculate optimal Type I error rates. Specifically, this Shiny tool executes the following function:"),
                 pre("optab(n1,n2,d,type,tails,T1T2cratio,HaHopratio"),
                 p("where n1 and n2 are sample sizes, d is Cohen's effect size, type is the type of t-Test (one sample, two-sample, paired), tails refers to whether the test is for a one-tailed or two-tailed alternative, T1T2cratio = the cost ration of Type I to Type II errors, and HaHopratio is the ratio of prior probabilities. A companion function was written to produce the plot showing how error rates change as Type I error rate goes from zero to one:"),
                 pre("optab.plot(n1,n2,d,type,tails,T1T2cratio,HaHopratio)"),
                 h4("References"),
                 HTML("<ul><li>Mudge, Joseph F., Leanne F. Baker, Christopher B. Edge, and Jeff E. Houlahan. “Setting an Optimal Α That Minimizes Errors in Null Hypothesis Significance Tests.” Edited by Zheng Su. PLoS ONE 7, no. 2 (February 28, 2012): e32734. doi:<a href='http://dx.doi.org/10.1371/journal.pone.0032734' target='_blank'>10.1371/journal.pone.0032734</a>.
</li><li>Mudge, Joseph F., Timothy J. Barrett, Kelly R. Munkittrick, and Jeff E. Houlahan. “Negative Consequences of Using Α = 0.05 for Environmental Monitoring Decisions: A Case Study from a Decade of Canada’s Environmental Effects Monitoring Program.” Environmental Science & Technology 46, no. 17 (September 4, 2012): 9249–55. doi:<a href='http://dx.doi.org/10.1021/es301320n' target='_blank'>10.1021/es301320n</a>.
</li></ul>"))
              )) # Close mainPanel and tabsetPanel
    ) # close sidebarLayout
  
  ))  # close fluidPage and shinyUI