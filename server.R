library(ggplot2)
library(plotly)
library(dplyr)
library(tidyverse)

df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

co2pcc <- df %>% filter(co2_per_capita != "NA") %>% select(country, year, co2_per_capita)

server <- function(input, output) {
  
  output$country_plot <- renderPlotly({
    
    filtered_df <- co2pcc %>%
      # Filter for user's gender selection
      filter(country %in% input$country_selection) 
    # Filter for user's year selection
    
    
    # Line plot
    country_plot <- ggplot(data = filtered_df) +
      geom_line(mapping =
                  aes(x = year,
                      y = co2_per_capita,
                      color = country)) +
      labs(title = "Channge of co2/capita over time", x = "Year", y = "Co2(kg) per USD")
    
    return(country_plot)
    
  })
  
}