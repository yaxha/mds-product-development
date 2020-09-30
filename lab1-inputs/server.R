#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(lubridate)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$text_slider = renderText({
        input$slider
    })
    
    output$text_rango_slider = renderText({
        input$rango_slider
    })
    
    output$text_listbox = renderText({
        input$listbox
    })
    
    output$text_multiple = renderText({
        input$listbox_multiple
    })
    
    output$text_fecha = renderText({
        paste0(day(input$fecha), '/', month(input$fecha), '/', year(input$fecha))
    })
    
    output$text_rango_fecha = renderText({
        paste0(day(input$rango_fecha[1]), '/', month(input$rango_fecha[1]), '/', year(input$rango_fecha[1]), ' a ', 
               day(input$rango_fecha[2]), '/', month(input$rango_fecha[2]), '/', year(input$rango_fecha[2]))
    })
    
    output$text_numerico = renderText({
        input$numerico
    })
    
    output$text_single_check = renderText({
        input$single_check
    })
    
    output$text_grouped_check = renderText({
        input$grouped_check
    })
    
    output$text_radiobutton = renderText({
        input$radiobutton
    })
    
    output$text_texto = renderText({
        input$texto
    })
    
    output$text_parrafo = renderText({
        input$parrafo
    })
    
    
    evento_boton = eventReactive(input$button, {
        as.character('I like you')
    })
    
    output$text_button = renderText({
        evento_boton()
    })

})
