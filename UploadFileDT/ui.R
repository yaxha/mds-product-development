
library(shiny)

shinyUI(fluidPage(
    titlePanel("Cargar Archivos y dataframes"),

    tabsetPanel(
        tabPanel("Cargar archivo",
                 sidebarLayout(
                     sidebarPanel(
                         h2('Subir archivo'), 
                         fileInput("upload_file_1", 
                                   label = 'Seleccionar archivo', 
                                   buttonLabel = 'Cargar archivo',
                                   placeholder = 'No hay archivo seleccionado', 
                                   accept = c('.csv'))
                         ), 
                     mainPanel(
                         tableOutput('tabla_archivo_1')
                         )
                     )
                 ), 
        tabPanel("Cargar archivo DT", 
                 sidebarLayout(
                     sidebarPanel(
                         h2('Subir archivo'), 
                         fileInput("upload_file_2", 
                                   label = 'Seleccionar archivo', 
                                   buttonLabel = 'Cargar archivo',
                                   placeholder = 'No hay archivo seleccionado', 
                                   accept = c('.csv'))
                     ), 
                     mainPanel(
                         DT::dataTableOutput('tabla_archivo_2')
                         )
                     )
                 ), 
        tabPanel("DT Option", 
                 h2('Formato columna'), 
                 fluidRow(column(width=12, 
                                 DT::dataTableOutput("tabla1")
                                 )
                          ), 
                 h2('Opciones'), 
                 fluidRow(column(width=12,
                                 DT::dataTableOutput("tabla2")
                                 )
                          ), 
                 h2('Tabla 3'), 
                 fluidRow(column(width=12,
                                 DT::dataTableOutput("tabla3")
                                 )
                          )
                 ), 
        tabPanel("Clicks en tabla", 
                 fluidRow(column(width=12, 
                                 h2('Click en una fila'),
                                 DT::dataTableOutput('tabla4'), 
                                 verbatimTextOutput('tabla4_single_click')
                                 )
                          ), 
                 fluidRow(column(width=12, 
                                 h2('Click en filas'),
                                 DT::dataTableOutput('tabla5'), 
                                 verbatimTextOutput('tabla5_multi_click')
                                 )
                          ), 
                 fluidRow(column(width=12, 
                                 h2('Click en una columna'),
                                 DT::dataTableOutput('tabla6'), 
                                 verbatimTextOutput('tabla6_single_click')
                                 )
                          ), 
                 fluidRow(column(width=12, 
                                 h2('Click en columnas'),
                                 DT::dataTableOutput('tabla7'), 
                                 verbatimTextOutput('tabla7_multi_click')
                                 )
                          ), 
                 fluidRow(column(width=12, 
                                 h2('Click en una celda'),
                                 DT::dataTableOutput('tabla8'), 
                                 verbatimTextOutput('tabla8_single_click')
                                 )
                          ), 
                 fluidRow(column(width=12, 
                                 h2('Click en celdas'),
                                 DT::dataTableOutput('tabla9'), 
                                 verbatimTextOutput('tabla9_multi_click')
                                 )
                          )
                 )
    )
))
