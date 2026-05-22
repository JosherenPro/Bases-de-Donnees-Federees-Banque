-- =============================================================================
-- FOREIGN TABLES — Système de Bases de Données Fédérées
-- Hub : PostgreSQL 16 | Sources : MySQL (mysql-credit) + SQL Server (mssql-compta)
-- =============================================================================

-- -----------------------------------------------------------------------------
--  FOREIGN TABLES — Source MySQL (mysql-credit)
-- -----------------------------------------------------------------------------

CREATE FOREIGN TABLE mysql_dossier_credit (
    id_dossier      INT,
    montant_demande NUMERIC(15,2),
    montant_accorde NUMERIC(15,2),
    duree_mois      INT,
    taux            NUMERIC(5,2),
    statut          VARCHAR(20),
    icf             VARCHAR(64),
    id_agent        INT
)
SERVER mysql_server
OPTIONS (dbname 'mysql_credit', table_name 'dossier_credit');

-- -----------------------------------------------------------------------------

CREATE FOREIGN TABLE mysql_garantie (
    id_garantie    INT,
    type_garantie  VARCHAR(50),
    valeur_estimee NUMERIC(15,2),
    id_dossier     INT
)
SERVER mysql_server
OPTIONS (dbname 'mysql_credit', table_name 'garantie');

-- -----------------------------------------------------------------------------

CREATE FOREIGN TABLE mysql_echeancier (
    id_echeance      INT,
    date_echeance    DATE,
    montant_capital  NUMERIC(15,2),
    montant_interet  NUMERIC(15,2),
    statut_paiement  VARCHAR(20),
    id_dossier       INT
)
SERVER mysql_server
OPTIONS (dbname 'mysql_credit', table_name 'echeancier');

-- -----------------------------------------------------------------------------

CREATE FOREIGN TABLE mysql_scoring (
    id_scoring      INT,
    score           INT,
    niveau_risque   VARCHAR(20),
    date_evaluation DATE,
    icf             VARCHAR(64)
)
SERVER mysql_server
OPTIONS (dbname 'mysql_credit', table_name 'scoring');


-- -----------------------------------------------------------------------------
--  FOREIGN TABLES — Source SQL Server (mssql-compta)
-- -----------------------------------------------------------------------------

CREATE FOREIGN TABLE mssql_plan_comptable (
    numero_compte VARCHAR(10),
    libelle       VARCHAR(100),
    classe_compte INT,
    sous_classe   VARCHAR(50)
)
SERVER mssql_server
OPTIONS (table_name 'plan_comptable');

-- -----------------------------------------------------------------------------

CREATE FOREIGN TABLE mssql_ecriture_comptable (
    id_ecriture   INT,
    date_ecriture DATE,
    libelle       VARCHAR(255),
    debit         NUMERIC(18,2),
    credit        NUMERIC(18,2),
    numero_compte VARCHAR(10),
    journal       VARCHAR(20),
    id_agence     INT
)
SERVER mssql_server
OPTIONS (table_name 'ecriture_comptable');

-- -----------------------------------------------------------------------------

CREATE FOREIGN TABLE mssql_bulletin_paie (
    id_bulletin  INT,
    mois         INT,
    annee        INT,
    salaire_brut NUMERIC(18,2),
    net_a_payer  NUMERIC(18,2),
    id_employe   INT
)
SERVER mssql_server
OPTIONS (table_name 'bulletin_paie');

-- -----------------------------------------------------------------------------

CREATE FOREIGN TABLE mssql_operation_agence (
    id_operation   INT,
    type_operation VARCHAR(50),
    montant        NUMERIC(18,2),
    devise         VARCHAR(3),
    date_operation DATE,
    id_agence      INT,
    id_employe     INT
)
SERVER mssql_server
OPTIONS (table_name 'operation_agence');