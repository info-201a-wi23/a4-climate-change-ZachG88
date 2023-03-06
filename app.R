library(shiny)
library(tidyverse)
library(rsconnect)

source("ui.R")
source("server.R")
library(rsconnect)



shinyApp(ui = ui, server = server)

deployApp()