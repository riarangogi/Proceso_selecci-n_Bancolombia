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

##4 Buscamos valores anomalos tales como id o codigos negativos
min_codigo_barrios<-min(data_barrios$codigo)
min_codigo_barrios #El minimo es positivo, con lo que nos aseguramos que
# ninguno es negativo

min_codigo_dispositivos<-min(data_dispositivos$codigo)
min_codigo_dispositivos#El minimo es positivo, con lo que nos aseguramos que
# ninguno es negativo

min_idbarrio_dispositivos<-min(data_dispositivos$id_barrio)
min_idbarrio_dispositivos#El minimo es positivo, con lo que nos aseguramos que
# ninguno es negativo

min_coddispositivo_clientes<-min(data_clientes$cod_dispositivo)
min_coddispositivo_clientes#El minimo es positivo, con lo que nos aseguramos
#que ninguno es negativo

min_numdoc_clientes<-min(data_clientes$num_doc)
min_numdoc_clientes#El minimo es negativo, con lo que nos aseguramos que
# almenos uno es negativo
