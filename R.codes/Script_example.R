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








