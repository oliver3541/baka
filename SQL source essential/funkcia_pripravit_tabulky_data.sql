CREATE OR REPLACE FUNCTION pripravit_tabulky_data()
RETURNS integer AS
$$
BEGIN
-------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS t_produkcia_import;
DROP TABLE IF EXISTS t_predpoved_import;
DROP TABLE IF EXISTS t_produkcia;
DROP TABLE IF EXISTS t_predpoved;
-------------------------------------------------------------------------------------------------------
CREATE TABLE t_predpoved (
	id			serial		PRIMARY KEY,
	lokalita	integer		REFERENCES t_lokalita,
    datum 		date,
	cas 		timestamp 	NOT NULL,
	gho			smallint,
	oblacnost	smallint,
	teplota		real,
	vietor		smallint,
	vlhkost		smallint,
	tlak		smallint
);
CREATE TABLE t_produkcia (
	id			serial		PRIMARY KEY,
    fve			integer		REFERENCES t_fve,
	predpoved	integer		REFERENCES t_predpoved,
    datum 		date,
	cas 		timestamp 	NOT NULL,
    praca		integer
);
CREATE TABLE t_produkcia_import (
	id			serial,
	in_cas		varchar(20),
    cas_cet		timestamp with time zone,
    cas			timestamp,
    group_cas	timestamp,
    datum		date,
    in_praca	integer,
    in_fve		varchar(20)
);
CREATE TABLE t_predpoved_import (
	datum		varchar(20),
	cas 		varchar(20),
	teplota		real,
	vietor		smallint,
	smer_vetra 	smallint,
	oblacnost	smallint,
	vlhkost		smallint,
	tlak		smallint,
	gho			smallint,
	nic			varchar(1)
);
-------------------------------------------------------------------------------------------------------
RETURN 1;
END;
$$
LANGUAGE plpgsql