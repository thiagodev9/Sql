# Aula 3: A Mágica dos Relacionamentos (JOINS)

Até agora, nós nos tornamos especialistas em fazer perguntas focadas em uma **única tabela** (como analisar apenas os produtos, ou apenas os clientes).

Porém, lembre-se da nossa primeira aula teórica: em bases **Relacionais** (como o PostgreSQL), as informações são divididas em várias tabelas para evitar repetição (a tal da Normalização). 

Mas e na hora de montar aquele relatório para o chefe que pede o *"Nome do funcionário que fez a venda"*, e o *"Nome do cliente que comprou"* na mesma planilha? Um dado está na tabela `employees`, e o outro na tabela `customers`. A tabela central `orders` só tem números chatos de IDs.

É aí que nós invocamos o poder dos **JOINS**!

## O que é um JOIN?

Um **JOIN** (Unir / Juntar) é uma cláusula fundamental em linguagens SQL que serve para **costurar** os dados de duas ou mais tabelas. Ele faz isso buscando a "ponte" entre elas (que geralmente é o vínculo de uma Chave Primária com uma Chave Estrangeira).

Para entender os JOINS facilmente, os analistas sempre imaginam os círculos interligados em conjuntos matemáticos (Diagramas de Venn). Os principais JOINS do mercado são:

### 1. INNER JOIN (A Intersecção Exata)
É o rei dos Joins, o que você mais vai usar na vida. Ele retorna **APENAS** as linhas que existem nas **duas** pontas da união. Ele "limpa" o que não tem par.
- *Exemplo visual:* "Traga os registros unindo Clientes e Pedidos. Porém, se um Cliente nunca fez um pedido, oculte ele. E se houver algum Pedido sem um Cliente registrado, oculte também."

### 2. LEFT JOIN (Privilégio do lado Esquerdo)
Ele garante que **TODOS** os registros da tabela "mãe" (a tabela da esquerda, que você declarou no comando `FROM`) apareçam no resultado final! Se o registro encontrar um parceiro na tabela da direita, ótimo! Se não encontrar correspondência, ele aparece mesmo assim, e os dados faltantes do outro lado vêm em branco (`NULL`).
- *Exemplo:* "A tabela da Esquerda é Clientes. Traga TODOS os clientes! Se o Tiago já comprou algo, me mostre as compras dele da tabela da direita. Se o Tiago é novato e tem zero compras, mostre a ficha dele mesmo assim e preencha as colunas de compras com NULL."
- *Utilidade:* Extremamente utilizado para achar "furos" comerciais (ex: "Me liste todos os clientes cujo o histórico de compra e data vierem como NULL, pois eu quero ligar para eles e oferecer um brinde").

### 3. RIGHT JOIN (Privilégio do lado Direito)
É a exata mesma coisa que o *Left Join*, só muda a direção (Traz TODOS do lado direito, preenchendo os faltantes da esquerda com NULL).
- *Dica de Ouro:* Você raramente vai ver isso. Os Desenvolvedores e Engenheiros têm o costume natural de ler o código de cima pra baixo e da esquerda pra direita. Então, é muito mais legível apenas inverter as tabelas de lugar e usar um `LEFT JOIN`.

### 4. FULL OUTER JOIN (O Abraço Completo)
Traz absolutamente todos os registros de ambas as tabelas (esquerda e direita). Os dados que têm pares se juntam, e os órfãos das duas tabelas se mantêm na tela recebendo valores nulos (NULL) em seus espaços de cruzamento vazios.
- *Utilidade:* Usado em processos pesados de auditoria corporativa e higienização de banco para mapear a bagunça geral de chaves soltas e perdidas.

## Onde entra o HAVING nessa história?

Ao combinarmos tabelas gigantes usando `JOINS`, entraremos pesado no ramo da Inteligência de Dados, cruzando informações e criando métricas agrupadas com o `GROUP BY` (Ex: *"Junte as duas tabelas e me dê a Soma de Pedidos por Cliente"*).

A grande confusão no mercado ocorre quando o chefe pede uma condição em cima dessa matemática: *"Me liste **apenas** os clientes cuja Soma de Pedidos seja MAIOR que 5 mil dólares"*.

Se você tentar barrar isso com um `WHERE`, o banco vai dar **ERRO FATAL**. Por quê?
Porque o `WHERE` filtra as linhas soltas **antes** da matemática dos agrupamentos acontecer. Ele não consegue enxergar a soma.

Para resolver, nós invocamos a cláusula **HAVING** ("Tendo"):
O **HAVING** é o "WHERE dos Agrupamentos". Ele tem o trabalho exclusivo de aplicar um filtro **depois** que o banco de dados efetuou os cálculos do `GROUP BY`.

### A Ordem Universal do SQL
Para dominar de vez, memorize a ordem de como o banco lê a sua consulta:
1. **`FROM` e `JOIN`:** O banco amarra as tabelas e levanta a massa de dados bruta.
2. **`WHERE`:** O banco corta as linhas sujas que você não quer analisar.
3. **`GROUP BY`:** A matemática amassa quem sobrou formando os grupos (tabela dinâmica).
4. **`HAVING`:** O banco corta fora os grupos que não atingiram a meta matemática estabelecida.
5. **`SELECT`:** O banco finalmente joga as colunas sobreviventes na sua placa de vídeo (tela).
6. **`ORDER BY`:** Arruma os dados alfabeticamente ou numericamente.
7. **`LIMIT`:** Imprime até bater no número máximo que você pediu.

---

Agora que dominamos a base de como as tabelas dão as mãos e como o banco processa seus filtros até o fim, iremos praticar escrevendo queries cruzadas na base da loja *Northwind*!
