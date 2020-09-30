#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Inputs con Shiny"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("slider",
                        "Seleccione un valor",
                        min = 1,
                        max = 100,
                        value = 50), 
            
            sliderInput("rango_slider",
                        "Seleccione un rango",
                        min = 1,
                        max = 100,
                        value = c(20,80)), 
            
            selectInput('listbox', 
                        label = 'Seleccine un carro', 
                        choices = rownames(mtcars)[21:25]
                        ), 
            
            selectInput('listbox_multiple', 
                        label = 'Seleccine uno o mas carros', 
                        choices = rownames(mtcars)[21:25], 
                        multiple = T
            ), 
            
            dateInput('fecha', 
                      label = 'Seleccione una fecha', 
                      language = 'es', 
                      format = 'dd/mm/yyyy', 
                      value = today(), 
                      min = today()-7, 
                      max = today()+60), 
            
            dateRangeInput('rango_fecha', 
                           label = 'Seleccione un rango de fecha',
                           format = 'dd/mm/yyyy',
                           min = today()-30, 
                           max = today()+60, 
                           separator = ' a '), 
            
            numericInput('numerico', 
                         label = 'Ingrese un numero', 
                         min = 0, 
                         max = 10, 
                         value = 5, 
                         step = 1), 
            
            checkboxInput('single_check', 
                          'Seleccione si verdadero', 
                          F), 
            
            checkboxGroupInput('grouped_check', 
                               'Seleccione varios opciones', 
                               c('Desayuno', 'Almuerzo', 'Cena')), 
            
            radioButtons('radiobutton', 
                         'Seleccione genero', 
                         c('Masculino', 'Femenino'), 
                         selected = 'Masculino'), 
            
            textInput('texto', 
                      'Ingrese una linea', 
                      placeholder = 'Texto corto'), 
            
            textAreaInput('parrafo', 
                          'Ingrese un parrafo', 
                          placeholder = 'Texto largo'), 
            
            actionButton('button', 
                         'I dare you', 
                         icon = icon('angellist'), 
                         class = "btn-lg btn-success")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3('Slider'), 
            verbatimTextOutput("text_slider"), 
            
            h3('Rango de Slider'),
            verbatimTextOutput("text_rango_slider"),
            
            h3('Listbox'),
            verbatimTextOutput("text_listbox"),
            
            h3('Multiple Input'),
            verbatimTextOutput("text_multiple"),
            
            h3('Fecha'),
            verbatimTextOutput("text_fecha"),
            
            h3('Rango de Fechas'),
            verbatimTextOutput("text_rango_fecha"),
            
            h3('Input Numerico'),
            verbatimTextOutput("text_numerico"),
            
            h3('Single Checkbox'),
            verbatimTextOutput("text_single_check"),
            
            h3('Grouped Checkbox'),
            verbatimTextOutput("text_grouped_check"),
            
            h3('Radiobutton'),
            verbatimTextOutput("text_radiobutton"),
            
            h3('Texto'),
            verbatimTextOutput("text_texto"),
            
            h3('Parrafo'), 
            verbatimTextOutput("text_parrafo"), 
            
            h3('Boton'), 
            verbatimTextOutput("text_button")
        )
    )
))
