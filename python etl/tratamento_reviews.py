import pandas as pd
import csv

print(pd.__version__)

df = pd.read_csv("../dados/olist_order_reviews_dataset.csv")
df_orders = pd.read_csv("../dados/olist_orders_dataset.csv")

print(df.head())
print(df_orders.head())

print("\n Informações do dataset 1: ")
print(df.info())
print("\n Informações do dataset 2: ")
print(df_orders.info())

print("\nInformações do score: ")
print(df["review_score"].unique())

print("\n Quantidade de valores nulos: ")
print(df.isnull().sum())

print("\n Porcentagem de valores nulos: ")
print(df.isnull().mean() * 100)

print("\n Quantidade de valores nulos por score: ")
print(df["review_score"].value_counts().sort_index())

print("\n Quantidade de comentários preenchidos: ")
print(df["review_comment_message"].notnull().sum())

print("\n Porcentagem de comentários preenchidos: ")
print(df["review_comment_message"].notnull().mean() * 100)

print("\n Quantidade de linhas duplpicadas: ")
print(df.duplicated().sum())

print("\n Quantidade de review_id duplpicadas: ")
print(df["review_id"].duplicated().sum())

print("\n Quantidade de review_id unicos duplicacdos ")
print(df.loc[df["review_id"].duplicated(keep=False), "review_id"].nunique())

print("\n Exemplos de review_id duplicados: ")
print(
    df[df["review_id"].duplicated(keep=False)]
    .sort_values("review_id")
    .head(20)
)

print("\n Linha completa de um registro duplicado: ")
print(
    df[df["review_id"] == "00130cbe1f9d422698c812ed8ded1919"].T
)

print("\nQuantidade de order_id duplicados:")
print(df["order_id"].duplicated().sum())

print("\nQuantidade de order_id únicos duplicados:")
print(df.loc[df["order_id"].duplicated(keep=False), "order_id"].nunique())

print("\nQuantidade de order_id diferentes por review_id duplicado:")
print(
    df[df["review_id"].duplicated(keep=False)]
    .groupby("review_id")["order_id"]
    .nunique()
    .value_counts()
)

print("\n")
reviews_multiplos_pedidos = (
    df.groupby('review_id')['order_id']
      .nunique()
      .loc[lambda x: x > 1]
)

print(reviews_multiplos_pedidos.head(10))


print("\n Linha completa de um registro duplicado: ")
print(
df[df['review_id'] == '00130cbe1f9d422698c812ed8ded1919'].T
)

print("\n")
print(df_orders.columns)

print("\n Verificação do primeiro Id encontrado direto na tabela Order: ")
print(df_orders[
    df_orders['order_id'] == '04a28263e085d399c97ae49e0b477efa'].T)

print("\n Verificação do segundo ID encontrado direto na tabela Order: ")
print(df_orders[
    df_orders['order_id'] == 'dfcdfc43867d1c1381bfaf62d6b9c195'].T)

print('\n')
print(df[
    df['review_id'] == '00130cbe1f9d422698c812ed8ded1919'
][['review_id', 'order_id']])


print('\n')
print(df_orders[
    df_orders['order_id'].isin([
        '04a28263e085d399c97ae49e0b477efa',
        'dfcdfc43867d1c1381bfaf62d6b9c195'
    ])
][['order_id', 'customer_id']])

print("\nQuantas linhas possuem exatamente a mesma combinação review_id + order_id?")
print(df.duplicated(
    subset=['review_id', 'order_id']
).sum())

print('\nPara cada pedido, quantos review_id diferentes existem?')
print(df.groupby('order_id')['review_id'].nunique().value_counts().sort_index())


print('\n')
pedidos_multiplos_reviews = (
    df.groupby('order_id')['review_id']
    .nunique()
    .loc[lambda x: x > 1]
)

print(pedidos_multiplos_reviews.head(10))

print('\n')
print(df[
    df['order_id'] == '0035246a40f520710769010f752e7507'].T)

print('\npara cada review_id, quantos valores diferentes existem em cada campo.')
print(df.groupby('review_id').agg({
    'review_score': 'nunique',
    'review_comment_title': 'nunique',
    'review_comment_message': 'nunique',
    'review_creation_date': 'nunique',
    'review_answer_timestamp': 'nunique'
}))



reviews_multiplos_pedidos = (
    df.groupby('review_id')['order_id']
    .nunique()
)

reviews_multiplos_pedidos = reviews_multiplos_pedidos[
    reviews_multiplos_pedidos > 1
]

analise_reviews_duplicados = df[
    df['review_id'].isin(reviews_multiplos_pedidos.index)
].groupby('review_id').agg({
    'order_id': 'nunique',
    'review_score': 'nunique',
    'review_comment_title': 'nunique',
    'review_comment_message': 'nunique',
    'review_creation_date': 'nunique',
    'review_answer_timestamp': 'nunique'
})

print('\n')
print(analise_reviews_duplicados)

print('\n')
print('Total de linhas:', len(df))
print('Review_id únicos:', df['review_id'].nunique())
print('Review_id duplicados:', df['review_id'].duplicated().sum())
print('Order_id únicos:', df['order_id'].nunique())


df['review_creation_date'] = pd.to_datetime(
    df['review_creation_date']
)

df['review_answer_timestamp'] = pd.to_datetime(
    df['review_answer_timestamp']
)

print(df.info())


print('\n linha com erro no dbeaver')
linha = df[
    df['review_comment_message'].str.contains(
        'gostei muito!',
        case=False,
        na=False
    )
]

print(linha)



print('\n')
print('\n quantidade de comentários que possuem virgula em seu texto:')
linhas = df[
    df['review_comment_title'].str.contains(',', na=False) |
    df['review_comment_message'].str.contains(',', na=False)
].shape[0]

print(linhas)

print('\n')



#df_teste = pd.read_csv(
 #   'olist_order_reviews_dataset_tratado.csv')

#print(df_teste.shape)
#print(df_teste.columns)



print('Remover vírgulas dos campos de texto')
df['review_comment_title'] = (
    df['review_comment_title']
    .str.replace(',', ' ', regex=False)
)

df['review_comment_message'] = (
    df['review_comment_message']
    .str.replace(',', ' ', regex=False)
)

print('Garantir que as duas colunas sejam datetime')
df['review_creation_date'] = pd.to_datetime(
    df['review_creation_date']
)

df['review_answer_timestamp'] = pd.to_datetime(
    df['review_answer_timestamp']
)

print('Criar um novo CSV')
#df.to_csv(
#    'olist_order_reviews_dataset_tratado_v3.csv',
#    index=False,
#    sep=',',
#    quoting=csv.QUOTE_ALL
#)



df_teste = pd.read_csv(
    'olist_order_reviews_dataset_tratado_v3.csv'
)

print("Dimensões:", df_teste.shape)

print("\nTipos:")
print(df_teste.dtypes)

print("\nVírgulas nos comentários:")

print(
    df_teste['review_comment_title'].str.contains(',', na=False).sum()
    +
    df_teste['review_comment_message'].str.contains(',', na=False).sum()
)


df_df = pd.read_csv(
    "olist_order_reviews_dataset_tratado_v3.csv",
    dtype=str
)

print("Tamanho máximo de cada coluna:")
print(df_df.map(lambda x: len(str(x)) if pd.notna(x) else 0).max())


print("\n Títulos acima de 1000:",
    (df_df["review_comment_title"].fillna("").str.len() > 1000).sum()
)

print("\n Mensagens acima de 1000:",
    (df_df["review_comment_message"].fillna("").str.len() > 1000).sum()
)



# Valores nulos
print("review_id nulos:", df_df["review_id"].isna().sum())

# Valores vazios
print("review_id vazios:", (df_df["review_id"].fillna("").str.strip() == "").sum())

sem_review_id = df_df[
    df_df["review_id"].isna() |
    (df_df["review_id"].fillna("").str.strip() == "")
]

print("Quantidade de registros sem review_id:", len(sem_review_id))

print(sem_review_id.to_string())



print("Tamanho dos review_id:")

print(
    df_df["review_id"]
    .fillna("")
    .str.strip()
    .str.len()
    .value_counts()
    .sort_index()
)

print("Quantidade de colunas:", len(df_df.columns))
print("\nColunas:")
print(df_df.columns.tolist())

print("\nPrimeiros registros:")
print(df_df.head(10).to_string())

print("\nQuantidade de valores nulos por coluna:")
print(df_df.isna().sum())


print('\n')

arquivo = "olist_order_reviews_dataset_tratado_v3.csv"

with open(arquivo, "r", encoding="utf-8-sig", newline="") as f:
    leitor = csv.reader(f)

    cabecalho = next(leitor)

    problemas = []

    for numero_linha, linha in enumerate(leitor, start=2):
        if len(linha) != 7:
            problemas.append((numero_linha, len(linha), linha))

print("Quantidade de linhas com problema:", len(problemas))

for problema in problemas[:20]:
    print("\nLinha:", problema[0])
    print("Quantidade de campos:", problema[1])
    print(problema[2])