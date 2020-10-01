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




## Análisis de texto Taylor  Swift


release_dates <- charts %>%
  distinct(album = title, released) %>%
  mutate(album = fct_recode(album,
                            folklore = "Folklore",
                            reputation = "Reputation")) %>%
  mutate(released = str_remove(released, " \\(.*")) %>%
  mutate(released = mdy(released))

taylor_swift_words <- taylor_swift_lyrics %>%
  rename_all(str_to_lower) %>%
  select(-artist) %>%
  unnest_tokens(word, lyrics) %>%
  anti_join(stop_words, by = "word") %>%
  inner_join(release_dates, by = "album") %>%
  mutate(album = fct_reorder(album, released))


taylor_swift_words %>%
  count(word, sort = TRUE) %>%
  head(25) %>%
  mutate(word = fct_reorder(word, n)) %>%
  ggplot(aes(n, word)) +
  geom_col()



## Rama Beyonce
ts <- taylor_swift_lyrics %>%
  rename_all(str_to_lower) %>%
  rename(song = title) %>%
  select(-album)

beyonce <- beyonce_lyrics %>%
  select(artist = artist_name, song = song_name, lyrics = line)
artist_song_words_raw <- bind_rows(ts, beyonce) %>%
  unnest_tokens(word, lyrics) %>%
  count(artist, song, word)

artist_song_words <- artist_song_words_raw %>%
  anti_join(stop_words, by = "word")


by_artist_word <- artist_song_words %>%
  group_by(artist, word) %>%
  summarize(num_songs = n(),
            num_words = sum(n)) %>%
  mutate(pct_words = num_words / sum(num_words)) %>%
  group_by(word) %>%
  mutate(num_words_total = sum(num_words)) %>%
  ungroup()
word_differences <- by_artist_word %>%
  bind_log_odds(artist, word, num_words) %>%
  arrange(desc(abs(log_odds_weighted))) %>%
  filter(artist == "Beyoncé") %>%
  slice_max(num_words_total, n = 100, with_ties = FALSE) %>%
  slice_max(abs(log_odds_weighted), n = 25, with_ties = FALSE) %>%
  mutate(word = fct_reorder(word, log_odds_weighted)) %>%
  mutate(direction = ifelse(log_odds_weighted > 0, "Beyoncé", "Taylor Swift"))
word_differences %>%
  ggplot(aes(log_odds_weighted, word, fill = direction)) +
  geom_col() +
  scale_x_continuous(breaks = log(2 ^ seq(-6, 9, 3)),
                     labels = paste0(2 ^ abs(seq(-6, 9, 3)), "X")) +
  labs(x = "Relative use in Beyoncé vs Taylor Swift (weighted)",
       y = "",
       title = "Which words most distinguish Beyoncé and Taylor Swift songs?",
       subtitle = "Among the 100 words most used by the artists (combined)",
       fill = "")


## Anexos desde la rama Beyonce

x_labels <- paste0(2 ^ abs(seq(-6, 9, 3)), "X")
x_labels <- ifelse(x_labels == "1X", "Same", x_labels)
word_differences %>%
  ggplot(aes(log_odds_weighted, word)) +
  geom_col(width = .1) +
  geom_point(aes(size = num_words_total, color = direction)) +
  geom_vline(lty = 2, xintercept = 0) +
  scale_x_continuous(breaks = log(2 ^ seq(-6, 9, 3)),
                     labels = x_labels) +
  labs(x = "Relative use in Beyoncé vs Taylor Swift (weighted)",
       y = "",
       title = "Which words most distinguish Beyoncé and Taylor Swift songs?",
       subtitle = "Among the 100 words most used by the artists (combined)",
       color = "",
       size = "# of words\n(both artists)")