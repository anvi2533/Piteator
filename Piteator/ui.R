library(markdown)
library(leaflet)

navbarPage(textOutput("title"),
           tabPanel("Totalt",
                    mainPanel(
                      tabsetPanel(
                        id = 'dataset1',
                        tabPanel("Karta", leafletOutput("mymap")),
                        tabPanel("Trendlinje", plotOutput("myplot"),textOutput("dev_text"))
                      )

                    )
           ),
           tabPanel("Tabell",
                    mainPanel(
                      tabsetPanel(
                        id = 'dataset2',
                        tabPanel("Weekly", DT::dataTableOutput("mytable1"), textOutput("text2")),
                        tabPanel("Monthly", DT::dataTableOutput("mytable2")),
                        tabPanel("Yearly", DT::dataTableOutput("mytable3"))
                      )
                    )
           ),
           tabPanel("Senaste rundan",
                    mainPanel(
                      tabsetPanel(
                        id = 'dataset3',
                        tabPanel("Karta", leafletOutput("mymap2"),textOutput("text"),"\n\nBest runs so far", DT::dataTableOutput("mytable5")),
                        tabPanel("Kilometerlista", DT::dataTableOutput("mytable4"))
                      )
                    )
           )
)