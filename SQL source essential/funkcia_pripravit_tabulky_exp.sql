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
    in_gho			boolean DEFAULT FALSE,
    in_teplota 		boolean DEFAULT FALSE,
    in_vietor		boolean DEFAULT FALSE,
    in_oblacnost	boolean DEFAULT FALSE,
    in_vlhkost		boolean DEFAULT FALSE,
    in_tlak			boolean DEFAULT FALSE,
    in_azim			boolean DEFAULT FALSE,
    in_zen			boolean DEFAULT FALSE,
    in_elev			boolean DEFAULT FALSE,
    in_dlzkadna		boolean DEFAULT FALSE,
    den_hod			varchar(3),
    fve				text,
    tren_mnoz			text,
    tren_mnoz_velkost	smallint, --priemerna velkost, ak sa berie percento naj
    tren_mnoz_select	text,
    tren_mnoz_opis		text,
    podobnost			text,
    neural				boolean DEFAULT FALSE,
    neural_layers 		text,
    neural_threshold 	text,
    neural_algorithm 	text,
    neural_startweights	text,
    forest				boolean DEFAULT FALSE,
    forest_ntree		smallint, --Number of trees to grow.
    forest_mtry			smallint, --Number of variables randomly sampled as candidates at each split.
    N		smallint,
    MBE		varchar(20),
    RMBE	varchar(20),
    RMSE	varchar(20),
    RRMSE	varchar(20),
    MAE		varchar(20),
    RMAE	varchar(20),
    MPE 	varchar(20),
    MAXAE	varchar(20),
    SD		varchar(20)
);
------------------------------------
RETURN 1;
END;
$$
LANGUAGE plpgsql