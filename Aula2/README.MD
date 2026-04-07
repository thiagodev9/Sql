# Aula 2: Subconjuntos do SQL e Camada DQL

Nesta segunda etapa da nossa jornada, vamos aprofundar nossos conhecimentos teóricos sobre as divisões da linguagem SQL e focar na área mais importante para análise de dados: a consulta.

## As Camadas (Subconjuntos) do SQL

Você sabia que o SQL não é "um bloco único de comandos"? Ele é formalmente dividido em "subconjuntos" (categorias de comandos) de acordo com a função de cada um. Os 5 subconjuntos universais são:

1. **DDL (Data Definition Language ou Linguagem de Definição de Dados):**
   Lida com a "estrutura" e o "esqueleto" do banco de dados, e não com as linhas de dados em si. 
   - *Comandos principais:* `CREATE` (Criar estrutura), `ALTER` (Alterar estrutura), `DROP` (Derrubar/Apagar estrutura).

2. **DML (Data Manipulation Language ou Linguagem de Manipulação de Dados):**
   Comandos usados para manusear as informações vivas de dentro das tabelas já estruturadas.
   - *Comandos principais:* `INSERT` (Inserir), `UPDATE` (Atualizar), `DELETE` (Deletar).

3. **DQL (Data Query Language ou Linguagem de Consulta de Dados):**
   É o cérebro das pesquisas! Totalmente focado em recuperar e vasculhar as informações valiosas salvas no banco.
   - *Comando principal:* `SELECT` (Selecionar/Buscar).

4. **DCL (Data Control Language ou Linguagem de Controle de Dados):**
   Focado na segurança. Permite que um administrador dê poderes a alguns usuários e os tire de outros.
   - *Comandos principais:* `GRANT` (Conceder acessos), `REVOKE` (Revogar acessos).

5. **TCL (Transaction Control Language ou Linguagem de Controle de Transações):**
   Salva o seu pescoço! Lida com a gravação segura de transações completas e a possibilidade de "voltar no tempo" se algo der errado (aquele conceito de "Atomicidade" visto no início).
   - *Comandos principais:* `COMMIT` (Afirmar/Salvar de vez), `ROLLBACK` (Reverter alterações antes de salvar).

---

## O Foco desta Aula: Atuação na Camada DQL

Para a **Aula 2**, nosso ambiente de trabalho será majoritariamente na **Camada DQL (Data Query Language)**!

Embora o comando principal dessa camada seja somente o `SELECT`, não se deixe enganar. Na rotina de um Desenvolvedor, Analista de Dados ou Engenheiro de Dados, você passará cerca de 80% do seu tempo de banco de dados rodando comandos DQL.

Vamos abrir "o motor" do `SELECT` na nossa base *Northwind* e descobrir seus poderes, incluindo filtros complexos, formatações e agrupamentos.

> Abra o arquivo `aula2.sql` para os comandos práticos.
