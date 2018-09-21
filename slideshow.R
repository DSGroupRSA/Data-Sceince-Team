library(shiny)
library(slickR)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      ####
    ),
    
    mainPanel(
      slickROutput("slickr", width="500px")
    )
  )
)

server <- function(input, output) {
  
  output$slickr <- renderSlickR({
    imgs <- list.files("hopepics/", pattern=".png", full.names = TRUE)
    slickR(imgs)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)