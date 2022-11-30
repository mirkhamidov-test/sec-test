-- MySQL dump 10.19  Distrib 10.3.28-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: dbs4oqsh.mariadb.hosting.zone    Database: dbs4oqsh
-- ------------------------------------------------------
-- Server version	10.3.28-MariaDB-deb10-keen

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
-- Table structure for table `api_apikey`
--

DROP TABLE IF EXISTS `api_apikey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_apikey` (
  `apikey_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `apikey` varchar(255) NOT NULL,
  `vertrag_id` int(10) unsigned NOT NULL,
  `zeitraum_id` int(10) unsigned NOT NULL,
  `ist_masterkey` tinyint(4) NOT NULL DEFAULT 0,
  `bearbeiter_id` int(10) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`apikey_id`),
  UNIQUE KEY `apikey` (`apikey`),
  KEY `vertrag_id` (`vertrag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_apikey`
--

LOCK TABLES `api_apikey` WRITE;
/*!40000 ALTER TABLE `api_apikey` DISABLE KEYS */;
INSERT INTO `api_apikey` VALUES (1,'99f26159eb7a50784a9006fa35a5dbe32e604fee',1,1,0,1,'2020-09-01 00:00:00'),(2,'3ae7824c75f1aef362dab353bfceee6722c1f6f9',2,1,0,1,'2020-09-01 00:00:00'),(3,'9faa37b23f350c516e3589e60083d10cd368df01',3,4,0,1,'2021-09-01 00:00:00'),(4,'8067562d7138d72501485941246cf9b229c3a46a',2,4,1,1,'2021-09-01 00:00:00');
/*!40000 ALTER TABLE `api_apikey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stamd_flagbit_ref`
--

DROP TABLE IF EXISTS `stamd_flagbit_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stamd_flagbit_ref` (
  `flagbit_ref_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `datensatz_typ_id` int(10) unsigned NOT NULL,
  `datensatz_id` int(10) unsigned NOT NULL,
  `flagbit` bigint(20) unsigned NOT NULL,
  `zeitraum_id` int(10) unsigned NOT NULL,
  `bearbeiter_id` int(10) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`flagbit_ref_id`),
  KEY `datensatz_typ_id` (`datensatz_typ_id`),
  KEY `datensatz_id` (`datensatz_id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stamd_flagbit_ref`
--

LOCK TABLES `stamd_flagbit_ref` WRITE;
/*!40000 ALTER TABLE `stamd_flagbit_ref` DISABLE KEYS */;
INSERT INTO `stamd_flagbit_ref` VALUES (100,2,1,4,1,2,'2020-10-01 12:05:00'),(101,2,2,4,2,3,'2021-03-01 14:55:54'),(102,2,3,12,2,2,'2021-09-01 13:15:58');
/*!40000 ALTER TABLE `stamd_flagbit_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stamd_nutzerdetails`
--

DROP TABLE IF EXISTS `stamd_nutzerdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stamd_nutzerdetails` (
  `nutzerdetails_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `Bearbeiter` int(10) unsigned DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`nutzerdetails_id`),
  KEY `stamd_nutzerdetails_FKIndex3` (`name`),
  KEY `stamd_nutzerdetails_FKIndex6` (`timestamp`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stamd_nutzerdetails`
--

LOCK TABLES `stamd_nutzerdetails` WRITE;
/*!40000 ALTER TABLE `stamd_nutzerdetails` DISABLE KEYS */;
INSERT INTO `stamd_nutzerdetails` VALUES (1,'Admin User',NULL,'2020-01-01 00:00:00'),(2,'Merchant A',1,'2020-09-01 00:00:00'),(3,'Merchant B',1,'2020-09-01 00:00:00'),(4,'User',1,'2021-01-01 00:00:00');
/*!40000 ALTER TABLE `stamd_nutzerdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaktion_transaktionen`
--

DROP TABLE IF EXISTS `transaktion_transaktionen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaktion_transaktionen` (
  `trans_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `produkt_id` int(11) NOT NULL,
  `vertrag_id` int(11) NOT NULL,
  `Betrag` int(10) unsigned NOT NULL,
  `beschreibung` text DEFAULT NULL,
  `waehrung_id` int(10) unsigned NOT NULL DEFAULT 1,
  `bearbeiter` int(10) unsigned NOT NULL,
  `erstelldatum` datetime DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`trans_id`),
  KEY `ix_betrag` (`Betrag`),
  KEY `ix_erstelldatum` (`erstelldatum`),
  KEY `ix_abschlussdatum_produkt_id_trans_status_id` (`produkt_id`),
  KEY `ix_produkt_id_trans_status_id_erstelldatum` (`produkt_id`,`erstelldatum`),
  KEY `ix_waehrung_id_produkt_id_trans_status_id` (`waehrung_id`,`produkt_id`),
  KEY `ix_timestamp_produkt_id` (`timestamp`,`produkt_id`),
  KEY `ix_zahler_status_id_produkt_id` (`produkt_id`),
  KEY `ix_haendler_status_id_produkt_id` (`produkt_id`),
  KEY `ix_vertrag_id_produkt_id_trans_status_id_erstelldatum` (`vertrag_id`,`produkt_id`,`erstelldatum`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaktion_transaktionen`
--

LOCK TABLES `transaktion_transaktionen` WRITE;
/*!40000 ALTER TABLE `transaktion_transaktionen` DISABLE KEYS */;
INSERT INTO `transaktion_transaktionen` VALUES (1,1,1,123,'Order #1',1,2,'2020-10-01 12:05:00','2020-10-01 12:05:00'),(2,1,2,45,'Order #2',1,3,'2021-03-01 14:55:54','2021-03-01 14:55:54'),(3,1,3,234,'Order #3',1,2,'2021-09-01 13:15:58','2021-09-01 13:15:58'),(4,1,2,23,'Order #4',1,3,'2021-09-02 00:26:44','2021-09-02 00:26:44');
/*!40000 ALTER TABLE `transaktion_transaktionen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vertragsverw_vertrag`
--

DROP TABLE IF EXISTS `vertragsverw_vertrag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vertragsverw_vertrag` (
  `vertrag_id` int(11) NOT NULL AUTO_INCREMENT,
  `zeitraum_id` int(10) unsigned NOT NULL,
  `nutzer_id` int(10) unsigned NOT NULL,
  `Bearbeiter` int(10) unsigned NOT NULL,
  PRIMARY KEY (`vertrag_id`),
  KEY `nutzer_id` (`nutzer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vertragsverw_vertrag`
--

LOCK TABLES `vertragsverw_vertrag` WRITE;
/*!40000 ALTER TABLE `vertragsverw_vertrag` DISABLE KEYS */;
INSERT INTO `vertragsverw_vertrag` VALUES (1,1,2,1),(2,2,3,1),(3,4,2,1);
/*!40000 ALTER TABLE `vertragsverw_vertrag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vorgaben_datensatz_typ`
--

DROP TABLE IF EXISTS `vorgaben_datensatz_typ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vorgaben_datensatz_typ` (
  `datensatz_typ_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `beschreibung` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`datensatz_typ_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vorgaben_datensatz_typ`
--

LOCK TABLES `vorgaben_datensatz_typ` WRITE;
/*!40000 ALTER TABLE `vorgaben_datensatz_typ` DISABLE KEYS */;
INSERT INTO `vorgaben_datensatz_typ` VALUES (1,'nutzer_id'),(2,'trans_id'),(3,'karten_id'),(4,'vertrag_id'),(5,'zahlungsmittel_id'),(6,'terminal_id'),(7,'adr_id'),(8,'hash_id'),(9,'plz_normiert_id'),(10,'branche_id'),(11,'tid_id'),(12,'mail_domain_id'),(13,'bankengruppe_id'),(14,'land_id für adr_id'),(15,'zahlungsmittelcontainer_id'),(16,'iin_id'),(17,'land_id für iin_id'),(18,'login (nutzer_id aus nutzer_logindaten)'),(19,'mail_id'),(20,'apikey_id (api_apikey)'),(21,'merchant_whitelist_id'),(22,'trans_hash_id'),(23,'name_id'),(24,'basket_item_id'),(25,'kartengruppe_id'),(26,'fall_id'),(27,'servicekontakt_id'),(28,'ean_id');
/*!40000 ALTER TABLE `vorgaben_datensatz_typ` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vorgaben_flagbit`
--

DROP TABLE IF EXISTS `vorgaben_flagbit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vorgaben_flagbit` (
  `flagbit_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `beschreibung` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`flagbit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vorgaben_flagbit`
--

LOCK TABLES `vorgaben_flagbit` WRITE;
/*!40000 ALTER TABLE `vorgaben_flagbit` DISABLE KEYS */;
INSERT INTO `vorgaben_flagbit` VALUES (1,'0 = Direkt, 1 = Accounting'),(2,'0 = keine ZG, 1 = ZG'),(3,'0 = kein 3DSecure, 1 = 3DSecure'),(4,'0 = XML, 1 = iFrame'),(5,'0 = keine Demo, 1 = Demo'),(6,'0 = keine Voraut. 1 = Voraut.'),(7,'0 = keine Rückstellung, 1 = mit Rückstellung von Auszahlung'),(8,'0 = Stakeholderumbuchung nicht ausgeführt / nicht notwendig, 1 = Stakeholderumbuchung ausgeführt'),(9,'0 = Warenkorb nicht verarbeitet, 1 = Warenkorb vollständig verarbeitet'),(10,'0 = Warenkorbposition nicht verarbeitet / nicht notwendig, 1 = Warenkorbposition verarbeitet'),(11,'1 = über Secucore erstellt'),(12,'1 = für Checkout erstellt'),(13,'0 = kein LVP, 1 = LVP'),(14,'0 = kein TRA, 1 = TRA'),(15,'0 = kein MIT, 1 = MIT');
/*!40000 ALTER TABLE `vorgaben_flagbit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vorgaben_zeitraum`
--

DROP TABLE IF EXISTS `vorgaben_zeitraum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vorgaben_zeitraum` (
  `zeitraum_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `von` datetime NOT NULL,
  `bis` datetime NOT NULL,
  PRIMARY KEY (`zeitraum_id`),
  UNIQUE KEY `von_2` (`von`,`bis`),
  KEY `von` (`von`),
  KEY `bis` (`bis`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vorgaben_zeitraum`
--

LOCK TABLES `vorgaben_zeitraum` WRITE;
/*!40000 ALTER TABLE `vorgaben_zeitraum` DISABLE KEYS */;
INSERT INTO `vorgaben_zeitraum` VALUES (1,'2020-09-01 00:00:00','2021-09-01 00:00:00'),(2,'2020-09-01 00:00:00','2030-10-01 00:00:00'),(3,'2021-06-01 00:00:00','2030-09-01 00:00:00'),(4,'2021-09-01 00:00:00','2030-10-01 00:00:00');
/*!40000 ALTER TABLE `vorgaben_zeitraum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'dbs4oqsh'
--
/*!50003 DROP PROCEDURE IF EXISTS `api_erstelle_apikey` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbs4oqsh_kms0cal`@`%` PROCEDURE `api_erstelle_apikey`(IN IN_vertrag_id INT(11),
  IN IN_bearbeiter_id INT(11),
  OUT OUT_fehler INT(11))
BEGIN

/*
#####
# Beschreibung:
#	Einen apikey für einen Vertrag erstellen
#
# OUT_fehler
# 0 - Ok
# 1 - INPUT leer
# 2 - Generierung API Key fehlgeschlagen
# 3 - es existiert bereits ein Eintrag für diese vertrag_id mit gültigem/aktuellem Zeitraum
#####
*/
DECLARE proz_max_anzahl_durchlaeufe INT DEFAULT 500;
DECLARE proz_anzahl_durchlaeufe INT DEFAULT 0;
DECLARE proz_von_datum DATETIME;
DECLARE proz_apikey VARCHAR(255);
DECLARE proz_anzahl, proz_zeitraum_id, proz_vertrag_id INT;

SELECT NOW() INTO proz_von_datum;

IF (IFNULL(IN_vertrag_id,0) <> 0 AND IFNULL(IN_bearbeiter_id,0) <> 0) THEN

	-- auf aktuellen Eintrag für den Vertrag prüfen
	SELECT vertrag_id
	INTO proz_vertrag_id
	FROM api_apikey
	INNER JOIN vorgaben_zeitraum ON vorgaben_zeitraum.zeitraum_id = api_apikey.zeitraum_id AND NOW() BETWEEN vorgaben_zeitraum.von AND vorgaben_zeitraum.bis
	WHERE vertrag_id = IN_vertrag_id LIMIT 1;

	-- prüfen ob ein aktueller Eintrag für diese vertrags_id bereits existiert
	IF IFNULL(proz_vertrag_id,0) = 0 THEN

		 loop_durchlauf: LOOP

			SELECT SHA1(CONCAT(UNIX_TIMESTAMP(NOW()), '537c70e7355eb935874e3ebd9e714fe7a0ecca69',UUID())) INTO proz_apikey;
		
			SELECT COUNT(*) INTO proz_anzahl FROM api_apikey WHERE apikey = proz_apikey;
			
			SET proz_anzahl_durchlaeufe = proz_anzahl_durchlaeufe + 1;

			IF ( proz_anzahl = 0 ) THEN
				-- generierter API Key noch nicht vorhanden
				SET OUT_fehler = 0;
				LEAVE loop_durchlauf;

			ELSEIF (proz_anzahl_durchlaeufe >= proz_max_anzahl_durchlaeufe) THEN

				SET OUT_fehler = 2;
				LEAVE loop_durchlauf;

			END IF;

		END LOOP loop_durchlauf;
		
		IF OUT_fehler = 0 THEN -- ok

			CALL erstelle_zeitraum(proz_von_datum, DATE_ADD(proz_von_datum,INTERVAL 50 YEAR), proz_zeitraum_id);

			INSERT INTO api_apikey (apikey, vertrag_id, zeitraum_id, bearbeiter_id) VALUES (proz_apikey, IN_vertrag_id, proz_zeitraum_id, IN_bearbeiter_id );

		END IF;

		

	ELSE

		SET OUT_fehler = 3;

	END IF;

ELSE

	SET OUT_fehler = 1;

END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `erstelle_zeitraum` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbs4oqsh_kms0cal`@`%` PROCEDURE `erstelle_zeitraum`(IN IN_von DATETIME,
  IN IN_bis DATETIME,
  OUT OUT_zeitraum_id INT UNSIGNED)
proc_block:BEGIN

/*
#####
# Beschreibung:
# Prozedur zum Erstellen eines Zeitraums.
#####
*/

-- Prüfen ob bereits ein Eintrag existiert
SELECT zeitraum_id
INTO OUT_zeitraum_id
FROM vorgaben_zeitraum
WHERE
  vorgaben_zeitraum.von = IN_von
  AND vorgaben_zeitraum.bis = IN_bis;

IF IFNULL( OUT_zeitraum_id, 0 ) <> 0 THEN
  LEAVE proc_block;
END IF;

INSERT IGNORE INTO vorgaben_zeitraum
SET
  von = IN_von,
  bis = IN_bis;

SELECT zeitraum_id
INTO OUT_zeitraum_id
FROM vorgaben_zeitraum
WHERE
  vorgaben_zeitraum.von = IN_von
  AND vorgaben_zeitraum.bis = IN_bis;

END
; ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stamd_aendern_erstellen_flagbit_ref` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbs4oqsh_kms0cal`@`%` PROCEDURE `stamd_aendern_erstellen_flagbit_ref`(IN IN_datensatz_typ_id INT UNSIGNED,
  IN IN_datensatz_id INT UNSIGNED,
  IN IN_flagbit BIGINT(20),
  IN IN_modus TINYINT(4),
  IN IN_bearbeiter_id INT UNSIGNED,
  OUT OUT_fehler_code TINYINT(4),
  OUT OUT_fehler TEXT)
proc_block:BEGIN


/*
#####
# Beschreibung:
# Prozedur zum Referenzieren eines Flags
#
# IN_modus:
#   1 = Eintragen/Ändern
#   2 = Austragen
#
# OUT_fehler_code = OUT_fehler:
#   0 = NULL = kein Fehler
#   1 = Parameter nicht hinreichend gefüllt
#   2 = Flagbit-Parameter nicht gültig
#####
*/

DECLARE proz_flagbit_ref_id, proz_zeitraum_id_alt, proz_zeitraum_id_neu, proz_datensatz_typ_id, proz_datensatz_id, proz_fehler, proz_anzahl INT;
DECLARE proz_zeitraum_von_neu, proz_zeitraum_von_alt DATETIME;
DECLARE proz_flagbit BIGINT;
DECLARE proz_neuen_datensatz_anlegen, proz_alten_datensatz_deaktivieren BOOLEAN DEFAULT FALSE;

-- 0 = kein Fehler
SET OUT_fehler_code = 0;

IF IFNULL( IN_datensatz_typ_id, 0 ) = 0
  OR IFNULL( IN_datensatz_id, 0 ) = 0
  OR IFNULL( IN_modus, 0 ) NOT IN ( 1, 2 )
  OR IFNULL( IN_bearbeiter_id, 0 ) = 0
THEN

  -- 1 = Parameter nicht hinreichend gefüllt
  SET OUT_fehler_code = 1;
  SET OUT_fehler = 'Parameter nicht hinreichend gefüllt';
  LEAVE proc_block;

END IF;

IF IN_modus = 1 -- 1 = Eintragen/Ändern
  AND IN_flagbit IS NULL
THEN

  -- 1 = Parameter nicht hinreichend gefüllt
  SET OUT_fehler_code = 1;
  SET OUT_fehler = 'Parameter nicht hinreichend gefüllt';
  LEAVE proc_block;

END IF;

SET proz_zeitraum_von_neu = NOW();

-- nach aktuellem Datensatz suchen
SELECT
  stamd_flagbit_ref.flagbit_ref_id,
  vorgaben_zeitraum.von,
  stamd_flagbit_ref.datensatz_typ_id,
  stamd_flagbit_ref.datensatz_id,
  stamd_flagbit_ref.flagbit
INTO
  proz_flagbit_ref_id,
  proz_zeitraum_von_alt,
  proz_datensatz_typ_id,
  proz_datensatz_id,
  proz_flagbit
FROM
  stamd_flagbit_ref
  INNER JOIN vorgaben_zeitraum
    ON vorgaben_zeitraum.zeitraum_id = stamd_flagbit_ref.zeitraum_id
      AND proz_zeitraum_von_neu BETWEEN vorgaben_zeitraum.von AND vorgaben_zeitraum.bis
WHERE
  stamd_flagbit_ref.datensatz_typ_id = IN_datensatz_typ_id
  AND stamd_flagbit_ref.datensatz_id = IN_datensatz_id;

IF IN_modus = 1 -- 1 = Eintragen/Ändern
  AND IFNULL( proz_flagbit_ref_id, 0 ) = 0
THEN

  SET proz_neuen_datensatz_anlegen = TRUE;

ELSEIF IN_modus = 2 -- 2 = Austragen
  AND IFNULL( proz_flagbit_ref_id, 0 ) <> 0
THEN

  SET proz_alten_datensatz_deaktivieren = TRUE;

ELSEIF IN_modus = 1 -- 1 = Eintragen/Ändern
  AND IFNULL( proz_flagbit_ref_id, 0 ) <> 0
THEN

  IF NOT proz_flagbit <=> IN_flagbit THEN

    SET proz_neuen_datensatz_anlegen = TRUE;
    SET proz_alten_datensatz_deaktivieren = TRUE;

  END IF;

ELSEIF IN_modus = 2 -- 2 = Austragen
  AND IFNULL( proz_flagbit_ref_id, 0 ) = 0
THEN

  -- 2 = Flagbit-Parameter nicht gültig
  SET OUT_fehler_code = 2;
  SET OUT_fehler = 'Flagbit-Referenz existiert nicht';
  LEAVE proc_block;

END IF;

IF IFNULL( proz_alten_datensatz_deaktivieren, FALSE ) THEN

  CALL erstelle_zeitraum ( proz_zeitraum_von_alt, DATE_SUB( proz_zeitraum_von_neu, INTERVAL 1 SECOND ), proz_zeitraum_id_alt );

  UPDATE stamd_flagbit_ref
  SET
    stamd_flagbit_ref.zeitraum_id = proz_zeitraum_id_alt,
    stamd_flagbit_ref.bearbeiter_id = IN_bearbeiter_id
  WHERE stamd_flagbit_ref.flagbit_ref_id = proz_flagbit_ref_id;

END IF;

IF IFNULL( proz_neuen_datensatz_anlegen, FALSE ) THEN

  CALL erstelle_zeitraum ( proz_zeitraum_von_neu, DATE_ADD( proz_zeitraum_von_neu, INTERVAL 50 YEAR ), proz_zeitraum_id_neu );

  INSERT INTO stamd_flagbit_ref
  SET
    datensatz_typ_id = IN_datensatz_typ_id,
    datensatz_id = IN_datensatz_id,
    flagbit = IN_flagbit,
    zeitraum_id = proz_zeitraum_id_neu,
    bearbeiter_id = IN_bearbeiter_id;

END IF;

cursor_loop:LOOP

  SELECT SQL_CALC_FOUND_ROWS stamd_flagbit_ref.flagbit_ref_id
  INTO proz_flagbit_ref_id
  FROM
    stamd_flagbit_ref
    INNER JOIN vorgaben_zeitraum
      ON vorgaben_zeitraum.zeitraum_id = stamd_flagbit_ref.zeitraum_id
        AND NOW() BETWEEN vorgaben_zeitraum.von AND vorgaben_zeitraum.bis
  WHERE
    stamd_flagbit_ref.datensatz_typ_id = IN_datensatz_typ_id
    AND stamd_flagbit_ref.datensatz_id = IN_datensatz_id
  ORDER BY
    vorgaben_zeitraum.von DESC,
    stamd_flagbit_ref.flagbit_ref_id DESC
  LIMIT 1;

  SET proz_anzahl = FOUND_ROWS();

  IF proz_anzahl <= 1 THEN
    LEAVE cursor_loop;
  END IF;

  UPDATE stamd_flagbit_ref
  SET zeitraum_id = 17396 -- 17396 = 1900 - 19000
  WHERE flagbit_ref_id = proz_flagbit_ref_id;

END LOOP cursor_loop;

END
; ;;
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

-- Dump completed on 2022-11-30  2:41:18
