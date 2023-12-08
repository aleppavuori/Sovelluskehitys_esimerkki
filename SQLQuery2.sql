CREATE TABLE tuotetiedot (id INTEGER IDENTITY(1,1) PRIMARY KEY, tuotenimi TEXT, tuotehinta INTEGER);

CREATE TABLE asiakkaat (id INTEGER IDENTITY (1,1) PRIMARY KEY, nimi VARCHAR(50), puhelinnumero VARCHAR(50));

CREATE TABLE tilaukset (id INTEGER IDENTITY (1,1) PRIMARY KEY, asiakas_id INTEGER REFERENCES asiakkaat ON DELETE CASCADE, toimitettu BIT DEFAULT 0);

CREATE TABLE tilauksen_tuotteet (id INTEGER IDENTITY(1,1) PRIMARY KEY, tilaus_id INTEGER REFERENCES tilaukset ON DELETE CASCADE, tuotetiedot_id INTEGER REFERENCES tuotetiedot ON DELETE CASCADE);

CREATE TABLE takuupalautukset (id INTEGER IDENTITY(1,1) PRIMARY KEY, asiakas_id INTEGER REFERENCES asiakkaat ON DELETE CASCADE, tilauksentuotteet_id INTEGER REFERENCES tilauksen_tuotteet ON DELETE NO ACTION, hyväksytty BIT DEFAULT 0);

INSERT INTO tuotetiedot (tuotenimi, tuotehinta) VALUES ('pömpeli', 333);

INSERT INTO tilaukset (asiakas_id) VALUES (1);

INSERT INTO asiakkaat (nimi, puhelinnumero) VALUES ('Joku Muu', '0401234667');

INSERT INTO tilauksen_tuotteet (tilaus_id, tuotetiedot_id) VALUES (1, 3);

INSERT INTO takuupalautukset (asiakas_id, tilauksentuotteet_id) VALUES (1, 2);

SELECT * FROM tilauksen_tuotteet;

SELECT * FROM asiakkaat;

SELECT * FROM tilaukset;

SELECT * FROM tuotetiedot;

SELECT * FROM takuupalautukset;

SELECT ti.id AS id, a.nimi AS asiakas, tu.nimi AS tuote, ti.toimitettu AS toimitettu  FROM tilaukset ti, asiakkaat a, tuotteet tu WHERE a.id=ti.asiakas_id AND tu.id=ti.tuote_id