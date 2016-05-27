

select id, cas_behu, metoda, fve, param1, param2, param3, param4, param5, n, rmse, rrmse, mae, RMAE, SD, pod_elev, pod_gho, pod_oblacnost, pod_teplota, pod_vietor, pod_dlzkadna, pod_vlhkost, pod_elev
from t_experiment
where metoda = 'stats_hod'
and cas_behu >= to_timestamp('09.05.2016 11:00', 'DD.MM.YYYY HH24:MI')
order by cas_behu desc

select id, cas_behu, metoda, fve, param1, param2, param3, param4, param5, n, rmse, rrmse, mae, RMAE, SD, pod_elev, pod_gho, pod_oblacnost, pod_teplota, pod_vietor, pod_dlzkadna, pod_vlhkost, pod_elev
from t_experiment
where metoda = 'stats_den'
and cas_behu >= to_timestamp('09.05.2016 11:00', 'DD.MM.YYYY HH24:MI')
order by cas_behu desc



select count(*) as ccc from (select distinct * from (select cas, fve from v_data
                             where to_date(to_char(datum, 'DD.MM.YYYY'), 'DD.MM.2000') <= to_date('20.3.2000', 'DD.MM.2000')
                             or to_date(to_char(datum, 'DD.MM.YYYY'), 'DD.MM.2000') > to_date('23.9.2000', 'DD.MM.2000')
  ) s1) s2

SELECT datum, cas, praca, gho, oblacnost,
teplota, vietor, vlhkost, dlzkadna, elev
FROM v_data WHERE fve = 1
and (to_date(to_char(datum, 'DD.MM.YYYY'), 'DD.MM.2000') <= to_date('20.3.2000', 'DD.MM.2000')
                             or to_date(to_char(datum, 'DD.MM.YYYY'), 'DD.MM.2000') > to_date('23.9.2000', 'DD.MM.2000'))
ORDER BY cas

SELECT fve, datum, cas, gho, oblacnost,
                                      teplota, vietor, vlhkost, dlzkadna, elev, praca
                                      FROM v_data
                                      WHERE to_date(to_char(datum, 'DD.MM.YYYY'), 'DD.MM.2000') <= to_date('20.3.2000', 'DD.MM.2000')
                             or to_date(to_char(datum, 'DD.MM.YYYY'), 'DD.MM.2000') > to_date('23.9.2000', 'DD.MM.2000')
                                      ORDER BY fve, cas

select sum(praca) praca dni
select count(*) dni from (
select distinct fve, datum from v_data_all
where to_date(to_char(datum, 'DD.MM.YYYY'), 'DD.MM.2000') <= to_date('20.3.2000', 'DD.MM.2000')
                             or to_date(to_char(datum, 'DD.MM.YYYY'), 'DD.MM.2000') > to_date('23.9.2000', 'DD.MM.2000')
) s1

select sum(praca) praca
from v_data_all
where to_date(to_char(datum, 'DD.MM.YYYY'), 'DD.MM.2000') > to_date('20.3.2000', 'DD.MM.2000')
                             and to_date(to_char(datum, 'DD.MM.YYYY'), 'DD.MM.2000') <= to_date('23.9.2000', 'DD.MM.2000')
) s1




SELECT datum, sum(praca) praca, sum(gho) gho, sum(100-oblacnost) oblacnost,
    sum(teplota) teplota, sum(vietor) vietor, max(dlzkadna) dlzkadna
    FROM v_data WHERE fve = 2 GROUP BY datum ORDER BY datum

select * from
(select * FROM
(SELECT MBE, RMBE, RMSE, RRMSE, MAE, RMAE, MPE, MAXAE, SD, pod_gho, pod_oblacnost, pod_teplota, pod_vietor, pod_dlzkadna,
row_number() OVER (ORDER BY RMSE) AS rmsei,
		row_number() OVER (ORDER BY RRMSE) AS rrmsei,
        row_number() OVER (ORDER BY MAE) AS maei,
        row_number() OVER (ORDER BY RMAE) AS rmaei,
        row_number() OVER (ORDER BY MAXAE) AS maxaei,
        row_number() OVER (ORDER BY SD) AS sdi
FROM t_experiment
where to_char(cas_behu, 'DD.MM.YYYY HH24:MI') = '28.03.2016 23:18') s1
order by (rmsei + rrmsei + maei + rmaei + maxaei + sdi)) s1)

(select (rrmsei + rmaei + mpei) poradie2 FROM(
SELECT MBE, RMBE, RMSE, RRMSE, MAE, RMAE, MPE, MAXAE, SD, pod_gho, pod_oblacnost, pod_teplota, pod_vietor, pod_dlzkadna,
		row_number() OVER (ORDER BY RRMSE) AS rrmsei,
        row_number() OVER (ORDER BY RMAE) AS rmaei,
        row_number() OVER (ORDER BY MPE) AS mpei
FROM t_experiment
where (to_char(cas_behu, 'DD.MM.YYYY HH24:MI') = '27.03.2016 17:54' or
to_char(cas_behu, 'DD.MM.YYYY HH24:MI') = '28.03.2016 00:14') and rrmse < 20.41 and rmae < 15.82) s2),

(select (rmsei + rrmsei + maei + rmaei + sdi) poradie3 FROM(
SELECT MBE, RMBE, RMSE, RRMSE, MAE, RMAE, MPE, MAXAE, SD, pod_gho, pod_oblacnost, pod_teplota, pod_vietor, pod_dlzkadna,
row_number() OVER (ORDER BY RMSE) AS rmsei,
		row_number() OVER (ORDER BY RRMSE) AS rrmsei,
        row_number() OVER (ORDER BY MAE) AS maei,
        row_number() OVER (ORDER BY RMAE) AS rmaei,
        row_number() OVER (ORDER BY SD) AS sdi
FROM t_experiment
where (to_char(cas_behu, 'DD.MM.YYYY HH24:MI') = '27.03.2016 17:54' or
to_char(cas_behu, 'DD.MM.YYYY HH24:MI') = '28.03.2016 00:14') and rrmse < 20.41 and rmae < 15.82) s3)
)