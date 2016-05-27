CREATE OR REPLACE VIEW v_data AS
	SELECT datum, cas, gho, oblacnost, teplota, vietor, vlhkost, tlak, praca,
		fve, fve_nazov, ins_vykon, dlzkadna, azim, elev
    FROM (
    	 SELECT   lag(t1.datum) over (ORDER BY t2.fve, t1.datum, t1.cas) as prev_date,
                  lead(t1.datum) over (ORDER BY t2.fve, t1.datum, t1.cas) as next_date,
                  t1.datum,
                  t1.cas,
                  t1.gho,
                  t1.oblacnost,
                  t1.teplota,
                  t1.vietor,
                  t1.vlhkost,
                  t1.tlak,
                  t2.praca,
                  t2.fve,
                  t3.nazov fve_nazov,
                  round(t3.instalovany_vykon * 1000) ins_vykon,
                  t4.dlzkadna,
                  t5.azim,
                  t5.elev
          FROM	t_predpoved t1,
                  t_produkcia t2,
                  t_fve t3,
                  t_solar_den t4,
                  t_solar_hod t5
          WHERE	t1.id = t2.predpoved
                  AND t2.fve = t3.id
                  AND t1.datum = t4.datum
                  AND t2.cas = t5.cas
                  AND t1.gho > 120
          ORDER BY t2.fve, t1.datum, t1.cas) s1
	WHERE prev_date = next_date;

CREATE OR REPLACE VIEW v_data_VZ_120 AS
	SELECT * FROM (
        SELECT datum, cas, gho, oblacnost, teplota, vietor, vlhkost, tlak, praca,
            fve, fve_nazov, ins_vykon, dlzkadna, azim, elev
        FROM (
             SELECT   lag(t1.datum) over (ORDER BY t2.fve, t1.datum, t1.cas) as prev_date,
                      lead(t1.datum) over (ORDER BY t2.fve, t1.datum, t1.cas) as next_date,
                      t1.datum,
                      t1.cas,
                      t1.gho,
                      t1.oblacnost,
                      t1.teplota,
                      t1.vietor,
                      t1.vlhkost,
                      t1.tlak,
                      t2.praca,
                      t2.fve,
                      t3.nazov fve_nazov,
                      round(t3.instalovany_vykon * 1000) ins_vykon,
                      t4.dlzkadna,
                      t5.azim,
                      t5.elev
              FROM	t_predpoved t1,
                      t_produkcia t2,
                      t_fve t3,
                      t_solar_den t4,
                      t_solar_hod t5
              WHERE	t1.id = t2.predpoved
                      AND t2.fve = t3.id
                      AND t1.datum = t4.datum
                      AND t2.cas = t5.cas
              ORDER BY t2.fve, t1.datum, t1.cas) s1
        WHERE prev_date = next_date
    ) s2 WHERE gho > 120;

CREATE OR REPLACE VIEW v_data_VZ AS
	SELECT datum, cas, gho, oblacnost, teplota, vietor, vlhkost, tlak, praca,
		fve, fve_nazov, ins_vykon, dlzkadna, azim, elev
    FROM (
    	 SELECT   lag(t1.datum) over (ORDER BY t2.fve, t1.datum, t1.cas) as prev_date,
                  lead(t1.datum) over (ORDER BY t2.fve, t1.datum, t1.cas) as next_date,
                  t1.datum,
                  t1.cas,
                  t1.gho,
                  t1.oblacnost,
                  t1.teplota,
                  t1.vietor,
                  t1.vlhkost,
                  t1.tlak,
                  t2.praca,
                  t2.fve,
                  t3.nazov fve_nazov,
                  round(t3.instalovany_vykon * 1000) ins_vykon,
                  t4.dlzkadna,
                  t5.azim,
                  t5.elev
          FROM	t_predpoved t1,
                  t_produkcia t2,
                  t_fve t3,
                  t_solar_den t4,
                  t_solar_hod t5
          WHERE	t1.id = t2.predpoved
                  AND t2.fve = t3.id
                  AND t1.datum = t4.datum
                  AND t2.cas = t5.cas
          ORDER BY t2.fve, t1.datum, t1.cas) s1
	WHERE prev_date = next_date;

CREATE OR REPLACE VIEW v_data_120 AS
	SELECT 	t1.datum,
    		t1.cas,
            t1.gho,
            t1.oblacnost,
            t1.teplota,
            t1.vietor,
            t1.vlhkost,
            t1.tlak,
            t2.praca,
            t2.fve,
            t3.nazov fve_nazov,
            t3.instalovany_vykon * 1000 ins_vykon,
            t4.dlzkadna,
            t5.azim,
            t5.elev
    FROM	t_predpoved t1,
    		t_produkcia t2,
            t_fve t3,
            t_solar_den t4,
            t_solar_hod t5
    WHERE	t1.id = t2.predpoved
    		AND t2.fve = t3.id
            AND t1.datum = t4.datum
            AND t2.cas = t5.cas
            AND t1.gho > 120
    ORDER BY t2.fve, t1.datum;

CREATE OR REPLACE VIEW v_data_all AS
	SELECT 	t1.datum,
    		t1.cas,
            t1.gho,
            t1.oblacnost,
            t1.teplota,
            t1.vietor,
            t1.vlhkost,
            t1.tlak,
            t2.praca,
            t2.fve,
            t3.nazov fve_nazov,
            t3.instalovany_vykon * 1000 ins_vykon,
            t4.dlzkadna,
            t5.azim,
            t5.elev
    FROM	t_predpoved t1,
    		t_produkcia t2,
            t_fve t3,
            t_solar_den t4,
            t_solar_hod t5
    WHERE	t1.id = t2.predpoved
    		AND t2.fve = t3.id
            AND t1.datum = t4.datum
            AND t2.cas = t5.cas
    ORDER BY t2.fve, t1.datum;