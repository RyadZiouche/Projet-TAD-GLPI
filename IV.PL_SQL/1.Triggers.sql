connect cergy_le_parc/cergy_le_parc;
-- Triggers que mets à jour la table stock lors de l'ajoute d'une attribution de materiel si possible 
-- Renvoie une erreur si quantite non disponible 
CREATE OR REPLACE TRIGGER trg_retrait_stock
AFTER INSERT ON Attributions
FOR EACH ROW
DECLARE
    v_nb_materiel NUMBER;
BEGIN
    -- Compter la quantité de matériels disponibles du même type et sur le même site
    SELECT s.quantite
    INTO v_nb_materiel
    FROM Stock s
    WHERE s.id_materiel = :NEW.id_materiel
      AND s.id_site = (
          SELECT id_site 
          FROM Utilisateurs 
          WHERE id_utilisateur = :NEW.id_utilisateur
      );

    -- Vérifier si la quantité est suffisante pour l'attribution
    IF v_nb_materiel > 0 THEN
        -- Mettre à jour le stock en décrémentant la quantité
        UPDATE Stock
        SET quantite = quantite - 1
        WHERE id_materiel = :NEW.id_materiel
          AND id_site = (
              SELECT id_site 
              FROM Utilisateurs 
              WHERE id_utilisateur = :NEW.id_utilisateur
          );
    ELSE
        -- Lever une erreur si le stock est insuffisant
        RAISE_APPLICATION_ERROR(-20001, 'Stock insuffisant pour ce type de matériel sur ce site.');
    END IF;
END;
/


-- Trigger qui se declenche uniquement si la quantité mise à jour devient inférieure au seuil d'alerte.
-- Insert dans events logs pour enregistrer l'evenement 
CREATE OR REPLACE TRIGGER trg_seuil_alerte
AFTER UPDATE ON Stock
FOR EACH ROW
WHEN (NEW.quantite < NEW.seuil_alerte)  -- Condition : Quantité devient inférieure au seuil
BEGIN
    INSERT INTO Event_Logs (log_id, type, description, date_event, id_materiel)
    VALUES (
        Event_Logs_seq.NEXTVAL,  -- Utilisation d'une séquence pour générer l'ID unique
        'Alerte Stock',
        'Le stock du matériel ' || :NEW.id_materiel || ' est passé sous le seuil d''alerte (' || :NEW.seuil_alerte || ').',
        SYSTIMESTAMP,
        :NEW.id_materiel
    );
END;
/


-- Trigger qui ajoute une ligne a events logs lors d'une connexion 
CREATE OR REPLACE TRIGGER trg_log_connexion
AFTER INSERT ON Réseaux
FOR EACH ROW
BEGIN
    -- Insérer un log lorsqu'une connexion réseau est enregistrée
    INSERT INTO Event_Logs (log_id, type, description, date_event, id_materiel)
    VALUES (
        Event_Logs_seq.NEXTVAL,  -- ID auto-incrémenté via une séquence
        'Connexion Réseau',
        'Connexion détectée pour le matériel ' || :NEW.id_materiel || 
        ' avec l adresse IP ' || :NEW.adresse_ip || ' et le sous-réseau ' || :NEW.sous_reseau,
        SYSTIMESTAMP,
        :NEW.id_materiel
    );
END;
/







-- Trigger qui va notifier une affection ou suppresion d'affectation
CREATE OR REPLACE TRIGGER trg_attribution_notification
AFTER INSERT OR DELETE ON Attributions
FOR EACH ROW
DECLARE
    -- Variables pour le nom et prénom de l'utilisateur
    v_nom_utilisateur VARCHAR2(255);
    v_prenom_utilisateur VARCHAR2(255);
BEGIN
    -- Lorsqu'un PC est attribué
    IF INSERTING THEN
        -- Récupérer le nom et prénom de l'utilisateur
        SELECT nom, prenom
        INTO v_nom_utilisateur, v_prenom_utilisateur
        FROM Utilisateurs
        WHERE id_utilisateur = :NEW.id_utilisateur;
        
        -- Créer la notification
        INSERT INTO Notifications (notification_id, id_utilisateur, message, statut, date_envoi)
        VALUES (
            Notifications_seq.NEXTVAL,  -- Séquence pour générer un ID unique
            :NEW.id_utilisateur,  -- ID de l'utilisateur qui reçoit le matériel
            'Bonjour ' || v_prenom_utilisateur || ' ' || v_nom_utilisateur || ', le matériel ' || :NEW.id_materiel || ' a été attribué à votre nom.',
            'Non lu',  -- Statut de la notification
            SYSTIMESTAMP  -- Date d'envoi de la notification
        );
    -- Lorsqu'un PC est retiré
    ELSIF DELETING THEN
        -- Récupérer le nom et prénom de l'utilisateur
        SELECT nom, prenom
        INTO v_nom_utilisateur, v_prenom_utilisateur
        FROM Utilisateurs
        WHERE id_utilisateur = :OLD.id_utilisateur;
        
        -- Créer la notification
        INSERT INTO Notifications (notification_id, id_utilisateur, message, statut, date_envoi)
        VALUES (
            Notifications_seq.NEXTVAL,  -- Séquence pour générer un ID unique
            :OLD.id_utilisateur,  -- ID de l'utilisateur qui a perdu le matériel
            'Bonjour ' || v_prenom_utilisateur || ' ' || v_nom_utilisateur || ', votre matériel numéroté ' || :OLD.id_materiel || ' a été retiré.',
            'Non lu',  -- Statut de la notification
            SYSTIMESTAMP  -- Date d'envoi de la notification
        );
    END IF;
END;
/

--Trigger notification ticket
CREATE OR REPLACE TRIGGER trg_ticket_notification
AFTER INSERT OR DELETE OR UPDATE ON Tickets
FOR EACH ROW
DECLARE
    v_nom_utilisateur VARCHAR2(255);
    v_prenom_utilisateur VARCHAR2(255);
BEGIN
    -- Lorsque un ticket est créé
    IF INSERTING THEN
        -- Récupérer le nom et prénom de l'utilisateur
        BEGIN
            SELECT nom, prenom
            INTO v_nom_utilisateur, v_prenom_utilisateur
            FROM Utilisateurs
            WHERE id_utilisateur = :NEW.id_utilisateur;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_nom_utilisateur := 'Inconnu';
                v_prenom_utilisateur := 'Inconnu';
        END;

        -- Créer la notification
        INSERT INTO Notifications (notification_id, id_utilisateur, message, statut, date_envoi)
        VALUES (
            Notifications_seq.NEXTVAL,  -- Séquence pour générer un ID unique
            :NEW.id_utilisateur,  -- ID de l'utilisateur concerné
            'Bonjour ' || v_prenom_utilisateur || ' ' || v_nom_utilisateur || ', un nouveau ticket a été créé pour vous. Titre: "' || :NEW.titre || '".',
            'Non lu',  -- Statut de la notification
            SYSTIMESTAMP  -- Date d'envoi de la notification
        );

    -- Lorsqu'un ticket est supprimé
    ELSIF DELETING THEN
        -- Récupérer le nom et prénom de l'utilisateur
        BEGIN
            SELECT nom, prenom
            INTO v_nom_utilisateur, v_prenom_utilisateur
            FROM Utilisateurs
            WHERE id_utilisateur = :OLD.id_utilisateur;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_nom_utilisateur := 'Inconnu';
                v_prenom_utilisateur := 'Inconnu';
        END;

        -- Créer la notification
        INSERT INTO Notifications (notification_id, id_utilisateur, message, statut, date_envoi)
        VALUES (
            Notifications_seq.NEXTVAL,  -- Séquence pour générer un ID unique
            :OLD.id_utilisateur,  -- ID de l'utilisateur concerné
            'Bonjour ' || v_prenom_utilisateur || ' ' || v_nom_utilisateur || ', le ticket intitulé "' || :OLD.titre || '" a été supprimé.',
            'Non lu',  -- Statut de la notification
            SYSTIMESTAMP  -- Date d'envoi de la notification
        );

    -- Lorsqu'un ticket est mis à jour (par exemple, son statut change)
    ELSIF UPDATING THEN
        -- Récupérer le nom et prénom de l'utilisateur
        BEGIN
            SELECT nom, prenom
            INTO v_nom_utilisateur, v_prenom_utilisateur
            FROM Utilisateurs
            WHERE id_utilisateur = :NEW.id_utilisateur;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_nom_utilisateur := 'Inconnu';
                v_prenom_utilisateur := 'Inconnu';
        END;

        -- Créer la notification (en cas de modification du statut du ticket)
        IF :NEW.statut != :OLD.statut THEN
            INSERT INTO Notifications (notification_id, id_utilisateur, message, statut, date_envoi)
            VALUES (
                Notifications_seq.NEXTVAL,  -- Séquence pour générer un ID unique
                :NEW.id_utilisateur,  -- ID de l'utilisateur concerné
                'Bonjour ' || v_prenom_utilisateur || ' ' || v_nom_utilisateur || ', le statut du ticket intitulé "' || :NEW.titre || '" a été modifié en : "' || :NEW.statut || '".',
                'Non lu',  -- Statut de la notification
                SYSTIMESTAMP  -- Date d'envoi de la notification
            );
        END IF;
    END IF;
END;
/









