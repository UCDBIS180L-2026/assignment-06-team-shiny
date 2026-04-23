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
  
  titlePanel("Sleep Data with respect to conservation"),
  
  helpText("In this website we are exploring the effect of conservation to sleep statistics. User can select Vore type and view how conservatio affect each of the sleep statistics such as sleep time and cycles on a graphed boxplot."),
  
  
  
  sidebarLayout(
    sidebarPanel(
      selectizeInput('vora', 'Select Vore:',
                     choices = vora),
      radioButtons('sleep_stats', 'Choose a sleep statistic to display:',
                   c("sleep_total",
                     "sleep_rem",
                     "sleep_cycle",
                     "awake")
                   
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
      filter(vore == input$vora) %>%
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
