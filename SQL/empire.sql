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
INSERT INTO `ci_sessions` VALUES ('be9bf3cbff8096a5d71a85b7bbb6ce08','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:9.0.1) Gecko/20100101 Firefox/9.0.1',1334445477,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:1:\"9\";s:8:\"username\";s:17:\"duke of brunswick\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}'),('9ffb867137050fe9ef1f9b57d3ea5b79','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0',1333825103,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:2:\"20\";s:8:\"username\";s:5:\"admin\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"A\";}'),('d567e11c41eaef4bf8e1f6f52622ff60','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0',1333905809,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:2:\"20\";s:8:\"username\";s:5:\"admin\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"A\";}'),('27b7967f1ca026640767bd14240e9b4e','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0',1333893276,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:2:\"10\";s:8:\"username\";s:8:\"augereau\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}'),('6a953d9cf342659f8bfaeb2a7fbe48a8','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0',1333907753,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:1:\"9\";s:8:\"username\";s:17:\"duke of brunswick\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}'),('54563076f13a3fea0a596fe8bb45acc4','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0',1333964899,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:2:\"25\";s:8:\"username\";s:12:\"wartensleben\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}'),('f5e066d05a5d5ff9baadcce66628d28b','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0',1333906055,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:2:\"20\";s:8:\"username\";s:5:\"admin\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"A\";}'),('ef5fae358f40f85caadc422a08cb5d1c','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0',1334159053,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:1:\"9\";s:8:\"username\";s:17:\"duke of brunswick\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}'),('d8cfe6edf4a47f76ce7b70c7ce335cae','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0',1333970276,'a:4:{s:7:\"user_id\";s:2:\"25\";s:8:\"username\";s:12:\"wartensleben\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}'),('e6f2552830e657c8c7d0426665569d44','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0',1333968774,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:2:\"10\";s:8:\"username\";s:8:\"augereau\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}'),('c662099942bd415738d457c30016b1f5','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0',1333972850,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:1:\"8\";s:8:\"username\";s:6:\"umpire\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"U\";}'),('be3d9787c8b2b01063c1fbb34706a1f8','203.122.194.178','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0',1334446880,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:2:\"20\";s:8:\"username\";s:5:\"admin\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"A\";}'),('b792b6b1c8086c0e805cfc19e092f668','203.122.194.178','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2',1334441302,'a:5:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:1:\"9\";s:8:\"username\";s:17:\"duke of brunswick\";s:12:\"is_logged_in\";b:1;s:4:\"role\";s:1:\"P\";}');
/*!40000 ALTER TABLE `ci_sessions` ENABLE KEYS */;
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
  `video_intro` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (1,'Weekend test game',2,'',5,2,3,4,3,'<p>Jena-Auerstaedt 1806.    Prussian Northern wing slips past Davout, and hits Augereau\'s Corps first.</p>','','','50.64','11.52',60,120,'');
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
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
  `descr` int(11) NOT NULL,
  PRIMARY KEY (`game_id`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_engagement`
--

LOCK TABLES `game_engagement` WRITE;
/*!40000 ALTER TABLE `game_engagement` DISABLE KEYS */;
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
  KEY `game_id` (`game_id`,`turn_number`),
  KEY `unit_id` (`unit_id`,`game_id`,`turn_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_event`
--

LOCK TABLES `game_event` WRITE;
/*!40000 ALTER TABLE `game_event` DISABLE KEYS */;
INSERT INTO `game_event` VALUES (1,1,100,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,101,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,102,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,103,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,104,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,105,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,106,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,107,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,108,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,109,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,110,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,111,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,112,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,113,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,114,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,115,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,116,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,117,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,118,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,119,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,120,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,121,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,122,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,123,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,124,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,125,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,126,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,127,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,128,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,129,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,130,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,131,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,132,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,133,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,134,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,135,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,136,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,137,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,138,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,139,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,140,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,141,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,142,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,143,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,144,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,145,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,146,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,147,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,148,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,149,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,150,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,151,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,152,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,153,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,154,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,155,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,156,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,157,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,158,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,159,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',1),(1,1,200,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,201,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,202,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,203,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,204,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,205,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,206,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,207,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,208,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,209,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,210,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,211,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,212,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,213,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,214,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,215,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,216,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,217,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,218,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,219,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,220,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,221,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,222,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,223,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,224,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,225,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,226,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,227,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,228,2,'Unit joins scenario Jena-Auerstaedt 1806.  \\n\\nPrussian Northern wing slips past Davout, and hits Augereau\\\'s Corps first.',0),(1,1,106,7,'Closed with the bayonet against the 44e ligne',0),(1,2,107,7,'Closed with the bayonet against the 58e legere',0),(1,2,103,23,'Unit is shaken, as the ME failed a determination test',2),(1,2,103,23,'Unit is shaken, as the ME failed a determination test',2),(1,2,103,23,'Unit is shaken, as the ME failed a determination test',2),(1,2,103,23,'Unit is shaken, as the ME failed a determination test',2),(1,2,103,23,'Unit is shaken, as the ME failed a determination test',2),(1,2,103,23,'Unit is shaken, as the ME failed a determination test',2),(1,2,104,23,'Unit is shaken, as the ME failed a determination test',2),(1,2,105,23,'Unit is shaken, as the ME failed a determination test',2),(1,2,106,23,'Unit is shaken, as the ME failed a determination test',2),(1,2,107,23,'Unit is shaken, as the ME failed a determination test',2),(1,2,103,23,'Unit is shaken, as the ME failed a determination test. 97 men had fled the ranks',2),(1,2,104,23,'Unit is shaken, as the ME failed a determination test. 61 men had fled the ranks',2),(1,2,105,23,'Unit is shaken, as the ME failed a determination test. 48 men had fled the ranks',2),(1,2,106,23,'Unit is shaken, as the ME failed a determination test. 10 men had fled the ranks',2),(1,2,107,23,'Unit is shaken, as the ME failed a determination test. 74 men had fled the ranks',2),(1,2,103,23,'Unit is shaken, as the ME failed a determination test. 29 men had fled the ranks',2),(1,2,104,23,'Unit is shaken, as the ME failed a determination test. 96 men had fled the ranks',2),(1,2,105,23,'Unit is shaken, as the ME failed a determination test. 36 men had fled the ranks',2),(1,2,106,23,'Unit is shaken, as the ME failed a determination test. 60 men had fled the ranks',2),(1,2,107,23,'Unit is shaken, as the ME failed a determination test. 32 men had fled the ranks',2),(1,2,103,23,'Unit is shaken, as the ME failed a determination test. 44 men had fled the ranks',2),(1,2,104,23,'Unit is shaken, as the ME failed a determination test. 52 men had fled the ranks',2),(1,2,105,23,'Unit is shaken, as the ME failed a determination test. 82 men had fled the ranks',2),(1,2,106,23,'Unit is shaken, as the ME failed a determination test. 42 men had fled the ranks',2),(1,2,107,23,'Unit is shaken, as the ME failed a determination test. 34 men had fled the ranks',2),(1,2,103,23,'Unit is shaken, as the ME failed a determination test. 14 men had fled the ranks',2),(1,2,104,23,'Unit is shaken, as the ME failed a determination test. 30 men had fled the ranks',2),(1,2,105,23,'Unit is shaken, as the ME failed a determination test. 41 men had fled the ranks',2),(1,2,106,23,'Unit is shaken, as the ME failed a determination test. 46 men had fled the ranks',2),(1,2,107,23,'Unit is shaken, as the ME failed a determination test. 14 men had fled the ranks',2),(1,2,103,23,'Unit is retreat, as the ME failed a determination test. 93 men had fled the ranks',3),(1,2,103,22,'In disgrace for retreating without orders',3),(1,2,103,23,'Unit is retreat, as the ME failed a determination test. 160 men had fled the ranks',3),(1,2,103,22,'In disgrace for retreating without orders',3),(1,2,103,23,'Unit is retreat, as the ME failed a determination test. 47 men had fled the ranks',3),(1,2,103,22,'In disgrace for retreating without orders',3),(1,2,103,23,'Unit is retreat, as the ME failed a determination test. 133 men had fled the ranks',3),(1,2,103,22,'In disgrace for retreating without orders',3),(1,2,103,23,'Unit is retreat, as the ME failed a determination test. 133 men had fled the ranks',3),(1,2,103,22,'In disgrace for retreating without orders',3);
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
INSERT INTO `game_me_det` VALUES (1,103,2,3,-41,31);
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
  PRIMARY KEY (`game_id`,`turn_number`,`seq`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_message`
--

LOCK TABLES `game_message` WRITE;
/*!40000 ALTER TABLE `game_message` DISABLE KEYS */;
INSERT INTO `game_message` VALUES (1,2,8,10,103,'Sir, we have immediate news that the officers and men of Fusilier Brigade von Oswald are shamefully losing confidence !','F',2,1),(1,2,7,9,103,'Sir, we have immediate news that the officers and men of Fusilier Brigade von Oswald are shamefully losing confidence !','F',2,2),(1,2,6,8,103,'Sir, we have immediate news that the officers and men of Fusilier Brigade von Oswald are shamefully losing confidence !','F',2,3),(1,2,5,25,103,'Sir, we have immediate news that the officers and men of Fusilier Brigade von Oswald are shamefully losing confidence !','F',2,4),(1,2,4,20,103,'Sir, we have immediate news that the officers and men of Fusilier Brigade von Oswald are shamefully losing confidence !','T',2,5),(1,2,3,10,103,'Sir, we have immediate news that the officers and men of Fusilier Brigade von Oswald are shamefully losing confidence !','F',2,6),(1,2,2,9,103,'Sir, we have immediate news that the officers and men of Fusilier Brigade von Oswald are shamefully losing confidence !','F',2,1),(1,2,1,8,103,'Sir, we have immediate news that the officers and men of Fusilier Brigade von Oswald are shamefully losing confidence !','F',2,2),(1,3,2,10,201,'From Division [201] Commander General of Division Jacques Desjardin<br>1st Division: Desjardin are taking some losses, but we are ready to carry on.','F',2,3),(1,3,1,9,103,'From Brigade [103] Commander General-Major Friedrich Gottlieb von Oswald<br>Fusilier Brigade von Oswald have sustained heavy losses - we must rest.','F',2,4),(1,2,9,20,103,'Sir, we have immediate news that the officers and men of Fusilier Brigade von Oswald are shamefully losing confidence !','T',2,5),(1,2,10,25,103,'Sir, we have immediate news that the officers and men of Fusilier Brigade von Oswald are shamefully losing confidence !','F',2,6),(1,3,3,9,103,'From Brigade [103] Commander General-Major Friedrich Gottlieb von Oswald<br>All is lost for Fusilier Brigade von Oswald, but we shall fight to the end.','T',2,1),(1,2,11,8,103,'Sir, we have astounding news that Fusilier Brigade von Oswald are in cowardly retreat !','F',2,5),(1,2,12,9,103,'Sir, we have astounding news that Fusilier Brigade von Oswald are in cowardly retreat !','T',2,5),(1,2,13,10,103,'Sir, we have astounding news that Fusilier Brigade von Oswald are in cowardly retreat !','F',2,5),(1,2,14,20,103,'Sir, we have astounding news that Fusilier Brigade von Oswald are in cowardly retreat !','T',2,4),(1,2,15,25,103,'Sir, we have astounding news that Fusilier Brigade von Oswald are in cowardly retreat !','F',2,5);
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
INSERT INTO `game_order` VALUES (1,1,1,100,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,101,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,102,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,103,'admin',1,'Crossroads','Initial deployment','0000-00-00 00:00:00'),(1,1,1,104,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,105,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,106,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,107,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,108,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,109,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,110,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,111,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,112,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,113,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,114,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,115,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,116,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,117,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,118,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,119,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,120,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,121,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,122,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,123,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,124,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,125,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,126,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,127,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,128,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,129,'admin',1,'Bridge','Initial deployment','0000-00-00 00:00:00'),(1,1,1,130,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,131,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,132,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,133,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,134,'admin',1,'Woods','Initial deployment','0000-00-00 00:00:00'),(1,1,1,135,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,136,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,137,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,138,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,139,'admin',1,'Road','Initial deployment','0000-00-00 00:00:00'),(1,1,1,140,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,141,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,142,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,143,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,144,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,145,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,146,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,147,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,148,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,149,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,150,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,151,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,152,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,153,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,154,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,155,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,156,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,157,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,158,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,159,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,200,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,201,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,202,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,203,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,204,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,205,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,206,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,207,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,208,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,209,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,210,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,211,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,212,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,213,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,214,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,215,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,216,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,217,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,218,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,219,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,220,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,221,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,222,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,223,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,224,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,225,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,226,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,227,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,1,228,'admin',1,'','Initial deployment','0000-00-00 00:00:00'),(1,1,0,217,'augereau',1,'to the death !','','2012-04-11 19:00:35'),(1,1,0,201,'augereau',3,'immediately to chateux d\\\'chenoncoix','','2012-04-11 19:01:20'),(1,1,0,114,'duke of brunswick',6,'to the rear','','2012-04-11 17:05:16'),(1,1,0,149,'duke of brunswick',2,'the bridge to the front','','2012-04-11 17:04:22'),(1,1,0,144,'duke of brunswick',2,'the bridge to the front','','2012-04-11 17:04:14'),(1,1,0,108,'duke of brunswick',2,'the bridge to the front','','2012-04-11 17:04:07'),(1,2,0,103,'duke of brunswick',5,'To the rear','','2012-04-13 07:50:43'),(1,2,0,124,'duke of brunswick',5,'Enter a short objective for the orders here.','','2012-04-13 14:23:24');
/*!40000 ALTER TABLE `game_order` ENABLE KEYS */;
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
  UNIQUE KEY `game_id` (`game_id`,`turn_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_turn`
--

LOCK TABLES `game_turn` WRITE;
/*!40000 ALTER TABLE `game_turn` DISABLE KEYS */;
INSERT INTO `game_turn` VALUES (1,1,1,0,0,'',25,1,0,0,1000,1,'Fine'),(1,2,1,0,0,'',28,2,12,0,800,1,'Morning fog');
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
  `formation` enum('CL','LN','CC','OO','SQ','HS') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CL',
  `engagement_id` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `did_close_combat` int(11) NOT NULL COMMENT 'did close combat last hour/ value = id of the event',
  `won_close_combat` int(11) NOT NULL COMMENT 'won a close combat last hour. value = id of the event',
  UNIQUE KEY `game_id` (`game_id`,`unit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_unit_stats`
--

LOCK TABLES `game_unit_stats` WRITE;
/*!40000 ALTER TABLE `game_unit_stats` DISABLE KEYS */;
INSERT INTO `game_unit_stats` VALUES (1,100,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,0,0,0),(1,101,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,102,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,103,'2012-04-14 20:52:54',0,0,3,20,20,0,0,0,0,0,0,984,0,0,80,80,678,'T','F','','CL',0,492,193,9,0,0),(1,104,'2012-04-14 13:44:53',780,10,2,5,20,303,0,0,0,0,0,303,0,0,80,80,259,'T','F','','CL',0,0,0,9,0,0),(1,105,'2012-04-14 13:44:53',780,10,2,5,20,227,0,0,0,0,0,227,0,0,80,80,210,'T','F','','CL',0,0,0,9,0,0),(1,106,'2012-04-14 13:44:53',780,10,2,5,20,780,500,0,0,0,0,206,0,0,80,80,160,'T','F','','CL',0,0,0,9,2,1),(1,107,'2012-04-14 13:44:53',780,10,2,5,20,780,300,0,0,0,0,177,0,0,80,80,197,'T','F','','CL',0,0,0,9,0,0),(1,108,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,746,193,9,0,0),(1,109,'0000-00-00 00:00:00',1200,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,110,'0000-00-00 00:00:00',1200,100,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,111,'0000-00-00 00:00:00',600,60,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,112,'0000-00-00 00:00:00',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,113,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,114,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,458,355,9,0,0),(1,115,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,116,'0000-00-00 00:00:00',1600,20,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,117,'0000-00-00 00:00:00',1600,20,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,118,'0000-00-00 00:00:00',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,119,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,723,355,9,0,0),(1,120,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,121,'0000-00-00 00:00:00',1600,20,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,122,'0000-00-00 00:00:00',1600,20,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,123,'0000-00-00 00:00:00',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,124,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,252,413,9,0,0),(1,125,'0000-00-00 00:00:00',500,50,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,126,'0000-00-00 00:00:00',500,50,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,127,'0000-00-00 00:00:00',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,128,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,25,0,0),(1,129,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,542,199,25,0,0),(1,130,'0000-00-00 00:00:00',830,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,25,0,0),(1,131,'0000-00-00 00:00:00',1600,20,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,25,0,0),(1,132,'0000-00-00 00:00:00',1600,20,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,25,0,0),(1,133,'0000-00-00 00:00:00',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,25,0,0),(1,134,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,498,551,25,0,0),(1,135,'0000-00-00 00:00:00',830,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,25,0,0),(1,136,'0000-00-00 00:00:00',1600,20,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,25,0,0),(1,137,'0000-00-00 00:00:00',1600,20,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,25,0,0),(1,138,'0000-00-00 00:00:00',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,25,0,0),(1,139,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,782,215,25,0,0),(1,140,'0000-00-00 00:00:00',600,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,25,0,0),(1,141,'0000-00-00 00:00:00',600,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,25,0,0),(1,142,'0000-00-00 00:00:00',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,25,0,0),(1,143,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,144,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,462,517,9,0,0),(1,145,'0000-00-00 00:00:00',830,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,146,'0000-00-00 00:00:00',1660,20,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,147,'0000-00-00 00:00:00',1660,20,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,148,'0000-00-00 00:00:00',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,149,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,325,569,9,0,0),(1,150,'0000-00-00 00:00:00',830,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,151,'0000-00-00 00:00:00',1600,20,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,152,'0000-00-00 00:00:00',1600,20,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,153,'0000-00-00 00:00:00',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,154,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,692,517,9,0,0),(1,155,'0000-00-00 00:00:00',1200,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,156,'0000-00-00 00:00:00',6,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,157,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,779,567,9,0,0),(1,158,'0000-00-00 00:00:00',600,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,159,'0000-00-00 00:00:00',600,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,9,0,0),(1,200,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,201,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,482,193,10,0,0),(1,202,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,203,'0000-00-00 00:00:00',720,10,1,0,20,700,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,204,'0000-00-00 00:00:00',720,10,1,0,20,700,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,205,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,206,'0000-00-00 00:00:00',720,10,1,0,20,700,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,207,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,208,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,209,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,210,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,211,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,212,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,213,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,214,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,215,'0000-00-00 00:00:00',4,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,216,'0000-00-00 00:00:00',4,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,217,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,396,245,10,0,0),(1,218,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,219,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,220,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,221,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,222,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,223,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,224,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,225,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,226,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,227,'0000-00-00 00:00:00',720,10,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,0,0,10,0,0),(1,228,'0000-00-00 00:00:00',0,0,1,0,20,0,0,0,0,0,0,0,0,0,80,80,25,'T','F','','CL',0,781,245,10,0,0);
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
INSERT INTO `game_users` VALUES (1,10,'',0),(1,9,'A',0),(1,8,'D',0),(1,25,'U',0);
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
  KEY `id-with-duplicates` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inspiration`
--

LOCK TABLES `inspiration` WRITE;
/*!40000 ALTER TABLE `inspiration` DISABLE KEYS */;
INSERT INTO `inspiration` VALUES (1,'Charistmatic'),(2,'Inspirational'),(3,'Impersonal'),(4,'Despised'),(2,'Inspiring'),(4,'Uninspiring');
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
INSERT INTO `logins` VALUES (7,'2011-12-26 09:53:22','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-26 09:52:40','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-26 11:58:46','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-26 22:53:18','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-26 23:10:59','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 01:30:31','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 01:33:33','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 01:48:59','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 01:54:09','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 01:58:11','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 02:05:52','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 02:06:04','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 02:57:52','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 03:30:10','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 06:08:50','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 07:01:04','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 07:08:27','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 07:09:16','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-27 15:18:48','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2011-12-27 17:47:43','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2011-12-30 03:25:15','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2011-12-30 03:27:43','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2012-01-04 03:18:40','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2012-01-04 03:38:34','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2012-01-05 11:19:57','Mozilla/5.0 (X11; Linux i686; rv:9.0.1) Gecko/20100101 Firefox/9.0.1','203.122.194.178'),(6,'2012-01-06 13:58:30','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2012-01-06 14:00:21','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2012-01-06 14:10:28','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2012-01-30 05:07:37','Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20100101 Firefox/7.0.1','203.122.194.178'),(6,'2012-02-04 09:00:19','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2012-03-15 01:17:27','Mozilla/5.0 (X11; Linux i686; rv:9.0.1) Gecko/20100101 Firefox/9.0.1','123.136.46.15'),(6,'2012-04-01 10:27:18','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2012-04-02 10:16:02','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(7,'2012-04-02 10:31:34','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2012-04-03 00:19:08','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2012-04-03 04:01:41','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(6,'2012-04-03 07:15:21','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-04 11:09:24','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-04 18:08:58','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(14,'2012-04-04 18:29:10','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(16,'2012-04-04 18:47:55','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(12,'2012-04-05 06:04:06','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-05 06:35:38','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-05 06:36:05','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-05 06:36:11','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-05 06:36:22','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(12,'2012-04-05 06:36:30','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-05 06:40:43','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-05 06:42:08','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-05 06:46:50','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(17,'2012-04-05 06:59:44','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(19,'2012-04-05 07:13:49','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 07:27:59','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 07:35:07','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 07:36:05','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 07:56:30','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:03:50','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:06:02','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:07:00','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:10:12','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:11:18','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-05 08:11:40','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(12,'2012-04-05 08:11:51','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(12,'2012-04-05 08:12:26','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:36:06','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:40:08','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:40:42','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-05 08:57:19','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 08:59:51','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-05 10:50:29','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-05 10:50:48','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 13:07:12','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 14:26:45','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-05 14:26:54','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-05 14:27:59','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 14:28:16','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 20:02:51','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 20:03:05','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 20:05:28','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 20:08:22','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-05 20:09:28','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-05 20:09:54','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-05 20:11:53','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-06 01:55:02','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-06 07:49:52','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-06 08:53:02','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 11:31:08','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 11:32:27','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 11:33:16','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 12:57:29','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 20:01:10','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 20:05:56','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 20:07:28','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-06 20:08:48','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-06 20:11:07','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-06 20:12:32','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-07 07:53:39','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 10:16:24','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-07 10:25:37','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 10:49:12','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 10:50:01','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 10:51:00','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 12:41:15','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 15:09:15','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 15:38:23','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 15:40:35','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 15:41:03','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 15:44:08','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 16:08:56','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 16:10:04','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-07 16:54:55','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-07 16:56:31','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 17:00:36','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-07 17:05:41','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 17:08:54','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 17:16:04','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 17:38:31','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 18:03:02','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 18:57:32','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 18:58:42','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 19:10:54','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-07 19:11:02','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 19:11:17','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-07 19:15:29','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-07 19:16:00','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-07 19:16:54','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 19:17:41','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 19:24:38','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-07 19:27:12','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-07 19:32:21','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-07 19:32:46','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-07 19:35:13','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-08 02:34:50','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-08 07:11:43','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-08 07:28:23','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-08 08:35:44','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-08 08:39:33','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-08 09:48:11','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-08 09:48:45','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-08 12:22:01','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-08 12:48:57','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-08 13:12:15','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-08 13:27:51','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-08 13:31:29','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-08 13:36:11','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-08 13:51:03','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-08 15:53:51','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-08 18:48:53','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-08 19:32:57','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(10,'2012-04-08 19:33:48','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-08 20:26:29','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-08 21:37:22','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-08 22:04:20','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(8,'2012-04-09 07:15:15','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(20,'2012-04-09 07:15:35','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(9,'2012-04-09 07:31:20','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-09 07:53:07','Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20100101 Firefox/8.0','203.122.194.178'),(25,'2012-04-09 09:58:59','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-09 10:14:30','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-09 10:16:48','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(8,'2012-04-09 10:18:41','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-09 10:28:08','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-09 10:46:46','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-09 11:17:38','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-09 11:18:01','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(8,'2012-04-09 11:18:26','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-11 15:52:46','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(8,'2012-04-11 15:53:58','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(8,'2012-04-11 17:13:57','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-11 19:00:07','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(20,'2012-04-11 19:02:09','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-11 20:46:36','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 01:21:44','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-13 02:38:59','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 07:50:55','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-13 08:33:22','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 08:37:20','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 08:51:58','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 09:02:23','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 09:02:42','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 09:08:23','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 11:58:11','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 12:07:13','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(10,'2012-04-13 12:27:33','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-13 12:29:42','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 12:45:39','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 13:14:26','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 13:14:48','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 13:23:08','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 13:23:40','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 13:24:07','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(9,'2012-04-13 13:24:30','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(20,'2012-04-13 13:26:28','Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20100101 Firefox/11.0','203.122.194.178'),(25,'2012-04-13 13:29:10','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(9,'2012-04-13 13:37:19','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(9,'2012-04-13 14:20:20','Mozilla/5.0 (X11; Linux i686; rv:9.0.1) Gecko/20100101 Firefox/9.0.1','203.122.194.178'),(20,'2012-04-14 19:07:35','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(25,'2012-04-14 19:08:23','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(25,'2012-04-14 19:23:17','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(25,'2012-04-14 19:40:15','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(9,'2012-04-14 20:18:24','Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2','203.122.194.178'),(9,'2012-04-14 23:18:17','Mozilla/5.0 (X11; Linux i686; rv:9.0.1) Gecko/20100101 Firefox/9.0.1','203.122.194.178');
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
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orbat`
--

LOCK TABLES `orbat` WRITE;
/*!40000 ALTER TABLE `orbat` DISABLE KEYS */;
INSERT INTO `orbat` VALUES (4,'JenaPrussian.trl','<p>1806 Prussian army - northern wing</p>','2012-04-08 02:30:54','Prussia',100,160,17,59,177,34860,'<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<Army item=\"y\" tlversion=\"1.2.4\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Corps\"\nicon=\"book_1\">\n<Name type=\"Text\" ref=\"y\">Prussian/Saxon forces at Jena Auerstaedt</Name>\n<Commander type=\"Text\">King of Prussia</Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\">Impersonal</Inspiration>\n<ProfessionalSkill type=\"Choice\" format=\"Superior/Excellent/Good/Mediocre/Poor/Despicable\">Despicable</ProfessionalSkill>\n<Doctrine type=\"Choice\" format=\"Regimental/DivisionGroup/Corps\">Regimental</Doctrine>\n<Wing item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">Brunswick\'s Main Army - Northern Wing (Auerstaedt)</Name>\n<MoraleState type=\"Choice\" format=\"Good/Shaken/Retreat/Broken\" init=\"Good\">Good</MoraleState>\n<Commander type=\"Text\">Duke of Brunswick</Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\">Impersonal</Inspiration>\n<ProfessionalSkill type=\"Choice\" format=\"Superior/Excellent/Good/Mediocre/Poor/Despicable\" init=\"Good\">Despicable</ProfessionalSkill>\n<Doctrine type=\"Choice\" format=\"Regimental/DivisionGroup/Corps\" init=\"Corps\">Regimental</Doctrine>\n<Division item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Brigade\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">Advanced Guard Division von Blucher</Name>\n<Commander type=\"Text\">General-Leutnant Gebhard Leberecht von Blucher</Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\" init=\"Impersonal\">Inspirational</Inspiration>\n<ProfessionalSkill type=\"Choice\" format=\"Superior/Excellent/Good/Mediocre/Poor/Despicable\" init=\"Good\">Despicable</ProfessionalSkill>\n<Doctrine type=\"Choice\" format=\"Regimental/DivisionGroup/Corps\">Regimental</Doctrine>\n<Brigade item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Battalion\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">Fusilier Brigade von Oswald</Name>\n<Commander type=\"Text\">General-Major Friedrich Gottlieb von Oswald</Commander>\n<Inspiration type=\"Choice\" format=\"Inspirational/Impersonal/Despised\" init=\"Impersonal\">Impersonal</Inspiration>\n<Drill type=\"Choice\" format=\"None/Prussian/French\" init=\"Prussian\">Prussian</Drill>\n<Image type=\"Picture\" html=\"y\"></Image>\n<Battalion item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"bullet_3\">\n<Name type=\"Text\" ref=\"y\">Weimar Fusilier</Name>\n<FacingColours type=\"Text\"></FacingColours>\n<MoraleState type=\"Choice\" format=\"Good/Shaken/Retreat/Broken\" init=\"Good\">Good</MoraleState>\n<Strength type=\"Number\" format=\"####\" init=\"720\">780</Strength>\n<NumBases type=\"Text\">4</NumBases>\n<Ranks type=\"Choice\" format=\"3/2/OpenOrder\" init=\"3\">3</Ranks>\n<Officers type=\"Number\" format=\"##\" init=\"10\">10</Officers>\n<ACE type=\"Number\" format=\"###\" init=\"10\">12</ACE>\n<MoraleGrade type=\"Choice\" format=\"OG/GRD/Gren/Elite/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\">Veteran</MoraleGrade>\n<SmallArms type=\"Choice\" format=\"OG/Guard/Gren/Elite/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\">Crack</SmallArms>\n<Skirmishers type=\"Number\" format=\"##\">1</Skirmishers>\n<OpenOrder type=\"Boolean\" format=\"yes/no\" init=\"false\">true</OpenOrder>\n<Rifles type=\"Boolean\" format=\"yes/no\" init=\"false\">false</Rifles>\n<ClosedColumn type=\"Boolean\" format=\"yes/no\" init=\"false\">false</ClosedColumn>\n<ShockTroops type=\"Boolean\" format=\"yes/no\" init=\"false\">false</ShockTroops>\n<BattalionGuns type=\"Boolean\" format=\"yes/no\" init=\"false\">false</BattalionGuns>\n<Breakpoint type=\"Number\" format=\"###\" init=\"80\">80</Breakpoint>\n<Fatigue type=\"Number\" format=\"##\" init=\"0\"></Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Grieffenberg Fusilier #4</Name>\n<MoraleState>Good</MoraleState>\n<Strength>780</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>12</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Oswald Fuslier #14</Name>\n<MoraleState>Good</MoraleState>\n<Strength>780</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>12</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Kloch Fusilier #18</Name>\n<MoraleState>Good</MoraleState>\n<Strength>780</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>12</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>true</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n</Battalion>\n</Brigade>\n<CavBrigade item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Squadron\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">Cavalry Brigade von Blucher</Name>\n<BattleGroup type=\"Boolean\" format=\"yes/no\" init=\"true\">true</BattleGroup>\n<Commander type=\"Text\">Blucher</Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\" init=\"Inspiring\">Inspiring</Inspiration>\n<Doctrine type=\"Choice\" format=\"Scouting/Packed/Linear\" init=\"Packed\">Packed</Doctrine>\n<Squadron item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"bullet_2\">\n<Name type=\"Text\" ref=\"y\">Hussar Regt #4  von Wurttemburg. 10 sqns</Name>\n<FacingColours type=\"Text\"></FacingColours>\n<Type type=\"Choice\" format=\"Hussar/Chass/ChevLeg/Dragoon/Lancer/Cossack/Cuirassier/Carabinier\" init=\"Dragoon\">Hussar</Type>\n<MoraleState type=\"Choice\" format=\"Good/Shaken/Retreat/Broken\" init=\"Good\">Good</MoraleState>\n<Strength type=\"Number\" format=\"###\" init=\"120\">1200</Strength>\n<NumBases type=\"Text\">10</NumBases>\n<Officers type=\"Number\" format=\"##\" init=\"10\">10</Officers>\n<ACE type=\"Number\" format=\"##\" init=\"20\">20</ACE>\n<MoraleClass type=\"Choice\" format=\"OG/Guard/Gren/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\">Crack</MoraleClass>\n<SmallArms type=\"Choice\" format=\"OG/Guard/Gren/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\">Veteran</SmallArms>\n<BattleCavalry type=\"Boolean\" format=\"yes/no\" init=\"false\">false</BattleCavalry>\n<Undistinguished type=\"Boolean\" format=\"yes/no\" init=\"false\">false</Undistinguished>\n<Skirmisher type=\"Number\" format=\"##\" init=\"0\">0</Skirmisher>\n<MoveRate type=\"Choice\" format=\"Light/Heavy\" init=\"Light\">Light</MoveRate>\n<Breakpoint type=\"Number\" format=\"###\" init=\"80\">80</Breakpoint>\n<Fatigue type=\"Number\" format=\"###\" init=\"0\"></Fatigue>\n</Squadron>\n<Squadron item=\"y\">\n<Name>Hussar Regt #8  von Blucher 10 sqns</Name>\n<Type>Hussar</Type>\n<MoraleState>Good</MoraleState>\n<Strength>1200</Strength>\n<NumBases>10</NumBases>\n<Officers>100</Officers>\n<ACE>20</ACE>\n<MoraleClass>Crack</MoraleClass>\n<SmallArms>Veteran</SmallArms>\n<BattleCavalry>false</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Light</MoveRate>\n<Breakpoint>80</Breakpoint>\n</Squadron>\n<Squadron item=\"y\">\n<Name>Dragoon Regt #3  von Irwing 5 sqns</Name>\n<Type>Dragoon</Type>\n<MoraleState>Good</MoraleState>\n<Strength>600</Strength>\n<NumBases>5</NumBases>\n<Officers>60</Officers>\n<ACE>24</ACE>\n<MoraleClass>Gren</MoraleClass>\n<SmallArms>Veteran</SmallArms>\n<BattleCavalry>true</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Light</MoveRate>\n<Breakpoint>70</Breakpoint>\n</Squadron>\n<Battery item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"bullet_1\">\n<Name type=\"Text\" ref=\"y\">Schorlemmer Horse Artillery Battery</Name>\n<Type type=\"Choice\" format=\"Foot/Horse\" init=\"Foot\">Horse</Type>\n<Calibre type=\"Choice\" format=\"4lb/6lb/8lb/12lb\" init=\"6\">6lb</Calibre>\n<Strength type=\"Number\" format=\"##\" init=\"6\">6</Strength>\n<NumGuns type=\"Text\">3</NumGuns>\n<CrewFigures type=\"Text\">2</CrewFigures>\n<Howitzers type=\"Number\" format=\"##\" init=\"0\">0</Howitzers>\n<Class type=\"Choice\" format=\"OG/Class I/Class II/Class III\" init=\"Class II\">Class II</Class>\n<MoraleClass type=\"Choice\" format=\"OG/GRD/Gren/Elite/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\">Veteran</MoraleClass>\n</Battery>\n</CavBrigade>\n</Division>\n<Division item=\"y\">\n<Name>1 Division Prinz Wiliam of Orange</Name>\n<Commander>General-Leutnant Prince William of Orange</Commander>\n<Inspiration>Despised</Inspiration>\n<ProfessionalSkill>Despicable</ProfessionalSkill>\n<Doctrine>Regimental</Doctrine>\n<Brigade item=\"y\">\n<Name>Infantrie Brigade Prinz Heinrich</Name>\n<Commander>Oberst Prince Henry</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>Prussian</Drill>\n<Battalion item=\"y\">\n<Name>Rheinbaben Grenadier Battalion</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>16</ACE>\n<MoraleGrade>Gren</MoraleGrade>\n<SmallArms>Gren</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>90</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Prince Ferdinand Infantry Regiment # 25, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1600</Strength>\n<NumBases>8 + Mounted Officer</NumBases>\n<Ranks>3</Ranks>\n<Officers>20</Officers>\n<ACE>12</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Puttkammer Infantry Regiment # 36, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1600</Strength>\n<NumBases>8 + Mounted Officer</NumBases>\n<Ranks>3</Ranks>\n<Officers>20</Officers>\n<ACE>12</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battery item=\"y\">\n<Name>Riemer Foot Artillery Battery, six 6-pound guns</Name>\n<Type>Foot</Type>\n<Calibre>6lb</Calibre>\n<Strength>6</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>3</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class III</Class>\n<MoraleClass>Veteran</MoraleClass>\n</Battery>\n</Brigade>\n<Brigade item=\"y\">\n<Name>Infantrie Brigade von Lutzow</Name>\n<Commander>Oberst Johann Adolf von Lutzow</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>Prussian</Drill>\n<Battalion item=\"y\">\n<Name>Knebel Grenadier Battalion</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>16</ACE>\n<MoraleGrade>Gren</MoraleGrade>\n<SmallArms>Gren</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>true</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Möllendorf Infantry Regiment # 34, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1600</Strength>\n<NumBases>8 + Mounted Officer</NumBases>\n<Ranks>3</Ranks>\n<Officers>20</Officers>\n<ACE>12</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Wartensleben Infantry Regiment # 36, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1600</Strength>\n<NumBases>8 + Mounted Officer</NumBases>\n<Ranks>3</Ranks>\n<Officers>20</Officers>\n<ACE>12</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battery item=\"y\">\n<Name>Lehmann Foot Artillery Battery, six 6-pound guns</Name>\n<Type>Foot</Type>\n<Calibre>6lb</Calibre>\n<Strength>6</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>3</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class III</Class>\n</Battery>\n</Brigade>\n<CavBrigade item=\"y\">\n<Name>Cavalry Brigade Prince Wilhelm</Name>\n<BattleGroup>true</BattleGroup>\n<Commander>Oberstleutnant Prince Wilhelm</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Doctrine>Packed</Doctrine>\n<Squadron item=\"y\">\n<Name>Leib Carabinier Regiment # 12, five squadrons</Name>\n<Type>Carabinier</Type>\n<MoraleState>Good</MoraleState>\n<Strength>500</Strength>\n<Officers>50</Officers>\n<ACE>27</ACE>\n<MoraleClass>Guard</MoraleClass>\n<SmallArms>Crack</SmallArms>\n<BattleCavalry>true</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Heavy</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Squadron item=\"y\">\n<Name>Garde du Corps Cuirassier Regiment # 14, five squadrons</Name>\n<Type>Cuirassier</Type>\n<MoraleState>Good</MoraleState>\n<Strength>500</Strength>\n<Officers>50</Officers>\n<ACE>27</ACE>\n<MoraleClass>Guard</MoraleClass>\n<SmallArms>Crack</SmallArms>\n<BattleCavalry>true</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Heavy</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Battery item=\"y\">\n<Name>Willmann Horse Artillery Battery, six 4-pound guns</Name>\n<Type>Horse</Type>\n<Calibre>4lb</Calibre>\n<Strength>6</Strength>\n<Howitzers>0</Howitzers>\n<Class>Class II</Class>\n<MoraleClass>Crack</MoraleClass>\n</Battery>\n</CavBrigade>\n</Division>\n<Division item=\"y\">\n<Name>2 Division von Wartensleben</Name>\n<Commander>General-Leutnant Leopold Alexander von Wartensleben</Commander>\n<Inspiration>Impersonal</Inspiration>\n<ProfessionalSkill>Despicable</ProfessionalSkill>\n<Doctrine>Regimental</Doctrine>\n<Brigade item=\"y\">\n<Name>Infantrie Brigade von Wedel</Name>\n<Commander>General-Major Karl Alexander von Wedel</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>Prussian</Drill>\n<Battalion item=\"y\">\n<Name>Hanstein Grenadier Battalion</Name>\n<MoraleState>Good</MoraleState>\n<Strength>830</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>16</ACE>\n<MoraleGrade>Gren</MoraleGrade>\n<SmallArms>Gren</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>true</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Renouard Infantry Regiment # 3, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1600</Strength>\n<NumBases>8 + Mounted Officer</NumBases>\n<Ranks>3</Ranks>\n<Officers>20</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Kleist Infantry Regiment # 5, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1600</Strength>\n<NumBases>8 + Mounted Officer</NumBases>\n<Ranks>3</Ranks>\n<Officers>20</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battery item=\"y\">\n<Name>Wilkins Foot Artillery battery, six 8-pound guns</Name>\n<Type>Foot</Type>\n<Calibre>8lb</Calibre>\n<Strength>6</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>3</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class III</Class>\n<MoraleClass>Veteran</MoraleClass>\n</Battery>\n</Brigade>\n<Brigade item=\"y\">\n<Name>Infantrie Brigade von Renouard</Name>\n<Commander>General-Major Johann Jeremias von Renouard</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>Prussian</Drill>\n<Battalion item=\"y\">\n<Name>Alt-Braun Grenadier Battalion</Name>\n<MoraleState>Good</MoraleState>\n<Strength>830</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>16</ACE>\n<MoraleGrade>Gren</MoraleGrade>\n<SmallArms>Gren</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>true</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Prince Louis Infantry Regiment # 20, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1600</Strength>\n<NumBases>8 + Mounted Officer</NumBases>\n<Ranks>3</Ranks>\n<Officers>20</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Brunswick Infantry Regiment # 21, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1600</Strength>\n<NumBases>8 + Mounted Officer</NumBases>\n<Ranks>3</Ranks>\n<Officers>20</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battery item=\"y\">\n<Name>Lange Foot Artillery Battery, six 8-pound guns</Name>\n<Type>Foot</Type>\n<Calibre>8lb</Calibre>\n<Strength>6</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>3</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class III</Class>\n<MoraleClass>Veteran</MoraleClass>\n</Battery>\n</Brigade>\n<CavBrigade item=\"y\">\n<Name>Kavallrie Brigade von Quitzow</Name>\n<BattleGroup>true</BattleGroup>\n<Commander>General-Major Christan Heinrich von Quitzow</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Doctrine>Packed</Doctrine>\n<Squadron item=\"y\">\n<Name>Quitzow Cuirassier Regiment # 6, five squadrons</Name>\n<Type>Cuirassier</Type>\n<MoraleState>Good</MoraleState>\n<Strength>600</Strength>\n<Officers>10</Officers>\n<ACE>27</ACE>\n<MoraleClass>Gren</MoraleClass>\n<SmallArms>Gren</SmallArms>\n<BattleCavalry>true</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Heavy</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Squadron item=\"y\">\n<Name>Reitzenstein Cuirassier Regiment # 7, five squadrons</Name>\n<Type>Cuirassier</Type>\n<MoraleState>Good</MoraleState>\n<Strength>600</Strength>\n<Officers>10</Officers>\n<ACE>27</ACE>\n<MoraleClass>Gren</MoraleClass>\n<SmallArms>Gren</SmallArms>\n<BattleCavalry>true</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Heavy</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Battery item=\"y\">\n<Name>Merkatz Horse Artillery Battery, six 4-pound guns</Name>\n<Type>Horse</Type>\n<Calibre>4lb</Calibre>\n<Strength>6</Strength>\n<Howitzers>0</Howitzers>\n<Class>Class I</Class>\n<MoraleClass>Crack</MoraleClass>\n</Battery>\n</CavBrigade>\n</Division>\n<Division item=\"y\">\n<Name>3 Division von Schmettau</Name>\n<Commander>General-Leutnant Friedrich Wilhelm Karl von Schmettau</Commander>\n<Inspiration>Impersonal</Inspiration>\n<ProfessionalSkill>Despicable</ProfessionalSkill>\n<Doctrine>Regimental</Doctrine>\n<Brigade item=\"y\">\n<Name>Infantrie Brigade von Alvensleben</Name>\n<Commander>General-Major Ludolph August Friedrich von Alvensleben</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>Prussian</Drill>\n<Battalion item=\"y\">\n<Name>Schack Grenadier Battalion</Name>\n<MoraleState>Good</MoraleState>\n<Strength>830</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>16</ACE>\n<MoraleGrade>Gren</MoraleGrade>\n<SmallArms>Gren</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>true</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Alvensleben Infantry Regiment # 33, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1660</Strength>\n<NumBases>8 + Mounted Officer</NumBases>\n<Ranks>3</Ranks>\n<Officers>20</Officers>\n<ACE>12</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Prince Heinrich Infantry Regiment # 35, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1660</Strength>\n<NumBases>8 + Mounted Officer</NumBases>\n<Ranks>3</Ranks>\n<Officers>20</Officers>\n<ACE>12</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battery item=\"y\">\n<Name>Röhl Foot Artillery Battery, six 8-pound guns</Name>\n<Type>Foot</Type>\n<Calibre>8lb</Calibre>\n<Strength>6</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>3</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class III</Class>\n<MoraleClass>Veteran</MoraleClass>\n</Battery>\n</Brigade>\n<Brigade item=\"y\">\n<Name>Infantrie Brigade von Schimonsky</Name>\n<Commander>General-Major Dietrich Lebrecht von Schimonsky</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>Prussian</Drill>\n<Battalion item=\"y\">\n<Name>Krafft Grenadier Battalion</Name>\n<MoraleState>Good</MoraleState>\n<Strength>830</Strength>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>16</ACE>\n<MoraleGrade>Gren</MoraleGrade>\n<SmallArms>Gren</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>true</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Malschitsky Infantry Regiment # 28, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1600</Strength>\n<NumBases>8 + Mounted Officer</NumBases>\n<Ranks>3</Ranks>\n<Officers>20</Officers>\n<ACE>12</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>Schimonsky Infantry Regiment # 40, two battalions</Name>\n<MoraleState>Good</MoraleState>\n<Strength>1600</Strength>\n<NumBases>8 + Mounted Officer</NumBases>\n<Ranks>3</Ranks>\n<Officers>20</Officers>\n<ACE>12</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Crack</SmallArms>\n<OpenOrder>false</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>true</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battery item=\"y\">\n<Name>Stankar Foot Artillery Battery, six 8-pound guns</Name>\n<Type>Foot</Type>\n<Calibre>8lb</Calibre>\n<Strength>6</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>3</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class III</Class>\n<MoraleClass>Veteran</MoraleClass>\n</Battery>\n</Brigade>\n<CavBrigade item=\"y\">\n<Name>Cavalry Brigade: von Irwing</Name>\n<BattleGroup>true</BattleGroup>\n<Commander>General-Major Friedrich Daniel Wilhelm von Irwing</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Doctrine>Packed</Doctrine>\n<Squadron item=\"y\">\n<Name>Königin Dragoon Regiment # 5, ten squadrons</Name>\n<Type>Dragoon</Type>\n<MoraleState>Good</MoraleState>\n<Strength>1200</Strength>\n<NumBases>10</NumBases>\n<Officers>10</Officers>\n<ACE>24</ACE>\n<MoraleClass>Guard</MoraleClass>\n<SmallArms>Crack</SmallArms>\n<BattleCavalry>true</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Heavy</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Battery item=\"y\">\n<Name>Graumann Horse Artillery Battery, six guns</Name>\n<Type>Horse</Type>\n<Calibre>4lb</Calibre>\n<Strength>6</Strength>\n<NumGuns>3</NumGuns>\n<CrewFigures>2</CrewFigures>\n<Howitzers>0</Howitzers>\n<Class>Class II</Class>\n<MoraleClass>Elite</MoraleClass>\n</Battery>\n</CavBrigade>\n<CavBrigade item=\"y\">\n<Name>Cavalry Brigade: von Bünting</Name>\n<BattleGroup>true</BattleGroup>\n<Commander>General-Major Karl Wilhelm von Bünting</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Doctrine>Packed</Doctrine>\n<Squadron item=\"y\">\n<Name>Heising Cuirassier Regiment # 8, five squadrons</Name>\n<Type>Cuirassier</Type>\n<MoraleState>Good</MoraleState>\n<Strength>600</Strength>\n<NumBases>5</NumBases>\n<Officers>10</Officers>\n<ACE>27</ACE>\n<MoraleClass>Gren</MoraleClass>\n<SmallArms>Crack</SmallArms>\n<BattleCavalry>true</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Heavy</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n<Squadron item=\"y\">\n<Name>Bünting Cuirassier Regiment # 12, five squadrons</Name>\n<Type>Cuirassier</Type>\n<MoraleState>Good</MoraleState>\n<Strength>600</Strength>\n<NumBases>5</NumBases>\n<Officers>10</Officers>\n<ACE>27</ACE>\n<MoraleClass>Gren</MoraleClass>\n<SmallArms>Crack</SmallArms>\n<BattleCavalry>true</BattleCavalry>\n<Undistinguished>false</Undistinguished>\n<Skirmisher>0</Skirmisher>\n<MoveRate>Heavy</MoveRate>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Squadron>\n</CavBrigade>\n</Division>\n</Wing>\n<Corps item=\"n\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Division\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\"></Name>\n</Corps>\n</Army>'),(3,'FrenchVIICorps-1806.trl','<p>VII Corps</p>','2012-04-08 02:12:12','1806 France',200,229,8,29,76,13688,'<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<Corps item=\"y\" tlversion=\"1.2.4\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Division\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">French VII Corps 1806 - Augereau</Name>\n<Commander type=\"Text\">Marshal Pierre Augereau</Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\">Inspirational</Inspiration>\n<ProfessionalSkill type=\"Choice\" format=\"Superior/Excellent/Good/Mediocre/Poor/Despicable\">Excellent</ProfessionalSkill>\n<Doctrine type=\"Choice\" format=\"Regimental/DivisionGroup/Corps\">Corps</Doctrine>\n<Division item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Brigade\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">1st Division: Desjardin</Name>\n<Commander type=\"Text\">General of Division Jacques Desjardin</Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\" init=\"Impersonal\">Impersonal</Inspiration>\n<ProfessionalSkill type=\"Choice\" format=\"Superior/Excellent/Good/Mediocre/Poor/Despicable\" init=\"Good\">Good</ProfessionalSkill>\n<Doctrine type=\"Choice\" format=\"Regimental/DivisionGroup/Corps\">Corps</Doctrine>\n<Brigade item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Battalion\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">Brigade d\' Legere Lapisse</Name>\n<Commander type=\"Text\">General of Brigade Pierre Belon Lapisse</Commander>\n<Inspiration type=\"Choice\" format=\"Inspirational/Impersonal/Despised\" init=\"Impersonal\">Inspirational</Inspiration>\n<Drill type=\"Choice\" format=\"None/Prussian/French\" init=\"Prussian\">French</Drill>\n<Image type=\"Picture\" html=\"y\"></Image>\n<Battalion item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"bullet_3\">\n<Name type=\"Text\" ref=\"y\">16eme Legere, 1e Bn</Name>\n<FacingColours type=\"Text\"></FacingColours>\n<MoraleState type=\"Choice\" format=\"Good/Shaken/Retreat/Broken\" init=\"Good\">Good</MoraleState>\n<Strength type=\"Number\" format=\"####\" init=\"720\">720</Strength>\n<NumBases type=\"Text\">4</NumBases>\n<Ranks type=\"Choice\" format=\"3/2/OpenOrder\" init=\"3\">3</Ranks>\n<Officers type=\"Number\" format=\"##\" init=\"10\">10</Officers>\n<ACE type=\"Number\" format=\"###\" init=\"10\">14</ACE>\n<MoraleGrade type=\"Choice\" format=\"OG/GRD/Gren/Elite/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\">Elite</MoraleGrade>\n<SmallArms type=\"Choice\" format=\"OG/Guard/Gren/Elite/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\">Elite</SmallArms>\n<Skirmishers type=\"Number\" format=\"##\">2</Skirmishers>\n<OpenOrder type=\"Boolean\" format=\"yes/no\" init=\"false\">true</OpenOrder>\n<Rifles type=\"Boolean\" format=\"yes/no\" init=\"false\">false</Rifles>\n<ClosedColumn type=\"Boolean\" format=\"yes/no\" init=\"false\">true</ClosedColumn>\n<ShockTroops type=\"Boolean\" format=\"yes/no\" init=\"false\">false</ShockTroops>\n<BattalionGuns type=\"Boolean\" format=\"yes/no\" init=\"false\">false</BattalionGuns>\n<Breakpoint type=\"Number\" format=\"###\" init=\"80\">80</Breakpoint>\n<Fatigue type=\"Number\" format=\"##\" init=\"0\">0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>16eme Legere, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>14</ACE>\n<MoraleGrade>Elite</MoraleGrade>\n<SmallArms>Elite</SmallArms>\n<Skirmishers>2</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>16eme Legere, 3e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>14</ACE>\n<MoraleGrade>Elite</MoraleGrade>\n<SmallArms>Elite</SmallArms>\n<Skirmishers>2</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>16eme Legere, 4e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>14</ACE>\n<MoraleGrade>Elite</MoraleGrade>\n<SmallArms>Elite</SmallArms>\n<Skirmishers>2</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n</Brigade>\n<Brigade item=\"y\">\n<Name>Brigade d\' Ligne Lefranc</Name>\n<Commander>General of Brigade Jacques Lefranc</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>French</Drill>\n<Battalion item=\"y\">\n<Name>14eme Legere, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>14</ACE>\n<MoraleGrade>Elite</MoraleGrade>\n<SmallArms>Elite</SmallArms>\n<Skirmishers>2</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>false</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>44eme Ligne, 1e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>44eme Ligne, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>44eme Ligne, 3e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>105eme Ligne, 1e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>105eme Ligne, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>105eme Ligne, 3e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n</Brigade>\n<Battery item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"bullet_1\">\n<Name type=\"Text\" ref=\"y\">3rd Foot Artillery Regiment, 4th company</Name>\n<Type type=\"Choice\" format=\"Foot/Horse\" init=\"Foot\">Foot</Type>\n<Calibre type=\"Choice\" format=\"4lb/6lb/8lb/12lb\" init=\"6\">12lb</Calibre>\n<Strength type=\"Number\" format=\"##\" init=\"6\">4</Strength>\n<NumGuns type=\"Text\">1</NumGuns>\n<CrewFigures type=\"Text\">4</CrewFigures>\n<Howitzers type=\"Text\" init=\"0\">2 x 6&quot; Howitzer</Howitzers>\n<Class type=\"Choice\" format=\"OG/Class I/Class II/Class III\" init=\"Class II\">Class I</Class>\n<MoraleGrade type=\"Choice\" format=\"OG/GRD/Gren/Elite/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\">Elite</MoraleGrade>\n</Battery>\n<Battery item=\"y\">\n<Name>6th Horse Artillery Regiment, 2nd company</Name>\n<Type>Horse</Type>\n<Calibre>6lb</Calibre>\n<Strength>4</Strength>\n<NumGuns>2</NumGuns>\n<CrewFigures>2</CrewFigures>\n<Class>Class I</Class>\n<MoraleGrade>Elite</MoraleGrade>\n</Battery>\n</Division>\n<Division item=\"y\">\n<Name>2nd Division: Gardanne</Name>\n<Commander>General of Division Gaspard Amédée Gardanne</Commander>\n<Inspiration>Impersonal</Inspiration>\n<ProfessionalSkill>Good</ProfessionalSkill>\n<Doctrine>Corps</Doctrine>\n<Brigade item=\"y\">\n<Name>Brigade d\' Legere Marcognet</Name>\n<Commander>General of Brigade Pierre-Louis Binet de Marcognet</Commander>\n<Inspiration>Inspirational</Inspiration>\n<Drill>French</Drill>\n<Battalion item=\"y\">\n<Name>25eme Legere, 1e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>14</ACE>\n<MoraleGrade>Elite</MoraleGrade>\n<SmallArms>Elite</SmallArms>\n<Skirmishers>2</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>25eme Legere, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>14</ACE>\n<MoraleGrade>Elite</MoraleGrade>\n<SmallArms>Elite</SmallArms>\n<Skirmishers>2</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n</Brigade>\n<Brigade item=\"y\">\n<Name>Brigade d\' Ligne Delabassé</Name>\n<Commander>General of Brigade Mathieu Delabassé</Commander>\n<Inspiration>Impersonal</Inspiration>\n<Drill>French</Drill>\n<Battalion item=\"y\">\n<Name>27eme Ligne, 1e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>27eme Ligne, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>50eme Ligne, 1e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>50eme Ligne, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>59eme Ligne, 1e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n<Battalion item=\"y\">\n<Name>59eme Ligne, 2e Bn</Name>\n<MoraleState>Good</MoraleState>\n<Strength>720</Strength>\n<NumBases>4</NumBases>\n<Ranks>3</Ranks>\n<Officers>10</Officers>\n<ACE>10</ACE>\n<MoraleGrade>Veteran</MoraleGrade>\n<SmallArms>Veteran</SmallArms>\n<Skirmishers>1</Skirmishers>\n<OpenOrder>true</OpenOrder>\n<Rifles>false</Rifles>\n<ClosedColumn>true</ClosedColumn>\n<ShockTroops>false</ShockTroops>\n<BattalionGuns>false</BattalionGuns>\n<Breakpoint>80</Breakpoint>\n<Fatigue>0</Fatigue>\n</Battalion>\n</Brigade>\n</Division>\n<CavBrigade item=\"y\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Squadron\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\">Brigade d\' Cheval  Colbert-Chabanais</Name>\n<BattleGroup type=\"Boolean\" format=\"yes/no\" init=\"true\">true</BattleGroup>\n<Commander type=\"Text\">General of Brigade Auguste François-Marie de Colbert-Chabanais</Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\" init=\"Inspiring\">Impersonal</Inspiration>\n<Doctrine type=\"Choice\" format=\"Scouting/Packed/Linear\" init=\"Packed\">Packed</Doctrine>\n</CavBrigade>\n<Army item=\"n\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nchildtype=\"Corps\"\nicon=\"book_1\">\n<Name type=\"Text\" ref=\"y\"></Name>\n</Army>\n<Squadron item=\"n\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"bullet_2\">\n<Name type=\"Text\" ref=\"y\"></Name>\n<FacingColours type=\"Text\"></FacingColours>\n<Type type=\"Choice\" format=\"Hussar/Chass/ChevLeg/Dragoon/Lancer/Cossack/Cuirassier/Carabinier\" init=\"Dragoon\"></Type>\n<MoraleState type=\"Choice\" format=\"Good/Shaken/Retreat/Broken\" init=\"Good\"></MoraleState>\n<Strength type=\"Number\" format=\"###\" init=\"120\"></Strength>\n<NumBases type=\"Text\"></NumBases>\n<Officers type=\"Number\" format=\"##\" init=\"10\"></Officers>\n<ACE type=\"Number\" format=\"##\" init=\"20\"></ACE>\n<MoraleClass type=\"Choice\" format=\"OG/GRD/Gren/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\"></MoraleClass>\n<SmallArms type=\"Choice\" format=\"OG/Guard/Gren/Crack/Veteran/Conscript/Landwehr/Militia/Untrained\" init=\"Veteran\"></SmallArms>\n<BattleCavalry type=\"Boolean\" format=\"yes/no\" init=\"false\"></BattleCavalry>\n<Undistinguished type=\"Boolean\" format=\"yes/no\" init=\"false\"></Undistinguished>\n<Skirmisher type=\"Number\" format=\"##\" init=\"0\"></Skirmisher>\n<MoveRate type=\"Choice\" format=\"Light/Heavy\" init=\"Light\"></MoveRate>\n<Breakpoint type=\"Number\" format=\"###\" init=\"80\"></Breakpoint>\n<Fatigue type=\"Number\" format=\"###\" init=\"0\"></Fatigue>\n</Squadron>\n<Wing item=\"n\"\nline0=\"{*Name*}\"\nline1=\"{*Name*}\"\nicon=\"person\">\n<Name type=\"Text\" ref=\"y\"></Name>\n<MoraleState type=\"Choice\" format=\"Good/Shaken/Retreat/Broken\" init=\"Good\"></MoraleState>\n<Commander type=\"Text\"></Commander>\n<Inspiration type=\"Choice\" format=\"Charismatic/Inspirational/Impersonal/Despised\"></Inspiration>\n<ProfessionalSkill type=\"Choice\" format=\"Superior/Excellent/Good/Mediocre/Poor/Despicable\" init=\"Good\"></ProfessionalSkill>\n<Doctrine type=\"Choice\" format=\"Regimental/DivisionGroup/Corps\" init=\"Corps\"></Doctrine>\n</Wing>\n</Corps>');
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
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professional_skill`
--

LOCK TABLES `professional_skill` WRITE;
/*!40000 ALTER TABLE `professional_skill` DISABLE KEYS */;
INSERT INTO `professional_skill` VALUES (1,'Superior'),(2,'Excellent'),(3,'Good'),(4,'Mediocre'),(5,'Poor'),(6,'Despicable');
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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scenario`
--

LOCK TABLES `scenario` WRITE;
/*!40000 ALTER TABLE `scenario` DISABLE KEYS */;
INSERT INTO `scenario` VALUES (2,'Jena-Auerstaedt 1806.  \n\nPrussian Northern wing slips past Davout, and hits Augereau\'s Corps first.','','',5,'50.64','11.52',4,3,''),(3,'Advanced Guard hit VII Corps','','',11,'50.62','11.3',52,51,'');
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
  `morale_state` int(11) NOT NULL DEFAULT '1',
  `fatigue` int(11) NOT NULL,
  `breakpoint` int(11) NOT NULL DEFAULT '20',
  `orbat_id` int(11) NOT NULL,
  `formation` enum('CL','LN','SQ','CC','OO','HS') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CL',
  `cover` enum('','L','M','H','S') COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `disorder` int(11) NOT NULL COMMENT 'percentage disordered 0 = good order, 50 = normal disorder, 90 = real bad, 10 = a little bit',
  PRIMARY KEY (`id`),
  KEY `parentid` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit`
--

LOCK TABLES `unit` WRITE;
/*!40000 ALTER TABLE `unit` DISABLE KEYS */;
INSERT INTO `unit` VALUES (158,157,157,'Heising Cuirassier Regiment # 8, five squadrons',11,'F','F',29,600,10,27,3,5,1,0,20,4,'CL','',0),(157,143,0,'Cavalry Brigade: von Bünting',6,'F','T',16,0,0,0,0,0,1,0,20,4,'CL','',0),(156,154,154,'Graumann Horse Artillery Battery, six guns',12,'F','F',32,6,10,10,4,4,1,0,20,4,'CL','',0),(154,143,0,'Cavalry Brigade: von Irwing',6,'F','T',15,0,0,0,0,0,1,0,20,4,'CL','',0),(155,154,154,'Königin Dragoon Regiment # 5, ten squadrons',11,'F','F',28,1200,10,24,2,5,1,0,20,4,'CL','',0),(152,149,149,'Schimonsky Infantry Regiment # 40, two battalions',10,'F','F',85,1600,20,12,6,5,1,0,20,4,'CL','',0),(153,149,149,'Stankar Foot Artillery Battery, six 8-pound guns',12,'F','F',31,6,10,10,6,6,1,0,20,4,'CL','',0),(150,149,149,'Krafft Grenadier Battalion',10,'F','F',83,830,10,16,3,3,1,0,20,4,'CL','',0),(151,149,149,'Malschitsky Infantry Regiment # 28, two battalions',10,'F','F',84,1600,20,12,6,5,1,0,20,4,'CL','',0),(149,143,0,'Infantrie Brigade von Schimonsky',5,'F','T',25,0,0,0,0,0,1,0,20,4,'CL','',0),(148,144,144,'Röhl Foot Artillery Battery, six 8-pound guns',12,'F','F',30,6,10,10,6,6,1,0,20,4,'CL','',0),(147,144,144,'Prince Heinrich Infantry Regiment # 35, two battalions',10,'F','F',82,1660,20,12,6,5,1,0,20,4,'CL','',0),(146,144,144,'Alvensleben Infantry Regiment # 33, two battalions',10,'F','F',81,1660,20,12,6,5,1,0,20,4,'CL','',0),(144,143,0,'Infantrie Brigade von Alvensleben',5,'F','T',24,0,0,0,0,0,1,0,20,4,'CL','',0),(145,144,144,'Schack Grenadier Battalion',10,'F','F',80,830,10,16,3,3,1,0,20,4,'CL','',0),(143,101,0,'3 Division von Schmettau',4,'T','F',14,0,0,0,0,0,1,0,20,4,'CL','',0),(142,139,139,'Merkatz Horse Artillery Battery, six 4-pound guns',12,'F','F',29,6,10,10,5,5,1,0,20,4,'CL','',0),(140,139,139,'Quitzow Cuirassier Regiment # 6, five squadrons',11,'F','F',26,600,10,27,3,3,1,0,20,4,'CL','',0),(141,139,139,'Reitzenstein Cuirassier Regiment # 7, five squadrons',11,'F','F',27,600,10,27,3,3,1,0,20,4,'CL','',0),(139,128,0,'Kavallrie Brigade von Quitzow',6,'F','T',14,0,0,0,0,0,1,0,20,4,'CL','',0),(138,134,134,'Lange Foot Artillery Battery, six 8-pound guns',12,'F','F',28,6,10,10,6,6,1,0,20,4,'CL','',0),(136,134,134,'Prince Louis Infantry Regiment # 20, two battalions',10,'F','F',78,1600,20,10,6,5,1,0,20,4,'CL','',0),(137,134,134,'Brunswick Infantry Regiment # 21, two battalions',10,'F','F',79,1600,20,10,6,5,1,0,20,4,'CL','',0),(134,128,0,'Infantrie Brigade von Renouard',5,'F','T',23,0,0,0,0,0,1,0,20,4,'CL','',0),(135,134,134,'Alt-Braun Grenadier Battalion',10,'F','F',77,830,10,16,3,3,1,0,20,4,'CL','',0),(133,129,129,'Wilkins Foot Artillery battery, six 8-pound guns',12,'F','F',27,6,10,10,6,6,1,0,20,4,'CL','',0),(132,129,129,'Kleist Infantry Regiment # 5, two battalions',10,'F','F',76,1600,20,10,6,5,1,0,20,4,'CL','',0),(130,129,129,'Hanstein Grenadier Battalion',10,'F','F',74,830,10,16,3,3,1,0,20,4,'CL','',0),(131,129,129,'Renouard Infantry Regiment # 3, two battalions',10,'F','F',75,1600,20,10,6,5,1,0,20,4,'CL','',0),(129,128,0,'Infantrie Brigade von Wedel',5,'F','T',22,0,0,0,0,0,1,0,20,4,'CL','',0),(128,101,0,'2 Division von Wartensleben',4,'T','F',13,0,0,0,0,0,1,0,20,4,'CL','',0),(127,124,124,'Willmann Horse Artillery Battery, six 4-pound guns',12,'F','F',26,6,10,10,5,5,1,0,20,4,'CL','',0),(126,124,124,'Garde du Corps Cuirassier Regiment # 14, five squadrons',11,'F','F',25,500,50,27,2,5,1,0,20,4,'CL','',0),(125,124,124,'Leib Carabinier Regiment # 12, five squadrons',11,'F','F',24,500,50,27,2,5,1,0,20,4,'CL','',0),(124,113,0,'Cavalry Brigade Prince Wilhelm',6,'F','T',13,0,0,0,0,0,1,0,20,4,'CL','',0),(123,119,119,'Lehmann Foot Artillery Battery, six 6-pound guns',12,'F','F',25,6,10,10,5,1,1,0,20,4,'CL','',0),(122,119,119,'Wartensleben Infantry Regiment # 36, two battalions',10,'F','F',73,1600,20,12,6,5,1,0,20,4,'CL','',0),(121,119,119,'Möllendorf Infantry Regiment # 34, two battalions',10,'F','F',72,1600,20,12,6,5,1,0,20,4,'CL','',0),(120,119,119,'Knebel Grenadier Battalion',10,'F','F',71,720,10,16,3,3,1,0,20,4,'CL','',0),(119,113,0,'Infantrie Brigade von Lutzow',5,'F','T',21,0,0,0,0,0,1,0,20,4,'CL','',0),(118,114,114,'Riemer Foot Artillery Battery, six 6-pound guns',12,'F','F',24,6,10,10,6,6,1,0,20,4,'CL','',0),(117,114,114,'Puttkammer Infantry Regiment # 36, two battalions',10,'F','F',70,1600,20,12,6,5,1,0,20,4,'CL','',0),(116,114,114,'Prince Ferdinand Infantry Regiment # 25, two battalions',10,'F','F',69,1600,20,12,6,5,1,0,20,4,'CL','',0),(115,114,114,'Rheinbaben Grenadier Battalion',10,'F','F',68,720,10,16,3,3,1,0,20,4,'CL','',0),(114,113,0,'Infantrie Brigade Prinz Heinrich',5,'F','T',20,0,0,0,0,0,1,0,20,4,'CL','',0),(113,101,0,'1 Division Prinz Wiliam of Orange',4,'T','F',12,0,0,0,0,0,1,0,20,4,'CL','',0),(112,108,108,'Schorlemmer Horse Artillery Battery',12,'F','F',23,6,10,10,6,6,1,0,20,4,'CL','',0),(111,108,108,'Dragoon Regt #3  von Irwing 5 sqns',11,'F','F',23,600,60,24,3,6,1,0,20,4,'CL','',0),(110,108,108,'Hussar Regt #8  von Blucher 10 sqns',11,'F','F',22,1200,100,20,5,6,1,0,20,4,'CL','',0),(109,108,108,'Hussar Regt #4  von Wurttemburg. 10 sqns',11,'F','F',21,1200,10,20,5,6,1,0,20,4,'CL','',0),(108,102,0,'Cavalry Brigade von Blucher',6,'F','T',12,0,0,0,0,0,1,0,20,4,'CL','',0),(107,103,103,'Kloch Fusilier #18',10,'F','F',67,780,10,12,6,5,1,0,20,4,'CL','',0),(106,103,103,'Oswald Fuslier #14',10,'F','F',66,780,10,12,6,5,1,0,20,4,'CL','',0),(105,103,103,'Grieffenberg Fusilier #4',10,'F','F',65,780,10,12,6,5,1,0,20,4,'CL','',0),(104,103,103,'Weimar Fusilier',10,'F','F',64,780,10,12,6,5,1,0,20,4,'CL','',0),(103,102,0,'Fusilier Brigade von Oswald',5,'F','T',19,0,0,0,0,0,1,0,20,4,'CL','',0),(102,101,0,'Advanced Guard Division von Blucher',4,'T','F',11,0,0,0,0,0,1,0,20,4,'CL','',0),(101,100,0,'Brunswick\'s Main Army - Northern Wing (Auerstaedt)',3,'T','F',4,0,0,0,0,0,1,0,20,4,'CL','',0),(100,0,0,'Prussian/Saxon forces at Jena Auerstaedt',1,'T','F',3,0,0,0,0,0,1,0,20,4,'CL','',0),(200,0,0,'French VII Corps 1806 - Augereau',2,'T','F',3,0,0,0,0,0,1,0,20,3,'CL','',0),(201,200,0,'1st Division: Desjardin',4,'T','T',9,0,0,0,0,0,1,0,20,3,'CL','',0),(202,201,201,'Brigade d\' Legere Lapisse',5,'F','F',15,0,0,0,0,0,1,0,20,3,'CL','',0),(203,202,201,'16eme Legere, 1e Bn',10,'F','F',45,720,10,14,4,4,1,0,20,3,'CL','',0),(204,202,201,'16eme Legere, 2e Bn',10,'F','F',46,720,10,14,4,4,1,0,20,3,'CL','',0),(205,202,201,'16eme Legere, 3e Bn',10,'F','F',47,720,10,14,4,4,1,0,20,3,'CL','',0),(206,202,201,'16eme Legere, 4e Bn',10,'F','F',48,720,10,14,4,4,1,0,20,3,'CL','',0),(207,201,201,'Brigade d\' Ligne Lefranc',5,'F','F',16,0,0,0,0,0,1,0,20,3,'CL','',0),(208,207,201,'14eme Legere, 2e Bn',10,'F','F',49,720,10,14,4,4,1,0,20,3,'CL','',0),(209,207,201,'44eme Ligne, 1e Bn',10,'F','F',50,720,10,10,6,6,1,0,20,3,'CL','',0),(210,207,201,'44eme Ligne, 2e Bn',10,'F','F',51,720,10,10,6,6,1,0,20,3,'CL','',0),(211,207,201,'44eme Ligne, 3e Bn',10,'F','F',52,720,10,10,6,6,1,0,20,3,'CL','',0),(212,207,201,'105eme Ligne, 1e Bn',10,'F','F',53,720,10,10,6,6,1,0,20,3,'CL','',0),(213,207,201,'105eme Ligne, 2e Bn',10,'F','F',54,720,10,10,6,6,1,0,20,3,'CL','',0),(214,207,201,'105eme Ligne, 3e Bn',10,'F','F',55,720,10,10,6,6,1,0,20,3,'CL','',0),(215,201,201,'3rd Foot Artillery Regiment, 4th company',12,'F','F',21,4,10,10,1,1,1,0,20,3,'CL','',0),(216,201,201,'6th Horse Artillery Regiment, 2nd company',12,'F','F',22,4,10,10,5,1,1,0,20,3,'CL','',0),(217,200,0,'2nd Division: Gardanne',4,'T','T',10,0,0,0,0,0,1,0,20,3,'CL','',0),(218,217,217,'Brigade d\' Legere Marcognet',5,'F','F',17,0,0,0,0,0,1,0,20,3,'CL','',0),(219,218,217,'25eme Legere, 1e Bn',10,'F','F',56,720,10,14,4,4,1,0,20,3,'CL','',0),(220,218,217,'25eme Legere, 2e Bn',10,'F','F',57,720,10,14,4,4,1,0,20,3,'CL','',0),(221,217,217,'Brigade d\' Ligne Delabassé',5,'F','F',18,0,0,0,0,0,1,0,20,3,'CL','',0),(222,221,217,'27eme Ligne, 1e Bn',10,'F','F',58,720,10,10,6,6,1,0,20,3,'CL','',0),(223,221,217,'27eme Ligne, 2e Bn',10,'F','F',59,720,10,10,6,6,1,0,20,3,'CL','',0),(224,221,217,'50eme Ligne, 1e Bn',10,'F','F',60,720,10,10,6,6,1,0,20,3,'CL','',0),(225,221,217,'50eme Ligne, 2e Bn',10,'F','F',61,720,10,10,6,6,1,0,20,3,'CL','',0),(226,221,217,'59eme Ligne, 1e Bn',10,'F','F',62,720,10,10,6,6,1,0,20,3,'CL','',0),(227,221,217,'59eme Ligne, 2e Bn',10,'F','F',63,720,10,10,6,6,1,0,20,3,'CL','',0),(228,200,0,'Brigade d\' Cheval  Colbert-Chabanais',6,'F','T',11,0,0,0,0,0,1,0,20,3,'CL','',0),(159,157,157,'Bünting Cuirassier Regiment # 12, five squadrons',11,'F','F',30,600,10,27,3,5,1,0,20,4,'CL','',0);
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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_army`
--

LOCK TABLES `unit_army` WRITE;
/*!40000 ALTER TABLE `unit_army` DISABLE KEYS */;
INSERT INTO `unit_army` VALUES (3,'King of Prussia',3,6,1);
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
) ENGINE=MyISAM AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_battalion`
--

LOCK TABLES `unit_battalion` WRITE;
/*!40000 ALTER TABLE `unit_battalion` DISABLE KEYS */;
INSERT INTO `unit_battalion` VALUES (68,'4','3',0,'F','F','F','F','F'),(69,'8 + Mounted Officer','3',0,'F','F','F','F','T'),(70,'8 + Mounted Officer','3',0,'F','F','F','F','T'),(71,'4','3',0,'F','F','F','T','F'),(72,'8 + Mounted Officer','3',0,'F','F','F','F','T'),(73,'8 + Mounted Officer','3',0,'F','F','F','F','T'),(82,'8 + Mounted Officer','3',0,'F','F','F','F','T'),(81,'8 + Mounted Officer','3',0,'F','F','F','F','T'),(80,'4','3',0,'F','F','F','T','F'),(79,'8 + Mounted Officer','3',0,'F','F','F','F','T'),(78,'8 + Mounted Officer','3',0,'F','F','F','F','T'),(77,'4','3',0,'F','F','F','T','F'),(76,'8 + Mounted Officer','3',0,'F','F','F','F','T'),(75,'8 + Mounted Officer','3',0,'F','F','F','F','T'),(74,'4','3',0,'F','F','F','T','F'),(67,'4','3',1,'T','T','F','F','F'),(66,'4','3',1,'T','F','F','F','F'),(65,'4','3',1,'T','F','F','F','F'),(64,'4','3',1,'T','F','F','F','F'),(45,'4','3',2,'T','F','T','F','F'),(46,'4','3',2,'T','F','T','F','F'),(47,'4','3',2,'T','F','T','F','F'),(48,'4','3',2,'T','F','T','F','F'),(49,'4','3',2,'T','F','F','F','F'),(50,'4','3',1,'T','F','T','F','F'),(51,'4','3',1,'T','F','T','F','F'),(52,'4','3',1,'T','F','T','F','F'),(53,'4','3',1,'T','F','T','F','F'),(54,'4','3',1,'T','F','T','F','F'),(55,'4','3',1,'T','F','T','F','F'),(56,'4','3',2,'T','F','T','F','F'),(57,'4','3',2,'T','F','T','F','F'),(58,'4','3',1,'T','F','T','F','F'),(59,'4','3',1,'T','F','T','F','F'),(60,'4','3',1,'T','F','T','F','F'),(61,'4','3',1,'T','F','T','F','F'),(62,'4','3',1,'T','F','T','F','F'),(63,'4','3',1,'T','F','T','F','F'),(83,'','3',0,'F','F','F','T','F'),(84,'8 + Mounted Officer','3',0,'F','F','F','F','T'),(85,'8 + Mounted Officer','3',0,'F','F','F','F','T');
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
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_battery`
--

LOCK TABLES `unit_battery` WRITE;
/*!40000 ALTER TABLE `unit_battery` DISABLE KEYS */;
INSERT INTO `unit_battery` VALUES (23,'Horse','6lb',3,2,'','Class II'),(24,'Foot','6lb',2,3,'','Class III'),(25,'Foot','6lb',2,3,'','Class III'),(26,'Horse','4lb',0,0,'','Class II'),(29,'Horse','4lb',0,0,'','Class I'),(28,'Foot','8lb',2,3,'','Class III'),(27,'Foot','8lb',2,3,'','Class III'),(21,'Foot','12lb',1,4,'2 x 6\" Howitzer','Class I'),(22,'Horse','6lb',2,2,'','Class I'),(30,'Foot','8lb',2,3,'','Class III'),(31,'Foot','8lb',2,3,'','Class III'),(32,'Horse','4lb',3,2,'','Class II');
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
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_brigade`
--

LOCK TABLES `unit_brigade` WRITE;
/*!40000 ALTER TABLE `unit_brigade` DISABLE KEYS */;
INSERT INTO `unit_brigade` VALUES (21,'Oberst Johann Adolf von Lutzow',3,1),(22,'General-Major Karl Alexander von Wedel',3,1),(23,'General-Major Johann Jeremias von Renouard',3,1),(24,'General-Major Ludolph August Friedrich von Alvensleben',3,1),(25,'General-Major Dietrich Lebrecht von Schimonsky',3,1),(20,'Oberst Prince Henry',3,1),(19,'General-Major Friedrich Gottlieb von Oswald',3,1),(15,'General of Brigade Pierre Belon Lapisse',2,2),(16,'General of Brigade Jacques Lefranc',3,2),(17,'General of Brigade Pierre-Louis Binet de Marcognet',2,2),(18,'General of Brigade Mathieu Delabassé',3,2);
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
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_cavbrigade`
--

LOCK TABLES `unit_cavbrigade` WRITE;
/*!40000 ALTER TABLE `unit_cavbrigade` DISABLE KEYS */;
INSERT INTO `unit_cavbrigade` VALUES (14,'General-Major Christan Heinrich von Quitzow',3,'T','Packed'),(15,'General-Major Friedrich Daniel Wilhelm von Irwing',3,'T','Packed'),(16,'General-Major Karl Wilhelm von Bünting',3,'T','Packed'),(13,'Oberstleutnant Prince Wilhelm',3,'T','Packed'),(12,'Blucher',2,'T','Packed'),(11,'General of Brigade Auguste François-Marie de Colbert-Chabanais',3,'T','Packed');
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
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_corps`
--

LOCK TABLES `unit_corps` WRITE;
/*!40000 ALTER TABLE `unit_corps` DISABLE KEYS */;
INSERT INTO `unit_corps` VALUES (4,'Duke of Brunswick',3,6,1),(3,'Marshal Pierre Augereau',2,2,3);
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
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_division`
--

LOCK TABLES `unit_division` WRITE;
/*!40000 ALTER TABLE `unit_division` DISABLE KEYS */;
INSERT INTO `unit_division` VALUES (13,'General-Leutnant Leopold Alexander von Wartensleben',3,6,1),(14,'General-Leutnant Friedrich Wilhelm Karl von Schmettau',3,6,1),(11,'General-Leutnant Gebhard Leberecht von Blucher',2,6,1),(12,'General-Leutnant Prince William of Orange',4,6,1),(9,'General of Division Jacques Desjardin',3,3,3),(10,'General of Division Gaspard Amédée Gardanne',3,3,3);
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
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_squadron`
--

LOCK TABLES `unit_squadron` WRITE;
/*!40000 ALTER TABLE `unit_squadron` DISABLE KEYS */;
INSERT INTO `unit_squadron` VALUES (21,1,10,'F','F','','Light'),(22,1,10,'F','F','','Light'),(23,4,5,'T','F','','Light'),(30,7,5,'T','F','','Heavy'),(29,7,5,'T','F','','Heavy'),(28,4,10,'T','F','','Heavy'),(27,7,0,'T','F','','Heavy'),(26,7,0,'T','F','','Heavy'),(25,7,0,'T','F','','Heavy'),(24,8,0,'T','F','','Heavy');
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
INSERT INTO `user` VALUES (8,'umpire','51af21c411643bd7a7e8d77e0d3c9acd','2012-04-12 02:43:57','steveoc64@gmail,com','T','U',1,0,1,''),(9,'duke of brunswick','5d2bbc279b5ce75815849d5e3f0533ec','2012-04-15 08:48:17','steveoc64@gmail,com','F','P',1,101,2,''),(10,'augereau','88e77ff74930f37010370c296d14737b','2012-04-13 21:57:33','steveoc64@gmail,com','F','P',1,200,1,''),(20,'admin','21232f297a57a5a743894a0e4a801fc3','2012-04-15 04:37:35','steveoc64@gmail.com','F','A',1,0,0,''),(25,'wartensleben','b50cd72da9f57f8bf6880303ff5b7622','2012-04-15 05:10:15','steveoc64@gmail.com','F','P',1,128,2,'');
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

-- Dump completed on 2012-04-15  9:45:06
