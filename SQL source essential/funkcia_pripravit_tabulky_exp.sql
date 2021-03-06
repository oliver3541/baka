CREATE OR REPLACE FUNCTION pripravit_tabulky_experimenty()
RETURNS integer AS
$$
BEGIN
------------------------------------
DROP TABLE IF EXISTS t_experiment;
------------------------------------
CREATE TABLE t_experiment (
	id				serial		PRIMARY KEY,
    cas_behu		timestamp,
    metoda			text,
    param1			text,
    param2			text,
    param3			text,
    param4			text,
    param5			text,
    N				smallint,
    MBE				real DEFAULT 99999,
    RMBE			real DEFAULT 99999,
    RMSE			real DEFAULT 99999,
    RRMSE			real DEFAULT 99999,
    MAE				real DEFAULT 99999,
    RMAE			real DEFAULT 99999,
    MPE 			real DEFAULT 99999,
    MAXAE			real DEFAULT 99999,
    SD				real DEFAULT 99999,
    tm_velkost		smallint, --priemerna velkost, ak sa berie podla podobnosti
    tm_select		text,
    tm_opis			text,
    fve				text,
	den_hod			varchar(3),
    pod_gho			real DEFAULT 0,
    pod_oblacnost	real DEFAULT 0,
    pod_teplota		real DEFAULT 0,
    pod_vietor		real DEFAULT 0,
    pod_vlhkost		real DEFAULT 0,
    pod_tlak		real DEFAULT 0,
    pod_dlzkadna	real DEFAULT 0,
    pod_azim		real DEFAULT 0,
    pod_elev		real DEFAULT 0,
    in_gho			boolean DEFAULT FALSE,
    in_oblacnost	boolean DEFAULT FALSE,
    in_teplota 		boolean DEFAULT FALSE,
    in_vietor		boolean DEFAULT FALSE,
    in_vlhkost		boolean DEFAULT FALSE,
    in_tlak			boolean DEFAULT FALSE,
    in_dlzkadna		boolean DEFAULT FALSE,
    in_azim			boolean DEFAULT FALSE,
    in_elev			boolean DEFAULT FALSE
);
------------------------------------
CREATE RULE t_exp_del_protect AS ON DELETE TO t_experiment DO INSTEAD NOTHING;
------------------------------------
RETURN 1;
END;
$$
LANGUAGE plpgsql