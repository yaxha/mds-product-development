library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

df_tabla = NULL #datasource global de la tabla
df_click = NULL #datasource global del click
df_brush = NULL #datasource global del brush
df_hover = NULL #datasource global del hover

shinyServer(function(input, output) {
  #Disenio de funcion para detectar los puntos que se deben pintar
  puntos.seleccionados = reactive({
    if(!is.null(input$clk$x)) {
      df = nearPoints(mtcars, input$clk, xvar = 'wt', yvar = 'mpg')
      seleccion = df %>% select(wt, mpg)
      df_tabla <<- rbind(df_tabla, seleccion) %>% distinct()
      df_click <<- rbind(df_click, seleccion) %>% distinct()
    }
    if(!is.null(input$mbrush$xmin)) {
      df = brushedPoints(mtcars, input$mbrush, xvar = 'wt', yvar = 'mpg')
      seleccion = df %>% select(wt, mpg)
      df_tabla <<- rbind(df_tabla, seleccion) %>% dplyr::distinct()
      df_brush <<- rbind(df_brush, seleccion) %>% distinct()
      df_click <<- setdiff(df_click, seleccion)
    }
    if(!is.null(input$dclk$x)) {
      df = nearPoints(mtcars, input$dclk, xvar = 'wt', yvar = 'mpg')
      seleccion = df %>% select(wt, mpg)
      df_tabla <<- setdiff(df_tabla, seleccion)
      df_click <<- setdiff(df_click, seleccion)
      df_brush <<- setdiff(df_brush, seleccion)
    }
    if(!is.null(input$mhover$x)) {
      df = nearPoints(mtcars, input$mhover, xvar = 'wt', yvar = 'mpg')
      seleccion = df %>% select(wt, mpg)
      df_hover <<- seleccion
    }
  })
  
  dibujar.plot = reactive({
    plot = ggplot(mtcars, aes(wt, mpg)) + 
      geom_point(size = 3) + 
      ylab("Millas por galon") + 
      xlab("Peso ") + 
      ggtitle("Rendimiento por peso de vehiculo") + 
      theme_minimal()
    
    seleccion = puntos.seleccionados()
    
    if(!is.null(df_click)) {
      plot = plot +
        geom_point(data = df_click,
                   aes(wt, mpg),
                   color = 'green', 
                   size = 4)
    }
    
    if(!is.null(df_brush)) {
      plot = plot +
        geom_point(data = df_brush,
                   aes(wt, mpg),
                   color = 'red', 
                   size = 4)
    }
    
    if(!is.null(df_hover)) {
      plot = plot +
        geom_point(data = df_hover,
                   aes(wt, mpg),
                   color = 'gray', 
                   size = 4)
    }
    
    plot
  })
  
  #Cargar datos a la grafica
  #Tambien se capturan las acciones del usuario para cambiar el color a ciertos puntos
  output$plot_click_options = renderPlot({
    dibujar.plot()
    
  })
  
  #Mostrar mensajes de acciones realizadas en el control de print
  output$click_data = renderPrint({
    if(!is.null(input$clk$x)) {
      clk_msg = paste0("Click en (", 
                       round(input$clk$x, 2),  ", ",
                       round(input$clk$y, 2),  ")")
      print(clk_msg)
    }
    if(!is.null(input$dclk$x)) {
      dclk_msg = paste0("Doble click en (", 
                        round(input$dclk$x, 2), ", ",
                        round(input$dclk$y, 2), ")")
      print(dclk_msg)
    }
    
    if(!is.null(input$mhover$x)) {
      hover_msg = paste0("Hover en (", 
                         round(input$mhover$x, 2), ", ",
                         round(input$mhover$y, 2), ")")
      print(hover_msg)
    }
    
    if(!is.null(input$mbrush$xmin)) {
      brusx = paste0("(", input$mbrush$xmin, ", ", input$mbrush$xmax, ")")
      brusy = paste0("(", input$mbrush$ymin, ", ", input$mbrush$ymax, ")")
      mbrush = cat("Area seleccionada \nX: ", brusx, "\n", 
                   "Y: ", brusy)
      print(mbrush)
    }
  })
  
  datos.tabla = reactive({
    input$clk$x
    input$dclk$x
    input$mbrush
    df_tabla
  })
  
  #Mostrar datos de los carros seleccionados, ya sea por click o brush
  output$tabla_mtcars = DT::renderDataTable({
    datos.tabla()
  })
  
  
})
