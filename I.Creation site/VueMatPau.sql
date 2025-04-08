alter session set "_ORACLE_SCRIPT"=true;

GRANT CREATE DATABASE LINK TO cergy_le_parc;
GRANT CREATE DATABASE LINK TO pau;
CREATE DATABASE LINK db_cergy;
GRANT CREATE MATERIALIZED VIEW TO pau;

connect pau/pau;
--Creation database link de cergy
CREATE DATABASE LINK db_cergy
CONNECT TO cergy_le_parc IDENTIFIED BY "cergy_le_parc"
USING 'xe';



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
