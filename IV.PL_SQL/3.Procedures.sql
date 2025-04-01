CREATE SEQUENCE Materiels_seq
START WITH 1 
INCREMENT BY 1 
NOCACHE 
NOCYCLE; 

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

--Procedure pour maj le stock
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



--Tests
EXEC ajouter_materiel(10,'Ordinateur', 1, 2);
EXEC mettre_a_jour_stock(1, 50);

