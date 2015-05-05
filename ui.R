# ui.R
library(shiny)

source ("Helper.R")

shinyUI(fluidPage(
  titlePanel("Births By Age of Mother"),
  
  sidebarLayout(position = "left",
                sidebarPanel(
                  helpText("Create chart to present number of births over period of 1950-2010 classified by age group of mother")
                 ,
                  
                  
                  radioButtons("regioncountry",
                               label = "Region or Country",
                               choices = list("Region" = "r", "Country" = "c"),
                               selected = "r")
                ,

                helpText("Based on above choice, Choose Either ")
                ,
                
                  selectInput("country",
                              label = "Choose your favorite Country",
                              choices = country)
                  ,

                helpText("OR")
                ,
                
                 selectInput("region",
                              label = "Choose your favorite Region",
                             choices = region)
                  
                  
                  
                  
                ),
                mainPanel(
                  
                 
                  h5( "Data Provided by United Nations, Population Division, Department of Economics and Social Affairs"),
                  tags$a(href="http://esa.un.org/wpp/Excel-Data/fertility.htm", "Click here to go to source website")
                  ,
                  
                 tabsetPanel(
                    tabPanel("Plot", plotOutput("plot")), 
                    tabPanel("Summary Plot", plotOutput("summaryplot")), 
                   tabPanel("Table", tableOutput("view"))
                )
                  
                  # h3(textOutput("regioncountry")),
                  
                  # h3(textOutput("region")),
                  
                  # h3(textOutput("country")),
#                  plotOutput("plot"),
#                  tableOutput("view")
                  
                  )
                         
  )
))