# 📋 CHANGELOG — Système de Bases de Données Fédérées
**Projet :** Banque Commerciale Togo  
**Équipe :** Dev A (M4dnolyn) & Dev B (JosherenPro)  
**École :** École Polytechnique de Lomé

---

## [SYNC 1] — Phase 1 & début Phase 2
**Date :** 22/05/2026  
**Tâches complétées :** A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11

---

### ✅ Réalisé

- **A1** — Fichier `.env` configuré pour les 3 SGBD (PostgreSQL, MySQL, SQL Server)
- **A2** — `docker-compose.yml` écrit avec les 5 services et le réseau `banque_federation_net`
- **A3** — `Dockerfile` PostgreSQL custom avec extensions `mysql_fdw` et `tds_fdw`
- **A4** — `Dockerfile` MySQL configuré en `utf8mb4` / `InnoDB`
- **A5** — `Dockerfile` SQL Server configuré avec `ACCEPT_EULA=Y`
- **A6** — Schéma DDL PostgreSQL : tables `agence`, `employe`, `client`, `compte`, `transaction`
- **A7** — Schéma DDL MySQL : tables `dossier_credit`, `garantie`, `echeancier`, `scoring`
- **A8** — Schéma DDL SQL Server : tables `plan_comptable`, `ecriture_comptable`, `bulletin_paie`, `operation_agence`
- **A9** — Infrastructure validée : 3 SGBD UP et stables
- **A10** — Extensions FDW installées : `mysql_fdw 1.2` et `tds_fdw 2.0.5`
- **A11** — 8 Foreign Tables créées, fédération MySQL et SQL Server opérationnelle

---

### ⚠️ Difficultés rencontrées & Solutions

| # | Problème                                      | Cause                                                             | Solution                                          |
|---------------------------------------------------|-------------------------------------------------------------------|---------------------------------------------------|
| 1 | Conteneur `postgres-hub` redémarre en boucle  | Le préfixe `pg_` est réservé par PostgreSQL — `pg_admin` interdit | Modification du `.env` :`POSTGRES_USER=hub_admin` |
| 2 | Tables non créées après `docker-compose up`   | Les volumes persistent — les scripts `init/` ne s'exécutent qu'au **premier** démarrage | `docker-compose down -v` pour supprimer les volumes puis `up -d` |
| 3 | `\dt` ne montre aucune table                  | Connexion à la mauvaise base (`postgres` par défaut au lieu de `postgres-hub`) | Ajouter `-d postgres-hub` dans la commande `psql` |
| 4 | `mssql_server` — connexion échouée depuis PostgreSQL | `tds_fdw` nécessite `tds_version` explicitement dans les OPTIONS du serveur | `DROP SERVER mssql_server CASCADE` puis recréation avec `OPTIONS (tds_version '7.4')` |
| 5 | Base `mssql_compta` inexistante sur SQL Server | SQL Server ne crée pas automatiquement la base comme PostgreSQL/MySQL | Création manuelle via `sqlcmd` + ajout de `CREATE DATABASE` en tête du script DDL |

---

### 📁 Fichiers créés / modifiés
.env                                    ← modification POSTGRES_USER
.env.example                            ← template sans valeurs sensibles
.gitignore                              ← protection du .env
docker-compose.yml                      ← orchestrateur 5 services
postgres-hub/Dockerfile                 ← image custom avec FDW
postgres-hub/init/01_create_tables.sql  ← DDL PostgreSQL
postgres-hub/init/04_create_fdw_servers.sql   ← serveurs FDW + user mappings
postgres-hub/init/05_create_foreign_tables.sql ← 8 foreign tables
mysql-credit/Dockerfile                 ← config utf8mb4/InnoDB
mysql-credit/init/01_create_tables.sql  ← DDL MySQL
mssql-compta/Dockerfile                 ← config ACCEPT_EULA
mssql-compta/init/01_create_tables.sql  ← DDL SQL Server + CREATE DATABASE
CHANGELOG.md                            ← ce fichier


---

### 🎯 Prochain SYNC (SYNC 2)

- **A12** — Dictionnaire de correspondance (mapping tables)
- **A13 & A14** — Vues fédérées et matérialisées
- **A15, A16 & A17** — Scripts de peuplement (seeds) pour les 3 SGBD
- **A18 & A19** — Script de vérification et tests unitaires SQL