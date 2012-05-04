-- MySQL dump 10.13  Distrib 5.1.55, for mandriva-linux-gnu (i586)
--
-- Host: localhost    Database: empire
-- ------------------------------------------------------
-- Server version	5.1.55-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `base_scale`
--

DROP TABLE IF EXISTS `base_scale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `base_scale` (
  `base` enum('1','S','P','C','B') COLLATE utf8_unicode_ci NOT NULL,
  `descr` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`base`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_scale`
--

LOCK TABLES `base_scale` WRITE;
/*!40000 ALTER TABLE `base_scale` DISABLE KEYS */;
INSERT INTO `base_scale` VALUES ('1','1:60'),('S','1:30'),('P','1:15'),('C','1:120'),('B','1:240');
/*!40000 ALTER TABLE `base_scale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cavalry_type`
--

DROP TABLE IF EXISTS `cavalry_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cavalry_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cavalry_type`
--

LOCK TABLES `cavalry_type` WRITE;
/*!40000 ALTER TABLE `cavalry_type` DISABLE KEYS */;
INSERT INTO `cavalry_type` VALUES (1,'Hussar'),(2,'Chasseur'),(3,'ChevLeg'),(4,'Dragoon'),(5,'Lancer'),(6,'Cossack'),(7,'Cuirassier'),(8,'Carabinier');
/*!40000 ALTER TABLE `cavalry_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ci_sessions`
--

DROP TABLE IF EXISTS `ci_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ci_sessions` (
  `session_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `ip_address` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `user_agent` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ci_sessions`
--

LOCK TABLES `ci_sessions` WRITE;
/*!40000 ALTER TABLE `ci_sessions` DISABLE KEYS */;
INSERT INTO `ci_sessions` VALUES ('dcf6fd8d4cd3390a7a33988fdf9ff687','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0',1336140128,''),('f1283381c64bf6963e21b74cc7bbd1c3','203.122.194.178','Opera/9.80 (X11; Linux i686; U; en) Presto/2.10.229 Version/11.62',1336162196,''),('d57798776a8cc2bdd0b43ffb7592b1b2','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0',1336158051,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:2:\"20\";s:8:\"username\";s:5:\"admin\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"A\";}'),('22711c1170f0155b8ea34afe9e3ffa5a','203.122.194.178','Mozilla/5.0 (X11; U; Linux i686; en-AU) AppleWebKit/533.3 (KHTML, like Gecko) Arora/0.11.0 Safari/533.3',1336151018,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:2:\"10\";s:8:\"username\";s:8:\"augereau\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}'),('9ac4d92c3581998ddcf459c50b9cfc2f','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0',1336141434,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:2:\"10\";s:8:\"username\";s:8:\"augereau\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}'),('038d1b82c60bf319aa37d5d55208864f','203.122.194.178','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2',1336163960,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:1:\"9\";s:8:\"username\";s:17:\"duke of brunswick\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}'),('753e4bcd4fa6268e7fe0ac7b6a5e092e','203.122.194.178','Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/533.3 (KHTML, like Gecko) Arora/0.11.0 Safari/533.3',1336135260,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:1:\"9\";s:8:\"username\";s:17:\"duke of brunswick\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}'),('ca653cafb4845910167f5f9d857ff766','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0',1336120764,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:2:\"20\";s:8:\"username\";s:5:\"admin\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"A\";}'),('6397d3f5bc0871358e605c8f05e047d0','203.122.194.178','Opera/9.80 (X11; Linux i686; U; en) Presto/2.10.229 Version/11.62',1336162193,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:2:\"10\";s:8:\"username\";s:8:\"augereau\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}'),('50df81ac3ddb2a855c65cfce4121f173','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:9.0.1) Gecko/20100101 Firefox/9.0.1',1336115563,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:2:\"10\";s:8:\"username\";s:8:\"augereau\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}'),('8d732959f2311e8aec93ce6ece7bfbd8','203.122.194.178','Mozilla/5.0 (compatible; Konqueror/4.6; Linux) KHTML/4.6.5 (like Gecko)',1335778690,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:2:\"10\";s:8:\"username\";s:8:\"augereau\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}'),('910fbad6664338f3626a3f9194533f5a','203.122.194.178','Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/533.3 (KHTML, like Gecko) Arora/0.11.0 Safari/533.3',1336116729,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:1:\"9\";s:8:\"username\";s:17:\"duke of brunswick\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}');
/*!40000 ALTER TABLE `ci_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `code_engine`
--

DROP TABLE IF EXISTS `code_engine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code_engine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `descr` text COLLATE utf8_unicode_ci NOT NULL,
  `command` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `movement` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `morale` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `firepower` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `melee` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code_engine`
--

LOCK TABLES `code_engine` WRITE;
/*!40000 ALTER TABLE `code_engine` DISABLE KEYS */;
INSERT INTO `code_engine` VALUES (1,'EmpireV','<p>Code engines that match the EmpireV rules as closely as is humanly possible</p>','empire/command','empire/movement','empire/morale','empire/firepower','empire/melee');
/*!40000 ALTER TABLE `code_engine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direction`
--

DROP TABLE IF EXISTS `direction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `direction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direction`
--

LOCK TABLES `direction` WRITE;
/*!40000 ALTER TABLE `direction` DISABLE KEYS */;
INSERT INTO `direction` VALUES (1,'N'),(2,'NE'),(3,'E'),(4,'SE'),(5,'S'),(6,'SW'),(7,'W'),(8,'NW');
/*!40000 ALTER TABLE `direction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctrine`
--

DROP TABLE IF EXISTS `doctrine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctrine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctrine`
--

LOCK TABLES `doctrine` WRITE;
/*!40000 ALTER TABLE `doctrine` DISABLE KEYS */;
INSERT INTO `doctrine` VALUES (1,'Regimental'),(2,'DivisionGroup'),(3,'Corps');
/*!40000 ALTER TABLE `doctrine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drill_type`
--

DROP TABLE IF EXISTS `drill_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drill_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drill_type`
--

LOCK TABLES `drill_type` WRITE;
/*!40000 ALTER TABLE `drill_type` DISABLE KEYS */;
INSERT INTO `drill_type` VALUES (1,'Prussian'),(2,'French');
/*!40000 ALTER TABLE `drill_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_type`
--

DROP TABLE IF EXISTS `event_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_type`
--

LOCK TABLES `event_type` WRITE;
/*!40000 ALTER TABLE `event_type` DISABLE KEYS */;
INSERT INTO `event_type` VALUES (1,'Order Received'),(2,'Order Activated'),(3,'March Movement'),(4,'Enter Engagement'),(5,'Break Off Engagement'),(6,'Small Arms Fire'),(7,'Closed with the Enemy'),(8,'Change of Formation'),(9,'Change of Cover'),(10,'Morale Test'),(11,'Firefight'),(12,'Close Combat Breakthrough'),(13,'Rally'),(14,'Leader Attached'),(15,'Leader Detached'),(16,'Receive Artillery Fire'),(17,'Receive Cavalry'),(18,'Receive Infantry'),(19,'Sickness'),(20,'Resupply'),(21,'Display of Valour'),(22,'Disgrace'),(23,'Change Morale State'),(24,'Exceed Fatigue Limit'),(25,'Fully Recover Fatigue'),(26,'Reinforcements');
/*!40000 ALTER TABLE `event_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `scenario_id` int(11) NOT NULL,
  `playing` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `start_hour` int(11) NOT NULL,
  `turn_number` int(11) NOT NULL DEFAULT '1',
  `phase` int(11) NOT NULL DEFAULT '1',
  `orbat_attacker` int(11) NOT NULL,
  `orbat_defender` int(11) NOT NULL,
  `situation` text COLLATE utf8_unicode_ci NOT NULL,
  `attacker_briefing` text COLLATE utf8_unicode_ci NOT NULL,
  `defender_briefing` text COLLATE utf8_unicode_ci NOT NULL,
  `latitude` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `longitude` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `ground_scale` int(11) NOT NULL,
  `figure_scale` int(11) NOT NULL,
  `infantry_base` int(11) NOT NULL,
  `cavalry_base` int(11) NOT NULL,
  `video_intro` text COLLATE utf8_unicode_ci NOT NULL,
  `rain_factor` int(11) NOT NULL COMMENT '0 = none, 10 = heavy',
  `code_engine_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (4,'Weekend test II',4,'',6,2,9,11,9,'<p>Small meeting engagement at Jena</p>','<p>You are to clear the area around Vierzehnheiligen</p>','<p>You are to advance and inflict total defeat on the French before Napoleon arrives</p>','','',50,80,0,0,'',0,1);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_attach`
--

DROP TABLE IF EXISTS `game_attach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_attach` (
  `game_id` int(11) NOT NULL,
  `commander_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  PRIMARY KEY (`game_id`,`commander_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_attach`
--

LOCK TABLES `game_attach` WRITE;
/*!40000 ALTER TABLE `game_attach` DISABLE KEYS */;
INSERT INTO `game_attach` VALUES (4,101,107);
/*!40000 ALTER TABLE `game_attach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_attach_done`
--

DROP TABLE IF EXISTS `game_attach_done`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_attach_done` (
  `game_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  PRIMARY KEY (`game_id`,`player_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_attach_done`
--

LOCK TABLES `game_attach_done` WRITE;
/*!40000 ALTER TABLE `game_attach_done` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_attach_done` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_engagement`
--

DROP TABLE IF EXISTS `game_engagement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_engagement` (
  `game_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `turn_start` int(11) NOT NULL,
  `turn_end` int(11) NOT NULL,
  `descr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`game_id`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_engagement`
--

LOCK TABLES `game_engagement` WRITE;
/*!40000 ALTER TABLE `game_engagement` DISABLE KEYS */;
INSERT INTO `game_engagement` VALUES (4,1,2,0,'Battle of Vierzehnheiligen');
/*!40000 ALTER TABLE `game_engagement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_engagement_initiative`
--

DROP TABLE IF EXISTS `game_engagement_initiative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_engagement_initiative` (
  `game_id` int(11) NOT NULL,
  `engagement_id` int(11) NOT NULL,
  `turn_number` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `impulses` int(11) NOT NULL,
  KEY `game_id` (`game_id`,`engagement_id`,`turn_number`),
  KEY `game_id_2` (`game_id`,`engagement_id`,`unit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_engagement_initiative`
--

LOCK TABLES `game_engagement_initiative` WRITE;
/*!40000 ALTER TABLE `game_engagement_initiative` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_engagement_initiative` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_engagement_unit`
--

DROP TABLE IF EXISTS `game_engagement_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_engagement_unit` (
  `game_id` int(11) NOT NULL,
  `engagement_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  PRIMARY KEY (`game_id`,`unit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_engagement_unit`
--

LOCK TABLES `game_engagement_unit` WRITE;
/*!40000 ALTER TABLE `game_engagement_unit` DISABLE KEYS */;
INSERT INTO `game_engagement_unit` VALUES (4,1,101),(4,1,235),(4,1,230);
/*!40000 ALTER TABLE `game_engagement_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_event`
--

DROP TABLE IF EXISTS `game_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event` (
  `game_id` int(11) NOT NULL,
  `turn_number` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `event_type` int(11) NOT NULL,
  `descr` text COLLATE utf8_unicode_ci NOT NULL,
  `value` int(11) NOT NULL,
  `losses` int(11) NOT NULL,
  `fled` int(11) NOT NULL,
  KEY `game_id` (`game_id`,`turn_number`),
  KEY `unit_id` (`unit_id`,`game_id`,`turn_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event`
--

LOCK TABLES `game_event` WRITE;
/*!40000 ALTER TABLE `game_event` DISABLE KEYS */;
INSERT INTO `game_event` VALUES (4,1,257,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,256,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,255,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,254,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,253,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,252,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,251,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,250,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,249,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,248,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,247,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,246,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,245,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,244,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,243,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,242,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,241,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,240,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,239,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,238,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,237,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,236,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,235,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,234,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,233,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,232,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,231,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,230,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,229,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,228,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,227,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,226,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,225,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,224,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,223,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,222,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,221,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,220,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,219,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,218,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,217,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,216,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,215,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,214,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,213,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,212,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,211,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,210,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,209,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,208,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,207,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,206,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,205,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,204,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,203,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,202,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,201,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,200,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,142,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,141,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,140,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,139,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,138,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,137,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,136,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,135,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,134,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,133,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,132,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,131,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,130,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,129,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,128,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,127,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,126,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,125,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,124,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,123,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,122,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,121,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,120,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,119,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,118,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,117,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,116,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,115,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,114,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,113,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,112,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,111,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,110,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,109,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,108,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,107,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,106,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,105,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,104,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,103,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,102,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,101,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,100,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,1,258,2,'Unit joins scenario Small meeting engagement at Jena',1,0,0),(4,2,2,0,'March objective reached',1,0,0),(4,2,225,2,'March objective reached',1,0,0),(4,2,231,8,'Formation change from CL to LN',0,0,0),(4,2,230,2,'Unit attacks enemy to their front under an intercept order',2,0,0);
/*!40000 ALTER TABLE `game_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_me_det`
--

DROP TABLE IF EXISTS `game_me_det`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_me_det` (
  `game_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `turn_number` int(11) NOT NULL,
  `result` int(11) NOT NULL,
  `diemod` int(11) NOT NULL,
  `dieroll` int(11) NOT NULL,
  PRIMARY KEY (`game_id`,`turn_number`,`unit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_me_det`
--

LOCK TABLES `game_me_det` WRITE;
/*!40000 ALTER TABLE `game_me_det` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_me_det` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_message`
--

DROP TABLE IF EXISTS `game_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_message` (
  `game_id` int(11) NOT NULL,
  `turn_number` int(11) NOT NULL,
  `seq` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `is_read` enum('T','F') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'F',
  `sent_turn` int(11) NOT NULL,
  `letter_icon` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`game_id`,`turn_number`,`seq`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_message`
--

LOCK TABLES `game_message` WRITE;
/*!40000 ALTER TABLE `game_message` DISABLE KEYS */;
INSERT INTO `game_message` VALUES (4,1,5,10,101,'From: General of Division Jacques Desjardin<br>[101] - 1st Division: Desjardin will Attack the village of Vierzehnheiligen','T',1,4,'2012-05-04 12:39:30'),(4,1,4,9,235,'From: Oberst von Erichsen<br>[235] - Light Brigade will Defend the western edge of Vierzehnheiligen','T',1,1,'2012-05-04 09:21:39'),(4,1,3,9,230,'From: General-Leutnant Friedrich Jacob von Holtzendorff<br>[230] - Cavalry Brigade von Holtzendorff will Support the right flank of the light brigade','T',1,1,'2012-05-04 09:25:09'),(4,1,2,9,225,'From: General-Major Christian Friedrich von Schimonsky<br>[225] - Brigade von Schimonsky will March to the south west of Vierzehnheiligen','T',1,2,'2012-05-04 09:23:36'),(4,1,1,9,220,'From: General-Major Johann Friedrich Wilhelm von Müffling<br>[220] - Brigade von Muffling will March to the south west of Vierzehnheiligen','T',1,4,'2012-05-04 09:23:37'),(4,3,1,9,220,'Unit has converted to defend order due to March objective reached','F',2,6,'2012-05-04 10:29:02'),(4,3,2,9,225,'Unit has converted to defend order due to March objective reached','F',2,3,'2012-05-04 10:29:54'),(4,2,1,9,0,'<img src=http://15mm-madness.com/empire/photos/2012-05-04_22-41-061.jpg><br>View from the southern flank looking towards Veirzehnheiligen','T',2,3,'2012-05-04 12:41:05'),(4,2,2,10,0,'<img src=http://15mm-madness.com/empire/photos/2012-05-04_22-41-061.jpg><br>View from the southern flank looking towards Veirzehnheiligen','T',2,5,'2012-05-04 12:40:10'),(4,2,3,20,0,'<img src=http://15mm-madness.com/empire/photos/2012-05-04_22-40-531.jpg><br>Prussian fusiliers take Veirzehnheiligen, as the French approach from the West.<br>','T',2,2,'2012-05-04 12:44:25'),(4,2,4,10,0,'<img src=http://15mm-madness.com/empire/photos/2012-05-04_22-40-531.jpg><br>Prussian fusiliers take Veirzehnheiligen, as the French approach from the West.<br>','T',2,2,'2012-05-04 12:39:42');
/*!40000 ALTER TABLE `game_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_order`
--

DROP TABLE IF EXISTS `game_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_order` (
  `game_id` int(11) NOT NULL,
  `turn_number` int(11) NOT NULL,
  `activate_turn` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `player_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `order_type` int(11) NOT NULL,
  `objective` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `comments` text COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `activation_chance` int(11) NOT NULL,
  PRIMARY KEY (`game_id`,`turn_number`,`activate_turn`,`unit_id`),
  KEY `game_id` (`game_id`,`turn_number`),
  KEY `game_id_2` (`game_id`,`activate_turn`),
  KEY `unit_id` (`unit_id`,`game_id`,`activate_turn`),
  KEY `player_name` (`player_name`,`game_id`,`turn_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_order`
--

LOCK TABLES `game_order` WRITE;
/*!40000 ALTER TABLE `game_order` DISABLE KEYS */;
INSERT INTO `game_order` VALUES (4,1,1,100,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,2,2,220,'umpire',1,'to the south west of Vierzehnheiligen','March objective reached','2012-05-04 10:29:02',100),(4,1,1,102,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,103,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,104,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,105,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,106,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,107,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,108,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,109,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,110,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,111,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,112,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,113,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,114,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,115,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,116,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,117,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,118,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,119,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,120,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,121,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,122,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,123,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,124,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,125,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,126,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,127,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,128,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,129,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,130,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,131,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,132,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,133,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,134,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,135,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,136,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,137,'admin',1,'','Initial deployment','2012-05-04 09:09:30',0),(4,1,1,138,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,139,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,140,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,141,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,142,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,200,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,201,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,202,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,203,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,204,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,205,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,206,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,207,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,208,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,209,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,210,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,211,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,212,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,213,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,214,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,215,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,216,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,217,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,218,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,219,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,221,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,222,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,223,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,224,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,226,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,227,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,228,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,229,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,2,2,225,'umpire',1,'to the south west of Vierzehnheiligen','March objective reached','2012-05-04 10:29:54',100),(4,1,1,231,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,232,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,233,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,234,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,236,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,237,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,238,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,239,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,240,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,241,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,242,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,243,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,244,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,245,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,246,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,247,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,248,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,249,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,250,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,251,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,252,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,253,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,254,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,255,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,256,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,257,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,258,'admin',1,'','Initial deployment','2012-05-04 09:09:31',0),(4,1,1,230,'duke of brunswick',7,'the right flank of the light brigade','','2012-05-04 09:12:47',55),(4,1,1,235,'duke of brunswick',1,'the western edge of Vierzehnheiligen','','2012-05-04 09:13:04',55),(4,1,1,220,'duke of brunswick',3,'to the south west of Vierzehnheiligen','','2012-05-04 09:13:18',55),(4,1,1,225,'duke of brunswick',3,'to the south west of Vierzehnheiligen','','2012-05-04 09:13:23',55),(4,1,1,101,'augereau',2,'the village of Vierzehnheiligen','','2012-05-04 09:14:35',90),(4,2,2,230,'admin',2,'Enemy to the front','','2012-05-04 14:17:17',55);
/*!40000 ALTER TABLE `game_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_photo`
--

DROP TABLE IF EXISTS `game_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_photo` (
  `game_id` int(11) NOT NULL,
  `turn_number` int(11) NOT NULL,
  `filename` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `player_id` int(11) NOT NULL,
  `caption` text COLLATE utf8_unicode_ci NOT NULL,
  KEY `game_id` (`game_id`,`turn_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_photo`
--

LOCK TABLES `game_photo` WRITE;
/*!40000 ALTER TABLE `game_photo` DISABLE KEYS */;
INSERT INTO `game_photo` VALUES (4,2,'2012-05-04_22-41-061.jpg',20,'View from the southern flank looking towards Veirzehnheiligen'),(4,2,'2012-05-04_22-40-531.jpg',20,'Prussian fusiliers take Veirzehnheiligen, as the French approach from the West.');
/*!40000 ALTER TABLE `game_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_turn`
--

DROP TABLE IF EXISTS `game_turn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_turn` (
  `game_id` int(11) NOT NULL,
  `turn_number` int(11) NOT NULL,
  `initiative` int(11) NOT NULL,
  `bombardments1` int(11) NOT NULL,
  `bombardments2` int(11) NOT NULL,
  `comments` text COLLATE utf8_unicode_ci NOT NULL,
  `temperature` int(11) NOT NULL,
  `wind_direction` int(11) NOT NULL,
  `wind_speed` int(11) NOT NULL,
  `rain` int(11) NOT NULL,
  `visibility` int(11) NOT NULL,
  `ground_conditions` int(11) NOT NULL COMMENT '1 = good, 10 = mud',
  `weather_conditions` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `realtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `game_id` (`game_id`,`turn_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_turn`
--

LOCK TABLES `game_turn` WRITE;
/*!40000 ALTER TABLE `game_turn` DISABLE KEYS */;
INSERT INTO `game_turn` VALUES (4,1,1,0,0,'',25,1,0,0,1000,1,'Fine','2012-05-04 09:09:30'),(4,2,1,0,0,'',24,1,-1,0,1008,1,'','2012-05-04 09:26:47');
/*!40000 ALTER TABLE `game_turn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_unit_stats`
--

DROP TABLE IF EXISTS `game_unit_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_unit_stats` (
  `game_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'this field is only here as a debugging tool, to see what records have last been modified',
  `initial_strength` int(11) NOT NULL,
  `initial_officers` int(11) NOT NULL,
  `morale_state` int(11) NOT NULL,
  `fatigue` int(11) NOT NULL,
  `breakpoint` int(11) NOT NULL,
  `casualties` int(11) NOT NULL,
  `casualties_this_hour` int(11) NOT NULL,
  `dead` int(11) NOT NULL,
  `officers_killed` int(11) NOT NULL,
  `disabling_wounds` int(11) NOT NULL,
  `light_wounds` int(11) NOT NULL,
  `fled` int(11) NOT NULL,
  `surrendered` int(11) NOT NULL,
  `mutineers` int(11) NOT NULL,
  `ammo` int(11) NOT NULL,
  `food` int(11) NOT NULL,
  `disorder` int(11) NOT NULL,
  `is_limbered` enum('T','F') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'T' COMMENT 'applies to artillery - is it limbered or not',
  `guns_abandoned` enum('T','F') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'F',
  `cover` enum('L','M','H','S') COLLATE utf8_unicode_ci NOT NULL,
  `formation` enum('CL','LN','CC','OO','SQ','HS','RC') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CL',
  `engagement_id` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `did_close_combat` int(11) NOT NULL COMMENT 'did close combat last hour/ value = id of the event',
  `won_close_combat` int(11) NOT NULL COMMENT 'won a close combat last hour. value = id of the event',
  `needs_morale_test` enum('T','F') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'F',
  UNIQUE KEY `game_id` (`game_id`,`unit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_unit_stats`
--

LOCK TABLES `game_unit_stats` WRITE;
/*!40000 ALTER TABLE `game_unit_stats` DISABLE KEYS */;
INSERT INTO `game_unit_stats` VALUES (4,100,'2012-05-04 09:09:30',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,101,'2012-05-04 09:14:20',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,447,35,10,0,0,'F'),(4,102,'2012-05-04 09:10:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,103,'2012-05-04 09:10:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,104,'2012-05-04 09:10:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,105,'2012-05-04 09:10:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,106,'2012-05-04 09:10:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,107,'2012-05-04 09:10:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,108,'2012-05-04 09:10:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,109,'2012-05-04 09:10:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,110,'2012-05-04 09:10:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,111,'2012-05-04 09:10:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,112,'2012-05-04 09:10:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,113,'2012-05-04 09:10:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,114,'2012-05-04 09:10:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,115,'2012-05-04 09:10:00',4,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,116,'2012-05-04 09:10:00',4,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0,'F'),(4,117,'2012-05-04 09:09:30',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,118,'2012-05-04 09:09:30',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,119,'2012-05-04 09:09:30',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,120,'2012-05-04 09:09:30',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,121,'2012-05-04 09:09:30',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,122,'2012-05-04 09:09:30',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,123,'2012-05-04 09:09:30',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,124,'2012-05-04 09:09:30',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,125,'2012-05-04 09:09:30',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,126,'2012-05-04 09:09:30',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,127,'2012-05-04 09:09:30',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,128,'2012-05-04 09:09:30',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,129,'2012-05-04 09:09:30',640,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,130,'2012-05-04 09:09:30',640,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,131,'2012-05-04 09:09:30',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,132,'2012-05-04 09:09:30',4,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,133,'2012-05-04 09:09:30',4,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,134,'2012-05-04 09:09:30',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,135,'2012-05-04 09:09:30',480,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,136,'2012-05-04 09:09:30',360,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,137,'2012-05-04 09:09:30',4,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,138,'2012-05-04 09:09:30',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,139,'2012-05-04 09:09:31',4,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,140,'2012-05-04 09:09:31',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,141,'2012-05-04 09:09:31',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,142,'2012-05-04 09:09:31',4,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,200,'2012-05-04 09:09:31',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,201,'2012-05-04 09:09:31',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,202,'2012-05-04 09:09:31',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,203,'2012-05-04 09:09:31',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,204,'2012-05-04 09:09:31',1280,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,205,'2012-05-04 09:09:31',1280,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,206,'2012-05-04 09:09:31',1280,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,207,'2012-05-04 09:09:31',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,208,'2012-05-04 09:09:31',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,209,'2012-05-04 09:09:31',600,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,210,'2012-05-04 09:09:31',600,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,211,'2012-05-04 09:09:31',600,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,212,'2012-05-04 09:09:31',200,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,213,'2012-05-04 09:09:31',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,214,'2012-05-04 09:09:31',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,215,'2012-05-04 09:09:31',1200,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,216,'2012-05-04 09:09:31',8,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,217,'2012-05-04 09:09:31',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,218,'2012-05-04 09:09:31',800,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,219,'2012-05-04 09:10:10',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,220,'2012-05-04 09:12:34',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,92,3,9,0,0,'F'),(4,221,'2012-05-04 09:10:10',600,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,222,'2012-05-04 09:10:10',1200,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,223,'2012-05-04 09:10:10',1200,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,224,'2012-05-04 09:10:10',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,225,'2012-05-04 09:12:33',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,187,66,9,0,0,'F'),(4,226,'2012-05-04 09:10:10',600,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,227,'2012-05-04 09:10:10',1200,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,228,'2012-05-04 09:10:10',1200,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,229,'2012-05-04 09:10:10',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,230,'2012-05-04 09:12:29',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,575,57,9,0,0,'F'),(4,231,'2012-05-04 14:02:08',500,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','LN',0,0,0,9,0,0,'F'),(4,232,'2012-05-04 09:10:10',600,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,233,'2012-05-04 09:10:10',600,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,234,'2012-05-04 09:10:10',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,235,'2012-05-04 09:12:31',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,391,3,9,0,0,'F'),(4,236,'2012-05-04 09:10:10',600,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,237,'2012-05-04 09:10:10',1000,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,238,'2012-05-04 09:10:10',4,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0,'F'),(4,239,'2012-05-04 09:09:31',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,240,'2012-05-04 09:09:31',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,241,'2012-05-04 09:09:31',1280,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,242,'2012-05-04 09:09:31',1280,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,243,'2012-05-04 09:09:31',8,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,244,'2012-05-04 09:09:31',8,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,245,'2012-05-04 09:09:31',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,246,'2012-05-04 09:09:31',1280,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,247,'2012-05-04 09:09:31',1280,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,248,'2012-05-04 09:09:31',640,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,249,'2012-05-04 09:09:31',10,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,250,'2012-05-04 09:09:31',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,251,'2012-05-04 09:09:31',480,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,252,'2012-05-04 09:09:31',480,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,253,'2012-05-04 09:09:31',480,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,254,'2012-05-04 09:09:31',10,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,255,'2012-05-04 09:09:31',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,256,'2012-05-04 09:09:31',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,257,'2012-05-04 09:09:31',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F'),(4,258,'2012-05-04 09:09:31',5,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0,'F');
/*!40000 ALTER TABLE `game_unit_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_users`
--

DROP TABLE IF EXISTS `game_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_users` (
  `game_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `side` enum('A','D','U') COLLATE utf8_unicode_ci NOT NULL,
  `commander_uid` int(11) NOT NULL,
  UNIQUE KEY `game_id` (`game_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_users`
--

LOCK TABLES `game_users` WRITE;
/*!40000 ALTER TABLE `game_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inspiration`
--

DROP TABLE IF EXISTS `inspiration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inspiration` (
  `id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `me_det_bonus` int(11) NOT NULL,
  `rally_me` int(11) NOT NULL,
  `rally_unit` int(11) NOT NULL,
  KEY `id-with-duplicates` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inspiration`
--

LOCK TABLES `inspiration` WRITE;
/*!40000 ALTER TABLE `inspiration` DISABLE KEYS */;
INSERT INTO `inspiration` VALUES (1,'Charistmatic',10,75,90),(2,'Inspirational',5,50,75),(3,'Impersonal',0,25,50),(4,'Despised',-10,10,25),(2,'Inspiring',5,50,75),(4,'Uninspiring',-10,10,25);
/*!40000 ALTER TABLE `inspiration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logins`
--

DROP TABLE IF EXISTS `logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logins` (
  `user_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_agent` text COLLATE utf8_unicode_ci NOT NULL,
  `ip_address` text COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `user_id` (`user_id`,`date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logins`
--

LOCK TABLES `logins` WRITE;
/*!40000 ALTER TABLE `logins` DISABLE KEYS */;
INSERT INTO `logins` VALUES (7,'2011-12-26 09:53:22','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-26 09:52:40','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-26 11:58:46','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-26 22:53:18','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-26 23:10:59','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 01:30:31','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 01:33:33','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 01:48:59','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 01:54:09','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 01:58:11','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 02:05:52','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 02:06:04','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 02:57:52','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 03:30:10','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 06:08:50','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 07:01:04','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 07:08:27','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 07:09:16','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 15:18:48','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2011-12-27 17:47:43','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-30 03:25:15','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2011-12-30 03:27:43','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2012-01-04 03:18:40','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2012-01-04 03:38:34','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2012-01-05 11:19:57','Mozilla/5.0 (X11; Linux i686; rv:9.0.1) Gecko/20100101 Firefox/9.0.1','203.122.194.178'),(6,'2012-01-06 13:58:30','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2012-01-06 14:00:21','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2012-01-06 14:10:28','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2012-01-30 05:07:37','Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20100101 Firefox/7.0.1','203.122.194.178'),(6,'2012-02-04 09:00:19','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2012-03-15 01:17:27','Mozilla/5.0 (X11; Linux i686; rv:9.0.1) Gecko/20100101 Firefox/9.0.1','123.136.46.15'),(6,'2012-04-01 10:27:18','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2012-04-02 10:16:02','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2012-04-02 10:31:34','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2012-04-03 00:19:08','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2012-04-03 04:01:41','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2012-04-03 07:15:21','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-04 11:09:24','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-04 18:08:58','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(14,'2012-04-04 18:29:10','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(16,'2012-04-04 18:47:55','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(12,'2012-04-05 06:04:06','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-05 06:35:38','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-05 06:36:05','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-05 06:36:11','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-05 06:36:22','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(12,'2012-04-05 06:36:30','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-05 06:40:43','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-05 06:42:08','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-05 06:46:50','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(17,'2012-04-05 06:59:44','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(19,'2012-04-05 07:13:49','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 07:27:59','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 07:35:07','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 07:36:05','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 07:56:30','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:03:50','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:06:02','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:07:00','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:10:12','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:11:18','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-05 08:11:40','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(12,'2012-04-05 08:11:51','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(12,'2012-04-05 08:12:26','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:36:06','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:40:08','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:40:42','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-05 08:57:19','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:59:51','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-05 10:50:29','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-05 10:50:48','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 13:07:12','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 14:26:45','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-05 14:26:54','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-05 14:27:59','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 14:28:16','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 20:02:51','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 20:03:05','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 20:05:28','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 20:08:22','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 20:09:28','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-05 20:09:54','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-05 20:11:53','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-06 01:55:02','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-06 07:49:52','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-06 08:53:02','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 11:31:08','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 11:32:27','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 11:33:16','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 12:57:29','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 20:01:10','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 20:05:56','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 20:07:28','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-06 20:08:48','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-06 20:11:07','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 20:12:32','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-07 07:53:39','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 10:16:24','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-07 10:25:37','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 10:49:12','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 10:50:01','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 10:51:00','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 12:41:15','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 15:09:15','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 15:38:23','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 15:40:35','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 15:41:03','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 15:44:08','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 16:08:56','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 16:10:04','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-07 16:54:55','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-07 16:56:31','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 17:00:36','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-07 17:05:41','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 17:08:54','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 17:16:04','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 17:38:31','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 18:03:02','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 18:57:32','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 18:58:42','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 19:10:54','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 19:11:02','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 19:11:17','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-07 19:15:29','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-07 19:16:00','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-07 19:16:54','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 19:17:41','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 19:24:38','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 19:27:12','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-07 19:32:21','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-07 19:32:46','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-07 19:35:13','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-08 02:34:50','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-08 07:11:43','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-08 07:28:23','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-08 08:35:44','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-08 08:39:33','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-08 09:48:11','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-08 09:48:45','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-08 12:22:01','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-08 12:48:57','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-08 13:12:15','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-08 13:27:51','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-08 13:31:29','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-08 13:36:11','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-08 13:51:03','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-08 15:53:51','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-08 18:48:53','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-08 19:32:57','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-08 19:33:48','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-08 20:26:29','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-08 21:37:22','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-08 22:04:20','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-09 07:15:15','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-09 07:15:35','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-09 07:31:20','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-09 07:53:07','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-09 09:58:59','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-09 10:14:30','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-09 10:16:48','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(8,'2012-04-09 10:18:41','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-09 10:28:08','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-09 10:46:46','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-09 11:17:38','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-09 11:18:01','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(8,'2012-04-09 11:18:26','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-11 15:52:46','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(8,'2012-04-11 15:53:58','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(8,'2012-04-11 17:13:57','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-11 19:00:07','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(20,'2012-04-11 19:02:09','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-11 20:46:36','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 01:21:44','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-13 02:38:59','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 07:50:55','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-13 08:33:22','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 08:37:20','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 08:51:58','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 09:02:23','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 09:02:42','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 09:08:23','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 11:58:11','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 12:07:13','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-13 12:27:33','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-13 12:29:42','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 12:45:39','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 13:14:26','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 13:14:48','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 13:23:08','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 13:23:40','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 13:24:07','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-13 13:24:30','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 13:26:28','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 13:29:10','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(9,'2012-04-13 13:37:19','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(9,'2012-04-13 14:20:20','Mozilla/5.0 (X11; Linux i686; rv:9.0.1) Gecko/20100101 Firefox/9.0.1','203.122.194.178'),(20,'2012-04-14 19:07:35','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(25,'2012-04-14 19:08:23','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(25,'2012-04-14 19:23:17','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(25,'2012-04-14 19:40:15','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(9,'2012-04-14 20:18:24','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(9,'2012-04-14 23:18:17','Mozilla/5.0 (X11; Linux i686; rv:9.0.1) Gecko/20100101 Firefox/9.0.1','203.122.194.178'),(10,'2012-04-15 05:33:35','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(25,'2012-04-15 07:05:13','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(10,'2012-04-17 01:19:46','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-17 02:35:31','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-17 02:36:26','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-17 02:36:57','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-17 20:12:06','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-17 20:14:14','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-18 04:09:01','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-18 04:15:14','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-18 04:34:55','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(8,'2012-04-18 04:38:54','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-18 06:50:46','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(25,'2012-04-18 07:24:28','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(8,'2012-04-18 07:38:07','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-18 07:54:39','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-18 13:43:18','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-19 03:42:43','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-19 03:51:23','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-19 06:09:53','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(10,'2012-04-19 07:41:00','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(25,'2012-04-19 10:46:54','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(9,'2012-04-19 11:07:24','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(20,'2012-04-19 12:24:27','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-19 13:02:32','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-19 13:17:55','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-19 13:18:55','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(8,'2012-04-19 13:19:35','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-19 20:25:00','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(9,'2012-04-20 08:56:40','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(8,'2012-04-20 09:03:11','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-20 17:30:43','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-20 17:32:01','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-21 04:04:08','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-25 05:37:27','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(25,'2012-04-25 05:41:53','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(9,'2012-04-25 05:42:51','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(25,'2012-04-25 05:43:06','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(10,'2012-04-25 12:48:25','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(9,'2012-04-25 12:48:46','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(10,'2012-04-30 09:38:23','Mozilla/5.0 (compatible; Konqueror/4.6; Linux) KHTML/4.6.5 (like Gecko)','203.122.194.178'),(10,'2012-04-30 09:39:25','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(25,'2012-05-04 03:24:21','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(10,'2012-05-04 03:24:52','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(10,'2012-05-04 03:49:33','Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/533.3 (KHTML, like Gecko) Arora/0.11.0 Safari/533.3','203.122.194.178'),(25,'2012-05-04 04:23:52','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(9,'2012-05-04 05:03:07','Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/533.3 (KHTML, like Gecko) Arora/0.11.0 Safari/533.3','203.122.194.178'),(20,'2012-05-04 05:06:21','Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0','203.122.194.178'),(10,'2012-05-04 05:10:22','Opera/9.80 (X11; Linux i686; U; en) Presto/2.10.229 Version/11.62','203.122.194.178'),(10,'2012-05-04 07:12:53','Mozilla/5.0 (X11; Linux i686; rv:9.0.1) Gecko/20100101 Firefox/9.0.1','203.122.194.178'),(9,'2012-05-04 07:19:44','Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/533.3 (KHTML, like Gecko) Arora/0.11.0 Safari/533.3','203.122.194.178'),(9,'2012-05-04 07:32:20','Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/533.3 (KHTML, like Gecko) Arora/0.11.0 Safari/533.3','203.122.194.178'),(10,'2012-05-04 08:10:07','Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20100101 Firefox/12.0','203.122.194.178'),(9,'2012-05-04 08:45:35','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(10,'2012-05-04 09:14:11','Mozilla/5.0 (X11; U; Linux i686; en-AU) AppleWebKit/533.3 (KHTML, like Gecko) Arora/0.11.0 Safari/533.3','203.122.194.178');
/*!40000 ALTER TABLE `logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `morale_grade`
--

DROP TABLE IF EXISTS `morale_grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `morale_grade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `ACE` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `morale_grade`
--

LOCK TABLES `morale_grade` WRITE;
/*!40000 ALTER TABLE `morale_grade` DISABLE KEYS */;
INSERT INTO `morale_grade` VALUES (1,'Old Guard',22),(2,'Guard',18),(3,'Grenadier',16),(8,'Landwehr',7),(7,'Conscript',8),(6,'Veteran',10),(5,'Crack',12),(4,'Elite',14),(9,'Trained Militia',5),(10,'Untrained Militia',3),(11,'Commander',0);
/*!40000 ALTER TABLE `morale_grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `morale_states`
--

DROP TABLE IF EXISTS `morale_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `morale_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `morale_states`
--

LOCK TABLES `morale_states` WRITE;
/*!40000 ALTER TABLE `morale_states` DISABLE KEYS */;
INSERT INTO `morale_states` VALUES (1,'Good'),(2,'Shaken'),(3,'Retreat'),(4,'Broken');
/*!40000 ALTER TABLE `morale_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `national_theme`
--

DROP TABLE IF EXISTS `national_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `national_theme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `backdrop_img` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `login_img` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `logout_img` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `parade_img` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `css` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `national_theme`
--

LOCK TABLES `national_theme` WRITE;
/*!40000 ALTER TABLE `national_theme` DISABLE KEYS */;
INSERT INTO `national_theme` VALUES (1,'Default Theme','scenario-master.jpg','french-line.jpg','french_retreat.jpg','inspect-troops.jpg','css/style.css'),(2,'Prussia 1806','prussia1806/background.jpg','prussia1806/march-in.jpg','prussia1806/march-out.jpg','prussia1806/parade.jpg','css/prussia1806.css');
/*!40000 ALTER TABLE `national_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orbat`
--

DROP TABLE IF EXISTS `orbat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orbat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `descr` text COLLATE utf8_unicode_ci NOT NULL,
  `date_loaded` datetime NOT NULL,
  `side` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `starting_id` int(11) NOT NULL,
  `ending_id` int(11) NOT NULL,
  `num_commands` int(11) NOT NULL,
  `num_units` int(11) NOT NULL,
  `num_bases` int(11) NOT NULL,
  `total_strength` int(11) NOT NULL,
  `xml_content` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orbat`
--

LOCK TABLES `orbat` WRITE;
/*!40000 ALTER TABLE `orbat` DISABLE KEYS */;
INSERT INTO `orbat` VALUES (9,'JenaSaxon.trl','','2012-05-04 18:33:32','',200,259,16,58,0,25863,'<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<Army item=\"y\" tlversion=\"1.2.4\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Division\"\nicon=\"book_1\">\n<Name type=\"Text\" ref=\"y\">Hohenlohe\'s Army</Name>\n<Commander type=\"Text\">Frederick Louis, Prince of Hohenlohe-Ingelfingen</Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\">Inspirational</Inspiration>\n<ProfessionalSkill type=\"Choice\" format=\"Superior/Excellent/Good/Mediocre/Poor/Despicable\">Poor</ProfessionalSkill>\n<Doctrine type=\"Choice\" format=\"Regimental/DivisionGroup/Corps\">DivisionGroup</Doctrine>\n<Wing item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">Southern Wing Command</Name>\n<MoraleState type=\"Choice\" format=\"Good/Shaken/Retreat/Broken\" init=\"Good\">Good</MoraleState>\n<Commander type=\"Text\">Hohenlohe</Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\">Impersonal</Inspiration>\n<ProfessionalSkill type=\"Choice\" format=\"Superior/Excellent/Good/Mediocre/Poor/Despicable\" init=\"Good\">Despicable</ProfessionalSkill>\n<Doctrine type=\"Choice\" format=\"Regimental/DivisionGroup/Corps\" init=\"Corps\">DivisionGroup</Doctrine>\n<Division item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Brigade\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">Advanced Guard Division</Name>\n<Commander type=\"Text\">General-Leutnant Prince Louis Ferdinand</Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\" init=\"Impersonal\">Inspirational</Inspiration>\n<ProfessionalSkill type=\"Choice\" format=\"Superior/Excellent/Good/Mediocre/Poor/Despicable\" init=\"Good\">Poor</ProfessionalSkill>\n<Doctrine type=\"Choice\" format=\"Regimental/DivisionGroup/Corps\">DivisionGroup</Doctrine>\n<Brigade item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Battalion\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">Infantry Brigade Belvilaqua</Name>\n<Commander type=\"Text\">General-Major von Bevilaqua</Commander>\n<Inspiration type=\"Choice\" format=\"Inspirational/Impersonal/Despised\" init=\"Impersonal\">Impersonal</Inspiration>\n<Drill type=\"Choice\" format=\"None/Prussian/French\" init=\"Prussian\">Prussian</Drill>\n<Image type=\"Picture\" html=\"y\"></Image>\n<Battalion item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"bullet_3\">\n<Name type=\"Text\" ref=\"y\">Müffling Infantry Regiment # 49, two battalions</Name>\n<FacingColours type=\"Text\"></FacingColours>\n<MoraleState type=\"Choice\" format=\"Good/Shaken/Retreat/Broken\" init=\"Good\">Good</MoraleState>\n<Strength type=\"Number\" format=\"####\" init=\"720\">1280</Strength>\n<NumBases type=\"Text\"></NumBases>\n<Ranks type=\"Choice\" format=\"3/2/OpenOrder\" init=\"3\">3</Ranks>\n<Officers type=\"Number\" format=\"##\" init=\"10\">10</Officers>\n<ACE type=\"Number\" format=\"###\" init=\"10\">10</ACE>\n<MoraleGrade type=\"Choice\" format=\"OG/GRD/Gren/Elite/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\">Veteran</MoraleGrade>\n<SmallArms type=\"Choice\" format=\"OG/Guard/Gren/Elite/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\">Crack</SmallArms>\n<Skirmishers type=\"Number\" format=\"##\"></Skirmishers>\n<OpenOrder type=\"Boolean\" format=\"yes/no\" init=\"false\">false</OpenOrder>\n<Rifles type=\"Boolean\" format=\"yes/no\" init=\"false\">false</Rifles>\n<ClosedColumn type=\"Boolean\" format=\"yes/no\" init=\"false\">false</ClosedColumn>\n<ShockTroops type=\"Boolean\" format=\"yes/no\" init=\"false\">false</ShockTroops>\n<BattalionGuns type=\"Boolean\" format=\"yes/no\" init=\"false\">true</BattalionGuns>\n<Breakpoint type=\"Number\" format=\"###\" init=\"80\">80</Breakpoint>\n<Fatigue type=\"Number\" format=\"##\" init=\"0\">0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Prince Clemens Saxon Infantry Regiment, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1280</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Kürfurst Saxon Infantry Regiment, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1280</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battery item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"bullet_1\">\n<Name type=\"Text\" ref=\"y\">Hoyer Foot Artillery Battery, six 4-pound guns</Name>\n<Type type=\"Choice\" format=\"Foot/Horse\" init=\"Foot\">Foot</Type>\n<Calibre type=\"Choice\" format=\"4lb/6lb/8lb/12lb\" init=\"6\">4lb</Calibre>\n<Strength type=\"Number\" format=\"##\" init=\"6\">6</Strength>\n<NumGuns type=\"Text\">3</NumGuns>\n<CrewFigures type=\"Text\">2</CrewFigures>\n<Howitzers type=\"Number\" format=\"##\" init=\"0\">0</Howitzers>\n<Class type=\"Choice\" format=\"OG/Class I/Class II/Class III\" init=\"Class II\">Class II</Class>\n<MoraleGrade type=\"Choice\" format=\"OG/GRD/Gren/Elite/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\">Veteran</MoraleGrade>\n</Battery>\n</Brigade>\n<Brigade item=\"y\">\n<Name>Brigade von Pelet</Name>\n<Commander>General-Major Karl Gerhard von Pelet</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>Prussian</Drill>\n<Battalion item=\"y\">\n<Name>Rabenau Fusilier Battalion # 13</Name>\n<MoraleState>Good</MoraleState>\n<Strength>600</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Pelet Fusilier Battalion # 14</Name>\n<MoraleState>Good</MoraleState>\n<Strength>600</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Rühle Fusilier Battalion # 15</Name>\n<MoraleState>Good</MoraleState>\n<Strength>600</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Masars and Valentin Foot Jäger companies</Name>\n<MoraleState>Good</MoraleState>\n<Strength>200</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Crack</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battery item=\"y\">\n<Name>Reimann Foot Artillery Battery, six 6-pound guns</Name>\n<Type>Foot</Type>\n<Calibre>6lb</Calibre>\n<Strength>6</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>3</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class II</Class>\n<MoraleGrade>Crack</MoraleGrade>\n</Battery>\n</Brigade>\n<CavBrigade item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Squadron\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">Cavalry Brigade von Schimmelpfennig</Name>\n<BattleGroup type=\"Boolean\" format=\"yes/no\" init=\"true\">true</BattleGroup>\n<Commander type=\"Text\">General-Major Christian Ludwig von Schimmelpfennig</Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\" init=\"Inspiring\">Impersonal</Inspiration>\n<Doctrine type=\"Choice\" format=\"Scouting/Packed/Linear\" init=\"Packed\">Packed</Doctrine>\n<Squadron item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"bullet_2\">\n<Name type=\"Text\" ref=\"y\">Schimmelpfennig Hussar Regiment # 6, ten squadrons</Name>\n<FacingColours type=\"Text\"></FacingColours>\n<Type type=\"Choice\" format=\"Hussar/Chass/ChevLeg/Dragoon/Lancer/Cossack/Cuirassier/Carabinier\" init=\"Dragoon\">Hussar</Type>\n<MoraleState type=\"Choice\" format=\"Good/Shaken/Retreat/Broken\" init=\"Good\">Good</MoraleState>\n<Strength type=\"Number\" format=\"###\" init=\"120\">1200</Strength>\n<NumBases type=\"Text\"></NumBases>\n<Officers type=\"Number\" format=\"##\" init=\"10\">10</Officers>\n<ACE type=\"Number\" format=\"##\" init=\"20\">20</ACE>\n<MoraleGrade type=\"Choice\" format=\"OG/Guard/Gren/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\">Veteran</MoraleGrade>\n<SmallArms type=\"Choice\" format=\"OG/Guard/Gren/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\">Veteran</SmallArms>\n<BattleCavalry type=\"Boolean\" format=\"yes/no\" init=\"false\">false</BattleCavalry>\n<Undistinguished type=\"Boolean\" format=\"yes/no\" init=\"false\">false</Undistinguished>\n<Skirmisher type=\"Number\" format=\"##\" init=\"0\">0</Skirmisher>\n<MoveRate type=\"Choice\" format=\"Light/Heavy\" init=\"Light\">Light</MoveRate>\n<Breakpoint type=\"Number\" format=\"###\" init=\"80\">80</Breakpoint>\n<Fatigue type=\"Number\" format=\"###\" init=\"0\">0</Fatigue>\n</Squadron>\n<Battery item=\"y\">\n<Name>Gause Horse Artillery Battery # 2, eight 6-pound guns</Name>\n<Type>Horse</Type>\n<Calibre>6lb</Calibre>\n<Strength>8</Strength>\n<NumGuns>3</NumGuns>\n<CrewFigures>3</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class II</Class>\n<MoraleGrade>Veteran</MoraleGrade>\n</Battery>\n</CavBrigade>\n<CavBrigade item=\"y\">\n<Name>Cavalry Brigade von Trützschler</Name>\n<BattleGroup>true</BattleGroup>\n<Commander>General-Major von Trützschler</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Doctrine>Packed</Doctrine>\n<Squadron item=\"y\">\n<Name>Saxon Hussar Regiment, eight squadrons</Name>\n<Type>Hussar</Type>\n<MoraleState>Good</MoraleState>\n<Strength>800</Strength>\n<Officers>10</Officers>\n<ACE>20</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<BattleCavalry>false</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Light</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n</CavBrigade>\n</Division>\n<Division item=\"y\">\n<Name>1st Division</Name>\n<Commander>General-Leutnant Julius von Grawert</Commander>\n<Inspiration>Impersonal</Inspiration>\n<ProfessionalSkill>Poor</ProfessionalSkill>\n<Doctrine>DivisionGroup</Doctrine>\n<Brigade item=\"y\">\n<Name>Brigade von Muffling</Name>\n<Commander>General-Major Johann Friedrich Wilhelm von Müffling</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>Prussian</Drill>\n<Battalion item=\"y\">\n<Name>Hahn Grenadier battalion (29/32)</Name>\n<MoraleState>Good</MoraleState>\n<Strength>600</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Gren</MoraleGrade>\n<SmallArms>Gren</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>true</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Hohenlohe Infantry Regiment # 32, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1200</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Sanitz Infantry Regiment # 50, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1200</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battery item=\"y\">\n<Name>Giasenapp Foot Artillery battery # 7, six 12-pound guns</Name>\n<Type>Foot</Type>\n<Calibre>12lb</Calibre>\n<Strength>6</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>3</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class II</Class>\n<MoraleGrade>Veteran</MoraleGrade>\n</Battery>\n</Brigade>\n<Brigade item=\"y\">\n<Name>Brigade von Schimonsky</Name>\n<Commander>General-Major Christian Friedrich von Schimonsky</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>Prussian</Drill>\n<Battalion item=\"y\">\n<Name>Sack Grenadier battalion (33/42)</Name>\n<MoraleState>Good</MoraleState>\n<Strength>600</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Gren</MoraleGrade>\n<SmallArms>Gren</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>true</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Grawert Infantry Regiment # 37, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1200</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Zastrow Infantry Regiment # 39, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1200</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battery item=\"y\">\n<Name>Wolframsdorf Foot Artillery battery # 8, six 12-pound guns</Name>\n<Type>Foot</Type>\n<Calibre>12lb</Calibre>\n<Strength>6</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>3</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class II</Class>\n<MoraleGrade>Veteran</MoraleGrade>\n</Battery>\n</Brigade>\n<CavBrigade item=\"y\">\n<Name>Cavalry Brigade von Holtzendorff</Name>\n<BattleGroup>true</BattleGroup>\n<Commander>General-Leutnant Friedrich Jacob von Holtzendorff</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Doctrine>Packed</Doctrine>\n<Squadron item=\"y\">\n<Name>Krafft Dragoon Regiment # 11, five squadrons</Name>\n<Type>Dragoon</Type>\n<MoraleState>Good</MoraleState>\n<Strength>500</Strength>\n<Officers>10</Officers>\n<ACE>24</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<BattleCavalry>true</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Heavy</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Squadron item=\"y\">\n<Name>Henkel Cuirassier Regiment # 1, five squadrons</Name>\n<Type>Cuirassier</Type>\n<MoraleState>Good</MoraleState>\n<Strength>600</Strength>\n<Officers>10</Officers>\n<ACE>27</ACE>\n<MoraleGrade>Guard</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<BattleCavalry>true</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Heavy</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Squadron item=\"y\">\n<Name>Holtzendorff Cuirassier Regiment # 9, five squadrons</Name>\n<Type>Cuirassier</Type>\n<MoraleState>Good</MoraleState>\n<Strength>600</Strength>\n<Officers>10</Officers>\n<ACE>27</ACE>\n<MoraleGrade>Gren</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<BattleCavalry>true</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Heavy</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Battery item=\"y\">\n<Name>Steinwehr Horse Artillery battery # 9, six 6-pound guns</Name>\n<Type>Horse</Type>\n<Calibre>6lb</Calibre>\n<Strength>6</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>3</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class II</Class>\n<MoraleGrade>Veteran</MoraleGrade>\n</Battery>\n</CavBrigade>\n<Brigade item=\"y\">\n<Name>Light Brigade</Name>\n<Commander>Oberst von Erichsen</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>Prussian</Drill>\n<Battalion item=\"y\">\n<Name>Erichsen Fusilier battalion # 10</Name>\n<MoraleState>Good</MoraleState>\n<Strength>600</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Squadron item=\"y\">\n<Name>Gettkandt Hussar Regiment # 1, ten squadrons</Name>\n<Type>Dragoon</Type>\n<MoraleState>Good</MoraleState>\n<Strength>1000</Strength>\n<Officers>10</Officers>\n<ACE>20</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<BattleCavalry>false</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Light</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Battery item=\"y\">\n<Name>Studnitz Prussian Horse Artillery battery # 14 (-), four 4-pound guns</Name>\n<Type>Horse</Type>\n<Calibre>4lb</Calibre>\n<Strength>4</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>2</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class II</Class>\n<MoraleGrade>Veteran</MoraleGrade>\n</Battery>\n</Brigade>\n</Division>\n<Division item=\"y\">\n<Name>2nd (Saxon) Division</Name>\n<Commander>General der Kavallerie Hans Gottlob von Zeschwitz</Commander>\n<Inspiration>Impersonal</Inspiration>\n<ProfessionalSkill>Despicable</ProfessionalSkill>\n<Doctrine>DivisionGroup</Doctrine>\n<Brigade item=\"y\">\n<Name>Brigade von Burgsdorff</Name>\n<Commander>General-Major von Burgsdorff</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>Prussian</Drill>\n<Battalion item=\"y\">\n<Name>Thümmel Saxon Infantry Regiment, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1280</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Prince Xavier Saxon Infantry Regiment, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1280</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battery item=\"y\">\n<Name>Haussmar Saxon Foot Artillery battery, eight 12-pound guns</Name>\n<Type>Foot</Type>\n<Calibre>12lb</Calibre>\n<Strength>8</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>4</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class II</Class>\n<MoraleGrade>Veteran</MoraleGrade>\n</Battery>\n<Battery item=\"y\">\n<Name>Ernst Saxon Foot Artillery battery, eight 12-pound guns</Name>\n<Type>Foot</Type>\n<Calibre>12lb</Calibre>\n<Strength>8</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>4</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class II</Class>\n<MoraleGrade>Veteran</MoraleGrade>\n</Battery>\n</Brigade>\n<Brigade item=\"y\">\n<Name>Brigade von Dyherrn</Name>\n<Commander>General-Major von Dyherrn</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>Prussian</Drill>\n<Battalion item=\"y\">\n<Name>Low Saxon Infantry Regiment, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1280</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Niesemeuschel Saxon Infantry Regiment, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1280</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Bevilaqua Saxon Infantry Regiment, 2nd battalion</Name>\n<MoraleState>Good</MoraleState>\n<Strength>640</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battery item=\"y\">\n<Name>Bonniot Saxon Foot Artillery battery # 8, ten 12-pound guns</Name>\n<Type>Foot</Type>\n<Calibre>12lb</Calibre>\n<Strength>10</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>4</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class II</Class>\n<MoraleGrade>Veteran</MoraleGrade>\n</Battery>\n</Brigade>\n<CavBrigade item=\"y\">\n<Name>Cavalry Brigade: von Kochtitsky</Name>\n<BattleGroup>true</BattleGroup>\n<Commander>General-Leutnant Joachim Friedrich von Zeschwitz</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Doctrine>Linear</Doctrine>\n<Squadron item=\"y\">\n<Name>Mounted Carabinier Saxon Regiment, four squadron</Name>\n<Type>Carabinier</Type>\n<MoraleState>Good</MoraleState>\n<Strength>480</Strength>\n<Officers>10</Officers>\n<ACE>27</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<BattleCavalry>true</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Heavy</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Squadron item=\"y\">\n<Name>Kochtitsky Saxon Cuirassier Regiment, four squadrons</Name>\n<Type>Dragoon</Type>\n<MoraleState>Good</MoraleState>\n<Strength>480</Strength>\n<Officers>10</Officers>\n<ACE>27</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<BattleCavalry>true</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Heavy</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Squadron item=\"y\">\n<Name>Prince Albert Saxon Chevau-léger Regiment, four squadrons</Name>\n<Type>ChevLeg</Type>\n<MoraleState>Good</MoraleState>\n<Strength>480</Strength>\n<Officers>10</Officers>\n<ACE>20</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<BattleCavalry>false</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Light</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Battery item=\"y\">\n<Name>Grossman Saxon Horse Artillery battery, ten guns</Name>\n<Type>Horse</Type>\n<Calibre>6lb</Calibre>\n<Strength>10</Strength>\n<NumGuns>4</NumGuns>\n<CrewFigures>2</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class II</Class>\n<MoraleGrade>Veteran</MoraleGrade>\n</Battery>\n</CavBrigade>\n<Brigade item=\"y\">\n<Name>Light Brigade von Polenz</Name>\n<Commander>Oberst Karl Anton Andreas von Boguslawsky</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>Prussian</Drill>\n<Battalion item=\"y\">\n<Name>Boguslawsky Prussian Fusilier battalion # 22</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Squadron item=\"y\">\n<Name>Polenz Saxon Chevau-léger Regiment, four squadrons</Name>\n<Type>ChevLeg</Type>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<Officers>10</Officers>\n<ACE>20</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<BattleCavalry>false</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Light</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Battery item=\"y\">\n<Name>Studnitz Prussian Horse Artillery battery # 14 (-), five guns</Name>\n<Type>Horse</Type>\n<Calibre>4lb</Calibre>\n<Strength>5</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>2</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class II</Class>\n<MoraleGrade>Veteran</MoraleGrade>\n</Battery>\n</Brigade>\n</Division>\n</Wing>\n<Division item=\"y\">\n<Name>Reserve Division</Name>\n<Commander>General-Leutnant Wolfgang Moritz von Prittwitz</Commander>\n<Inspiration>Impersonal</Inspiration>\n<ProfessionalSkill>Despicable</ProfessionalSkill>\n<Doctrine>DivisionGroup</Doctrine>\n</Division>\n<Division item=\"y\">\n<Name>Left Flank Corps</Name>\n<Commander>General-Major Bogislav Friedrich Emanuel von Tauentzien</Commander>\n<Inspiration>Impersonal</Inspiration>\n<ProfessionalSkill>Poor</ProfessionalSkill>\n<Doctrine>DivisionGroup</Doctrine>\n</Division>\n<Corps item=\"n\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Division\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\"></Name>\n</Corps>\n<DEFAULT item=\"n\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\">\n<Name type=\"Text\" ref=\"y\"></Name>\n</DEFAULT>\n<ROOT item=\"n\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"DEFAULT\">\n<Name type=\"Text\" ref=\"y\"></Name>\n</ROOT>\n</Army>'),(11,'FrenchVIICorps-1806.trl','','2012-05-04 18:35:58','',100,143,10,43,95,16560,'<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<Corps item=\"y\" tlversion=\"1.2.4\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Division\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">French VII Corps 1806 - Augereau</Name>\n<Commander type=\"Text\">Marshal Pierre Augereau</Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\">Inspirational</Inspiration>\n<ProfessionalSkill type=\"Choice\" format=\"Superior/Excellent/Good/Mediocre/Poor/Despicable\">Excellent</ProfessionalSkill>\n<Doctrine type=\"Choice\" format=\"Regimental/DivisionGroup/Corps\">Corps</Doctrine>\n<Division item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Brigade\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">1st Division: Desjardin</Name>\n<Commander type=\"Text\">General of Division Jacques Desjardin</Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\" init=\"Impersonal\">Impersonal</Inspiration>\n<ProfessionalSkill type=\"Choice\" format=\"Superior/Excellent/Good/Mediocre/Poor/Despicable\" init=\"Good\">Good</ProfessionalSkill>\n<Doctrine type=\"Choice\" format=\"Regimental/DivisionGroup/Corps\">Corps</Doctrine>\n<Brigade item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Battalion\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">Brigade d\' Legere Lapisse</Name>\n<Commander type=\"Text\">General of Brigade Pierre Belon Lapisse</Commander>\n<Inspiration type=\"Choice\" format=\"Inspirational/Impersonal/Despised\" init=\"Impersonal\">Inspirational</Inspiration>\n<Drill type=\"Choice\" format=\"None/Prussian/French\" init=\"Prussian\">French</Drill>\n<Image type=\"Picture\" html=\"y\"></Image>\n<Battalion item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"bullet_3\">\n<Name type=\"Text\" ref=\"y\">16eme Legere, 1e Bn</Name>\n<FacingColours type=\"Text\"></FacingColours>\n<MoraleState type=\"Choice\" format=\"Good/Shaken/Retreat/Broken\" init=\"Good\">Good</MoraleState>\n<Strength type=\"Number\" format=\"####\" init=\"720\">720</Strength>\n<NumBases type=\"Text\">4</NumBases>\n<Ranks type=\"Choice\" format=\"3/2/OpenOrder\" init=\"3\">3</Ranks>\n<Officers type=\"Number\" format=\"##\" init=\"10\">10</Officers>\n<ACE type=\"Number\" format=\"###\" init=\"10\">14</ACE>\n<MoraleGrade type=\"Choice\" format=\"OG/GRD/Gren/Elite/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\">Elite</MoraleGrade>\n<SmallArms type=\"Choice\" format=\"OG/Guard/Gren/Elite/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\">Elite</SmallArms>\n<Skirmishers type=\"Number\" format=\"##\">2</Skirmishers>\n<OpenOrder type=\"Boolean\" format=\"yes/no\" init=\"false\">true</OpenOrder>\n<Rifles type=\"Boolean\" format=\"yes/no\" init=\"false\">false</Rifles>\n<ClosedColumn type=\"Boolean\" format=\"yes/no\" init=\"false\">true</ClosedColumn>\n<ShockTroops type=\"Boolean\" format=\"yes/no\" init=\"false\">false</ShockTroops>\n<BattalionGuns type=\"Boolean\" format=\"yes/no\" init=\"false\">false</BattalionGuns>\n<Breakpoint type=\"Number\" format=\"###\" init=\"80\">80</Breakpoint>\n<Fatigue type=\"Number\" format=\"##\" init=\"0\">0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>16eme Legere, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>14</ACE>\n<MoraleGrade>Elite</MoraleGrade>\n<SmallArms>Elite</SmallArms>\n<Skirmishers>2</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>16eme Legere, 3e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>14</ACE>\n<MoraleGrade>Elite</MoraleGrade>\n<SmallArms>Elite</SmallArms>\n<Skirmishers>2</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>16eme Legere, 4e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>14</ACE>\n<MoraleGrade>Elite</MoraleGrade>\n<SmallArms>Elite</SmallArms>\n<Skirmishers>2</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n</Brigade>\n<Brigade item=\"y\">\n<Name>Brigade d\' Ligne Lefranc</Name>\n<Commander>General of Brigade Jacques Lefranc</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>French</Drill>\n<Battalion item=\"y\">\n<Name>14eme Legere, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>14</ACE>\n<MoraleGrade>Elite</MoraleGrade>\n<SmallArms>Elite</SmallArms>\n<Skirmishers>2</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>44eme Ligne, 1e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>44eme Ligne, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>44eme Ligne, 3e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>105eme Ligne, 1e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>105eme Ligne, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>105eme Ligne, 3e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n</Brigade>\n<Battery item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"bullet_1\">\n<Name type=\"Text\" ref=\"y\">3rd Foot Artillery Regiment, 4th company</Name>\n<Type type=\"Choice\" format=\"Foot/Horse\" init=\"Foot\">Foot</Type>\n<Calibre type=\"Choice\" format=\"4lb/6lb/8lb/12lb\" init=\"6\">12lb</Calibre>\n<Strength type=\"Number\" format=\"##\" init=\"6\">4</Strength>\n<NumGuns type=\"Text\">1</NumGuns>\n<CrewFigures type=\"Text\">4</CrewFigures>\n<Howitzers type=\"Text\" init=\"0\">2 x 6&quot; Howitzer</Howitzers>\n<Class type=\"Choice\" format=\"OG/Class I/Class II/Class III\" init=\"Class II\">Class I</Class>\n<MoraleGrade type=\"Choice\" format=\"OG/GRD/Gren/Elite/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\">Elite</MoraleGrade>\n</Battery>\n<Battery item=\"y\">\n<Name>6th Horse Artillery Regiment, 2nd company</Name>\n<Type>Horse</Type>\n<Calibre>6lb</Calibre>\n<Strength>4</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>2</CrewFigures>\n<Class>Class I</Class>\n<MoraleGrade>Elite</MoraleGrade>\n</Battery>\n</Division>\n<Division item=\"y\">\n<Name>2nd Division: de Bierre</Name>\n<Commander>General of Division Étienne Heudelet de Bierre</Commander>\n<Inspiration>Impersonal</Inspiration>\n<ProfessionalSkill>Good</ProfessionalSkill>\n<Doctrine>Corps</Doctrine>\n<Brigade item=\"y\">\n<Name>Brigade d\' Legere Amey</Name>\n<Commander>General of Brigade François Pierre Amey</Commander>\n<Inspiration>Inspirational</Inspiration>\n<Drill>French</Drill>\n<Battalion item=\"y\">\n<Name>7eme Legere, 1e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>14</ACE>\n<MoraleGrade>Elite</MoraleGrade>\n<SmallArms>Elite</SmallArms>\n<Skirmishers>2</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>7eme Legere, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>14</ACE>\n<MoraleGrade>Elite</MoraleGrade>\n<SmallArms>Elite</SmallArms>\n<Skirmishers>2</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>7eme Legere, 3e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>14</ACE>\n<MoraleGrade>Elite</MoraleGrade>\n<SmallArms>Elite</SmallArms>\n<Skirmishers>2</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n</Brigade>\n<Brigade item=\"y\">\n<Name>Brigade d\' Ligne Sarrut</Name>\n<Commander>General of Brigade Jacques Thomas Sarrut</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>French</Drill>\n<Battalion item=\"y\">\n<Name>24eme Ligne, 1e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>24eme Ligne, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>24eme Ligne, 3e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>63eme Ligne, 1e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>63eme Ligne, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n</Brigade>\n<Brigade item=\"y\">\n<Name>Brigade Allied</Name>\n<Commander>General of Brigade Prinz Karl von Hesse Darmstadt</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>Prussian</Drill>\n<Battalion item=\"y\">\n<Name>Hesse Darmstadt Fuslier, 1st Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>640</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Hesse Darmstadt Fuslier, 1st Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>640</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Nassau Infantrie Regiment, 3rd Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n</Brigade>\n<Battery item=\"y\">\n<Name>3rd Foot Artillery Regiment, 3rd company</Name>\n<Type>Foot</Type>\n<Calibre>12lb</Calibre>\n<Strength>4</Strength>\n<NumGuns>1</NumGuns>\n<CrewFigures>4</CrewFigures>\n<Howitzers>2 x 6&quot; Howitzer</Howitzers>\n<Class>Class I</Class>\n<MoraleGrade>Elite</MoraleGrade>\n</Battery>\n<Battery item=\"y\">\n<Name>6th Horse Artillery Regiment, 2nd company</Name>\n<Type>Horse</Type>\n<Calibre>6lb</Calibre>\n<Strength>4</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>2</CrewFigures>\n<Class>Class I</Class>\n<MoraleGrade>Elite</MoraleGrade>\n</Battery>\n</Division>\n<CavBrigade item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Squadron\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">Brigade d\' Cheval  Auguste Durosnel</Name>\n<BattleGroup type=\"Boolean\" format=\"yes/no\" init=\"true\">true</BattleGroup>\n<Commander type=\"Text\">General of Brigade Antoine Jean Auguste Durosnel</Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\" init=\"Inspiring\">Impersonal</Inspiration>\n<Doctrine type=\"Choice\" format=\"Scouting/Packed/Linear\" init=\"Packed\">Packed</Doctrine>\n<Squadron item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"bullet_2\">\n<Name type=\"Text\" ref=\"y\">7e Chasseurs</Name>\n<FacingColours type=\"Text\"></FacingColours>\n<Type type=\"Choice\" format=\"Hussar/Chass/ChevLeg/Dragoon/Lancer/Cossack/Cuirassier/Carabinier\" init=\"Dragoon\">Chass</Type>\n<MoraleState type=\"Choice\" format=\"Good/Shaken/Retreat/Broken\" init=\"Good\">Good</MoraleState>\n<Strength type=\"Number\" format=\"###\" init=\"120\">480</Strength>\n<NumBases type=\"Text\">4</NumBases>\n<Officers type=\"Number\" format=\"##\" init=\"10\">10</Officers>\n<ACE type=\"Number\" format=\"##\" init=\"20\">20</ACE>\n<MoraleGrade type=\"Choice\" format=\"OG/GRD/Gren/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\">Veteran</MoraleGrade>\n<SmallArms type=\"Choice\" format=\"OG/Guard/Gren/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\">Veteran</SmallArms>\n<BattleCavalry type=\"Boolean\" format=\"yes/no\" init=\"false\">false</BattleCavalry>\n<Undistinguished type=\"Boolean\" format=\"yes/no\" init=\"false\">false</Undistinguished>\n<Skirmisher type=\"Number\" format=\"##\" init=\"0\">0</Skirmisher>\n<MoveRate type=\"Choice\" format=\"Light/Heavy\" init=\"Light\">Light</MoveRate>\n<Breakpoint type=\"Number\" format=\"###\" init=\"80\">80</Breakpoint>\n<Fatigue type=\"Number\" format=\"###\" init=\"0\">0</Fatigue>\n</Squadron>\n<Squadron item=\"y\">\n<Name>20e Chasseurs</Name>\n<Type>Chass</Type>\n<MoraleState>Good</MoraleState>\n<Strength>360</Strength>\n<NumBases>3</NumBases>\n<Officers>10</Officers>\n<ACE>20</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<BattleCavalry>false</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Light</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Battery item=\"y\">\n<Name>6th Horse Artillery Regiment, 5th company</Name>\n<Type>Horse</Type>\n<Calibre>4lb</Calibre>\n<Strength>4</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>2</CrewFigures>\n<Class>Class I</Class>\n<MoraleGrade>Elite</MoraleGrade>\n</Battery>\n</CavBrigade>\n<Division item=\"y\">\n<Name>Corps Artillery</Name>\n<Inspiration>Impersonal</Inspiration>\n<ProfessionalSkill>Good</ProfessionalSkill>\n<Doctrine>Corps</Doctrine>\n<Battery item=\"y\">\n<Name>Heavy battery</Name>\n<Type>Foot</Type>\n<Calibre>12lb</Calibre>\n<Strength>4</Strength>\n<NumGuns>1</NumGuns>\n<CrewFigures>4</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class I</Class>\n<MoraleGrade>Crack</MoraleGrade>\n</Battery>\n<Battery item=\"y\">\n<Name>1e Artillery d Pied</Name>\n<Type>Foot</Type>\n<Calibre>8lb</Calibre>\n<Strength>6</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>3</CrewFigures>\n<Howitzers>2 x 6&quot; howitzers</Howitzers>\n<Class>Class I</Class>\n<MoraleGrade>Crack</MoraleGrade>\n</Battery>\n<Battery item=\"y\">\n<Name>1e Artillery d pied</Name>\n<Type>Foot</Type>\n<Calibre>8lb</Calibre>\n<Strength>6</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>3</CrewFigures>\n<Howitzers>2 x 6&quot; howitzer</Howitzers>\n<Class>Class I</Class>\n<MoraleGrade>Crack</MoraleGrade>\n</Battery>\n<Battery item=\"y\">\n<Name>2e Artillery d Cheval</Name>\n<Type>Horse</Type>\n<Calibre>4lb</Calibre>\n<Strength>4</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>2</CrewFigures>\n<Class>Class I</Class>\n<MoraleGrade>Crack</MoraleGrade>\n</Battery>\n</Division>\n<Army item=\"n\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Corps\"\nicon=\"book_1\">\n<Name type=\"Text\" ref=\"y\"></Name>\n</Army>\n<Wing item=\"n\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\"></Name>\n<MoraleState type=\"Choice\" format=\"Good/Shaken/Retreat/Broken\" init=\"Good\"></MoraleState>\n<Commander type=\"Text\"></Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\"></Inspiration>\n<ProfessionalSkill type=\"Choice\" format=\"Superior/Excellent/Good/Mediocre/Poor/Despicable\" init=\"Good\"></ProfessionalSkill>\n<Doctrine type=\"Choice\" format=\"Regimental/DivisionGroup/Corps\" init=\"Corps\"></Doctrine>\n</Wing>\n</Corps>');
/*!40000 ALTER TABLE `orbat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_types`
--

DROP TABLE IF EXISTS `order_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `infantry_me_only` int(11) NOT NULL,
  `cavalry_me_only` int(11) NOT NULL,
  `me_only` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_types`
--

LOCK TABLES `order_types` WRITE;
/*!40000 ALTER TABLE `order_types` DISABLE KEYS */;
INSERT INTO `order_types` VALUES (1,'Defend',0,0,0),(2,'Attack',0,0,0),(3,'March',0,0,0),(4,'Withdraw',0,0,0),(5,'Redeploy',0,0,0),(6,'Rest and Rally',0,0,0),(7,'Support',0,1,0),(8,'Break Off',0,0,1),(9,'Garrison',1,0,0),(10,'Sauve qui peut',0,0,1);
/*!40000 ALTER TABLE `order_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professional_skill`
--

DROP TABLE IF EXISTS `professional_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `professional_skill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `base_activation` int(11) NOT NULL,
  `attached_elsewhere` int(11) NOT NULL,
  `army_hq_bonus` int(11) NOT NULL,
  `delay` decimal(2,1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professional_skill`
--

LOCK TABLES `professional_skill` WRITE;
/*!40000 ALTER TABLE `professional_skill` DISABLE KEYS */;
INSERT INTO `professional_skill` VALUES (1,'Superior',95,70,30,'0.0'),(2,'Excellent',90,60,20,'0.5'),(3,'Good',80,50,10,'1.0'),(4,'Mediocre',65,35,5,'2.0'),(5,'Poor',55,25,0,'3.0'),(6,'Despicable',45,15,0,'4.0');
/*!40000 ALTER TABLE `professional_skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scenario`
--

DROP TABLE IF EXISTS `scenario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descr` text COLLATE utf8_unicode_ci NOT NULL,
  `attacker_briefing` text COLLATE utf8_unicode_ci NOT NULL,
  `defender_briefing` text COLLATE utf8_unicode_ci NOT NULL,
  `start_hour` int(11) NOT NULL,
  `latitude` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `longitude` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `orbat_attacker` int(11) NOT NULL,
  `orbat_defender` int(11) NOT NULL,
  `video_intro` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scenario`
--

LOCK TABLES `scenario` WRITE;
/*!40000 ALTER TABLE `scenario` DISABLE KEYS */;
INSERT INTO `scenario` VALUES (4,'Small meeting engagement at Jena','<p>You are to clear the area around Vierzehnheiligen</p>','<p>You are to advance and inflict total defeat on the French before Napoleon arrives</p>',6,'','',11,9,'');
/*!40000 ALTER TABLE `scenario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit`
--

DROP TABLE IF EXISTS `unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `parent_me` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `unit_type` int(11) NOT NULL,
  `is_command` enum('T','F') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'F',
  `is_me` enum('T','F') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'F',
  `type_id` int(11) NOT NULL,
  `strength` int(11) NOT NULL,
  `officers` int(11) NOT NULL,
  `ace` int(11) NOT NULL,
  `morale_grade` int(11) NOT NULL,
  `small_arms` int(11) NOT NULL,
  `starting_morale_state` int(11) NOT NULL DEFAULT '1',
  `starting_fatigue` int(11) NOT NULL,
  `breakpoint` int(11) NOT NULL DEFAULT '20',
  `orbat_id` int(11) NOT NULL,
  `starting_formation` enum('CL','LN','SQ','CC','OO','HS') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CL',
  `cover` enum('','L','M','H','S') COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `starting_disorder` int(11) NOT NULL COMMENT 'percentage disordered 0 = good order, 50 = normal disorder, 90 = real bad, 10 = a little bit',
  PRIMARY KEY (`id`),
  KEY `parentid` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit`
--

LOCK TABLES `unit` WRITE;
/*!40000 ALTER TABLE `unit` DISABLE KEYS */;
INSERT INTO `unit` VALUES (200,0,0,'Hohenlohe\'s Army',1,'T','F',1,0,0,0,0,0,1,0,20,9,'CL','',0),(201,200,0,'Southern Wing Command',3,'T','F',1,0,0,0,0,0,1,0,20,9,'CL','',0),(202,201,0,'Advanced Guard Division',4,'T','F',1,0,0,0,0,0,1,0,20,9,'CL','',0),(203,202,0,'Infantry Brigade Belvilaqua',5,'F','F',1,0,0,0,0,0,1,0,20,9,'CL','',0),(204,203,0,'Müffling Infantry Regiment # 49, two battalions',10,'F','F',1,1280,10,10,6,5,1,0,20,9,'CL','',0),(205,203,0,'Prince Clemens Saxon Infantry Regiment, two battalions',10,'F','F',2,1280,10,10,6,5,1,0,20,9,'CL','',0),(206,203,0,'Kürfurst Saxon Infantry Regiment, two battalions',10,'F','F',3,1280,10,10,6,6,1,0,20,9,'CL','',0),(207,203,0,'Hoyer Foot Artillery Battery, six 4-pound guns',12,'F','F',1,6,10,10,6,6,1,0,20,9,'CL','',0),(208,202,0,'Brigade von Pelet',5,'F','F',2,0,0,0,0,0,1,0,20,9,'CL','',0),(209,208,0,'Rabenau Fusilier Battalion # 13',10,'F','F',4,600,10,10,6,5,1,0,20,9,'CL','',0),(210,208,0,'Pelet Fusilier Battalion # 14',10,'F','F',5,600,10,10,6,6,1,0,20,9,'CL','',0),(211,208,0,'Rühle Fusilier Battalion # 15',10,'F','F',6,600,10,10,6,5,1,0,20,9,'CL','',0),(212,208,0,'Masars and Valentin Foot Jäger companies',10,'F','F',7,200,10,10,5,5,1,0,20,9,'CL','',0),(213,208,0,'Reimann Foot Artillery Battery, six 6-pound guns',12,'F','F',2,6,10,10,5,5,1,0,20,9,'CL','',0),(214,202,0,'Cavalry Brigade von Schimmelpfennig',6,'F','T',1,0,0,0,0,0,1,0,20,9,'CL','',0),(215,214,214,'Schimmelpfennig Hussar Regiment # 6, ten squadrons',11,'F','F',1,1200,10,20,6,6,1,0,20,9,'CL','',0),(216,214,0,'Gause Horse Artillery Battery # 2, eight 6-pound guns',12,'F','F',3,8,10,10,6,6,1,0,20,9,'CL','',0),(217,202,0,'Cavalry Brigade von Trützschler',6,'F','T',2,0,0,0,0,0,1,0,20,9,'CL','',0),(218,217,217,'Saxon Hussar Regiment, eight squadrons',11,'F','F',2,800,10,20,6,6,1,0,20,9,'CL','',0),(219,201,0,'1st Division',4,'T','F',2,0,0,0,0,0,1,0,20,9,'CL','',0),(220,219,0,'Brigade von Muffling',5,'F','T',3,0,0,0,0,0,1,0,20,9,'CL','',0),(221,220,220,'Hahn Grenadier battalion (29/32)',10,'F','F',8,600,10,10,3,3,1,0,20,9,'CL','',0),(222,220,220,'Hohenlohe Infantry Regiment # 32, two battalions',10,'F','F',9,1200,10,10,6,5,1,0,20,9,'CL','',0),(223,220,220,'Sanitz Infantry Regiment # 50, two battalions',10,'F','F',10,1200,10,10,6,6,1,0,20,9,'CL','',0),(224,220,220,'Giasenapp Foot Artillery battery # 7, six 12-pound guns',12,'F','F',4,6,10,10,6,6,1,0,20,9,'CL','',0),(225,219,0,'Brigade von Schimonsky',5,'F','T',4,0,0,0,0,0,1,0,20,9,'CL','',0),(226,225,225,'Sack Grenadier battalion (33/42)',10,'F','F',11,600,10,10,3,3,1,0,20,9,'CL','',0),(227,225,225,'Grawert Infantry Regiment # 37, two battalions',10,'F','F',12,1200,10,10,6,5,1,0,20,9,'CL','',0),(228,225,225,'Zastrow Infantry Regiment # 39, two battalions',10,'F','F',13,1200,10,10,6,6,1,0,20,9,'CL','',0),(229,225,225,'Wolframsdorf Foot Artillery battery # 8, six 12-pound guns',12,'F','F',5,6,10,10,6,6,1,0,20,9,'CL','',0),(230,219,0,'Cavalry Brigade von Holtzendorff',6,'F','T',3,0,0,0,0,0,1,0,20,9,'CL','',0),(231,230,230,'Krafft Dragoon Regiment # 11, five squadrons',11,'F','F',3,500,10,24,6,6,1,0,20,9,'CL','',0),(232,230,230,'Henkel Cuirassier Regiment # 1, five squadrons',11,'F','F',4,600,10,27,2,5,1,0,20,9,'CL','',0),(233,230,230,'Holtzendorff Cuirassier Regiment # 9, five squadrons',11,'F','F',5,600,10,27,3,5,1,0,20,9,'CL','',0),(234,230,0,'Steinwehr Horse Artillery battery # 9, six 6-pound guns',12,'F','F',6,6,10,10,6,6,1,0,20,9,'CL','',0),(235,219,0,'Light Brigade',5,'F','T',5,0,0,0,0,0,1,0,20,9,'CL','',0),(236,235,235,'Erichsen Fusilier battalion # 10',10,'F','F',14,600,10,10,6,5,1,0,20,9,'CL','',0),(237,235,235,'Gettkandt Hussar Regiment # 1, ten squadrons',11,'F','F',6,1000,10,20,6,6,1,0,20,9,'CL','',0),(238,235,235,'Studnitz Prussian Horse Artillery battery # 14 (-), four 4-pound guns',12,'F','F',7,4,10,10,6,6,1,0,20,9,'CL','',0),(239,201,0,'2nd (Saxon) Division',4,'T','F',3,0,0,0,0,0,1,0,20,9,'CL','',0),(240,239,0,'Brigade von Burgsdorff',5,'F','F',6,0,0,0,0,0,1,0,20,9,'CL','',0),(241,240,0,'Thümmel Saxon Infantry Regiment, two battalions',10,'F','F',15,1280,10,10,6,6,1,0,20,9,'CL','',0),(242,240,0,'Prince Xavier Saxon Infantry Regiment, two battalions',10,'F','F',16,1280,10,10,6,6,1,0,20,9,'CL','',0),(243,240,0,'Haussmar Saxon Foot Artillery battery, eight 12-pound guns',12,'F','F',8,8,10,10,6,6,1,0,20,9,'CL','',0),(244,240,0,'Ernst Saxon Foot Artillery battery, eight 12-pound guns',12,'F','F',9,8,10,10,6,6,1,0,20,9,'CL','',0),(245,239,0,'Brigade von Dyherrn',5,'F','F',7,0,0,0,0,0,1,0,20,9,'CL','',0),(246,245,0,'Low Saxon Infantry Regiment, two battalions',10,'F','F',17,1280,10,10,6,6,1,0,20,9,'CL','',0),(247,245,0,'Niesemeuschel Saxon Infantry Regiment, two battalions',10,'F','F',18,1280,10,10,6,6,1,0,20,9,'CL','',0),(248,245,0,'Bevilaqua Saxon Infantry Regiment, 2nd battalion',10,'F','F',19,640,10,10,6,6,1,0,20,9,'CL','',0),(249,245,0,'Bonniot Saxon Foot Artillery battery # 8, ten 12-pound guns',12,'F','F',10,10,10,10,6,6,1,0,20,9,'CL','',0),(250,239,0,'Cavalry Brigade: von Kochtitsky',6,'F','T',4,0,0,0,0,0,1,0,20,9,'CL','',0),(251,250,250,'Mounted Carabinier Saxon Regiment, four squadron',11,'F','F',7,480,10,27,6,6,1,0,20,9,'CL','',0),(252,250,250,'Kochtitsky Saxon Cuirassier Regiment, four squadrons',11,'F','F',8,480,10,27,6,6,1,0,20,9,'CL','',0),(253,250,250,'Prince Albert Saxon Chevau-léger Regiment, four squadrons',11,'F','F',9,480,10,20,6,6,1,0,20,9,'CL','',0),(254,250,0,'Grossman Saxon Horse Artillery battery, ten guns',12,'F','F',11,10,10,10,6,6,1,0,20,9,'CL','',0),(255,239,0,'Light Brigade von Polenz',5,'F','F',8,0,0,0,0,0,1,0,20,9,'CL','',0),(256,255,0,'Boguslawsky Prussian Fusilier battalion # 22',10,'F','F',20,720,10,10,6,6,1,0,20,9,'CL','',0),(257,255,255,'Polenz Saxon Chevau-léger Regiment, four squadrons',11,'F','F',10,720,10,20,6,6,1,0,20,9,'CL','',0),(258,255,0,'Studnitz Prussian Horse Artillery battery # 14 (-), five guns',12,'F','F',12,5,10,10,6,6,1,0,20,9,'CL','',0),(132,117,0,'3rd Foot Artillery Regiment, 3rd company',12,'F','F',24,4,10,10,4,4,1,0,20,11,'CL','',0),(131,128,0,'Nassau Infantrie Regiment, 3rd Bn',10,'F','F',64,720,10,10,6,6,1,0,20,11,'CL','',0),(130,128,0,'Hesse Darmstadt Fuslier, 1st Bn',10,'F','F',63,640,10,10,6,6,1,0,20,11,'CL','',0),(129,128,0,'Hesse Darmstadt Fuslier, 1st Bn',10,'F','F',62,640,10,10,6,6,1,0,20,11,'CL','',0),(128,117,0,'Brigade Allied',5,'F','F',18,0,0,0,0,0,1,0,20,11,'CL','',0),(127,122,0,'63eme Ligne, 2e Bn',10,'F','F',61,720,10,10,6,6,1,0,20,11,'CL','',0),(126,122,0,'63eme Ligne, 1e Bn',10,'F','F',60,720,10,10,6,6,1,0,20,11,'CL','',0),(125,122,0,'24eme Ligne, 3e Bn',10,'F','F',59,720,10,10,6,6,1,0,20,11,'CL','',0),(124,122,0,'24eme Ligne, 2e Bn',10,'F','F',58,720,10,10,6,6,1,0,20,11,'CL','',0),(123,122,0,'24eme Ligne, 1e Bn',10,'F','F',57,720,10,10,6,6,1,0,20,11,'CL','',0),(122,117,0,'Brigade d\' Ligne Sarrut',5,'F','F',17,0,0,0,0,0,1,0,20,11,'CL','',0),(121,118,0,'7eme Legere, 3e Bn',10,'F','F',56,720,10,14,4,4,1,0,20,11,'CL','',0),(120,118,0,'7eme Legere, 2e Bn',10,'F','F',55,720,10,14,4,4,1,0,20,11,'CL','',0),(119,118,0,'7eme Legere, 1e Bn',10,'F','F',54,720,10,14,4,4,1,0,20,11,'CL','',0),(118,117,0,'Brigade d\' Legere Amey',5,'F','F',16,0,0,0,0,0,1,0,20,11,'CL','',0),(117,100,0,'2nd Division: de Bierre',4,'T','F',8,0,0,0,0,0,1,0,20,11,'CL','',0),(116,101,101,'6th Horse Artillery Regiment, 2nd company',12,'F','F',23,4,10,10,4,4,1,0,20,11,'CL','',0),(115,101,101,'3rd Foot Artillery Regiment, 4th company',12,'F','F',22,4,10,10,4,4,1,0,20,11,'CL','',0),(114,107,101,'105eme Ligne, 3e Bn',10,'F','F',53,720,10,10,6,6,1,0,20,11,'CL','',0),(113,107,101,'105eme Ligne, 2e Bn',10,'F','F',52,720,10,10,6,6,1,0,20,11,'CL','',0),(112,107,101,'105eme Ligne, 1e Bn',10,'F','F',51,720,10,10,6,6,1,0,20,11,'CL','',0),(111,107,101,'44eme Ligne, 3e Bn',10,'F','F',50,720,10,10,6,6,1,0,20,11,'CL','',0),(110,107,101,'44eme Ligne, 2e Bn',10,'F','F',49,720,10,10,6,6,1,0,20,11,'CL','',0),(109,107,101,'44eme Ligne, 1e Bn',10,'F','F',48,720,10,10,6,6,1,0,20,11,'CL','',0),(108,107,101,'14eme Legere, 2e Bn',10,'F','F',47,720,10,14,4,4,1,0,20,11,'CL','',0),(107,101,101,'Brigade d\' Ligne Lefranc',5,'F','F',15,0,0,0,0,0,1,0,20,11,'CL','',0),(106,102,101,'16eme Legere, 4e Bn',10,'F','F',46,720,10,14,4,4,1,0,20,11,'CL','',0),(105,102,101,'16eme Legere, 3e Bn',10,'F','F',45,720,10,14,4,4,1,0,20,11,'CL','',0),(104,102,101,'16eme Legere, 2e Bn',10,'F','F',44,720,10,14,4,4,1,0,20,11,'CL','',0),(103,102,101,'16eme Legere, 1e Bn',10,'F','F',43,720,10,14,4,4,1,0,20,11,'CL','',0),(102,101,101,'Brigade d\' Legere Lapisse',5,'F','F',14,0,0,0,0,0,1,0,20,11,'CL','',0),(101,100,0,'1st Division: Desjardin',4,'T','T',7,0,0,0,0,0,1,0,20,11,'CL','',0),(100,0,0,'French VII Corps 1806 - Augereau',2,'T','F',3,0,0,0,0,0,1,0,20,11,'CL','',0),(133,117,0,'6th Horse Artillery Regiment, 2nd company',12,'F','F',25,4,10,10,4,4,1,0,20,11,'CL','',0),(134,100,0,'Brigade d\' Cheval  Auguste Durosnel',6,'F','T',6,0,0,0,0,0,1,0,20,11,'CL','',0),(135,134,134,'7e Chasseurs',11,'F','F',13,480,10,20,6,6,1,0,20,11,'CL','',0),(136,134,134,'20e Chasseurs',11,'F','F',14,360,10,20,6,6,1,0,20,11,'CL','',0),(137,134,0,'6th Horse Artillery Regiment, 5th company',12,'F','F',26,4,10,10,4,4,1,0,20,11,'CL','',0),(138,100,0,'Corps Artillery',4,'T','F',9,0,0,0,0,0,1,0,20,11,'CL','',0),(139,138,0,'Heavy battery',12,'F','F',27,4,10,10,5,5,1,0,20,11,'CL','',0),(140,138,0,'1e Artillery d Pied',12,'F','F',28,6,10,10,5,5,1,0,20,11,'CL','',0),(141,138,0,'1e Artillery d pied',12,'F','F',29,6,10,10,5,5,1,0,20,11,'CL','',0),(142,138,0,'2e Artillery d Cheval',12,'F','F',30,4,10,10,5,5,1,0,20,11,'CL','',0);
/*!40000 ALTER TABLE `unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_army`
--

DROP TABLE IF EXISTS `unit_army`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_army` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commander` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `inspiration` int(11) NOT NULL,
  `professional_skill` int(11) NOT NULL,
  `doctrine` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_army`
--

LOCK TABLES `unit_army` WRITE;
/*!40000 ALTER TABLE `unit_army` DISABLE KEYS */;
INSERT INTO `unit_army` VALUES (1,'Frederick Louis, Prince of Hohenlohe-Ingelfingen',2,5,2);
/*!40000 ALTER TABLE `unit_army` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_battalion`
--

DROP TABLE IF EXISTS `unit_battalion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_battalion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num_bases` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ranks` enum('3','2','Open') COLLATE utf8_unicode_ci NOT NULL,
  `skirmishers` int(11) NOT NULL,
  `open_order` enum('T','F') COLLATE utf8_unicode_ci NOT NULL,
  `rifles` enum('T','F') COLLATE utf8_unicode_ci NOT NULL,
  `closed_column` enum('T','F') COLLATE utf8_unicode_ci NOT NULL,
  `shock_troops` enum('T','F') COLLATE utf8_unicode_ci NOT NULL,
  `battalion_guns` enum('T','F') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_battalion`
--

LOCK TABLES `unit_battalion` WRITE;
/*!40000 ALTER TABLE `unit_battalion` DISABLE KEYS */;
INSERT INTO `unit_battalion` VALUES (1,'','3',0,'F','F','F','F','T'),(2,'','3',0,'F','F','F','F','T'),(3,'','3',0,'F','F','F','F','T'),(4,'','3',1,'T','F','F','F','F'),(5,'','3',1,'T','F','F','F','F'),(6,'','3',1,'T','F','F','F','F'),(7,'','3',1,'T','F','F','F','F'),(8,'','3',0,'F','F','F','T','F'),(9,'','3',0,'F','F','F','F','T'),(10,'','3',0,'F','F','F','F','T'),(11,'','3',0,'F','F','F','T','F'),(12,'','3',0,'F','F','F','F','T'),(13,'','3',0,'F','F','F','F','T'),(14,'','3',1,'T','F','F','F','F'),(15,'','3',0,'F','F','F','F','T'),(16,'','3',0,'F','F','F','F','T'),(17,'','3',0,'F','F','F','F','F'),(18,'','3',0,'F','F','F','F','F'),(19,'','3',0,'F','F','F','F','F'),(20,'','3',0,'T','F','F','F','F'),(64,'4','3',0,'F','F','F','F','F'),(63,'4','3',0,'F','F','F','F','F'),(62,'4','3',0,'F','F','F','F','F'),(61,'4','3',1,'T','F','T','F','F'),(60,'4','3',1,'T','F','T','F','F'),(59,'4','3',1,'T','F','T','F','F'),(58,'4','3',1,'T','F','T','F','F'),(57,'4','3',1,'T','F','T','F','F'),(56,'4','3',2,'T','F','T','F','F'),(55,'4','3',2,'T','F','T','F','F'),(54,'4','3',2,'T','F','T','F','F'),(53,'4','3',1,'T','F','T','F','F'),(52,'4','3',1,'T','F','T','F','F'),(51,'4','3',1,'T','F','T','F','F'),(50,'4','3',1,'T','F','T','F','F'),(49,'4','3',1,'T','F','T','F','F'),(48,'4','3',1,'T','F','T','F','F'),(47,'4','3',2,'T','F','F','F','F'),(46,'4','3',2,'T','F','T','F','F'),(45,'4','3',2,'T','F','T','F','F'),(44,'4','3',2,'T','F','T','F','F'),(43,'4','3',2,'T','F','T','F','F');
/*!40000 ALTER TABLE `unit_battalion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_battery`
--

DROP TABLE IF EXISTS `unit_battery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_battery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('Foot','Horse') COLLATE utf8_unicode_ci NOT NULL,
  `calibre` enum('4lb','6lb','8lb','12lb') COLLATE utf8_unicode_ci NOT NULL,
  `gun_models` int(11) NOT NULL,
  `crew_figures` int(11) NOT NULL,
  `howitzers` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `class` enum('OldGuard','Class I','Class II','Class III') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_battery`
--

LOCK TABLES `unit_battery` WRITE;
/*!40000 ALTER TABLE `unit_battery` DISABLE KEYS */;
INSERT INTO `unit_battery` VALUES (1,'Foot','4lb',3,2,'0','Class II'),(2,'Foot','6lb',2,3,'0','Class II'),(3,'Horse','6lb',3,3,'0','Class II'),(4,'Foot','12lb',2,3,'0','Class II'),(5,'Foot','12lb',2,3,'0','Class II'),(6,'Horse','6lb',2,3,'0','Class II'),(7,'Horse','4lb',2,2,'0','Class II'),(8,'Foot','12lb',2,4,'0','Class II'),(9,'Foot','12lb',2,4,'0','Class II'),(10,'Foot','12lb',2,4,'0','Class II'),(11,'Horse','6lb',4,2,'0','Class II'),(12,'Horse','4lb',2,2,'0','Class II'),(27,'Foot','12lb',1,4,'0','Class I'),(26,'Horse','4lb',2,2,'','Class I'),(25,'Horse','6lb',2,2,'','Class I'),(24,'Foot','12lb',1,4,'2 x 6\" Howitzer','Class I'),(23,'Horse','6lb',2,2,'','Class I'),(22,'Foot','12lb',1,4,'2 x 6\" Howitzer','Class I'),(28,'Foot','8lb',2,3,'2 x 6\" howitzers','Class I'),(29,'Foot','8lb',2,3,'2 x 6\" howitzer','Class I'),(30,'Horse','4lb',2,2,'','Class I');
/*!40000 ALTER TABLE `unit_battery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_brigade`
--

DROP TABLE IF EXISTS `unit_brigade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_brigade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commander` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `inspiration` int(11) NOT NULL,
  `drill` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_brigade`
--

LOCK TABLES `unit_brigade` WRITE;
/*!40000 ALTER TABLE `unit_brigade` DISABLE KEYS */;
INSERT INTO `unit_brigade` VALUES (1,'General-Major von Bevilaqua',3,1),(2,'General-Major Karl Gerhard von Pelet',3,1),(3,'General-Major Johann Friedrich Wilhelm von Müffling',3,1),(4,'General-Major Christian Friedrich von Schimonsky',3,1),(5,'Oberst von Erichsen',3,1),(6,'General-Major von Burgsdorff',3,1),(7,'General-Major von Dyherrn',3,1),(8,'Oberst Karl Anton Andreas von Boguslawsky',3,1),(17,'General of Brigade Jacques Thomas Sarrut',3,2),(16,'General of Brigade François Pierre Amey',2,2),(15,'General of Brigade Jacques Lefranc',3,2),(14,'General of Brigade Pierre Belon Lapisse',2,2),(18,'General of Brigade Prinz Karl von Hesse Darmstadt',3,1);
/*!40000 ALTER TABLE `unit_brigade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_cavbrigade`
--

DROP TABLE IF EXISTS `unit_cavbrigade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_cavbrigade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commander` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `inspiration` int(11) NOT NULL,
  `battle_group` enum('T','F') COLLATE utf8_unicode_ci NOT NULL,
  `doctrine` enum('Scouting','Packed','Linear') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_cavbrigade`
--

LOCK TABLES `unit_cavbrigade` WRITE;
/*!40000 ALTER TABLE `unit_cavbrigade` DISABLE KEYS */;
INSERT INTO `unit_cavbrigade` VALUES (1,'General-Major Christian Ludwig von Schimmelpfennig',3,'T','Packed'),(2,'General-Major von Trützschler',3,'T','Packed'),(3,'General-Leutnant Friedrich Jacob von Holtzendorff',3,'T','Packed'),(4,'General-Leutnant Joachim Friedrich von Zeschwitz',3,'T','Linear'),(6,'General of Brigade Antoine Jean Auguste Durosnel',3,'T','Packed');
/*!40000 ALTER TABLE `unit_cavbrigade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_corps`
--

DROP TABLE IF EXISTS `unit_corps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_corps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commander` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `inspiration` int(11) NOT NULL,
  `professional_skill` int(11) NOT NULL,
  `doctrine` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_corps`
--

LOCK TABLES `unit_corps` WRITE;
/*!40000 ALTER TABLE `unit_corps` DISABLE KEYS */;
INSERT INTO `unit_corps` VALUES (1,'Hohenlohe',3,6,2),(3,'Marshal Pierre Augereau',2,2,3);
/*!40000 ALTER TABLE `unit_corps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_division`
--

DROP TABLE IF EXISTS `unit_division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_division` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commander` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `inspiration` int(11) NOT NULL,
  `professional_skill` int(11) NOT NULL,
  `doctrine` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_division`
--

LOCK TABLES `unit_division` WRITE;
/*!40000 ALTER TABLE `unit_division` DISABLE KEYS */;
INSERT INTO `unit_division` VALUES (1,'General-Leutnant Prince Louis Ferdinand',2,5,2),(2,'General-Leutnant Julius von Grawert',3,5,2),(3,'General der Kavallerie Hans Gottlob von Zeschwitz',3,6,2),(8,'General of Division Étienne Heudelet de Bierre',3,3,3),(7,'General of Division Jacques Desjardin',3,3,3),(9,'',3,3,3);
/*!40000 ALTER TABLE `unit_division` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_squadron`
--

DROP TABLE IF EXISTS `unit_squadron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_squadron` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cavalry_type` int(11) NOT NULL,
  `num_bases` int(11) NOT NULL,
  `battle_cavalry` enum('T','F') COLLATE utf8_unicode_ci NOT NULL,
  `undistinguished` enum('T','F') COLLATE utf8_unicode_ci NOT NULL,
  `skirmisher` enum('T','F') COLLATE utf8_unicode_ci NOT NULL,
  `move_rate` enum('Light','Heavy') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_squadron`
--

LOCK TABLES `unit_squadron` WRITE;
/*!40000 ALTER TABLE `unit_squadron` DISABLE KEYS */;
INSERT INTO `unit_squadron` VALUES (1,1,0,'F','F','','Light'),(2,1,0,'F','F','','Light'),(3,4,0,'T','F','','Heavy'),(4,7,0,'T','F','','Heavy'),(5,7,0,'T','F','','Heavy'),(6,4,0,'F','F','','Light'),(7,8,0,'T','F','','Heavy'),(8,4,0,'T','F','','Heavy'),(9,3,0,'F','F','','Light'),(10,3,0,'F','F','','Light'),(14,2,3,'F','F','','Light'),(13,2,4,'F','F','','Light');
/*!40000 ALTER TABLE `unit_squadron` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_type`
--

DROP TABLE IF EXISTS `unit_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_type`
--

LOCK TABLES `unit_type` WRITE;
/*!40000 ALTER TABLE `unit_type` DISABLE KEYS */;
INSERT INTO `unit_type` VALUES (1,'Army'),(2,'Corps'),(3,'Wing'),(4,'Division'),(5,'Brigade'),(10,'Battalion'),(6,'CavBrigade'),(11,'Squadron'),(12,'Battery');
/*!40000 ALTER TABLE `unit_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime NOT NULL,
  `email` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `admin` enum('T','F') COLLATE utf8_unicode_ci NOT NULL,
  `role` enum('X','A','U','P','S') COLLATE utf8_unicode_ci NOT NULL,
  `current_game` int(11) NOT NULL,
  `commander_id` int(11) NOT NULL,
  `national_theme` int(11) NOT NULL DEFAULT '1',
  `portrait` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (8,'umpire','51af21c411643bd7a7e8d77e0d3c9acd','2012-04-20 18:33:11','steveoc64@gmail,com','T','U',0,0,1,''),(9,'duke of brunswick','5d2bbc279b5ce75815849d5e3f0533ec','2012-05-04 18:15:35','steveoc64@gmail,com','F','P',4,219,2,''),(10,'augereau','88e77ff74930f37010370c296d14737b','2012-05-04 18:44:11','steveoc64@gmail,com','F','P',4,101,1,''),(20,'admin','21232f297a57a5a743894a0e4a801fc3','2012-05-04 14:36:21','steveoc64@gmail.com','F','A',4,0,0,''),(25,'wartensleben','b50cd72da9f57f8bf6880303ff5b7622','2012-05-04 13:53:52','steveoc64@gmail.com','F','P',0,0,2,'');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `seq` int(11) NOT NULL,
  `role` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`role`),
  UNIQUE KEY `seq` (`seq`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,'A','Admin'),(2,'U','Umpire'),(3,'P','Player'),(4,'S','Solo Player'),(5,'X','Not yet validated');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-05-05  6:13:22
