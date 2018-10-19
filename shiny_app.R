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
women_pics <- "/Users/themba/Pictures/"
#men_pics <- "/Users/themba/Pictures/"
#girls_pics <- "/Users/themba/Pictures/"
#boys_pics <- "/Users/themba/Pictures/"



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

    sidebarMenu(
      menuItem("Registration", tabName = "registration"), 
      menuItem("Employee charter", tabName = "employees"),
      menuItem("Clients/Customers", tabName = "clients"),
      menuItem("Sales", tabName = "sales", badgeLabel = "new", badgeColor = "green"), #icon = icon("th"),
      menuItem("Suppliers", tabName = "suppliers"),
      menuItem("About", tabName = "about", icon = icon("question")),

      #new addition.  icon = icon("file-text-o"),
      id = "sidebar_menu",
      menuItemOutput("dynamic_menu"),
      menuItem("Menu2", tabName = "menu2")
      )
    ),

  dashboardBody(
    #slickROutput("slickr", width = "100%", height = "400px"),
    uiOutput("menu1_content"),
    uiOutput("menu2_content")
    )
)

server <- function(input, output, session) { 
  output$dynamic_menu <- renderMenu({
      menu_list <- lapply(c("Man","Woman","Girls","Boys"), function(x) {
        menuSubItem(x, tabName = paste0("menu1-", x))
      })
      menuItem(icon = icon("file-text-o"),
        text = "Ads",
        startExpanded = TRUE,
        do.call(tagList, menu_list)
      )
    })

    output$menu1_content <- renderUI({
      if (grepl("-",input$sidebar_menu) == TRUE) {
        sidebar_menu <- tstrsplit(input$sidebar_menu, "-")
        if (sidebar_menu[[2]] == "Woman") box(background='black',renderSlickR({
    imgs <- list.files(women_pics, pattern=".jpeg", full.names = TRUE)
    slickR(imgs)
  }))
        else box(sidebar_menu[[2]])}

      #if (sidebar_menu[[1]] == "menu1") box(sidebar_menu[[2]])
    })

    output$menu2_content <- renderUI({
      sidebar_menu <- tstrsplit(input$sidebar_menu, "-")
      if (sidebar_menu[[1]] == "menu2") box("I am menu2")
    })
}

shinyApp(ui, server)