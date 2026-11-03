/* =====================================================================
   Banco de dados do jogo de RPG online
   SGBD: Microsoft SQL Server (T-SQL)
   Script de definição de dados (DDL) baseado no diagrama "diagrama_jogo_RPG"

   Relacionamentos do diagrama:
     - USUARIOS 1:N PERSONAGENS
     - CLASSES  1:N PERSONAGENS
     - CLASSES  N:N HABILIDADES (resolvido pela tabela CLASSES_HABILIDADES)
   ===================================================================== */

-- 1. Verificar o banco de dados selecionado no momento
SELECT DB_NAME() AS BancoAtual;
GO

-- 2. Criar o banco de dados do projeto (se ainda não existir) e selecioná-lo
IF DB_ID('RPG_Online') IS NULL
    CREATE DATABASE RPG_Online;
GO

USE RPG_Online;
GO

SELECT DB_NAME() AS BancoAtual;
GO

-- Permite executar o script novamente: remove as tabelas na ordem inversa das dependências
DROP TABLE IF EXISTS CLASSES_HABILIDADES;
DROP TABLE IF EXISTS PERSONAGENS;
DROP TABLE IF EXISTS HABILIDADES;
DROP TABLE IF EXISTS CLASSES;
DROP TABLE IF EXISTS USUARIOS;
GO

-- 3. Criação das tabelas

-- Contas dos jogadores
CREATE TABLE USUARIOS (
    UsuarioId  INT IDENTITY(1,1) NOT NULL,
    Email      VARCHAR(100)      NOT NULL,
    Senha      VARCHAR(255)      NOT NULL,
    CONSTRAINT PK_USUARIOS PRIMARY KEY (UsuarioId),
    CONSTRAINT UQ_USUARIOS_Email UNIQUE (Email)
);
GO

-- Classes disponíveis no jogo (ex.: Guerreiro, Mago, Arqueiro)
CREATE TABLE CLASSES (
    ClasseId   INT IDENTITY(1,1) NOT NULL,
    Nome       VARCHAR(50)       NOT NULL,
    Descricao  VARCHAR(255)      NULL,
    CONSTRAINT PK_CLASSES PRIMARY KEY (ClasseId),
    CONSTRAINT UQ_CLASSES_Nome UNIQUE (Nome)
);
GO

-- Habilidades que podem ser associadas às classes
CREATE TABLE HABILIDADES (
    HabilidadeId INT IDENTITY(1,1) NOT NULL,
    Nome         VARCHAR(50)       NOT NULL,
    CONSTRAINT PK_HABILIDADES PRIMARY KEY (HabilidadeId),
    CONSTRAINT UQ_HABILIDADES_Nome UNIQUE (Nome)
);
GO

-- Personagens: cada um pertence a um usuário (1:N) e a uma classe (1:N)
CREATE TABLE PERSONAGENS (
    PersonagemId    INT IDENTITY(1,1) NOT NULL,
    NomePersonagem  VARCHAR(50)       NOT NULL,
    UsuarioId       INT               NOT NULL,
    ClasseId        INT               NOT NULL,
    CONSTRAINT PK_PERSONAGENS PRIMARY KEY (PersonagemId),
    CONSTRAINT FK_PERSONAGENS_USUARIOS FOREIGN KEY (UsuarioId)
        REFERENCES USUARIOS (UsuarioId),
    CONSTRAINT FK_PERSONAGENS_CLASSES FOREIGN KEY (ClasseId)
        REFERENCES CLASSES (ClasseId)
);
GO

-- Tabela associativa que resolve o N:N entre CLASSES e HABILIDADES
-- A chave primária é composta pelas duas chaves estrangeiras
CREATE TABLE CLASSES_HABILIDADES (
    ClasseId      INT NOT NULL,
    HabilidadeId  INT NOT NULL,
    CONSTRAINT PK_CLASSES_HABILIDADES PRIMARY KEY (ClasseId, HabilidadeId),
    CONSTRAINT FK_CLASSES_HABILIDADES_CLASSES FOREIGN KEY (ClasseId)
        REFERENCES CLASSES (ClasseId),
    CONSTRAINT FK_CLASSES_HABILIDADES_HABILIDADES FOREIGN KEY (HabilidadeId)
        REFERENCES HABILIDADES (HabilidadeId)
);
GO

-- 4. Conferência: tabelas, colunas e chaves criadas
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY TABLE_NAME, ORDINAL_POSITION;

SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
ORDER BY TABLE_NAME, CONSTRAINT_TYPE;
GO
