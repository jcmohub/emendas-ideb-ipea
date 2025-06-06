# emendas-ideb-ipea
Análise da distribuição de emendas parlamentares na educação em relação ao IDEB por estado (2021)
# emendas-ideb-ipea

📊 Análise da distribuição de emendas parlamentares na educação em relação ao IDEB por estado (2021)

Este repositório contém os dados e scripts utilizados na análise exploratória sobre a relação entre o desempenho educacional dos estados brasileiros, medido pelo IDEB, e os valores empenhados por emendas parlamentares na função orçamentária "Educação".

---

## 🎯 Objetivo

Investigar se estados com menor desempenho no IDEB (Ensino Fundamental – Anos Finais) receberam proporcionalmente mais recursos via emendas parlamentares na área da educação no ano de 2021.

---

## 📁 Estrutura do repositório

- `emendas.csv` – Dados extraídos do Portal da Transparência com emendas para a função Educação (2020 a 2024)
- `ideb_uf_2021.csv` – IDEB estadual de 2021 (Ensino Fundamental – Anos Finais)
- `IPEA-JC.R` – Script em R para limpeza, tratamento, análise e visualizações
- `grafico_dispersão_ideb.png` – Gráfico de dispersão com linha de regressão (IDEB vs. Total Empenhado)

---

## 🛠️ Ferramentas utilizadas

- Linguagem: **R**
- Pacotes: `readr`, `dplyr`, `ggplot2`, `janitor`

---

## 🔗 Fonte dos dados

- [Portal da Transparência – Emendas Parlamentares](https://www.portaldatransparencia.gov.br/emendas)
- [INEP – IDEB por Unidade da Federação](https://ideb.inep.gov.br/resultado)

---

## 📈 Resultados preliminares

- A correlação entre o IDEB e o total de emendas empenhadas foi positiva, porém fraca (r ≈ 0.13)
- Estados com IDEB mais alto receberam, em média, valores maiores de emendas na função educação
- Não se observa uma política de compensação proporcional a baixo desempenho educacional

---

## 👤 Autor

José Carlos Martinez  
Candidato à Chamada Pública 032/2025 – IPEA | Projeto NINSOC  
Residência Técnica IPARDES | Pós-graduação em Data Science – UFPR  
