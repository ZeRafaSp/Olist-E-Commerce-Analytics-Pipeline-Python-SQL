import pandas as pd

teste = pd.DataFrame({
    "review_id": [
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
        "cccccccccccccccccccccccccccccccc"
    ],
    "order_id": [
        "11111111111111111111111111111111",
        "22222222222222222222222222222222",
        "33333333333333333333333333333333"
    ],
    "review_score": [5, 1, 4],
    "review_comment_title": [
        "Excelente",
        "Problema",
        "Muito bom"
    ],
    "review_comment_message": [
        "Produto chegou rápido.",
        "Produto com defeito.",
        "Gostei muito da compra."
    ],
    "review_creation_date": [
        "2018-01-01 00:00:00",
        "2018-01-02 00:00:00",
        "2018-01-03 00:00:00"
    ],
    "review_answer_timestamp": [
        "2018-01-02 10:00:00",
        "2018-01-03 11:00:00",
        "2018-01-04 12:00:00"
    ]
})

teste.to_csv(
    "teste_dbeaver.csv",
    index=False,
    encoding="utf-8-sig",
    quoting=1
)

print("Arquivo teste_dbeaver.csv criado.")