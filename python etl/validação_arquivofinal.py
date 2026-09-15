import csv

arquivo = "olist_order_reviews_dataset_final.csv"

with open(arquivo, "r", encoding="utf-8-sig", newline="") as f:
    leitor = csv.reader(f)

    cabecalho = next(leitor)

    problemas = []

    for numero_linha, linha in enumerate(leitor, start=2):
        if len(linha) != 7:
            problemas.append((numero_linha, len(linha), linha))

print("Quantidade de linhas com problema:", len(problemas))

print("\nQuantidade de registros lidos:",
      sum(1 for _ in open(arquivo, encoding="utf-8-sig")) - 1)

print("\nCabeçalho:")
print(cabecalho)

if problemas:
    print("\nPrimeiros problemas:")
    for problema in problemas[:10]:
        print(problema)
else:
    print("\nTodas as linhas possuem exatamente 7 campos.")


