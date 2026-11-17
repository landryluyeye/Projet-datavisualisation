SELECT * FROM `indicateurs_cles_fede`

USE indicateursfedesdb;
SET SQL_SAFE_UPDATES = 0;

SELECT table_name INTO @t
FROM information_schema.columns
WHERE table_schema = 'indicateursfedesdb' AND column_name = 'fede_gp'
LIMIT 1;

SET @q1 = CONCAT('ALTER TABLE `', @t, '` ADD COLUMN id_fede_gp TINYINT, ADD COLUMN nom_fede_gp VARCHAR(50)');
PREPARE s1 FROM @q1; EXECUTE s1; DEALLOCATE PREPARE s1;

SET @q2 = CONCAT('UPDATE `', @t, '` SET id_fede_gp = CAST(SUBSTRING_INDEX(fede_gp, ''.'', 1) AS UNSIGNED), nom_fede_gp = TRIM(SUBSTRING(fede_gp, LOCATE(''.'', fede_gp) + 1))');
PREPARE s2 FROM @q2; EXECUTE s2; DEALLOCATE PREPARE s2;

SET @q3 = CONCAT('SELECT fede_gp, id_fede_gp, nom_fede_gp, COUNT(*) AS nb FROM `', @t, '` GROUP BY 1,2,3 ORDER BY 2');
PREPARE s3 FROM @q3; EXECUTE s3; DEALLOCATE PREPARE s3;

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM <indicateursfedesdb> WHERE fede_gp IS NULL OR fede_gp = '';

USE indicateursfedesdb;

SELECT table_name INTO @t
FROM information_schema.columns
WHERE table_schema = 'indicateursfedesdb' AND column_name = 'fede_gp'
LIMIT 1;

SET @q = CONCAT('SELECT COUNT(*) AS total, SUM(fede_gp IS NULL OR fede_gp = '''') AS vides FROM `', @t, '`');
PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s;

SET @q = CONCAT('SELECT * FROM `', @t, '` WHERE fede_gp IS NULL OR fede_gp = ''''');
PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s;

SHOW VARIABLES LIKE 'secure_file_priv';