library(leaflet) 

function(input, output, session) {
  output$mytable1 <- DT::renderDataTable({
      DT::datatable(readRDS("weekly.RDS"), options = list(searching = FALSE, paging = FALSE, ordering = FALSE))
  })
  
  output$mytable2 <- DT::renderDataTable({
    DT::datatable(readRDS("monthly.RDS"), options = list(searching = FALSE, paging = FALSE, ordering = FALSE))
  })
  
  output$mytable3 <- DT::renderDataTable({
    DT::datatable(readRDS("yearly.RDS"), options = list(searching = FALSE, paging = FALSE, ordering = FALSE))
  })
  
  output$mytable4 <- DT::renderDataTable({
    DT::datatable(readRDS("km_list.RDS"), options = list(searching = FALSE, paging = FALSE, ordering = FALSE))
  })
  
  output$mytable5 <- DT::renderDataTable({
    DT::datatable(readRDS("best_10.RDS"), options = list(searching = FALSE, paging = FALSE, ordering = FALSE))
  })
  
  output$title <- renderText({
    readRDS("title.RDS")
  })
  
  output$dev_text <- renderText({
    readRDS("dev_text.RDS")
  })
  
  output$text <- renderText({
    readRDS("pos_text.RDS")
  })
  
  output$text2 <- renderText({
    readRDS("goal.RDS")
  })
  
  output$mymap <- renderLeaflet({
    readRDS("piteator.RDS")
  })
  
  output$mymap2 <- renderLeaflet({
    readRDS("latest_run.RDS")
  })
  
  output$myplot <- renderPlot({
    readRDS("trendline.RDS")
  })
}