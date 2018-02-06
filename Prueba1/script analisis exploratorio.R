##1. Leemos los datos
data_barrios<-read.csv('Datos Crudos/exa__barrios_cali.csv',sep = ',',
                       header = TRUE,stringsAsFactors = FALSE )

data_dispositivos<-read.csv('Datos Crudos/exa__dispositivos_cali.csv',
                            sep = ',', header = TRUE,
                            stringsAsFactors = FALSE )

data_clientes<-read.csv('Datos Crudos/exa__trx_clientes.csv',sep = ',',
                       header = TRUE,stringsAsFactors = FALSE )

##2 Hacemos un resumen de las columnas en cada archivo
str(data_barrios)

str(data_dispositivos)

str(data_clientes)

##3 Buscamos si hay datos faltantes (NA)
barrios_na<-complete.cases(data_barrios)
table(barrios_na) #No hay valores faltantes

dispositivos_na<-complete.cases(data_dispositivos)
table(dispositivos_na) #No hay valores faltantes

clientes_na<-complete.cases(data_clientes)
table(clientes_na) #No hay valores faltantes
