/*!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.6.18-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: 0.0.0.0    Database: eshop
-- ------------------------------------------------------
-- Server version	10.6.18-MariaDB-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `faktura`
--

DROP TABLE IF EXISTS `faktura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faktura` (
  `faktura_id` int(11) NOT NULL AUTO_INCREMENT,
  `ordernummer` int(11) NOT NULL,
  `totala_priset` int(11) DEFAULT NULL,
  PRIMARY KEY (`faktura_id`),
  KEY `ordernummer` (`ordernummer`),
  CONSTRAINT `faktura_ibfk_1` FOREIGN KEY (`ordernummer`) REFERENCES `order` (`ordernummer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faktura`
--

LOCK TABLES `faktura` WRITE;
/*!40000 ALTER TABLE `faktura` DISABLE KEYS */;
/*!40000 ALTER TABLE `faktura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategori`
--

DROP TABLE IF EXISTS `kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kategori` (
  `kategori_id` int(11) NOT NULL AUTO_INCREMENT,
  `namn` varchar(120) NOT NULL,
  PRIMARY KEY (`kategori_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategori`
--

LOCK TABLES `kategori` WRITE;
/*!40000 ALTER TABLE `kategori` DISABLE KEYS */;
INSERT INTO `kategori` VALUES (1,'Kläder'),(2,'Accessoarer'),(3,'Skor'),(4,'Väskor'),(5,'Outdoor');
/*!40000 ALTER TABLE `kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kund`
--

DROP TABLE IF EXISTS `kund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kund` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namn` varchar(120) NOT NULL,
  `epost` varchar(120) DEFAULT NULL,
  `telefonnummer` varchar(20) DEFAULT NULL,
  `adress` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kund`
--

LOCK TABLES `kund` WRITE;
/*!40000 ALTER TABLE `kund` DISABLE KEYS */;
INSERT INTO `kund` VALUES (1,'Anna Andersson','anna@example.com','0701234567','Gatan 1'),(2,'Erik Svensson','erik@example.com','0709876543','Vägen 2'),(3,'Sara Nilsson','sara@example.com','0731122334','Stigen 3'),(4,'Johan Larsson','johan@example.com','0723344556','Backen 4'),(5,'Maria Karlsson','maria@example.com','0705566778','Torggatan 5'),(6,'Oskar Berg','oskar@example.com','0765566123','Parkvägen 6');
/*!40000 ALTER TABLE `kund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lager`
--

DROP TABLE IF EXISTS `lager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lager` (
  `hylla_nummer` int(11) NOT NULL AUTO_INCREMENT,
  `namn` varchar(50) NOT NULL,
  PRIMARY KEY (`hylla_nummer`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lager`
--

LOCK TABLES `lager` WRITE;
/*!40000 ALTER TABLE `lager` DISABLE KEYS */;
INSERT INTO `lager` VALUES (1,'Hylla A'),(2,'Hylla B'),(3,'Hylla C'),(4,'Hylla D'),(5,'Hylla E');
/*!40000 ALTER TABLE `lager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lager2plocklista`
--

DROP TABLE IF EXISTS `lager2plocklista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lager2plocklista` (
  `plocklista_id` int(11) NOT NULL,
  `lager_id` int(11) NOT NULL,
  PRIMARY KEY (`plocklista_id`,`lager_id`),
  KEY `lager_id` (`lager_id`),
  CONSTRAINT `lager2plocklista_ibfk_1` FOREIGN KEY (`lager_id`) REFERENCES `lager` (`hylla_nummer`),
  CONSTRAINT `lager2plocklista_ibfk_2` FOREIGN KEY (`plocklista_id`) REFERENCES `plocklista` (`plocklista_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lager2plocklista`
--

LOCK TABLES `lager2plocklista` WRITE;
/*!40000 ALTER TABLE `lager2plocklista` DISABLE KEYS */;
INSERT INTO `lager2plocklista` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `lager2plocklista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lager2produkt`
--

DROP TABLE IF EXISTS `lager2produkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lager2produkt` (
  `lager_id` int(11) NOT NULL,
  `produkt_id` int(11) NOT NULL,
  `antal` int(11) DEFAULT NULL,
  PRIMARY KEY (`lager_id`,`produkt_id`),
  KEY `index_lager2produkt_produkt_id` (`produkt_id`),
  CONSTRAINT `lager2produkt_ibfk_1` FOREIGN KEY (`lager_id`) REFERENCES `lager` (`hylla_nummer`),
  CONSTRAINT `lager2produkt_ibfk_2` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`produktkod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lager2produkt`
--

LOCK TABLES `lager2produkt` WRITE;
/*!40000 ALTER TABLE `lager2produkt` DISABLE KEYS */;
INSERT INTO `lager2produkt` VALUES (1,1,20),(1,2,10),(2,3,15),(2,4,25),(3,5,12),(4,6,30);
/*!40000 ALTER TABLE `lager2produkt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logg`
--

DROP TABLE IF EXISTS `logg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logg` (
  `logg_id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` datetime NOT NULL DEFAULT current_timestamp(),
  `händelse` text NOT NULL,
  PRIMARY KEY (`logg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logg`
--

LOCK TABLES `logg` WRITE;
/*!40000 ALTER TABLE `logg` DISABLE KEYS */;
INSERT INTO `logg` VALUES (1,'2025-03-27 01:12:21','Ny produkt lades till med produktkod \'1\'.'),(2,'2025-03-27 01:12:21','Ny produkt lades till med produktkod \'2\'.'),(3,'2025-03-27 01:12:21','Ny produkt lades till med produktkod \'3\'.'),(4,'2025-03-27 01:12:21','Ny produkt lades till med produktkod \'4\'.'),(5,'2025-03-27 01:12:21','Ny produkt lades till med produktkod \'5\'.'),(6,'2025-03-27 01:12:21','Ny produkt lades till med produktkod \'6\'.');
/*!40000 ALTER TABLE `logg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `ordernummer` int(11) NOT NULL AUTO_INCREMENT,
  `kund_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `ordered_at` timestamp NULL DEFAULT NULL,
  `shipped_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ordernummer`),
  KEY `index_order_kund_id` (`kund_id`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`kund_id`) REFERENCES `kund` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,1,'2025-03-27 00:12:21',NULL,NULL,NULL,NULL),(2,1,'2025-03-27 00:12:21','2025-03-27 00:12:21',NULL,NULL,NULL),(3,2,'2025-03-27 00:12:21','2025-03-27 00:12:21',NULL,'2025-03-27 00:12:21',NULL),(4,2,'2025-03-27 00:12:21','2025-03-27 00:12:21',NULL,'2025-03-25 00:12:21','2025-03-27 00:12:21'),(5,1,'2025-03-27 00:12:21','2025-03-27 00:12:21','2025-03-27 00:12:21',NULL,NULL);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_row`
--

DROP TABLE IF EXISTS `order_row`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_row` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `produkt_id` int(11) NOT NULL,
  `antal` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `produkt_id` (`produkt_id`),
  CONSTRAINT `order_row_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`ordernummer`),
  CONSTRAINT `order_row_ibfk_2` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`produktkod`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_row`
--

LOCK TABLES `order_row` WRITE;
/*!40000 ALTER TABLE `order_row` DISABLE KEYS */;
INSERT INTO `order_row` VALUES (1,1,1,2),(2,2,2,3),(3,3,3,1),(4,4,4,5),(5,5,5,1);
/*!40000 ALTER TABLE `order_row` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plocklista`
--

DROP TABLE IF EXISTS `plocklista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plocklista` (
  `plocklista_id` int(11) NOT NULL AUTO_INCREMENT,
  `ordernummer` int(11) NOT NULL,
  `hylla_nummer` int(11) NOT NULL,
  PRIMARY KEY (`plocklista_id`),
  KEY `hylla_nummer` (`hylla_nummer`),
  CONSTRAINT `plocklista_ibfk_1` FOREIGN KEY (`hylla_nummer`) REFERENCES `lager` (`hylla_nummer`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plocklista`
--

LOCK TABLES `plocklista` WRITE;
/*!40000 ALTER TABLE `plocklista` DISABLE KEYS */;
INSERT INTO `plocklista` VALUES (1,1,1),(2,3,2);
/*!40000 ALTER TABLE `plocklista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produkt`
--

DROP TABLE IF EXISTS `produkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt` (
  `produktkod` int(11) NOT NULL AUTO_INCREMENT,
  `namn` varchar(120) NOT NULL,
  `beskrivning` text DEFAULT NULL,
  `pris` int(11) DEFAULT NULL,
  PRIMARY KEY (`produktkod`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt`
--

LOCK TABLES `produkt` WRITE;
/*!40000 ALTER TABLE `produkt` DISABLE KEYS */;
INSERT INTO `produkt` VALUES (1,'T-shirt','Vit bomulls T-shirt',199),(2,'Jeans','Blå jeans slim fit',599),(3,'Sneakers','Vita sneakers i skinn',899),(4,'Keps','Svart keps med tryck',149),(5,'Ryggsäck','Grå ryggsäck 25L',399),(6,'Solglasögon','Svarta solglasögon',249);
/*!40000 ALTER TABLE `produkt` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`127.0.0.1`*/ /*!50003 TRIGGER logg_insert_produkt
AFTER INSERT ON produkt
FOR EACH ROW
BEGIN
    INSERT INTO logg (händelse)
    VALUES (CONCAT("Ny produkt lades till med produktkod '", NEW.produktkod, "'."));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`127.0.0.1`*/ /*!50003 TRIGGER logg_update_produkt
AFTER UPDATE ON produkt
FOR EACH ROW
BEGIN
    INSERT INTO logg (händelse)
    VALUES (CONCAT("Detaljer om produktkod '", NEW.produktkod, "' uppdaterades."));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`127.0.0.1`*/ /*!50003 TRIGGER logg_delete_produkt
AFTER DELETE ON produkt
FOR EACH ROW
BEGIN
    INSERT INTO logg (händelse)
    VALUES (CONCAT("Produkten med produktkod '", OLD.produktkod, "' raderades."));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `produkt2kategori`
--

DROP TABLE IF EXISTS `produkt2kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt2kategori` (
  `produkt_id` int(11) NOT NULL,
  `kategori_id` int(11) NOT NULL,
  PRIMARY KEY (`produkt_id`,`kategori_id`),
  KEY `kategori_id` (`kategori_id`),
  CONSTRAINT `produkt2kategori_ibfk_1` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`produktkod`),
  CONSTRAINT `produkt2kategori_ibfk_2` FOREIGN KEY (`kategori_id`) REFERENCES `kategori` (`kategori_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt2kategori`
--

LOCK TABLES `produkt2kategori` WRITE;
/*!40000 ALTER TABLE `produkt2kategori` DISABLE KEYS */;
INSERT INTO `produkt2kategori` VALUES (1,1),(1,5),(2,1),(3,3),(3,5),(4,1),(4,2),(5,4),(5,5),(6,2);
/*!40000 ALTER TABLE `produkt2kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'eshop'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `order_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` FUNCTION `order_status`(created TIMESTAMP,
    updated TIMESTAMP,
    deleted TIMESTAMP,
    ordered TIMESTAMP,
    shipped TIMESTAMP
) RETURNS varchar(20) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_inventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `add_inventory`(
    IN prod_id INT,
    IN shelf_id INT,
    IN amount INT
)
BEGIN
    INSERT INTO lager2produkt (lager_id, produkt_id, antal)
    VALUES (shelf_id, prod_id, amount)
    ON DUPLICATE KEY UPDATE antal = antal + VALUES(antal);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_order_row` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `add_order_row`(
    IN p_order_id INT,
    IN p_produkt_id INT,
    IN p_antal INT
)
BEGIN
    INSERT INTO order_row (order_id, produkt_id, antal)
    VALUES (p_order_id, p_produkt_id, p_antal);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `add_product`(
    IN prod_name VARCHAR(120),
    IN prod_beskrivning TEXT,
    IN prod_pris INTEGER
)
BEGIN
    INSERT INTO produkt (namn, beskrivning, pris)
    VALUES (prod_name, prod_beskrivning, prod_pris);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `check_stock`(
    IN prod_id INT,
    OUT current_stock INT
)
BEGIN
    SELECT IFNULL(SUM(antal), 0)
    INTO current_stock
    FROM lager2produkt
    WHERE produkt_id = prod_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `confirm_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `confirm_order`(
    IN p_order_id INT
)
BEGIN
    update `order`
    SET ordered_at = NOW()
    WHERE ordernummer = p_order_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `create_order`(
    IN p_kund_id INT
)
BEGIN
    INSERT INTO `order` (kund_id)
    VALUES (p_kund_id);
    SELECT LAST_INSERT_ID() AS order_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `delete_product`(IN prod_id INT)
BEGIN 
    DELETE FROM produkt2kategori WHERE produkt_id = prod_id;
    DELETE FROM order_row WHERE produkt_id = prod_id;
    DELETE FROM lager2produkt WHERE produkt_id = prod_id;
    DELETE FROM produkt WHERE produktkod = prod_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_categories` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `get_all_categories`()
BEGIN
    SELECT kategori_id, namn
    FROM kategori;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_customers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `get_all_customers`()
BEGIN
    SELECT id, namn, adress, telefonnummer FROM kund;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `get_all_orders`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_products` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `get_all_products`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_shelves` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `get_all_shelves`()
BEGIN
    SELECT hylla_nummer, namn FROM lager;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_inventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `get_inventory`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_inventory_filtered` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `get_inventory_filtered`(IN filter_str VARCHAR(255))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `get_log`(IN antal INT)
BEGIN
    SELECT * FROM logg
    ORDER BY tid DESC
    LIMIT antal;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_order_rows` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `get_order_rows`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_picklist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `get_picklist`(IN p_order_id INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `get_product`(IN prod_id INT)
BEGIN
    SELECT p.*, k2.kategori_id
    FROM produkt AS p

    LEFT JOIN produkt2kategori AS k2 ON p.produktkod = k2.produkt_id
    LEFT JOIN kategori AS k ON k2.kategori_id = k.kategori_id
    WHERE p.produktkod = prod_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_inventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `remove_inventory`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ship_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `ship_order`(IN p_order_id INT)
BEGIN 
    UPDATE `order`
    SET shipped_at = NOW()
    WHERE ordernummer = p_order_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`127.0.0.1` PROCEDURE `update_product`(
    IN prod_id INT,
    IN prod_name VARCHAR(120),
    IN prod_beskrivning TEXT,
    IN prod_pris INTEGER
)
BEGIN
    UPDATE produkt
    SET namn = prod_name, beskrivning = prod_beskrivning, pris = prod_pris
    WHERE produktkod = prod_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-27  1:12:59
