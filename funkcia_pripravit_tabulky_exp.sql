CREATE OR REPLACE FUNCTION pripravit_tabulky_experimenty()
RETURNS integer AS
$$
BEGIN
------------------------------------
DROP TABLE IF EXISTS t_vysledky_hodina;
DROP TABLE IF EXISTS t_vysledky_den;
DROP TABLE IF EXISTS t_experiment;
------------------------------------
CREATE TABLE t_experiment (
	id				serial		PRIMARY KEY,
    in_gho			boolean,
    in_teplota 		boolean,
    in_vietor		boolean,
    in_oblacnost	boolean,
    in_vlhkost		boolean,
    in_sklon		boolean,
    in_den_hod		boolean, 	-- 0 = den, 1 = hod
    tren_mnoz_s		text,		-- select
    tren_mnoz_opis	text		-- opis
    -- pridat statisticke ukazovatele
);

CREATE TABLE t_vysledky_den (
	id		serial		PRIMARY KEY,
    exp		integer		REFERENCES t_experiment	ON DELETE SET NULL,
    fve		varchar(20) NOT NULL,
    produkcia	integer
    	REFERENCES t_produkcia_den,
    predikcia	real
);

CREATE TABLE t_vysledky_hodina (
	id		serial		PRIMARY KEY,
    exp		integer		REFERENCES t_experiment	ON DELETE SET NULL,
    fve		varchar(20) NOT NULL,
    produkcia	integer
    	REFERENCES t_produkcia_hodina,
    predikcia	real
);

RETURN 1;
END;
$$
LANGUAGE plpgsql