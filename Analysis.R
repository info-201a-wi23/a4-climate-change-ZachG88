library(dplyr)

df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

# What is the average CO2 emissions per year globally (1750-2021) ?
avg_per_year <- df %>% filter(country == "World") %>% summarise(avg_co2 = mean(co2)) %>% pull(avg_co2)

# Which country has the lowest overall average recorded CO2 emissions (1750-2021) ?
countries <- read.csv("https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/all/all.csv") %>% select(name)

average_co2_yearly <- df %>% 
    filter(co2 != "NA") %>% 
    group_by(country) %>% 
    summarise(mean_co2_pyear = mean(co2)) 

average_co2_yearly <- dplyr::filter(average_co2_yearly, country %in% countries$name) 

lowest_country <- average_co2_yearly[which.min(average_co2_yearly$mean_co2_pyear),] %>% pull(country)
lowest_amount <- average_co2_yearly[which.min(average_co2_yearly$mean_co2_pyear),] %>% pull(mean_co2_pyear)

# Which country has the highest overall average recorded CO2 emissions ?
highest_country <- average_co2_yearly[which.max(average_co2_yearly$mean_co2_pyear),] %>% pull(country)
highest_amount <- average_co2_yearly[which.max(average_co2_yearly$mean_co2_pyear),] %>% pull(mean_co2_pyear)


# Over the last 100 years, how has the global co2 per capita changed ?
co2pc <- df %>% filter(year >= 1921, country == "World") %>% select(country, year, co2_per_capita)

co2pc_min <- co2pc %>% summarise(co2pc = min(co2_per_capita)) %>% pull(co2pc)
co2pc_max <- co2pc %>% summarise(co2pc = max(co2_per_capita)) %>% pull(co2pc)

change_co2pc <- co2pc_max - co2pc_min

# Over the last 100 years, how has the global co2 per gdp changed ? 

co2pgdp <- df %>% filter(year >= 1921, country == "World", co2_per_gdp != "NA") %>% select(country, year, co2_per_gdp)

co2pgdp_min <- co2pgdp %>% summarise(co2pgdp = min(co2_per_gdp)) %>% pull(co2pgdp)
co2pgdp_max <- co2pgdp %>% summarise(co2pgdp = max(co2_per_gdp)) %>% pull(co2pgdp)

change_co2pgdp <- co2pgdp_max - co2pgdp_min

## Building space

co2pcc <- df %>% filter(co2_per_capita != "NA") %>% select(country, year, co2_per_capita)

co2pcc_countries <- dplyr::filter(co2pcc, country %in% countries$name) 

