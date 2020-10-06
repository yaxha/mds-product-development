library(shiny)
library(readr)
library(DT)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {
  
  #Detectar cada vez que el path del archivo cambie
  archivo_carga_1 = reactive({
    if(is.null(input$upload_file_1)){
      return(NULL)
    }
    #browser() #Para debuggear
    if(input$upload_file_1$type == 'application/vnd.ms-excel') {
      file_data = read_csv(input$upload_file_1$datapath)
      return(file_data)
    }
    return(NULL)
  })
  
  output$tabla_archivo_1 = renderTable({
    archivo_carga_1()
  })
  
  #Segunda pestania
  archivo_carga_2 = reactive({
    if(is.null(input$upload_file_2)){
      return(NULL)
    }
    #browser() #Para debuggear
    if(input$upload_file_2$type == 'application/vnd.ms-excel') {
      file_data = read_csv(input$upload_file_2$datapath)
      return(file_data)
    }
    return(NULL)
  })
  
  output$tabla_archivo_2 = DT::renderDataTable({
    DT::datatable(archivo_carga_2())
  })
  
  output$tabla1 = DT::renderDataTable({
    diamonds %>% 
      datatable() %>%
      formatCurrency("price") %>%
      formatString(c('x','y', 'z'), suffix = 'mm')
  })
  
  output$tabla2 = DT::renderDataTable({
    mtcars %>% 
      datatable(options = list(pageLength = 5, 
                               lengthMenu = c(5, 10, 20)
                               ), 
                filter = 'top'
                )
  })
  
  output$tabla3 = DT::renderDataTable({
    iris %>% 
      datatable(
        extensions = 'Buttons', 
        options = list(dom='Bfrtip', 
                       buttons=c('csv')), 
        rownames = F
      )
  })
  
  output$tabla4 = DT::renderDataTable({
    mtcars %>% 
      datatable(
        selection = 'single'
      )
  })
  
  output$tabla4_single_click = renderText({
    input$tabla4_rows_selected
  })
  
  output$tabla5 = DT::renderDataTable({
    mtcars %>% 
      datatable()
  })
  
  output$tabla5_multi_click = renderText({
    input$tabla5_rows_selected
  })
  
  output$tabla6 = DT::renderDataTable({
    mtcars %>% 
      datatable(
        selection = list(mode='single', 
                         target='column'
                         )
      )
  })
  
  output$tabla6_single_click = renderText({
    input$tabla6_columns_selected
  })
  
  output$tabla7 = DT::renderDataTable({
    mtcars %>% 
      datatable(
        selection = list(target='column')
      )
  })
  
  output$tabla7_multi_click = renderText({
    input$tabla7_columns_selected
  })
  
  output$tabla8 = DT::renderDataTable({
    mtcars %>% 
      datatable(
        selection = list(mode='single', 
                         target='cell'
        )
      )
  })
  
  output$tabla8_single_click = renderPrint({
    input$tabla8_cells_selected
  })
  
  output$tabla9 = DT::renderDataTable({
    mtcars %>% 
      datatable(
        selection = list(target='cell')
      )
  })
  
  output$tabla9_multi_click = renderPrint({
    input$tabla9_cells_selected
  })
  
})
