# 🛍️ Olist E-Commerce Analytics Pipeline — Python & SQL

## 📌 Sobre o Projeto

Este projeto apresenta um fluxo de **tratamento, validação e análise de dados** utilizando a base pública do e-commerce brasileiro **Olist**.

O objetivo é transformar arquivos CSV brutos em uma base estruturada e adequada para análise, passando por etapas de **Data Wrangling com Python**, organização e relacionamento dos dados em **PostgreSQL** e desenvolvimento de consultas SQL para extração de indicadores de negócio.

Como etapa posterior, os resultados serão utilizados na construção de um **dashboard no Power BI**, permitindo transformar as análises realizadas em SQL em uma visão visual e interativa do negócio.

---

## 🎯 Objetivos

- Tratar problemas de qualidade presentes nos arquivos CSV.
- Preparar os dados para importação em um banco de dados relacional.
- Estruturar os relacionamentos entre as diferentes tabelas da base Olist.
- Garantir a integridade referencial por meio de chaves primárias e estrangeiras.
- Desenvolver consultas SQL para análise comercial, logística e comportamento dos clientes.
- Extrair indicadores relevantes para análise do negócio.
- Preparar os resultados para visualização no Power BI.

---

## 🛠️ Tecnologias e Ferramentas

| Tecnologia | Utilização |
|---|---|
| 🐍 **Python** | Tratamento, limpeza e validação dos arquivos CSV |
| 🐼 **Pandas** | Manipulação e transformação dos dados |
| 🗄️ **PostgreSQL** | Armazenamento e modelagem relacional |
| 🔎 **SQL** | Consultas analíticas, agregações e criação de KPIs |
| 🛠️ **DBeaver** | Gerenciamento do banco e execução das consultas SQL |
| 📊 **Power BI** | Visualização e construção do dashboard |
| 🌱 **Git / GitHub** | Controle de versão e documentação |

---

# 🐍 1. Tratamento dos Dados com Python

A primeira etapa do projeto foi dedicada à preparação dos arquivos CSV para posterior importação no banco de dados.

Durante a análise da base, foram identificados problemas de formatação, principalmente no arquivo de avaliações dos pedidos (`olist_order_reviews_dataset`), que poderiam comprometer a correta interpretação das colunas durante a importação.

### Principais tratamentos realizados

- Identificação de linhas com problemas estruturais.
- Tratamento de aspas presentes nos textos das avaliações.
- Remoção de quebras de linha presentes dentro dos campos textuais.
- Tratamento de caracteres de controle e problemas de codificação.
- Remoção de caracteres que poderiam interferir na estrutura do CSV.
- Padronização da estrutura dos arquivos.
- Exportação dos arquivos tratados para importação no PostgreSQL.
- Validação da quantidade de registros e colunas após o tratamento.

Um dos principais desafios foi garantir que os textos presentes nas avaliações não fossem interpretados como delimitadores ou quebras de registros durante a importação.

### 🔎 Validação da Qualidade dos Dados

Após o tratamento, foram realizadas validações para verificar:

- Quantidade de registros;
- Quantidade de colunas;
- Valores nulos;
- Registros duplicados;
- Duplicidade de identificadores;
- Formato dos identificadores;
- Intervalo dos valores de avaliação;
- Formato das datas.

Essa etapa teve como objetivo garantir uma estrutura confiável para as análises realizadas posteriormente.

---

# 🗄️ 2. Modelagem Relacional com PostgreSQL

Após o tratamento dos arquivos, os dados foram importados para um banco de dados PostgreSQL.

A estrutura da base foi organizada de forma relacional, estabelecendo os relacionamentos entre as principais entidades do e-commerce.

### Principais tabelas utilizadas

- `olist_customers_dataset`
- `olist_orders_dataset`
- `olist_order_items_dataset`
- `olist_products_dataset`
- `olist_sellers_dataset`
- `olist_order_payments_dataset`
- `olist_order_reviews_dataset`
- `product_category_name_translation`

### 🔗 Integridade Referencial

Foram definidas e validadas:

- **Primary Keys (PK)**
- **Foreign Keys (FK)**
- Relacionamentos entre pedidos, clientes, produtos, vendedores, pagamentos e avaliações.

A tabela `olist_orders_dataset` representa uma das principais entidades do modelo, relacionando-se com informações de clientes, itens vendidos, pagamentos e avaliações.

A tabela `olist_order_items_dataset` estabelece os relacionamentos entre os pedidos, produtos e vendedores, permitindo análises comerciais mais detalhadas.

---

# 🔎 3. Análise dos Dados com SQL

Com a base estruturada no PostgreSQL, foram desenvolvidas consultas SQL para analisar diferentes aspectos da operação do e-commerce.

## 📊 Visão Geral do Negócio

Foram calculados indicadores como:

- Quantidade total de pedidos;
- Quantidade de clientes;
- Quantidade de vendedores;
- Quantidade de produtos;
- Faturamento total;
- Ticket médio por pedido.

## 🚚 Logística e Entregas

Foram desenvolvidas análises relacionadas ao processo de entrega, incluindo:

- Tempo médio de entrega;
- Diferença entre prazo estimado e prazo real;
- Identificação de pedidos atrasados;
- Percentual de atrasos;
- Análises segmentadas por estado.

## 👥 Comportamento dos Clientes

Foram realizadas análises para identificar:

- Clientes recorrentes;
- Clientes que realizaram apenas uma compra;
- Quantidade de pedidos por cliente;
- Taxa de recorrência da base.

## 💳 Meios de Pagamento

Foram analisados:

- Métodos de pagamento utilizados;
- Quantidade de transações;
- Volume financeiro;
- Número de parcelas escolhidas pelos clientes.

## 📅 Evolução Temporal

Também foram desenvolvidas consultas para analisar a evolução das vendas ao longo do tempo, incluindo agregações por período e comparação entre períodos consecutivos.

---

# 🧠 4. Técnicas SQL Aplicadas

Durante o desenvolvimento das análises foram utilizadas diferentes técnicas de SQL.

### CTEs — Common Table Expressions

Utilização da cláusula `WITH` para dividir consultas complexas em etapas menores e mais organizadas.

```sql
WITH vendas AS (
    SELECT
        ...
    FROM ...
)
SELECT
    ...
FROM vendas;
```

Essa abordagem facilita a leitura, manutenção e organização das consultas analíticas.

Agregações

Foram utilizadas funções como:
```
COUNT()
SUM()
AVG()
MIN()
MAX()
```
para geração dos principais indicadores do projeto.

**JOINs**

Foram utilizados diferentes tipos de JOIN para combinar informações provenientes das diversas tabelas relacionais.

**FILTER**

A cláusula FILTER (WHERE ...) foi utilizada em agregações para calcular métricas condicionais dentro da mesma consulta.

**Funções de Janela**

Foram utilizadas funções de janela em análises que exigem comparação entre registros ou períodos, permitindo desenvolver análises temporais e métricas mais avançadas.

# 📊 5. Power BI

Como etapa de visualização, os resultados das consultas SQL serão utilizados na construção de um dashboard no Power BI.

O objetivo é transformar os indicadores obtidos por meio do SQL em uma visão visual e interativa da operação do e-commerce.

---

### Análises previstas no dashboard

- Evolução das vendas;
- Indicadores comerciais;
- Desempenho por categoria;
- Indicadores logísticos;
- Comportamento dos clientes;
- Meios de pagamento.

> 🚧 **Status:** Dashboard em desenvolvimento.

---

# 📈 6. Principais Indicadores

| Área | Indicadores |
|---|---|
| 💰 **Comercial** | Faturamento, ticket médio e volume de pedidos |
| 👥 **Clientes** | Clientes únicos, recorrência e pedidos por cliente |
| 🚚 **Logística** | Tempo médio de entrega e percentual de atrasos |
| 💳 **Pagamentos** | Métodos de pagamento, parcelas e volume financeiro |
| 📦 **Produtos** | Categorias, produtos e volume de vendas |
| 📅 **Temporal** | Evolução das vendas e variação entre períodos |

---

## 7. Estrutura do Repositório

```text
📁 Olist-Ecommerce-Pipeline/
│
├── 📁 python_etl/
│   └── sanitizacao_reviews.py
│
├── 📁 scripts/
│   ├── 01_schema_database.sql
│   └── 02_analises_kpis.sql
│
├── 📁 data/
│   └── Arquivos tratados / instruções de obtenção
│
└── 📄 README.md
```

---

## 8. Roadmap do Projeto

### Fase 1 — Tratamento e preparação dos dados
- [x] Importação dos datasets
- [x] Identificação de problemas de qualidade
- [x] Tratamento e sanitização dos arquivos
- [x] Validação dos dados
- [x] Preparação dos arquivos para importação

### Fase 2 — Banco de dados e análise SQL
- [x] Criação do banco PostgreSQL
- [x] Criação das tabelas
- [x] Definição das chaves primárias e estrangeiras
- [x] Validação dos relacionamentos
- [x] Criação das consultas analíticas
- [x] Análise de indicadores de negócio
- [x] Análise temporal das vendas

### Fase 3 — Power BI
- [ ] Conexão do Power BI com os dados
- [ ] Modelagem dos dados
- [ ] Criação das medidas DAX
- [ ] Desenvolvimento do dashboard
- [ ] Criação de indicadores e visualizações
- [ ] Análise dos principais insights

---

## 9. Competências Demonstradas

Este projeto demonstra conhecimentos práticos em:

- **Python**
- **Pandas**
- **Data Wrangling**
- **Tratamento e validação de dados**
- **ETL**
- **PostgreSQL**
- **SQL**
- **CTEs (Common Table Expressions)**
- **JOINs**
- **Funções de agregação**
- **Window Functions**
- **Análise temporal**
- **Análise de indicadores de negócio**
- **Power BI**
- **DAX**
- **Business Intelligence**
- **Git e GitHub**

---

## 👤 Autor

**José Rafael Santos Pereira**

Analista de Dados | Business Intelligence | Data Analytics | Power BI • SQL • Python • DAX • Data Analytics

[LinkedIn](https://www.linkedin.com/) 

[GitHub](https://github.com/ZeRafaSp)


