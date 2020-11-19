if (!require("RMySQL")) install.packages('RMySQL',type='source')

library(shiny)
library(RMySQL)
library(ggplot2)
library(dplyr)
library(DT)
library(shinydashboard)

#Opciones
db_user = 'root'
db_password = 'root123'
db_name = 'Academatica'
db_table = 'video'
db_host = '172.30.0.2'
db_port = 3306

#Dataframes
data = NULL #Data de videos
total.likes = 0

loadData = function() {
  mydb =  dbConnect(MySQL(), 
                    user = db_user, 
                    password = db_password,
                    dbname = db_name, 
                    host = db_host, 
                    port = db_port)
  query = 'SELECT s.id ID, s.view_count Vistas,
            s.like_count Me_Gusta, s.dislike_count No_Me_Gusta,
            s.favorite_count Favoritos, s.comment_count Comentarios,
            v.fecha_publicacion Fecha_Publicacion, 
            YEAR(v.fecha_publicacion) Anio, 
            MONTH(v.fecha_publicacion) Mes, 
            DAY(v.fecha_publicacion) Dia
          FROM video AS v
            INNER JOIN stats AS s
            ON v.content_id = s.id;'
  
  data <<- dbGetQuery(mydb, query)
  dbDisconnect(mydb)
  data
}

shinyServer(function(input, output, session) {
  cargar.datos = reactive({
    loadData()
  })
  
  output$tabla_videos = DT::renderDataTable({
    cargar.datos()
  })
  
  #Funciones para dashboard
  #General
  output$total_vistas = renderValueBox({
    df = cargar.datos()
    total.vistas = sum(df$Vistas)
    
    valueBox(
      formatC(total.vistas, format = "d", big.mark = ','), 
      "Vistas", 
      icon = icon("play"),
      color = "blue"
    )
  })
  
  output$total_likes = renderValueBox({
    total.likes = sum(data$Me_Gusta)
    
    valueBox(
      formatC(total.likes, format = "d", big.mark = ','), 
      "Likes", 
      icon = icon("thumbs-up", lib = "glyphicon"),
      color = "green"
    )
  })
  
  output$total_dislikes = renderValueBox({
    total.dislikes = sum(data$No_Me_Gusta)
    
    valueBox(
      formatC(total.dislikes, format = "d", big.mark = ','), 
      "Dislikes", 
      icon = icon("thumbs-down", lib = "glyphicon"),
      color = "red"
      )
  })
  
  output$total_favs = renderValueBox({
    total.favs = sum(data$Favoritos)
    
    valueBox(
      formatC(total.favs, format = "d", big.mark = ','), 
      "Favoritos", 
      icon = icon("star"),
      color = "yellow"
    )
  })
  
  output$total_comments = renderValueBox({
    total.comments = sum(data$Comentarios)
    
    valueBox(
      formatC(total.comments, format = "d", big.mark = ','), 
      "Comentarios", 
      icon = icon("comment"),
      color = "purple"
    )
  })
  
  #Promedios
  output$mean_likes = renderInfoBox({
    mean.likes = mean(data$Me_Gusta)
    
    infoBox(
      "Like", 
      subtitle = "por video",
      formatC(mean.likes, format = "d", big.mark = ','), 
      icon = icon("thumbs-up", lib = "glyphicon"),
      color = "green"
    )
  })
  
  output$mean_dislikes = renderInfoBox({
    mean.dislikes = mean(data$No_Me_Gusta)
    
    infoBox(
      "Dislike", 
      subtitle = "por video",
      formatC(mean.dislikes, format = "d", big.mark = ','), 
      icon = icon("thumbs-down", lib = "glyphicon"),
      color = "red"
    )
  })
  
  output$mean_comments = renderInfoBox({
    mean.comments = mean(data$Comentarios)
    
    infoBox(
      "Comentario", 
      subtitle = "por video",
      formatC(mean.comments, format = "d", big.mark = ','), 
      icon = icon("comment"),
      color = "purple"
    )
  })
  
  #Por video
  output$max_likes = renderText({
    max.likes = max(data$Me_Gusta)
    formatC(max.likes, format = "d", big.mark = ',')
  })
  
  output$min_likes = renderText({
    min.likes = min(data$Me_Gusta)
    formatC(min.likes, format = "d", big.mark = ',')
  })
  
  #Plots
  output$plot_likes = renderPlot({
    ggplot(data, aes(x=Vistas, y=Me_Gusta)) + 
      geom_point(show.legend = FALSE, color = "#00AFBB", size = 1) + 
      geom_rug(show.legend = FALSE, color = "#00AFBB") + 
      theme_minimal() 
  })
  
  output$plot_comments = renderPlot({
    ggplot(data, aes(x=Vistas, y=Comentarios)) +
      geom_point(show.legend = FALSE, color = "#FC4E07", size = 1) + 
      geom_rug(show.legend = FALSE, color = "#FC4E07") + 
      theme_minimal() 
  })
  
  
})
