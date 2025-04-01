

--Creation d'un tech reseau a cergy (meme principe pour les autres roles )
CONNECT cergy_le_parc/cergy_le_parc;
CREATE USER tech_cergy_user IDENTIFIED BY tech_cergy_user;
GRANT CONNECT, technicien_cergy TO tech_cergy_user;
GRANT CREATE SESSION to tech_cergy_user;
CONNECT tech_cergy_user/tech_cergy_user;
SELECT * FROM cergy_le_parc.vue_technicien_cergy;