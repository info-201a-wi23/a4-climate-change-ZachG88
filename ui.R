library(plotly)
library(bslib)
library(tidyverse)

df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

co2pcc <- df %>% filter(co2_per_capita != "NA") %>% select(country, year, co2_per_capita)

my_theme <- bs_theme(
  bg = "#0b3d91", # background color
  fg = "white", # foreground color
  primary = "#FCC780", # primary color
)
# Update BootSwatch Theme
my_theme <- bs_theme_update(my_theme, bootswatch = "cerulean")

# Home page tab
intro_tab <- tabPanel(
  # Title of tab
  "Introduction",
  fluidPage(
    # Include a Markdown file!
    includeMarkdown("Introduction.Rmd")
  )
)

select_widget <-
  selectInput(
    inputId = "country_selection",
    label = "Geographic location",
    choices = co2pcc$country,
    selectize = TRUE,
    # True allows you to select multiple choices...
    multiple = TRUE,
    selected = 
  )

slider_widget <- sliderInput(
  inputId = "year_selection",
  label = "year",
  min = min(co2pcc$year),
  max = max(co2pcc$year),
  value = c(1750, 2021),
  sep = "")

# Put a plot in the middle of the page
main_panel_plot <- mainPanel(
  # Make plot interactive
  plotlyOutput(outputId = "country_plot")
)

# Data viz tab  — combine sidebar panel and main panel
viz_tab <- tabPanel(
  "Data Viz",
  sidebarLayout(
    sidebarPanel(
      select_widget,
      slider_widget
    ),
    main_panel_plot
  )
)

ui <- navbarPage(
  # Select Theme
  theme = my_theme,
  # Home page title
  "Home Page",
  intro_tab,
  viz_tab
)
