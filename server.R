library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)
library(plotly)
library(sf)
library(scales)
library(tibble)
library(radarchart)
library(fmsb)
library(RColorBrewer)

#setwd("C:/Users/Pablo/Desktop/UCM/Visualización Avanzada/Entrega")
# Cargamos los datos desde el desktop
timesData <- read.csv("timesData.csv")

#Transformamos total_score, international, income, num_students, income a numericos
timesData$total_score <- as.numeric(timesData$total_score)  
timesData$international <- as.numeric(timesData$international) 
timesData$num_students <- as.numeric(timesData$num_students) 
timesData$income <- as.numeric(timesData$income) 

# Distinguimos variables numericas de las categoricas
numeric <- sapply(timesData, is.numeric)
continuas <- names(timesData)[numeric]

# Tratamiento para variables categoricas, las cuales pasasmos a factor
categorical <- sapply(timesData, is.character)
categoricas <- names(timesData)[categorical]
timesData[categoricas] <- lapply(timesData[categoricas], factor)


shinyServer(function(input, output) {
  
  output$plot <- renderPlot({
    rank_resume<- timesData %>% group_by(world_rank) %>% summarise(n = mean(total_score))
    
    p <- timesData %>% group_by(world_rank) %>% ggplot( 
                aes_string(x=input$x, y = timesData$total_score,size=timesData$total_score)) + geom_point(alpha=0.3) + ylab('Total Score') 
    
    if (input$color != 'None')
    p<- p + aes_string(color= input$color)+theme(legend.position="none")+geom_text_repel(label = timesData$world_rank) 
    
    
    if (input$facet_row != 'None')
      p <- p + facet_wrap(~get(input$facet_row))
    
    
    if (input$lm)
      p <- p + geom_smooth(method='lm',formula=y~x, na.rm = T)
    if (input$smooth)
      p <- p + geom_smooth(method='loess',formula=y~x, na.rm = T)
    
    print(p)
    
  })

  output$plot2 <- renderPlot({
    top_rank<- timesData %>% group_by(world_rank) %>% summarise(n = mean(total_score)) %>% top_n(10,n) %>% ungroup() %>% arrange(desc(n))

    timesData  %>% filter(world_rank %in% top_rank$world_rank) %>%
      ggplot(aes(x=reorder(university_name,total_score), y=total_score, col=university_name)) + guides(col=FALSE) +
      geom_boxplot() +  theme_bw() + coord_flip() +
      labs(x="University", y="Rank by total Score", 
           title=paste("Rank in ",input$Year), subtitle="Top 10 mejores universidades") 
 
  })
  
  output$plot3 <-renderPlotly ({
    timeGrouped<-timesData %>% group_by(country,year) %>% 
      summarise(nr = length(world_rank), minw=min(as.numeric(world_rank)), maxw=max(as.numeric(world_rank)), avgw=round(mean(as.numeric(world_rank)),0)) %>%
      select(country, year, nr, minw, maxw, avgw) %>% ungroup()
    
    # Añadimos borde gris al mapa
    l <- list(color = toRGB("grey"), width = 0.5)
    timeGrouped$hover <- with(timeGrouped, 
                        paste("Country: ", country, '<br>', 
                              "Year: ",year, "<br>",
                              "Universities in top: ", nr, "<br>",
                              "Min rank in top: ", minw, "<br>",
                              "Max rank in top: ", maxw, "<br>",
                              "Mean rank in top: ", avgw,"<br>"
                        ))
    # especificamos opciones al mapa
    g <- list(
      showframe = TRUE,
      showcoastlines = TRUE,
      projection = list(type = 'orthogonal')
    )
    
    #Realizamos el plot del mapa
    z <- plot_geo(timeGrouped, locationmode = 'country names') %>%
      add_trace(
        z = ~nr, color = ~nr, colors = 'Spectral', frame = ~year,
        text = ~hover, locations=~country, marker = list(line = l)
      ) %>%
      colorbar(title = 'Number of\nuniversities in top', tickprefix = '') %>%
      layout(
        title = with(timeGrouped, paste('Number of universities in top<br>Source:<a href="http://timeshighereducation.com/">THE World University Ranking</a><br>')),
        geo = g
      )
    print(z)
  })

  output$plot4<- renderPlot({
    
    #Agrupamos los datos por top 10
    rank_top <-timesData %>% group_by(year) %>% 
    top_n(10, wt = total_score) %>% select(year,university_name,teaching,research,citations,student_staff_ratio, international, num_students, income, total_score)%>% ungroup()
    
    #Standarizamos las variable agrupada
    rank_top<- rank_top%>% mutate_at(vars(-c(university_name,year)), rescale)
    
    top10u<- rank_top %>% filter(year==input$year2) %>% ungroup() 
    top10 <- as.data.frame(cbind(top10u[,c(3,4,5,6,7,8,9)]))

    colnames(top10) <- c("Teaching", "Research", "Citations", "Ratios Stu", 
                         "International", "Number Stu", "Total Score")
    
    rownames(top10) <- top10u$university_name
    rmin <- apply(top10,2,min); rmax <- apply(top10,2,max)
    rmax <- 1
    rmin <- 0
    colors_border=c( "tomato", "blue", "gold", "green", "magenta", 
                     "yellow", "grey", "lightblue", "brown", "red", "lightgreen", "cyan" )
    par(mfrow=c(4,3))
    par(mar=c(1,1,5,1))
    for(i in 1:nrow(top10)){
      colorValue<-(col2rgb(as.character(colors_border[i]))%>% as.integer())/255
      radarchart(rbind(rmax,rmin,top10[i,]),
                 axistype=2 , 
                 pcol=rgb(colorValue[1],colorValue[2],colorValue[3], alpha = 1),
                 pfcol=rgb(colorValue[1],colorValue[2],colorValue[3], alpha = 0.5),
                 plwd=1 , plty=1,cglcol="grey", cglty=1, axislabcol="grey", cglwd=0.5,vlcex=0.7, 
                 title=rownames(top10[i,]))
    }
    title(paste0('\nTHE World University  Rankings top 10 (',input$year2,')'),outer=TRUE,col.main='black',cex.main=1.5)
  })

  

output$plot5<- renderPlot({
  Rank_values <- timesData %>% group_by(world_rank) %>% summarise(avg = mean(total_score))%>% top_n(10,avg)%>% arrange(desc(avg))%>% ungroup()
  k <- ggplot(aes(x = reorder(world_rank,avg), y = avg), data = Rank_values) + geom_bar(stat = "identity")
  print(k)
  
  timesData %>% filter(year==input$year3) %>% group_by(country) %>% 
    summarise(nr = length(world_rank)) %>%  top_n(10,nr) %>%
    ggplot(aes(x=reorder(country,nr), y=nr),fill=year) + guides(fill=FALSE)+
    geom_bar(stat="identity",position=position_dodge(0.2), fill="gold")+ theme_bw() + coord_flip()+
    labs(x="Country", y="Number of universities in top", 
         title="Number of universities", input$year3, subtitle="Top 10 countries - World University Rankings (CWUR)")
})

output$plot6<- renderPlot({
  timesData %>% filter(year==input$year3) %>% group_by(country)  %>% 
    summarise(mn = mean(income)) %>% top_n(10,mn) %>%
    ggplot(aes(x=reorder(country,mn), y=mn),fill=year) + guides(fill=FALSE) +
    geom_bar(stat="identity", fill="red", colour="black", position=position_dodge(0.2))+ theme_bw() + coord_flip() + 
    labs(x="Country", y="Total Score Income ", 
         title="Total Score Income ",input$year3, subtitle="Top 10 countries - Higher knowledge transfer)")
})

})

