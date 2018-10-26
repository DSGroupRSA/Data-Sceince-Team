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


#----------------------------------
#Input images
women_pics <- "/home/aorabile/Pictures/Pictures/Pictures"   # Change picture directory
catalog    <- c("Man","Woman","Girls","Boys")  #define catalog for subfolders
data       <- read.csv("clients.csv", header = TRUE, sep=";") 

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

  dashboardBody(uiOutput("menu1_content"),
    uiOutput("menu2_content")
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
        								box(background='blue',renderSlickR({imgs <- list.files(women_pics, pattern=".jpg", full.names = TRUE)
 										slickR(imgs)}))
        							else box(sidebar_menu[[2]])}
    })

    	output$menu2_content <- renderUI({
    	  							sidebar_menu <- tstrsplit(input$sidebar_menu, "-")
    	  							if (sidebar_menu[[1]] == "employee") box("We are employees")
    })
}

shinyApp(ui, server)