--conecter au system
connect SYSTEM/mot_de_passe ;
-- Creer un user sans le c##
alter session set "_ORACLE_SCRIPT"=true;
-- Création de l'utilisateur principal
CREATE USER cergy_le_parc IDENTIFIED BY cergy_le_parc;
GRANT CONNECT, RESOURCE TO cergy_le_parc;
ALTER USER cergy_le_parc QUOTA UNLIMITED ON USERS;

--conecter au system
connect SYSTEM/mot_de_passe ;
-- Creer un user sans le c##
alter session set "_ORACLE_SCRIPT"=true;
-- Création de l'utilisateur principal
CREATE USER pau IDENTIFIED BY pau;
GRANT CONNECT, RESOURCE TO pau;
ALTER USER pau QUOTA UNLIMITED ON USERS;

