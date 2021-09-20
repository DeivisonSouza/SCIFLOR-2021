#-----------------------------------------------------------------------------------
# Título: Introdução ao R para Análise de Dados
#-----------------------------------------------------------------------------------
# Subtítulo: Parte 5 - Análise de Regressão Linear
# Autor: Prof. Dr. Deivison Venicio Souza
# Instituto: Universidade Federal do Pará (UFPA)
#-----------------------------------------------------------------------------------

# Sobre o conjunto de dados
#---------------------------------------------
# Conjunto 1:
# São dados de 31 cerejeiras (Prunus serotina).
# Possui 3 variáveis: diâmetro, altura e volume de madeira
# Acesso: datasets::trees ou labestData::DemetrioEx1.4.1.4
# Objetivo: Modelar o volume como função das variáveis diâmetro
# e altura das cerejeiras.

#---------------------------------------------------------------
# Parte 1 - Análise Exploratória de Dados - Dados Cerejeiras
#---------------------------------------------------------------

# 1: Instala pacotes -------------------------------------------
#install.packages("readr")
#install.packages("dplyr")
#install.packages("ggplot2")
#install.packages("patchwork")
#install.packages("corrr")

# 2: Carrega pacotes -------------------------------------------
library(readr)     # importação e exportação de dados
library(dplyr)     # manipulação de dados
library(ggplot2)   # visualização de dados
library(patchwork) # combinar gráficos em painel
library(corrr)     # calcular correlações (tidymodels)

# 3: Conjunto de dados -------------------------------------------

data <- labestData::DemetrioEx1.4.1.4

# 4: Relação entre variáveis -------------------------------------

# Volume x Diâmetro
# Mostra um tendência linear na relação...
data %>%
  ggplot(mapping = aes(x = dia, y = vol)) +
  geom_point() +
  labs(x = "Diâmetro (inches/polegadas)",
       y = "Volume (cubic ft/pés cúbicos)")

# Volume x Altura
# Uma relação não linear e alta variação...
data %>%
  ggplot(mapping = aes(x = alt, y = vol)) +
  geom_point() +
  labs(x = "Altura (ft/pés)",
       y = "Volume (cubic ft/pés cúbicos)")

#---------------
# Correlação entre as variáveis
# Existem vários pacotes dedicados à estimar correlações e
# criar visualizações gráficas destas. Escolha qual preferir!
# A seguir algumas possibilidades...

# Opção 1: Correlação com função cor() stats (R-base)
data %>%
  cor()

# Opção 2: Correlação com Pacote "Hmisc"
data %>%
  as.matrix() %>%
  Hmisc::rcorr(type = "pearson")

# A função rcorr() retorna uma lista contendo:
# r: matriz de correlação.
# P: Valor p do teste.

#---------------------------
# Interpretação:
# - A correlação entre volume e diâmetro é 0,97. O p-valor para
# essa correlação é menor do que 0,05 (menor do que o nível de
# significância alfa = 0,05). Portanto, é razoável admitir que
# a correlação entre as duas variáveis é significativa.
#----------------------------

#--------------------
# Opção 3: Correlação com Pacote "corrr"

# Função correlate()-------------
# É a função principal que retorna as correlações...

data %>%
  corrr::correlate(method = "pearson",
                   quiet = T)        # saída é uma tibble

# Função focus()-----------------
# É usada para focar nas correlações desejadas...
# A seguir o foco é na correlaçao do "vol" com as demais variáveis

data %>%
  corrr::correlate(method = "pearson", quiet = T) %>%
  corrr::focus(vol)

# Função fashion()-----------------
# Use para uma impressão mais bonita...

data %>%
  corrr::correlate(method = "pearson", quiet = T) %>%
  corrr::fashion()

# Função stretch()-----------------
# Saída em um formato longo...

data %>%
  corrr::correlate(method = "pearson", quiet = T) %>%
  corrr::stretch()

# Função  network_plot()-----------------
data %>%
  correlate() %>%
  network_plot(min_cor = .1,
               colors = c("red", "green"))

# Crie um gráfico personalizado
# Conversa muito bem com ggplot...

data %>%
  corrr::correlate(method = "pearson", quiet = T) %>%
  corrr::focus(vol) %>%
  ggplot(mapping = aes(x=term, y = vol)) +
  geom_bar(aes(fill = term), stat = "identity")

#------------
# 5: Modelo Clássico de Regressão Linear ---------------------
# - Como existe uma relação linear forte entre volume e diâmetro,
# é razoável supor um modelo linear para descrever a relação
# entre estas variáveis.
# - Portanto, nesta seção, a ideia é explorar o modelo clássico
# de regressão linear, que pressupõe distribuição normal
# para a variável resposta. Vamos especificar apenas 2
# modelos, e avaliar sua adequação por meio de estatísticas
# de ajustes e diagnóstico residual. Os parâmetros dos
# modelos são estimados por Mínimos Quadrados Ordinários (MQO).


#-----------------------
# 5.1 - Ajuste do modelo linear normal
# m1: objeto que guarda as informações de ajuste

#-------------------------------------------------
# Modelo 1: vol = β0 + β1*dia (sem transformação)
#-------------------------------------------------

m1 <- lm(vol ~ dia, data=data)

# Extraindo informações do ajuste...

names(m1)         # elementos gerados pelo ajuste da RL
summary(m1)       # Resumo do modelo ajustado
anova(m1)         # ANOVA da RL
coefficients(m1)  # Coeficientes estimados
fitted(m1)        # Predições/estimativas para conj. ajuste
predict(m1)       # Idem...
residuals(m1)     # Resíduos ordinários
confint(m1)       # IC (95%) para os parâmetros do modelo
confint(m1,
        level=0.99) # IC (99%) para os parâmetros do modelo

#---------------
# Gráfico com modelo ajustado

# Opção 1:
#---------------

data %>%
  ggplot(aes(x=dia, y=vol)) +
  geom_point() +
  geom_line(aes(y = predict(m1)),
            size = 1,
            color = "red")

# Opção 2:
#---------------
data %>%
   ggplot(mapping = aes(x=dia, y=vol)) +         # 1ª camada
   geom_point() +                                # 2ª camada
   geom_smooth(method='lm', formula=y~x, se=F) + # 3ª camada
   ggpmisc::stat_poly_eq(formula = y~x,
                         eq.with.lhs = "italic(hat(V))~`=`~",
                         aes(label =
                               paste(..eq.label..,
                                     ..adj.rr.label..,
                                     sep = "*plain(\",\")~")),
                         parse = TRUE)       # 4ª camada

#----------------
# Diagnóstico dos resíduos
# Objetivos:
# - Avaliar as pressuposições do modelo linear normal:
# a) Os erros são normalmente distribuídos?
# b) A variância dos erros é constante?
# - Avaliar a existência de pontos influentes, que estejam
# prejudicando o ajuste do modelo.
#
# Lembre-se: Toda observação têm impacto nos parâmetros ajustado.

par(mfrow = c(2, 2))
plot(m1)

# Grafico 1 (Residuals vs Fitted)
# - Usado para identificar falta de ajuste (ou não) do modelo.
# - No exemplo, fica evidente a falta de ajuste do modelo aos
# dados. O comportamento desejável é uma distribuição uniforme
# em torno do resíduo zero.
# A linha vermelha descreve a tendência do comportamento do
# resíduo em função das predições. É desejável que está linha
# esteja horizontal. Não é o caso!


# Grafico 2 (Scale-Location)
# - Usado para avaliar se os erros possuem variância constante.
# A linha vermelha descreve a tendência do comportamento da
# raiz quadrada do módulo dos resíduos padronizados em função
# das predições.
# Desejável: é que a linha esteja bem próximo da horizontal.
# Isto indicaria que os erros são constantes. Não é o caso!


# Grafico 3 (superior direita)
# - Indica a se existe normalidade (ou não) dos residuos
# - Desejável: deve existir uma predominância das observações
# em cima da linha diagonal do gráfico. Isso indicaria que os
# resíduos tendem a uma distribuição normal. Pequenas "fugas"
# são normais e aceitáveis.

# Grafico 4 (inferior direita)
# - Ajudar a detectar pontos influentes no modelo ajustado.
# - Os pontos com alta alavancagem podem ser influentes.
#  Ou seja, excluí-los mudaria muito o modelo.
#  Neste caso, não há pontos fora da linha pontilhada.

# Conclusão:
# O Modelo 1: vol = β0 + β1*dia mostrou falta de ajuste, indicado
# pelo gráfico "Residuals vs Fitted". Portanto, deve-se buscar um
# modelo com melhor especificação.

# Será que uma transformação logarítimica não melhoria o ajuste?

#------------------------------------------------------
# Modelo 2: log(vol) = β0 + β1*log(dia) +  β2*log(alt)
# (com transformação)
#------------------------------------------------------

m2 <- lm(log(vol) ~ log(dia) + log(alt), data=data)


# Extraindo informações do ajuste...

names(m2)         # elementos gerados pelo ajuste da RL
summary(m2)       # Resumo do modelo ajustado
anova(m2)         # ANOVA da RL
coefficients(m2)  # Coeficientes estimados
fitted(m2)        # Predições/estimativas para conj. ajuste
predict(m2)       # Idem...
residuals(m2)     # Resíduos ordinários

#----------------
# Graficos de resíduos do R-base
par(mfrow = c(2, 2))
plot(m2)

# Grafico 1 (Residuals vs Fitted)
# - O modelo está melhor ajustado do que o modelo 1.

# Grafico 2 (Scale-Location)
# - Parece ainda existir problemas de heterocedasticidade.

# Grafico 3 (superior direita)
# - Existe uma predominância das observações em cima da linha
# diagonal do gráfico. Alguns ponto com "fuga", mas não parece
# muito grave.

# Grafico 4 (inferior direita)
#  Neste caso, não há pontos fora da linha pontilhada. Sem
#  indicação de pontos influentes.


# Fim
# -----------------
