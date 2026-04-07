# Início do Aprendizado de SQL com PostgreSQL

Este repositório documenta o início dos estudos sobre SQL, utilizando o **PostgreSQL** como Sistema de Gerenciamento de Banco de Dados Relacional (SGBDR).

## O que é SQL e para que serve?

**SQL** (*Structured Query Language* ou Linguagem de Consulta Estruturada) é a linguagem padrão universal utilizada para se comunicar e interagir com bancos de dados relacionais. 

- **O que é?** É uma linguagem desenvolvida especificamente para lidar com dados. No SQL nós damos "ordens" ou fazemos "perguntas" diretamente ao banco de dados sobre o que queremos buscar ou modificar, e ele se encarrega de nos trazer a resposta.
- **Para que serve?** Serve para que possamos construir, organizar e manipular o banco de dados. Com o SQL nós podemos:
  - **Consultar (Ler):** Pesquisar, filtrar e cruzar informações ("Me mostre todos os clientes de São Paulo que compraram na última semana").
  - **Inserir (Criar):** Adicionar novas informações nas tabelas.
  - **Atualizar (Modificar):** Alterar informações que já existem (ex: mudar o preço ou o estoque de um produto).
  - **Deletar (Apagar):** Remover dados antigos ou incorretos.
  - **Estruturar o Banco:** Criar as próprias tabelas ("planilhas") onde os dados ficarão guardados, definir quais tipos de dados elas aceitam (texto, números, datas) e estabelecer como essas tabelas se conectam umas às outras.

## Arquitetura Cliente-Servidor

O banco de dados funciona sob uma arquitetura **Cliente-Servidor**:
- **Servidor (Server):** É a "maquininha" do banco de dados em si (o serviço do PostgreSQL). Ele roda silenciosamente em background no seu sistema, gerenciando os arquivos de dados na memória e no disco, executando as consultas (queries) e retornando os resultados.
- **Cliente (Client):** É a ferramenta ou aplicação que utilizamos para nos comunicar com o servidor. O cliente envia os comandos SQL para o servidor processar. No nosso caso, usaremos ferramentas gráficas e de linha de comando para fazer o papel do cliente.

## Instalação do PostgreSQL e pgAdmin

Para rodarmos o banco de dados e enviarmos comandos localmente, precisamos baixar e instalar os programas em nossa máquina.

1. **Baixar o PostgreSQL:**
   - Acesse o site oficial de downloads no link: [https://www.postgresql.org/download/](https://www.postgresql.org/download/)
   - Selecione o seu sistema operacional (como Windows, por exemplo) para ser redirecionado para os instaladores (geralmente da EnterpriseDB).
   - Baixe a versão mais recente suportada.

2. **Passo a passo básico de Instalação:**
   - Execute o instalador baixado.
   - Siga as etapas clicando em *Next* (Avançar).
   - **Atenção:** Em determinado momento, o instalador solicitará uma **senha para o superusuário (postgres)**. Crie uma senha que você vai lembrar, pois você precisará dela toda vez que for se conectar ao banco!
   - Certifique-se de que a opção para instalar o **pgAdmin 4** esteja marcada.
   - A porta padrão (5432) pode ser mantida.

## Utilizando o pgAdmin

O **pgAdmin 4** é o nosso **Cliente** gráfico oficial. Ele é uma interface visual (GUI) excelente que facilita muito a vida de quem está operando e aprendendo sobre PostgreSQL.

- **Para que serve:** Em vez de digitar os comandos em uma tela preta de terminal, interagimos com o banco através de botões, abas e um editor de texto com realce de sintaxe adequado para código SQL.
- **Acesso:** Procure por "pgAdmin 4" no menu do seu sistema após a instalação. Ao ser aberto, ele pedirá a senha (aquela que você definiu na instalação).
- A partir do pgAdmin, você conseguirá ver seus bancos de dados, escrever scripts para criar tabelas e inserir dados, e visualizar os resultados das suas pesquisas de forma organizada parecida com uma planilha.
