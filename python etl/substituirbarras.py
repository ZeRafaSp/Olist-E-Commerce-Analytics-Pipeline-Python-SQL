import pandas as pd

arquivo = "olist_order_reviews_dataset_final.csv"
saida = "olist_order_reviews_teste_sem_barras.csv"

df = pd.read_csv(arquivo, dtype="string")

colunas_texto = [
    "review_comment_title",
    "review_comment_message"
]

for coluna in colunas_texto:
    df[coluna] = df[coluna].str.replace("\\", "", regex=False)

df.to_csv(
    saida,
    index=False,
    encoding="utf-8-sig",
    quoting=1
)

print("Arquivo criado:", saida)
print("Dimensões:", df.shape)

quantidade_barras = (
    df["review_comment_title"].fillna("").str.contains("\\", regex=False).sum()
    +
    df["review_comment_message"].fillna("").str.contains("\\", regex=False).sum()
)

print("\nRegistros que ainda possuem barra invertida:", quantidade_barras)