 2016-03-28 23:18:45
 2016-03-29 09:47:06
 2016-03-29 10:05:02
 2016-03-29 15:26:44
 2016-03-29 20:50:00
 2016-03-29 21:08:41
 2016-04-09 20:48:32


select id, cas_behu, fve, n, rrmse, RMAE, SD, pod_gho, pod_oblacnost, pod_teplota, pod_vietor, pod_dlzkadna
from t_experiment
where cas_behu >= to_date('09.04.2016 20:48', 'DD.MM.YYYY HH24:MI')
order by cas_behu desc

select id, cas_behu, fve, rmse, RRmse, RMAE, MPE, MAXAE, SD, pod_gho, pod_oblacnost, pod_teplota, pod_vietor, pod_dlzkadna
from t_experiment
where (to_char(cas_behu, 'DD.MM.YYYY HH24:MI') = '29.03.2016 20:50'
or
to_char(cas_behu, 'DD.MM.YYYY HH24:MI') = '29.03.2016 21:08')

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