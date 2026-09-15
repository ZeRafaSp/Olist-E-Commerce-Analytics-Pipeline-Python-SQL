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

```text
[Dados Brutos / CSVs] 
       │
       ▼
[01. Python (Pandas)] ──► Sanitização de aspas internas e Ajuste de codificação
       │
       ▼
[02. Banco Relacional SQL] ──► Agregações, KPIs Comerciais e Modelagem
       │
       ▼
[03. Power BI] (Roadmap) ──► Visualização Executiva de Dados

---

### 📊 Principais Insights e Métricas de Negócio (SQL)
As consultas SQL desenvolvidas no projeto permitem extrair indicadores fundamentais para a operação do e-commerce:

Visão Geral da Operação: Cálculo de volume total de pedidos, quantidade de clientes únicos, faturamento global e ticket médio por pedido. 

Logística e Prazos (SLAs): Análise do tempo médio de entrega (em dias), diferença de dias entre a data estimada e a data real de entrega, além do mapeamento do percentual de pedidos atrasados segmentados por Estado.  

Comportamento e Retenção: Avaliação da taxa de retenção mapeando clientes recorrentes (compras > 1) em contraste com clientes de compra única, revelando o percentual exato de recorrência da base.  

Meios de Pagamento: Distribuição do volume financeiro e quantidade de transações divididas por método de pagamento e número de parcelas escolhidas pelos consumidores.  

---

### 🗂️ Modelagem Relacional (Modelo ER)
A integridade referencial do banco de dados foi construída e validada através de scripts DDL com definição de Chaves Primárias (PRIMARY KEY) e Chaves Estrangeiras (FOREIGN KEY):  

Tabelas de Dimensão e Fato: Clientes, produtos e vendedores funcionam como dimensões. A tabela de pedidos (olist_orders_dataset) atua no centro, conectada aos itens vendidos (olist_order_items_dataset), que por sua vez ligam-se aos produtos e aos vendedores parceiros.  


Outras conexões importantes incluem pagamentos (olist_order_payments_dataset) e avaliações (olist_order_reviews_dataset) ligados diretamente ao ID do pedido, além da tradução de categorias amarrada à tabela de produtos.  

---

### 💡 Destaques de Código e Técnicas Aplicadas
1. Tratamento Avançado de Strings em Python (Pandas)
Para resolver problemas de importação (quebra de colunas) gerados pela base bruta, o script em Python foi projetado para:

Varrer o arquivo e identificar linhas problemáticas verificando se a quantidade de aspas (count('"')) é ímpar, o que desbalanceia a estrutura do CSV.  

Remover todas as aspas textuais internas presentes nos comentários de avaliações dos clientes (str.replace('"', '', regex=False)), garantindo uma exportação perfeitamente formatada.  

2. Agregações Complexas e Cláusula FILTER em SQL
Para otimizar o desempenho das extrações, foram utilizadas práticas avançadas:

Estruturação de consultas utilizando CTEs (WITH clause) para isolar etapas de cálculo, como a contagem de clientes e pedidos antes das divisões finais.  

Uso da cláusula FILTER (WHERE ...) combinada com agregações (COUNT) para calcular rapidamente condições específicas na mesma linha (ex: filtrar apenas atrasos ou apenas compras > 1) sem a necessidade de múltiplos e custosos CASE WHEN.  

Conversão temporal utilizando EXTRACT(EPOCH FROM ...)/86400 para extrair a diferença exata em dias entre as datas de aprovação, envio e entrega real do produto aos clientes.  

---

### 📂 Estrutura do Repositório
Plaintext


📁 Olist-Ecommerce-Pipeline/
│
├── 📁 python_etl/                # Scripts Python para limpeza e sanitização
│   └── sanitizacao_reviews.py
│
├── 📁 scripts/                   # Scripts SQL para criação de DDL, KPIs e métricas
│   ├── 01_schema_database.sql
│   └── 02_analises_kpis.sql
│
└── 📄 README.md                  # Documentação do projeto

---

### 🚧 Roadmap de Desenvolvimento
[x] Fase 1 (Python): Tratamento de dados brutos, caracteres especiais e validação estrutural de arquivos CSV.  


[x] Fase 2 (SQL): Criação das restrições relacionais, limpeza secundária e geração de consultas complexas de KPIs.  


[ ] Fase 3 (Power BI): Construção do Dashboard Interativo e Storytelling visual de E-Commerce (Em andamento).  

---

👨‍💻 Autor
José Rafael Santos Pereira

Desenvolvendo soluções práticas de dados | Power BI | SQL | Python | Business Intelligence


LinkedIn: https://www.linkedin.com/in/rafaelsantospereirarsp/

GitHub: https://github.com/ZeRafaSp/

