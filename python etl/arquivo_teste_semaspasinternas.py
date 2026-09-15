import pandas as pd

arquivo = "olist_order_reviews_dataset_final.csv"
saida = "olist_order_reviews_teste_sem_aspas_internas.csv"

df = pd.read_csv(arquivo, dtype="string")

# Remove apenas aspas que fazem parte do conteúdo dos textos
for coluna in ["review_comment_title", "review_comment_message"]:
    df[coluna] = df[coluna].str.replace('"', '', regex=False)

df.to_csv(
    saida,
    index=False,
    encoding="utf-8-sig",
    quoting=1
)

print("Arquivo de teste criado:", saida)
print("Dimensões:", df.shape)