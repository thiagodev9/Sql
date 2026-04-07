-- =======================================================
-- AULA 1: Nossos Primeiros Comandos em SQL
-- =======================================================

-- =======================================================
-- GUIA: ONDE E COMO RODAR ESTES CÓDIGOS?
-- =======================================================
-- Você tem duas opções principais de onde rodar esses comandos:
--
-- OPÇÃO 1: Usando o pgAdmin 4 (Programa Oficial)
-- 1. Abra o pgAdmin 4 e conecte-se ao servidor informando sua senha.
-- 2. No menu esquerdo, expanda: Servers > PostgreSQL > Databases.
-- 3. Clique com o botão direito sobre o seu banco ('postgres') e escolha "Query Tool" (Ferramenta de Consulta).
-- 4. Cole os comandos na tela branca e clique no botão de "Play" ▶️.
--
-- OPÇÃO 2: Usando o próprio VS Code (Via Extensão)
-- 1. Vá na aba de extensões do VS Code e instale uma extensão para SQL (como a "PostgreSQL" ou a famosa "SQLTools").
-- 2. Cadastre sua conexão ali do lado esquerdo passando seu usuário (postgres) e senha.
-- 3. Com o banco conectado, você pode executar as queries direto deste próprio arquivo clicando no botão "Run" que a extensão cria.
--
-- * DICA DE OURO (Válida para ambos!): Para não rodar todo o arquivo de uma vez e se perder, selecione (grife com o mouse) apenas as linhas do comando que você quer e mande executar.
-- =======================================================

-- 1. ESTRUTURAR OS DADOS: CREATE TABLE (Criar Tabela)
-- O comando CREATE TABLE é usado para criar a "planilha" onde nossos dados serão guardados.
-- Aqui estamos criando uma tabela chamada "alunos" e definindo quais informações (colunas) ela terá.
CREATE TABLE alunos (
    id SERIAL PRIMARY KEY,    -- SERIAL: O banco vai preencher esse ID automaticamente (1, 2, 3...). PRIMARY KEY: Indica que é o identificador único.
    nome VARCHAR(100),        -- VARCHAR(100): Uma coluna de texto que aceita até 100 letras/caracteres.
    idade INT                 -- INT: Indica que esta coluna aceita apenas números inteiros (Integer).
);


-- 2. ADICIONAR DADOS: INSERT INTO (Inserir em)
-- O comando INSERT INTO serve para criarmos novas "linhas" na nossa tabela recém-criada.
-- Dizemos em quais colunas vamos adicionar (nome, idade) e depois passamos os VALORES.
INSERT INTO alunos (nome, idade) 
VALUES ('João da Silva', 25);

INSERT INTO alunos (nome, idade) 
VALUES ('Maria Souza', 30);

INSERT INTO alunos (nome, idade) 
VALUES ('Carlos Eduardo', 22);

-- *Dica: Como o "id" foi definido como SERIAL, não precisamos passar ele aqui. O banco gera sozinho!


-- 3. BUSCAR DADOS: SELECT (Selecionar)
-- O SELECT é o comando mais usado. É a requisição que fazemos para ler os dados do banco.
-- O asterisco (*) é um atalho que significa "Traga TODAS as colunas".
SELECT * FROM alunos;

-- Também podemos filtrar a nossa busca usando a palavra "WHERE" (Onde).
-- Aqui dizemos: "Traga todas as colunas dos alunos ONDE a idade for maior que 24".
SELECT * FROM alunos 
WHERE idade > 24;


-- 4. ATUALIZAR DADOS EXISTENTES: UPDATE (Atualizar)
-- Usado para alterar informações que já estão lá. 
-- Sempre use o WHERE no UPDATE para não acabar atualizando a tabela inteira sem querer!
UPDATE alunos 
SET idade = 26 
WHERE nome = 'João da Silva';


-- 5. DELETAR DADOS: DELETE (Apagar)
-- Apaga registros específicos.
-- Assim como o UPDATE, o WHERE é indispensável para evitar apagar coisas erradas.
DELETE FROM alunos 
WHERE nome = 'Carlos Eduardo';