--
-- Delete tables, in order, depending on
-- foreign key constraints.
--
DELETE FROM produkt2kategori;
DELETE FROM lager2produkt;
DELETE FROM lager2plocklista;
DELETE FROM plocklista;
DELETE FROM faktura;
DELETE FROM `order`;
DELETE FROM logg;
DELETE FROM kategori;
DELETE FROM lager;
DELETE FROM produkt;
DELETE FROM kund;


--
-- Insert into kund
--
LOAD DATA LOCAL INFILE 'customers.csv'
INTO TABLE kund
CHARACTER SET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(id, namn, epost, telefonnummer, adress)
;

--
-- Insert into produkt
--
LOAD DATA LOCAL INFILE 'products.csv'
INTO TABLE produkt
CHARACTER SET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(produktkod, namn, beskrivning, pris)
;

--
-- Insert into kategori
--
LOAD DATA LOCAL INFILE 'categories.csv'
INTO TABLE kategori
CHARACTER SET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(kategori_id, namn)
;

--
-- Insert into lager(hyllor)
--
LOAD DATA LOCAL INFILE 'shelves.csv'
INTO TABLE lager
CHARACTER SET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(hylla_nummer, namn)
;

--
-- Insert into produkt2kategori
--
INSERT INTO produkt2kategori (produkt_id, kategori_id) VALUES
(1,1),
(1,5),
(2,1),
(3,3),
(3,5),
(4,2),
(4,1),
(5,4),
(5,5),
(6,2);

--
-- Insert into lager2produkt
--
INSERT INTO lager2produkt (lager_id, produkt_id, antal) VALUES
(1,1, 20),
(1,2, 10),
(2,3, 15),
(2, 4, 25),
(3,5, 12),
(4,6, 30);


CALL create_order(1);
CALL add_order_row(1, 1, 2);

CALL create_order(1);
CALL add_order_row(2, 2, 3);
UPDATE `order` SET updated_at = NOW() WHERE ordernummer = 2;

CALL create_order(2);
CALL add_order_row(3, 3, 1);
UPDATE `order` SET ordered_at = NOW() WHERE ordernummer = 3;

CALL create_order(2);
CALL add_order_row(4, 4, 5);
UPDATE `order` SET ordered_at = NOW() - INTERVAL 2 DAY, shipped_at = NOW() WHERE ordernummer = 4;

CALL create_order(1);
CALL add_order_row(5, 5, 1);
UPDATE `order` SET deleted_at = NOW() WHERE ordernummer = 5;


INSERT INTO plocklista (ordernummer, hylla_nummer)
VALUES
(1, 1),
(3, 2);

INSERT INTO lager2plocklista (plocklista_id, lager_id)
VALUES
(1, 1),
(2, 2);