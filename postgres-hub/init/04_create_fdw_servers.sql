-- =============================================================================
-- DÉCLARATION DES SERVEURS FDW
-- =============================================================================

-- -----------------------------------------------------------------------------
--  Serveur distant MySQL (mysql-credit)
-- -----------------------------------------------------------------------------
CREATE SERVER mysql_server
    FOREIGN DATA WRAPPER mysql_fdw
    OPTIONS (host 'mysql-credit', port '3306');

CREATE USER MAPPING FOR hub_admin
    SERVER mysql_server
    OPTIONS (username 'mysql_admin', password 'MysqlCred@Togo2026#');

-- -----------------------------------------------------------------------------
--  Serveur distant SQL Server (mssql-compta)
-- -----------------------------------------------------------------------------
CREATE SERVER mssql_server
    FOREIGN DATA WRAPPER tds_fdw
    OPTIONS (
        servername 'mssql-compta',
        port '1433',
        database 'mssql_compta',
        tds_version '7.4'
    );
    
CREATE USER MAPPING FOR hub_admin
    SERVER mssql_server
    OPTIONS (username 'sa', password 'MssqlCompta@Togo2026#');