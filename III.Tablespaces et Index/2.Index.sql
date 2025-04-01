-- 1. Index sur la colonne 'email' de la table Utilisateurs
CREATE INDEX idx_utilisateurs_email ON Utilisateurs(email);

-- 2. Index sur la colonne 'id_materiel' dans la table Tickets
CREATE INDEX idx_tickets_materiel ON Tickets(id_materiel);

-- 3. Index composite sur 'id_utilisateur' et 'id_materiel' dans la table Attributions
CREATE INDEX idx_attributions_user_materiel ON Attributions(id_utilisateur, id_materiel);

-- 4. Index sur la colonne 'id_site' dans la table Matériels
CREATE INDEX idx_materiels_site ON Matériels(id_site);

-- 5. Index sur la colonne 'id_site' dans la table Stock
CREATE INDEX idx_stock_site ON Stock(id_site);

