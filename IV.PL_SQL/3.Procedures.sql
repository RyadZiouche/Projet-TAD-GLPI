CONNECT cergy_le_parc/cergy_le_parc;

-- Procédure : Ajouter un matériel
CREATE OR REPLACE PROCEDURE ajouter_materiel (
    p_id_materiel IN INT, 
    p_nom_materiel IN VARCHAR2,
    p_type_materiel IN INT,
    p_id_site IN INT
)
IS
BEGIN
    INSERT INTO Matériels (id_materiel, nom_materiel, id_type_materiel, id_site)
    VALUES (p_id_materiel, p_nom_materiel, p_type_materiel, p_id_site);
END;
/


-- Procédure : Mettre à jour le stock
CREATE OR REPLACE PROCEDURE mettre_a_jour_stock (
    p_id_materiel IN INT,
    p_quantite IN INT
)
IS
BEGIN
    UPDATE Stock
    SET quantite = p_quantite
    WHERE id_materiel = p_id_materiel;
END;
/

-- Procédure : Ajouter un utilisateur avec vérification d'email
CREATE OR REPLACE PROCEDURE ajouter_utilisateur (
    p_nom           IN VARCHAR2,
    p_prenom        IN VARCHAR2,
    p_email         IN VARCHAR2
)
IS
    v_count_email NUMBER;
BEGIN
    -- Vérifier si l'email existe déjà
    SELECT COUNT(*)
    INTO v_count_email
    FROM Utilisateurs
    WHERE email = p_email;

    IF v_count_email > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : l''adresse email "' || p_email || '" est déjà utilisée.');
    ELSE
        -- Insérer le nouvel utilisateur
        INSERT INTO Utilisateurs (id_utilisateur, nom, prenom, email)
        VALUES (utilisateurs_seq.NEXTVAL, p_nom, p_prenom, p_email);

        DBMS_OUTPUT.PUT_LINE('Utilisateur ajouté avec succès : ' || p_prenom || ' ' || p_nom || '.');
    END IF;
END;
/
