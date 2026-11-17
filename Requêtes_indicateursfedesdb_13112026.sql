USE indicateursfedesdb;

DROP TABLE IF EXISTS licences_2023;
CREATE TABLE licences_2023 (
  code_commune VARCHAR(5), commune VARCHAR(100), code_qpv VARCHAR(20), nom_qpv VARCHAR(150),
  departement VARCHAR(3), region VARCHAR(60), statut_geo VARCHAR(30),
  code_fede VARCHAR(5), federation VARCHAR(120),
  f_1_4 INT, f_5_9 INT, f_10_14 INT, f_15_19 INT, f_20_24 INT, f_25_29 INT, f_30_34 INT, f_35_39 INT,
  f_40_44 INT, f_45_49 INT, f_50_54 INT, f_55_59 INT, f_60_64 INT, f_65_69 INT, f_70_74 INT, f_75_79 INT,
  f_80_99 INT, f_nr INT,
  h_1_4 INT, h_5_9 INT, h_10_14 INT, h_15_19 INT, h_20_24 INT, h_25_29 INT, h_30_34 INT, h_35_39 INT,
  h_40_44 INT, h_45_49 INT, h_50_54 INT, h_55_59 INT, h_60_64 INT, h_65_69 INT, h_70_74 INT, h_75_79 INT,
  h_80_99 INT, h_nr INT,
  total INT
) CHARACTER SET utf8mb4;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/lic-data-2023.csv'
INTO TABLE licences_2023
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

DROP TABLE IF EXISTS clubs_2023;
CREATE TABLE clubs_2023 (
  code_commune VARCHAR(5), commune VARCHAR(100), code_qpv VARCHAR(20), nom_qpv VARCHAR(150),
  departement VARCHAR(3), region VARCHAR(60), statut_geo VARCHAR(30),
  code_fede VARCHAR(5), federation VARCHAR(120),
  clubs_actifs INT, epa_actifs INT, total_actifs INT, clubs INT, epa INT, total INT
) CHARACTER SET utf8mb4;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/clubs-data-2023.csv'
INTO TABLE clubs_2023
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

ALTER TABLE licences_2023 ADD INDEX (departement), ADD INDEX (code_fede);
ALTER TABLE clubs_2023    ADD INDEX (departement), ADD INDEX (code_fede);

USE indicateursfedesdb;

ALTER TABLE licences_2023
  MODIFY code_commune VARCHAR(30),
  MODIFY departement VARCHAR(10);

TRUNCATE TABLE licences_2023;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/lic-data-2023.csv'
INTO TABLE licences_2023
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

USE indicateursfedesdb;
ALTER TABLE licences_2023 ADD INDEX idx_dep (departement), ADD INDEX idx_fede (code_fede);
ALTER TABLE clubs_2023    ADD INDEX idx_dep (departement), ADD INDEX idx_fede (code_fede);

USE indicateursfedesdb;

DROP TABLE IF EXISTS clubs_2023;
CREATE TABLE clubs_2023 (
  code_commune VARCHAR(30), commune VARCHAR(100), code_qpv VARCHAR(20), nom_qpv VARCHAR(150),
  departement VARCHAR(10), region VARCHAR(60), statut_geo VARCHAR(30),
  code_fede VARCHAR(5), federation VARCHAR(120),
  clubs_actifs INT, epa_actifs INT, total_actifs INT, clubs INT, epa INT, total INT
) CHARACTER SET utf8mb4;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/clubs-data-2023.csv'
INTO TABLE clubs_2023
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

ALTER TABLE clubs_2023 ADD INDEX idx_dep (departement), ADD INDEX idx_fede (code_fede);

USE indicateursfedesdb;
SELECT 'licences' AS table_, COUNT(*) AS nb_lignes, SUM(total) AS somme_total FROM licences_2023
UNION ALL
SELECT 'clubs', COUNT(*), SUM(total) FROM clubs_2023;

USE indicateursfedesdb;

DROP TABLE IF EXISTS lics_histo;
CREATE TABLE lics_histo (
  code_fede_2025 VARCHAR(5), code_fede_ref VARCHAR(5), federation VARCHAR(120),
  annee DATE, evol_20ans DOUBLE, evol_10ans DOUBLE, evol_5ans DOUBLE,
  lics INT, lics_100_2002 DOUBLE, lics_100_2016 DOUBLE, fede_gp VARCHAR(50)
) CHARACTER SET utf8mb4;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/lics_histo.csv'
INTO TABLE lics_histo
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(code_fede_2025, code_fede_ref, federation, annee, @e20, @e10, @e5, @lics, @l02, @l16, fede_gp)
SET evol_20ans = NULLIF(@e20,''), evol_10ans = NULLIF(@e10,''), evol_5ans = NULLIF(@e5,''),
    lics = NULLIF(@lics,''), lics_100_2002 = NULLIF(@l02,''), lics_100_2016 = NULLIF(@l16,'');

SELECT YEAR(annee) AS an, COUNT(*) AS nb_fedes, SUM(lics) AS licences
FROM lics_histo GROUP BY an ORDER BY an;

USE indicateursfedesdb;

DROP TABLE IF EXISTS lics_histo;
CREATE TABLE lics_histo (
  code_fede_2025 VARCHAR(5), code_fede_ref VARCHAR(5), federation VARCHAR(120),
  annee DATE, evol_20ans DOUBLE, evol_10ans DOUBLE, evol_5ans DOUBLE,
  lics INT, lics_100_2002 DOUBLE, lics_100_2016 DOUBLE, fede_gp VARCHAR(50)
) CHARACTER SET utf8mb4;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/lics_histo.csv'
INTO TABLE lics_histo
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(code_fede_2025, code_fede_ref, federation, annee, @e20, @e10, @e5, @lics, @l02, @l16, fede_gp)
SET evol_20ans = NULLIF(@e20,''), evol_10ans = NULLIF(@e10,''), evol_5ans = NULLIF(@e5,''),
    lics = NULLIF(@lics,''), lics_100_2002 = NULLIF(@l02,''), lics_100_2016 = NULLIF(@l16,'');

SELECT YEAR(annee) AS an, COUNT(*) AS nb_fedes, SUM(lics) AS licences
FROM lics_histo GROUP BY an ORDER BY an;

USE indicateursfedesdb;

DROP TABLE IF EXISTS population_dep;
CREATE TABLE population_dep (
  code_region VARCHAR(3), region VARCHAR(60),
  departement VARCHAR(10), nom_departement VARCHAR(60),
  nb_arr INT, nb_cantons INT, nb_communes INT,
  pop_municipale INT, pop_totale INT,
  PRIMARY KEY (departement)
) CHARACTER SET utf8mb4;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/donnees_departements.csv'
INTO TABLE population_dep
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(code_region, region, departement, nom_departement, @arr, @can, @com, pop_municipale, pop_totale)
SET nb_arr = NULLIF(@arr,''), nb_cantons = NULLIF(@can,''), nb_communes = NULLIF(@com,'');

SELECT COUNT(*) AS nb_dep, SUM(pop_municipale) AS population FROM population_dep;
INSERT INTO population_dep VALUES ('06','Mayotte','976','Mayotte',NULL,NULL,17,310022,310022);

SELECT DISTINCT l.departement FROM licences_2023 l
LEFT JOIN population_dep p ON p.departement = l.departement
WHERE p.departement IS NULL;

USE indicateursfedesdb;

DROP TABLE IF EXISTS dim_federation;
CREATE TABLE dim_federation AS
SELECT DISTINCT code_fede, federation,
  CASE
    WHEN federation REGEXP 'Football|Rugby|Basket|Handball|Volley|Hockey|Baseball|Water' THEN 'Sports collectifs'
    WHEN federation REGEXP 'Tennis|Badminton|Squash|Pelote|Padel'                       THEN 'Sports de raquette'
    WHEN federation REGEXP 'Judo|Karat|Taekwondo|Boxe|Lutte|Escrime|Arts martiaux|Aïkido|Kick|Wushu|Savate' THEN 'Arts martiaux et combat'
    WHEN federation REGEXP 'Athl|Natation|Cyclisme|Triathlon|Gymnastique|Halt|Tir|Aviron|Cano|Équitation|Golf|Ski|Voile|Surf|Montagne|Escalade|Randonn|Course' THEN 'Sports individuels'
    WHEN federation REGEXP 'Sport pour tous|Retraite|EPGV|Multisport|UFOLEP|UNSS|USEP|FSGT|Sport en milieu rural|Handisport|Sport adapté|Scolaire|Universitaire' THEN 'Multisports, affinitaires et scolaires'
    ELSE 'Autres disciplines'
  END AS famille
FROM licences_2023;
ALTER TABLE dim_federation ADD PRIMARY KEY (code_fede);

SELECT famille, COUNT(*) FROM dim_federation GROUP BY famille;

USE indicateursfedesdb;
SET SQL_SAFE_UPDATES = 0;

UPDATE dim_federation SET famille = CASE
  WHEN code_fede IN ('105','111','115','116','129','131','133','138','140','248','264') THEN 'Sports collectifs'
  WHEN code_fede IN ('103','123','124','141','207','208','227','231','241') THEN 'Sports de raquette et de balle'
  WHEN code_fede IN ('106','110','117','118','122','204','205','212','229','254','261','268') THEN 'Arts martiaux et combat'
  WHEN code_fede IN ('102','107','119','128','137','221','228','234','249','250','265','267') THEN 'Sports nautiques'
  WHEN code_fede IN ('121','135','217','218','244','245','251','255','271','112','214') THEN 'Sports de nature et de montagne'
  WHEN code_fede LIKE '4%' OR code_fede LIKE '5%' OR code_fede LIKE '6%' THEN 'Multisports, affinitaires, handi et scolaires'
  WHEN code_fede IN ('201','202','203','206','224','233','237','243','257','258','269') THEN 'Sports aériens et mécaniques'
  WHEN code_fede IN ('210','211','213','220','226','242','209','125','126') THEN 'Précision, boules et jeux'
  ELSE 'Sports individuels'
END;

SET SQL_SAFE_UPDATES = 1;
SELECT famille, COUNT(*) AS nb FROM dim_federation GROUP BY famille ORDER BY nb DESC;

ALTER TABLE dim_federation MODIFY famille VARCHAR(60);

USE indicateursfedesdb;
SET SQL_SAFE_UPDATES = 0;

UPDATE dim_federation SET famille = CASE
  WHEN code_fede IN ('105','111','115','116','129','131','133','138','140','248','264') THEN 'Sports collectifs'
  WHEN code_fede IN ('103','123','124','141','207','208','227','231','241') THEN 'Sports de raquette et de balle'
  WHEN code_fede IN ('106','110','117','118','122','204','205','212','229','254','261','268') THEN 'Arts martiaux et combat'
  WHEN code_fede IN ('102','107','119','128','137','221','228','234','249','250','265','267') THEN 'Sports nautiques'
  WHEN code_fede IN ('121','135','217','218','244','245','251','255','271','112','214') THEN 'Sports de nature et de montagne'
  WHEN code_fede LIKE '4%' OR code_fede LIKE '5%' OR code_fede LIKE '6%' THEN 'Multisports, affinitaires, handi et scolaires'
  WHEN code_fede IN ('201','202','203','206','224','233','237','243','257','258','269') THEN 'Sports aériens et mécaniques'
  WHEN code_fede IN ('210','211','213','220','226','242','209','125','126') THEN 'Précision, boules et jeux'
  ELSE 'Sports individuels'
END;

SET SQL_SAFE_UPDATES = 1;
SELECT famille, COUNT(*) AS nb FROM dim_federation GROUP BY famille ORDER BY nb DESC;

USE indicateursfedesdb;

CREATE OR REPLACE VIEW v_dep_fede AS
SELECT l.departement, l.code_fede,
  SUM(f_1_4+f_5_9+f_10_14+f_15_19+f_20_24+f_25_29+f_30_34+f_35_39+f_40_44+f_45_49
     +f_50_54+f_55_59+f_60_64+f_65_69+f_70_74+f_75_79+f_80_99+f_nr) AS lic_femmes,
  SUM(h_1_4+h_5_9+h_10_14+h_15_19+h_20_24+h_25_29+h_30_34+h_35_39+h_40_44+h_45_49
     +h_50_54+h_55_59+h_60_64+h_65_69+h_70_74+h_75_79+h_80_99+h_nr) AS lic_hommes,
  SUM(l.total) AS lic_total
FROM licences_2023 l
GROUP BY l.departement, l.code_fede;

CREATE OR REPLACE VIEW v_clubs_dep_fede AS
SELECT departement, code_fede, SUM(total) AS nb_clubs
FROM clubs_2023 GROUP BY departement, code_fede;

SELECT SUM(lic_total) AS licences, SUM(lic_femmes)/SUM(lic_total) AS taux_fem FROM v_dep_fede;