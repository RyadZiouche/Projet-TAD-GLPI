connect cergy_le_parc/cergy_le_parc;
CREATE OR REPLACE TYPE materiel_stock_type AS OBJECT (
    nom_type_materiel VARCHAR2(255),
    quantite_stock INT
);
/

CREATE OR REPLACE TYPE materiel_stock_table AS TABLE OF materiel_stock_type;
/

CREATE OR REPLACE FUNCTION total_materiels_par_site(
    p_id_site IN INT
) RETURN materiel_stock_table 
IS
    v_result materiel_stock_table := materiel_stock_table();
BEGIN
    SELECT materiel_stock_type(t.nom_type_materiel, COALESCE(SUM(s.quantite), 0))
    BULK COLLECT INTO v_result
    FROM Types_de_Materiels t
    LEFT JOIN Matériels m ON t.id_type_materiel = m.id_type_materiel
    LEFT JOIN Stock s ON m.id_materiel = s.id_materiel
    WHERE m.id_site = p_id_site
    GROUP BY t.nom_type_materiel;

    RETURN v_result;
END;
/


-- Fonction qui retourne les infos a partir d'un mail 
CREATE OR REPLACE FUNCTION trouver_utilisateur_par_email(p_email IN VARCHAR2)  
RETURN VARCHAR2  
IS  
    v_nom_utilisateur VARCHAR2(100);  
BEGIN  
    SELECT nom || ' ' || prenom  
    INTO v_nom_utilisateur  
    FROM Utilisateurs  
    WHERE email = p_email;  

    RETURN v_nom_utilisateur;  
EXCEPTION  
    WHEN NO_DATA_FOUND THEN  
        RETURN 'Utilisateur introuvable';  
END;  
/
