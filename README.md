# Curso  de NLP 

![](https://conflictos-ambientales.net/oca_bd/img/Logo%20UN.jpg)


Instructor : *Carlos Daniel Jiménez M*

* Email : danieljimenez88m@gmail.com
* Web: www.danieljimenezm.com
* Github: carlosjimenez88M


Instructor : *Enrique Rendón*

* Email : cortina.er@gmail.com
* Github: ECortina


Con el aumento de la información en todas sus versiones: escrita, oral, documental, de imagenes entre otras, el análisis de datos adquiere una dinámica propia por lo cual es necesario desarrollar habilidades estadísticas,para el modelamiento de dicha información, comprender el versionamiento de estos proyectos y por último tener la capacidad de integrarlo para la puesta en producción y es por ello que la Universidad Nacional de Colombia, a través de la escuela de [Economía](http://www.fce.unal.edu.co/pec.html)  diseño este curso, en donde los participantes desarrollaran las siguientes habilidades:

* Manejo de Git & Github;
* Lectura y organización de textos;
* Tokenización de documentos;
* Comprensión de documentos;
* Text Mining;
* Topic Modeling;
* Machine Learning Aplicado al análisis de texto;
* Deep Learning (introducción) para el Desarrollo de NLP.


## Requisitos


* Instale [R](https://www.icesi.edu.co/CRAN/), versión 4.0.2;
* Instale [R Studio](https://rstudio.com/products/rstudio/download/);
* Instale Git haciendo click [aquí](https://git-scm.com/);
* Abra una cuenta de Github [aquí](https://github.com/);
* Instale alguno de los siguientes editores de texto:
  + [Sublime Text](https://www.sublimetext.com/3)
  + [Visual Studio Code](https://code.visualstudio.com/download)

* Dado que Git trabaja bajo el formato **Markdown** por favor revise el siguiente [documento](https://guides.github.com/pdfs/markdown-cheatsheet-online.pdf).

* Instale [Docker](https://www.docker.com/), esto permitirá replicar el trabajo desarrollado en cualquier sistema operativo.

* Instale [Jenkins](https://www.jenkins.io/), esto permitirá la automatización de los modelos 


* Otro material que puede ayudar a dominar **markdown** es el siguiente [link](https://docs.github.com/es/github/writing-on-github/basic-writing-and-formatting-syntax)

![](https://miro.medium.com/max/1400/1*t5fqqkzm9lZc4V-hMxh79g.png)

Por otro lado instale las siguientes librerías

```{r}
install.packages(c('tidytext','tidymodels','tidyverse','tm','wordcloud','reshape2','stringr','ggrepel','ggraph','igraph','topicmodels','SnowballC','stopwords','magrittr','widyr','pdftools','lubridate','openNLP','cleanNLP','tidylo'))
```



## Forma de trabajo



Las clases tienen dos componentes: i) La clase magistral donde el docente expone y presenta ideas y aplicaciones del proceso de Text Mining y NLP con estudios de caso y ii) El trabajo colaborativo entre el grupo, por lo que se desarrollaran ejercicios que tengan que ver con el core de su operación dentro de la organización.


A la par, el curso consta de dos examenes 

Para la fase de Automatización y Versionamiento desarrolle el siguiente cuestionario:

|Examen|Fecha|
|-----:|-----|
|[Inicio del curso](https://docs.google.com/forms/d/1vMYu1IS4nJ0Fqnx-vgCxlm9DVg7un7_NJE8Kfekq9yw/edit?ts=5f681b8f)|6 de Octubre|
|[Final del curso](https://docs.google.com/forms/d/1EL2uyevVIEeUBmG7Cr6l3YqkCveBDETWnx58GGcxN2g/edit?ts=5f681ffc)|12 de Noviembre|

Para la fase de Text Mining y NLP desarrolle el siguiente cuestionario

|Examen|Fecha|
|-----:|-----|
|[Inicio del curso](https://docs.google.com/forms/d/1bjiMaLPnIjNCBOLaHDrjvc5UY_AaeJ2WUWz0WyFRWSg/edit)|6 de Octubre|
|[Final del curso](https://docs.google.com/forms/d/1BOJXEjxhyp_UBXhdx1-AqSjPDfBLBBT6Zp_oN3cqtzw/)|12 de Noviembre|


<center>Por favor realice los examenes en las fechas asignadas y escriba su nombre completo.</center>

## Agenda de las clases

|Fecha|Clase|Presentación|Código|
|----:|----:|------------:|----:|
|6 de Octubre|Introducción a Git y Github|[Clase 1](https://github.com/carlosjimenez88M/Github-Class/blob/master/Presentations/Clase-1.pdf)|[cod1](https://github.com/carlosjimenez88M/NLP_Course/blob/master/R.codes/Script_example.R)|
|8 de Octubre|Introducción a R|[Clase 2](https://github.com/carlosjimenez88M/NLP_Course/blob/master/Presentations/clase2.pdf)|[cod2](https://github.com/carlosjimenez88M/NLP_Course/blob/master/R.codes/Monitoria2.md)|
|13 de Octubre|Introducción al análisis estadístico|[Clase 3](https://github.com/carlosjimenez88M/NLP_Course/blob/master/Presentations/Clase3.pdf)|[cod3](https://github.com/carlosjimenez88M/NLP_Course/blob/master/R.codes/Clase3-15oct.Rmd)|
|15 de Octubre|Introducción al análisis de texto|[Clase 4](https://github.com/carlosjimenez88M/NLP_Course/blob/master/Presentations/text%20mining.pdf)|[cod4]()|
|3 de Noviembre |Introducción al análisis de texto 2|[Clase 5](https://github.com/carlosjimenez88M/NLP_Course/blob/master/Presentations/clase5.pdf)|[cod5](https://github.com/carlosjimenez88M/NLP_Course/blob/master/R.codes/Introducci%C3%B3n-al-Text-Mining.md)|
|5 de Noviembre |Introducción al Topic Modelling|[Clase 6]()|[cod6]()|
|10 de Noviembre |Machine Learning para la clasificación de textos II|[Clase 7]()|[cod7]()|
|12 de Noviembre |Introducción al Natural Lenguaje Processing|[Clase 8](https://github.com/carlosjimenez88M/NLP_Course/blob/master/Presentations/tensorflow.pdf)|[cod8](https://github.com/carlosjimenez88M/NLP_Course/blob/master/R.codes/Clasificaci%C3%B3n-de-textos.Rmd)|
|17 de Noviembre|Estudio de Caso|[Clase 9]()|[cod9]()|


## Monitorías

Las monitorias se realizaran los días sabados de 8:00am a 10:00am con previo aviso por parte del estudiante.

Los correos tienen un tiempo de respuesta entre 24 a 48 horas.

## Bases de datos 

|Base|Link de descarga|
|---:|---------------:|
|IMBD_I|[base](https://github.com/carlosjimenez88M/NLP_Course/blob/master/Bases_de_datos/IMDB-Movie-Data.csv)|
|IMBD|[base](https://github.com/carlosjimenez88M/NLP_Course/blob/master/Bases_de_datos/movie_review.csv)|


## Material de respaldo

|Tema|Código|
|---:|------|
|Tensorflow|[code](https://github.com/carlosjimenez88M/NLP_Course/blob/master/R.codes/Tensorflow%201.Rmd)|
