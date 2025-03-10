-- Table des sites (référentiel pour la fragmentation)
CREATE TABLE sites (
    site_id INT PRIMARY KEY,
    nom VARCHAR(50) UNIQUE NOT NULL
);

-- Table des utilisateurs (centralisée sur Cergy Le Parc)
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role ENUM('Admin', 'Technicien', 'Utilisateur') NOT NULL,
    site_id INT NOT NULL,
    FOREIGN KEY (site_id) REFERENCES sites(site_id)
);

-- Table des équipements (fragmentation horizontale par site)
CREATE TABLE assets (
    asset_id INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    type ENUM('Ordinateur', 'Écran', 'Imprimante', 'Routeur') NOT NULL,
    etat ENUM('Actif', 'En panne', 'Remplacé') NOT NULL,
    site_id INT NOT NULL,
    FOREIGN KEY (site_id) REFERENCES sites(site_id)
);

-- Table des équipements réseau (fragmentation horizontale)
CREATE TABLE network_devices (
    device_id INT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    adresse_ip VARCHAR(15) UNIQUE NOT NULL,
    site_id INT NOT NULL,
    FOREIGN KEY (site_id) REFERENCES sites(site_id)
);

-- Table des connexions réseau (fragmentation horizontale)
CREATE TABLE network_connections (
    connection_id INT PRIMARY KEY,
    source_device_id INT NOT NULL,
    destination_device_id INT NOT NULL,
    type_connexion VARCHAR(50) NOT NULL,
    site_id INT NOT NULL,
    FOREIGN KEY (source_device_id) REFERENCES network_devices(device_id),
    FOREIGN KEY (destination_device_id) REFERENCES network_devices(device_id),
    FOREIGN KEY (site_id) REFERENCES sites(site_id)
);

-- Table des tickets (centralisée à Cergy Le Parc, vues pour chaque site)
CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    statut ENUM('Ouvert', 'En cours', 'Fermé') NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL,
    asset_id INT,
    site_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (asset_id) REFERENCES assets(asset_id),
    FOREIGN KEY (site_id) REFERENCES sites(site_id)
);

-- Table des logs (centralisée à Cergy Le Parc)
CREATE TABLE event_logs (
    log_id INT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    date_event TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    asset_id INT,
    FOREIGN KEY (asset_id) REFERENCES assets(asset_id)
);

-- Table des notifications
CREATE TABLE notifications (
    notification_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    statut ENUM('Non lu', 'Lu') DEFAULT 'Non lu',
    date_envoi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table de gestion des stocks
CREATE TABLE stock (
    stock_id INT PRIMARY KEY,
    asset_id INT NOT NULL,
    quantite INT NOT NULL CHECK (quantite >= 0),
    seuil_alerte INT NOT NULL CHECK (seuil_alerte >= 0),
    site_id INT NOT NULL,
    FOREIGN KEY (asset_id) REFERENCES assets(asset_id),
    FOREIGN KEY (site_id) REFERENCES sites(site_id)
);
