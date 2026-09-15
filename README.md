# 🛍️ Olist E-Commerce Analytics Pipeline — Python & SQL

#### 📌 Sobre o Projeto
Este repositório contempla as etapas de **Engenharia de Dados (ETL/Data Wrangling)** e **Análise Relacional via SQL** sobre a base de dados pública do e-commerce brasileiro **Olist** (disponível no Kaggle).

O objetivo do projeto é estruturar uma pipeline confiável para ingestão, sanitização e análise de dados brutos complexos, tratando incoerências de formatação e viabilizando a extração de KPIs estratégicos de negócios.

---

### 🛠️ Tecnologias e Ferramentas Utilizadas
* **Python (Pandas & Unicodedata):** Limpeza pesada de dados, correção de enquadramento de aspas, caracteres de controle Unicode e exportação otimizada.
* **SQL (Relational Queries):** Modelagem relacional, junções relacionais (`JOINs`), window functions e agregações estratégicas.
* **Git / GitHub:** Controle de versão e documentação técnica.

---

### ⚙️ Arquitetura do Pipeline de Dados

[Dados Brutos / CSVs]

│

▼

[01. Python (Pandas & Unicodedata)] ──► Sanitização, Remoção de Nulos e Ajuste UTF-8
│
▼

[02. Banco de Dados Relacional / SQL] ──► Agregações, KPIs Comerciais e Modelagem
│
▼

[03. Power BI] (Em Desenvolvimento / Roadmap) ──► Visualização Executiva de Dados

---

### 🎯 Desafios Técnicos Solucionados com Python

Durante a etapa de **Data Wrangling** com Python, foram identificadas e resolvidas diversas inconsistências comuns em bases legadas reais:
* **Sanitização de Strings e Aspas Internas:** Correção de quebras de estrutura em arquivos CSV causadas por aspas soltas dentro dos textos de avaliações dos clientes.
* **Tratamento de Caracteres não-ASCII:** Identificação e substituição de caracteres de controle invisíveis usando a biblioteca `unicodedata`.
* **Integridade de Exportação:** Configuração de delimitadores e parâmetros de citação (`quoting`) para assegurar leitura perfeita em SGBDs e ferramentas de BI.

---

### 📂 Estrutura do Repositório
```text
📁 Olist-Ecommerce-Pipeline/
│
├── 📁 python_etl/             # Scripts Python para limpeza e sanitização
│   └── sanitizacao_reviews.py
│
├── 📁 scripts/            # Scripts SQL para consulta e KPIs de negócio
│   ├── 01_schema_database.sql
│   └── 02_analises_kpis.sql
│
└── 📄 README.md                  # Documentação do projeto


---

🚧 Roadmap de Desenvolvimento
[x] Fase 1 (Python): Tratamento de dados brutos, caracteres especiais e validação de arquivos.

[x] Fase 2 (SQL): Criação das tabelas relacionais, limpeza secundária e geração de consultas de KPIs.

[ ] Fase 3 (Power BI): Construção do Dashboard Interativo e Storytelling com Dados (Em andamento).

👨💻 Autor
José Rafael Santos Pereira

Desenvolvendo soluções práticas de dados | Power BI | SQL | Python | Business Intelligence

LinkedIn: https://www.linkedin.com/in/rafaelsantospereirarsp/

GitHub: https://github.com/ZeRafaSp/
