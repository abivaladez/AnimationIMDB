## Iniciamos cargando las librerías y el dataset

library(dplyr)
library(ggplot2)
library(tidyr)
library(RColorBrewer)
library(viridis)
library(hrbrthemes)


dataset <- read.csv('TopAnimatedImDb.csv')

# Exploración de datos

names(dataset)
head(dataset)
tail(dataset)


#Vemos que hay 11 columnas:
  
#1. Nombre
#2. Calificación
#3. Votos
#4. Ganancia
#5. Género
#6. Metascore
#7. Certificado
#8. Director
#9. Año de estreno
#10. Descripción
#11. Duración

#Revisando estas columnas, hay distintas preguntas que uno puede hacer:
  
#  * ¿Cúal es el género favorito de los directores?
#  * ¿Qué tipo películas generan más ganancias?
#  * ¿De qué año y género son las películas mejor rankeadas en el _metascore_?
  
# Limpieza de datos

dataset[dataset==""] <- NA
dataset <- na.omit(dataset)
head(dataset)



# Preparación de datos

#Seleccion de columnas
dataset <- select(dataset, -c(Rating,Votes,Description,Runtime,Certificate))
names(dataset)

# Respondiendo las preguntas 

#1
directors_genres <- dataset %>% count(Genre, Director, sort=TRUE)
head(directors_genres)

ggplot(directors_genres,aes(Genre, Director,size=n,color=n))+geom_point(alpha=0.5)+scale_size(range=c(1,10),name='Número de películas')+ guides(x=guide_axis(angle=90))+ scale_color_gradient(low='#F4ACB7',high='#FF5D8F')+theme_dark()+theme(legend.position='none')

#2
dataset$Gross <- as.numeric(gsub('\\$|M','',dataset$Gross))

dataset_gross <- dataset %>% group_by(Genre) %>% summarise(Promedio=mean(Gross),Total=sum(Gross),n=n())
dataset_gross


#3
genre_meta <- dataset %>% group_by(Genre,Year) %>% summarise(Promedio=mean(Metascore)) %>% arrange(Promedio)

head(genre_meta)

ggplot(genre_meta,aes(Year,Promedio,color=Genre))+geom_point(alpha=0.5,size=5)+theme_gray()+ylab('Promedio de Metascore')+xlab('Año')+theme(legend.position='bottom')+theme(legend.key.size = unit(1, 'cm'))
