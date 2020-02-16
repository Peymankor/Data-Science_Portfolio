library(miniUI)
#install.packages("leaflet")
library(leaflet)
library(shiny)
library(tidyverse)
library(shinythemes)
library(aws.s3)
library(bootstraplib)
bs_theme_new(bootswatch = "sketchy")
bs_theme_add_variables(`body-bg` = "#0A0909", `body-color` = "#F9C110", 
                       `input-border-color` = "#30BBE7", primary = "#39ACDB")
#Sys.setenv("AWS_ACCESS_KEY_ID" = "AKIAJR5NC5GYMJ3Q6B6A",
#          "AWS_SECRET_ACCESS_KEY" = "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",
#         "AWS_DEFAULT_REGION" = "eu-north-1")


get_bucket(bucket = 'norwayemission')

years <- c("1990","1991","1992","1993",
           "1994","1995","1996","1997","1998","1999","2000","2001",
           "2002","2003","2004","2005","2006","2007","2008","2009",
           "2010","2011","2012","2013","2014","2015","2016","2017",
           "2018")
pol <- c("Carbon dioxide (CO2)", "Methane (CH4)", "Nitrous Oxide (N2O)")

ui <- miniPage(bootstrap(),
    gadgetTitleBar("Norway Emission Analytics @ Decarbonify"),
    miniTabstripPanel(
        miniTabPanel("Parameters", icon = icon("sliders"),
                     miniContentPanel(
                         selectInput("year", "Years", 
                                     choices=years),
                         selectInput("Pol", "Polutant", 
                                     choices=pol)
                     )
        ),
        miniTabPanel("Visualize", icon = icon("area-chart"),
                     miniContentPanel(
                         plotOutput('plot1', width = "100%", height = "800px")
                     )
        ),
        miniTabPanel("Data", icon = icon("table"),
                     miniContentPanel(
                         tableOutput("table")
                     )
        )
    )
)
server <- function(input, output) {
    output$plot1 <- renderPlot({
        # Fill in the spot we created for a plot
        data_tidy_sel_s3 <- read.csv(text = rawToChar(get_object(object =
                                                                     "s3://norwayemission/data_tidy_sel.csv")))
        data_plot <- data_tidy_sel_s3 %>% 
            filter(Year == input$year, Pol==input$Pol) %>% 
            top_n(n = 10, wt = Emission) %>% 
            select(Sr_act, Emission) 
        
        ggplot(data_plot,aes(x=reorder(Sr_act, -Emission), y=Emission, fill=Emission)) +
            geom_bar(stat="identity") +
            scale_fill_gradient2(low = "green", high ="red", mid = 'blue') + 
            theme_dark() +
            #    scale_fill_distiller(palette = "Spectral") +
            theme(axis.text.x = element_text(face = "bold", color = "#993333", 
                                             size = 12, angle = 45, hjust = 1)) +
            xlab("Source of Emission") +
            ylab("1000 Tonns") 
            #theme_dark()
    })
    
    aws <- reactive(read.csv(text = rawToChar(get_object(object =
                                                             "s3://norwayemission/data_tidy_sel.csv"))))
    
    new_data <- reactive(
         aws() %>% 
            filter(Year == input$year, Pol==input$Pol) %>% 
            top_n(n = 10, wt = Emission) %>% 
            select(Sr_act, Emission) 
        
    )
    output$table <- renderTable(
        new_data()
    )
    
    
}
shinyApp(ui, server)
