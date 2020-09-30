#==============================#
#         Ejemplo Código       #
#           Clase # 1          #
#        Curso NLP y Git       #
#==============================#

##  ¿Qué vamos hacer?
# Analizaremos las canciones de Taylor Swift Y Beyonce
# Haremos un poco de Text Mining y algo de  NLP

# Libraries --------------------

library(tidyverse)
library(tidytext)
library(widyr)
library(tidytuesdayR)
library(lubridate)
library(tidylo)
library(scales)


## Load data set  ------

beyonce_lyrics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-29/beyonce_lyrics.csv')
taylor_swift_lyrics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-29/taylor_swift_lyrics.csv')
sales <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-29/sales.csv')
charts <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-29/charts.csv')


## Exploratory Data Analysis -----

beyonce_lyrics %>%
  count(song_name, sort = TRUE)


sales %>%
  filter(country == "US") %>%
  mutate(title = fct_reorder(title, sales)) %>%
  ggplot(aes(sales, title, fill = artist)) +
  geom_col() +
  scale_x_continuous(labels = dollar) +
  labs(x = "Sales (US)",
       y = "",
       title = 'Relation Sales Beyonce/Taylor',
       subtitle = 'Total in Dollars')


top_contries<-sales%>%
  count(country, sort = TRUE)%>%
  top_n(3,n)


sales %>%
  filter(country %in% top_contries$country) %>%
  mutate(title = fct_reorder(title, sales)) %>%
  ggplot(aes(sales, title, fill = artist)) +
  geom_col() +
  scale_x_continuous(labels = dollar) +
  labs(x = "Sales (US)",
       y = "",
       title = 'Relation Sales Beyonce/Taylor',
       subtitle = 'Total in Dollars')+
  facet_wrap(~country,scales='free',nrow = 3)+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))


sales %>%
  filter(country %in% c("World", "WW")) %>%
  mutate(title = fct_reorder(title, sales)) %>%
  ggplot(aes(sales, title, fill = artist)) +
  geom_col() +
  scale_x_continuous(labels = dollar) +
  labs(x = "Sales (World)",
       y = "")+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
