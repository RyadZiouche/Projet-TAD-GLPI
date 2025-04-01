
--Creation Table sur le site Principal
connect CERGY_LE_PARC/CERGY_LE_PARC;


-- Table Types de Matériels
CREATE TABLE Types_de_Materiels (
    id_type_materiel INT PRIMARY KEY,
    nom_type_materiel VARCHAR2(255)
);

-- Table Sites
CREATE TABLE Sites (
    id_site INT PRIMARY KEY,
    nom_site VARCHAR2(255)
);

-- Table Réseaux
CREATE TABLE Réseaux (
    id_reseau INT PRIMARY KEY,
    adresse_ip VARCHAR2(255),
    sous_reseau VARCHAR2(255),
    id_materiel INT,
    FOREIGN KEY (id_materiel) REFERENCES Matériels(id_materiel)


);

-- Table Utilisateurs
CREATE TABLE Utilisateurs (
    id_utilisateur INT PRIMARY KEY,
    nom VARCHAR2(255),
    prenom VARCHAR2(255),
    email VARCHAR2(255)
);

-- Table Matériels
CREATE TABLE Matériels (
    id_materiel INT PRIMARY KEY,
    nom_materiel VARCHAR2(255),
    id_type_materiel INT,
    id_site INT,
    FOREIGN KEY (id_type_materiel) REFERENCES Types_de_Materiels(id_type_materiel),
    FOREIGN KEY (id_site) REFERENCES Sites(id_site),
);

-- Table Attributions
CREATE TABLE Attributions (
    id_attribution INT PRIMARY KEY,
    id_utilisateur INT,
    id_materiel INT,
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateurs(id_utilisateur),
    FOREIGN KEY (id_materiel) REFERENCES Matériels(id_materiel)
);

-- Table Tickets
CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY,
    titre VARCHAR2(255),
    description CLOB,
    statut VARCHAR2(50),
    date_creation DATE,
    id_utilisateur INT,
    id_materiel INT,
    id_site INT,
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateurs(id_utilisateur),
    FOREIGN KEY (id_materiel) REFERENCES Matériels(id_materiel),
    FOREIGN KEY (id_site) REFERENCES Sites(id_site)
);

-- Table Event Logs
CREATE TABLE Event_Logs (
    log_id INT PRIMARY KEY,
    type VARCHAR2(255),
    description CLOB,
    date_event DATE,
    id_materiel INT,
    FOREIGN KEY (id_materiel) REFERENCES Matériels(id_materiel)
);

-- Table Notifications
CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY,
    id_utilisateur INT,
    message CLOB,
    statut VARCHAR2(50),
    date_envoi DATE,
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateurs(id_utilisateur)
);

-- Table Stock
CREATE TABLE Stock (
    stock_id INT PRIMARY KEY,
    id_materiel INT,
    quantite INT,
    seuil_alerte INT,
    id_site INT,
    FOREIGN KEY (id_materiel) REFERENCES Matériels(id_materiel),
    FOREIGN KEY (id_site) REFERENCES Sites(id_site)
);
