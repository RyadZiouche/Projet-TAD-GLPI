connect cergy_le_parc/cergy_le_parc;

-- Vue Utilisateurs Cergy
CREATE VIEW vue_utilisateurs_cergy AS
SELECT * FROM Utilisateurs
WHERE id_utilisateur IN (
    SELECT id_utilisateur
    FROM Attributions a
    JOIN Matériels m ON a.id_materiel = m.id_materiel
    WHERE m.id_site = (SELECT id_site FROM Sites WHERE nom_site = 'Cergy')
);

-- Vue Matériels Cergy
CREATE VIEW vue_materiels_cergy AS
SELECT * FROM Matériels
WHERE id_site = (SELECT id_site FROM Sites WHERE nom_site = 'Cergy');

-- Vue Attributions Cergy
CREATE VIEW vue_attributions_cergy AS
SELECT a.* FROM Attributions a
JOIN Matériels m ON a.id_materiel = m.id_materiel
WHERE m.id_site = (SELECT id_site FROM Sites WHERE nom_site = 'Cergy');

-- Vue Stock Cergy
CREATE VIEW vue_stock_cergy AS
SELECT * FROM Stock
WHERE id_site = (SELECT id_site FROM Sites WHERE nom_site = 'Cergy');

-- Vue Tickets Cergy (Technicien)
CREATE VIEW vue_tickets_cergy AS
SELECT * FROM Tickets
WHERE id_materiel IN (
    SELECT id_materiel FROM Matériels
    WHERE id_site = (SELECT id_site FROM Sites WHERE nom_site = 'Cergy')
);


connect pau/pau;
-- Vue Utilisateurs Pau
CREATE VIEW vue_utilisateurs_pau AS
SELECT * FROM Utilisateurs@db_cergy
WHERE id_utilisateur IN (
    SELECT id_utilisateur
    FROM Attributions@db_cergy a
    JOIN Matériels@db_cergy m ON a.id_materiel = m.id_materiel
    WHERE m.id_site = (SELECT id_site FROM Sites@db_cergy WHERE nom_site = 'Pau')
);

-- Vue Matériels Pau
CREATE VIEW vue_materiels_pau AS
SELECT * FROM Matériels@db_cergy
WHERE id_site = (SELECT id_site FROM Sites@db_cergy WHERE nom_site = 'Pau');

-- Vue Attributions Pau
CREATE VIEW vue_attributions_pau AS
SELECT a.* FROM Attributions@db_cergy a
JOIN Matériels@db_cergy m ON a.id_materiel = m.id_materiel
WHERE m.id_site = (SELECT id_site FROM Sites@db_cergy WHERE nom_site = 'Pau');

-- Vue Stock Pau
CREATE VIEW vue_stock_pau AS
SELECT * FROM Stock@db_cergy
WHERE id_site = (SELECT id_site FROM Sites@db_cergy WHERE nom_site = 'Pau');

-- Vue Tickets Pau (Technicien)
CREATE VIEW vue_tickets_pau AS
SELECT ticket_id, titre, statut, date_creation, id_materiel
FROM Tickets@db_cergy
WHERE id_materiel IN (
    SELECT id_materiel 
    FROM Matériels@db_cergy
    WHERE id_site = (SELECT id_site FROM Sites@db_cergy WHERE nom_site = 'Pau')
);

