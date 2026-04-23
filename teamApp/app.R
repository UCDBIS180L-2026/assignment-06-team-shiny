library(shiny)
library(ggplot2)
# other libraries here
library(tidyverse)
# data loading and one-time processing here
#data(msleep)
head(msleep)

vora <- setdiff(unique(msleep$vore), c(NA, "NA"))

# Define UI for application 
ui <- fluidPage(
  
  titlePanel("Sleep Data with respect to Genus"),
  
  helpText("In this website we are exploring how sleep statistics varies among Genus. You can first select the big group by what food they consome(Plant, Meat, hybrid, or if they are insect). Then you can view how sleep statistics such as sleep time and cycles varies between different genus group on a graphed boxplot."),
  
  
  
  sidebarLayout(
    sidebarPanel(width = 3,
      selectizeInput('vora', 'Select Vore:',
                     choices = vora),
      radioButtons('sleep_stats', 'Choose a sleep statistic to display:',
                   c("sleep_total",
                     "sleep_rem",
                     "sleep_cycle",
                     "awake")
                   
      )
    ),
    mainPanel(width = 9, 
      plotOutput("plot")
    )
  )
  

)


# Define server logic 
server <- function(input, output) {
  # server code here
  
  
  
  output$plot <- renderPlot({
    
    sleepStats <- as.name(input$sleep_stats) #convert as variable names
    
    msleep %>% #select from input:genus for filtering
      filter(vore == input$vora) %>%
      ggplot(aes(x = order, 
                 y = !! sleepStats,
                 fill = order)) + #then plot the sleep stats with conservation
      geom_boxplot(alpha=0.75) +
      labs(title = sleepStats, x= "Order", fill="Order")+
      theme(axis.text.x = element_text(size = 14,angle = 30, hjust=1),
            axis.text.y = element_text(size = 14),
            axis.title = element_text(size = 16),
            plot.title = element_text(size = 16, hjust = 0.5),
            legend.text = element_text(size = 14),
            legend.title = element_text(siz = 16))
      
      
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
