library(fpp3)
library(here)
library(neonUtilities)
library(tidyverse)
library(jsonlite)


## Section to handle all sites weekly means for time series chart and choropleth 
subdirectory <- here(
    'data',
    'NEON_conc-co2-soil',
    'stackedFiles'
)

raw_co2_data <- readTableNEON(
    dataFile = here(subdirectory, 'SCO2C_30_minute.csv'),
    varFile = here(subdirectory, 'variables_00095.csv')
)

## Get mean daily value for CO2 concentration and drop NAs
grouped_co2 <- raw_co2_data %>%
    group_by(siteID, endDateTime) %>%
    summarize(mean_of_mean = mean(soilCO2concentrationMean, na.rm=T)) %>%
    filter(!is.na(mean_of_mean)) %>%
    mutate(endDate = date(endDateTime)) %>%
    select(-endDateTime) %>%
    group_by(siteID, endWeek = cut(endDate, "week")) %>%
    summarize(daily_mean_of_mean = mean(mean_of_mean))

json_grouped_co2 <- grouped_co2 %>%
    pivot_wider(names_from= siteID, values_from = daily_mean_of_mean) %>%
    replace_na(list(BONA = 0, DEJU = 0,
                    BARR = 0, HEAL = 0,
                    TOOL = 0)) %>%
    arrange(endWeek)

jsonlite::write_json(json_grouped_co2, path="weekly_mean_of_means_zero.json")


## Section to handle sensor depths 
df_sensor_depths <- jsonlite::fromJSON("weekly_co2_sensor_depths.json") %>% as.data.frame

df_sensor_depths_filtered <- df_sensor_depths %>%
    filter(!(siteID %in% c('BARR','TOOL'))) %>%
    rename(w_mean = mean.of.mean, verPos = verticalPosition) %>%
    replace_na(list(w_mean=0))

df_sensor_depths_filtered$w_mean <- as.integer(df_sensor_depths_filtered$w_mean)

jsonlite::write_json(df_sensor_depths_filtered, 'weekly_co2_sensors_depth_3_sites.json')

df_sensor_depths_filtered <- jsonlite::fromJSON('weekly_co2_sensors_depth_3_sites.json') %>%
    pivot_wider(names_from=verPos, values_from=w_mean)
jsonlite::write_json(df_sensor_depths_filtered, 'weekly_co2_sensors_depth_3_sites.json')

## Section to convert float to int for all sites
df_sensor_thresholds <- fromJSON("co2_by_threshold_two_sensor_shortcol.json")
df_sensor_thresholds$co2 <- as.integer(df_sensor_thresholds$co2)
jsonlite::write_json(df_sensor_thresholds, "co2_by_threshold_two_sensor_shortcol_ints.json")
