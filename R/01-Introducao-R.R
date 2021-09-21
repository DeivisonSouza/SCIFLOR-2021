#-----------------------------------------------------------------------------------
# Título: Introdução ao R para Análise de Dados
#-----------------------------------------------------------------------------------
# Subtítulo: Parte 1 - Introdução à Linguagem de Programação R
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

#---------------
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
# 3 - Arrays
#---------------------------------------

# - Os arrays generalizam a noção de matriz. Veja que:
  # **Matrizes**: Os elementos são organizados em duas
  # dimensões (linhas e colunas).
  # **Array**: Os elementos podem ser armazenados
  # em mais de duas dimensões.

# - No R-base, um array pode ser criando com a função array().

# - Os arrays podem armazenar apenas o tipo de dados.

# array(data = NA, dim = length(data), dimnames = NULL)

# Cria um array sem elementos
(ar1 <- array(dim = c(3, 2, 2)))

# 3: número de linhas
# 2: número de colunas
# 2: número de matrizes

# Array com elementos
(ar2 <- array(data = 1:12, dim = c(3, 2, 2)))
# Cria 2 matrizes de dimensões 3 (linhas) x 2 (colunas)
dim(ar2)

# Array a partir de vetores de tamanhos diferentes

vect1 <- c(3, 6, 1)
vect2 <- c(15, 18, 13, 11, 17, 16)

array(c(vect1, vect2), dim = c(3, 3, 2))

#----------------------
# Nomeando linhas, colunas e matrizes do array
# Use o argumento **dimnames** para nomear as linhas, colunas e
# matrizes do array

array(c(vect1, vect2),
      dim = c(3, 3, 2),
      dimnames = list(c("L1", "L2", "L3"),
                      c("C1", "C2", "C3"),
                      c("M1", "M2")))

#---------------------------------------
# 4 - Data Frames
#---------------------------------------
# São caracterizados por possuírem duas dimensões (linhas e colunas).
# Pode-se reunir vetores de diferentes classes, com a condição de possuírem
# igual comprimento.
# O R-base possui a função data.frame().

#---------------------------------------
# 4.1 - Função data.frame()

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
# 4.2 - Função edit()

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
# 4.3 - Importação de dados
# Em geral, dados importados (.csv e .txt) são armazenados como data.frame.

data <- read.csv("Slides/data/UPA07DVS.csv")
class(data)

#---------------------------------------
# 5 - Listas
#---------------------------------------

# Pode reunir diferentes estruturas de dados (vetores, matrizes,
# data frames e inclusive outras listas).
# O R-base possui a função list().
# Se os objetos já existem pode-se simplesmente adicioná-los à função list().

#---------------------------------------
# 5.1 - Função list()

## 5.1.1 - Cria uma lista a partir de vetores já existentes

especie <- c("Acapu", "Mogno", "Cedro", "Ipe")
diametro <- c(23.0, 27.0, 33.6, 52.6)
altura <- c(8.4, 8.7, 9.1, 18.2)

# Sem atribuir nomes
list1 <- list(especie, diametro, altura)

# Atribuindo nomes aos elementos da lista
# Nomear os componentes da lista facilita a identificação e a indexação.
list2 <- list(Esp = especie, DAP = diametro, H = altura)

# 5.1.2 - Uma lista com diferentes estruturas de dados
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

# 5.1.3 - Coagindo lista para data frame
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
#---------------------------------------

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
#---------------------------------------

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
# 3 - Indexação de arrays
#--------------------------------------

# A ideia de indexação de arrays é similar ao aprendido para matrizes.
# No caso de arrays, deve-se apenas considerar que existe mais dimensões.
# Portanto, a indexação pode ser realizada usando o comando [i, j, z].
# Assim, i = linhas, j = colunas, z = matrizes.

(arr <- array(1:18,
      dim = c(3, 3, 2),
      dimnames = list(c("L1", "L2", "L3"),
                      c("C1", "C2", "C3"),
                      c("M1", "M2"))))

# 3.1 - Extração
# 3.1.1 - Extração por indexação positiva
#--------------------------------------------

arr[ , , ]
arr[ , , 1]   # acessando a matriz 1
arr[ , , 2]   # acessando a matriz 2
arr[1, , 1]   # primeira linha da "M1"
arr[ , 2, 2]  # segunda coluna da "M2"
arr[1, 2, 1]  # acessar elemento da primeira linha e segunda coluna de "M1"
arr[1, , ]    # primeira de ambas matrizes

# 3.1.2 - Extração por indexação negativa
#--------------------------------------------

arr[ , , -1]   # extrai matriz, exceto a primeira
arr[1, , -1]   # extrai primeira linha, exceto a primeira
arr[1, -2, -2] # extrai primeira linhas, exceto coluna 2 e matriz 2

#---------------------------------------
# 4 - Indexação de data frames
#---------------------------------------
# A **extração**, **inclusão** ou **substituição** de vetores em um data frame
# pode ser feita usando os comandos: [i, j] e $.
# O comando $ é usual para colunas nomeadas.
# O comando [ i, j ] segue a lógica de matrizes. Em que, i = linhas e j = colunas.
# Operadores lógicos (&, |, !) e de comparação (<, >, >=, <=, !=, ==, %in%)
# podem ser usados para extrair informações específicas do data frame.
# As funções attach() (attachment) e with() também podem ser usadas para
# facilitar o acesso à colunas de data frames.


# 4.1 - Extração usando o comando [i, j]
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

# 4.2 - Extração usando o comando $
#--------------------------------------------

# extrai a coluna “diâmetro”
invFlor$diametro

# Acessa a coluna “altura”
# e extrai os elementos da posição [4, 5]
invFlor$altura[c(3,4)]

# 4.3 - Extração usando o comandos $ + Operadores de comparação
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

# 4.4 - Extração usando os comandos: [i, j] + $ + Operadores (lógicos e comparação)
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

# 4.5 - Adição de linhas e colunas
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
# 5 - Indexação de listas
#---------------------------------------
# A indexação de lista pode ser feita com uso dos comandos [[ ]] e $ .
# Para acessar subíndices dos componentes da lista pode-se fazer: [[ ]][ ] .
# O comando $ poderá ser usado quando a lista tiver seus componentes nomeados.

# 5.1 - Lista com níveis superiores não nomeados
#--------------------------------------------

diametro <- c(23.0, 27.0, 33.6, 52.6)

invFlor <-
  data.frame(
    especie=c("Acapu", "Mogno", "Cedro", "Tauari"),
    cortar=c("Não", "Não", "Não", "Sim"),
    stringsAsFactors=FALSE)

# Criando lista não nomeada
list <- list(diametro, invFlor)

# extrai o componente 1
list[[1]]

# extrai a posição 1 do componente 2
list[[2]][1]
list[[2]]$especie
#list[[2]]["especie"]

# 5.2 - Lista com níveis superiores nomeados
#--------------------------------------------

diametro <- c(23.0, 27.0, 33.6, 52.6)

invFlor <-
  data.frame(
    especie=c("Acapu", "Mogno", "Cedro", "Tauari"),
    cortar=c("Não", "Não", "Não", "Sim"),
    stringsAsFactors=FALSE)

# Criando lista não nomeada
list <- list(DAP = diametro, Inventario = invFlor)

# extrai o componente da posição 1
list$DAP

# extrai a coluna espécie do componente 2
list$Inventario$especie

# extrai as árvores para corte com DAP > 50
list$Inventario[diametro > 50 & cortar == "Sim", ]

##############################################
# Parte 4 - Um pouco mais sobre o R
##############################################

# 1 - Operadores no R

# Na linguagem R existe três tipos de operadores
# Os operadores lógicos e relacionais operam com duas
# respostas possíveis: `TRUE` (verdadeiro) ou `FALSE` (falso).

#--------------------------------------------
# 1.1 - **Operadores Aritméticos**

  # | Símbolo | Descrição                |
  # |---------|--------------------------|
  # | +       | Adição                   |
  # | -       | Subtração                |
  # | *       | Multiplicação            |
  # | /       | Divisão                  |
  # | ^ ou ** | Potenciação              |
  # | %%      | Resto da divisão         |
  # | %/%     | Parte inteira da divisão |

# Operadores usuais para realizar operações matemáticas.

2+3             # adição
4*9             # multiplicação
20/5            # divisão
32-10           # subtração
5^3             # potenciação (exponenciação)
10%%3           # resto da divisão
10%/%3          # Parte inteira da divisão

(x <- c(2,4,6,8))
(y <- c(1,5,9,0))

x + y
y/x+2

# Regra PEMDAS (Parênteses, Exponenciação, Multiplicação, Divisão, Adição e Subtração).
(2+3)*10
4*3**3
5+8-4*9/3
5+(8-4)*9/3
2^3*4+6/2
2^3*(4+6)/2

#--------------------------------------------
# 1.2 - **Operadores Relacionais (ou Comparação)**

  # | Símbolo | Descrição                |
  # |---------|--------------------------|
  # | <       | Menor do que...          |
  # | >       | Maior do que...          |
  # | <=      | Menor ou igual do que... |
  # | >=      | Maior ou igual do que... |
  # | ==      | Igual a...               |
  # | !=      | Diferente de...          |
  # | %in%    | Contém                   |

# Operadores relacionais são usados para realizar comparações de valores.

# vetor com um elemento
(x <- 20)
(y <- 10)
(v <- 1)

# vetor com mais de um elemento
(z <- c(1:5))
(w <- c(5:1))

x > y        # x é maior do que y?
x < y        # x é menor do que y?
x != y       # x é diferente de y?
y <= x       # y é menor ou igual a x?
y >= x       # y é maior ou igual a x?
z == w       # elementos de z são iguais aos de w?
z != w       # elementos de z são dif. aos de w?
x >= w       # x é >= aos elementos de w?
w %in% v     # w contém v?


# Um pouco mais sobre o operador %in%

# É um operador binário que retorna um vetor booleano (TRUE ou FALSE) de tamanho
# sempre igual ao vetor esquerdo.

# Considere um vetor de nomes de espécies florestais...

especie <-
  c("Vouacapoua-americana", "Cedrela-odorata",
    "Bertholletia-excelsa", "Dinizia-excelsa Ducke",
    "Bertholletia-excelsa", "Manilkara-huberi",
    "Couratari-guianensis")

# Agora, você deseja descobrir se esse vetor contém *Bertholletia excelsa* e
# *Swietenia macrophylla*?

"Bertholletia-excelsa" %in% especie
"Swietenia-macrophylla" %in% especie

# Comparando dois vetores com operador %in%

especie <-
  c("Vouacapoua-americana", "Cedrela-odorata",
    "Bertholletia-excelsa", "Dinizia-excelsa Ducke",
    "Bertholletia-excelsa", "Manilkara-huberi",
    "Couratari-guianensis")

ameacadas <-
  c("Vouacapoua-americana", "Bertholletia-excelsa",
    "Cedrela-odorata", "Swietenia-macrophylla")

# Pergunta
# As espécies do vetor "ameacadas" estão contidas no vetor "especie"?
# O comando .green[**%in%**] avalia cada elemento do vetor "especie" e
# retorna uma resposta booleana (TRUE ou FALSE) de comprimento igual ao
# vetor esquerdo ("especie").

especie %in% ameacadas
#unique(especie[which(especie %in% ameacadas)])

#--------------------------------------------
# 1.3 - **Operadores Lógicos**

  # | Símbolo | Descrição                       |
  # |---------|---------------------------------|
  # | &       | E (and) - versão vetorizada     |
  # | &&      | E (and) - versão não-vetorizada |
  # | ⎮       | Ou (or) - versão vetorizada     |
  # | ⎮⎮      | Ou (or) - versão não-vetorizada |
  # | !       | Não...                          |
  # | xor     | Ou exclusivo...                 |

# Estes operadores são usados para realizar **operações lógicas**,
# cuja saída é uma **resposta booleana**.
# Uma resposta booleana indica se algo é Verdadeiro (`TRUE`) ou Falso (`FALSE`).

data <- data.frame(
  Especie = c("Swietenia macrophylla", "Swietenia macrophylla", "Swietenia macrophylla", "Hymenolobium petraeum","Hymenolobium petraeum", "Hymenolobium petraeum", "Hymenolobium petraeum","Hymenolobium petraeum", "Swietenia macrophylla", "Swietenia macrophylla"),
  DAP = c(33.6, 42.6, 52.1, 80.3, 90.8,
          49.4, 70.5, 100.5, 60.7, 27.1),
  H = c(9.1, 13.2, 15.4, 18.6, 19.5,
        16.8, 17.9, 22.4, 15.3, 8.7),
  Cipo = c("Sim", "Não", "Sim", "Não", "Sim",
           "Não", "Sim", "Não", "Sim", "Sim"),
  QF = c(2, 1, 3, 1, 2, 1, 2, 3, 1, 3),
  Selecao = c("Protegida", "Protegida", "Protegida", "Explorar", "Explorar",
              "Remanescente", "Explorar", "Remanescente","Protegida", "Protegida"),
  stringsAsFactors = T)


# 1.3.1 - Operador `&`

# Use o operador lógico `&` para responder as questões a seguir:

# Quais árvores possuem **DAP maior ou igual a 50cm** e **Qualidade de Fuste (QF)
# igual a 1**❓

data$DAP >= 50 & data$QF == 1
#data[data$DAP >= 50 & data$QF == 1, ]

# Quais árvores possuem **cipós ausentes**, **QF igual a 1** e **DAP maior ou igual
# a 50cm**❓

data$Cipo == "Não" & data$QF == 1 & data$DAP >= 50
#data[data$Cipo == "Não" & data$QF == 1 & data$DAP >= 50,]

# Quais árvores estão selecionadas para **explorar** e **QF igual a 1**❓

data$Selecao == "Explorar" & data$QF == 1
#data[data$Selecao == "Explorar" & data$QF == 1, ]

