CREATE OR REPLACE FUNCTION delete_abundant_data()
RETURNS integer AS
$$
BEGIN
-------------------------------------------------------------------------------------------------------
-- odstranit tie, kde je gho aj praca 0
DELETE FROM t_produkcia WHERE cas IN
	(select cas from t_solar_hod where elev < 0);
-------------------------------------------------------------------------------------------------------
-- odstranit tie, co nemaju par
DELETE FROM t_produkcia WHERE predpoved IS NULL;
DELETE FROM t_predpoved WHERE id NOT IN (SELECT predpoved FROM t_produkcia);
-------------------------------------------------------------------------------------------------------
DELETE FROM t_solar_den WHERE datum NOT IN (SELECT datum FROM t_predpoved);
DELETE FROM t_solar_hod WHERE cas NOT IN (SELECT cas FROM t_predpoved);
-------------------------------------------------------------------------------------------------------
RETURN 1;
END;
$$
LANGUAGE plpgsql