import pandas as pd
import unicodedata

arquivo = "olist_order_reviews_dataset_final.csv"

df = pd.read_csv(arquivo, dtype="string")

# Divisão que já sabemos que funciona/não funciona
meio = len(df) // 2
parte2 = df.iloc[meio:]

meio_parte2 = len(parte2) // 2

parte2A = parte2.iloc[:meio_parte2]
parte2B = parte2.iloc[meio_parte2:]


def analisar_parte(parte, nome):

    print("\n" + "=" * 70)
    print(nome)
    print("=" * 70)

    print("Registros:", len(parte))

    # -------------------------------------------------
    # 1. Caracteres não ASCII
    # -------------------------------------------------

    total_nao_ascii = 0

    for coluna in parte.columns:

        valores = parte[coluna].dropna().astype(str)

        quantidade = valores.apply(
            lambda x: any(ord(c) > 127 for c in x)
        ).sum()

        total_nao_ascii += quantidade

        print(f"{coluna} - registros com caracteres não ASCII: {quantidade}")

    # -------------------------------------------------
    # 2. Caracteres Unicode suspeitos
    # -------------------------------------------------

    suspeitos = []

    for coluna in parte.columns:

        for indice, valor in parte[coluna].dropna().items():

            for caractere in str(valor):

                categoria = unicodedata.category(caractere)

                # Separadores, símbolos de formatação e caracteres
                # potencialmente problemáticos
                if categoria in ["Cf", "Cc", "Cs", "Co"]:

                    suspeitos.append({
                        "indice": indice,
                        "review_id": df.loc[indice, "review_id"],
                        "coluna": coluna,
                        "caractere": repr(caractere),
                        "unicode": f"U+{ord(caractere):04X}",
                        "nome": unicodedata.name(
                            caractere,
                            "SEM NOME"
                        )
                    })

    print("\nCaracteres Unicode especiais encontrados:",
          len(suspeitos))

    for item in suspeitos[:10]:
        print(item)

    # -------------------------------------------------
    # 3. Tamanho máximo dos campos
    # -------------------------------------------------

    print("\nTamanho máximo dos campos:")

    for coluna in parte.columns:

        tamanho = (
            parte[coluna]
            .fillna("")
            .astype(str)
            .str.len()
            .max()
        )

        print(f"{coluna}: {tamanho}")

    # -------------------------------------------------
    # 4. Registros com vírgulas
    # -------------------------------------------------

    print("\nRegistros contendo vírgula nos campos de texto:")

    for coluna in [
        "review_comment_title",
        "review_comment_message"
    ]:

        quantidade = (
            parte[coluna]
            .fillna("")
            .str.contains(",", regex=False)
            .sum()
        )

        print(f"{coluna}: {quantidade}")

    # -------------------------------------------------
    # 5. Registros com aspas
    # -------------------------------------------------

    print("\nRegistros contendo aspas nos campos de texto:")

    for coluna in [
        "review_comment_title",
        "review_comment_message"
    ]:

        quantidade = (
            parte[coluna]
            .fillna("")
            .str.contains('"', regex=False)
            .sum()
        )

        print(f"{coluna}: {quantidade}")

    return suspeitos


suspeitos_A = analisar_parte(parte2A, "PARTE 2A")
suspeitos_B = analisar_parte(parte2B, "PARTE 2B")




print('\n 2 B')

arquivo2b = "reviews_teste_parte2B.csv"

with open(arquivo2b, "rb") as f:
    linhas = f.readlines()

print("Quantidade de linhas físicas:", len(linhas))

# Estatísticas do tamanho das linhas
tamanhos = [len(linha) for linha in linhas]

print("Menor linha:", min(tamanhos), "bytes")
print("Maior linha:", max(tamanhos), "bytes")
print("Média:", sum(tamanhos) / len(tamanhos))

# Mostrar as 20 maiores linhas
maiores = sorted(
    enumerate(tamanhos, start=1),
    key=lambda x: x[1],
    reverse=True
)

print("\n20 maiores linhas:")

for numero, tamanho in maiores[:20]:
    print(
        f"Linha {numero}: {tamanho} bytes"
    )



print('\n 2 A')

arquivo2A = "reviews_teste_parte2A.csv"

with open(arquivo2A, "rb") as f:
    linhas = f.readlines()

print("Quantidade de linhas físicas:", len(linhas))

tamanhos = [len(linha) for linha in linhas]

print("Menor linha:", min(tamanhos), "bytes")
print("Maior linha:", max(tamanhos), "bytes")
print("Média:", sum(tamanhos) / len(tamanhos))

maiores = sorted(
    enumerate(tamanhos, start=1),
    key=lambda x: x[1],
    reverse=True
)

print("\n20 maiores linhas:")

for numero, tamanho in maiores[:20]:
    print(f"Linha {numero}: {tamanho} bytes")