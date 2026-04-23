library(shiny)
library(ggplot2)
# other libraries here
library(tidyverse)
# data loading and one-time processing here
#data(msleep)
head(msleep)

# Define UI for application 
ui <- fluidPage(
  
  titlePanel("Sleep Data"),
  
  helpText("placeholder"),
  
  sidebarLayout(
    sidebarPanel(
      selectizeInput('genus', 'Select Genus:',
                     choices = msleep$genus),
      radioButtons('sleep_stats', 'Choose a sleep statistic to display:',
                   c("Sleep_total",
                     "REM_sleep",
                     "Sleep_Cycle",
                     "Awake")
                   
      )
    ),
    mainPanel(
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
      filter(vore != input$genus) %>%
      ggplot(aes(x = conservation, 
                 y = !! sleepStats,
                 fill = conservation)) + #then plot the sleep stats with conservation
      geom_boxplot(alpha=0.75) +
      labs(x= "Conservation", fill="Conservation Status") +
      theme_minimal()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
