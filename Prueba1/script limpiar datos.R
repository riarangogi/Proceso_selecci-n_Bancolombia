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

table(data_clientes$tipo_doc)#Hay 14 datos anomalos en esta columna, tipo_doc
# =4 y tipo_doc=9

##5 Limpiamos los datos borrando los valores anomalos
data_clientes_tidy<-subset(data_clientes,
                           subset = num_doc>0 & tipo_doc %in% c(1,2) ,
                           select = num_doc:num_trx)

##6 Ponemos los mismos nombres de columnas en las tablas
names(data_barrios)<-c('id_barrio','nombre_barrio')

names(data_dispositivos)<-c('tipo_disp','id_disp','latitud','longitud',
                            'id_barrio')

names(data_clientes_tidy)<-c('id_cliente','tipo_doc','tipo_disp','id_disp',
                             'num_trx')

##7 Guardamos los datos ya limpios
dir.create('./Datos Limpios')

write.csv('./Datos Limpios/barrios_tidy.csv',row.names = FALSE)

write.csv('./Datos Limpios/dispositivos_tidy.csv',row.names = FALSE)

write.csv('./Datos Limpios/clientes_tidy.csv',row.names = FALSE)
