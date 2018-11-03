#-------------------------------------------------------------------------
#  This application is the property of Data Analytics. 
#
#  Themba Gqaza, Mike Hlabathi, Hope Mokolo, Zwido Khangala, Orapeleng Mongwana, Sam Ngoasheng
#  September, 2018
#----------------------------------

library(shiny)
library(shinydashboard)
library(slickR)  # for slideshow
library(data.table)
library(DBI)
library(RPostgreSQL)
library(DT)
#library(jsonlite)
library()


json_data <- rjson::fromJSON(file = "../secrets.json")
drv <- dbDriver("PostgreSQL")
conn <- dbConnect(drv, dbname = json_data$dbname, host = json_data$host, port = json_data$port, user = json_data$user, password=json_data$password)
data <- dbGetQuery(conn, paste0("SELECT * FROM customers_table"))


#----------------------------------
#Input images
women_pics <- "/Users/themba/Pictures/"
catalog    <- c("Man","Woman","Girls","Boys")

ui <- dashboardPage(skin = "blue",
  dashboardHeader(
    title = "Data Analytics", #titleWidth = 200
    dropdownMenu()
    ),

  dashboardSidebar(
    sidebarSearchForm(
      textId = "searchText",
      buttonId = "searchButton",
      label = "Search..."),

    sidebarMenu(id = "sidebar_menu",
            menuItemOutput("dynamic_menu"),
            menuItem("Employees", tabName = "employee")
      )
    ),

  dashboardBody(
    uiOutput("menu1_content"),
    uiOutput("menu2_content",style = "height:500px; overflow-y: scroll;overflow-x: scroll;")
    )
)

server <- function(input, output, session) { 
      output$dynamic_menu <- renderMenu({menu_list <- lapply(catalog, function(x) {menuSubItem(x, tabName = paste0("menu1-", x))})
                    menuItem(icon = icon("file-text-o"),
                      text = "Catalogues:",
                      startExpanded = TRUE,
                      do.call(tagList, menu_list))})

      output$menu1_content <- renderUI({
                    if (grepl("-",input$sidebar_menu) == TRUE) 
                      {sidebar_menu <- tstrsplit(input$sidebar_menu, "-")
                      if (sidebar_menu[[2]] == "Woman") 
                        box(background='black',renderSlickR({imgs <- list.files(women_pics, pattern=".jpeg", full.names = TRUE)
                    slickR(imgs)}))
                      else box(sidebar_menu[[2]])}
    })



      output$menu2_content <- renderUI({
                      sidebar_menu <- tstrsplit(input$sidebar_menu, "-")
                      if (sidebar_menu[[1]] == "employee") box(width = 15, height = 12, #title = "Sales", 
                        datatable(data=data,options = list(columnDefs = list(list(className = 'dt-center', targets = 5)),
                          pageLength = 5,lengthMenu = c(5, 10, 15, 20))
  ))
    })
}
on.exit(dbDisconnect(conn), add = TRUE)
shinyApp(ui, server)