SELECT * FROM indicateursfedesdb.lics_histo WHERE An = 2023 LIMIT 20;

SHOW COLUMNS FROM indicateursfedesdb.lics_histo;

SELECT * FROM indicateursfedesdb.lics_histo LIMIT 30;

SELECT fede_gp, COUNT(*) AS nb_lignes, SUM(lics) AS licences
FROM indicateursfedesdb.lics_histo
WHERE YEAR(annee) = 2023
GROUP BY fede_gp
ORDER BY fede_gp;

SELECT fede_gp, code_fede_2025, code_fede_ref, federation, lics
FROM indicateursfedesdb.lics_histo
WHERE YEAR(annee) = 2023
ORDER BY lics DESC
LIMIT 15;