CREATE OR REPLACE VIEW v_data AS
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