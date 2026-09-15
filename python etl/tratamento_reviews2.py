import pandas as pd
import csv

arquivo_entrada = "olist_order_reviews_dataset_tratado_v3.csv"
arquivo_saida = "olist_order_reviews_dataset_final.csv"


df = pd.read_csv(
    arquivo_entrada,
    dtype={
        "review_id": "string",
        "order_id": "string",
        "review_score": "Int64",
        "review_comment_title": "string",
        "review_comment_message": "string"}
)

print('\n Remover quebras de linha dos campos de texto')
df["review_comment_title"] = (
    df["review_comment_title"]
    .str.replace("\r", " ", regex=False)
    .str.replace("\n", " ", regex=False)
)

df["review_comment_message"] = (
    df["review_comment_message"]
    .str.replace("\r", " ", regex=False)
    .str.replace("\n", " ", regex=False)
)

print('\n Remover espaços duplicados que podem ter surgido')
df["review_comment_title"] = (
    df["review_comment_title"]
    .str.replace(r"\s+", " ", regex=True)
    .str.strip()
)

df["review_comment_message"] = (
    df["review_comment_message"]
    .str.replace(r"\s+", " ", regex=True)
    .str.strip()
)

# Salvar novo CSV
df.to_csv(
    arquivo_saida,
    index=False,
    encoding="utf-8-sig",
    quoting=1
)

print("Arquivo criado com sucesso:")
print(arquivo_saida)

print("\nDimensões:")
print(df.shape)

print("\nQuantidade de colunas:")
print(len(df.columns))

print("\nColunas:")
print(df.columns.tolist())

print("\nQuebras de linha nos comentários:")
print(
    "Título:",
    df["review_comment_title"].str.contains(r"[\r\n]", regex=True, na=False).sum()
)

print(
    "Mensagem:",
    df["review_comment_message"].str.contains(r"[\r\n]", regex=True, na=False).sum()
)