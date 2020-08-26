library(readxl)
library(ggplot2)
library(dplyr)
require(maps)
require(viridis)
theme_set(
  theme_void()
)

setwd("~/github/gbif")

# Countries
countries <- c(
  "USA","Mexico","Canada","Brazil","Chile","Argentina","Ecuador","Venezuela","Belize",
  "El Salvador","Colombia"
)
# Retrieve the map data
maps <- map_data("world", region = countries)

# Compute the centroid as the mean longitude and latitude
# Used as label coordinate for country's names
region.lab.data <- maps %>%
  group_by(region) %>%
  summarise(long = mean(long), lat = mean(lat))

ggplot(maps, aes(x = long, y = lat)) +
  geom_polygon(aes( group = group, fill = region))+
  geom_text(aes(label = region), data = region.lab.data,  size = 3, hjust = 0.5)+
  scale_fill_viridis_d()+
  theme_void()+
  theme(legend.position = "none")
