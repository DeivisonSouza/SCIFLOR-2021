#-----------------------------------------------------------------------------------
# Título: Introdução ao R para Análise de Dados
#-----------------------------------------------------------------------------------
# Subtítulo: Parte 3 - Visualização de Dados com ggplot2
# Autor: Prof. Dr. Deivison Venicio Souza
# Instituto: Universidade Federal do Pará (UFPA)
#-----------------------------------------------------------------------------------

##############################################
# Parte 1 - Visualização de dados com ggplot2
##############################################

#----------------------------------
# 1 - Motivação
#----------------------------------

# Dados constituem uma representação usada para gerar informações
# sobre um fenômeno.
# Os gráficos são representações visuais úteis para exibir
# informações ocultas nos dados.
# Representações visuais são melhor interpretadas pelo cerébro
# humano.
# A natureza da variável e o objetivo da análise, em geral,
# orientam a melhor representação visual.
# O R-base possui diversas funções para visualização de dados.
# Por exemplo, **plot()**, **hist()**, **barplot()**,
# **boxplot()**, entre outras.
# O tidyverse incorpora o pacote **ggplot2**, um framework
# sensacional para construção de gráficos elegantes.

#----------------------------------
# 2 - O pacote ggplot2
#----------------------------------

# O ggplot2 é um pacote para .blue[visualização de dados] disponível no R.
# O pacote foi desenvolvido por .blue[Hadley Wickham], inspirado pelo livro .blue[**The Grammar of graphics**] (A gramática dos gráficos) de .blue[Leland Wilkinson].
# A essência do ggplot2 é a construção de gráficos ".blue[camada por camada]".
# O ggplot2 possui .blue[vantagens] frente ao R-base:
  ## É altamente customizável;
  ## É mais elegante (bonito);
  ## É muito intuitivo, devido a filosofia de camadas.

# Instale o ggplot2
install.packages(ggplot2)
install.packages(tidyverse)

# instala diversos pacotes, inclusive ggplot2

# Carrega pacotes
library(ggplot2)
library(dplyr)

# Para tornar todas as funções do pacote disponíveis para uso
# na sessão corrente do R.

#--------------------------------------------
# 3 - Conjunto de dados - IF100%
#--------------------------------------------

data <- readr::read_csv(file="Slides/data/UPA07DVS.csv") %>%
  mutate(DAP = round(CAP/pi, 2),
         V = round(((DAP^2*pi)/40000)*HC*0.7, 4))

# Para fins didáticos, vamos usar uma amostra de 4 espécies
# florestais de um IF100% para construir os gráficos...

#--------------------------------------------
# Amostra 1 - 4 espécies
#--------------------------------------------

set.seed(1000)

data_sample <- data %>%
  select(Nome_Especie, DAP, CAP, HC, QF, Selecao, V) %>%
  filter(Nome_Especie %in% c('Acapu', 'Andiroba',
                             'Maçaranduba', 'Goiabão')) %>%
  group_by(Nome_Especie) %>%
  sample_n(50, replace = F)

#--------------------------------------------
# 4 - Sintaxe Básica - ggplot2
#--------------------------------------------

# A estrutura de dados deve ser um data.frame.
# Não admite matrizes, vetores, e outros!
# A função principal é ggplot().
# Nesta função os argumentos básicos são:
  ## **data**: argumento que recebe os dados no formato de
  ## data.frame.
  ## **mapping**: argumento que recebe informações das variáveis
  ## (x e y) a serem usadas na plotagem. Esses argumentos são
  ## passados dentro da função aes().

# Obs.: Se mapping não for especificado na função ggplot(),
# deve ser fornecido em cada camada adicionada ao gráfico.

# Existem 3 formas de invocar a função ggplot():

# 1) ggplot(df, aes(x, y, outras estéticas))

  ## Método é recomendado quando dados de **um único data.frame**
  ## e também as **mesmas estéticas** são usadas nas camadas
  ## adicionadas.

# 2) ggplot(df)

  ## Método é recomendado quando dados de **um único data.frame**
  ## é usado pelas camadas adicionadas, mas as **estéticas
  ## variam de uma camada para outra**.

# 3) ggplot()

  ## Método é recomendado quando **vários data.frames precisam
  ## ser usados para produzir diferentes camadas** no gráfico.
  ## É usual para gráficos complexos.

#--------------------------------------------
# 5 - Camada base - ggplot2
#--------------------------------------------

# A execução da função ggplot() (sem argumentos) ou com apenas
# o argumento data especificado ggplot(data = data_sample) gera
# simplesmente a base do gráfico (sem elementos estéticos e
# geométricos).

ggplot(data = data_sample)    # sem pipe

data_sample %>% ggplot()      # com pipe (%>%)

# É comum usar o operador pipe (%>%) para enviar o conjunto
# de dados para a função ggplot().

#-------------------------------------------
# 5.1 - Camada base - Especificando x e y

# - Adicionamos "x" = DAP e "y" = HC dentro da função aes()
# do argumento mapping.
# - Isso informar que as variáveis DAP e HC devem ser usadas
# nos eixos x e y, respectivamente, do gráfico.
# - Apesar disso, ainda não é possível visualizar um gráfico
# com elementos geométricos representativos dos dados.
# - Então, é necessário definir o **tipo de gráfico** que
# deseja-se construir.

ggplot(data = data_sample,
       mapping = aes(x = DAP, y = HC)) # 1ª camada

#-------------------------------------------
# 6 - Gráfico de pontos (dispersão)
#-------------------------------------------
# Útil para exibir a relação entre duas variáveis contínuas.

ggplot(data = data_sample,
       mapping = aes(x = DAP, y = V)) + # 1ª camada
  geom_point()                          # 2ª camada

#-----------------------------
# 2ª camada:
# - A função geom_point() foi usada para adicionar uma camada
# de pontos no gráfico. Tem-se um gráfico de dispersão.
# - Importante: Para adicionar camadas usa-se o operador + (adição).
#-----------------------------

# 6.1 - Gráfico de pontos - Adicione linha de regressão
#-----------------------------------------------------

ggplot(data = data_sample,
       mapping = aes(x = DAP, y = V)) +       # 1ª camada
  geom_point() +                              # 2ª camada
  geom_smooth(method='lm', formula=y~x, se=F) # 3ª camada

# 3ª camada:
# - A função geom_smooth() foi usada para adicionar uma linha
# de regressão linear (y~x = V~DAP).

# 6.2 - Gráfico de pontos - polinômio de 2 grau
#-----------------------------------------------------
ggplot(data = data_sample,
       mapping = aes(x = DAP, y = V)) +          # 1ª camada
  geom_point() +                                 # 2ª camada
  geom_smooth(method='lm', formula=y~x, se=F) +  # 3ª camada
  geom_smooth(method='lm', formula=y~poly(x,2),
              se=F, color = "red")               # 4ª camada

# 4ª camada:
# - A função geom_smooth() foi usada para adicionar outra
# linha de regressão, porém de um polinômio de segundo
# grau (y~x^2 = V~DAP^2).

# 6.3 - Gráfico de pontos - polinômio de 10 grau
#-----------------------------------------------------

ggplot(data = data_sample,
       mapping = aes(x = DAP, y = V)) +          # 1ª camada
  geom_point() +                                 # 2ª camada
  geom_smooth(method='lm', formula=y~x, se=F) +  # 3ª camada
  geom_smooth(method='lm', formula=y~poly(x,2),
              se=F, color = "red") +             # 4ª camada
  geom_smooth(method='lm', formula=y~poly(x,10),
              se=F, color = "green")             # 5ª camada

# 5ª camada:
# - A função geom_smooth() foi usada para adicionar outra
# linha de regressão, porém de um polinômio de grau 10
# (y~x^10 = V~DAP^10).

# 6.4 - Gráfico de pontos - Modifique a cor dos pontos
#-----------------------------------------------------
# A ideia é identificar os pontos pertencentes a cada
# espécie.

ggplot(data = data_sample,
       mapping = aes(x = DAP, y = V)) +           # 1ª camada
  geom_point(mapping = aes(colour=Nome_Especie))  # 2ª camada


# 2ª camada:
# A função geom_point() também possui argumentos para
# customização de atributos estéticos. (?geom_point).
  ## mapping: pode receber argumentos por meio da função aes():
  ### x, y, alpha, **colour**, fill, group, shape, size, stroke

# O argumento **colour** recebeu a coluna "Nome_Especie" e
# mapeou diferentes cores para as categorias: Acapu, Andiroba,
# Goiabão, Maçaranduba.

# 6.5 - Gráfico de pontos - Modifique a forma dos pontos
#-----------------------------------------------------

ggplot(data = data_sample,
       mapping = aes(x = DAP, y = V)) +           # 1ª camada
  geom_point(mapping = aes(colour=Nome_Especie,
                           shape=Selecao))        # 2ª camada

# 2ª camada:
# O argumento **shape** recebeu a coluna "Selecao" e mapeou
# diferentes formas para as categorias: Explorar e Remanescente.


# 6.6 - Gráfico de pontos - Tamanho proporcional
#---------------------------------------------------
# - **Bubblechart** (gráfico de bolhas): É um gráfico de
# dispersão, em que uma terceira dimensão é adicionada.

# Vamos usar apenas os dados da "Maçaranduba" para melhor
# visualização dos efeitos. Mas, para isso é necessário
# filtrar apenas as linhas de dados da espécie.

ggplot(data = data_sample %>%
         filter(Nome_Especie == 'Maçaranduba'),
       mapping = aes(x = DAP, y = V)) +           # 1ª camada
  geom_point(mapping = aes(colour = Selecao,
                           size = HC))            # 2ª camada

# Ou de outro modo...

data_sample %>%
  filter(Nome_Especie == 'Maçaranduba') %>%
  ggplot(mapping = aes(x = DAP, y = V)) +         # 1ª camada
  geom_point(mapping = aes(colour = Selecao,
                           size = HC))            # 2ª camada

# 2ª camada:

# - O argumento **size** (dentro de aes()) recebeu a coluna "HC"
# e mapeou tamanhos de pontos proporcionais aos valores de HC.
# - Portanto, a altura de cada árvore é representada pelo
# tamanho do círculo.

# 6.7 - Gráfico de pontos - Modifique tamanho dos pontos
#---------------------------------------------------

# Vamos usar apenas os dados de "Maçaranduba" e "Acapu" para
# melhor visualização dos efeitos. Mas, para isso é necessário
# filtrar apenas as linhas de dados da espécie.

ggplot(data = data_sample %>%
         filter(Nome_Especie %in% c('Acapu', 'Maçaranduba')),
       mapping = aes(x = DAP, y = V)) +           # 1ª camada
  geom_point(mapping = aes(colour = Nome_Especie,
                           shape = Selecao),
             size = 4)                            # 2ª camada

# Ou de outro modo...

data_sample %>%
  filter(Nome_Especie %in% c('Acapu', 'Maçaranduba')) %>%
  ggplot(mapping = aes(x = DAP, y = V)) +        # 1ª camada
  geom_point(mapping =
               aes(colour = Nome_Especie,
                           shape = Selecao
                   ),
             size = 4)                            # 2ª camada

# 2ª camada:

# - Isso é feito com argumento **size**, porém fora de aes().
# - Especifique um valor inteiro para o argumento.


# 6.8 - Gráfico de pontos - Personalize a forma e a cor dos pontos
#----------------------------------------------------------------------

ggplot(data = data_sample %>%
         filter(Nome_Especie %in% c('Andiroba', 'Maçaranduba')),
       mapping = aes(x = DAP, y = V)) +               # 1ª camada
  geom_point(mapping = aes(colour = Nome_Especie,
                           shape = Selecao),
             size = 4) +                              # 2ª camada
  scale_shape_manual(values = c(3, 5)) +              # 3ª camada
  scale_color_manual(values = c('#F1C40F','#DE3163')) # 4ª camada

# Ou de outro modo...

data_sample %>%
  filter(Nome_Especie %in% c('Andiroba', 'Maçaranduba')) %>%
  ggplot(mapping = aes(x = DAP, y = V)) +             # 1ª camada
  geom_point(mapping =
               aes(colour = Nome_Especie,
                           shape = Selecao
                   ),
             size = 4) +                              # 2ª camada
  scale_shape_manual(values = c(3, 5)) +              # 3ª camada
  scale_color_manual(values = c('#F1C40F','#DE3163')) # 4ª camada

# 3ª e 4ª camadas:

# - Use scale_shape_manual() e scale_color_manual() para
# definir a forma e cor desejada para os pontos (e muito mais),
# respectivamente.


# 6.9 - Gráfico de pontos - Modifique legendas
#---------------------------------------------

ggplot(data = data_sample %>%
         filter(Nome_Especie %in% c('Andiroba', 'Maçaranduba')),
       mapping = aes(x = DAP, y = V)) +                 # 1ª camada
  geom_point(mapping = aes(colour = Nome_Especie,
                           shape = Selecao),
             size = 4) +                                # 2ª camada
  scale_shape_manual(values = c(3, 5),
                     labels = c("Árvore para explorar",
                                "Árvore remanescente"),
                     name = "Seleção") +                # 3ª camada
  scale_color_manual(values = c('#999999','#E69F00'),
                     labels = c("Carapa guianensis",
                                "Manilkara elata"),
                     name = "Espécie")                  # 4ª camada

# Ou de outro modo...

data_sample %>%
  filter(Nome_Especie %in% c('Andiroba', 'Maçaranduba')) %>%
ggplot(mapping = aes(x = DAP, y = V)) +                 # 1ª camada
  geom_point(mapping = aes(colour = Nome_Especie,
                           shape = Selecao),
             size = 4) +                                # 2ª camada
  scale_shape_manual(values = c(3, 5),
                     labels = c("Árvore para explorar",
                                "Árvore remanescente"),
                     name = "Seleção") +                # 3ª camada
  scale_color_manual(values = c('#999999','#E69F00'),
                     labels = c("Carapa guianensis",
                                "Manilkara elata"),
                     name = "Espécie")                  # 4ª camada

# 3ª e 4ª camadas:

# - Use scale_shape_manual() e scale_color_manual() para
# modificar as legendas atribuídas a partir das variáveis
# mapeadas em "shape" e "color" de geom_point(), respectivamente.
# - Explore os argumentos "labels" e "name".


# 6.10 - Gráfico de pontos - Modifique títulos e escalas
#------------------------------------------------------

data_sample %>%
  filter(Nome_Especie %in% c('Andiroba', 'Maçaranduba')) %>%
  ggplot(mapping = aes(x = DAP, y = V)) +             # 1ª camada
  geom_point(mapping = aes(colour = Nome_Especie,
                           shape = Selecao),
             size = 4
             ) +                                       # 2ª camada
  scale_shape_manual(values = c(3, 5),
                     labels = c("Árvore para explorar",
                                "Árvore remanescente"),
                     name = "Seleção") +               # 3ª camada
  scale_color_manual(values = c('#999999','#E69F00'),
                     labels = c("Carapa guianensis",
                                "Manilkara elata"),
                     name = "Espécie") +                # 4ª camada
  scale_x_continuous(name = "Diâmetro (cm)",
                     limits = c(35, 115),
                     breaks = seq(35, 115, 10))         # 5ª camada


# 5ª camada:

# - Argumentos "name", "limits" e "breaks" na camada de
# scale_x_continuous().
# - Experimente: scale_y_continuous().


# 6.11 - Gráfico de pontos - Adicione títulos,
# subtítulos, tags...
#-----------------------------------------------------

data_sample %>%
  filter(Nome_Especie %in% c('Andiroba', 'Maçaranduba')) %>%
  ggplot(mapping = aes(x = DAP, y = V)) +             # 1ª camada
  geom_point(mapping = aes(colour = Nome_Especie,
                           shape = Selecao),
             size = 4) +                              # 2ª camada
  scale_shape_manual(values = c(3, 5),
                     labels = c("Árvore para explorar",
                                "Árvore remanescente"),
                     name = "Seleção") +               # 3ª camada
  scale_color_manual(values = c('#999999','#E69F00'),
                     labels = c("Carapa guianensis",
                                "Manilkara elata"),
                     name = "Espécie") +               # 4ª camada
  labs(title = "Relação Volume-Diâmetro",
       subtitle = "(IF100% - Amazônia)",
       tag = "A", x = "Diâmetro (cm)",
       y = "Volume (m³)")                              # 5ª camada

# 5ª camada:
# - Experimente a função labs() para adicionar títulos.


# 6.12 - Gráfico de pontos - Adicione equações e estatísticas
#-----------------------------------------------------

# Uma maneira prática (não a única!) de adicionar um modelo
# ajustado (e suas estatísticas de ajuste) em um gráfico
# criado com ggplot2 é usar funções do pacote "ggpmisc".

# Vamos ajustar uma RL usando apenas dados da 'Maçaranduba'.

data_sample %>%
  filter(Nome_Especie %in% 'Maçaranduba') %>%
  ggplot(mapping = aes(x = DAP, y = V)) +       # 1ª camada
  geom_point() +                                # 2ª camada
  geom_smooth(method='lm', formula=y~x, se=F) + # 3ª camada
  ggpmisc::stat_poly_eq(formula = y~x,
                        eq.with.lhs = "italic(hat(V))~`=`~",
                        aes(label =
                              paste(..eq.label..,
                                    ..adj.rr.label..,
                                    ..AIC.label..,
                                    sep = "*plain(\",\")~")),
                        parse = TRUE)            # 4ª camada

# 4ª camada:
# - Use a função stat_poly_eq() do pacote ggpmisc para adicionar
#  informações de ajuste de um modelo linear.


# 6.13 - Gráfico de pontos - Adicione equações e estatísticas
#-----------------------------------------------------

# Adicione um polinômio de grau 2...

data_sample %>%
  filter(Nome_Especie %in% 'Maçaranduba') %>%
  ggplot(mapping = aes(x = DAP, y = V)) +       # 1ª camada
  geom_point() +                                # 2ª camada
  geom_smooth(method='lm',
              formula=y~poly(x,2), se=F) +      # 3ª camada
  ggpmisc::stat_poly_eq(formula = y~poly(x,2),
                        eq.with.lhs = "italic(hat(V))~`=`~",
                        aes(label =
                              paste(..eq.label..,
                                    ..adj.rr.label..,
                                    ..AIC.label..,
                                    sep = "*plain(\",\")~")),
                        parse = TRUE)            # 4ª camada

# 4ª camada:
# - Use a função stat_poly_eq() do pacote **ggpmisc** para
# adicionar informações de ajuste de um modelo linear.
# - Use poly() no argumento formula para modificar o grau do
# polinômio.



