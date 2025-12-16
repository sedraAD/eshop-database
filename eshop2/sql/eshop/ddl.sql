--
-- CREATE TABLES FOR eshop
--

USE eshop;

DROP FUNCTION IF EXISTS order_status;
DROP PROCEDURE IF EXISTS get_all_categories;
DROP PROCEDURE IF EXISTS get_all_products;
DROP PROCEDURE IF EXISTS add_product;
DROP PROCEDURE IF EXISTS get_product;
DROP PROCEDURE IF EXISTS update_product;
DROP PROCEDURE IF EXISTS delete_product;
DROP PROCEDURE If EXISTS get_log;
DROP PROCEDURE IF EXISTS get_all_shelves;
DROP PROCEDURE IF EXISTS get_inventory;
DROP PROCEDURE IF EXISTS get_inventory_filtered;
DROP PROCEDURE IF EXISTS add_inventory;
DROP PROCEDURE IF EXISTS remove_inventory;
DROP PROCEDURE IF EXISTS get_all_customers;
DROP PROCEDURE IF EXISTS create_order;
DROP PROCEDURE IF EXISTS add_order_row;
DROP PROCEDURE IF EXISTS get_order_rows;
DROP PROCEDURE IF EXISTS confirm_order;
DROP PROCEDURE IF EXISTS get_all_orders;
DROP PROCEDURE IF EXISTS check_stock;
DROP PROCEDURE IF EXISTS get_picklist;
DROP PROCEDURE IF EXISTS ship_order;

DROP TRIGGER IF EXISTS logg_insert_produkt;
DROP TRIGGER IF EXISTS logg_update_produkt;
DROP TRIGGER IF EXISTS logg_delete_produkt;

DROP TABLE IF EXISTS produkt2kategori;
DROP TABLE IF EXISTS lager2produkt;
DROP TABLE IF EXISTS lager2plocklista;
DROP TABLE IF EXISTS plocklista;
DROP TABLE IF EXISTS faktura;
DROP TABLE IF EXISTS order_row;
DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS logg;
DROP TABLE IF EXISTS kategori;
DROP TABLE IF EXISTS lager;
DROP TABLE IF EXISTS produkt;
DROP TABLE IF EXISTS kund;


CREATE TABLE kund (
    id INTEGER NOT NULL AUTO_INCREMENT,
    namn VARCHAR(120) NOT NULL, 
    epost VARCHAR(120),
    telefonnummer VARCHAR(20),
    adress VARCHAR(150),

    PRIMARY KEY(id)
);

CREATE TABLE produkt (
    produktkod INTEGER NOT NULL AUTO_INCREMENT,
    namn VARCHAR(120) NOT NULL,
    beskrivning TEXT,
    pris INTEGER,

    PRIMARY KEY(produktkod)
);

CREATE TABLE kategori (
    kategori_id INTEGER NOT NULL AUTO_INCREMENT,
    namn VARCHAR(120) NOT NULL,

    PRIMARY KEY(kategori_id)
);

CREATE TABLE `order` (
    ordernummer INTEGER NOT NULL AUTO_INCREMENT,
    kund_id INTEGER NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    ordered_at TIMESTAMP NULL,
    shipped_at TIMESTAMP NULL,

    PRIMARY KEY(ordernummer),
    FOREIGN KEY(kund_id) REFERENCES kund(id)
);

CREATE TABLE order_row(
    id INTEGER NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    produkt_id INT NOT NULL,
    antal INT NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY(order_id) REFERENCES `order`(ordernummer),
    FOREIGN KEY (produkt_id) REFERENCES produkt(produktkod)
);

CREATE TABLE faktura (
    faktura_id INTEGER NOT NULL AUTO_INCREMENT,
    ordernummer INTEGER NOT NULL,
    totala_priset INTEGER,

    PRIMARY KEY(faktura_id),
    FOREIGN KEY(ordernummer) REFERENCES `order`(ordernummer)
);

CREATE TABLE lager (
    hylla_nummer INTEGER NOT NULL AUTO_INCREMENT,
    namn VARCHAR(50) NOT NULL,

    PRIMARY KEY(hylla_nummer)
);

CREATE TABLE plocklista (
    plocklista_id INTEGER NOT NULL AUTO_INCREMENT,
    ordernummer INTEGER NOT NULL,
    hylla_nummer INTEGER NOT NULL,

    PRIMARY KEY(plocklista_id),
    FOREIGN KEY(hylla_nummer) REFERENCES lager(hylla_nummer)
);

CREATE TABLE logg (
    logg_id INTEGER NOT NULL AUTO_INCREMENT,
    tid DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    händelse TEXT NOT NULL,

    PRIMARY KEY(logg_id)
);

CREATE TABLE lager2produkt (
    lager_id INTEGER NOT NULL,
    produkt_id INTEGER NOT NULL,
    antal INTEGER,

    PRIMARY KEY(lager_id, produkt_id),
    FOREIGN KEY (lager_id) REFERENCES lager(hylla_nummer),
    FOREIGN KEY (produkt_id) REFERENCES produkt(produktkod)
);

CREATE TABLE lager2plocklista (
    plocklista_id INTEGER NOT NULL,
    lager_id INTEGER NOT NULL,

    PRIMARY KEY(plocklista_id, lager_id),
    FOREIGN KEY (lager_id) REFERENCES lager(hylla_nummer),
    FOREIGN KEY (plocklista_id) REFERENCES plocklista(plocklista_id)
);

CREATE TABLE produkt2kategori (
    produkt_id INTEGER NOT NULL,
    kategori_id INTEGER NOT NULL,

    PRIMARY KEY(produkt_id, kategori_id),
    FOREIGN KEY (produkt_id) REFERENCES produkt(produktkod),
    FOREIGN KEY (kategori_id) REFERENCES kategori(kategori_id)
);



DROP INDEX IF EXISTS _order_kund_id ON `order`;
DROP INDEX IF EXISTS index_lager2produkt_produkt_id ON lager2produkt;

CREATE INDEX index_order_kund_id ON `order`(kund_id);
CREATE INDEX index_lager2produkt_produkt_id ON lager2produkt(produkt_id);

DELIMITER ;;

CREATE TRIGGER logg_insert_produkt
AFTER INSERT ON produkt
FOR EACH ROW
BEGIN
    INSERT INTO logg (händelse)
    VALUES (CONCAT("Ny produkt lades till med produktkod '", NEW.produktkod, "'."));
END;
;;

CREATE TRIGGER logg_update_produkt
AFTER UPDATE ON produkt
FOR EACH ROW
BEGIN
    INSERT INTO logg (händelse)
    VALUES (CONCAT("Detaljer om produktkod '", NEW.produktkod, "' uppdaterades."));
END;
;;

CREATE TRIGGER logg_delete_produkt
AFTER DELETE ON produkt
FOR EACH ROW
BEGIN
    INSERT INTO logg (händelse)
    VALUES (CONCAT("Produkten med produktkod '", OLD.produktkod, "' raderades."));
END;
;;

CREATE PROCEDURE get_all_categories()
BEGIN
    SELECT kategori_id, namn
    FROM kategori;
END;
;;

CREATE PROCEDURE get_all_products()
BEGIN
    SELECT
        produkt.produktkod,
        produkt.namn,
        produkt.pris,
        IFNULL(SUM(lager2produkt.antal), 0) AS lagerantal,
        GROUP_CONCAT(kategori.namn SEPARATOR ', ') AS kategorier
    FROM produkt
    LEFT JOIN produkt2kategori ON produkt.produktkod = produkt2kategori.produkt_id
    LEFT JOIN kategori ON produkt2kategori.kategori_id = kategori.kategori_id
    LEFT JOIN lager2produkt ON produkt.produktkod = lager2produkt.produkt_id
    GROUP BY produkt.produktkod;
END;
;;

CREATE PROCEDURE add_product(
    IN prod_name VARCHAR(120),
    IN prod_beskrivning TEXT,
    IN prod_pris INTEGER
)
BEGIN
    INSERT INTO produkt (namn, beskrivning, pris)
    VALUES (prod_name, prod_beskrivning, prod_pris);
END;
;;

CREATE PROCEDURE get_product(IN prod_id INT)
BEGIN
    SELECT p.*, k2.kategori_id
    FROM produkt AS p

    LEFT JOIN produkt2kategori AS k2 ON p.produktkod = k2.produkt_id
    LEFT JOIN kategori AS k ON k2.kategori_id = k.kategori_id
    WHERE p.produktkod = prod_id;
END;
;;

CREATE PROCEDURE update_product(
    IN prod_id INT,
    IN prod_name VARCHAR(120),
    IN prod_beskrivning TEXT,
    IN prod_pris INTEGER
)
BEGIN
    UPDATE produkt
    SET namn = prod_name, beskrivning = prod_beskrivning, pris = prod_pris
    WHERE produktkod = prod_id;
END;
;;

CREATE PROCEDURE delete_product(IN prod_id INT)
BEGIN 
    DELETE FROM produkt2kategori WHERE produkt_id = prod_id;
    DELETE FROM order_row WHERE produkt_id = prod_id;
    DELETE FROM lager2produkt WHERE produkt_id = prod_id;
    DELETE FROM produkt WHERE produktkod = prod_id;
END;
;;

CREATE PROCEDURE get_log(IN antal INT)
BEGIN
    SELECT * FROM logg
    ORDER BY tid DESC
    LIMIT antal;
END;
;;

CREATE PROCEDURE get_all_shelves()
BEGIN
    SELECT hylla_nummer, namn FROM lager;
END;
;;

CREATE PROCEDURE get_inventory()
BEGIN
    SELECT
        produkt.produktkod,
        produkt.namn AS produkt_namn,
        lager.hylla_nummer AS hylla_nummer,
        lager.namn AS hylla_namn,
        lager2produkt.antal AS antal
    FROM produkt
    JOIN lager2produkt ON produkt.produktkod = lager2produkt.produkt_id
    JOIN lager ON lager2produkt.lager_id = lager.hylla_nummer;
END;
;;

CREATE PROCEDURE get_inventory_filtered(IN filter_str VARCHAR(255))
BEGIN
    SELECT
        produkt.produktkod,
        produkt.namn AS produkt_namn,
        lager.hylla_nummer AS hylla_nummer,
        lager.namn AS hylla_namn,
        lager2produkt.antal AS antal
    FROM produkt
    JOIN lager2produkt ON produkt.produktkod = lager2produkt.produkt_id
    JOIN lager ON lager2produkt.lager_id = lager.hylla_nummer
    WHERE 
        produkt.produktkod LIKE CONCAT('%', filter_str, '%') OR
        produkt.namn LIKE CONCAT('%', filter_str, '%') OR
        lager.hylla_nummer LIKE CONCAT('%', filter_str, '%');
END;
;;

CREATE PROCEDURE add_inventory(
    IN prod_id INT,
    IN shelf_id INT,
    IN amount INT
)
BEGIN
    INSERT INTO lager2produkt (lager_id, produkt_id, antal)
    VALUES (shelf_id, prod_id, amount)
    ON DUPLICATE KEY UPDATE antal = antal + VALUES(antal);
END;
;;

CREATE PROCEDURE remove_inventory(
    IN prod_id INT,
    IN shelf_id INT,
    IN amount INT
)
BEGIN
    DECLARE current_amount INT;

    SELECT antal INTO current_amount
    FROM lager2produkt
    WHERE lager_id = shelf_id AND produkt_id = prod_id;

    IF current_amount IS NOT NULL AND current_amount >= amount THEN
        UPDATE lager2produkt
        SET antal = antal - amount
        WHERE lager_id = shelf_id AND produkt_id = prod_id;
        SELECT CONCAT('Lagret för produkt ', prod_id, ' på hylla ', shelf_id, ' har minskat med ', amount, ' enheter.') AS message;
    ELSEIF current_amount IS NULL THEN
        SELECT 'Produkten finns inte på den angivna hyllan.' AS message;
    ELSE
        SELECT 'Det fnns inte tillräckligt med produkter på hyllan.' AS message;
    END IF;
END;
;;

CREATE PROCEDURE get_all_customers()
BEGIN
    SELECT id, namn, adress, telefonnummer FROM kund;
END;
;;

CREATE PROCEDURE create_order(
    IN p_kund_id INT
)
BEGIN
    INSERT INTO `order` (kund_id)
    VALUES (p_kund_id);
    SELECT LAST_INSERT_ID() AS order_id;
END;
;;

CREATE PROCEDURE add_order_row(
    IN p_order_id INT,
    IN p_produkt_id INT,
    IN p_antal INT
)
BEGIN
    INSERT INTO order_row (order_id, produkt_id, antal)
    VALUES (p_order_id, p_produkt_id, p_antal);
END;
;;

CREATE PROCEDURE check_stock(
    IN prod_id INT,
    OUT current_stock INT
)
BEGIN
    SELECT IFNULL(SUM(antal), 0)
    INTO current_stock
    FROM lager2produkt
    WHERE produkt_id = prod_id;
END;
;;

CREATE PROCEDURE get_order_rows(
    IN p_order_id INT
)
BEGIN
    SELECT
        orow.id,
        orow.antal,
        p.namn AS produkt_namn,
        p.pris
    FROM order_row AS orow
    JOIN produkt AS p ON orow.produkt_id = p.produktkod
    WHERE orow.order_id = p_order_id;
END;
;;

CREATE PROCEDURE confirm_order(
    IN p_order_id INT
)
BEGIN
    update `order`
    SET ordered_at = NOW()
    WHERE ordernummer = p_order_id;
END;
;;

CREATE PROCEDURE get_all_orders()
BEGIN
    SELECT
        o.ordernummer,
        o.kund_id,
        o.created_at,
        COUNT(orow.id) AS antal_rader,
        order_status(o.created_at, o.updated_at, o.deleted_at, o.ordered_at, o.shipped_at) AS status
    FROM `order` AS o
    LEFT JOIN order_row AS orow ON o.ordernummer = orow.order_id
    GROUP BY o.ordernummer;
END;
;;

CREATE PROCEDURE get_picklist(IN p_order_id INT)
BEGIN
    SELECT
        orow.antal,
        p.namn AS produkt_namn,
        l.lager_id AS hylla_id,
        l.antal AS lager_antal,
        hylla.namn AS hylla_namn
    FROM order_row AS orow
    JOIN produkt AS p ON orow.produkt_id = p.produktkod
    LEFT JOIN lager2produkt AS l ON orow.produkt_id = l.produkt_id AND l.antal > 0
    LEFT JOIN lager AS hylla ON l.lager_id = hylla.hylla_nummer
    WHERE orow.order_id = p_order_id
    ORDER By l.lager_id;
END;
;;

CREATE PROCEDURE ship_order(IN p_order_id INT)
BEGIN 
    UPDATE `order`
    SET shipped_at = NOW()
    WHERE ordernummer = p_order_id;
END;
;;

CREATE FUNCTION order_status(
    created TIMESTAMP,
    updated TIMESTAMP,
    deleted TIMESTAMP,
    ordered TIMESTAMP,
    shipped TIMESTAMP
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE status VARCHAR(20);

    IF deleted IS NOT NULL THEN
        SET status = 'Raderad';
    ELSEIF shipped IS NOT NULL THEN
        SET status = 'Skickad';
    ELSEIF ordered IS NOT NULL THEN
        SET status = 'Beställd';
    ELSEIF updated IS NOT NULL THEN
        SET status = 'Uppdaterad';
    ELSE 
        SET status = 'Skapad';
    END IF;

    RETURN status;
END;
;;

DELIMITER ;