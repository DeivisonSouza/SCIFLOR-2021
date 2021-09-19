#-----------------------------------------------------------------------------------
# Título: Introdução ao R para Análise de Dados
#-----------------------------------------------------------------------------------
# Subtítulo: Parte 3 - Análise Exploratória de Dados de IF 100%
# Autor: Prof. Dr. Deivison Venicio Souza
# Instituto: Universidade Federal do Pará (UFPA)
#-----------------------------------------------------------------------------------

##########################################################################
# Parte 1 - Tabelas Resumos do IF100%
##########################################################################

#----------------------------------
## Objetivo geral
#----------------------------------

# - Explorar dados de inventário florestal 100% realizado em floresta
# de Terra Firme na Amazônia brasileira.

#----------------------------------
## Objetivo específico
#----------------------------------

# - Obter tabelas resumo da quantidade de árvores por espécie;
# - Obter tabela resumo do número de árvores destinadas à explorar e
# remanescente por espécie.
# - Obter tabela...
# - Criar gráficos de distribuição diamétrica das espécies...

# 1: Instalar os pacotes necessários -----------------------------------
#install.packages("readr")
#install.packages("dplyr")

# 2: Carregar os pacotes necessários -----------------------------------
library(readr)
library(dplyr)
library(ggplot2)

# 3: Carregar o conjunto de dados --------------------------------------
data <- readr::read_csv("Slides/data/UPA07DVS.csv")
str(data)
dim(data)

#-------------------------- Importante!-------------------------------#
# Após carregar os dados, é importante inspecionar se a classe das
# variáveis estão  especificadas corretamente. Veja, por exemplo, que
# após executar a função read_csv() as variáveis são carregadas como
# sendo de dois tipos: double() ou character(). Assim, deve-se avaliar,
# para cada variável, se a classe está adequada.
#---------------------------------------------------------------------#

# Vamos carregar novamente a base, mas especificando a classe de cada
# variável...
data <- read_csv("Slides/data/UPA07DVS.csv",
                 col_types = "fiiffddff")
str(data)

#------------
# 4: Criando novas variáveis -------------------------------------------
# - Em geral, em campo, a variável CAP é coletada. Mas, para fins de obtenção
# do volume de cada árvore, é comum transformá-la para DAP. Em seguida, o
# volume é obtido.
# - Então, nesta etapa vamos fazer os cálculos de DAP e Volume e, em seguida,
# adicionar estas variáveis no objeto "data", que guarda a base de dados.

data <- data %>%
  mutate(DAP = CAP/pi,
         V07 = (pi*DAP^2/40000)*HC*0.7,
         VEq = 10^(0.181893687+(1.82878576*(log10(DAP/100)))+(0.654505046*log10(HC))))

#------------
# 5: Análise Exploratória de Dados -------------------------------------
# Volume por Unidade de Trabalho/Especie/Selecao
# Em se tratando de IF100% uma das informações requeridas é o volume e o
# número de árvores. Em geral, deseja-se saber o volume total por espécie,
# por categoria de seleção (explorar ou remanescente?) e por Unidade de
# Trabalho. Então, vamos gerar essas informações!

#-----------------------------------------
## 5.1 - Tabelas para Espécies
#-----------------------------------------
# Criar tabelas de frequências por espécie.
# Criar tabelas com soma e média de volume por espécie.

#-----------------------
# Qual a quantidade de espécies inventariadas?

data %>%
  summarise(n = n_distinct(Nome_Especie))

# length(unique(data$Nome_Especie))   # equivalente no R-base


#-----------------------
# 5.1.1 - Tabela 1
# Quais as espécies inventariadas?

data %>%
  distinct(Nome_Especie, Nome_Cientifico)


#-----------------------
# 5.1.2 - Tabela 2
# Qual número de árvores por espécie no IF100%?

n_Esp <- data %>%
  group_by(Nome_Especie, Nome_Cientifico) %>%
  summarise(n = n())

# Salve a tabela em .xlsx
write_excel_csv(n_Esp, "R/Output/Table/n_Esp.xlsx")


#-----------------------
# 5.1.3 - Tabela 3
# Qual o número de árvore por espécie?
# Qual a soma e média de volume por espécie?

n_V_Esp <- data %>%
  group_by(Nome_Especie, Nome_Cientifico) %>%
  summarise(n = n(),
            across(.cols = c(VEq),
                   .fns = list(soma=sum, media=mean),
                   na.rm = TRUE,
                   .names = "{.col}.{.fn}"
                   )
            )

# Salve a tabela em .xlsx
# write_excel_csv(n_V_Esp, "R/Output/Table/n_V_Esp.xlsx")


#-----------------------
# 5.1.4 - Tabela 4
# Qual o número de árvore por espécie para explorar e remanescente?

(n_esp_sel <- data %>%
    group_by(Nome_Especie, Nome_Cientifico, Selecao) %>%
    summarise(n = n()))


#-----------------------
# 5.1.5 - Tabela 5
# Qual o número de árvore por espécie para explorar e remanescente?
# Qual a soma e média de volume por espécie para explorar e remanescente?


n_V_Sel_Esp <- data %>%
  group_by(Nome_Especie, Nome_Cientifico, Selecao) %>%
  summarise(n = n(),
            across(.cols = c(VEq),
                   .fns = list(soma=sum, media=mean),
                   na.rm = TRUE,
                   .names = "{.col}.{.fn}"
            )
  )


#---------------------------------------------------------
## 5.2 - Tabelas para Espécies por Unidade de Trabalho
#---------------------------------------------------------
# Criar tabelas de frequências por espécie e UT.
# Criar tabelas com soma e média de volume por espécie e UT.
# E outras...

#-----------------------
# Qual a quantidade de espécies inventariadas por UT?

data %>%
  group_by(UT) %>%
  summarise(n = n_distinct(Nome_Especie))


#-----------------------
# 5.2.1 - Tabela 1
# Quais as espécies inventariadas por UT?

data %>%
  group_by(UT) %>%
  distinct(Nome_Especie, Nome_Cientifico)


#-----------------------
# 5.2.2 - Tabela 2
# Qual o número de árvore e volume total por UT?
data %>%
  group_by(UT) %>%
  summarise(n = n(), Soma = sum(VEq))


#-----------------------
# 5.2.3 - Tabela 3
# Qual o número de árvore e o volume total (explorar e remanescente) por UT?

data %>%
  group_by(UT, Selecao) %>%
  summarise(n = n(), Soma = sum(VEq))


#-----------------------
# 5.2.4 - Tabela 4
# Qual número de árvores por espécie e UT?

n_Esp_UT <- data %>%
  group_by(Nome_Especie, Nome_Cientifico, UT) %>%
  summarise(n = n())


#-----------------------
# 5.2.5 - Tabela 5
# Qual o número de árvore por espécie e UT?
# Qual a soma e média de volume por espécie e UT?

n_V_Esp_UT <- data %>%
  group_by(Nome_Especie, Nome_Cientifico, UT) %>%
  summarise(n = n(),
            across(.cols = c(VEq),
                   .fns = list(soma=sum, media=mean),
                   na.rm = TRUE,
                   .names = "{.col}.{.fn}"
            )
  )


#-----------------------
# 5.2.6 - Tabela 6
# Qual o número de árvore por espécie e UT para explorar e remanescente?

(n_esp_sel_UT <- data %>%
   group_by(Nome_Especie, Nome_Cientifico, UT, Selecao) %>%
   summarise(n = n()))


#-----------------------
# 5.2.7 - Tabela 7
# Qual o número de árvore por espécie e UT para explorar e remanescente?
# Qual a soma e média de volume por espécie e UT para explorar e remanescente?

n_V_UT_Sel_Esp <- data %>%
  group_by(Nome_Especie, Nome_Cientifico, UT, Selecao) %>%
  summarise(n = n(),
            across(.cols = c(VEq),
                   .fns = list(soma=sum, media=mean),
                   na.rm = TRUE,
                   .names = "{.col}.{.fn}"
            ),
            .groups = 'drop'
            )


#---------------------------------------------------------
## 5.3 - Tabelas para Espécies por Qualidade de Fuste
#---------------------------------------------------------
# Identificar se existem árvores para explorar com QF = 3.

# Você pode obter tabelas similares às anteriores. Basta apenas adicionar
# "QF" em group_by().
# Aqui, apenas iremos verificar se existe árvores prevista para exploração
# com qualidade de fuste 3 (QF = 3)? Não pode!

#-----------------------
# 5.3.1 - Tabela 1
# Qual o número de árvore (explorar e remanescente) por QF?

data %>%
  group_by(Selecao, QF) %>%
  summarise(n = n())


#------------------------------------------------------------------------
# Experimentar as funções a seguir para obter estatísticas descritivas
# Hmisc::describe(data)
# psych::describe(data)
# skimr::skim(data)
#------------------------------------------------------------------------

##########################################################################
# Parte 2 - Visualização de dados do IF100%
##########################################################################

# 1: Gráficos de contagem ------------------------------------------

#------------
# 1.1 - Número de árvores por espécie
# Temos um grande problema aqui! São muitas categorias...
# Uma alternativa pode ser um gráfico "lollipop" (pirulito)
# Um gráfico por família talvez fosse mais eficiente!
# Por enquanto, a nossa tabela é melhor!

data %>%
  group_by(Nome_Especie) %>%
  summarise(n = n()) %>%
  mutate(Nome_Especie =
           forcats::fct_reorder(Nome_Especie, n, .desc = F)
  ) %>%
  ggplot(aes(x=Nome_Especie, y=n)) +
  geom_point(color="blue", size=2, alpha=0.6) +
  geom_segment(aes(x=Nome_Especie, xend=Nome_Especie, y=0, yend=n),
               color="skyblue") +
  coord_flip() +
  theme_light() +
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  )

ggsave("lollipop.pdf", path = "R/Output/Figure",
       width = 20, height = 30, dpi = 600, units = "cm")


# Parei aqui!






#------------
# 2: Gráficos de barras (volume) -----------------------------------




# 1: Gráficos de barras -----------------------------------

# 6.1. Gráficos de barras

# Número de árvores por UT?
g1 <- data %>%
  group_by(UT) %>%
  summarise(n = n(), Soma = sum(VEq)) %>%
  ggplot(aes(x = forcats::fct_reorder(UT, n),
             y = n, fill = UT)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Unidades de Trabalho", y = "Número de árvores") +
  coord_flip() +
  geom_text(aes(label = paste(n)),
            position=position_dodge(width=0.9),
            vjust=.5, hjust=-.3) +
  scale_y_continuous(breaks = seq(0, 3700, 200),
                     limits = c(0, 3700)) +
  scale_x_discrete(breaks = 1:8,
                   labels = c("UT1", "UT2", "UT3", "UT4",
                              "UT6", "UT6", "UT7", "UT8")) +
  theme_bw() +
  theme(panel.border=element_rect(color="black"),
        legend.position="none",
        legend.title = element_blank())

ggsave("Output/Figure/Fig-Cont-UT.png", dpi=600, width=8, height=5, units="in")

#---------
# Volume por UT?

g2 <- data %>%
  group_by(UT) %>%
  summarise(n = n(), Soma = sum(VEq)) %>%
  ggplot(aes(x = forcats::fct_reorder(UT, Soma),
             y = Soma, fill = UT)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Unidades de Trabalho", y = "Volume Total (m³)") +
  coord_flip() +
  geom_text(aes(label = paste(round(Soma, 3))),
            position=position_dodge(width=0.9),
            vjust=.5, hjust=-.3) +
  scale_y_continuous(breaks = seq(0, 15000, 2000),
                     limits = c(0, 15000)) +
  scale_x_discrete(breaks = 1:8,
                   labels = c("UT1", "UT2", "UT3", "UT4",
                              "UT6", "UT6", "UT7", "UT8")) +
  theme_bw() +
  theme(panel.border=element_rect(color="black"),
        legend.position="none",
        legend.title = element_blank())

ggsave("Output/Figure/Fig-Vol-UT.png", dpi=600, width=8, height=5, units="in")

# Combina gráficos ---------------------------------------------------------

ggpubr::ggarrange(g1, g2,
                  nrow = 1, font.label = list(family ='Times',size = 12),
                  labels = c("(A)", "(B)")
)

ggsave("Output/Figure/Fig-Comb.png", dpi=600, width=16, height=5, units="in")

# End ---------

