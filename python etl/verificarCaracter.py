import pandas as pd
import unicodedata

arquivo = "olist_order_reviews_dataset_final.csv"

df = pd.read_csv(arquivo, dtype="string")

meio = len(df) // 2

parte2 = df.iloc[meio:]

meio_parte2 = len(parte2) // 2

parte2A = parte2.iloc[:meio_parte2]
parte2B = parte2.iloc[meio_parte2:]


def analisar_caracteres(parte, nome):

    print("\n" + "=" * 70)
    print(nome)
    print("=" * 70)

    colunas = [
        "review_comment_title",
        "review_comment_message"
    ]

    for coluna in colunas:

        texto = parte[coluna].fillna("").astype(str)

        print(f"\n--- {coluna} ---")

        caracteres_procurados = {
            '"': 'aspas duplas',
            "'": 'aspas simples',
            "\\": 'barra invertida',
            ";": 'ponto e vírgula',
            "|": 'barra vertical',
            "\t": 'tab',
            "\r": 'carriage return',
            "\n": 'quebra de linha'
        }

        for caractere, nome_caractere in caracteres_procurados.items():

            quantidade = texto.str.contains(
                caractere,
                regex=False
            ).sum()

            print(
                f"{nome_caractere}: {quantidade}"
            )

        # Caracteres Unicode de separação
        separadores = []

        for indice, valor in parte[coluna].items():

            if pd.isna(valor):
                continue

            for caractere in str(valor):

                categoria = unicodedata.category(caractere)

                if categoria in ["Zl", "Zp", "Zs"] and caractere not in [" "]:

                    separadores.append({
                        "indice": indice,
                        "review_id": df.loc[indice, "review_id"],
                        "caractere": repr(caractere),
                        "unicode": f"U+{ord(caractere):04X}",
                        "nome": unicodedata.name(
                            caractere,
                            "SEM NOME"
                        )
                    })

        print(
            "Separadores Unicode especiais:",
            len(separadores)
        )

        for item in separadores[:10]:
            print(item)


analisar_caracteres(parte2A, "PARTE 2A")
analisar_caracteres(parte2B, "PARTE 2B")





mask = (
    df["review_comment_title"].fillna("").str.contains("\\", regex=False)
    |
    df["review_comment_message"].fillna("").str.contains("\\", regex=False)
)

registros = df.loc[
    mask,
    [
        "review_id",
        "order_id",
        "review_comment_title",
        "review_comment_message"
    ]
]

print("Quantidade de registros com barra invertida:", len(registros))

print("\nRegistros encontrados:")
print(registros.to_string(index=True))