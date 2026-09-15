import pandas as pd
import csv


arquivo = "olist_order_reviews_dataset_final.csv"

linhas_problema = []

with open(arquivo, "r", encoding="utf-8-sig") as f:
    for numero_linha, linha in enumerate(f, start=1):

        # Remove a quebra de linha do final
        linha_sem_quebra = linha.rstrip("\r\n")

        # Conta as aspas na linha
        quantidade_aspas = linha_sem_quebra.count('"')

        if quantidade_aspas % 2 != 0:
            linhas_problema.append(
                (numero_linha, quantidade_aspas, linha_sem_quebra)
            )

print("Quantidade de linhas com aspas desbalanceadas:",
      len(linhas_problema))

for numero, quantidade, linha in linhas_problema[:20]:
    print("\nLinha:", numero)
    print("Quantidade de aspas:", quantidade)
    print("Conteúdo:")
    print(linha)

    print('\n')

    arquivo = "olist_order_reviews_dataset_final.csv"

df = pd.read_csv(
    arquivo,
    dtype=str
)

for coluna in ["review_comment_title", "review_comment_message"]:

    mask = df[coluna].fillna("").str.contains('"', regex=False)

    print(f"\nColuna: {coluna}")
    print("Registros com aspas dentro do texto:", mask.sum())

    if mask.sum() > 0:
        print("\nExemplos:")
        print(
            df.loc[mask, ["review_id", coluna]]
            .head(10)
            .to_string(index=False)
        )


print('\n')

arquivo = "olist_order_reviews_dataset_final.csv"

review_id_procurado = "320ae91d4c5cb8164c168fc68392a5fb"

with open(arquivo, "r", encoding="utf-8-sig") as f:
    for numero_linha, linha in enumerate(f, start=1):
        if review_id_procurado in linha:
            print("Linha:", numero_linha)
            print(linha)
            break


print('\n')




arquivo = "olist_order_reviews_dataset_final.csv"

# Ler o CSV pelo Pandas
df = pd.read_csv(arquivo, dtype="string")

# Registros que possuem aspas dentro dos textos
mask = (
    df["review_comment_title"].fillna("").str.contains('"', regex=False)
    | df["review_comment_message"].fillna("").str.contains('"', regex=False)
)

df_aspas = df.loc[mask, [
    "review_id",
    "review_comment_title",
    "review_comment_message"
]]

problemas = []

# Ler o arquivo fisicamente
with open(arquivo, "r", encoding="utf-8-sig") as f:

    linhas = f.readlines()

    for _, registro in df_aspas.iterrows():

        review_id = registro["review_id"]

        # Encontrar a linha física correspondente ao review_id
        linha_encontrada = None
        numero_linha = None

        for i, linha in enumerate(linhas, start=1):
            if review_id in linha:
                linha_encontrada = linha.rstrip("\r\n")
                numero_linha = i
                break

        if linha_encontrada is None:
            problemas.append({
                "review_id": review_id,
                "problema": "review_id não encontrado no arquivo"
            })
            continue

        # Quantidade de aspas no texto original
        aspas_titulo = registro["review_comment_title"]
        aspas_mensagem = registro["review_comment_message"]

        quantidade_aspas_texto = (
            (aspas_titulo.count('"') if pd.notna(aspas_titulo) else 0)
            +
            (aspas_mensagem.count('"') if pd.notna(aspas_mensagem) else 0)
        )

        # Para cada aspas literal do texto, o CSV deve possuir duas aspas
        quantidade_aspas_esperada = quantidade_aspas_texto * 2

        # Remover as aspas que delimitam os 7 campos.
        # Cada campo do CSV está entre aspas, portanto são 14 aspas estruturais.
        quantidade_aspas_internas = (
            linha_encontrada.count('"') - 14
        )

        if quantidade_aspas_internas != quantidade_aspas_esperada:
            problemas.append({
                "review_id": review_id,
                "linha": numero_linha,
                "aspas_no_texto": quantidade_aspas_texto,
                "aspas_internas_no_csv": quantidade_aspas_internas,
                "aspas_esperadas": quantidade_aspas_esperada,
                "linha_csv": linha_encontrada
            })

print("Registros analisados:", len(df_aspas))
print("Registros com possível problema:", len(problemas))

for problema in problemas[:20]:
    print("\n" + "=" * 100)
    print("Review ID:", problema["review_id"])
    print("Linha:", problema.get("linha"))
    print("Aspas no texto:", problema.get("aspas_no_texto"))
    print("Aspas internas no CSV:", problema.get("aspas_internas_no_csv"))
    print("Aspas esperadas:", problema.get("aspas_esperadas"))
    print("\nLinha do CSV:")
    print(problema.get("linha_csv"))