-- Se connecter en tant que SYSTEM
CONNECT cergy_le_parc/cergy_le_parc;
alter session set "_ORACLE_SCRIPT"=true;

-- Création du rôle Administrateur (a accès à tout)
CREATE ROLE admin;
GRANT ALL PRIVILEGES TO admin;

-- Technicien Cergy
CREATE ROLE technicien_cergy;
GRANT SELECT, UPDATE ON vue_technicien_cergy TO technicien_cergy;
GRANT SELECT, INSERT, UPDATE ON vue_tickets_cergy TO technicien_cergy;
grant select on vue_materiels_cergy to technicien_cergy;
-- Gestionnaire Stock Cergy
CREATE ROLE gestionnaire_stock_cergy;
GRANT SELECT, UPDATE, DELETE ON vue_gestionnaire_stock_cergy TO gestionnaire_stock_cergy;
GRANT SELECT, INSERT, UPDATE, DELETE ON vue_stock_cergy TO gestionnaire_stock_cergy;
grant select on vue_materiels_cergy to gestionnaire_stock_cergy;

-- Responsable Cergy
CREATE ROLE responsable_cergy;
GRANT SELECT, UPDATE, DELETE ON vue_responsable_cergy TO responsable_cergy;
GRANT SELECT, INSERT, UPDATE, DELETE ON vue_utilisateurs_cergy TO responsable_cergy;
GRANT SELECT, INSERT, UPDATE, DELETE ON vue_materiels_cergy TO responsable_cergy;
GRANT SELECT, INSERT, UPDATE, DELETE ON vue_attributions_cergy TO responsable_cergy;
-- Gestionnaire affectation cergy 
CREATE ROLE gestionnaire_affectation_cergy;
GRANT SELECT, UPDATE ON vue_gestionnaire_affectation_cergy TO gestionnaire_affectation_cergy;
GRANT INSERT ON vue_gestionnaire_affectation_cergy TO gestionnaire_affectation_cergy; 
GRANT SELECT, INSERT, UPDATE ON vue_attributions_cergy TO gestionnaire_affectation_cergy;
GRANT select on vue_utilisateurs_cergy to gestionnaire_affectation_cergy;
grant select on vue_materiels_cergy to gestionnaire_affectation_cergy;

-- Se connecter en tant que SYSTEM
CONNECT pau/pau;

alter session set "_ORACLE_SCRIPT"=true;

-- Technicien Pau
CREATE ROLE technicien_pau;
GRANT SELECT, UPDATE ON vue_technicien_pau TO technicien_pau;
GRANT SELECT, INSERT, UPDATE ON vue_tickets_pau TO technicien_pau;
GRANT SELECT ON vue_materiels_pau TO technicien_pau;

-- Gestionnaire Stock Pau
CREATE ROLE gestionnaire_stock_pau;
GRANT SELECT, UPDATE, DELETE ON vue_gestionnaire_stock_pau TO gestionnaire_stock_pau;
GRANT SELECT, INSERT, UPDATE, DELETE ON vue_stock_pau TO gestionnaire_stock_pau;
GRANT SELECT ON vue_materiels_pau TO gestionnaire_stock_pau;

-- Responsable Pau
CREATE ROLE responsable_pau;
GRANT SELECT, UPDATE, DELETE ON vue_responsable_pau TO responsable_pau;
GRANT SELECT, INSERT, UPDATE, DELETE ON vue_utilisateurs_pau TO responsable_pau;
GRANT SELECT, INSERT, UPDATE, DELETE ON vue_materiels_pau TO responsable_pau;
GRANT SELECT, INSERT, UPDATE, DELETE ON vue_attributions_pau TO responsable_pau;

-- Gestionnaire Affectation Pau
CREATE ROLE gestionnaire_affectation_pau;
GRANT SELECT, UPDATE ON vue_gestionnaire_affectation_pau TO gestionnaire_affectation_pau;
GRANT INSERT ON vue_gestionnaire_affectation_pau TO gestionnaire_affectation_pau;
GRANT SELECT, INSERT, UPDATE ON vue_attributions_pau TO gestionnaire_affectation_pau;
GRANT SELECT ON vue_utilisateurs_pau TO gestionnaire_affectation_pau;
GRANT SELECT ON vue_materiels_pau TO gestionnaire_affectation_pau;