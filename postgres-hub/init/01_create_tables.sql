-- Table agence
CREATE TABLE IF NOT EXISTS agence (
    id_agence SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    ville VARCHAR(100) NOT NULL,
    adresse TEXT,
    code_agence VARCHAR(20) UNIQUE NOT NULL
);

-- Table employe
CREATE TABLE IF NOT EXISTS employe (
    id_employe SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    poste VARCHAR(100) NOT NULL,
    date_embauche DATE NOT NULL,
    id_agence INTEGER NOT NULL REFERENCES agence(id_agence)
);

-- Table client
CREATE TABLE IF NOT EXISTS client (
    id_client SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    date_naissance DATE NOT NULL,
    numero_piece VARCHAR(50) UNIQUE NOT NULL,
    icf VARCHAR(64) UNIQUE NOT NULL,
    telephone VARCHAR(20),
    email VARCHAR(100),
    adresse TEXT,
    id_agence INTEGER NOT NULL REFERENCES agence(id_agence)
);

-- Table compte
CREATE TABLE IF NOT EXISTS compte (
    id_compte SERIAL PRIMARY KEY,
    iban VARCHAR(34) UNIQUE NOT NULL,
    type_compte VARCHAR(20) NOT NULL CHECK (type_compte IN ('courant', 'epargne', 'terme')),
    solde NUMERIC(15,2) NOT NULL DEFAULT 0,
    date_ouverture DATE NOT NULL,
    statut VARCHAR(20) NOT NULL DEFAULT 'actif',
    id_client INTEGER NOT NULL REFERENCES client(id_client),
    id_agence INTEGER NOT NULL REFERENCES agence(id_agence),
    CONSTRAINT solde_epargne_non_negatif CHECK (
        (type_compte = 'epargne' AND solde >= 0) OR type_compte != 'epargne'
    )
);

-- Table transaction
CREATE TABLE IF NOT EXISTS transaction (
    id_transaction SERIAL PRIMARY KEY,
    type_operation VARCHAR(30) NOT NULL,
    montant NUMERIC(15,2) NOT NULL CHECK (montant > 0),
    devise VARCHAR(3) NOT NULL DEFAULT 'XOF',
    date_heure TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_compte_source INTEGER REFERENCES compte(id_compte),
    id_compte_dest INTEGER REFERENCES compte(id_compte)
);

-- Index
CREATE INDEX IF NOT EXISTS idx_client_icf ON client(icf);
CREATE INDEX IF NOT EXISTS idx_compte_iban ON compte(iban);
CREATE INDEX IF NOT EXISTS idx_compte_client ON compte(id_client);
CREATE INDEX IF NOT EXISTS idx_transaction_date ON transaction(date_heure);
CREATE INDEX IF NOT EXISTS idx_transaction_compte ON transaction(id_compte_source, id_compte_dest);
