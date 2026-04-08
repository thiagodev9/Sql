"""
=========================================================
AULA 3: JOINS e HAVING (Executando SQL via Python)
=========================================================
Neste cenário prático, vamos utilizar a biblioteca nativa 'sqlite3' do Python.
Ela nos permite criar um "Banco de Dados Rápido" na memória RAM (que some
quando o arquivo termina de rodar).

É a oportunidade perfeita para você treinar a lógica dos JOINS e do HAVING
sem se preocupar em quebrar o PostgreSQL da sua máquina!
"""

import sqlite3

# 1. Configurando a conexão na memória RAM
conn = sqlite3.connect(':memory:')
cursor = conn.cursor()

# 2. DDL - Criando nossas tabelas
cursor.execute('''
CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nome TEXT
)
''')

cursor.execute('''
CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    valor_compra REAL,
    id_cliente INTEGER,
    FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente)
)
''')

# 3. DML - Inserindo os dados falsos (A base do problema)
# Preste atenção nos furos que criei de propósito:
# -> O Pedro (ID 3) não fez pedido nenhum.
# -> O Pedido (ID 30) tem um valor altíssimo mas id_cliente NULL (não tem dono).
cursor.executemany('INSERT INTO clientes VALUES (?, ?)', [
    (1, 'Tiago'), 
    (2, 'Maria'), 
    (3, 'Pedro')
])

cursor.executemany('INSERT INTO pedidos VALUES (?, ?, ?)', [
    (10, 250.00, 1),     # Compra do Tiago
    (20, 150.00, 1),     # Outra compra do Tiago (Tiago gastou R$ 400 total)
    (30, 900.00, None),  # Compra anônima (Erro do sistema, sem CPF amarrado)
    (40, 600.00, 2)      # Compra da Maria (Maria gastou R$ 600 total)
])

print("\n🚀 CONSTRUÇÃO DO BANCO FINALIZADA! INICIANDO CONSULTAS:\n")

# Uma funçãozinha Python só pra deixar a impressão no terminal bonitinha
def imprimir_resultado(titulo, query):
    print(f"=== {titulo} ===")
    cursor.execute(query)
    resultados = cursor.fetchall()
    for linha in resultados:
        print(linha)
    print("\n")


# ========================================================
# EXEMPLO A: INNER JOIN (A mágica da pontualidade)
# ========================================================
# O INNER JOIN cruza as linhas perfeitamente.
# * O Pedro não tem pedido, então ele some da resposta.
# * O Pedido 30 não tem dono, então a fatura também some da resposta.
query_inner = """
SELECT clientes.nome, pedidos.valor_compra 
FROM clientes
INNER JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente;
"""
imprimir_resultado("EXEMPLO A: INNER JOIN", query_inner)


# ========================================================
# EXEMPLO B: LEFT JOIN (Retenção e Descoberta de Furos)
# ========================================================
# O LEFT JOIN blinda a tabela da ESQUERDA ('clientes' no caso). 
# Ele me jura que o Pedro vai aparecer dessa vez! Como o Pedro
# não tem fatura vinculada a ele na direita, o valor virá como None (NULL).
query_left = """
SELECT clientes.nome, pedidos.valor_compra 
FROM clientes
LEFT JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente;
"""
imprimir_resultado("EXEMPLO B: LEFT JOIN", query_left)


# ========================================================
# EXEMPLO C: GROUP BY + HAVING (Cálculo com Filtro Final)
# ========================================================
# Desafio do Chefe: 
# "Quero ver a soma total do que cada cliente faturou, 
#  MAS SÓ ME MOSTRE os clientes que faturaram MAIS DE R$ 450,00".
#
# Lógica do Banco:
# O JOIN junta as tabelas -> O GROUP BY amassa o Tiago em "400" e a Maria em "600".
# Nesse momento, o HAVING desperta e corta fora quem gastou 450 ou menos (Tiago).
query_having = """
SELECT clientes.nome, SUM(pedidos.valor_compra) as total_gasto
FROM clientes
INNER JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
GROUP BY clientes.nome
HAVING SUM(pedidos.valor_compra) > 450;
"""
imprimir_resultado("EXEMPLO C: HAVING (Meta > R$ 450)", query_having)


# Finalizando e limpando a memória RAM
conn.close()

# ========================================================
# DEVER DE CASA:
# Para rodar este arquivo e ver a mágica acontecendo, 
# abra o terminal do seu bloco de notas ou VS Code e rode:
# python aula3.py
# ========================================================
