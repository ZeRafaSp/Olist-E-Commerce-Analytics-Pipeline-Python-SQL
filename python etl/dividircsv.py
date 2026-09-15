import pandas as pd

arquivo = "reviews_teste_parte2.csv"

df = pd.read_csv(arquivo, dtype="string")

meio = len(df) // 2

df.iloc[:meio].to_csv(
    "reviews_teste_parte2A.csv",
    index=False,
    encoding="utf-8-sig",
    quoting=1
)

df.iloc[meio:].to_csv(
    "reviews_teste_parte2B.csv",
    index=False,
    encoding="utf-8-sig",
    quoting=1
)

print("Total de registros:", len(df))
print("Parte 2A:", len(df.iloc[:meio]))
print("Parte 2B:", len(df.iloc[meio:]))