-- Actualisation des Vue Materiels sur Pau
EXEC DBMS_MVIEW.REFRESH('tickets_pau');
EXEC DBMS_MVIEW.REFRESH('stock_pau');
EXEC DBMS_MVIEW.REFRESH('materiels_pau');


-- Test d'un role
--Creation d'un tech reseau a cergy (meme principe pour les autres roles )
CONNECT cergy_le_parc/cergy_le_parc;
CREATE USER gestion_affection IDENTIFIED BY 123;
GRANT gestionnaire_affectation_cergy TO gestion_affection;
GRANT CREATE SESSION to gestion_affection;
CONNECT gestion_affection/123;
SELECT * FROM cergy_le_parc.vue_technicien_cergy;
select * from cergy_le_parc.vue_tickets_cergy;

insert into CERGY_LE_PARC.VUE_TICKETS_CERGY
values(1002,'ttt','des','Ouvert','08/04/25',326,26,2);

select * from CERGY_LE_PARC.VUE_TICKETS_CERGY
where TICKET_ID=1002;


-- Trigger stock
insert into ATTRIBUTIONS
VALUES (1,1,1);
-- Trigger seuil 
-- Tester en update une ligne de stock
UPDATE Stock 
SET quantite = 1  
WHERE id_materiel = 101;

--Trigger réseau
-- Teste trigger réseau 
insert into RÉSEAUX(ID_RESEAU,ADRESSE_IP,SOUS_RESEAU,ID_MATERIEL)
VALUES (5, '192.168.0.0','255.255.255.0',1);

--Trigger notification attribution
DELETE FROM Attributions WHERE id_attribution = 1;  -- Retirer l'attribution du matériel


--Tigger ticket notification



-- Tester curseur 
BEGIN
    nom_du_procdedure_de_curseur ;
END;
/
--Tests procedures
EXEC ajouter_materiel(10,'Ordinateur', 1, 2);
EXEC mettre_a_jour_stock(1, 50);
BEGIN
    ajouter_utilisateur('test', 'test', 'test.test@example.com');
END;

--Tests Fonctions 

SELECT * FROM TABLE(total_materiels_par_site(1));
SELECT trouver_utilisateur_par_email('exemple@email.com') FROM dual;

