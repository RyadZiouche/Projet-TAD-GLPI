
-- Désactiver les triggers
ALTER TRIGGER CERGY_LE_PARC.TRG_ATTRIBUTION_NOTIFICATION DISABLE;
ALTER TRIGGER CERGY_LE_PARC.TRG_TICKET_NOTIFICATION DISABLE;
ALTER TRIGGER CERGY_LE_PARC.TRG_LOG_CONNEXION DISABLE;
ALTER TRIGGER CERGY_LE_PARC.TRG_SEUIL_ALERTE DISABLE;

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
    DELETE FROM Utilisateurs;
    
-- Réactiver les triggers
ALTER TRIGGER CERGY_LE_PARC.TRG_ATTRIBUTION_NOTIFICATION ENABLE;
ALTER TRIGGER CERGY_LE_PARC.TRG_TICKET_NOTIFICATION ENABLE;
ALTER TRIGGER CERGY_LE_PARC.TRG_LOG_CONNEXION ENABLE;
ALTER TRIGGER CERGY_LE_PARC.TRG_SEUIL_ALERTE ENABLE;

    
-- Supprimer les anciennes séquences 
DROP SEQUENCE Types_de_Materiels_seq;
DROP SEQUENCE Sites_seq;
DROP SEQUENCE Materiels_seq;
DROP SEQUENCE Utilisateurs_seq;
DROP SEQUENCE Stock_seq;
DROP SEQUENCE Attributions_seq;
DROP SEQUENCE Réseaux_seq;
DROP SEQUENCE Tickets_seq;
DROP SEQUENCE Event_Logs_seq;
DROP SEQUENCE Notifications_seq;

-- Séquence pour la table Types_de_Materiels
CREATE SEQUENCE Types_de_Materiels_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table Sites
CREATE SEQUENCE Sites_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table Matériels
CREATE SEQUENCE Materiels_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table Utilisateurs
CREATE SEQUENCE Utilisateurs_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table Stock
CREATE SEQUENCE Stock_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table Attributions
CREATE SEQUENCE Attributions_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table Réseaux
CREATE SEQUENCE Réseaux_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table Tickets
CREATE SEQUENCE Tickets_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table Event_Logs
CREATE SEQUENCE Event_Logs_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Séquence pour la table Notifications
CREATE SEQUENCE Notifications_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;


--Ajouter lignes 
-- Insertion des utilisateurs
INSERT INTO Utilisateurs (id_utilisateur, nom, prenom, email) 
VALUES (utilisateurs_seq.NEXTVAL, 'Dupont', 'Jean', 'jean.dupont@example.com');

INSERT INTO Utilisateurs (id_utilisateur, nom, prenom, email) 
VALUES (utilisateurs_seq.NEXTVAL, 'Martin', 'Pierre', 'pierre.martin@example.com');
select * from UTILISATEURS;
-- Insertion des types de matériels
INSERT INTO Types_de_Materiels (id_type_materiel, nom_type_materiel)
VALUES (types_de_materiels_seq.NEXTVAL, 'Ordinateur');

INSERT INTO Types_de_Materiels (id_type_materiel, nom_type_materiel)
VALUES (types_de_materiels_seq.NEXTVAL, 'Imprimante');
select * from TYPES_DE_MATERIELS;
-- Insertion des sites
INSERT INTO Sites (id_site, nom_site)
VALUES (sites_seq.NEXTVAL, 'Cergy');

INSERT INTO Sites (id_site, nom_site)
VALUES (sites_seq.NEXTVAL, 'Pau');

-- Insertion des matériels
INSERT INTO Matériels (id_materiel, nom_materiel, id_type_materiel, id_site)
VALUES (materiels_seq.NEXTVAL, 'Ordinateur Dell', 1, 1);

INSERT INTO Matériels (id_materiel, nom_materiel, id_type_materiel, id_site)
VALUES (materiels_seq.NEXTVAL, 'Imprimante HP', 2, 2);

-- Insertion des stocks
INSERT INTO Stock (stock_id, id_materiel, quantite, seuil_alerte, id_site)
VALUES (stock_seq.NEXTVAL, 1, 10, 2, 1);

INSERT INTO Stock (stock_id, id_materiel, quantite, seuil_alerte, id_site)
VALUES (stock_seq.NEXTVAL, 2, 5, 2, 2);



-- Insertion des tickets
INSERT INTO Tickets (ticket_id, titre, description, statut, date_creation, id_utilisateur, id_materiel, id_site)
VALUES (tickets_seq.NEXTVAL, 'Problème avec lordinateur', 'L ordinateur Dell ne démarre pas', 'Ouvert', SYSDATE, 1, 1, 1);

INSERT INTO Tickets (ticket_id, titre, description, statut, date_creation, id_utilisateur, id_materiel, id_site)
VALUES (tickets_seq.NEXTVAL, 'Problème avec l imprimante', 'Limprimante HP est en panne', 'Fermé', SYSDATE, 2, 2, 2);

