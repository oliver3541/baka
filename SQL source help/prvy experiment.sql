delete from t_experiment where id = 7

select * from t_experiment


select datum, sum(praca) praca, sum(gho) gho, sum(teplota) teplota, sum(vietor) vietor, sum(oblacnost) oblacnost
                          from v_data where fve_nazov = 'FVE Dubravy 2' group by datum order by datum

select datum, sum(praca) praca, sum(gho) gho, sum(teplota) teplota, sum(vietor) vietor,
		sum(oblacnost) oblacnost, sum(vlhkost) vlhkost, max(dlzkadna) dlzkadna, max(elev) elev
                          from v_data where fve_nazov = 'FVE Dubravy 2' group by datum order by datum