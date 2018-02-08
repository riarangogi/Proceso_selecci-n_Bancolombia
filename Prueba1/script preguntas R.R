library(data.table)
library(plyr)


##1·¿Cuales son las zonas más concurridas de la ciudad ?.


#Leer archilvos
data_barrios<-read.csv('./Datos Limpios/barrios_tidy.csv',header = TRUE,
                        sep = ',',stringsAsFactors = FALSE)

data_clientes<-read.csv('./Datos Limpios/clientes_tidy.csv',header = TRUE,
                       sep = ',',stringsAsFactors = FALSE)

data_dispositivos<-read.csv('./Datos Limpios/dispositivos_tidy.csv',
                            header = TRUE, sep = ',',stringsAsFactors = FALSE)

#convertir en tablas y asignarles un identificador
table_barrios<-data.table(data_barrios,key = 'id_barrio')

table_dispositivos<-data.table(data_dispositivos,key = 'id_disp')

table_clientes<-data.table(data_clientes,key = 'id_cliente')

#hacer un inner join 
bar_disp<-join(table_barrios,table_dispositivos,type='inner')

#mostrar solo las columnas id_disp y nombre_barrio
bar_disp<-bar_disp[,c(2,4)]

#asignarle a la tabla bar_disp la identificación
key(bar_disp)<-'id_disp'

#hacer un inner join 
disp_cli<-join(table_dispositivos,table_clientes,type='inner')

#mostrar solo las columnas id_disp y num_trx
disp_cli<-disp_cli[,c(2,8)]

#asignarle a la tabla bar_disp la identificación
key(disp_cli)<-'id_disp'

#hacer un inner join 
bar_cli<-join(bar_disp,disp_cli,type='inner')

#mostrar solo las columnas nombre_barrio y num_trx
bar_cli<-bar_cli[,c(1,3)]

#agrupar por el nombre del barrio y sumar las trx allí realizadas
bar_cli<-aggregate(num_trx~nombre_barrio,bar_cli,FUN = sum)

#ordenar los barrios de mayor a meenor segun el número de trx
bar_cli<-bar_cli[order(bar_cli$num_trx,decreasing = TRUE),]


##2 ¿Cuántos dispositivos y de que tipo se encuentran en cada zona
## de la ciudad?

#Leer archilvos
data_barrios<-read.csv('./Datos Limpios/barrios_tidy.csv',header = TRUE,
                       sep = ',',stringsAsFactors = FALSE)

data_dispositivos<-read.csv('./Datos Limpios/dispositivos_tidy.csv',
                            header = TRUE, sep = ',',stringsAsFactors = FALSE)

#hacer un inner join 
bar_disp<-join(table_barrios,table_dispositivos,type='inner')

#mostrar solo las columnas id_disp y nombre_barrio
bar_disp<-bar_disp[,2:4]

#cambiamos la columna id_disp por un vector de unos, pues solo nos intereza
# saber que hay un dispositivo
bar_disp$id_disp<-rep(1,length(bar_disp$nombre_barrio))

#contamos los dispositivos presentes en cada barrio respecto a su tipo
bar_disp_tipo<-aggregate(id_disp~nombre_barrio+tipo_disp,bar_disp,FUN = sum)


##3 ¿Cuales son las zonas más importantes (transaccionalmente) para
#cada cliente (donde realiza el 65% de sus compras)?. Nota:  Todos los
#clientes deben tener al menos una zona de influencia.

#Leer archilvos
data_barrios<-read.csv('./Datos Limpios/barrios_tidy.csv',header = TRUE,
                       sep = ',',stringsAsFactors = FALSE)

data_clientes<-read.csv('./Datos Limpios/clientes_tidy.csv',header = TRUE,
                        sep = ',',stringsAsFactors = FALSE)

data_dispositivos<-read.csv('./Datos Limpios/dispositivos_tidy.csv',
                            header = TRUE, sep = ',',stringsAsFactors = FALSE)

#convertir en tablas y asignarles un identificador
table_barrios<-data.table(data_barrios,key = 'id_barrio')

table_dispositivos<-data.table(data_dispositivos,key = 'id_disp')

table_clientes<-data.table(data_clientes,key = 'id_cliente')

#hacer un inner join 
bar_disp<-join(table_barrios,table_dispositivos,type='inner')

#mostrar solo las columnas id_disp y nombre_barrio
bar_disp<-bar_disp[,c(2,4)]

#asignarle a la tabla bar_disp la identificación
key(bar_disp)<-'id_disp'

#hacer un inner join 
disp_cli<-join(table_dispositivos,table_clientes,type='inner')

#mostrar solo las columnas id_disp,id_cliente y num_trx
disp_cli<-disp_cli[,c(2,6,8)]

#asignarle a la tabla bar_disp la identificación
key(disp_cli)<-'id_disp'

#hacer un inner join 
bar_cli<-join(bar_disp,disp_cli,type='inner')

#mostrar solo las columnas id_disp,id_cliente y num_trx
bar_cli<-bar_cli[,c(1,3,4)]

#calcular el total de trx de cada cliente
total_cli_trx<-aggregate(num_trx~id_cliente,bar_cli,FUN = sum)

#agregar una columna con el 65% de cada dato a la tabla total_cli_trx
total_cli_trx$pct<-65*total_cli_trx$num_trx/100

total_cli_trx<-total_cli_trx[,c(1,3)]

#hacer total_cli_trx con id_cliente como su llave
total_cli_trx<-data.table(total_cli_trx,key = 'id_cliente')

#calcular el total de trx de cada cliente considerando el barrio
#en el que se hicieron
cli_trx_bar<-aggregate(num_trx~id_cliente+nombre_barrio,bar_cli,FUN = sum)

#hacer cli_trx_bar con id_cliente como su llave
cli_trx_bar<-data.table(cli_trx_bar,key = 'id_cliente')

cli_trx_bar<-join(cli_trx_bar,total_cli_trx,type='inner')

#nos quedamos solo con las  lineas que su numero de trax sea menor que su 
# 65%
cli_trx_bar<-subset(cli_trx_bar,num_trx<=pct,select = c(id_cliente,nombre_barrio,num_trx,pct))

#guardamosel archivo en nuestro direcorio de trabajo
write.csv(cli_trx_bar,'./zonas_de_influencia.csv',
          row.names = FALSE)
