Introducción al Text Mining
================

``` r
library(tidyverse) # Manipulación de datos
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──

    ## ✓ ggplot2 3.3.2     ✓ purrr   0.3.4
    ## ✓ tibble  3.0.4     ✓ dplyr   1.0.2
    ## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
    ## ✓ readr   1.4.0     ✓ forcats 0.5.0

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(tidytext) # Manipulación de textos
library(tm) #  Procesamiento de mega-data y creación de corpus
```

    ## Loading required package: NLP

    ## 
    ## Attaching package: 'NLP'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     annotate

``` r
library(topicmodels) # Agrupación de textos por tema
library(wordcloud) # Nube de palabras
```

    ## Loading required package: RColorBrewer

``` r
library(ggraph)
library(ggrepel)
library(widyr)
library(stopwords)
```

    ## 
    ## Attaching package: 'stopwords'

    ## The following object is masked from 'package:tm':
    ## 
    ##     stopwords

``` r
library(tidygraph)
```

    ## 
    ## Attaching package: 'tidygraph'

    ## The following object is masked from 'package:stats':
    ## 
    ##     filter

``` r
library(stm)
```

    ## stm v1.3.6 successfully loaded. See ?stm for help. 
    ##  Papers, resources, and other materials at structuraltopicmodel.com

``` r
stop_words_es<-stopwords::stopwords(language = "spanish")
```

``` r
hawai<-read_csv('../Bases_de_datos/hawai.txt',col_names = FALSE)%>%
  rename(Letra=X1)
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   X1 = col_character()
    ## )

    ## Warning: 23 parsing failures.
    ## row col  expected    actual                          file
    ##   3  -- 1 columns 3 columns '../Bases_de_datos/hawai.txt'
    ##   4  -- 1 columns 2 columns '../Bases_de_datos/hawai.txt'
    ##   7  -- 1 columns 2 columns '../Bases_de_datos/hawai.txt'
    ##  10  -- 1 columns 2 columns '../Bases_de_datos/hawai.txt'
    ##  11  -- 1 columns 2 columns '../Bases_de_datos/hawai.txt'
    ## ... ... ......... ......... .............................
    ## See problems(...) for more details.

``` r
hawai_df<-hawai%>%
  tibble(line=1:50,texto=Letra)
hawai_df
```

    ## # A tibble: 50 x 3
    ##    Letra                                line texto                              
    ##    <chr>                               <int> <chr>                              
    ##  1 Deja de mentirte (ah)                   1 Deja de mentirte (ah)              
    ##  2 La foto que subiste con él diciend…     2 La foto que subiste con él diciend…
    ##  3 Bebé                                    3 Bebé                               
    ##  4 No te diré quién                        4 No te diré quién                   
    ##  5 Por mí te vieron                        5 Por mí te vieron                   
    ##  6 Déjame decirte                          6 Déjame decirte                     
    ##  7 Se ve que él te trata bien              7 Se ve que él te trata bien         
    ##  8 Pero eso no cambiará que yo llegué…     8 Pero eso no cambiará que yo llegué…
    ##  9 Sé que te va ir bien pero no te qu…     9 Sé que te va ir bien pero no te qu…
    ## 10 Puede que no te haga falta na'         10 Puede que no te haga falta na'     
    ## # … with 40 more rows

## Partir la canción por palabras

``` r
hawai_df%>%
  unnest_tokens(word,Letra)%>%
  filter(!word %in% stop_words_es)%>%
  count(word,sort=TRUE)
```

    ## # A tibble: 76 x 2
    ##    word          n
    ##    <chr>     <int>
    ##  1 na            6
    ##  2 va            6
    ##  3 bien          4
    ##  4 falta         4
    ##  5 haga          4
    ##  6 hawái         4
    ##  7 instagram     4
    ##  8 lindo         4
    ##  9 pa            4
    ## 10 posteas       4
    ## # … with 66 more rows

``` r
hawai_df%>%
  unnest_tokens(word,Letra)%>%
  filter(!word %in% stop_words_es)%>%
  count(word,sort=TRUE)%>%
  mutate(word=fct_reorder(word,n))%>%
  top_n(20)%>%
  ggplot(aes(n,word))+
  geom_col()+
  labs(title = 'Base de datos sucia',
       subtitle = 'De esta forma no se debe análizar un texto')
```

    ## Selecting by n

![](Introducción-al-Text-Mining_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

Un poco de limpieza, como hay muchas contracciones se eliminan las
palabras de dos caracteres

``` r
hawai_df%>%
  unnest_tokens(word,Letra)%>%
  filter(!word %in% stop_words_es)%>%
  mutate(word=gsub('\\b[[:alpha:]]{1,3}\\b','',word))%>%
  filter(word!='')%>%
  count(word,sort=TRUE)%>%
  mutate(word=fct_reorder(word,n))%>%
  top_n(20)%>%
  ggplot(aes(n,word))+
  geom_col()+
  labs(title = 'Frecuencia de las palabras más usadas',
       subtitle = 'En la canción de Hawai')
```

    ## Selecting by n

![](Introducción-al-Text-Mining_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

Ahora se estudia la frecuencia de palabra en un rango, esta de ley de
Zipf

``` r
total_words<-hawai_df%>%
  unnest_tokens(word,Letra)%>%
  count(word,sort=TRUE)
total_words<-sum(total_words$n) 

freq_words<-hawai_df%>%
  unnest_tokens(word,Letra)%>%
  filter(!word %in% stop_words_es)%>%
  mutate(word=gsub('\\b[[:alpha:]]{1,3}\\b','',word))%>%
  filter(word!='')%>%
  count(word,sort=TRUE)%>%
  mutate(rank=row_number(),
         frequency=n/total_words)
```

``` r
freq_words %>%
  ggplot(aes(rank,frequency , group=1)) +
  geom_line(size = 1.1, alpha = 0.8, show.legend = FALSE) +
  labs(title = 'Relación en el uso de palabras con pendiente Negativa',
       subtitle = 'en la canción Hawai')
```

![](Introducción-al-Text-Mining_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

Modelo de Zipf

``` r
freq_words
```

    ## # A tibble: 67 x 4
    ##    word           n  rank frequency
    ##    <chr>      <int> <int>     <dbl>
    ##  1 bien           4     1   0.0142 
    ##  2 falta          4     2   0.0142 
    ##  3 haga           4     3   0.0142 
    ##  4 hawái          4     4   0.0142 
    ##  5 instagram      4     5   0.0142 
    ##  6 lindo          4     6   0.0142 
    ##  7 posteas        4     7   0.0142 
    ##  8 puede          4     8   0.0142 
    ##  9 vacaciones     4     9   0.0142 
    ## 10 ahora          2    10   0.00709
    ## # … with 57 more rows

``` r
fit<-lm(frequency~rank,data=freq_words)
fit
```

    ## 
    ## Call:
    ## lm(formula = frequency ~ rank, data = freq_words)
    ## 
    ## Coefficients:
    ## (Intercept)         rank  
    ##   0.0107634   -0.0001469

Está es la versión clásica de la ley de Zipf

``` r
equatiomatic::extract_eq(fit,use_coefs = TRUE)
```

    ## $$
    ## \operatorname{frequency} = 0.01 + 0(\operatorname{rank}) + \epsilon
    ## $$

\[
\operatorname{frequency} = 0.01 + 0(\operatorname{rank}) + \epsilon
\]

Ahora se genera la pendiente

``` r
freq_words %>%
  ggplot(aes(rank,frequency , group=1)) +
  geom_abline(intercept = 0.01, slope = -0.0001469 , color = "gray50", linetype = 2) +
  geom_line(size = 1.1, alpha = 0.8, show.legend = FALSE) +
  # scale_x_log10() +
  # scale_y_log10()+
  labs(title = 'Relación en el uso de palabras con pendiente Negativa',
       subtitle = 'en la canción Hawai')
```

![](Introducción-al-Text-Mining_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

La idea de tf-idf es encontrar las palabras importantes para el
contenido de cada documento disminuyendo el peso de las palabras de uso
común y aumentando el peso de las palabras que no se usan mucho en una
colección o corpus de documentos, en este caso, el grupo de novelas de
Jane Austen en su conjunto. El cálculo de tf-idf intenta encontrar las
palabras que son importantes (es decir, comunes) en un texto, pero no
demasiado comunes. Hagámoslo ahora.

``` r
freq_words<-hawai_df%>%
  unnest_tokens(word,Letra)%>%
  filter(!word %in% stop_words_es)%>%
  mutate(word=gsub('\\b[[:alpha:]]{1,3}\\b','',word))%>%
  filter(word!='')%>%
  count(word,sort=TRUE)

hawai_tf_idf<-freq_words%>%
  left_join(hawai_df%>%
  unnest_tokens(word,Letra)%>%
  filter(!word %in% stop_words_es)%>%
  mutate(word=gsub('\\b[[:alpha:]]{1,3}\\b','',word))%>%
  filter(word!=''), by='word')%>%
  distinct(word,.keep_all = TRUE)%>%
  bind_tf_idf(word, line, n)%>%
  select(-texto)

hawai_tf_idf %>%
  arrange(desc(tf_idf))
```

    ## # A tibble: 67 x 6
    ##    word          n  line    tf   idf tf_idf
    ##    <chr>     <int> <int> <dbl> <dbl>  <dbl>
    ##  1 bebé          2     3     1  3.47   3.47
    ##  2 cómo          2    13     1  3.47   3.47
    ##  3 vieron        2     5     1  3.47   3.47
    ##  4 baby          1    32     1  3.47   3.47
    ##  5 fuimo         1    23     1  3.47   3.47
    ##  6 hablar        1    29     1  3.47   3.47
    ##  7 jaja          1    48     1  3.47   3.47
    ##  8 maluma        1    46     1  3.47   3.47
    ##  9 mamacita      1    44     1  3.47   3.47
    ## 10 preguntas     1    27     1  3.47   3.47
    ## # … with 57 more rows

Visualizar la importancia del texto

``` r
hawai_tf_idf%>%
  arrange(desc(tf_idf))%>%
  mutate(word=fct_reorder(word,tf_idf))%>%
  top_n(15)%>%
  ggplot(aes(tf_idf,word,fill=tf_idf))+
  geom_col()+
  labs(title = 'Entendimiento por nivel de importancia de las palabras',
       subtitle = 'En la canción')
```

    ## Selecting by tf_idf

![](Introducción-al-Text-Mining_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

Ahora analicemos esta canción por grupos de palabras , esto se hara con
un token de tres palabras

``` r
hawai_ngram<-hawai_df%>%
  unnest_tokens(ngram,Letra,token = 'ngrams',n=2)

hawai_ngram%>%
  count(ngram,sort=TRUE)%>%
  filter(!is.na(ngram))
```

    ## # A tibble: 144 x 2
    ##    ngram             n
    ##    <chr>         <int>
    ##  1 no te             7
    ##  2 que yo            5
    ##  3 te va             5
    ##  4 de vacaciones     4
    ##  5 en instagram      4
    ##  6 falta na          4
    ##  7 haga falta        4
    ##  8 hawái de          4
    ##  9 instagram lo      4
    ## 10 lindo en          4
    ## # … with 134 more rows

Ahora se hace una separación de las palabras

``` r
hawai_ngram_filter<-hawai_ngram%>%
  count(ngram,sort=TRUE)%>%
  filter(!is.na(ngram))%>%
  separate(ngram, c("word1", "word2"), sep = " ")%>%
  filter(!word1 %in% c('na'))%>%
  filter(!word2 %in% c('na'))%>%
  filter(!word1 %in% stop_words_es)%>%
  filter(!word2 %in% stop_words_es)

hawai_ngram_filter
```

    ## # A tibble: 13 x 3
    ##    word1    word2       n
    ##    <chr>    <chr>   <int>
    ##  1 haga     falta       4
    ##  2 diré     quién       2
    ##  3 vea      cómo        2
    ##  4 déjame   decirte     1
    ##  5 déjame   hablar      1
    ##  6 gana     ninguno     1
    ##  7 ir       bien        1
    ##  8 llegué   primero     1
    ##  9 mentirte ah          1
    ## 10 papi     juancho     1
    ## 11 si       después     1
    ## 12 trata    bien        1
    ## 13 va       ir          1

``` r
bigram_counts <- hawai_ngram_filter %>%
  count(word1, word2, sort = TRUE)
bigram_counts
```

    ## # A tibble: 13 x 3
    ##    word1    word2       n
    ##    <chr>    <chr>   <int>
    ##  1 déjame   decirte     1
    ##  2 déjame   hablar      1
    ##  3 diré     quién       1
    ##  4 gana     ninguno     1
    ##  5 haga     falta       1
    ##  6 ir       bien        1
    ##  7 llegué   primero     1
    ##  8 mentirte ah          1
    ##  9 papi     juancho     1
    ## 10 si       después     1
    ## 11 trata    bien        1
    ## 12 va       ir          1
    ## 13 vea      cómo        1

Ahora unimos las palabras para entender el contexto

``` r
bigram_filtrado<-hawai_ngram%>%
  filter(!is.na(ngram))%>%
  separate(ngram, c("word1", "word2"), sep = " ")%>%
  filter(!word1 %in% c('na'))%>%
  filter(!word2 %in% c('na'))%>%
  filter(!word1 %in% stop_words_es)%>%
  filter(!word2 %in% stop_words_es)%>%
  select(-texto)

bigram_filtrado
```

    ## # A tibble: 18 x 3
    ##     line word1    word2  
    ##    <int> <chr>    <chr>  
    ##  1     1 mentirte ah     
    ##  2     4 diré     quién  
    ##  3     6 déjame   decirte
    ##  4     7 trata    bien   
    ##  5     8 llegué   primero
    ##  6     9 va       ir     
    ##  7     9 ir       bien   
    ##  8    10 haga     falta  
    ##  9    13 vea      cómo   
    ## 10    14 haga     falta  
    ## 11    22 si       después
    ## 12    26 gana     ninguno
    ## 13    29 déjame   hablar 
    ## 14    33 haga     falta  
    ## 15    36 vea      cómo   
    ## 16    37 haga     falta  
    ## 17    47 diré     quién  
    ## 18    50 papi     juancho

``` r
bigrams_unido <- bigram_filtrado %>%
  unite(bigram, word1, word2, sep = " ")
bigrams_unido
```

    ## # A tibble: 18 x 2
    ##     line bigram        
    ##    <int> <chr>         
    ##  1     1 mentirte ah   
    ##  2     4 diré quién    
    ##  3     6 déjame decirte
    ##  4     7 trata bien    
    ##  5     8 llegué primero
    ##  6     9 va ir         
    ##  7     9 ir bien       
    ##  8    10 haga falta    
    ##  9    13 vea cómo      
    ## 10    14 haga falta    
    ## 11    22 si después    
    ## 12    26 gana ninguno  
    ## 13    29 déjame hablar 
    ## 14    33 haga falta    
    ## 15    36 vea cómo      
    ## 16    37 haga falta    
    ## 17    47 diré quién    
    ## 18    50 papi juancho

Ahora analicemos la palabra `no`

``` r
library(tidyr)
hawai_ngram%>%
  select(-texto)%>%
  separate(ngram, c("word1", "word2"), sep = " ")%>%
  filter(!word1 %in% c('na'))%>%
  filter(!word2 %in% c('na'))%>%
  # filter(!word1 %in% stop_words_es)%>%
  # filter(!word2 %in% stop_words_es)%>%
  na.omit()%>%
  count(word1, word2, sort = TRUE)
```

    ## # A tibble: 142 x 3
    ##    word1     word2          n
    ##    <chr>     <chr>      <int>
    ##  1 no        te             7
    ##  2 que       yo             5
    ##  3 te        va             5
    ##  4 de        vacaciones     4
    ##  5 en        instagram      4
    ##  6 haga      falta          4
    ##  7 hawái     de             4
    ##  8 instagram lo             4
    ##  9 lindo     en             4
    ## 10 lo        que            4
    ## # … with 132 more rows

``` r
bigram_hawai<-hawai_ngram%>%
  select(-texto)%>%
  separate(ngram, c("word1", "word2"), sep = " ")%>%
  filter(!word1 %in% c('na'))%>%
  filter(!word2 %in% c('na'))%>%
  # filter(!word1 %in% stop_words_es)%>%
  # filter(!word2 %in% stop_words_es)%>%
  na.omit()%>%
  count(word1, word2, sort = TRUE)
```

``` r
bigram_hawai%>%
  filter(word2=='no')%>%
  ggplot(aes(reorder(word1,n),n))+
  geom_col()+
  coord_flip()
```

![](Introducción-al-Text-Mining_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->

Ahora analicemos el contexto de la canción

``` r
hawai_words<-hawai_df%>%
  unnest_tokens(word,Letra)%>%
  filter(!word %in% stop_words_es)%>%
  add_count(word,name='total_words')%>%
  filter(total_words>1)%>%
  select(-texto)

hawai_words
```

    ## # A tibble: 89 x 3
    ##     line word     total_words
    ##    <int> <chr>          <int>
    ##  1     1 deja               2
    ##  2     1 mentirte           2
    ##  3     2 foto               2
    ##  4     2 subiste            2
    ##  5     2 diciendo           2
    ##  6     2 cielo              2
    ##  7     3 bebé               2
    ##  8     4 diré               2
    ##  9     4 quién              2
    ## 10     5 vieron             2
    ## # … with 79 more rows

Ahora analicemos las correlaciones de las palabras

``` r
hawai_words%>%
  pairwise_cor(word,line,sort=TRUE, upper=FALSE)
```

    ## Warning: `tbl_df()` is deprecated as of dplyr 1.0.0.
    ## Please use `tibble::as_tibble()` instead.
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_warnings()` to see where this warning was generated.

    ## # A tibble: 406 x 3
    ##    item1    item2    correlation
    ##    <chr>    <chr>          <dbl>
    ##  1 deja     mentirte        1.  
    ##  2 foto     subiste         1.  
    ##  3 foto     diciendo        1.  
    ##  4 subiste  diciendo        1.  
    ##  5 foto     cielo           1.  
    ##  6 subiste  cielo           1.  
    ##  7 diciendo cielo           1.  
    ##  8 diré     quién           1.  
    ##  9 amor     compra          1.  
    ## 10 puede    haga            1.00
    ## # … with 396 more rows

la palabra foto adquiere una nueva importancia

``` r
hawai_words%>%
  pairwise_cor(word,line,sort=TRUE, upper=FALSE)%>%
  filter(item1 == 'foto')
```

    ## # A tibble: 26 x 3
    ##    item1 item2    correlation
    ##    <chr> <chr>          <dbl>
    ##  1 foto  subiste       1.    
    ##  2 foto  diciendo      1.    
    ##  3 foto  cielo         1.    
    ##  4 foto  bebé         -0.0556
    ##  5 foto  diré         -0.0556
    ##  6 foto  quién        -0.0556
    ##  7 foto  vieron       -0.0556
    ##  8 foto  déjame       -0.0556
    ##  9 foto  cómo         -0.0556
    ## 10 foto  amor         -0.0556
    ## # … with 16 more rows

Ahora veamos como se contraponen con respecto a esta palabra

``` r
hawai_words%>%
  pairwise_cor(word,line,sort=TRUE, upper=FALSE)%>%
  filter(item1 == 'foto')%>%
  mutate(item2=fct_reorder(item2,correlation))%>%
  ggplot(aes(correlation,item2,fill=correlation>0))+
  geom_col()+
  labs(title = 'Correlación de la palabra foto con el resto del texto',
       fill= 'Correlation')
```

![](Introducción-al-Text-Mining_files/figure-gfm/unnamed-chunk-25-1.png)<!-- -->

Ahora analicemos toda la canción

``` r
words_count<-hawai_words%>%
  count(word,sort = TRUE)

hawai_words%>%
  pairwise_cor(word,line,sort=TRUE)%>%
  head(500)%>%
  as_tbl_graph()%>%
  left_join(words_count,by=c(name='word'))%>%
  ggraph(layout = 'fr')+
  geom_edge_link(aes(edge_alpha=correlation))+
  geom_node_point(aes(size=n))+
  geom_node_text(aes(label=name),
                 check_overlap=TRUE,
                 vjust=2,
                 hjust=1,
                 size=3)
```

![](Introducción-al-Text-Mining_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

## Ahora se desarrolla el topic

``` r
library(stm)
hawai_matrix<-hawai_words%>%
  group_by(word)%>%
  filter(total_words>1)%>%
  cast_sparse(line, word, total_words)

topic_model_1 <- stm(hawai_matrix,
                     K = 2,
                     verbose = TRUE,
                     init.type = "Spectral",
                     emtol = 5)
```

    ## Warning in stm(hawai_matrix, K = 2, verbose = TRUE, init.type = "Spectral", :
    ## K=2 is equivalent to a unidimensional scaling model which you may prefer.

    ## Beginning Spectral Initialization 
    ##   Calculating the gram matrix...
    ##   Finding anchor words...
    ##      ..
    ##   Recovering initialization...
    ##      
    ## Initialization complete.
    ## ......................................
    ## Completed E-Step (0 seconds). 
    ## Completed M-Step. 
    ## Completing Iteration 1 (approx. per word bound = -3.075) 
    ## ......................................
    ## Completed E-Step (0 seconds). 
    ## Completed M-Step. 
    ## Model Converged

``` r
topic_model_1
```

    ## A topic model with 2 topics, 38 documents and a 29 word dictionary.

``` r
tidy(topic_model_1) %>%
  filter(topic=='1')%>%
  filter(!term %in% stop_words_es)%>%
  filter(!term %in% c('va','na'))%>%
  group_by(topic) %>%
  top_n(12, beta) %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(beta, term, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  scale_y_reordered() +
  facet_wrap(~ topic, scales = "free_y")
```

![](Introducción-al-Text-Mining_files/figure-gfm/unnamed-chunk-28-1.png)<!-- -->

``` r
hawai_words
```

    ## # A tibble: 89 x 3
    ##     line word     total_words
    ##    <int> <chr>          <int>
    ##  1     1 deja               2
    ##  2     1 mentirte           2
    ##  3     2 foto               2
    ##  4     2 subiste            2
    ##  5     2 diciendo           2
    ##  6     2 cielo              2
    ##  7     3 bebé               2
    ##  8     4 diré               2
    ##  9     4 quién              2
    ## 10     5 vieron             2
    ## # … with 79 more rows

``` r
topic_model_gamma <- tidy(topic_model_1, matrix = "gamma") %>%
  mutate(lines = rownames(hawai_matrix)[document]) 

topic_model_gamma %>%
  group_by(topic) %>%
  top_n(1, gamma)%>%
  left_join(hawai_words,by=c('document'='line'))%>%
  filter(total_words==max(total_words))
```

    ## # A tibble: 3 x 6
    ## # Groups:   topic [2]
    ##   document topic gamma lines word       total_words
    ##      <int> <int> <dbl> <chr> <chr>            <int>
    ## 1       36     1 0.932 45    va                   6
    ## 2       38     2 0.932 49    hawái                4
    ## 3       38     2 0.932 49    vacaciones           4

``` r
hawai_dtm<-hawai_words%>%
  group_by(word)%>%
  filter(total_words>1)%>%
  cast_dtm(line, word, total_words)
```

## Latent Dirichlet allocation

``` r
hawai_lda <- LDA(hawai_dtm, k = 2, control = list(seed = 1234))
hawai_topics <- tidy(hawai_lda, matrix = "beta")
hawai_topics <- hawai_topics%>%
  arrange(desc(beta))%>%
  filter(!term %in% stop_words_es)%>%
  filter(!term %in% c('va','na','pa'))

hawai_topics
```

    ## # A tibble: 52 x 3
    ##    topic term         beta
    ##    <int> <chr>       <dbl>
    ##  1     2 hawái      0.117 
    ##  2     2 vacaciones 0.117 
    ##  3     2 lindo      0.117 
    ##  4     2 instagram  0.117 
    ##  5     2 posteas    0.117 
    ##  6     1 bien       0.0889
    ##  7     1 puede      0.0889
    ##  8     1 haga       0.0889
    ##  9     1 falta      0.0889
    ## 10     1 vea        0.0889
    ## # … with 42 more rows

``` r
hawai_top_terms<-hawai_topics %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

hawai_top_terms %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~topic, scales = "free") +
  coord_flip() +
  scale_x_reordered()
```

![](Introducción-al-Text-Mining_files/figure-gfm/unnamed-chunk-33-1.png)<!-- -->

``` r
beta_spread <- hawai_top_terms %>%
  mutate(topic = paste0("topic", topic)) %>%
  spread(topic, beta) %>%
  filter(topic1 > .0001 | topic2 > .0001) %>%
  mutate(log_ratio = log2(topic2 / topic1))

beta_spread%>%
  na.omit()
```

    ## # A tibble: 2 x 4
    ##   term      topic1 topic2 log_ratio
    ##   <chr>      <dbl>  <dbl>     <dbl>
    ## 1 bebé   8.19e-276 0.0292      909.
    ## 2 vieron 7.78e-277 0.0292      912.

``` r
hawai_documents <- tidy(hawai_lda, matrix = "gamma")
hawai_documents
```

    ## # A tibble: 76 x 3
    ##    document topic   gamma
    ##    <chr>    <int>   <dbl>
    ##  1 1            1 0.00476
    ##  2 2            1 0.00239
    ##  3 3            1 0.00942
    ##  4 4            1 0.00476
    ##  5 5            1 0.00942
    ##  6 6            1 0.00942
    ##  7 7            1 0.995  
    ##  8 9            1 0.998  
    ##  9 10           1 0.999  
    ## 10 11           1 0.00239
    ## # … with 66 more rows

``` r
hawai_documents %>%
  mutate(title = reorder(document, gamma * topic)) %>%
  ggplot(aes(factor(topic), gamma)) +
  geom_boxplot() +
  facet_wrap(~document)
```

![](Introducción-al-Text-Mining_files/figure-gfm/unnamed-chunk-36-1.png)<!-- -->

``` r
hawai_documents %>%
  group_by(topic) %>%
  top_n(1, gamma) %>%
  ungroup()
```

    ## # A tibble: 10 x 3
    ##    document topic gamma
    ##    <chr>    <int> <dbl>
    ##  1 10           1 0.999
    ##  2 14           1 0.999
    ##  3 17           1 0.999
    ##  4 33           1 0.999
    ##  5 37           1 0.999
    ##  6 40           1 0.999
    ##  7 12           2 0.998
    ##  8 16           2 0.998
    ##  9 35           2 0.998
    ## 10 39           2 0.998

\#\# tagging

``` r
hawai_documents%>%
  ungroup()%>%
  group_by(topic)%>%
  summarize(tagg=max(gamma))
```

    ## `summarise()` ungrouping output (override with `.groups` argument)

    ## # A tibble: 2 x 2
    ##   topic  tagg
    ##   <int> <dbl>
    ## 1     1 0.999
    ## 2     2 0.998

``` r
topic_model_gamma <- tidy(hawai_lda, matrix = "gamma")%>%
  left_join(hawai_words%>%
              mutate(line=as.character(line)),by=c('document'='line'))%>%
  filter(gamma==max(gamma))%>%
  filter(!word %in% c('na','va','pa','vea','puede'))

topic_model_gamma%>%
  group_by(topic)%>%
  filter(total_words==max(total_words))%>%
  head(2)%>%
  mutate(tagging=paste(word[1],word[2]))%>%
  select(-word)%>%
  head(1)
```

    ## # A tibble: 1 x 5
    ## # Groups:   topic [1]
    ##   document topic gamma total_words tagging   
    ##   <chr>    <int> <dbl>       <int> <chr>     
    ## 1 10           1 0.999           4 haga falta
