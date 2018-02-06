##1. Leemos los datos
data_barrios<-read.csv('Datos Crudos/exa__barrios_cali.csv',sep = ',',
                       header = TRUE,stringsAsFactors = FALSE)

data_dispositivos<-read.csv('Datos Crudos/exa__dispositivos_cali.csv',sep = ',',
                       header = TRUE,stringsAsFactors = FALSE)

data_clientes<-read.csv('Datos Crudos/exa__trx_clientes.csv',sep = ',',
                       header = TRUE,stringsAsFactors = FALSE)
