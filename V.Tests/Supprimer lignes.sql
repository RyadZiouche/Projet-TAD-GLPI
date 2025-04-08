
-- supprimer les lignes 
    DELETE FROM Stock;
    DELETE FROM Event_Logs;
    
    DELETE FROM Notifications;
    DELETE FROM Attributions;
    DELETE FROM Tickets;
    DELETE FROM Réseaux;
    DELETE FROM Matériels;
    DELETE FROM Sites;
    Delete From Types_de_Materiels;
    DELETE FROM Notifications;
    DELETE FROM Utilisateurs;


-- Réinitialiser la séquence pour la table Types_de_Materiels
ALTER SEQUENCE Types_de_Materiels_seq RESTART START WITH 1;

-- Réinitialiser la séquence pour la table Sites
ALTER SEQUENCE Sites_seq RESTART START WITH 1;

-- Réinitialiser la séquence pour la table Matériels
ALTER SEQUENCE Materiels_seq RESTART START WITH 1;

-- Réinitialiser la séquence pour la table Utilisateurs
ALTER SEQUENCE Utilisateurs_seq RESTART START WITH 1;

-- Réinitialiser la séquence pour la table Stock
ALTER SEQUENCE Stock_seq RESTART START WITH 1;

-- Réinitialiser la séquence pour la table Attributions
ALTER SEQUENCE Attributions_seq RESTART START WITH 1;

-- Réinitialiser la séquence pour la table Réseaux
ALTER SEQUENCE Réseaux_seq RESTART START WITH 1;

-- Réinitialiser la séquence pour la table Tickets
ALTER SEQUENCE Tickets_seq RESTART START WITH 1;

-- Réinitialiser la séquence pour la table Event_Logs
ALTER SEQUENCE Event_Logs_seq RESTART START WITH 1;

-- Réinitialiser la séquence pour la table Notifications
ALTER SEQUENCE Notifications_seq RESTART START WITH 1;


--Ajouter lignes 
-- Insertion des Utilisateurs  400 utilisateurs)
DECLARE
    i INT;
BEGIN
    FOR i IN 1..400 LOOP
        INSERT INTO Utilisateurs (id_utilisateur, nom, prenom, email) 
        VALUES (utilisateurs_seq.NEXTVAL, 'Nom' || i, 'Prenom' || i, 'email' || i || '@example.com');
    END LOOP;
END;
/

-- Insertion des Types de Matériels (40 types)
DECLARE
    i INT;
BEGIN
    FOR i IN 1..40 LOOP
        INSERT INTO Types_de_Materiels (id_type_materiel, nom_type_materiel) 
        VALUES (types_de_materiels_seq.NEXTVAL, 'Type' || i);
    END LOOP;
END;
/

-- Insertion des Sites (seulement 2 sites)
DECLARE
    i INT;
BEGIN
    FOR i IN 1..2 LOOP
        INSERT INTO Sites (id_site, nom_site) 
        VALUES (sites_seq.NEXTVAL, CASE WHEN i = 1 THEN 'Cergy' ELSE 'Pau' END);
    END LOOP;
END;
/

-- Insertion des Matériels (100 matériels)
DECLARE
    i INT;
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Matériels (id_materiel, nom_materiel, id_type_materiel, id_site) 
        VALUES (materiels_seq.NEXTVAL, 'Materiel ' || i, MOD(i, 40) + 1, MOD(i, 2) + 1);
    END LOOP;
END;
/

-- Insertion des Stocks (100 stocks)
DECLARE
    i INT;
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Stock (stock_id, id_materiel, quantite, seuil_alerte, id_site) 
        VALUES (stock_seq.NEXTVAL, i, 10, 2, MOD(i, 2) + 1);
    END LOOP;
END;
/

-- Insertion des Tickets (600 tickets)
DECLARE
    i INT;
BEGIN
    FOR i IN 1..600 LOOP
        INSERT INTO Tickets (ticket_id, titre, description, statut, date_creation, id_utilisateur, id_materiel, id_site)
        VALUES (tickets_seq.NEXTVAL, 'Probleme sur materiel ' || i, 'Description du probleme pour le materiel ' || i, 
                CASE WHEN MOD(i, 2) = 0 THEN 'Ferme' ELSE 'Ouvert' END, SYSDATE, MOD(i, 400) + 1, MOD(i, 100) + 1, MOD(i, 2) + 1);
    END LOOP;
END;
/

-- Insertion des Connexions Réseau (200 connexions)
DECLARE
    i INT;
BEGIN
    FOR i IN 1..200 LOOP
        INSERT INTO Réseaux (id_reseau, adresse_ip, sous_reseau, id_materiel)
        VALUES (réseaux_seq.NEXTVAL, '192.168.1.' || (i+1), '255.255.255.0', MOD(i, 100) + 1);
    END LOOP;
END;
/
