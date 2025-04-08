-- Activer le mode script
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;


-- Création de l'utilisateur cergy_le_parc
CREATE USER cergy_le_parc IDENTIFIED BY cergy_le_parc;
GRANT BDA TO cergy_le_parc;
ALTER USER cergy_le_parc QUOTA UNLIMITED ON USERS;

-- Création de l'utilisateur pau
CREATE USER pau IDENTIFIED BY pau;
GRANT DBA TO pau;
ALTER USER pau QUOTA UNLIMITED ON USERS;
