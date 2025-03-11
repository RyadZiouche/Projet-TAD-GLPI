-- Création de la table des rôles
CREATE TABLE roles (
    id_role INT PRIMARY KEY,
    nom_role VARCHAR(50) UNIQUE NOT NULL
);

-- Création de la table des utilisateurs
CREATE TABLE utilisateurs (
    id_utilisateur INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    id_role INT NOT NULL,
    FOREIGN KEY (id_role) REFERENCES roles(id_role)
);

-- Création de la table des sites
CREATE TABLE sites (
    id_site INT PRIMARY KEY,
    nom_site VARCHAR(50) UNIQUE NOT NULL
);

-- Création de la table des types de matériels
CREATE TABLE types_materiels (
    id_type_materiel INT PRIMARY KEY,
    nom_type_materiel VARCHAR(100) UNIQUE NOT NULL
);

-- Création de la table des réseaux
CREATE TABLE reseaux (
    id_reseau INT PRIMARY KEY,
    adresse_ip VARCHAR(15) UNIQUE NOT NULL,
    sous_reseau VARCHAR(50) NOT NULL
);

-- Création de la table des matériels (fragmentation horizontale)
CREATE TABLE materiels (
    id_materiel INT PRIMARY KEY,
    nom_materiel VARCHAR(100) NOT NULL,
    id_type_materiel INT NOT NULL,
    id_site INT NOT NULL,
    id_reseau INT,
    FOREIGN KEY (id_type_materiel) REFERENCES types_materiels(id_type_materiel),
    FOREIGN KEY (id_site) REFERENCES sites(id_site),
    FOREIGN KEY (id_reseau) REFERENCES reseaux(id_reseau)
);

-- Création de la table des attributions des matériels aux utilisateurs
CREATE TABLE attributions (
    id_attribution INT PRIMARY KEY,
    id_utilisateur INT NOT NULL,
    id_materiel INT NOT NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur),
    FOREIGN KEY (id_materiel) REFERENCES materiels(id_materiel)
);

-- Création de la table des tickets (gestion des incidents IT)
CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    statut ENUM('Ouvert', 'En cours', 'Fermé') NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_utilisateur INT NOT NULL,
    id_materiel INT,
    id_site INT NOT NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur),
    FOREIGN KEY (id_materiel) REFERENCES materiels(id_materiel),
    FOREIGN KEY (id_site) REFERENCES sites(id_site)
);

-- Création de la table des logs d’événements
CREATE TABLE event_logs (
    log_id INT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    date_event TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_materiel INT,
    FOREIGN KEY (id_materiel) REFERENCES materiels(id_materiel)
);

-- Création de la table des notifications
CREATE TABLE notifications (
    notification_id INT PRIMARY KEY,
    id_utilisateur INT NOT NULL,
    message TEXT NOT NULL,
    statut ENUM('Non lu', 'Lu') DEFAULT 'Non lu',
    date_envoi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur)
);

-- Création de la table de gestion des stocks (fragmentation horizontale)
CREATE TABLE stock (
    stock_id INT PRIMARY KEY,
    id_materiel INT NOT NULL,
    quantite INT NOT NULL CHECK (quantite >= 0),
    seuil_alerte INT NOT NULL CHECK (seuil_alerte >= 0),
    id_site INT NOT NULL,
    FOREIGN KEY (id_materiel) REFERENCES materiels(id_materiel),
    FOREIGN KEY (id_site) REFERENCES sites(id_site)
);

-- 🔹 Les **données critiques** (tickets, utilisateurs, rôles, logs) sont **centralisées à Cergy Le Parc**.
-- 🔹 Les **données spécifiques à un site** (matériels, réseaux, stocks) sont **fragmentées horizontalement**.
-- 🔹 Les **vues filtrées** permettent aux sites secondaires de **consulter uniquement les données qui les concernent**.
