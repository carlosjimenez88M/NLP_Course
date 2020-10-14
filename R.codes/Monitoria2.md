Tutoria \# 2 NLP
================

## ¿Cómo gestionar proyectos con datos?

  - Anotación especial: un chunk se abre bajo la combinación de control
    + alt + i

<!-- end list -->

``` r
library(tidyverse)
library(skimr)
```

## Cargar una base de datos

``` r
iris
```

    ##     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
    ## 1            5.1         3.5          1.4         0.2     setosa
    ## 2            4.9         3.0          1.4         0.2     setosa
    ## 3            4.7         3.2          1.3         0.2     setosa
    ## 4            4.6         3.1          1.5         0.2     setosa
    ## 5            5.0         3.6          1.4         0.2     setosa
    ## 6            5.4         3.9          1.7         0.4     setosa
    ## 7            4.6         3.4          1.4         0.3     setosa
    ## 8            5.0         3.4          1.5         0.2     setosa
    ## 9            4.4         2.9          1.4         0.2     setosa
    ## 10           4.9         3.1          1.5         0.1     setosa
    ## 11           5.4         3.7          1.5         0.2     setosa
    ## 12           4.8         3.4          1.6         0.2     setosa
    ## 13           4.8         3.0          1.4         0.1     setosa
    ## 14           4.3         3.0          1.1         0.1     setosa
    ## 15           5.8         4.0          1.2         0.2     setosa
    ## 16           5.7         4.4          1.5         0.4     setosa
    ## 17           5.4         3.9          1.3         0.4     setosa
    ## 18           5.1         3.5          1.4         0.3     setosa
    ## 19           5.7         3.8          1.7         0.3     setosa
    ## 20           5.1         3.8          1.5         0.3     setosa
    ## 21           5.4         3.4          1.7         0.2     setosa
    ## 22           5.1         3.7          1.5         0.4     setosa
    ## 23           4.6         3.6          1.0         0.2     setosa
    ## 24           5.1         3.3          1.7         0.5     setosa
    ## 25           4.8         3.4          1.9         0.2     setosa
    ## 26           5.0         3.0          1.6         0.2     setosa
    ## 27           5.0         3.4          1.6         0.4     setosa
    ## 28           5.2         3.5          1.5         0.2     setosa
    ## 29           5.2         3.4          1.4         0.2     setosa
    ## 30           4.7         3.2          1.6         0.2     setosa
    ## 31           4.8         3.1          1.6         0.2     setosa
    ## 32           5.4         3.4          1.5         0.4     setosa
    ## 33           5.2         4.1          1.5         0.1     setosa
    ## 34           5.5         4.2          1.4         0.2     setosa
    ## 35           4.9         3.1          1.5         0.2     setosa
    ## 36           5.0         3.2          1.2         0.2     setosa
    ## 37           5.5         3.5          1.3         0.2     setosa
    ## 38           4.9         3.6          1.4         0.1     setosa
    ## 39           4.4         3.0          1.3         0.2     setosa
    ## 40           5.1         3.4          1.5         0.2     setosa
    ## 41           5.0         3.5          1.3         0.3     setosa
    ## 42           4.5         2.3          1.3         0.3     setosa
    ## 43           4.4         3.2          1.3         0.2     setosa
    ## 44           5.0         3.5          1.6         0.6     setosa
    ## 45           5.1         3.8          1.9         0.4     setosa
    ## 46           4.8         3.0          1.4         0.3     setosa
    ## 47           5.1         3.8          1.6         0.2     setosa
    ## 48           4.6         3.2          1.4         0.2     setosa
    ## 49           5.3         3.7          1.5         0.2     setosa
    ## 50           5.0         3.3          1.4         0.2     setosa
    ## 51           7.0         3.2          4.7         1.4 versicolor
    ## 52           6.4         3.2          4.5         1.5 versicolor
    ## 53           6.9         3.1          4.9         1.5 versicolor
    ## 54           5.5         2.3          4.0         1.3 versicolor
    ## 55           6.5         2.8          4.6         1.5 versicolor
    ## 56           5.7         2.8          4.5         1.3 versicolor
    ## 57           6.3         3.3          4.7         1.6 versicolor
    ## 58           4.9         2.4          3.3         1.0 versicolor
    ## 59           6.6         2.9          4.6         1.3 versicolor
    ## 60           5.2         2.7          3.9         1.4 versicolor
    ## 61           5.0         2.0          3.5         1.0 versicolor
    ## 62           5.9         3.0          4.2         1.5 versicolor
    ## 63           6.0         2.2          4.0         1.0 versicolor
    ## 64           6.1         2.9          4.7         1.4 versicolor
    ## 65           5.6         2.9          3.6         1.3 versicolor
    ## 66           6.7         3.1          4.4         1.4 versicolor
    ## 67           5.6         3.0          4.5         1.5 versicolor
    ## 68           5.8         2.7          4.1         1.0 versicolor
    ## 69           6.2         2.2          4.5         1.5 versicolor
    ## 70           5.6         2.5          3.9         1.1 versicolor
    ## 71           5.9         3.2          4.8         1.8 versicolor
    ## 72           6.1         2.8          4.0         1.3 versicolor
    ## 73           6.3         2.5          4.9         1.5 versicolor
    ## 74           6.1         2.8          4.7         1.2 versicolor
    ## 75           6.4         2.9          4.3         1.3 versicolor
    ## 76           6.6         3.0          4.4         1.4 versicolor
    ## 77           6.8         2.8          4.8         1.4 versicolor
    ## 78           6.7         3.0          5.0         1.7 versicolor
    ## 79           6.0         2.9          4.5         1.5 versicolor
    ## 80           5.7         2.6          3.5         1.0 versicolor
    ## 81           5.5         2.4          3.8         1.1 versicolor
    ## 82           5.5         2.4          3.7         1.0 versicolor
    ## 83           5.8         2.7          3.9         1.2 versicolor
    ## 84           6.0         2.7          5.1         1.6 versicolor
    ## 85           5.4         3.0          4.5         1.5 versicolor
    ## 86           6.0         3.4          4.5         1.6 versicolor
    ## 87           6.7         3.1          4.7         1.5 versicolor
    ## 88           6.3         2.3          4.4         1.3 versicolor
    ## 89           5.6         3.0          4.1         1.3 versicolor
    ## 90           5.5         2.5          4.0         1.3 versicolor
    ## 91           5.5         2.6          4.4         1.2 versicolor
    ## 92           6.1         3.0          4.6         1.4 versicolor
    ## 93           5.8         2.6          4.0         1.2 versicolor
    ## 94           5.0         2.3          3.3         1.0 versicolor
    ## 95           5.6         2.7          4.2         1.3 versicolor
    ## 96           5.7         3.0          4.2         1.2 versicolor
    ## 97           5.7         2.9          4.2         1.3 versicolor
    ## 98           6.2         2.9          4.3         1.3 versicolor
    ## 99           5.1         2.5          3.0         1.1 versicolor
    ## 100          5.7         2.8          4.1         1.3 versicolor
    ## 101          6.3         3.3          6.0         2.5  virginica
    ## 102          5.8         2.7          5.1         1.9  virginica
    ## 103          7.1         3.0          5.9         2.1  virginica
    ## 104          6.3         2.9          5.6         1.8  virginica
    ## 105          6.5         3.0          5.8         2.2  virginica
    ## 106          7.6         3.0          6.6         2.1  virginica
    ## 107          4.9         2.5          4.5         1.7  virginica
    ## 108          7.3         2.9          6.3         1.8  virginica
    ## 109          6.7         2.5          5.8         1.8  virginica
    ## 110          7.2         3.6          6.1         2.5  virginica
    ## 111          6.5         3.2          5.1         2.0  virginica
    ## 112          6.4         2.7          5.3         1.9  virginica
    ## 113          6.8         3.0          5.5         2.1  virginica
    ## 114          5.7         2.5          5.0         2.0  virginica
    ## 115          5.8         2.8          5.1         2.4  virginica
    ## 116          6.4         3.2          5.3         2.3  virginica
    ## 117          6.5         3.0          5.5         1.8  virginica
    ## 118          7.7         3.8          6.7         2.2  virginica
    ## 119          7.7         2.6          6.9         2.3  virginica
    ## 120          6.0         2.2          5.0         1.5  virginica
    ## 121          6.9         3.2          5.7         2.3  virginica
    ## 122          5.6         2.8          4.9         2.0  virginica
    ## 123          7.7         2.8          6.7         2.0  virginica
    ## 124          6.3         2.7          4.9         1.8  virginica
    ## 125          6.7         3.3          5.7         2.1  virginica
    ## 126          7.2         3.2          6.0         1.8  virginica
    ## 127          6.2         2.8          4.8         1.8  virginica
    ## 128          6.1         3.0          4.9         1.8  virginica
    ## 129          6.4         2.8          5.6         2.1  virginica
    ## 130          7.2         3.0          5.8         1.6  virginica
    ## 131          7.4         2.8          6.1         1.9  virginica
    ## 132          7.9         3.8          6.4         2.0  virginica
    ## 133          6.4         2.8          5.6         2.2  virginica
    ## 134          6.3         2.8          5.1         1.5  virginica
    ## 135          6.1         2.6          5.6         1.4  virginica
    ## 136          7.7         3.0          6.1         2.3  virginica
    ## 137          6.3         3.4          5.6         2.4  virginica
    ## 138          6.4         3.1          5.5         1.8  virginica
    ## 139          6.0         3.0          4.8         1.8  virginica
    ## 140          6.9         3.1          5.4         2.1  virginica
    ## 141          6.7         3.1          5.6         2.4  virginica
    ## 142          6.9         3.1          5.1         2.3  virginica
    ## 143          5.8         2.7          5.1         1.9  virginica
    ## 144          6.8         3.2          5.9         2.3  virginica
    ## 145          6.7         3.3          5.7         2.5  virginica
    ## 146          6.7         3.0          5.2         2.3  virginica
    ## 147          6.3         2.5          5.0         1.9  virginica
    ## 148          6.5         3.0          5.2         2.0  virginica
    ## 149          6.2         3.4          5.4         2.3  virginica
    ## 150          5.9         3.0          5.1         1.8  virginica

## Conocer la naturaleza de los datos

``` r
iris%>%
  glimpse() 
```

    ## Rows: 150
    ## Columns: 5
    ## $ Sepal.Length <dbl> 5.1, 4.9, 4.7, 4.6, 5.0, 5.4, 4.6, 5.0, 4.4, 4.9, 5.4, 4…
    ## $ Sepal.Width  <dbl> 3.5, 3.0, 3.2, 3.1, 3.6, 3.9, 3.4, 3.4, 2.9, 3.1, 3.7, 3…
    ## $ Petal.Length <dbl> 1.4, 1.4, 1.3, 1.5, 1.4, 1.7, 1.4, 1.5, 1.4, 1.5, 1.5, 1…
    ## $ Petal.Width  <dbl> 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1, 0.2, 0…
    ## $ Species      <fct> setosa, setosa, setosa, setosa, setosa, setosa, setosa, …

``` r
glimpse(iris)
```

    ## Rows: 150
    ## Columns: 5
    ## $ Sepal.Length <dbl> 5.1, 4.9, 4.7, 4.6, 5.0, 5.4, 4.6, 5.0, 4.4, 4.9, 5.4, 4…
    ## $ Sepal.Width  <dbl> 3.5, 3.0, 3.2, 3.1, 3.6, 3.9, 3.4, 3.4, 2.9, 3.1, 3.7, 3…
    ## $ Petal.Length <dbl> 1.4, 1.4, 1.3, 1.5, 1.4, 1.7, 1.4, 1.5, 1.4, 1.5, 1.5, 1…
    ## $ Petal.Width  <dbl> 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1, 0.2, 0…
    ## $ Species      <fct> setosa, setosa, setosa, setosa, setosa, setosa, setosa, …

## Comprender una base de datos

1)  La base de datos esta completa ?

<!-- end list -->

``` r
iris%>%
  skim() # con esta función se logro entender la naturaleza de los datos.
```

|                                                  |            |
| :----------------------------------------------- | :--------- |
| Name                                             | Piped data |
| Number of rows                                   | 150        |
| Number of columns                                | 5          |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |            |
| Column type frequency:                           |            |
| factor                                           | 1          |
| numeric                                          | 4          |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |            |
| Group variables                                  | None       |

Data summary

**Variable type: factor**

| skim\_variable | n\_missing | complete\_rate | ordered | n\_unique | top\_counts               |
| :------------- | ---------: | -------------: | :------ | --------: | :------------------------ |
| Species        |          0 |              1 | FALSE   |         3 | set: 50, ver: 50, vir: 50 |

**Variable type: numeric**

| skim\_variable | n\_missing | complete\_rate | mean |   sd |  p0 | p25 |  p50 | p75 | p100 | hist  |
| :------------- | ---------: | -------------: | ---: | ---: | --: | --: | ---: | --: | ---: | :---- |
| Sepal.Length   |          0 |              1 | 5.84 | 0.83 | 4.3 | 5.1 | 5.80 | 6.4 |  7.9 | ▆▇▇▅▂ |
| Sepal.Width    |          0 |              1 | 3.06 | 0.44 | 2.0 | 2.8 | 3.00 | 3.3 |  4.4 | ▁▆▇▂▁ |
| Petal.Length   |          0 |              1 | 3.76 | 1.77 | 1.0 | 1.6 | 4.35 | 5.1 |  6.9 | ▇▁▆▇▂ |
| Petal.Width    |          0 |              1 | 1.20 | 0.76 | 0.1 | 0.3 | 1.30 | 1.8 |  2.5 | ▇▁▇▅▃ |

2)  Análisis Exploratorio de datos

<!-- end list -->

``` r
cor(iris[,-5])
```

    ##              Sepal.Length Sepal.Width Petal.Length Petal.Width
    ## Sepal.Length    1.0000000  -0.1175698    0.8717538   0.8179411
    ## Sepal.Width    -0.1175698   1.0000000   -0.4284401  -0.3661259
    ## Petal.Length    0.8717538  -0.4284401    1.0000000   0.9628654
    ## Petal.Width     0.8179411  -0.3661259    0.9628654   1.0000000

¿Cómo es la relación del largo del sepalo con respecto al largo del
petalo?

``` r
iris%>%
  ggplot(aes(Sepal.Length ,Petal.Length,color=Species))+ # este comando se uiliza para diseñar las gráficas
  geom_point()+ # hacer gráfico de puntos 
  geom_smooth() + # mostrar tendencia 
  labs(title = "Relacióne entre Sepalo y Petalo")
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![](Monitoria2_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

## Funciones Lógicas

``` r
for (i in iris$Species){
  print(i)
}
```

    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "setosa"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "versicolor"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"
    ## [1] "virginica"

``` r
for (i in iris){
  i = mean(iris$Sepal.Length)
  print(i)
}
```

    ## [1] 5.843333
    ## [1] 5.843333
    ## [1] 5.843333
    ## [1] 5.843333
    ## [1] 5.843333

## Crear Funciones

Las funciones se crean con el comando `function`

``` r
trae_promedio<-function(especie){
  iris%>%
    filter(Species==especie)%>%
    group_by(Species)%>%
    summarize(Promedio=mean(Sepal.Length))
}
```

``` r
iris%>%
  count(Species,sort = TRUE)
```

    ##      Species  n
    ## 1     setosa 50
    ## 2 versicolor 50
    ## 3  virginica 50

``` r
trae_promedio('virginica')
```

    ## `summarise()` ungrouping output (override with `.groups` argument)

    ## # A tibble: 1 x 2
    ##   Species   Promedio
    ##   <fct>        <dbl>
    ## 1 virginica     6.59

## Como mejorar la función

``` r
trae_media<-function(especie){
  iris%>%
    filter(Species==especie)%>%
    ggplot(aes(Sepal.Length,Petal.Length))+
    geom_point()+
    geom_smooth()
}
```

``` r
trae_media('virginica')
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![](Monitoria2_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

## Análisis con for

Un for es un loop, uina condición

``` r
a<-1:10
b<-1:10

res<-numeric(length = length(a))

for(i in seq_along(a)){
  res[i]<-a[i] + b[i]
}   

res
```

    ##  [1]  2  4  6  8 10 12 14 16 18 20

# For en iris

Cuando quiero utilizar tíldes en R, debo hacer un cambio en el formato
de escritura y colocarlo como utf-8 (español)

``` r
Sepalo<-iris$Sepal.Length
Petalo<-iris$Petal.Length
proporcion<-numeric(length = length(Sepalo))

for(i in seq_along(Sepalo)){
  proporcion[i]<-round((Sepalo[i]/Petalo[i])*100,2)
}
proporcion
```

    ##   [1] 364.29 350.00 361.54 306.67 357.14 317.65 328.57 333.33 314.29 326.67
    ##  [11] 360.00 300.00 342.86 390.91 483.33 380.00 415.38 364.29 335.29 340.00
    ##  [21] 317.65 340.00 460.00 300.00 252.63 312.50 312.50 346.67 371.43 293.75
    ##  [31] 300.00 360.00 346.67 392.86 326.67 416.67 423.08 350.00 338.46 340.00
    ##  [41] 384.62 346.15 338.46 312.50 268.42 342.86 318.75 328.57 353.33 357.14
    ##  [51] 148.94 142.22 140.82 137.50 141.30 126.67 134.04 148.48 143.48 133.33
    ##  [61] 142.86 140.48 150.00 129.79 155.56 152.27 124.44 141.46 137.78 143.59
    ##  [71] 122.92 152.50 128.57 129.79 148.84 150.00 141.67 134.00 133.33 162.86
    ##  [81] 144.74 148.65 148.72 117.65 120.00 133.33 142.55 143.18 136.59 137.50
    ##  [91] 125.00 132.61 145.00 151.52 133.33 135.71 135.71 144.19 170.00 139.02
    ## [101] 105.00 113.73 120.34 112.50 112.07 115.15 108.89 115.87 115.52 118.03
    ## [111] 127.45 120.75 123.64 114.00 113.73 120.75 118.18 114.93 111.59 120.00
    ## [121] 121.05 114.29 114.93 128.57 117.54 120.00 129.17 124.49 114.29 124.14
    ## [131] 121.31 123.44 114.29 123.53 108.93 126.23 112.50 116.36 125.00 127.78
    ## [141] 119.64 135.29 113.73 115.25 117.54 128.85 126.00 125.00 114.81 115.69

## Else

Else se ejecuta cuando existe otra alternativa a una cadena de
sentencias

``` r
x<-2
if(x>3){
  print("Es mayor a tres")
} else {
  print("Es menor a tres")
}
```

    ## [1] "Es menor a tres"

``` r
x<-1:10
for(i in x){
  if(i>5){
    print(paste0(i," Es mayor a 5"))
  }else{
    print(paste0(i," Es menor a 5"))
  }
}
```

    ## [1] "1 Es menor a 5"
    ## [1] "2 Es menor a 5"
    ## [1] "3 Es menor a 5"
    ## [1] "4 Es menor a 5"
    ## [1] "5 Es menor a 5"
    ## [1] "6 Es mayor a 5"
    ## [1] "7 Es mayor a 5"
    ## [1] "8 Es mayor a 5"
    ## [1] "9 Es mayor a 5"
    ## [1] "10 Es mayor a 5"
