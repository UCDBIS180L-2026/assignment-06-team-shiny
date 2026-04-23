library(shiny)
library(ggplot2)
# other libraries here

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
}

# Run the application 
shinyApp(ui = ui, server = server)
