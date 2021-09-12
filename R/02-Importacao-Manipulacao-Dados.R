#-----------------------------------------------------------------------------------
# Título: Introdução ao R para Análise de Dados
#-----------------------------------------------------------------------------------
# Subtítulo: Parte 2 - Importação e Manipulação de Dados: readr e dplyr
# Autor: Prof. Dr. Deivison Venicio Souza
# Instituto: Universidade Federal do Pará (UFPA)
#-----------------------------------------------------------------------------------

##############################################
# Parte 1 - Importação de dados com readr
##############################################

#----------------------------------
# 1 - Importação de dados no R
#----------------------------------

# A etapa de importação de dados para o R precede a análise de dados.
# Os dados podem ser exportados: i) diretamente para a memória (RAM); ou ii) acessados remotamente.
# O mecanismo de importação depende do formato dos dados.
# Por exemplo, é possível exportar dados nos formatos: .txt, .csv, .xlsx, .ods, SAS, SPSS, etc.
# O R-base possui funções para importação de dados: **read.csv()** e **read.table()** (Pacote **utils**).
# O tidyverse incorpora o pacote **readr**, que possui várias funções para importação de dados.

#----------------------------------
# 2 - O pacote readr (tidyverse)
#----------------------------------

# O pacote **readr** está incorporado no tidyverse.
# Possui diversas funções para importação e exportação de dados.

#---------------------------------------
# install.packages("readr") # Instala o pacote (Recomendação: Instalar o Tidyverse!)
library(readr)            # Importação
library(dplyr)            # Manipulação

#---------------------------------------
# 2.1 - Funções para importação e exportação de dados
# ^ = início da string

ls("package:readr") %>%
  stringr::str_subset("^read_")    # Funções para importação de dados

ls("package:readr") %>%
  stringr::str_subset("^write_")   # Funções para exportação de dados

#---------------------------------------
# 3 - Importação de dados usando o readr

# Vamos estudar apenas algumas das principais funções de importação do readr...

# **read_csv()** - Importar um arquivo de valores separados por vírgula (*Comma-Separated Values*)

# **read_csv2()** - Importar um arquivo de valores separados por ponto e vírgula (*Semicolon-Separated Values*)

# **read_tsv()** - Importar um arquivo de valores separados por tabulação (*Tab-Separated Values*)

# **read_delim()** - Importar um arquivo de valores separados por um delimitador incomum

#------------------------------------------------
# 3.1 - Arquivo de valores separados por vírgula (,)

# Função read_csv() - Importar arquivos .csv
#-------------------------------------------------
# Para importar é necessário possuir o arquivo em algum diretório...
# Então, vamos usar a estratégia de criar esses arquivos usando as funções de
# exportação do readr e salvá-lo no diretório "data"...

# Cria o arquivo "file1.csv" e salva em "data"

readr::write_file(x = "Nome,DAP,H\nAngelim,100,30\nMogno,80,20",
                  path = "Slides/data/file1.csv")

# read_csv(): O único argumento obrigatório (file) é o caminho para o arquivo....

file1 <- readr::read_csv(file="Slides/data/file1.csv")

# A função possui inúmeros argumentos que podem ser especificados.

args(read_csv)   # verifique os argumentos disponíveis
?read_csv        # consulte a ajuda da função p/ detalhes

# Vamos explorar outros argumentos da função read_csv()...

## col_names...

# Importa o arquivo "file1"
(file1 <- readr::read_csv(file="Slides/data/file1.csv"))

# Importa o arquivo "file1", e específica nomes para colunas
(file1.mod1 <- readr::read_csv(file="Slides/data/file1.csv",
                               col_names = c("Name", "DBH", "H")))

