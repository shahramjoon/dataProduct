library(shiny)
library(ggplot2)
source("Helper.R")

shinyServer(function(input, output) {

  datasetInput <- reactive({
     subset ( data , (Area == input$region & input$regioncountry=='r') | (Area == input$country & input$regioncountry=='c'))
  })  

  
  datasetInput1 <- reactive({
     subset ( summarydata , (Area == input$region & input$regioncountry=='r') | (Area == input$country & input$regioncountry=='c'))
  })  
  
  
  output$regioncountry <- renderText({
    paste ( "You Have selected", input$regioncountry)
  
  })
  
  output$region <- renderText({
    paste ( "You Have selected", input$region)
    
  })
  
  output$country <- renderText({
    paste ( "You Have selected", input$country)
    
  })
  
  output$view <- renderTable({
    datasetInput()
  })
  

  output$plot <- renderPlot({
   ggplot(datasetInput() , aes(x=Period, y=cnt, group=agegroup))+
     geom_line(aes(group=agegroup, color=agegroup)) +
     geom_point(aes(group=agegroup, color=agegroup)) +  
      labs ( x="Period", y="Number of Births (Thousands)")+
      stat_summary(aes(colour="Mean",shape="Mean",group=1), fun.y=mean, geom="line", size=1.1)+
     scale_color_brewer(palette="Set1")+
      ggtitle(paste("Births By Five-Year Age Group of Mother in" , if (input$regioncountry == "r") { input$region } else { input$country }, " 1950-2010"))+
     theme_bw() +
      theme(panel.grid.major = element_blank(),
            # panel.background = element_rect(fill = 'pink', colour = 'red'),
            plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
            axis.title = element_text(face = "bold", size = 10))
  })  
  
  
  output$summaryplot <- renderPlot({
    ggplot(datasetInput1() , aes(x=Period, y=total))+
    geom_histogram(aes(fill=Period), stat="identity")+  
      labs ( x="Period", y="Number of Births (Thousands)")+
      # stat_summary(aes(colour="Mean",shape="Mean",group=1), fun.y=mean, geom="line", size=1.1)+
      scale_color_brewer(palette="Set1")+
      ggtitle(paste("Births in" , if (input$regioncountry == "r") { input$region } else { input$country }, " 1950-2010"))+
      theme_bw() +
      theme(panel.grid.major = element_blank(),
            # panel.background = element_rect(fill = 'pink', colour = 'red'),
            plot.title = element_text(size = rel(1.2), face = "bold", vjust = 1.5),
            axis.title = element_text(face = "bold", size = 10))
  })  
  
})