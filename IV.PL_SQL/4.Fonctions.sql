-- Fonction qui retoune le nom de type de materiels par site 
CREATE OR REPLACE FUNCTION total_materiels_par_site(
    p_id_site IN INT
) RETURN INT 
IS
    v_total INT;
BEGIN
    SELECT COUNT(*) INTO v_total
    FROM Matériels
    WHERE id_site = p_id_site;
    
    RETURN v_total;
END;
/
-- Test
SELECT total_materiels_par_site(1) FROM dual;

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
-- Tests 
SELECT trouver_utilisateur_par_email('exemple@email.com') FROM dual;
