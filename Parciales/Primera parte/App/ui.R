if (!require("shinythemes")) install.packages("shinythemes")
if (!require("dashboardthemes")) install.packages("dashboardthemes")

library(shiny)
library(shinythemes)
library(dashboardthemes)
library(shinydashboard)

shinyUI(
    dashboardPage(
        #Header
        dashboardHeader(
            title = shinyDashboardLogo(
                theme = "grey_dark",
                boldText = "Parcial",
                mainText = "ProdDev",
                badgeText = "v1.0"
            )
        ),
        #Sidebar
        dashboardSidebar(
            sidebarMenu(
                menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
                menuItem("Tabla", tabName = "tabla", icon = icon("th")),
                menuItem("About", tabName = "about", icon = icon("info-circle"))
            )
        ),
        #Body
        dashboardBody(
            shinyDashboardThemes(
                theme = "grey_dark"
            ), 
            tabItems(
                # Primera tab de dashboard
                tabItem(
                    tabName = "dashboard",
                    h1("Academatica"),
                    
                    h2("General"),
                    fluidRow(
                        valueBoxOutput("total_vistas", width = 8)
                    ),
                    fluidRow(
                        valueBoxOutput("total_likes" ),
                        valueBoxOutput("total_dislikes")
                    ), 
                    fluidRow(
                        valueBoxOutput("total_favs" ),
                        valueBoxOutput("total_comments")
                    ), 
                    
                    h2("Promedios"), 
                    fluidRow(
                        infoBoxOutput("mean_likes" ),
                        infoBoxOutput("mean_dislikes"),
                        infoBoxOutput("mean_comments")
                    ),
                    
                    h2("Estadisticas por video"), 
                    fluidRow(
                        box(
                            title = "Con mas likes",
                            status = "success",
                            width = 4,
                            h3(textOutput("max_likes"))
                        ), 
                        box(
                            title = "Con menos likes",
                            status = "warning",
                            width = 4,
                            h3(textOutput("min_likes"))
                        )
                    ), 
                    h2("Interacciones por video visto"), 
                    fluidRow(
                        box(
                            title = "Likes por cantidad de vistas",
                            status = "primary",
                            solidHeader = TRUE,
                            width = 6,
                            plotOutput("plot_likes")
                        ), 
                        box(
                            title = "Comentarios por cantidad de vistas",
                            status = "success",
                            solidHeader = TRUE,
                            width = 6,
                            plotOutput("plot_comments")
                        )
                    )
                ),
                
                # Segunda tab de tabla de data sin filtrar
                tabItem(
                    tabName = "tabla",
                    h2("Tabla"),
                    h4("Data sin filtrar"),
                    DT::dataTableOutput('tabla_videos')
                ), 
                # Tercera tab de Acerca de
                tabItem(
                    tabName = "about",
                    
                    h1("About"), 
                    h2("Curso"), 
                    p("Universidad Galileo"),  
                    p("Maestria en Data Science"),
                    p("Product Development - 2020"),
                    p("Parcial, Primera parte"),
                    
                    h2("Integrantes"), 
                    p("Lilian Rebeca Carrera Lemus"), 
                    p("Jose Armando Barrios Leon")
                )
            )
        )
    )
)
