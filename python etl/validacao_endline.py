import csv

arquivo = "olist_order_reviews_dataset_final.csv"

try:
    with open(arquivo, "r", encoding="utf-8-sig", newline="") as f:
        leitor = csv.reader(
            f,
            delimiter=",",
            quotechar='"',
            doublequote=True,
            strict=True
        )

        next(leitor)

        for numero_linha, linha in enumerate(leitor, start=2):
            pass

    print("CSV válido no modo strict.")
    print("Todas as linhas foram lidas corretamente.")

except csv.Error as e:
    print("ERRO NO CSV")
    print("Linha:", numero_linha)
    print("Erro:", e)


    print('\n')


    arquivo = "olist_order_reviews_dataset_final.csv"

with open(arquivo, "rb") as f:
    dados = f.read()

print("Últimos 100 bytes do arquivo:")
print(dados[-100:])

print("\nArquivo termina com quebra de linha:")
print(dados.endswith(b"\n"))