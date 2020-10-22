### cargar libreriras
library(tidyverse); ##
library(caret);
library(GGally) ##
library(corrr)
library(corrplot)##
library(skimr)
library(FactoMineR)
library(factoextra)
library(cluster)
### cargar data
data("iris")


glimpse(iris)


iris %>%
  glimpse()


### edpxlorar la data
ggpairs(iris)

iris %>%
  summary()


iris %>%
  group_by(Species) %>%
  summarize(MD_SL = median(Sepal.Length)
            ,SD_SL = sd(Sepal.Length),
            SD_SW = sd (Sepal.Width),
            SD_PL = sd(Petal.Length),
            SD_PW = sd (Petal.Width)
  ) %>%
  arrange(desc(MD_SL))

iris[,1:4] %>%
  cor() %>%
  corrplot(method = "number")



iris %>%
  ggplot(aes(Sepal.Length,Petal.Length)) +
  geom_point() +
  geom_smooth(method = "auto") +
  facet_wrap(~Species,scales = "free")


iris %>%
  ggplot(aes(Petal.Width,Sepal.Width)) +
  geom_point() +
  geom_smooth(method = "auto") +
  facet_wrap(~Species,scales = "free")

skim(iris)

iris %>%
  ggplot(aes(Sepal.Length,fill = Species)) +
  geom_histogram(bins = 10)+
  facet_wrap(~Species,scales = "free")


iris %>%
  group_by(Species) %>%
  summarize(MD_SL = median(Sepal.Length),
            p25 = quantile(Sepal.Length)[2],
            p75 = quantile(Sepal.Length)[4]
  ) %>%
  mutate(Species = fct_reorder(Species, MD_SL)) %>%
  ggplot(aes(Species,MD_SL)) +
  geom_point(aes(size=MD_SL,color=factor(MD_SL)))+
  geom_errorbar(aes(ymin = p25, ymax = p75)) +
  coord_flip()+
  guides(size=FALSE)



iris %>%
  group_by(Species) %>%
  summarize(MD_PL = median(Petal.Length),
            p25 = quantile(Petal.Length)[2],
            p75 = quantile(Petal.Length)[4]
  ) %>%
  mutate(Species = fct_reorder(Species, MD_PL)) %>%
  ggplot(aes(Species,MD_PL)) +
  geom_point(aes(size=MD_PL,color=factor(MD_PL)))+
  geom_errorbar(aes(ymin = p25, ymax = p75)) +
  coord_flip()+
  guides(size=FALSE)



iris %>%
  group_by(Species) %>%
  summarize(MD_PW = median(Petal.Width),
            p25 = quantile(Petal.Width)[2],
            p75 = quantile(Petal.Width) [4]
  ) %>%
  mutate(Species = fct_reorder(Species, MD_PW))%>%
  ggplot(aes(Species,MD_PW)) +
  geom_point(aes(size=MD_PW, color = factor(MD_PW)))+
  geom_errorbar(aes(ymin = p25, ymax = p75)) +
  coord_flip()+
  guides (size=FALSE)

iris %>%
  ggplot(aes(Species, Petal.Width)) +  geom_boxplot()



iris %>%
  filter(Species == 'setosa') %>%
  summary()


### modelos

modelo1 =lm(Petal.Width~., data = iris)
modelo1 %>% summary()

Sepal.Length = 4
Sepal.Width = 5
Petal.Length = 2
Species = "setosa"
nuevas_variables = data.frame (Sepal.Length, Sepal.Width,Petal.Length,Species)
predict(modelo1, nuevas_variables)

modelo2 =lm(Petal.Width~., data = iris)
modelo2 %>% summary()


Sepal.Width = 5
Petal.Length = 2
Species = "setosa"
nuevas_variables = data.frame (Sepal.Length, Sepal.Width,Petal.Length,Species)
predict(modelo2, nuevas_variables)


### cluster

iris [,-5]%>%
  scale() -> iC
iC


gap_stat <- clusGap(iC, FUN = kmeans, nstart = 30, K.max = 6, B = 50)

fviz_gap_stat(gap_stat) + theme_minimal() + ggtitle("fviz_gap_stat: Gap Statistic")


kmeans(iris[-5],centers = 2)
iris_cluster <- kmeans(iris[-5],centers = 2)
iris$cluster = iris_cluster$cluster

iris  %>%
  group_by( Species,cluster) %>%
  summarize(n=n(),MSP_mean=mean(Sepal.Length),
            MDPW=median(Petal.Width))



iris%>%
  ggplot(aes(Sepal.Length,Petal.Width,color=factor(cluster)))+
  geom_point()


