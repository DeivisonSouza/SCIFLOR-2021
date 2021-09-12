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
# 1.1 - Instala pacote
# install.packages("readr")

#---------------------------------------
# 1.2 - Carrega o pacote
library(readr)

#---------------------------------------
# 1.3 - Funções para importação de dados
ls("package:readr") %>%
  stringr::str_subset("^read_")         # ^ = início da string

#---------------------------------------
# 1.4 - Funções para exportação de dados
ls("package:readr") %>%
  stringr::str_subset("^write_")

#---------------------------------------
# 1.5 - Algumas das principais funções de importação do readr

# Vamos estudar apenas algumas das principais funções de importação do readr...

# **read_csv()** - Importar um arquivo de valores separados por vírgula (*Comma-Separated Values*)

# **read_csv2()** - Importar um arquivo de valores separados por ponto e vírgula (*Semicolon-Separated Values*)

# **read_tsv()** - Importar um arquivo de valores separados por tabulação (*Tab-Separated Values*)

# **read_delim()** - Importar um arquivo de valores separados por um delimitador incomum

#------------------------------------------------
# 1.5.1 - Arquivo de valores separados por vírgula (,)



- **Função .black[read_csv()]** - Importar arquivos .csv


