-- =======================================================
-- AULA 2: Atuando na Camada DQL (Data Query Language)
-- Base de Dados: Northwind
-- =======================================================

-- Como vimos, a DQL é a camada de CURIOSIDADE do banco. Ela escuta as nossas 
-- perguntas investigativas e traz as respostas na tela usando o comando SELECT. 
-- Imagine que nós somos os "Detetives dos Dados".

-- 👤 QUEM TRABALHA NESSA CAMADA? 
-- Ao contrário da DDL (focada nos DBAs e Engenheiros de Dados), a camada DQL 
-- é a "casa" dos Analistas de Dados, Cientistas de Dados e desenvolvedores de Business Intelligence (BI). 
-- Por ser uma camada exclusivamente de LEITURA, muitas empresas concedem acesso a ela até 
-- para gerentes de Produto (PMs) e times de Marketing, pois eles podem fazer seus próprios 
-- comandos SELECTs para extrair relatórios sem nenhum risco de quebrar ou apagar o banco!

-- OBS: Para testar estes códigos no seu computador, certifique-se de estar conectado
-- no banco de dados do *Northwind* que você preparou na etapa anterior!

-- =======================================================
-- 1. O SELECT BÁSICO (Olhando para o todo)
-- =======================================================
-- O asterisco (*) é a expressão para "Traz tudo logo".
-- A query abaixo diz: "Me mostre todos os registros (linhas) e informações (colunas) da tabela de clientes (customers)".
SELECT * FROM customers;


-- =======================================================
-- 2. O SELECT CIRÚRGICO (Performance e Foco)
-- =======================================================
-- No mundo real, dar "SELECT *" em uma base de milhões de linhas trava o servidor inteiro e onera custos caríssimos.
-- A regra de ouro é: "Peça só as colunas que você usar".
-- Aqui, tiramos dezenas de informações úteis e puxamos a tabela 'products' de forma cirúrgica.
SELECT product_name, unit_price, units_in_stock
FROM products;


-- =======================================================
-- 3. ALIAS: Apelidando os Retornos ("AS")
-- =======================================================
-- Trabalhar com bancos antigos ou em outros idiomas é chato quando a coluna chama "prd_id_cat_num_01".
-- Nós usamos o comando AS (Como) na DQL para MÁSCARAR a saída pros olhos do cliente, criando um "Apelido" bonitinho, 
-- sem afetar de verdade o nome na raiz do banco de dados (que requereria DDL).
SELECT 
    product_name AS "Nome do Produto do Catálogo", 
    unit_price AS "Preço em Dólar",
    units_in_stock AS "Quantidade em Estoque"
FROM products;


-- =======================================================
-- 4. ORDER BY: Organizando a Bagunça
-- =======================================================
-- O banco joga os dados nas nossas mãos de forma caótica. Mas com DQL podemos arrumar isso:
-- ASC: Ordem Natural/Crescente (A-Z ou 0-100).
-- DESC: Ordem Inversa/Decrescente (Z-A ou 100-0).

-- Exemplo: Mostrar os produtos organizados pelas letras do abecedário (ASC)
SELECT product_name, unit_price
FROM products
ORDER BY product_name ASC;

-- Exemplo: Mostrar a "Hierarquia de Preço" (Do mais luxuoso pro mais barato) usando DESC.
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC;


-- =======================================================
-- 5. LIMIT e OFFSET: Paginação Inteligente
-- =======================================================
-- Se o CEO pediu o retorno dos relatórios principais, ele não quer ler 2.000 linhas. Ele quer os "Top 5".

-- LIMIT barra a busca no milésimo de segundo que encontra o corte, poupando processamento absurdo.
-- Mostrando o relatório de luxo: Os Top 5 produtos mais CAROS da base Northwind!
SELECT product_name, unit_price 
FROM products 
ORDER BY unit_price DESC 
LIMIT 5;

-- Mas e se o usuário clicou no botão "Página 2" daquele relatório no site? 
-- Entra o mágico do OFFSET: "Pula os 5 primeiros que ele já leu lá em cima, e começa a entregar do sexto."
SELECT product_name, unit_price 
FROM products 
ORDER BY unit_price DESC 
LIMIT 5 OFFSET 5; -- (Isso forma a famosa 'Paginação' da internet)

-- =======================================================
-- 6. O COMANDO "SET" (Definir/Atribuir Valores)
-- =======================================================
-- Pode surgir a dúvida: "E onde entra o comando SET?". É importante 
-- esclarecer que o SET age fora da área de "Consulta" pura (DQL). 
-- Ele costuma aparecer em dois lugares clássicos:
--
-- CASO 1: Em par com o UPDATE (Na camada DML)
-- O SET (Defina) é a palavra-chave obrigatória para dizer QUAL será o 
-- nosso novo valor quando vamos modificar uma linha já existente.
-- Exemplo de uso (Isto é DML e não DQL!):
-- UPDATE products
-- SET unit_price = 25.50     <-- "Defina o preço igual a 25.50"
-- WHERE product_id = 1;
--
-- CASO 2: Configuração da Sessão do Cliente
-- Se usado sozinho, o comando SET serve para você mudar uma configuração 
-- local na sua "aba" do banco de dados, sem afetar o servidor inteiro.
-- Muito útil para você converter moedas, mudar idiomas ou formatar fusos horários.
--
-- Exemplo prático de DQL combinada com SET de Sessão:
-- SET timezone = 'America/Sao_Paulo'; -- Diz para o servidor te mostrar a data no formato de SP.

-- =======================================================
-- BÔNUS: O Cabeçalho de Configuração (PostgreSQL Dumps)
-- =======================================================
-- Ao pegar scripts gigantes (como o próprio script do Northwind que baixamos), 
-- você vai notar que os arquivos começam com um bloco similar a esse abaixo. 
-- Eles usam o comando SET para preparar a sessão e garantir que o computador que 
-- está injetando os dados e o servidor falem "a mesma língua":

-- SET statement_timeout = 0;             
-- Desliga o limite de tempo de uma consulta. Útil no carregamento, assim o servidor não derruba uma inserção pesada que demore mais que o habitual.

-- SET lock_timeout = 0;                  
-- Desliga o limite de tempo de tolerância para esperar caso alguma tabela que ele precise editar esteja sendo usada por outra pessoa na rede. 

-- SET client_encoding = 'UTF8';          
-- Alinha o sistema de texto! Garante que o banco aceite caracteres especiais (acentos, ç, kanjis), evitando que virem símbolos bugados, já que UTF-8 é o padrão ocidental da web.

-- SET standard_conforming_strings = on;  
-- Informa ao banco para tratar barras ("\") contidas dentro de colunas de texto como barras reais de texto, não como comandos ocultos (padrão SQL moderno).

-- SET check_function_bodies = false;     
-- Faz o banco de dados NÃO parar para ler/validar blocos de código de Funções durante a geração (o que deixaria a importação super lenta). Como é um script pronto, confiamos nele.

-- SET client_min_messages = warning;     
-- "Limpa a tela chata". Diz para o servidor não ficar avisando a cada linha importada com sucesso ("Dica" / "Log"). Manda ele imprimir na tela apenas o que for do nível "Aviso" (Warning) para cima!

-- =========================================================================
-- =========================================================================
-- PARTE II: O GUIA DEFINITIVO DOS FILTROS E FUNÇÕES DQL
-- =========================================================================
-- =========================================================================

-- =======================================================
-- 7. DISTINCT: Valores Únicos
-- =======================================================
-- Usado para não retornar valores repetidos. 
-- "Quantos países diferentes temos na nossa base?"
SELECT country FROM customers;          -- Mostra todos os países (com muitas repetições)
SELECT DISTINCT country FROM customers; -- Filtra a exibição mostrando apenas os países únicos

-- E se quisermos CONTAR quantos países únicos são?
SELECT COUNT(DISTINCT country) FROM customers;


-- =======================================================
-- 8. WHERE: A Arte de Filtrar e os Operadores Lógicos
-- =======================================================
-- O banco tem milhares de registros. O WHERE permite fatiar os dados com base em regras (AND, OR, NOT).

SELECT * FROM customers WHERE country = 'Mexico';                  -- Traz apenas do México
SELECT * FROM customers WHERE customer_id = 'ANATR';               -- Traz o cliente com esse ID específico

-- AND (As duas condições devem bater)
SELECT * FROM customers WHERE country = 'Germany' AND city = 'Berlin';

-- OR (Ao menos uma condição deve bater)
SELECT * FROM customers WHERE city = 'Berlin' OR city = 'Aachen';

-- NOT e <> (Excluem o que não queremos ver)
SELECT * FROM customers WHERE country <> 'Germany';                 -- Diferente de (também representado por !=)
SELECT * FROM customers WHERE NOT country = 'Germany';

-- MISTURANDO (Use parênteses sempre que misturar AND com OR!)
SELECT * FROM customers WHERE country = 'Germany' AND (city = 'Berlin' OR city = 'Aachen');
SELECT * FROM customers WHERE country <> 'Germany' AND country <> 'USA';


-- =======================================================
-- 9. Operadores de Comparação Matemáticos (<, >, <=, >=)
-- =======================================================
-- Ideias para colunas financeiras (preço) ou estoques numéricos.

SELECT * FROM products WHERE unit_price < 20;                      -- Menor que 20
SELECT * FROM products WHERE unit_price > 100;                     -- Maior que 100
SELECT * FROM products WHERE unit_price <= 50;                     -- Menor ou igual a 50
SELECT * FROM products WHERE units_in_stock >= 10;                 -- Estoque de no mínimo 10
SELECT * FROM products WHERE unit_price >= 50 AND unit_price < 100;-- Junta regras!


-- =======================================================
-- 10. NULL: O "Abismo" Vazio (IS NULL / IS NOT NULL)
-- =======================================================
-- NULL em SQL não é zero nem string vazia, é "Desconhecido". Logo, "X = NULL" não funciona. Tem que usar 'IS'.

SELECT * FROM customers WHERE contact_name IS NULL;     -- Traz as fichas onde faltou preencher o nome
SELECT * FROM customers WHERE contact_name IS NOT NULL; -- Traz somente os cadastros "limpos e completos"


-- =======================================================
-- 11. LIKE: O Buscador e seus Curingas (%) e (_)
-- =======================================================
-- O LIKE é a alma das barras de pesquisas de sites!
-- % representa infinitos caracteres (ou zero).  _ representa exatamente um caractere!

SELECT * FROM customers WHERE contact_name LIKE 'a%';     -- Começa com "a" (Case sensitive: apenas "a" minúsculo no Postgres)
SELECT * FROM customers WHERE contact_name LIKE '%a';     -- Termina com "a"
SELECT * FROM customers WHERE contact_name LIKE '%or%';   -- Tem "or" em qualquer lugar do nome
SELECT * FROM customers WHERE contact_name LIKE '_r%';    -- Tem "r" exatamente na SUA SEGUNDA letra da palavra
SELECT * FROM customers WHERE contact_name LIKE 'A_%_%';  -- Começa com "A" e tem ao menos 3 letras

-- TRATANDO MAIÚSCULAS/MINÚSCULAS (Case Insensitive)
-- Se você buscar por "tiago", o banco pode ignorar o "Tiago". Para resolver:
SELECT * FROM customers WHERE LOWER(contact_name) LIKE 'a%'; -- Transforma a busca toda em minúscula, então acha tanto "a" quanto "A".
SELECT * FROM customers WHERE UPPER(contact_name) LIKE 'A%'; -- Faz o mesmo, focando no maiúsculo.
-- * Dica Postgres exclusivo: O PostgreSQL é bondoso e tem o operador "ILIKE" que já faz isso sozinho!

-- OUTROS CURINGAS AVANÇADOS
SELECT * FROM customers WHERE city SIMILAR TO '(B|S|P)%'; -- [Pós-graduação do PostgreSQL!] Cidade começa com B OU S OU P.
-- Curinga no SQL Server (Ele adora usar as famosas chaves):  city LIKE '[BSP]%'


-- =======================================================
-- 12. Operador IN: A Lista "Mágica"
-- =======================================================
-- Substitui a lentidão de escrever milhares de "OR".

-- Quero os clientes que se localizem em um dos 3 países abaixo:
SELECT * FROM customers WHERE country IN ('Germany', 'France', 'UK');

-- Usando uma subquery (Dentro do limite de quem quer ir além):
-- "Quero todos os clientes que vivam em um país onde nós temos Fornecedores."
SELECT * FROM customers WHERE country IN (SELECT country FROM suppliers);


-- =======================================================
-- 13. BETWEEN: O Famoso "Entre"
-- =======================================================
-- Exemplo fácil e limpo (Inclusive):
SELECT * FROM products WHERE unit_price BETWEEN 10 AND 20;

-- Misturando BETWEEN em textos lógicos (Ordem alfabética B -> M)
SELECT * FROM products WHERE product_name BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni' ORDER BY product_name;


-- =======================================================
-- 14. [TANGENTE] COMO OUTROS SGBDS LIdAM COM DATAS
-- =======================================================
-- Cada fabricante tem sua frescura pra cuidar de datas e formatações.

-- PostgreSQL (O Nosso atual. Extremamente limpo e aceita formatação pura):
SELECT * FROM orders WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';

-- SQL Server (Gosta de ser explícito com as suas funções de transformação):
-- SELECT CONVERT(VARCHAR, order_date, 120) FROM orders ...
-- SELECT FORMAT(order_date, 'yyyy-MM-dd') FROM orders ...

-- MySQL (Tem a sua clássica função nativa para isso):
-- SELECT DATE_FORMAT(order_date, '%Y-%m-%d') FROM orders ...

-- Oracle Database (Usa as clássicas TO_CHAR e TO_DATE):
-- SELECT TO_CHAR(order_date, 'YYYY-MM-DD') FROM orders ...


-- =======================================================
-- 15. FUNÇÕES AGREGADAS E O TAL "GROUP BY"
-- =======================================================
-- Agregação pega centenas de números e reduz a apenas uma "Conclusão".
-- Detalhe: Cuidado com nulos (NULL), pois MIN, MAX, SUM e AVG os ignoram.

SELECT MIN(unit_price) AS preco_minimo FROM products;              -- O produto mais baratinho da loja
SELECT MAX(unit_price) AS preco_maximo FROM products;              -- O produto mais absurdamente caro da loja
SELECT COUNT(*) AS total_de_produtos FROM products;                -- Conta todas as linhas (Total de registros cadastrados)
SELECT AVG(unit_price) AS preco_medio FROM products;               -- Se fizermos a média dos preços... (Cuidado, bases grandes pedem indices!)
SELECT SUM(quantity) AS num_itens_vendidos FROM order_details;     -- A soma de tudo vendido até hoje!

-- Misturando Agregação com "GROUP BY" (Criando as Famosas "Tabelas Dinâmicas" do Excel via código!)
-- Qual a Categoria mais barata e a mais cara?
-- (Eles agrupam as faturas/produtos pelas suas chaves, e fazem os cálculos apenas para aquele grupo separado!)
SELECT category_id, MIN(unit_price) AS preco_minimo FROM products GROUP BY category_id;
SELECT category_id, MAX(unit_price) AS preco_maximo FROM products GROUP BY category_id;
SELECT category_id, AVG(unit_price) AS preco_medio FROM products GROUP BY category_id;
SELECT order_id, SUM(quantity) AS quantidade_comprada_por_pedido FROM order_details GROUP BY order_id;


-- =======================================================
-- 16. 🔥 DESAFIOS PRÁTICOS FINAIS!
-- =======================================================

-- DESAFIO A: Obter todas as colunas das 3 principais tabelas-matrizes.
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM suppliers;

-- DESAFIO B: Lista telefônica de clientes ordenada alfabeticamente por país e depois desempata pelo nome
SELECT * FROM customers ORDER BY country, contact_name;

-- DESAFIO C: Trazer faturas antigas! (Os "Top 5" primeiros pedidos já efetuados na vida)
SELECT * FROM orders ORDER BY order_date LIMIT 5;

-- DESAFIO D: Contagem do total de vendas realizadas inteiramente durante o ano de 1997.
SELECT COUNT(*) AS "Number of Orders During 1997"
FROM orders
WHERE order_date BETWEEN '1997-01-01' AND '1997-12-31';

-- DESAFIO E: Prospectar Gerentes (Managers) da nossa lista inteira de contatos para parcerias. Alfabeticamente.
SELECT contact_name
FROM customers
WHERE contact_title LIKE '%Manager%'
ORDER BY contact_name;

-- DESAFIO F: Checar o andamento pontual do dia exato: "19 de Maio de 1997"
SELECT * FROM orders WHERE order_date = '1997-05-19';

-- ==============================================================================
-- FIM DA AULA 2: Você acabou de varrer 90% dos conceitos vitais de consulta DQL!
-- ==============================================================================
