connect cergy_le_parc/cergy_le_parc;
-- Curseur qui identifie les materiels sous seuil d'alerte 
CREATE OR REPLACE PROCEDURE detecter_stock_bas AS
    CURSOR cur_stock_bas IS 
        SELECT id_materiel, quantite, seuil_alerte 
        FROM Stock 
        WHERE quantite < seuil_alerte;
        
    v_id_materiel Stock.id_materiel%TYPE;
    v_quantite Stock.quantite%TYPE;
    v_seuil Stock.seuil_alerte%TYPE;
BEGIN
    OPEN cur_stock_bas;
    LOOP
        FETCH cur_stock_bas INTO v_id_materiel, v_quantite, v_seuil;
        EXIT WHEN cur_stock_bas%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('⚠️ Matériel ' || v_id_materiel || 
                             ' en stock bas (' || v_quantite || '/' || v_seuil || ')');
    END LOOP;
    CLOSE cur_stock_bas;
END;
/

-- Curseur pour voir les utilisateur qui n'ont pas de materiel attribue 
CREATE OR REPLACE PROCEDURE utilisateurs_sans_attribution AS
    CURSOR cur_utilisateurs_sans_attribution IS
        SELECT id_utilisateur, nom, prenom
        FROM Utilisateurs 
        WHERE id_utilisateur NOT IN (SELECT id_utilisateur FROM Attributions);
        
    v_id_utilisateur Utilisateurs.id_utilisateur%TYPE;
    v_nom Utilisateurs.nom%TYPE;
    v_prenom Utilisateurs.prenom%TYPE;
BEGIN
    OPEN cur_utilisateurs_sans_attribution;
    LOOP
        FETCH cur_utilisateurs_sans_attribution INTO v_id_utilisateur, v_nom, v_prenom;
        EXIT WHEN cur_utilisateurs_sans_attribution%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Utilisateur sans attribution : ' || v_nom || ' ' || v_prenom);
    END LOOP;
    CLOSE cur_utilisateurs_sans_attribution;
END;
/
-- Curseur pour trouver les tickets non résolu 

CREATE OR REPLACE PROCEDURE tickets_non_resolus AS
    CURSOR cur_tickets_non_resolus IS
        SELECT ticket_id, titre, statut
        FROM Tickets
        WHERE statut != 'Résolu';
        
    v_ticket_id Tickets.ticket_id%TYPE;
    v_titre Tickets.titre%TYPE;
    v_statut Tickets.statut%TYPE;
BEGIN
    OPEN cur_tickets_non_resolus;
    LOOP
        FETCH cur_tickets_non_resolus INTO v_ticket_id, v_titre, v_statut;
        EXIT WHEN cur_tickets_non_resolus%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Ticket non résolu : ' || v_titre || ' (ID: ' || v_ticket_id || ')');
    END LOOP;
    CLOSE cur_tickets_non_resolus;
END;
/

--Curseur pour vérifier les connexions réseau d’un matériel


CREATE OR REPLACE PROCEDURE verifier_connexions_reseau AS
    CURSOR cur_connexions_reseau IS
        SELECT r.id_reseau, r.adresse_ip, r.sous_reseau, r.id_materiel, m.nom_materiel
        FROM Réseaux r
        JOIN Matériels m ON r.id_materiel = m.id_materiel;
        
    v_id_reseau Réseaux.id_reseau%TYPE;
    v_adresse_ip Réseaux.adresse_ip%TYPE;
    v_sous_reseau Réseaux.sous_reseau%TYPE;
    v_id_materiel Réseaux.id_materiel%TYPE;
    v_nom_materiel Matériels.nom_materiel%TYPE;
BEGIN
    OPEN cur_connexions_reseau;
    LOOP
        FETCH cur_connexions_reseau INTO v_id_reseau, v_adresse_ip, v_sous_reseau, v_id_materiel, v_nom_materiel;
        EXIT WHEN cur_connexions_reseau%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Matériel : ' || v_nom_materiel || ' (ID: ' || v_id_materiel || ') est connecté au réseau : ' || 
                             v_id_reseau || ', avec adresse IP : ' || v_adresse_ip || ' et sous-réseau : ' || v_sous_reseau);
    END LOOP;
    CLOSE cur_connexions_reseau;
END;
/




