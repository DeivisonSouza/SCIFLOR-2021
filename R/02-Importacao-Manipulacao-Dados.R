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
#---------------------------------------

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

# Argumento **col_types**
#-----------------------------------
# **col_types** = É possível usar strings compactas em que cada caractere
# representa uma coluna.

# c = character;
# i = integer;
# n = number;
# d = double;
# l = logical;
# f = factor;
# D = date

# Importa o arquivo "file1"
(file1 <- readr::read_csv(file="Slides/data/file1.csv"))

# Importa o arquivo "file1", e específica o tipo de dado na coluna
(file1.mod2 <- readr::read_csv(file="Slides/data/file1.csv",
                               col_types = "fdi"))

#class(file1$DAP)  # qual tipo de objeto? Vetor do tipo "numeric"...
#typeof(file1$DAP) # modo de armazenar os dados do objeto na memória....

# Função class(): Indica o tipo de objeto no R
# Função typeof(): Indica o modo de armazenamento na memória

class(file1)
typeof(file1)

# A função de class() ajuda a entender o tipo de objeto no R. Por exemplo, considere o
# objeto "file1". Se executar a class(file1) indicará que o objeto é do tipo "data.frame"
# (e outras). Mas, a execução de typeof(file1) indica que os dados são armazenados na
# memória como lista (list).

# Argumento **col_select**
#-----------------------------------

# Importa o arquivo "file1"

(file1 <- readr::read_csv(file="Slides/data/file1.csv"))

# Importa o arquivo "file1", mas apenas colunas especificadas

(file1.mod3 <- readr::read_csv(file = "Slides/data/file1.csv",
                               col_select = c(Nome, DAP)))

# Argumento **n_max**
#-----------------------------------
# n_max: permite controlar o número máximo de linhas a serem lidas...

(file.IF <- readr::read_csv(file="Slides/data/UPA07DVS.csv"))

(file.IF2 <- readr::read_csv(file="Slides/data/UPA07DVS.csv", n_max = 30))

#----------------------------------------------------
# 3.2 - Arquivo de valores separados por vírgula (;)
#----------------------------------------------------

# Função read_csv2() - Importar arquivos .csv
#-------------------------------------------------
# Os arquivo separados por ponto e vírgula também têm a extensão .csv.

# Cria o arquivo "file2.csv" e salva em "data"

readr::write_file(x = "Nome;DAP;H\nAngelim;100;30\nMogno;80;20",
                  path = "Slides/data/file2.csv")

# Importa o arquivo "file2"
# Novamente, o único argumento obrigatório (file) é o caminho para o arquivo.

(file2 <- readr::read_csv2(file="Slides/data/file2.csv"))

# A função possui inúmeros argumentos que podem ser especificados.

args(read_csv2)   # verifique os argumentos disponíveis
?read_csv2        # consulte a ajuda da função p/ detalhes


# Argumento **skip** = pular
#-----------------------------------
# Pode ser usado para pular antes de ler os dados (Padrão 0)

# Cria o arquivo "fileC.csv" e salva em "data"
readr::write_file(x = "Tabela de dados\nNome;DAP;H\nAngelim;100;30\nMogno;80;20",
                  path = "Slides/data/fileC.csv")

# Importa o arquivo "fileC"
# Use skip = 1 para pular a primeira linha da planilha...

(fileC <- readr::read_csv2(file="Slides/data/fileC.csv"))
(fileC <- readr::read_csv2(file="Slides/data/fileC.csv", skip = 1))


# Combine Skip + col_names: para mudar nomes das colunas

readr::write_file(x = "Nome;DAP;H\nAngelim;100;30\nMogno;80;20",
                  path = "Slides/data/file2.csv")

(file2 <- readr::read_csv2(file="Slides/data/file2.csv"))

(file2.mod <- readr::read_csv2(file="Slides/data/file2.csv", skip=1,
                               col_names = c("Name", "DBH", "H")))

#----------------------------------------------------
# 3.3 - Arquivo de valores separados por tabulação (\t)
#----------------------------------------------------

# Função read_tsv() - Importar arquivos (.tsv, .txt)
#-------------------------------------------------

# Cria o arquivo "file3.tsv" e salva em "data"

readr::write_file(x = "Nome\tDAP\tH\nAngelim\t100\t30\nMogno\t80\t20",
                  path = "Slides/data/file3.txt")

# Importa o arquivo "file3"

(file3 <- readr::read_tsv(file="Slides/data/file3.txt"))

args(read_tsv)   # verifique os argumentos disponíveis
?read_tsv        # consulte a ajuda da função p/ detalhes

#--------------------------------------------------------------
# 3.4 - Arquivo de valores separados por um delimitador incomum
#--------------------------------------------------------------

# Função read_delim() - Importar arquivos com
# delimitator de valores específicos
#-------------------------------------------------

# Arquivos com valores separados por | (barra vertical)

# Cria o arquivo "file4.txt" e salva em "data"

readr::write_file(x = "Nome|DAP|H\nAngelim|100|30\nMogno|80|20",
                  path = "Slides/data/file4.txt")

# Importa o arquivo "file4"

(file4 <- readr::read_delim(file="Slides/data/file4.txt", delim = "|"))

args(read_delim)   # verifique os argumentos disponíveis
?read_delim        # consulte a ajuda da função p/ detalhes

#-----------------------------------------------------
# 4 - Importação de dados usando a GUI do RStudio
#-----------------------------------------------------

# Use a Interface Gráfica do Usuário (*Graphical User Interface* - GUI) para
# importar dados rapidamente.
# RStudio IDE - Environment - Import Dataset - From Text (readr).
# É possível também usar funções do R-base e de outros pacotes,
# como **readxl** (para ler arquivos .xlsx).

##############################################
# Parte 2 - Manipulação de dados com dplyr
##############################################

# Sobre o pacote **dplyr**...

# Um dos principais pacotes do .green[tidyverse].
# O pacote dplyr é essencialmente um conjunto consistente de funções projetadas para
# resolver os desafios mais comuns de **manipulação de dados**.
# Foi projetado para ser simples, intuitivo, amigável e elegante.
# O encadeamento de comandos é facilitado pelo emprego do operador **%>%** (pipe).
# Códigos em R que fazem uso dos verbos dplyr são mais elegantes, compeeensíveis e intuitivos.
# **Cheatsheet do RStudio** (folhas de resumo): Help - Cheatsheets - Data Transformation with dplyr
# No site da RStudio pode-se encontrar algumas Cheatsheet traduzidas:
# [cheatsheets-translations](https://www.rstudio.com/resources/cheatsheets/#translations)

#--------------------------------
### Principais verbos **dplyr**

# O **dplyr** possui diversos verbos (funções). A seguir são listadas algumas das
# mais usuais:

# mutate()
# select()
# filter()
# arrange()
# group_by()
# summarise()

# Lista de funções do pacote **dplyr**:
ls("package:dplyr")
length(ls("package:dplyr"))
lsf.str("package:dplyr")

# Ou simplesmente digite dplyr::.

#--------------------------------------
# 1 - Função select e suas auxiliares
#--------------------------------------

#-----------------------------------------------------------------
# 1.1 - Conjunto de dados: uma pequena amostra para praticar...

data <- readr::read_csv("Slides/data/data.csv")


# 1.2 - Função select() - selecionar colunas
#-------------------------------------------------
# select(.data, ...)
?select

# 1.2.1 - Selecionando apenas uma coluna...
# ---------------------------------------

# Alternativa 1:
select(.data=data, Nome_Especie)

# Alternativa 2:
data %>%
  select(Nome_Especie)

# 1.2.2 - Selecionando múltiplas colunas
# ---------------------------------------

# Alternativa 1 (sem %>%)

select(.data=data, CAP, HC, QF)

# Alternativa 2 (com %>%)

data %>%
  select(CAP, HC, QF)

# Alternativa 3 (:) - range de colunas

data %>%
  select(CAP:QF)

# 1.2.3 - Usando funções auxiliares...
# ---------------------------------------

# starts_with()
#-------------------
# Função usada para selecionar colunas cujos nomes iniciam com um texto padrão.

select(data, starts_with("N"))

# ends_with()
#-------------------
# Função usada para selecionar colunas cujos nomes terminam com um texto padrão.

select(data, ends_with("e"))

# contains()
#-------------------
# Função usada para selecionar colunas cujos nomes tenham algum texto padrão.

select(data, contains("e"))

# matches()
#-------------------
# Função usada para selecionar colunas que contenham nomes correspondentes
# à alguma expressão regular.

select(data, matches('No|cao|F'))

# everything()
#-------------------
# Seleciona todas as variáveis. É útil para reordenar algumas colunas,
# sem se importar com a ordem das demais.

data %>%
  select(Nome_Especie, Selecao, everything())

# where()
#-------------------
# Aplica uma função à todas as variáveis e seleciona aquelas para as quais a
# resposta é TRUE.

data %>%
  select(where(is.character))

# Combinando funções auxiliares e operadores lógicos...
#-------------------

data %>%
  select(
    starts_with("N") &
      !ends_with("Arvore"))

# Função concatenate
#-------------------

data %>%
  select(-c(CAP:Selecao))

# Reordenar colunas
#-------------------
data %>%
  select(Nome_Especie,
         Selecao, CAP,
         QF, HC)

#-------------------------
# 2 - Função arrange()
#-------------------------
# Função usada para ordenar linhas

# 2.1 - Ordem crescente de uma variável

data %>% arrange(HC)

# 2.2 - Ordem decrescente de uma variável

data %>% arrange(desc(HC))

