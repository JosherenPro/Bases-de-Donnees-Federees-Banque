CREATE TABLE IF NOT EXISTS dossier_credit (
    id_dossier INT AUTO_INCREMENT PRIMARY KEY,
    montant_demande DECIMAL(15,2) NOT NULL,
    montant_accorde DECIMAL(15,2),
    duree_mois INT NOT NULL,
    taux DECIMAL(5,2) NOT NULL,
    statut ENUM('en_cours', 'approuve', 'rejete', 'cloture') NOT NULL DEFAULT 'en_cours',
    icf VARCHAR(64) NOT NULL,
    id_agent INT,
    INDEX idx_icf (icf),
    INDEX idx_statut (statut)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS garantie (
    id_garantie INT AUTO_INCREMENT PRIMARY KEY,
    type_garantie VARCHAR(50) NOT NULL,
    valeur_estimee DECIMAL(15,2) NOT NULL CHECK (valeur_estimee > 0),
    id_dossier INT NOT NULL,
    FOREIGN KEY (id_dossier) REFERENCES dossier_credit(id_dossier) ON DELETE CASCADE,
    INDEX idx_dossier (id_dossier)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS echeancier (
    id_echeance INT AUTO_INCREMENT PRIMARY KEY,
    date_echeance DATE NOT NULL,
    montant_capital DECIMAL(15,2) NOT NULL,
    montant_interet DECIMAL(15,2) NOT NULL,
    statut_paiement ENUM('pending', 'paid', 'overdue') NOT NULL DEFAULT 'pending',
    id_dossier INT NOT NULL,
    FOREIGN KEY (id_dossier) REFERENCES dossier_credit(id_dossier) ON DELETE CASCADE,
    INDEX idx_dossier (id_dossier),
    INDEX idx_date_echeance (date_echeance)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS scoring (
    id_scoring INT AUTO_INCREMENT PRIMARY KEY,
    score INT NOT NULL CHECK (score BETWEEN 0 AND 100),
    niveau_risque VARCHAR(20) NOT NULL,
    date_evaluation DATE NOT NULL,
    icf VARCHAR(64) NOT NULL,
    INDEX idx_icf_date (icf, date_evaluation)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
