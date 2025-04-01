GRANT CREATE DATABASE LINK TO cergy_le_parc;
GRANT CREATE DATABASE LINK TO pau;
CREATE DATABASE LINK db_cergy

connect pau/pau;
--Creation database link de cergy
CONNECT TO cergy_le_parc IDENTIFIED BY "cergy_le_parc"
USING 'xe';

connect system/mot_de_passe;
GRANT CREATE MATERIALIZED VIEW TO pau;

-- Création de la vue matérialisée materiels_pau avec rafraicchisment a la demande 
CREATE MATERIALIZED VIEW materiels_pau
REFRESH ON DEMAND
AS 
SELECT * 
FROM CERGY_LE_PARC.Matériels@db_cergy 
WHERE id_site = (SELECT id_site FROM CERGY_LE_PARC.Sites@db_cergy WHERE nom_site = 'Pau');

-- Création de la vue matérialisée tickets_pau avec rafraicchisment a la demande 
CREATE MATERIALIZED VIEW tickets_pau
REFRESH ON DEMAND
AS 
SELECT * 
FROM CERGY_LE_PARC.Tickets@db_cergy 
WHERE id_site = (SELECT id_site FROM CERGY_LE_PARC.Sites@db_cergy WHERE nom_site = 'Pau');

-- Création de la vue matérialisée stock_pau avec rafraicchisment a la demande 
CREATE MATERIALIZED VIEW stock_pau
REFRESH ON DEMAND
AS 
SELECT * 
FROM CERGY_LE_PARC.Stock@db_cergy 
WHERE id_site = (SELECT id_site FROM CERGY_LE_PARC.Sites@db_cergy WHERE nom_site = 'Pau');

--Commande pour rafraichir la vue materiel 
BEGIN
    EXEC DBMS_MVIEW.REFRESH('tickets_pau');
    EXEC DBMS_MVIEW.REFRESH('stock_pau');
    EXEC DBMS_MVIEW.REFRESH('materiels_pau');

END;

