CREATE OR REPLACE FUNCTION import_fve_csv()
RETURNS integer AS
$$
BEGIN
---------------------------------------------------------------------------
-- odstranit chybne a nepotrebne
DELETE FROM t_produkcia_import WHERE (in_fve = 'FVE Dubravy 1'
AND (in_cas like '23.7.2015%' or in_cas like '25.7.2015%'))
OR (in_fve like '%Dubravy%' AND in_cas like '29.11.2014%')
OR (in_fve = 'FVE Plesivec' AND
	(in_cas like '25.8.2014%' OR in_cas like '28.10.2015%'
    OR in_cas like '25.7.2015%' OR in_cas like '31.7.2015%'));
---------------------------------------------------------------------------
--update cas na timestamp v UTC
SET timezone='CET';
UPDATE t_produkcia_import t
	SET cas_cet = to_timestamp(t.in_cas, 'DD.MM.YYYY HH24:MI');
SET timezone='UTC';
UPDATE t_produkcia_import t
	SET cas = cas_cet at time zone 'UTC';
UPDATE t_produkcia_import t
	SET group_cas = to_timestamp(to_char(cas, 'YYYY-MM-DD HH24:00'),
    	'YYYY-MM-DD HH24:MI')
	WHERE cast(to_char(cas, 'MI') as integer) <= 30;
UPDATE t_produkcia_import t
	SET group_cas = to_timestamp(to_char(cas, 'YYYY-MM-DD HH24:00'),
    	'YYYY-MM-DD HH24:MI') + '1 hours'
	WHERE cast(to_char(cas, 'MI') as integer) > 30;
UPDATE t_produkcia_import t
	SET datum = to_date(to_char(group_cas, 'YYYY-MM-DD'), 'YYYY-MM-DD');
---------------------------------------------------------------------------
--vlozit skutocne data
INSERT INTO t_produkcia (datum, cas, praca, fve)
	(SELECT datum, cas, praca, fve FROM
		(select datum, group_cas cas, sum(in_praca) praca, in_fve,
        		(SELECT id FROM t_fve WHERE nazov = in_fve) fve
			from t_produkcia_import
			group by in_fve, datum, group_cas
			order by in_fve, datum, group_cas) s1);
---------------------------------------------------------------------------
--naparovat produkciu na predpovede
UPDATE t_produkcia t1
	SET predpoved = (select t2.id from t_predpoved t2, t_fve t3
    					where t2.cas = t1.cas and t1.fve = t3.id
                        and t3.lokalita = t2.lokalita);
---------------------------------------------------------------------------
DELETE FROM t_produkcia_import;
RETURN 1;
END;
$$
LANGUAGE plpgsql