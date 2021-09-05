#-----------------------------------------------------------------------------------
# Título: Introdução ao R para Análise de Dados
#-----------------------------------------------------------------------------------
# Subtítulo: Introdução à Linguagem de Programação R
# Autor: Prof. Dr. Deivison Venicio Souza
# Instituto: Universidade Federal do Pará (UFPA)
#-----------------------------------------------------------------------------------

# Estrutura de dados na linguagem R

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

