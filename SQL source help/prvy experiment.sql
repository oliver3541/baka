delete from t_experiment where forest_ntree < 100

select * from t_experiment
where neural = false order by abs(cast(RRMSE as real))

select tren_mnoz_velkost, forest_ntree, forest_mtry, cast(rmbe as real) rmbe, cast(rrmse as real),
		cast((case when mpe = 'Inf' then '0' else mpe end) as real), cast(maxae as real), cast(sd as real)
from t_experiment
where to_char(cas_behu, 'YYYY-MM-DD HH:MI') = '2016-03-26 09:30'

select tren_mnoz_velkost, neural_layers, cast(rmbe as real) rmbe, cast(rrmse as real),
		cast((case when mpe = 'Inf' then '0' else mpe end) as real), cast(maxae as real), cast(sd as real)
from t_experiment
where to_char(cas_behu, 'YYYY-MM-DD HH:MI') = '2016-03-26 09:30'

select * from v_data

2016-03-27 17:54:16 -- vcerajsi 5 hodinovy
2016-03-28 00:14:51 --nocny
select * from t_experiment where to_char(cas_behu, 'DD.MM.YYYY HH24:MI') = '27.03.2016 17:54'

select min(id), max(id) from t_experiment where to_char(cas_behu, 'DD.MM.YYYY HH24:MI') = '27.03.2016 17:54'

select MBE, RMBE, RMSE, RRMSE, MAE, RMAE, MPE, MAXAE, SD, pod_gho, pod_oblacnost, pod_teplota, pod_vietor, pod_dlzkadna
from t_experiment
where (to_char(cas_behu, 'DD.MM.YYYY HH24:MI') = '27.03.2016 17:54' or
to_char(cas_behu, 'DD.MM.YYYY HH24:MI') = '28.03.2016 00:14')

SELECT row_number() OVER (ORDER BY RMSE) AS rmsei,
		row_number() OVER (ORDER BY RRMSE) AS rrmsei,
        row_number() OVER (ORDER BY MAE) AS maei,
        row_number() OVER (ORDER BY RMAE) AS rmaei,
        row_number() OVER (ORDER BY MPE) AS mpei,
        row_number() OVER (ORDER BY MAXAE) AS maxaei,
        row_number() OVER (ORDER BY SD) AS sdi


and
(param2 like '%700' or
param2 like '%600' or
param2 like '%500' or
param2 like '%800')
and
(param1 like '%120' or
param1 like '%110' or
param1 like '%100')

 and
(param3 like '%2' or
param3 like '%3' )

and
(param2 like '%700' or
param2 like '%600' or
param2 like '%500' or
param2 like '%400')
and fve = 'FVE Dubravy 2'

select param1, avg(rmse) rmse, avg(rrmse) rrmse, avg(mae) mae, avg(rmae) rmae, avg(mpe) mpe, avg(maxae) maxae, avg(sd) sd from t_experiment
where (to_char(cas_behu, 'DD.MM.YYYY HH24:MI') = '27.03.2016 15:04' or
to_char(cas_behu, 'DD.MM.YYYY HH24:MI') = '27.03.2016 17:02')
and
(param2 like '%700' or
param2 like '%600' or
param2 like '%500' or
param2 like '%800')
and
(param1 like '%120' or
param1 like '%110' or
param1 like '%100')

group by param1

UPDATE t_experiment
	SET pod_gho = -1,
    pod_oblacnost = -1,
    pod_teplota = -1,
    pod_vietor = -1,
    pod_dlzkadna = -1
    WHERE id = 961;