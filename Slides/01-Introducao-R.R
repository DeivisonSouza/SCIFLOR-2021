#-----------------------------------------------------------------------------------
# Título: Introdução ao R para Análise de Dados
#-----------------------------------------------------------------------------------
# Subtítulo: Introdução à Linguagem de Programação R
# Autor: Prof. Dr. Deivison Venicio Souza
# Instituto: Universidade Federal do Pará (UFPA)
#-----------------------------------------------------------------------------------

##############################################
# Parte 2 - Estrutura de dados na linguagem R
##############################################

#---------------------------------------
# 1 - Vetores
#---------------------------------------
# 1.1 - Função c() (concatenate)
# Função genérica que permite concatenar (combinar) argumentos
# para formar um vetor.

# Cria um vetor da classe "character"
c("Acapu", "Araucaria", "Mogno", "Cedro")

# Cria um vetor da classe "character" e faz atribuição
especie <- c("Acapu", "Mogno", "Cedro", "Ipe")
class(especie)

# Por padrão, ao concatenar strings cria-se um vetor de classe character.

# Cria um vetor da classe "numeric"
c(23.0, 27.0, 33.6, 42.6, 52.1)

# Cria um vetor da classe "numeric" e faz atribuição
diametro <- c(23.0, 27.0, 33.6, 42.6, 52.1)
class(diametro)

# Cria um vetor da classe "character", codifica para "factor"
# Se desejável, pode-se codificar um vetor de classe character
# para a classe factor.
Fito <- c("FOM", "FOA", "FOM", "FOM", "FOM", "FOA")
class(Fito)
Fito <- factor(Fito)
class(Fito)
#as.factor()

# Cria um vetor da classe "factor", mas com níveis do mês não ordenados
mes <- factor(
  c("Janeiro", "Abril", "Julho", "Outubro")
)
class(mes)
levels(mes)

# Por padrão, os níveis (levels) de um vetor de classe factor ficam dispostos
# em ordem alfabética.

# Cria um vetor da classe "factor", com níveis do mês ordenados
mes <-
    factor(x = mes,
           levels = c("Janeiro", "Abril",
                      "Julho", "Outubro"),
           ordered = TRUE)
class(mes)
levels(mes)

#---------------------------------------
# 1.2 - Função seq() (sequence)
# seq(from = ?, to = ?, by = ?, length.out = ?, along.with = ?)

# 1 a 10, com intervalo 1.
seq(10)

# Sequência de 1 a 10, com intervalo 1.
seq(1:10)

# Sequência de 1 a 10, com intervalo 1.
seq(from = 1, to = 10, by = 1)

# Sequência de -2 a 10, com intervalo 2.
seq(from = -2, to = 10, by = 2)

# Sequência de 11 números entre 0 e 1.
seq(from=0, to=1, length.out = 5)

# Sequência do tamanho do vetor-espécie.
especie <- c("Acapu", "Mogno", "Cedro", "Ipe")
seq(along.with = especie)

#---------------------------------------
# 1.3 - Função rep() (replicate)
# rep(x = ?, times = ?, each = ?)

# Repete a sequência de 1 a 4 (2x).
rep(x = 1:4, 2)

# Repete a sequência de 1 a 4 (3x).
rep(x = 1:4, times = 3)

# Repete cada valor em "x" (2x).
rep(x = 1:4, each = 2)

# Repete cada valor em "x" (2x).
rep(x = 1:4, c(2,2,2,2))

# Repete cada valor em "x", com base em c().
rep(1:4, c(2,1,2,1))

# Repete cada valor em "x", até 4 números.
rep(1:4, each = 2, len = 4)

# Repete cada valor em "x" (2x), por 3x.
rep(1:2, each = 2, times = 3)

#---------------------------------------
# 1.4 - Função scan()
# Digite os vetores abaixo usando a função scan()

##     especie diametro altura
##     Acapu     23.0    8.5
## Araucaria     27.0    9.2
##     Mogno     33.6   10.5
##     Cedro     42.6   13.4
##       Ipe     52.1   15.8

x <- scan()                   # Use para "numeric"
y <- scan(what = character()) # Use para "strings"

#---------------------------------------
# 2 - Matrizes
#---------------------------------------
# São caracterizadas por possuírem duas dimensões (linhas e colunas).
# Todos os seus elementos possuem a mesma classe (numeric, character ou logical).
# No R-base, a forma mais eficiente de construir matrizes é por meio da
# função matrix().
# As funções rbind() e cbind() também podem ser usadas para obter matrizes.
# rbind() = row bind (organiza vetores em linhas)
# cbind() = column bind (organiza vetores em colunas)

#---------------------------------------
# 2.1 - Função rbind()

diametro <- c(23.0, 27.0, 33.6, 42.6, 52.1)
altura <- c(8.4, 8.7, 9.1, 13.2, 15.4)

mat.1 <- rbind(diametro, altura)
class(mat.1)

#---------------------------------------
# 2.2 - Função cbind()

mat.2 <- cbind(diametro, altura)
print(mat.2)

#---------------------------------------
# 2.3 - Função matrix() - Mais eficiente
# matrix(data = NA, nrow = 1, ncol = 1, byrow = FALSE, dimnames = NULL)

# Cria uma matriz de 1 a 6, com 2 linhas e 3 colunas
mat.3 <- matrix(data=1:6, nrow=2, ncol=3); print(mat1)

# Atribui nomes às linhas e colunas - rownames e colnames
rownames(mat.3) <- c("L1","L2"); print(mat1)
colnames(mat.3) <- c("C1","C2","C3"); print(mat1)

# Atribui nomes às linhas e colunas - dimnames
(mat.4 <-
    matrix(data=1:6, nrow=2,
           ncol=3, byrow=TRUE,
           dimnames=list(c("L1", "L2"),
                         c("C1", "C2", "C3"))))

# Outra forma de atribuir nomes às linhas e colunas é usar o
# parâmetro dimnames da própria função matrix().

# Situações especiais ao criar matrizes
# a) Descarte de elementos (Número de elementos > ncol x nrow)
# Quando a quantidade de elementos (n) for maior que a quantidade de
# linhas e colunas (ncol x nrow).

(mat.5 <- matrix(1:9, nrow=2, ncol=3, byrow = TRUE,
                dimnames = list(c("L1", "L2"),
                                c("C1", "C2", "C3"))))

# b) Regra da Reciclagem (# ncol x nrow > número de elementos)
# Quando a quantidade de linhas e colunas (ncol x nrow) for maior do
# que a quantidade de elementos (n).

mat.6 <- matrix(1:6, nrow=3, ncol=3, byrow = TRUE,
                dimnames = list(c("L1", "L2", "L3"),
                                c("C1", "C2", "C3")))

#---------------------------------------
# 3 - Data Frames
#---------------------------------------

# São caracterizados por possuírem duas dimensões (linhas e colunas).
# Pode-se reunir vetores de diferentes classes, com a condição de possuírem
# igual comprimento.
# O R-base possui a função data.frame().

#---------------------------------------
# 3.1 - Função data.frame()

# Cria um data frame a partir de vetores existentes
especie <- c("Acapu", "Araucaria", "Cedro", "Tauari")
diametro <- c(23.0, 27.0, 33.6, 52.6)
altura <- c(8.4, 8.7, 9.1, 18.2)
cortar <- c("Não", "Não", "Não", "Sim")

(invFlor1 <-
    data.frame(especie, diametro, altura, cortar,
               stringsAsFactors = TRUE))

# Cria um data frame com apenas um comando

(invFlor2 <-
    data.frame(
      especie=c("Acapu", "Araucaria", "Cedro", "Tauari"),
      diametro=c(23.0, 27.0, 33.6, 52.6),
      altura=c(8.4, 8.7, 9.1, 18.2),
      cortar=c("Não", "Não", "Não", "Sim"),
      stringsAsFactors=FALSE))

# Explore as funções dim() e str().

#---------------------------------------
# 3.2 - Função edit()

# A edição de um data frame pode ser feita usando a função edit().
# Use o comando x <- edit(data.frame()) e crie a tabela a seguir:

##     especie diametro altura
##     Acapu     23.0    8.5
## Araucaria     27.0    9.2
##     Mogno     33.6   10.5
##     Cedro     42.6   13.4
##       Ipe     52.1   15.8

x <- edit(data.frame())


#---------------------------------------
# 3.3 - Importação de dados
# Em geral, dados importados (.csv e .txt) são armazenados como data.frame.

data <- read.csv("Slides/data/UPA07DVS.csv")
class(data)

#---------------------------------------
# 4 - Listas
#---------------------------------------

# Pode reunir diferentes estruturas de dados (vetores, matrizes,
# data frames e inclusive outras listas).
# O R-base possui a função list().
# Se os objetos já existem pode-se simplesmente adicioná-los à função list().

#---------------------------------------
# 4.1 - Função list()

## 4.1.1 - Cria uma lista a partir de vetores já existentes

especie <- c("Acapu", "Mogno", "Cedro", "Ipe")
diametro <- c(23.0, 27.0, 33.6, 52.6)
altura <- c(8.4, 8.7, 9.1, 18.2)

# Sem atribuir nomes
list1 <- list(especie, diametro, altura)

# Atribuindo nomes aos elementos da lista
# Nomear os componentes da lista facilita a identificação e a indexação.
list2 <- list(Esp = especie, DAP = diametro, H = altura)

# 4.1.2 - Uma lista com diferentes estruturas de dados
diametro <- c(23.0, 27.0, 33.6, 52.6)

mat <-
  matrix(data=1:6, nrow=2,
         ncol=3, byrow=TRUE,
         dimnames=list(c("L1", "L2"),
                       c("C1", "C2", "C3")))
invFlor <-
  data.frame(
    especie=c("Acapu", "Mogno", "Cedro", "Ipe"),
    cortar=c("Não", "Não", "Não", "Sim"),
    stringsAsFactors=FALSE)

# Criando lista nomeada
list3 <- list(Vetor = diametro,
               Matriz = mat,
               DataFrame = invFlor)

# Explore as funções length() e names().

# 4.1.3 - Coagindo lista para data frame
# Uma lista pode ser transformada em um data frame usando a
# função as.data.frame().
# Mas, para isso a lista a ser transformada deve possuir vetores de
# igual comprimento.

# Criando lista nomeada
list4 <- list(
  Esp = c("Acapu", "Mogno", "Cedro", "Ipe"),
  DAP = c(23.0, 27.0, 33.6, 52.6),
  H = c(8.4, 8.7, 9.1, 18.2))

as.data.frame(list4)

##############################################
# Parte 3 - Indexação no R
##############################################

# Quando o interesse é extrair, excluir ou substituir elementos de objetos
# é possível fazê-lo por meio de algum mecanismo de indexação.
# Operadores de indexação: [ ], [[ ]] e $.
# O operador $: permite extrair componentes nomeados de uma lista ou data frame.

#---------------------------------------
# 1 - Indexação de vetores

# Para extrair, excluir ou substituir elementos de um vetor usa-se o comando [i].
# O índice i indica a posição do elemento no objeto, e inicia no valor 1.
# A função c() pode ser usada para concatenar as posições dentro de colchetes.

# 1.1 - Extração
# 1.1.1 - Extração por indexação positiva
#--------------------------------------------

# cria os vetores
especie <- c("Acapu", "Mogno", "Cedro", "Ipe")
diametro <- c(23.0, 27.0, 33.6, 42.6)

# Um elemento
especie[2]

# Múltiplos elementos (sequenciais)
diametro[1:3]

# Múltiplos elementos (alternados)
especie[c(1,3,4)]

# Múltiplos elementos usando seq()
diametro[seq(from = 1, to = 4, by = 1)]

# 1.1.2 - Extração por indexação negativa
#--------------------------------------------

# Um elemento
especie[-2]

# Múltiplos elementos (sequenciais)
diametro[-(1:3)]

# Múltiplos elementos (alternados)
especie[-c(1,3,5)]

# 1.1.3 - Extração por indexação lógica
#--------------------------------------------

Especie <- c("Mogno", "Cedro", "Ipe", "Tauari")
Diametro <- c(23.0, 27.0, 33.6, 42.6, 52.1)

# Extrai árvores que não sejam Tauari
Especie[Especie != "Tauari"]

# Diâmetros >= 50cm.
Diametro[Diametro >= 50]

# 1.2 - Substituição
#--------------------------------------------
Especie <- c("Mogno", "Cedro", "Ipe", NA, NA)
Diametro <- c(23.0, 27.0, 33.6, 42.6, 52.1)

# Substitui os NAs
Especie[is.na(Especie)] <- "NI"
print(Especie)

# Altera posição 3, e atribui 33.5.

Diametro[3] <- 33.5; print(Diametro)

# Altera posições 4 e 5, e atribui 55.3 e 63.4
Diametro[c(4, 5)] <- c(55.3, 63.4); print(Diametro)


#---------------------------------------
# 2 - Indexação de matrizes

# Para **extrair**, **excluir** ou **substituir** elementos de uma matriz usa-se o comando [ i, j ].
# O índice i indica as linhas e o índice j indica as colunas da matriz.
# Se o argumento for do tipo [ i, ] ter-se-á acesso a todos os elementos da linha i especificada.
# Se o argumento for do tipo [ , j ] ter-se-á acesso a todos os elementos da coluna j especificada.
# Se nem o número da linha e nem o número da coluna é informado [ , ]: a matriz é acessada por completa.

# 2.1 - Extração
# 2.1.1 - Extração por indexação positiva
#--------------------------------------------

# Cria uma matriz
(mat <-
   matrix(1:6, nrow=2, ncol=3, byrow = TRUE,
          dimnames = list(c("L1", "L2"),
                          c("C1", "C2", "C3"))))

# extrai o elemento da linha 2 e coluna 2.
mat[2, 2]

# extrai todos elementos da linha 2.
mat[2, ]

# extrai todos elementos da coluna 3.
mat[, 3]

# extrai os elementos de L1 e L2, C2 e C3.
mat[c(1, 2), c(2, 3)]

# 2.1.2 - Extração por indexação negativa
#--------------------------------------------

# Cria uma matriz
(mat <-
   matrix(1:6, nrow=2, ncol=3, byrow = TRUE,
          dimnames = list(c("L1", "L2"),
                          c("C1", "C2", "C3"))))

# exclui as colunas 1 e 3.
mat[, c(-1, -3)]

# exclui apenas a coluna 2
mat[, -2]

# 2.2 - Substituição de elementos na matriz
#--------------------------------------------

# Cria uma matriz
(mat <-
   matrix(1:6, nrow=2, ncol=3, byrow = TRUE,
          dimnames = list(c("L1", "L2"),
                          c("C1", "C2", "C3"))))

# Substitui o elemento da posição 1 por zero.
mat[1, 1] <- 0; print(mat)

# Substitui os elementos das posições 1 e 5 por zero.
mat[c(1,5)] <- c(0,0); print(mat)

#---------------------------------------
# 3 - Indexação de data frames

# A **extração**, **inclusão** ou **substituição** de vetores em um data frame
# pode ser feita usando os comandos: [i, j] e $.
# O comando $ é usual para colunas nomeadas.
# O comando [ i, j ] segue a lógica de matrizes. Em que, i = linhas e j = colunas.
# Operadores lógicos (&, |, !) e de comparação (<, >, >=, <=, !=, ==, %in%)
# podem ser usados para extrair informações específicas do data frame.
# As funções attach() (attachment) e with() também podem ser usadas para
# facilitar o acesso à colunas de data frames.


# 3.1 - Extração usando o comando [i, j]
#--------------------------------------------

invFlor <-
   data.frame(
     especie=c("Acapu", "Mogno", "Cedro", "Tauari"),
     diametro=c(39.5, 45.6, 49.5, 70.4),
     altura=c(10.5, 13.6, 14.5, 17.4),
     cortar=c("Não", "Não", "Não", "Sim"),
     stringsAsFactors=FALSE)

# Extrai elementos da linha 2 e coluna 1
invFlor[2, 1]

# Extrai todos os elementos da coluna 2
invFlor[, 2]

# Extrai todos os elementos da coluna 2
# Porém, conserve a saída como data frame
invFlor[, 2, drop=FALSE]

# Extrai colunas pelo nome
invFlor[, "especie"]

# Extrai grupos de colunas
# Observe a ordem de impressão das variáveis
invFlor[, c(4,3)]
invFlor[, c("cortar", "especie")]

# 3.2 - Extração usando o comando $
#--------------------------------------------

# extrai a coluna “diâmetro”
invFlor$diametro

# Acessa a coluna “altura”
# e extrai os elementos da posição [4, 5]
invFlor$altura[c(3,4)]

# 3.3 - Extração usando o comandos $ + Operadores de comparação
#--------------------------------------------
# Operadores de comparação (<, >, >=, <=, !=, ==, %in%)

(invFlor <-
   data.frame(
     especie=c("Acapu", "Mogno", "Cedro", "Tauari"),
     diametro=c(39.5, 45.6, 49.5, 70.4),
     altura=c(10.5, 13.6, 14.5, 17.4),
     cortar=c("Não", "Não", "Não", "Sim"),
     stringsAsFactors=FALSE))

# Quais árvores têm mais de 14 m?
invFlor$altura > 14

# Quais árvores têm diâmetros >= 50cm?
invFlor$diametro >= 50

# Quais árvores estão previstas para corte?
invFlor$cortar == "Sim"

################################# Importante! ##############################
# Observe que as saídas dos comandos são respostas booleanas (TRUE ou FALSE).
# No entanto, na maioria das vezes deseja-se extrair os elementos.
############################################################################

# 3.4 - Extração usando os comandos: [i, j] + $ + Operadores (lógicos e comparação)
#--------------------------------------------

# Quais árvores têm mais de 14 m?
invFlor[invFlor$altura > 14, ]

# Quais árvores têm diâmetros >= 50cm?
invFlor[invFlor$diametro >= 50, ]

# Quais árvores estão previstas para corte?
invFlor[invFlor$cortar == "Sim", ]

# Quais árvores têm diametro < 50
# e não estão previstas para corte?
invFlor[invFlor$diametro < 50 & invFlor$cortar == "Não", ]

# 3.5 - Adição de linhas e colunas
#--------------------------------------------

# Cria um vetor sobre proteção
protegida <- c("Sim", "Sim", "Sim", "Não")

# Adiciona como nova coluna
invFlor$protegida <- protegida
print(invFlor)

# Substitui linha na posição 1
invFlor[1,] <- c("Acapu", 50.9, 15.6, "Não", "Sim")
print(invFlor)

#---------------------------------------
# 4 - Indexação de listas
