# Banco de dados — Jogo de RPG online

Script SQL (SQL Server / T-SQL) que cria o banco `RPG_Online` e as tabelas do diagrama do projeto:

| Tabela | Chave primária | Chaves estrangeiras |
|---|---|---|
| USUARIOS | UsuarioId | — |
| CLASSES | ClasseId | — |
| HABILIDADES | HabilidadeId | — |
| PERSONAGENS | PersonagemId | UsuarioId → USUARIOS, ClasseId → CLASSES |
| CLASSES_HABILIDADES | (ClasseId, HabilidadeId) | ClasseId → CLASSES, HabilidadeId → HABILIDADES |

Relacionamentos: USUARIOS 1:N PERSONAGENS, CLASSES 1:N PERSONAGENS e CLASSES N:N HABILIDADES
(resolvido pela tabela associativa CLASSES_HABILIDADES).

## Como executar

Abra [`rpg_online.sql`](rpg_online.sql) no SQL Server Management Studio (SSMS), conectado ao servidor,
e execute (F5).
