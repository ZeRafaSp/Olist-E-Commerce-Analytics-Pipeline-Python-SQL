import pandas as pd
import unicodedata

arquivo = "olist_order_reviews_dataset_final.csv"

df = pd.read_csv(arquivo, dtype="string")

# Mesmas divisões que fizemos anteriormente
meio = len(df) // 2

parte2 = df.iloc[meio:]

meio_parte2 = len(parte2) // 2

parte2A = parte2.iloc[:meio_parte2]
parte2B = parte2.iloc[meio_parte2:]

colunas_texto = [
    "review_id",
    "order_id",
    "review_comment_title",
    "review_comment_message"
]


def analisar_caracteres(df_parte, nome_parte):

    problemas = []

    for coluna in colunas_texto:

        for indice, valor in df_parte[coluna].items():

            if pd.isna(valor):
                continue

            caracteres = []

            for caractere in valor:

                categoria = unicodedata.category(caractere)

                if categoria.startswith("C"):
                    caracteres.append(
                        f"{repr(caractere)} "
                        f"({unicodedata.name(caractere, 'SEM NOME')})"
                    )

            if caracteres:
                problemas.append({
                    "parte": nome_parte,
                    "indice": indice,
                    "review_id": df.loc[indice, "review_id"],
                    "coluna": coluna,
                    "caracteres": caracteres,
                    "valor": valor
                })

    return problemas


problemas_A = analisar_caracteres(parte2A, "Parte 2A")
problemas_B = analisar_caracteres(parte2B, "Parte 2B")


print("=" * 70)
print("RESULTADO")
print("=" * 70)

print("Parte 2A:")
print("Registros com caracteres de controle:", len(problemas_A))

print("\nParte 2B:")
print("Registros com caracteres de controle:", len(problemas_B))


if problemas_A:
    print("\n--- Exemplos Parte 2A ---")

    for problema in problemas_A[:10]:
        print("\nÍndice:", problema["indice"])
        print("Review ID:", problema["review_id"])
        print("Coluna:", problema["coluna"])
        print("Caracteres:", problema["caracteres"])


if problemas_B:
    print("\n--- Exemplos Parte 2B ---")

    for problema in problemas_B[:10]:
        print("\nÍndice:", problema["indice"])
        print("Review ID:", problema["review_id"])
        print("Coluna:", problema["coluna"])
        print("Caracteres:", problema["caracteres"])