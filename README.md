# Jornada de Estudos em SQL

Bem-vindo ao repositório da jornada de estudos sobre Bancos de Dados e SQL! Aqui é onde documentaremos todo o aprendizado, códigos e resumos.

## Fundamentos de Arquitetura de Bancos de Dados

Antes de mergulhar de cabeça nos comandos (queries), é crucial entender a arquitetura base que suporta os bancos de dados relacionais (como o PostgreSQL, MySQL, Oracle):

### 1. O Modelo Relacional (Tabelas)
Em bancos de dados relacionais, os dados são organizados e arquitetados em formatos de grade, como planilhas estruturadas, que chamamos de **Tabelas** (ou Entidades).
- **Linhas (Registros/Tuplas):** Representam um item único gravado no banco (ex: a ficha completa de um cliente específico).
- **Colunas (Atributos):** São as propriedades ou informações que formam aquele item (ex: ID, nome, e-mail). Cada coluna tem um tipo de dado rígido (número inteiro, texto curto, data real).

### 2. Chaves e Relacionamentos
A arquitetura "Relacional" recebe esse nome justamente porque as tabelas interagem entre si, criando um ecossistema conectado, graças às "chaves":
- **Chave Primária (Primary Key - PK):** É a coluna que identifica de maneira **absolutamente única** cada registro em uma tabela. Ex: "Número da Conta Bancária". Não existe repetição e não se aceita valores vazios.
- **Chave Estrangeira (Foreign Key - FK):** É a ligação. É a coluna em uma tabela "B" que guarda a Chave Primária da tabela "A". Por exemplo: a tabela de `Vendas` tem uma coluna chamada `id_cliente` que obrigatoriamente se relaciona com a tabela de `Clientes`.

### 3. Transações e a Arquitetura ACID
O motor do banco de dados relacional é arquitetado para garantir que seus dados nunca fiquem "pela metade" e corrompidos, seguindo as propriedades **ACID**:
- **Atomicidade (Atomicity):** Tudo ou Nada. Se você tentar transferir R$500 do Pedro para a Maria, e a internet cair pela metade, o banco não tira o dinheiro do Pedro sem chegar na Maria. Ele desfaz a operação inteira.
- **Consistência (Consistency):** Os dados sempre vão obedecer às regras do jogo. Se uma coluna só aceita números inteiros, tentar salvar a palavra "Olá" falhará e protegerá seu banco.
- **Isolamento (Isolation):** Se mil pessoas tentarem comprar a última calça no estoque no mesmo milésimo de segundo, o banco as coloca em fila (isolamento). Cada transação é processada como se fosse a única no servidor naquele instante.
- **Durabilidade (Durability):** Uma vez que recebemos o "OK" de um salvamento, o dado é gravado no disco físico e nunca mais é perdido, mesmo se o servidor pegar fogo imediatamente no segundo seguinte.

### 4. Normalização dos Dados
No processo de construção dessa arquitetura, evitamos criar uma "tabelona gigante" que repete dados desnecessariamente. Se 10 clientes moram no mesmo Estado, não repetimos a palavra "São Paulo" 10 vezes; em vez disso, criamos uma tabela separada só para "Estados" e usamos *Chaves Estrangeiras*. Isso se chama **Normalização** e garante atualização rápida dos dados e pouco desperdício de armazenamento.

## Banco de Dados de Estudo: Northwind

Para as aulas de consultas avançadas, utilizaremos o famoso banco de dados **Northwind**, que simula um sistema completo de gestão de vendas e produtos (uma base amplamente usada para aprender SQL em todo o mundo).

**Como preparar o Northwind no seu computador:**
1. Acesse o repositório adaptado para PostgreSQL: [https://github.com/pthom/northwind_psql](https://github.com/pthom/northwind_psql)
2. Encontre e clique no arquivo principal do banco, geralmente chamado `northwind.sql`.
3. Na página do arquivo, clique no botão **"Raw"** (ou "Código Bruto") no canto superior direito do código. A tela vai ficar apenas com texto puro.
4. **Copie** absolutamente tudo (pressione `Ctrl + A` para selecionar tudo e `Ctrl + C` para copiar).
5. Vá no seu **pgAdmin 4** (ou na sua ferramenta de query preferida), abra uma tela em branco, **cole** o conteúdo completo e clique no botão de **Play/Executar**.

Isso criará uma série de tabelas já populadas com centenas de registros de Clientes, Funcionários, Produtos e Pedidos para podermos treinar de verdade!

---

> Dica: Comece pela pasta `Aula1` para os primeiros passos de estruturação de tabelas e leitura de registros.
