CREATE OR REPLACE FUNCTION import_aladin_csv(subor text)
RETURNS integer AS
$$
DECLARE
	lokalita_id integer;
BEGIN
---------------------------------------------------------------------------
IF subor like '%DUB%' THEN
	SELECT id INTO lokalita_id FROM t_lokalita WHERE nazov = 'Dubravy';
ELSIF subor like '%PLE%' THEN
	SELECT id INTO lokalita_id FROM t_lokalita WHERE nazov = 'Plesivec';
ELSE RETURN -1;
END IF;
---------------------------------------------------------------------------
SET TIMEZONE = 'UTC';
DELETE FROM t_predpoved_import;
EXECUTE format('COPY t_predpoved_import FROM %L WITH DELIMITER '
					|| quote_literal(',') || ';', subor);
---------------------------------------------------------------------------
INSERT INTO t_predpoved (lokalita, datum, cas, gho, oblacnost, teplota,
	vietor, vlhkost, tlak)
	(SELECT lokalita_id lokalita, to_date(datum, 'DD-MM-YYYY') datum,
    		to_timestamp(datum || ' ' || cas, 'DD-MM-YYYY HH24:MI') cas,
    		gho, oblacnost, teplota, vietor, vlhkost, tlak
		FROM t_predpoved_import);
---------------------------------------------------------------------------
DELETE FROM t_predpoved_import;
RETURN 1;
END;
$$
LANGUAGE plpgsql