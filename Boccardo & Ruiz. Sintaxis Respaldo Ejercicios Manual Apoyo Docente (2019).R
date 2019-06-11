# RStudio para Estadística Descriptiva en Ciencias Sociales
# Manual de apoyo docente para la asignatura Estadística Descriptiva. 
# Carrera de Sociología, Universidad de Chile (segunda edición)
# Giorgio Boccardo Bosoni y Felipe Ruiz Bruzzone
# Junio 2019

# Sintaxis de respaldo para todos los ejercicios del manual

# ---- CAPÍTULO 4 ----

##Ejercicio 4.3

#Asignación del valor "10" al objeto "X"
X <- 10
X

#Cambiar el valor de X: cambiar el "10" por un "5"
X <- 5
X

#

#Ejercicio 4.4

#Asignación del valor "5" al objeto "Y"
5 -> Y
Y

#Ejercicio 4.5

#Concatenar valores para crear un vector de más de un sólo valor
edad <- c(15, 12, 27, 55, 63, 63, 24,21, 70)

table(edad)

# Ejercicio 4.6

#Vector numérico (función concatenar)
a <- c(4, 3, 5) 

#Vector numérico (función concatenar)
b <- c(1.1, 4.67, 5.1, 6.8) 

#Vector alfanumérico (función concatenar)
letras <- c("hombre", "mujer", "no sabe/no responde")

# Ejercicio 4.7

#Creación de las variables: todas tienen la misma cantidad de casos

genero <- c(1,1,2,1,2,2,2,1,2)

ingreso <- c(100000,300000,500000,340000,300000,500000,650000,410000,750000)

acuerdo <- c(1,1,3,2,4,1,5,3,2)

#Creación de base de datos a partir de variables previamente creadas
#Se asigna el resultado al objeto "aborto"
aborto <- data.frame(genero, ingreso, acuerdo) 

#Ejercicio 4.8

View(aborto) #Comando para visualizar base vía sintaxis (o hacer click en entorno)

#Ejercicio 4.9

save(aborto, file = "aborto.RData") #Se indica primero el objeto a guardar 
                                   #y luego el nombre del archivo, entre comillas

#Ejercicio 4.10

#Comando para eliminar elementos especificos, aquí se elimina 
#la base creada.
remove(aborto) 

#Comando para limpiar todos los objetos del entorno de trabajo.
rm(list = ls())

#---- CAPÍTULO 5 -----

#Ejercicio 5.1
install.packages("readxl") #Se descarga e instala el paquete readxl.

#Ejercicio 5.2

library(readxl) #Carga el paquete descargado a la sesión de trabajo de R.

# Ejercicio 5.3

install.packages("installr")

library(installr)

updateR()

# Ejercicio 5.4

update.packages()

# ---- CAPÍTULO 6 ----

# Ejercicio 6.1

install.packages("haven")

# Ejercicio 6.2

library(haven) #Debemos asegurarnos de que el paquete a ejecutar, 
#está cargado en la sesión de Rtudio.

CEP <- read_spss("CEP_sep-oct_2017.sav") # Nombre del archivo entre comillas.

# Ejercicio 6.3

install.packages("readxl") #Descarga e instalación del paquete
library(readxl) #Cargar paquete en sesión de trabajo de R

CEP_excel  <- read_excel("CEP_sep-oct_2017.xlsx") #Leer libro excel

CEP_excel  <- read_excel("CEP_sep-oct_2017.xlsx", sheet = 2) 
#indica posición de hoja en el libro de trabajo.

CEP_excel  <- read_excel("CEP_sep-oct_2017.xlsx", sheet = "DATOS") 
#indica nombre de hoja en libro de trabajo.

CEP_excel  <- read_excel("CEP_sep-oct_2017.xlsx", sheet = 2, skip = 1)
#indica posición de la hoja en el libro de trabajo.

# Ejercicio 6.4

CEP_csv  <- read.csv("CEP_sep-oct_2017.csv")

CEP_csv  <- read.csv("CEP_sep-oct_2017.csv", sep = ";")

CEP_csv2 <- read.csv2("CEP_sep-oct_2017.csv")

# Ejercicio 6.5

remove(CEP_csv2, CEP_excel)

# Ejercicio 6.6

library(dplyr) #Cargar paquete, si no está cargado desde antes.

CEP <- select(CEP_csv, pond = POND, sexo = SEXO, region = REGION, edad = DS_P2_EXACTA,
              satisfaccion_vida = SV_1, satisfaccion_chilenos = SV_2, eval_econ = MB_P2)
#Se indica base de datos, el nombre de variable a crear y los datos que la compondrán.
View(CEP) #Visualización de la base

# Ejercicio 6.7

save(CEP, file = "seleccion_CEP.RData")

#Ejercicio 6.8

rm(list = ls())

# Ejercicio 6.9

load("seleccion_CEP.RData")

#Ejercicio 6.10

names(CEP)

# Ejercicio 6.11

dim(CEP)

# Ejercicio 6.12

summary(CEP)

# Ejercicio 6.13

table(CEP$sexo)
class(CEP$sexo)

# Ejercicio 6.14

CEP <- mutate(CEP, sexo_chr = recode(CEP$sexo, "1" = "hombre", "2" = "mujer"))
table(CEP$sexo_chr)


class(CEP$sexo_chr)

CEP <- mutate(CEP, sexo_factor = factor(CEP$sexo, 
                                       labels = c("Hombre", "Mujer")))

# Ejercicio 6.15

table(CEP$region) #Observar características de la variables

class(CEP$region)

#Transformar a una variable distinta, categorías "Otras regiones" y "Región Metropolitana".
CEP <- mutate(CEP, region_factor = car::recode(CEP$region, "1:12 = 1; 13 = 2; 14:15 = 1"))

#Sobreescribir variable con resultado de convertir a factor incorporando etiquetas
CEP$region_factor <- factor(CEP$region_factor, 
                            labels = c("Otras regiones", "Región Metropolitana"))

table(CEP$region_factor) #Se sigue manteniendo la estuctura de casos.

class(CEP$region_factor) #Cambia el formato del objeto.

#Ejercicio 6.16

#Explorar variable "satisfacción con la propia vida"
class(CEP$satisfaccion_vida)

table(CEP$satisfaccion_vida)

summary(CEP$satisfaccion_vida)

class(CEP$satisfaccion_chilenos)

table(CEP$satisfaccion_chilenos)

summary(CEP$satisfaccion_chilenos)

CEP$satisfaccion_vida[CEP$satisfaccion_vida==88]<- NA #Asignar NA a casos con valor 88
CEP$satisfaccion_vida[CEP$satisfaccion_vida==99]<- NA #Asignar NA a casos con valor 99

CEP$satisfaccion_chilenos[CEP$satisfaccion_chilenos==88]<- NA
CEP$satisfaccion_chilenos[CEP$satisfaccion_chilenos==99]<- NA

table(CEP$satisfaccion_vida) #Ver resultado de codificación
summary(CEP$satisfaccion_vida)

table(CEP$satisfaccion_chilenos)
summary(CEP$satisfaccion_chilenos)

# Ejercicio 6.17
class(CEP$eval_econ)

table(CEP$eval_econ)

summary(CEP$eval_econ)

#Recodificar variable a 3 tramos: positiva, neutra, negativa

#Valores perdidos se asignan en la misma codificación,
#con argumento else ("todos los demás valores")
CEP <- mutate(CEP, eval_econ_factor = 
                car::recode(CEP$eval_econ, 
                            "1:2 = 1; 3 = 2; 4:5 = 3; else = NA"))

CEP$eval_econ_factor <- factor(CEP$eval_econ_factor, 
                               labels = c("Positiva", "Neutra", "Negativa"))

table(CEP$eval_econ_factor)
summary(CEP$eval_econ_factor)

#---- CAPÍTULO 7 ----

#Ejercicio 7.1

mean(CEP$satisfaccion_vida, na.rm = TRUE)

mean(CEP$satisfaccion_vida, na.rm = TRUE, trim = 0.025)

# Ejercicio 7.2

median(CEP$satisfaccion_vida, na.rm = TRUE)

# Ejercicio 7.3

#Ejecutar previamente "install.packages("modeest")"
library(modeest)
mfv(CEP$edad) #Indica el o los valores con más frecuencia

# Ejercicio 7.4

tabla <- table(CEP$eval_econ_factor)
tabla

# Ejercicio 7.5

#Frecuencias relativas (proporciones)
prop.table(tabla)

# Ejercicio 7.6

#Frecuencias relativas (porcentajes)
prop.table(tabla)*100

#Redondeo a dos decimales
round((prop.table(tabla)*100),2)

# Ejercicio 7.7

#Frecuencias absolutas acumuladas
cumsum(tabla)

#Frecuencias relativas acumuladas
cumsum(prop.table(tabla))

#Porcentaje acumulado redondado en dos decimales
round(cumsum(prop.table(tabla)*100),2)

# Ejercicio 7.8

quantile(CEP$satisfaccion_chilenos, prob = c(0.25, 0.5, 0.75), na.rm = TRUE)

# Ejercicio 7.9

range(CEP$edad, na.rm = TRUE)

min(CEP$edad, na.rm = TRUE)

max(CEP$edad, na.rm = TRUE)

max(CEP$edad, na.rm = TRUE) - min(CEP$edad, na.rm = TRUE)

# Ejercicio 7.10

var(CEP$satisfaccion_chilenos, na.rm = TRUE)

sd(CEP$satisfaccion_chilenos, na.rm = TRUE)

# Ejercicio 7.11

sd(CEP$edad)/mean(CEP$edad)

#Asegurarse de ejecutar previamente el comando "install.packages("FinCal")"
library(FinCal)
coefficient.variation(sd=sd(CEP$edad), avg = mean(CEP$edad))

# Ejercicio 7.12

library(psych)
skew(CEP$satisfaccion_vida)
kurtosi(CEP$satisfaccion_vida)

# Ejercicio 7.13

skew(CEP$satisfaccion_vida)/sqrt(6/1401) 
kurtosi(CEP$satisfaccion_vida)/sqrt(6/1401) 

# Ejercicio 7.14

#Prueba de Shapiro Wilk (muestras pequeñas)
shapiro.test(CEP$edad)

#Prueba Kolmogorov Smirnov (muestras grandes)
ks.test(CEP$edad, "pnorm", mean(CEP$edad, na.rm=T), sd(CEP$edad,na.rm=T))

# Ejercicio 7.15

f <- table(CEP$eval_econ_factor)
f_porc <- round((prop.table(tabla)*100),2)
f_porc_acum <- round(cumsum(prop.table(tabla)*100),2)

write.csv2(f, file = "Tabla 1.csv")
write.csv2(f_porc, file= "Tabla 2.csv")
write.csv2(f_porc_acum, file= "Tabla 3.csv")

# Ejercicio 7.16

summary(CEP$satisfaccion_vida)

# Ejercicio 7.17

#Guardar summary como objeto
descriptivos <- summary(CEP$satisfaccion_vida)

#Ver nombres y valores del objeto
names(descriptivos)

as.numeric(descriptivos)

#Configurar como matriz de datos
descr_sat_vida <- as.data.frame(rbind(names(descriptivos), as.numeric(descriptivos)))
View(descr_sat_vida)

#Exportar matriz a archivo CSV
write.csv2(descr_sat_vida, file = "Tabla 4.csv")

# Ejercicio 7.18

#Cálculo simple de estadíticos descriptivos
min <- min(CEP$satisfaccion_vida, na.rm = TRUE)
q1 <- quantile(CEP$satisfaccion_vida, probs = 0.25, na.rm = TRUE)
media <- mean.default(CEP$satisfaccion_vida, na.rm = TRUE)
media_rec <- mean.default(CEP$satisfaccion_vida, trim = 0.025, na.rm = TRUE)
mediana <- median.default(CEP$satisfaccion_vida, na.rm = TRUE)
moda <- mfv(CEP$satisfaccion_vida)
var <- var(CEP$satisfaccion_vida, na.rm = TRUE)
desvest <- sd(CEP$satisfaccion_vida, na.rm = TRUE)
q3 <- quantile(CEP$satisfaccion_vida, probs = 0.75, na.rm = TRUE)
max <- max(CEP$satisfaccion_vida, na.rm = TRUE)
s <- skew(CEP$satisfaccion_vida)
c <- kurtosi(CEP$satisfaccion_vida)

#Valores de estadísticos como vector
descriptivos_satvida <- as.numeric(c(min, q1, media, media_rec, mediana, moda,
                                     var, desvest, q3, max, s, c))

#Encabezados de cada estadístico como un vector
nombres <- c("Mínimo", "Q1", "Media", "Media recortada", "Mediana", "Moda",
             "Varianza", "Desviación Estándar", "Q3", "Máximo", "Simetría", "Curtosis")

descr2 <- as.data.frame(rbind(nombres,descriptivos_satvida))

write.csv2(descr2, file = "Tabla 5.csv")

# Ejercicio 7.19

library(PropCIs)

table(CEP$eval_econ_factor)
nrow(CEP)

exactci(x = 730, n = 1424, conf.level = 0.95)

# Ejercicio 7.20

library(Publish)

ci.mean(CEP$satisfaccion_vida) #Nivel de confianza por defecto.

ci.mean(CEP$satisfaccion_vida, alpha = 0.2) #Definición manual del nivel de confianza.

# Ejercicio 7.21

ci.mean(satisfaccion_vida~sexo_factor, data=CEP) 

# Ejercicio 7.22

#Cargar ENE y guardar como objeto
ENE <- read.csv2("ENE 2019 02 EFM.csv", sep = ";", dec = ",")

#Recodificacón edad en PET
library(dplyr)
ENE <- mutate(ENE, PET = car::recode(ENE$edad, 
                                     "0:14=2; else = 1"))
# Etiquetado de categorías
ENE$PET <- factor(ENE$PET, labels = c(">=15", "<15"))
table(ENE$PET)

# Ejercicio 7.23

#Creación de base de datos ponderada
library(survey)
ENE_ponderada <- svydesign(data = ENE, id=~1, weights = ~fact)

#Características base ponderada
class(ENE_ponderada)

# Ejercicio 7.24

svytotal(~PET, ENE_ponderada)

# ---- CAPÍTULO 8 ----

# Ejercicio 8.1

# Transformar variable sexo a factor (contar con valores y etiquetas)
CEP <- mutate(CEP, sexo_factor = factor(CEP$sexo, 
                                        labels = c("Hombre", "Mujer")))
# Ejercicio 8.2

#Limitaciones de la función hist
hist(CEP$sexo)
hist(CEP$sexo_chr)
hist(CEP$sexo_factor)

# Ejercicio 8.3

plot(CEP$sexo_factor, main = "Gráfico de barras 1",
     xlab = "Género", ylab = "Frecuencia")

# Ejercicio 8.4

#Valores que dividirán el gráfico
porcentajes <- as.numeric(round(((prop.table(table(CEP$eval_econ_factor)))*100),2))
porcentajes

#Etiquetas para el gráfico
etiquetas <- c("Positiva", "Neutra", "Negativa")
etiquetas

etiquetas <- paste(etiquetas, porcentajes)
etiquetas


etiquetas <- paste(etiquetas, "%", sep = "")
etiquetas

# Ejercicio 8.5

hist(CEP$edad, main = "Histograma de frecuencias 1",
     xlab = "Edad (años cumplidos)",
     ylab = "Frecuencia",
     col = "red",
     border = "black",
     xlim = c(18, 97),
     ylim = c(0, 150))

# Ejercicio 8.6

densidad_edad <- density(CEP$edad)
plot(densidad_edad, 
     main = "Histograma de densidad 1",
     xlab = "Edad (años cumplidos)",
     ylab = "Densidad")

# Ejercicio 8.7

boxplot(CEP$edad, main = "Gráfico de cajas 1",
        outline = TRUE)

# Ejercicio 8.8

library(ggplot2)
#Gráfico de barras 2: sexo en frecuencias absolutas
ggplot(CEP, aes(x = sexo_factor)) +
  geom_bar(width = 0.4,  fill=rgb(0.1,1,0.5,0.7)) +
  scale_x_discrete("Sexo") +     # configuración eje X (etiqueta del eje)
  scale_y_continuous("Frecuencia") +
  labs(title = "Gráfico de barras 2",
       subtitle = "Frecuencia absoluta de la variable sexo")

# Ejercicio 8.9

ggplot(CEP, aes(x = sexo_factor)) +
  geom_bar(width = 0.4, fill=rgb(0.1,0.3,0.5,0.7), aes(y = (..count..)/sum(..count..))) +
  scale_x_discrete("Sexo") +     # configuración eje X (etiqueta del eje)
  scale_y_continuous("Porcentaje",labels=scales::percent) + #Configuración eje y
  labs(title = "Gráfico de barras 3",
       subtitle = "Frecuencia relativa de la variable sexo")

# Ejercicio 8.10

ggplot(CEP, aes(x = as.numeric(edad))) +
  geom_histogram(binwidth = 0.6) +
  scale_x_continuous("Edad (años cumplidos)") + 
  scale_y_continuous("Frecuencia") +
  labs(title = "Histograma de frecuencias 2",
       subtitle = "Frecuencia absoluta de la variable edad")

# Ejercicio 8.11

ggplot(CEP, aes(x = edad)) +
  geom_density() +
  scale_y_continuous("Densidad") +
  scale_x_continuous("Edad") +
  labs(title = "Histograma de densidad 2",
       subtitle = "Forma de la distribución de la variable edad")

# ---- CAPÍTULO 9 ---- 

#Ver sintaxis anexa en formato RMarkdown (.Rmd)