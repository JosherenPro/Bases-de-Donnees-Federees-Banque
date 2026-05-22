CREATE TABLE plan_comptable (
    numero_compte NVARCHAR(10) PRIMARY KEY,
    libelle NVARCHAR(100) NOT NULL,
    classe_compte INT NOT NULL CHECK (classe_compte BETWEEN 1 AND 9),
    sous_classe NVARCHAR(50)
);

CREATE TABLE ecriture_comptable (
    id_ecriture INT IDENTITY(1,1) PRIMARY KEY,
    date_ecriture DATE NOT NULL,
    libelle NVARCHAR(255) NOT NULL,
    debit DECIMAL(18,2) NOT NULL CHECK (debit >= 0),
    credit DECIMAL(18,2) NOT NULL CHECK (credit >= 0),
    numero_compte NVARCHAR(10) NOT NULL,
    journal NVARCHAR(20) NOT NULL,
    id_agence INT,
    FOREIGN KEY (numero_compte) REFERENCES plan_comptable(numero_compte)
);

CREATE TABLE bulletin_paie (
    id_bulletin INT IDENTITY(1,1) PRIMARY KEY,
    mois INT NOT NULL CHECK (mois BETWEEN 1 AND 12),
    annee INT NOT NULL,
    salaire_brut DECIMAL(18,2) NOT NULL CHECK (salaire_brut >= 0),
    net_a_payer DECIMAL(18,2) NOT NULL CHECK (net_a_payer >= 0),
    id_employe INT NOT NULL
);

CREATE TABLE operation_agence (
    id_operation INT IDENTITY(1,1) PRIMARY KEY,
    type_operation NVARCHAR(50) NOT NULL,
    montant DECIMAL(18,2) NOT NULL CHECK (montant > 0),
    devise NVARCHAR(3) NOT NULL DEFAULT 'XOF',
    date_operation DATE NOT NULL,
    id_agence INT NOT NULL,
    id_employe INT NOT NULL
);

CREATE INDEX idx_ecriture_date ON ecriture_comptable(date_ecriture);
CREATE INDEX idx_ecriture_compte_date ON ecriture_comptable(numero_compte, date_ecriture);
CREATE INDEX idx_bulletin_employe ON bulletin_paie(id_employe, annee, mois);
CREATE INDEX idx_operation_agence ON operation_agence(id_agence, date_operation);
