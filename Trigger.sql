-- Création du trigger pour gérer le retrait du matériel du stock lors d'une attribution
CREATE OR REPLACE TRIGGER trg_retrait_stock
AFTER INSERT ON attributions
FOR EACH ROW
DECLARE
    v_nb_materiel NUMBER;
BEGIN
    -- Compter la quantité de matériels disponibles du même type et sur le même site
    SELECT COUNT(*) 
    INTO v_nb_materiel
    FROM materiels m
    JOIN stock s ON m.id_materiel = s.id_materiel
    WHERE m.id_type_materiel = (SELECT id_type_materiel FROM materiels WHERE id_materiel = :NEW.id_materiel)
      AND s.id_site = (SELECT id_site FROM utilisateurs WHERE id_utilisateur = :NEW.id_utilisateur);

    -- Vérifier si la quantité est suffisante pour l'attribution
    IF v_nb_materiel > 0 THEN
        -- Mettre à jour le stock en décrémentant la quantité
        UPDATE stock
        SET stock_id = stock_id - 1
        WHERE id_materiel = :NEW.id_materiel
          AND id_site = (SELECT id_site FROM utilisateurs WHERE id_utilisateur = :NEW.id_utilisateur);
    ELSE
        -- Lever une erreur si le stock est insuffisant
        RAISE_APPLICATION_ERROR(-20001, 'Stock insuffisant pour ce type de matériel sur ce site.');
    END IF;
END;
/

-- test
INSERT INTO attributions (id_attribution, id_utilisateur, id_materiel)
VALUES (1, 101, 2001);

--connect C##sys;
--ALTER USER C##TEST QUOTA UNLIMITED ON USERS;




--DROP TRIGGER trg_log_ticket;

-- Création du trigger pour enregistrer les actions sur les tickets
CREATE OR REPLACE TRIGGER trg_log_ticket
AFTER INSERT OR UPDATE ON tickets
FOR EACH ROW
DECLARE
    v_action VARCHAR2(50);
    v_utilisateur VARCHAR2(100);
BEGIN
    -- Déterminer l'action (Création ou Mise à jour)
    IF INSERTING THEN
        v_action := 'Création';
    ELSIF UPDATING THEN
        v_action := 'Modification';
    END IF;

    -- Récupérer le nom de l'utilisateur connecté
    SELECT USER INTO v_utilisateur FROM DUAL;

    -- Insertion de l'entrée dans la table logs_tickets
    INSERT INTO logs_tickets (log_id, ticket_id, action, utilisateur, description, date_action)
    VALUES (
        logs_tickets_seq.NEXTVAL,  -- Assurez-vous que la séquence existe
        :NEW.ticket_id,
        v_action,
        v_utilisateur,
        'Ticket ' || v_action || ' - Titre: ' || :NEW.titre || ', Statut: ' || :NEW.statut,
        SYSTIMESTAMP
    );
END;
/

-- test 
--INSERT INTO tickets (ticket_id, titre, description, statut, id_utilisateur, id_site)
--VALUES (1, 'Problème réseau', 'Le réseau est en panne.', 'Ouvert', 101, 1);

UPDATE tickets
SET statut = 'En cours'
WHERE ticket_id = 1;
