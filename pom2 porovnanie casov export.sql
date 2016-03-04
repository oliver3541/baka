﻿select * from 
(select * from t_produkcia_import 
where (cast(to_char(cas, 'MI') as integer) % 15) != 0
UNION ALL
select * from t_produkcia_import 
where (id + 1) IN (select id from t_produkcia_import where (cast(to_char(cas, 'MI') as integer) % 15) != 0)
or (id - 1) IN (select id from t_produkcia_import where (cast(to_char(cas, 'MI') as integer) % 15) != 0)) s1
order by id

SELECT cas, vykon, produkcia_den FROM
		(select sum(vykon) vykon, (SELECT id FROM t_produkcia_den WHERE datum = to_date(to_char(cas, 'YYYY-MM-DD'), 'YYYY-MM-DD')
			and fve = (SELECT id FROM t_fve WHERE nazov = in_fve)) produkcia_den, in_fve, group_by_cas
			from t_produkcia_import
			group by in_fve, group_by_cas
			order by in_fve, group_by_cas) s1,
		(select id, to_char(cas, 'YYYY-MM-DD HH24') cas
			from t_produkcia_import) s2
	WHERE s1.id = d2.id
	
SET time zone 'UTC'
select to_timestamp('2015-02-05 23:45', 'YYYY-MM-DD HH24:MI') + '1 hours'

SELECT import_fve_csv()


select * from t_produkcia_import order by id

select * from t_produkcia_hodina order by id

select * from t_lokalita where id = 1
select * from t_fve where id = 1


select t1.cas cas_predpoved, t1.gho, t3.vykon, t3.cas cas_produkcia
from t_predpoved_hodina t1, t_predpoved_den t2, t_produkcia_hodina t3, t_produkcia_den t4
where t1.predpoved_den = t2.id
and t2.lokalita = 1
and t3.produkcia_den = t4.id
and t4.fve = 1
and t1.cas = t3.cas

COPY (select t1.cas cas_predpoved, t1.gho, t3.vykon, t3.cas cas_produkcia
from t_predpoved_hodina t1, t_predpoved_den t2, t_produkcia_hodina t3, t_produkcia_den t4
where t1.predpoved_den = t2.id
and t2.lokalita = 1
and t3.produkcia_den = t4.id
and t4.fve = 1
and t1.cas = t3.cas)
TO 'C:\000\data_export.csv' WITH DELIMITER AS ';'
