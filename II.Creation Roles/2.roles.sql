-- Se connecter en tant que SYSTEM
CONNECT SYSTEM/mot_de_passe;
-- Création du rôle Administrateur (a accès à tout)
CREATE ROLE admin;
GRANT ALL PRIVILEGES TO admin;

-- Technicien Cergy
CREATE ROLE technicien_cergy;
GRANT SELECT, UPDATE ON vue_technicien_cergy TO technicien_cergy;

-- Technicien Pau
CREATE ROLE technicien_pau;
GRANT SELECT, UPDATE ON vue_technicien_pau TO technicien_pau;

-- Gestionnaire Stock Cergy
CREATE ROLE gestionnaire_stock_cergy;
GRANT SELECT, UPDATE, DELETE ON vue_gestionnaire_stock_cergy TO gestionnaire_stock_cergy;

-- Gestionnaire Stock Pau
CREATE ROLE gestionnaire_stock_pau;
GRANT SELECT, UPDATE, DELETE ON vue_gestionnaire_stock_pau TO gestionnaire_stock_pau;

-- Responsable Cergy
CREATE ROLE responsable_cergy;
GRANT SELECT, UPDATE, DELETE ON vue_responsable_cergy TO responsable_cergy;

-- Responsable Pau
CREATE ROLE responsable_pau;
GRANT SELECT, UPDATE, DELETE ON vue_responsable_pau TO responsable_pau;

-- Administrateur Reseau 
CREATE ROLE admin_reseau;
GRANT SELECT, UPDATE, DELETE ON vue_admin_reseau TO admin_reseau;

--Gestionnaire affectation pau 
CREATE ROLE gestionnaire_affectation_pau;
GRANT SELECT, UPDATE ON vue_gestionnaire_affectation_pau TO gestionnaire_affectation_pau;

-- Gestionnaire affectation cergy 
CREATE ROLE gestionnaire_affectation_cergy;
GRANT SELECT, UPDATE ON vue_gestionnaire_affectation_cergy TO gestionnaire_affectation_cergy;
GRANT INSERT ON vue_gestionnaire_affectation_cergy TO gestionnaire_affectation_cergy;
