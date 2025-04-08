connect cergy_le_parc/cergy_le_parc;    
-- Vue combinée pour le technicien Cergy
CREATE VIEW vue_technicien_cergy AS
SELECT t.ticket_id, t.titre, t.statut, t.date_creation, m.id_materiel, m.nom_materiel
FROM Tickets t
JOIN Matériels m ON t.id_materiel = m.id_materiel
WHERE m.id_site = (SELECT id_site FROM Sites WHERE nom_site = 'Cergy');

-- Vue combinée pour le gestionnaire de stock Cergy
CREATE VIEW vue_gestionnaire_stock_cergy AS
SELECT s.stock_id, s.quantite, s.seuil_alerte, m.id_materiel, m.nom_materiel
FROM Stock s
JOIN Matériels m ON s.id_materiel = m.id_materiel
WHERE s.id_site = (SELECT id_site FROM Sites WHERE nom_site = 'Cergy');

-- Vue combinée pour le responsable de site Cergy
CREATE VIEW vue_responsable_cergy AS
SELECT 
    u.id_utilisateur, 
    u.nom, 
    u.prenom, 
    u.email, 
    m.id_materiel, 
    m.nom_materiel, 
    s.stock_id, 
    s.quantite
FROM 
    Utilisateurs u
JOIN 
    Attributions a ON u.id_utilisateur = a.id_utilisateur  -- Lier Utilisateurs et Matériels via Attributions
JOIN 
    Matériels m ON a.id_materiel = m.id_materiel           -- Lier Attributions et Matériels
JOIN 
    Stock s ON m.id_materiel = s.id_materiel                -- Lier Matériels et Stock
WHERE 
    m.id_site = (SELECT id_site FROM Sites WHERE nom_site = 'Cergy');

-- Vue Gestionnaire d'Affectation pour Cergy
CREATE VIEW vue_gestionnaire_affectation_cergy AS
SELECT
    a.id_attribution,
    a.id_utilisateur,
    a.id_materiel,
    u.nom,
    u.prenom,
    m.nom_materiel
FROM
    Attributions a
JOIN
    Utilisateurs u ON a.id_utilisateur = u.id_utilisateur
JOIN
    Matériels m ON a.id_materiel = m.id_materiel
JOIN
    Sites s ON m.id_site = s.id_site
WHERE
    s.nom_site = 'Cergy';


-- Vue Administrateur Réseau pour Cergy et PAU
CREATE VIEW vue_admin_reseau AS
SELECT
    r.id_reseau,
    r.adresse_ip,
    r.sous_reseau,
    e.log_id,
    e.type,
    e.description,
    e.date_event
FROM
    Réseaux r
JOIN
    Event_Logs e ON r.id_reseau = e.id_materiel
WHERE
    r.id_reseau IS NOT NULL;


CONNECT pau/pau;
-- Vue combinée pour le technicien Pau
CREATE VIEW vue_technicien_pau AS
SELECT t.ticket_id, t.titre, t.statut, t.date_creation, m.id_materiel, m.nom_materiel
FROM Tickets@db_cergy t
JOIN Matériels@db_cergy m ON t.id_materiel = m.id_materiel
WHERE m.id_site = (SELECT id_site FROM Sites@db_cergy WHERE nom_site = 'Pau');

-- Vue combinée pour le gestionnaire de stock Pau
CREATE VIEW vue_gestionnaire_stock_pau AS
SELECT s.stock_id, s.quantite, s.seuil_alerte, m.id_materiel, m.nom_materiel
FROM Stock@db_cergy s
JOIN Matériels@db_cergy m ON s.id_materiel = m.id_materiel
WHERE s.id_site = (SELECT id_site FROM Sites@db_cergy WHERE nom_site = 'Pau');

-- Vue combinée pour le responsable de site Pau
CREATE VIEW vue_responsable_pau AS
SELECT 
    u.id_utilisateur, 
    u.nom, 
    u.prenom, 
    u.email, 
    m.id_materiel, 
    m.nom_materiel, 
    s.stock_id, 
    s.quantite
FROM 
    Utilisateurs@db_cergy u
JOIN 
    Attributions@db_cergy a ON u.id_utilisateur = a.id_utilisateur
JOIN 
    Matériels@db_cergy m ON a.id_materiel = m.id_materiel
JOIN 
    Stock@db_cergy s ON m.id_materiel = s.id_materiel
WHERE 
    m.id_site = (SELECT id_site FROM Sites@db_cergy WHERE nom_site = 'Pau');





-- Vue Gestionnaire d'Affectation pour Pau 
CREATE VIEW vue_gestionnaire_affectation_pau AS
SELECT
    a.id_attribution,
    a.id_utilisateur,
    a.id_materiel,
    u.nom,
    u.prenom,
    m.nom_materiel
FROM
    Attributions@db_cergy a
JOIN
    Utilisateurs@db_cergy u ON a.id_utilisateur = u.id_utilisateur
JOIN
    Matériels@db_cergy m ON a.id_materiel = m.id_materiel
JOIN
    Sites@db_cergy s ON m.id_site = s.id_site
WHERE
    s.nom_site = 'Pau';
