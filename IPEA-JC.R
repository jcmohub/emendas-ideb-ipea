# Carregar pacote necessário
library(readr)

# Lendo o CSV com caminho completo
emendas <- read_csv("C:/Users/jcmonate/Desktop/Projeto - IPEA/emendas.csv")

# Ver as primeiras linhas
head(emendas)





emendas <- read.csv("C:/Users/jcmonate/Desktop/Projeto - IPEA/emendas.csv",
                    sep = ";", fileEncoding = "UTF-8")

# Verificar se carregou corretamente
head(emendas)



library(readr)
library(dplyr)

glimpse(emendas)  # Agora deve funcionar




emendas <- read_delim("C:/Users/jcmonate/Desktop/Projeto - IPEA/emendas.csv",
                      delim = ";",
                      locale = locale(encoding = "Latin1"))

# Verificar se agora tem dados
glimpse(emendas)



######################### limpeza e transformação inicial ######################
################################################################################
install.packages("janitor")
library(dplyr)
library(janitor)

# 1. Renomear e selecionar colunas importantes
emendas_limpo <- emendas %>%
  clean_names() %>%
  select(ano,
         tipo_de_emenda,
         autor_da_emenda,
         localidade_do_gasto_regionalizacao,
         valor_empenhado,
         valor_pago)

# 2. Tratar os valores monetários: remover "." e trocar "," por "." e converter para número
emendas_limpo <- emendas_limpo %>%
  mutate(
    valor_empenhado = as.numeric(gsub(",", ".", gsub("\\.", "", valor_empenhado))),
    valor_pago = as.numeric(gsub(",", ".", gsub("\\.", "", valor_pago)))
  )



emendas_agrupadas <- emendas_limpo %>%
  group_by(ano, localidade_do_gasto_regionalizacao) %>%
  summarise(
    total_empenhado = sum(valor_empenhado, na.rm = TRUE),
    total_pago = sum(valor_pago, na.rm = TRUE),
    .groups = "drop"
  )

# Ver os 10 primeiros resultados
head(emendas_agrupadas, 10)



# Filtrar apenas localidades que são estados (UFs)
emendas_uf <- emendas_agrupadas %>%
  filter(grepl("\\(UF\\)", localidade_do_gasto_regionalizacao)) %>%
  mutate(
    uf = gsub(" \\(UF\\)", "", localidade_do_gasto_regionalizacao),
    uf = toupper(uf)  # garantir caixa alta para cruzamento com o IDEB depois
  )



head(emendas_uf, 10)
unique(emendas_uf$uf)  # para ver os nomes dos estados





# Simulação do IDEB por UF e ano
ideb_uf <- tribble(
  ~uf,                ~ano, ~ideb,
  "ACRE",             2021, 4.7,
  "ALAGOAS",          2021, 4.5,
  "AMAPÁ",            2021, 4.6,
  "AMAZONAS",         2021, 4.8,
  "BAHIA",            2021, 4.9,
  "CEARÁ",            2021, 5.7,
  "DISTRITO FEDERAL", 2021, 5.1,
  "ESPÍRITO SANTO",   2021, 5.3,
  "GOIÁS",            2021, 5.4,
  "MARANHÃO",         2021, 4.8,
  "MATO GROSSO",      2021, 5.2,
  "MATO GROSSO DO SUL",2021, 5.3,
  "MINAS GERAIS",     2021, 5.5,
  "PARANÁ",           2021, 5.7,
  "PARAÍBA",          2021, 5.0,
  "PARÁ",             2021, 4.4,
  "PERNAMBUCO",       2021, 5.2,
  "PIAUÍ",            2021, 5.1,
  "RIO DE JANEIRO",   2021, 4.9,
  "RIO GRANDE DO NORTE", 2021, 4.8,
  "RIO GRANDE DO SUL", 2021, 5.3,
  "RONDÔNIA",         2021, 5.0,
  "RORAIMA",          2021, 4.7,
  "SANTA CATARINA",   2021, 5.5,
  "SERGIPE",          2021, 4.8,
  "SÃO PAULO",        2021, 5.5,
  "TOCANTINS",        2021, 5.0
)


base_final <- emendas_uf %>%
  filter(ano == 2021) %>%  # cruzar apenas com o ano do IDEB disponível
  left_join(ideb_uf, by = c("uf", "ano"))




# Ver as primeiras linhas
head(base_final)

# Ver correlação entre IDEB e valor empenhado
cor(base_final$ideb, base_final$total_empenhado, use = "complete.obs")





############## GRAFICO DE DISPERSAO ###########################################
library(ggplot2)

ggplot(base_final, aes(x = ideb, y = total_empenhado)) +
  geom_point(color = "darkblue", size = 3) +
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed") +
  labs(title = "IDEB vs. Total de Emendas Empenhadas na Educação (2021)",
       x = "IDEB (Ensino Fundamental - Anos Finais)",
       y = "Total Empenhado (R$)") +
  theme_minimal()



################# Categorizar estados por faixas de IDEB ######################
base_final <- base_final %>%
  mutate(faixa_ideb = case_when(
    ideb < 4.8 ~ "baixo",
    ideb >= 4.8 & ideb < 5.3 ~ "médio",
    ideb >= 5.3 ~ "alto"
  ))

# Total médio por faixa
base_final %>%
  group_by(faixa_ideb) %>%
  summarise(media_empenhada = mean(total_empenhado))


























