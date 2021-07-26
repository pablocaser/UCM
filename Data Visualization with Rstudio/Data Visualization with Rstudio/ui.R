library(shiny)
library(ggplot2)
library(ggrepel)
#setwd("C:/Users/Pablo/Desktop/UCM/Visualización Avanzada/Entrega")
# Cargamos los datos desde el repositorio github del módulo 

timesData <- read.csv("timesData.csv")

#Transformamos total_score a numerica
timesData$total_score <- as.numeric(timesData$total_score)
timesData$international <- as.numeric(timesData$international) 
timesData$num_students <- as.numeric(timesData$num_students) 
timesData$income <- as.numeric(timesData$income)

# distinguimos variables "a nivel de intervalo" ("continuas" para ggplot)
numeric <- sapply(timesData, is.numeric)
continuas <- names(timesData)[numeric]

# y variables "categóricas" ("discretas" para ggplot)
categorical <- sapply(timesData, is.character)
categoricas <- names(timesData)[categorical]
timesData[categoricas] <- lapply(timesData[categoricas], factor)

shinyUI(
  navbarPage("World Universwity Ranking",
             tabPanel("Introducción al trabajo",
                    sidebarLayout(position = "left",
                      sidebarPanel(
                        h2("Dataset de estudio"),
                        p("Consta de un total de 2603 registros, 14 variables "),
                        a("https://www.kaggle.com/mylesoneill/world-university-rankings?select=timesData.csv"),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        "THE World University Rankings ", 
                        span("RStudio", style = "color:blue")
                      ),
                      mainPanel(
                        h1("Ejercicio Visualización Avanzada", align = "center"),
                        h2("Propuesto por Pablo María Casero Palmero", align = "left"),
                        strong("THE World University Rankings, es la lista definitiva de las mejores universidades a nivel mundial, 
                        que incluye más de 1250 instituciones en 86 países en 2019"),
                        p("-Análisis de la muestra del top 10: se trata del analizar la posición en el ranking de universidades nivel mundial"),
                        p("-Estudio de indicadores: Correlación entre los factores determinantes para situar una universidad entre las mejores del mundo "),
                        
                        p(""),
                        p(""),
                        
                        h2("Conlusiones del estudio", align = "left"),
                        h3("Acerca del Estudio Indicadores:"),
                        p("1.1) Es más evidente la relación estrecha entre docencia e investigación donde la correlación es positiva (R>0.3) y creciente según sea el ranking mayor."),
                        p("1.2) Caso de las publicaciones no es tan directa con respecto a la docencia y los mejores situados en el ranking quedan al margen sin verse afectados por aumentos en el número de publicaciones"),
                        
                        h3("Análisis de la muestra del top 10"),
                        p("2.1) EEUU es el país que más universidades engloba en el ranking, además de situarse como el país que mejores puestos ocupa "),
                        p("2.2) Paises de america del norte y centroeuropa concentran mejores puntuaciones totales, las cuales agrupan los mejores centros universitarios del top 10"),
                        p("2.3) No necesariamente las universidades que mejores recursos económicos dispongan consiguen mejor resultado"),
                        
                        p("Finalmente, Obtener mejores resultados en categorías como docencia o investigación no tiene la misma implicación que en categorías como ingresos. Si bien parece indicar que en ambos casos (investigación y docencia) refuerzan aun más el puesto en el ranking que el resto de indicadores, 
                          de que tradicionalmente las que vienen siendo las mejores centros universitarios del mundos apenas varíande entre los cinco primeros y se distnacian mucho del resto de puestos"),
                      ))
                    ),

             tabPanel("Estudio de los indicadores",
                  sidebarLayout(position = "right",
                      sidebarPanel(

                        selectInput('x', h4('Elige variable para eje X'), continuas, continuas[[1]]),
                        selectInput("color", h4("Seleccione color por ranking"),
                                     c("None" = "None", "World Rank" = "world_rank")),
                                     
                        checkboxInput('lm', h4('Línea de Regresión')),
                        checkboxInput('smooth', h4('Suavizado LOESS')),
                        
                        selectInput("facet_row", h4("Elige variable para facetas por filas"),c("None", "Year" = "year", "Country" = "country"))
                        
                      ),
                      mainPanel(
                        plotOutput('plot',
                                   height=400))),
                  
                  
                  sidebarLayout(position = "left",
                      sidebarPanel(
                        selectInput("year2", h4("Seleccione año"), 
                                    choices = list("2011" = 2011, "2012" = 2012,
                                                   "2013" = 2013, "2014" = 2014, "2015" = 2015, "2016" = 2016), selected = 1)),
                      
                      mainPanel(
                        plotOutput('plot4',
                                   height=500)
                      ))
             ),
             tabPanel("Análisis del top 10",
                    h1("Análisis del top 10 de las mejores universidades", align = "center"),
                    p("El análisis se reduce a las 10 mejores del ranking de las universidades de 2011 a 2016 y el papel que juega cada uno de los indicadores en el ranking mundial",align = "center"),
                    sidebarLayout(position = "right",
                      sidebarPanel(
                        selectInput("year3", h4("Seleccione año"), 
                                    choices = list("2011" = 2011, "2012" = 2012,
                                                   "2013" = 2013, "2014" = 2014, "2015" = 2015, "2016" = 2016), selected = 1)),
                        mainPanel(
                          plotOutput('plot2',
                          height=300),
                          
                          br(),
                          br(),
                          br(),
                          
                          plotlyOutput('plot3',
                          height=400),
                          
                          plotOutput('plot5', height=300),
                          plotOutput('plot6', height=300)
                        ))


               
             )
    
             
  ))
