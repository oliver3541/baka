CREATE OR REPLACE FUNCTION pripravit_tabulky_zaklad()
RETURNS integer AS
$$
BEGIN
---------------------------------------------------------------------------
DROP VIEW IF EXISTS v_data;
DROP VIEW IF EXISTS v_data_vz_120;
DROP VIEW IF EXISTS v_data_vz;
DROP VIEW IF EXISTS v_data_120;
DROP VIEW IF EXISTS v_data_all;
DROP TABLE IF EXISTS t_produkcia;
DROP TABLE IF EXISTS t_fve;
DROP TABLE IF EXISTS t_predpoved;
DROP TABLE IF EXISTS t_lokalita;
DROP TABLE IF EXISTS t_solar_hod;
DROP TABLE IF EXISTS t_solar_den;
---------------------------------------------------------------------------
CREATE TABLE t_lokalita (
	id	serial 		PRIMARY KEY,
	nazov	varchar(20) 	NOT NULL
);
INSERT INTO t_lokalita VALUES
	(DEFAULT, '1'),
	(DEFAULT, '3');
CREATE TABLE t_fve (
	id 			serial		PRIMARY KEY,
	lokalita		integer		REFERENCES t_lokalita,
	nazov			varchar(20) 	NOT NULL,
	instalovany_vykon	real,
	rocny_predpoklad	real
);
INSERT INTO t_fve (nazov, instalovany_vykon, rocny_predpoklad, lokalita) VALUES
	('FVE 1', 0.850, 901.641, (SELECT id FROM t_lokalita WHERE nazov = '1') ),
	('FVE 2', 0.850, 901.641, (SELECT id FROM t_lokalita WHERE nazov = '1') ),
	('FVE 3', 0.984, 1150, (SELECT id FROM t_lokalita WHERE nazov = '3') );
CREATE TABLE t_solar_hod (
	id 		serial		PRIMARY KEY,
    cas		timestamp,
    azim		real,
    elev		real
);
CREATE TABLE t_solar_den (
	id		serial	PRIMARY KEY,
    datum	date,
    dlzkadna real
);
---------------------------------------------------------------------------
RETURN 1;
END;
$$
LANGUAGE plpgsql