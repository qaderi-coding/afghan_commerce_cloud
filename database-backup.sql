-- MySQL dump 10.17  Distrib 10.3.11-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: kl_accountant
-- ------------------------------------------------------
-- Server version	10.3.11-MariaDB

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
-- Table structure for table `accountcategories`
--

DROP TABLE IF EXISTS `accountcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accountId` (`accountId`),
  KEY `account_categories_name` (`name`),
  CONSTRAINT `accountcategories_ibfk_1` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountcategories`
--

LOCK TABLES `accountcategories` WRITE;
/*!40000 ALTER TABLE `accountcategories` DISABLE KEYS */;
INSERT INTO `accountcategories` VALUES (5,'ورداش',101),(6,'ورداش',102),(7,'ورداش',103),(8,'ورداش',104),(9,'بازارموندونکی',105),(10,'بازارموندونکی',106),(11,'بازارموندونکی',107),(12,'عادی',108),(14,'انلاین مارکیټینګ',109),(15,'سرمایه',95),(19,'کښتګر',118),(20,'کښتګر',119),(21,'کښتګر',115),(22,'کښتګر',114),(23,'کښتګر',113),(24,'کښتګر',112),(25,'کښتګر',111),(26,'کښتګر',110),(27,'کښتګر',91),(28,'کښتګر',90),(30,'کښتګر',88),(31,'کښتګر',85),(32,'کښتګر',84),(33,'کښتګر',83),(34,'کښتګر',82),(35,'کښتګر',71),(36,'کښتګر',72),(37,'کښتګر',70),(38,'کښتګر',120),(39,'کښتګر',121),(40,'کښتګر',123),(42,'Kabul',76),(43,'کښتګر',76),(44,'Kabul',77),(45,'کښتګر',77),(46,'کښتګر',86),(47,'Kabul',86),(48,'Kabul',78),(49,'کښتګر',78),(50,'Kabul',124),(51,'کښتګر',124);
/*!40000 ALTER TABLE `accountcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `balanceType` char(2) NOT NULL,
  `subType` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `system` tinyint(1) NOT NULL DEFAULT 0,
  `maxCreditSales` double NOT NULL DEFAULT 0,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`),
  KEY `userId` (`userId`),
  KEY `accounts_type` (`type`),
  KEY `accounts_system` (`system`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'2026-03-28 17:28:39','نغدي','currentAsset','dr','cash',NULL,NULL,NULL,1,0,NULL),(2,'2026-03-28 17:28:39','اصلي سټاک','currentAsset','dr','stock',NULL,NULL,NULL,1,0,NULL),(3,'2026-03-28 17:28:39','د لاسته راوړو وړ پیسې','currentAsset','dr',NULL,NULL,NULL,NULL,1,0,NULL),(4,'2026-03-28 17:28:39','د تادیې وړ پیسې','liability','cr',NULL,NULL,NULL,NULL,1,0,NULL),(5,'2026-03-28 17:28:39','د ثابتی شتمنۍ خرڅلاو','revenue','cr',NULL,NULL,NULL,NULL,1,0,NULL),(6,'2026-03-28 17:28:39','د ثابتی شتمنۍ تمام شد قیمت','expense','dr',NULL,NULL,NULL,NULL,1,0,NULL),(7,'2026-03-28 17:28:39','د اجناسو تاوان','expense','dr',NULL,NULL,NULL,NULL,1,0,NULL),(8,'2026-03-28 17:28:39','د خرڅ شوي اجناسو تمام شد قیمت','expense','dr',NULL,NULL,NULL,NULL,1,0,NULL),(9,'2026-03-28 17:28:39','د خرڅلاو عاید','revenue','cr',NULL,NULL,NULL,NULL,1,0,NULL),(10,'2026-03-28 17:28:39','نارسیده اجناس','currentAsset','dr','stock',NULL,NULL,NULL,1,0,NULL),(11,'2026-03-28 17:28:39','معاشات','expense','dr',NULL,NULL,NULL,NULL,1,0,NULL),(12,'2026-03-28 17:28:39','د تادیې وړ معاشات','liability','cr',NULL,NULL,NULL,NULL,1,0,NULL),(13,'2026-03-28 17:28:39','ساتل شوې ګټه','profit','cr',NULL,NULL,NULL,NULL,1,0,NULL),(14,'2026-03-28 17:28:39','سرمایه','capital','cr',NULL,NULL,NULL,NULL,1,0,NULL),(15,'2026-03-28 17:28:39','د خدماتو عاید','revenue','cr',NULL,NULL,NULL,NULL,1,0,NULL),(16,'2026-03-28 17:28:39','د خدماتو لګښت','expense','dr',NULL,NULL,NULL,NULL,1,0,NULL),(17,'2026-03-28 17:28:39','$17','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(18,'2026-03-28 17:28:39','$18','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(19,'2026-03-28 17:28:39','$19','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(20,'2026-03-28 17:28:39','$20','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(21,'2026-03-28 17:28:39','$21','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(22,'2026-03-28 17:28:39','$22','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(23,'2026-03-28 17:28:39','$23','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(24,'2026-03-28 17:28:39','$24','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(25,'2026-03-28 17:28:39','$25','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(26,'2026-03-28 17:28:39','$26','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(27,'2026-03-28 17:28:39','$27','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(28,'2026-03-28 17:28:39','$28','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(29,'2026-03-28 17:28:39','$29','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(30,'2026-03-28 17:28:39','$30','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(31,'2026-03-28 17:28:39','$31','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(32,'2026-03-28 17:28:39','$32','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(33,'2026-03-28 17:28:39','$33','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(34,'2026-03-28 17:28:39','$34','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(35,'2026-03-28 17:28:39','$35','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(36,'2026-03-28 17:28:39','$36','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(37,'2026-03-28 17:28:39','$37','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(38,'2026-03-28 17:28:39','$38','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(39,'2026-03-28 17:28:39','$39','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(40,'2026-03-28 17:28:39','$40','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(41,'2026-03-28 17:28:39','$41','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(42,'2026-03-28 17:28:39','$42','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(43,'2026-03-28 17:28:39','$43','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(44,'2026-03-28 17:28:39','$44','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(45,'2026-03-28 17:28:39','$45','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(46,'2026-03-28 17:28:39','$46','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(47,'2026-03-28 17:28:39','$47','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(48,'2026-03-28 17:28:39','$48','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(49,'2026-03-28 17:28:39','$49','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(50,'2026-03-28 17:28:39','$50','systemReserved','dr',NULL,NULL,NULL,NULL,1,0,NULL),(54,'2026-03-30 14:35:50','د کور مصارفات','expense','dr',NULL,NULL,NULL,NULL,0,0,2),(55,'2026-03-30 14:36:01','د دوکان مصارفات','expense','dr',NULL,NULL,NULL,NULL,0,0,2),(56,'2026-03-30 19:33:16','عبدالله فضلی - سرمایه','personal','cr','shareholder','0705271068','کندهار',NULL,0,0,2),(60,'2026-04-02 19:37:22','حضرت شاه','personal','cr',NULL,'0700366868','کندهار',NULL,0,0,2),(61,'2026-04-02 19:49:40','ګل احمد','personal','cr',NULL,'0700344026','کندهار',NULL,0,30000,2),(62,'2026-04-02 19:50:21','ذبیر احمد - امه زوی','personal','cr',NULL,'0700351327','کندهار',NULL,0,15000,2),(63,'2026-04-02 19:50:42','حیات الله ماما','personal','cr',NULL,NULL,'کندهار',NULL,0,30000,2),(64,'2026-04-02 19:50:58','نصیر احمد - خاله زوی','personal','cr',NULL,NULL,'کندهار',NULL,0,0,2),(65,'2026-04-02 19:51:10','ذبیح الله - امه زوی','personal','cr',NULL,'','کندهار',NULL,0,0,2),(66,'2026-04-02 19:51:39','سرور - کوکا آغا','personal','cr',NULL,NULL,'کندهار',NULL,0,10000,2),(67,'2026-04-02 19:51:56','نور احمد','personal','cr',NULL,NULL,'کندهار',NULL,0,15000,2),(68,'2026-04-02 19:52:11','حضرت ماما','personal','cr',NULL,NULL,'کندهار',NULL,0,20000,2),(69,'2026-04-02 19:52:33','احمد ولی اغا - خاله زوی','personal','cr',NULL,NULL,'کندهار',NULL,0,10000,2),(70,'2026-04-02 19:52:58','نوری ټکنالوژي','personal','cr',NULL,NULL,'کندهار',NULL,0,50000,2),(71,'2026-04-02 19:53:14','افتاب ښوونیز مرکز','personal','cr',NULL,NULL,'کندهار',NULL,0,0,2),(72,'2026-04-02 19:53:27','احمد خوشحال','personal','cr',NULL,NULL,'کندهار',NULL,0,30000,2),(73,'2026-04-02 19:54:08','نجیب الله - کاکا زوی','personal','cr',NULL,'0702588900','کندهار',NULL,0,0,2),(74,'2026-04-02 19:54:30','نور الله - کاکا زوی','personal','cr',NULL,'0703003414','کندهار',NULL,0,0,2),(75,'2026-04-02 19:54:52','المدینه فضلی شرکت','personal','cr',NULL,'0700317475 - 0700321715','کندهار',NULL,0,0,2),(76,'2026-04-03 09:47:23','ملی ټکنالوژي','personal','cr',NULL,NULL,'Kabul',NULL,0,0,2),(77,'2026-04-03 09:47:33','حیدری','personal','cr',NULL,NULL,'Kabul',NULL,0,0,2),(78,'2026-04-03 09:48:07','الاحسان کمپیوټر - کابل','personal','cr',NULL,NULL,'Kabul',NULL,0,0,2),(79,'2026-04-03 09:48:26','عمران ټکنالوژي','personal','cr',NULL,NULL,'Kandahar',NULL,0,0,2),(80,'2026-04-03 09:48:36','عادل کمپیوټر','personal','cr',NULL,NULL,'Kandahar',NULL,0,0,2),(81,'2026-04-03 09:48:48','اسحاق نظری کمپیوټر','personal','cr',NULL,NULL,'Kandahar',NULL,0,0,2),(82,'2026-04-03 09:48:58','لمر کمپیوټر - کندهار','personal','cr',NULL,NULL,'Kandahar',NULL,0,0,2),(83,'2026-04-03 09:49:08','فیضانی کمپیوټر','personal','cr',NULL,NULL,'Kandahar',NULL,0,0,2),(84,'2026-04-03 09:49:18','الاحسان کمپیوټر - کندهار','personal','cr',NULL,NULL,'Kandahar',NULL,0,0,2),(85,'2026-04-03 09:49:28','اوشن امنیتی کامرې','personal','cr',NULL,NULL,'Kandahar',NULL,0,0,2),(86,'2026-04-03 09:49:38','اسلام شینواری کمپیوټر','personal','cr',NULL,NULL,'Kabul',NULL,0,0,2),(87,'2026-04-03 09:49:50','نیازی Netss Wifi  والا','personal','cr',NULL,NULL,'Kabul',NULL,0,0,2),(88,'2026-04-03 09:50:09','هوتکی کمپیوټر','personal','cr',NULL,NULL,'Kandahar',NULL,0,0,2),(90,'2026-04-03 09:50:36','عزت عادل کمپیوټر','personal','cr',NULL,NULL,'Kandahar',NULL,0,0,2),(91,'2026-04-03 09:51:06','شیرزاد کمپیوټر','personal','cr',NULL,NULL,'Kandahar',NULL,0,0,2),(92,'2026-04-03 10:05:42','نصیر احمد - ملګری','personal','cr',NULL,NULL,'Kandahar',NULL,0,0,2),(93,'2026-04-03 19:43:25','دریابی صرافی','currentAsset','dr','cash',NULL,'کندهار صرافی',NULL,0,0,2),(95,'2026-04-03 23:10:51','نبی الله فضلی - سرمایه','personal','cr','shareholder','0706293877','کندهار',NULL,0,0,2),(97,'2026-04-04 11:51:57','عمومی اکاونټ','expense','dr',NULL,NULL,NULL,NULL,0,0,2),(98,'2026-04-04 15:55:27','عمومی عاید حساب','revenue','cr',NULL,NULL,NULL,NULL,0,0,2),(101,'2026-04-04 18:10:31','عبدالله فضلی - ورداش','personal','cr',NULL,NULL,NULL,NULL,0,0,2),(102,'2026-04-04 18:10:39','نبی الله فضلی - ورداش','personal','cr',NULL,NULL,NULL,NULL,0,0,2),(103,'2026-04-04 18:10:51','د کور مصارف','personal','cr',NULL,NULL,NULL,NULL,0,0,2),(104,'2026-04-04 18:11:07','د دوکان مصارف','personal','cr',NULL,NULL,NULL,NULL,0,0,2),(105,'2026-04-05 06:30:29','حضرت شاه - بازار موندونکی','personal','cr',NULL,NULL,NULL,NULL,0,0,2),(106,'2026-04-05 06:30:46','ګل احمد - بازارموندونکی','personal','cr',NULL,NULL,NULL,NULL,0,0,2),(107,'2026-04-05 06:31:02','نور احمد - بازار موندونکی','personal','cr',NULL,NULL,NULL,NULL,0,0,2),(108,'2026-04-05 06:45:48','ګیراک - عمومی','personal','cr',NULL,NULL,NULL,NULL,0,0,2),(109,'2026-04-05 16:17:08','انلاین مارکیټینګ','personal','cr',NULL,NULL,NULL,NULL,0,0,2),(110,'2026-04-05 16:37:09','نجیب عادل کمپیوټر','personal','cr',NULL,NULL,'Kandahar',NULL,0,0,2),(111,'2026-04-05 16:57:06','کندهار کمپیوټر','personal','cr',NULL,NULL,'Kandahar',NULL,0,0,2),(112,'2026-04-06 16:33:18','عبدالهادی بکواه','personal','cr',NULL,NULL,'Bakwa',NULL,0,0,2),(113,'2026-04-07 09:56:24','احسان الله - ویش بولدک','personal','cr',NULL,'0700449587','Boldak',NULL,0,0,2),(114,'2026-04-09 13:20:58','عبدالباری استاد - ګرشک','personal','cr',NULL,NULL,'Helmand, Greshk',NULL,0,0,2),(115,'2026-04-09 15:19:10','سلام نوری ټکنالوژي','personal','cr',NULL,NULL,'Kandahar',NULL,0,0,2),(116,'2026-04-09 17:19:31','حاجی بسم الله','personal','cr',NULL,NULL,NULL,NULL,0,0,2),(117,'2026-04-12 19:44:49','د ویش - بولدک څخه سودا','personal','cr',NULL,NULL,NULL,NULL,0,0,2),(118,'2026-04-16 12:46:29','احسان ټکنالوژي','personal','cr',NULL,NULL,'کندهار',NULL,0,0,2),(119,'2026-04-16 16:04:29','جوس والا - غازی پارک','personal','cr',NULL,'0706047587','غازی پارک، کندهار',NULL,0,0,2),(120,'2026-04-21 18:35:58','ګل احمد تلویزون والا','personal','cr',NULL,NULL,'کندهار',NULL,0,0,2),(121,'2026-04-23 14:52:27','فضلی احمد اغا','personal','cr',NULL,NULL,NULL,NULL,0,0,2),(122,'2026-04-23 16:27:27','د پیسو استولو کمیشن','expense','dr',NULL,NULL,NULL,NULL,0,0,2),(123,'2026-04-27 17:32:26','حضرت الله - ویش - بولدک','personal','cr',NULL,NULL,NULL,NULL,0,0,2),(124,'2026-04-27 18:24:09','بلال ټکنالوژي','personal','cr',NULL,NULL,'کابل',NULL,0,0,2),(125,'2026-04-30 20:18:38','حاجی عبدالله - ویش بولدک','personal','cr',NULL,NULL,NULL,NULL,0,0,2),(126,'2026-05-07 10:52:50','د کاریګر مزدوری','expense','dr',NULL,NULL,NULL,NULL,0,0,2),(127,'2026-05-07 11:31:27','کبیر احمد - میرویس مینه','personal','cr',NULL,NULL,NULL,NULL,0,0,2);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `averagecostadjustments`
--

DROP TABLE IF EXISTS `averagecostadjustments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `averagecostadjustments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `journalId` int(11) DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  `capitalAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `stockItemId` (`stockItemId`),
  KEY `capitalAccountId` (`capitalAccountId`),
  CONSTRAINT `averagecostadjustments_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `averagecostadjustments_ibfk_2` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `averagecostadjustments_ibfk_3` FOREIGN KEY (`capitalAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `averagecostadjustments`
--

LOCK TABLES `averagecostadjustments` WRITE;
/*!40000 ALTER TABLE `averagecostadjustments` DISABLE KEYS */;
/*!40000 ALTER TABLE `averagecostadjustments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `averagecosts`
--

DROP TABLE IF EXISTS `averagecosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `averagecosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `preQuantity` double NOT NULL,
  `newQuantity` double NOT NULL,
  `amount` double DEFAULT NULL,
  `code` char(3) DEFAULT NULL,
  `journalId` int(11) DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `stockItemId` (`stockItemId`),
  CONSTRAINT `averagecosts_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `averagecosts_ibfk_2` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `averagecosts`
--

LOCK TABLES `averagecosts` WRITE;
/*!40000 ALTER TABLE `averagecosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `averagecosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `balanceadjustments`
--

DROP TABLE IF EXISTS `balanceadjustments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `balanceadjustments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `type` varchar(255) NOT NULL,
  `subType` varchar(255) DEFAULT NULL,
  `journalId` int(11) DEFAULT NULL,
  `accountId` int(11) DEFAULT NULL,
  `capitalAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `accountId` (`accountId`),
  KEY `capitalAccountId` (`capitalAccountId`),
  CONSTRAINT `balanceadjustments_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `balanceadjustments_ibfk_2` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `balanceadjustments_ibfk_3` FOREIGN KEY (`capitalAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `balanceadjustments`
--

LOCK TABLES `balanceadjustments` WRITE;
/*!40000 ALTER TABLE `balanceadjustments` DISABLE KEYS */;
INSERT INTO `balanceadjustments` VALUES (3,34.3,'USD',2227.099,'AFN','payables',NULL,174,76,14),(4,77050,'AFN',77050,'AFN','payables',NULL,175,77,14),(5,85475,'AFN',85475,'AFN','payables',NULL,176,78,14),(6,26438,'AFN',26438,'AFN','receivables',NULL,177,61,14),(7,15050,'AFN',15050,'AFN','receivables',NULL,178,60,14),(8,8100,'AFN',8100,'AFN','receivables',NULL,179,62,14),(9,35000,'AFN',35000,'AFN','receivables',NULL,180,63,14),(10,5248,'AFN',5248,'AFN','receivables',NULL,181,64,14),(11,1500,'AFN',1500,'AFN','receivables',NULL,182,65,14),(12,2072,'AFN',2072,'AFN','receivables',NULL,183,66,14),(13,7472,'AFN',7472,'AFN','receivables',NULL,184,67,14),(14,13000,'AFN',13000,'AFN','receivables',NULL,185,68,14),(15,15000,'AFN',15000,'AFN','receivables',NULL,186,92,14),(16,5000,'AFN',5000,'AFN','receivables',NULL,187,69,14),(17,72900,'AFN',72900,'AFN','receivables',NULL,188,70,14),(18,8500,'AFN',8500,'AFN','receivables',NULL,189,71,14),(19,24500,'AFN',24500,'AFN','receivables',NULL,190,72,14),(20,19500,'USD',1271400,'AFN','payables',NULL,191,75,14),(21,2000,'USD',130400,'AFN','payables',NULL,192,74,14),(22,1500,'USD',97800,'AFN','payables',NULL,193,73,14),(23,60,'AFN',60,'AFN','decrease',NULL,194,93,14),(24,92373,'AFN',92373,'AFN','increase',NULL,195,1,14),(27,715280,'AFN',715280,'AFN','increase',NULL,200,1,14),(31,158700,'AFN',158700,'AFN','receivables',NULL,213,56,14),(32,190540,'AFN',190540,'AFN','receivables',NULL,214,95,14),(37,8155,'AFN',8155,'AFN','receivables',NULL,403,90,14),(38,1000,'AFN',1000,'AFN','receivables',NULL,408,106,14),(39,300,'AFN',300,'AFN','receivables',NULL,453,112,14),(40,33.8,'USD',2194.634,'AFN','payables',NULL,459,76,14);
/*!40000 ALTER TABLE `balanceadjustments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cashexchanges`
--

DROP TABLE IF EXISTS `cashexchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cashexchanges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `exchangedToAmount` double NOT NULL,
  `exchangedToCode` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `type` varchar(255) NOT NULL,
  `journalId` int(11) DEFAULT NULL,
  `accountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `accountId` (`accountId`),
  CONSTRAINT `cashexchanges_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cashexchanges_ibfk_2` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cashexchanges`
--

LOCK TABLES `cashexchanges` WRITE;
/*!40000 ALTER TABLE `cashexchanges` DISABLE KEYS */;
INSERT INTO `cashexchanges` VALUES (3,23043.3,'USD',1502423.16,'AFN',1502423.16,'AFN','negativeCash',223,14),(5,32525,'AFN',500,'USD',32525,'AFN','positiveCash',296,1),(7,104080,'AFN',1600,'USD',104080,'AFN','positiveCash',301,93),(8,19480,'AFN',300,'USD',19479.000000000004,'AFN','positiveCash',387,1);
/*!40000 ALTER TABLE `cashexchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cashpaymentitems`
--

DROP TABLE IF EXISTS `cashpaymentitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cashpaymentitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `inExchangeForAmount` double NOT NULL,
  `inExchangeForCode` char(3) NOT NULL,
  `cashPaymentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cashPaymentId` (`cashPaymentId`),
  CONSTRAINT `cashpaymentitems_ibfk_1` FOREIGN KEY (`cashPaymentId`) REFERENCES `cashpayments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cashpaymentitems`
--

LOCK TABLES `cashpaymentitems` WRITE;
/*!40000 ALTER TABLE `cashpaymentitems` DISABLE KEYS */;
INSERT INTO `cashpaymentitems` VALUES (3,30000,'AFN',30000,'AFN',30000,'AFN',3),(4,5200,'AFN',5200,'AFN',5200,'AFN',4),(6,3750,'AFN',3750,'AFN',3750,'AFN',6),(7,3200,'AFN',3200,'AFN',3200,'AFN',7),(8,1300,'AFN',1300,'AFN',20,'USD',8),(9,4600,'AFN',4600,'AFN',4600,'AFN',5),(10,3000,'AFN',3000,'AFN',3000,'AFN',9),(11,11000,'AFN',11000,'AFN',11000,'AFN',10),(12,1100,'AFN',1100,'AFN',1100,'AFN',11),(13,11700,'AFN',11700,'AFN',11700,'AFN',12),(14,10000,'AFN',10000,'AFN',10000,'AFN',13),(15,2500,'AFN',2500,'AFN',2500,'AFN',14),(16,2000,'AFN',2000,'AFN',2000,'AFN',15),(17,6705,'AFN',6705,'AFN',6705,'AFN',16),(18,6000,'AFN',6000,'AFN',6000,'AFN',17),(19,2500,'AFN',2500,'AFN',2500,'AFN',18),(21,500,'AFN',500,'AFN',500,'AFN',20),(22,300,'AFN',300,'AFN',300,'AFN',21),(23,2140,'AFN',2140,'AFN',2140,'AFN',22),(24,3000,'AFN',3000,'AFN',3000,'AFN',23),(28,100140,'AFN',100140,'AFN',100140,'AFN',25),(29,2795,'AFN',2795,'AFN',2795,'AFN',26),(30,600,'AFN',600,'AFN',600,'AFN',27),(31,2500,'AFN',2500,'AFN',2500,'AFN',28),(32,2000,'AFN',2000,'AFN',2000,'AFN',29),(33,1000,'AFN',1000,'AFN',1000,'AFN',30),(34,3000,'AFN',3000,'AFN',3000,'AFN',31),(35,100,'USD',6470,'AFN',100,'USD',32),(36,2600,'AFN',2600,'AFN',40,'USD',32),(37,400,'AFN',400,'AFN',400,'AFN',33),(38,3000,'AFN',3000,'AFN',3000,'AFN',19),(39,500,'USD',32350,'AFN',500,'USD',34),(40,500,'USD',32350,'AFN',500,'USD',35),(41,14500,'AFN',14500,'AFN',14500,'AFN',36),(42,8450,'AFN',8450,'AFN',130,'USD',37),(43,1000,'USD',64700,'AFN',1000,'USD',38),(44,4000,'AFN',4000,'AFN',4000,'AFN',39),(45,500,'AFN',500,'AFN',500,'AFN',40),(46,500,'AFN',500,'AFN',500,'AFN',41),(47,3000,'AFN',3000,'AFN',3000,'AFN',42),(48,7000,'AFN',7000,'AFN',7000,'AFN',43),(49,600,'AFN',600,'AFN',600,'AFN',44),(50,1300,'AFN',1300,'AFN',1300,'AFN',45),(51,600,'AFN',600,'AFN',600,'AFN',46),(52,2500,'AFN',2500,'AFN',2500,'AFN',47),(53,2000,'AFN',2000,'AFN',2000,'AFN',48),(54,20500,'AFN',20500,'AFN',20500,'AFN',49),(55,3000,'AFN',3000,'AFN',3000,'AFN',50),(56,11000,'AFN',11000,'AFN',11000,'AFN',51),(57,8450,'AFN',8450,'AFN',130,'USD',52),(58,4500,'AFN',4500,'AFN',4500,'AFN',53),(59,2000,'AFN',2000,'AFN',2000,'AFN',54),(61,500,'AFN',500,'AFN',500,'AFN',56),(62,2500,'AFN',2500,'AFN',2500,'AFN',57),(63,500,'AFN',500,'AFN',500,'AFN',58),(64,1000,'AFN',1000,'AFN',1000,'AFN',59),(65,6405,'AFN',6405,'AFN',6405,'AFN',60),(66,3250,'AFN',3250,'AFN',50,'USD',61),(67,2800,'AFN',2800,'AFN',2800,'AFN',61),(68,2500,'AFN',2500,'AFN',2500,'AFN',62),(69,3000,'AFN',3000,'AFN',3000,'AFN',63),(70,50000,'AFN',50000,'AFN',50000,'AFN',55),(71,1500,'AFN',1500,'AFN',1500,'AFN',64),(73,5040,'AFN',5040,'AFN',5040,'AFN',65),(74,19000,'AFN',19000,'AFN',19000,'AFN',66),(75,1100,'AFN',1100,'AFN',1100,'AFN',67),(76,3300,'AFN',3300,'AFN',3300,'AFN',68),(77,2500,'AFN',2500,'AFN',2500,'AFN',69),(78,2500,'AFN',2500,'AFN',2500,'AFN',70),(79,300,'AFN',300,'AFN',300,'AFN',71),(80,4500,'AFN',4500,'AFN',4500,'AFN',72),(81,600,'AFN',600,'AFN',600,'AFN',73),(82,2500,'AFN',2500,'AFN',2500,'AFN',74),(83,1000,'AFN',1000,'AFN',1000,'AFN',75),(84,4000,'AFN',4000,'AFN',4000,'AFN',76),(86,40475,'AFN',40475,'AFN',40475,'AFN',77),(87,1550,'AFN',1550,'AFN',1550,'AFN',78),(88,1160,'AFN',1160,'AFN',1160,'AFN',79),(89,6000,'AFN',6000,'AFN',6000,'AFN',80),(90,2000,'AFN',2000,'AFN',2000,'AFN',81),(92,7030,'AFN',7030,'AFN',110,'USD',83),(93,2000,'AFN',2000,'AFN',2000,'AFN',84),(94,2500,'AFN',2500,'AFN',2500,'AFN',85),(95,1000,'AFN',1000,'AFN',1000,'AFN',86),(96,300,'AFN',300,'AFN',300,'AFN',87),(97,7500,'AFN',7500,'AFN',7500,'AFN',88),(98,18000,'AFN',18000,'AFN',18000,'AFN',89);
/*!40000 ALTER TABLE `cashpaymentitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cashpayments`
--

DROP TABLE IF EXISTS `cashpayments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cashpayments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `includeOldBalance` tinyint(1) DEFAULT 0,
  `journalId` int(11) DEFAULT NULL,
  `recipientAccountId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `recipientAccountId` (`recipientAccountId`),
  KEY `cashAccountId` (`cashAccountId`),
  CONSTRAINT `cashpayments_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cashpayments_ibfk_2` FOREIGN KEY (`recipientAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `cashpayments_ibfk_3` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cashpayments`
--

LOCK TABLES `cashpayments` WRITE;
/*!40000 ALTER TABLE `cashpayments` DISABLE KEYS */;
INSERT INTO `cashpayments` VALUES (3,'{\"amount\":\"AFN 30,000\"}',0,267,85,1),(4,'{\"amount\":\"AFN 5,200\"}',0,268,85,1),(5,'{\"amount\":\"AFN 4,600\"}',0,269,81,1),(6,'{\"amount\":\"AFN 3,750\"}',0,270,79,1),(7,'{\"amount\":\"AFN 3,200\"}',0,271,80,1),(8,'{\"amount\":\"USD 20\"}',0,272,83,1),(9,'{\"amount\":\"AFN 3,000\"}',0,273,104,1),(10,'{\"amount\":\"AFN 11,000\"}',0,274,104,1),(11,'{\"amount\":\"AFN 1,100\"}',0,275,104,1),(12,'{\"amount\":\"AFN 11,700\"}',0,276,101,1),(13,'{\"amount\":\"AFN 10,000\"}',0,277,102,1),(14,'{\"amount\":\"AFN 2,500\"}',0,278,102,1),(15,'{\"amount\":\"AFN 2,000\"}',0,279,101,1),(16,'{\"amount\":\"AFN 6,705\"}',0,280,103,1),(17,'{\"amount\":\"AFN 6,000\"}',0,281,104,1),(18,'{\"amount\":\"AFN 2,500\"}',0,282,102,1),(19,'{\"amount\":\"AFN 3,000\"}',0,283,101,1),(20,'{\"amount\":\"AFN 500\"}',0,284,103,1),(21,'{\"amount\":\"AFN 300\"}',0,285,104,1),(22,'{\"amount\":\"AFN 2,140\"}',0,286,104,1),(23,'{\"amount\":\"AFN 3,000\"}',0,288,68,1),(25,'{\"amount\":\"AFN 100,140\"}',0,300,93,1),(26,'{\"amount\":\"AFN 2,795\"}',0,316,103,1),(27,'{\"amount\":\"AFN 600\"}',0,317,104,1),(28,'{\"amount\":\"AFN 2,500\"}',0,318,102,1),(29,'{\"amount\":\"AFN 2,000\"}',0,319,101,1),(30,'{\"amount\":\"AFN 1,000\"}',0,320,101,1),(31,'{\"amount\":\"AFN 3,000\"}',0,322,80,1),(32,'{\"amount\":\"USD 100, USD 40\"}',0,327,82,1),(33,'{\"amount\":\"AFN 400\"}',0,328,82,1),(34,'{\"amount\":\"USD 500\"}',0,329,76,93),(35,'{\"amount\":\"USD 500\"}',0,330,78,93),(36,'{\"amount\":\"AFN 14,500\"}',0,331,115,1),(37,'{\"amount\":\"USD 130\"}',0,341,83,1),(38,'{\"amount\":\"USD 1,000\"}',0,348,73,1),(39,'{\"amount\":\"AFN 4,000\"}',0,349,93,1),(40,'{\"amount\":\"AFN 500\"}',0,350,103,1),(41,'{\"amount\":\"AFN 500\"}',0,356,74,1),(42,'{\"amount\":\"AFN 3,000\"}',0,363,103,1),(43,'{\"amount\":\"AFN 7,000\"}',0,372,80,1),(44,'{\"amount\":\"AFN 600\"}',0,373,79,1),(45,'{\"amount\":\"AFN 1,300\"}',0,386,81,1),(46,'{\"amount\":\"AFN 600\"}',0,391,104,1),(47,'{\"amount\":\"AFN 2,500\"}',0,392,102,1),(48,'{\"amount\":\"AFN 2,000\"}',0,393,101,1),(49,'{\"amount\":\"AFN 20,500\"}',0,397,85,1),(50,'{\"amount\":\"AFN 3,000\"}',0,398,104,1),(51,'{\"amount\":\"AFN 11,000\"}',0,411,104,1),(52,'{\"amount\":\"USD 130\"}',0,414,83,1),(53,'{\"amount\":\"AFN 4,500\"}',0,428,103,1),(54,'{\"amount\":\"AFN 2,000\"}',0,429,103,1),(55,'{\"amount\":\"AFN 50,000\"}',0,436,78,93),(56,'{\"amount\":\"AFN 500\"}',0,438,102,1),(57,'{\"amount\":\"AFN 2,500\"}',0,439,102,1),(58,'{\"amount\":\"AFN 500\"}',0,440,104,1),(59,'{\"amount\":\"AFN 1,000\"}',0,441,101,1),(60,'{\"amount\":\"AFN 6,405\"}',0,445,82,1),(61,'{\"amount\":\"USD 50, AFN 2,800\"}',0,447,91,1),(62,'{\"amount\":\"AFN 2,500\"}',0,448,101,1),(63,'{\"amount\":\"AFN 3,000\"}',0,449,104,1),(64,'{\"amount\":\"AFN 1,500\"}',0,452,118,1),(65,'{\"amount\":\"AFN 5,040\"}',0,478,103,1),(66,'{\"amount\":\"AFN 19,000\"}',0,480,123,1),(67,'{\"amount\":\"AFN 1,100\"}',0,486,104,1),(68,'{\"amount\":\"AFN 3,300\"}',0,494,91,1),(69,'{\"amount\":\"AFN 2,500\"}',0,497,102,1),(70,'{\"amount\":\"AFN 2,500\"}',0,498,101,1),(71,'{\"amount\":\"AFN 300\"}',0,499,104,1),(72,'{\"amount\":\"AFN 4,500\"}',0,506,103,1),(73,'{\"amount\":\"AFN 600\"}',0,509,103,1),(74,'{\"amount\":\"AFN 2,500\"}',0,510,103,1),(75,'{\"amount\":\"AFN 1,000\"}',0,511,101,1),(76,'{\"amount\":\"AFN 4,000\"}',0,512,61,1),(77,'{\"amount\":\"AFN 40,475\"}',0,515,125,1),(78,'{\"amount\":\"AFN 1,550\"}',0,519,104,1),(79,'{\"amount\":\"AFN 1,160\"}',0,521,103,1),(80,'{\"amount\":\"AFN 6,000\"}',0,523,68,1),(81,'{\"amount\":\"AFN 2,000\"}',0,524,101,1),(83,'{\"amount\":\"USD 110\"}',1,550,82,1),(84,'{\"amount\":\"AFN 2,000\"}',0,554,101,1),(85,'{\"amount\":\"AFN 2,500\"}',0,555,102,1),(86,'{\"amount\":\"AFN 1,000\"}',0,556,103,1),(87,'{\"amount\":\"AFN 300\"}',0,557,104,1),(88,'{\"amount\":\"AFN 7,500\"}',0,572,101,1),(89,'{\"amount\":\"AFN 18,000\"}',0,573,104,1);
/*!40000 ALTER TABLE `cashpayments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cashreceiptitems`
--

DROP TABLE IF EXISTS `cashreceiptitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cashreceiptitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `inExchangeForAmount` double NOT NULL,
  `inExchangeForCode` char(3) NOT NULL,
  `cashReceiptId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cashReceiptId` (`cashReceiptId`),
  CONSTRAINT `cashreceiptitems_ibfk_1` FOREIGN KEY (`cashReceiptId`) REFERENCES `cashreceipts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cashreceiptitems`
--

LOCK TABLES `cashreceiptitems` WRITE;
/*!40000 ALTER TABLE `cashreceiptitems` DISABLE KEYS */;
INSERT INTO `cashreceiptitems` VALUES (19,2000,'AFN',2000,'AFN',2000,'AFN',5),(20,1000,'AFN',1000,'AFN',1000,'AFN',6),(21,6000,'AFN',6000,'AFN',6000,'AFN',7),(22,1000,'AFN',1000,'AFN',1000,'AFN',8),(23,16540,'AFN',16540,'AFN',16540,'AFN',9),(24,500,'AFN',500,'AFN',500,'AFN',10),(27,196832,'AFN',196832,'AFN',196832,'AFN',4),(28,196832,'AFN',196832,'AFN',196832,'AFN',3),(29,1000,'AFN',1000,'AFN',1000,'AFN',11),(30,6218,'AFN',6218,'AFN',6218,'AFN',12),(31,1000,'AFN',1000,'AFN',1000,'AFN',13),(32,1000,'AFN',1000,'AFN',1000,'AFN',14),(33,1896,'AFN',1896,'AFN',1896,'AFN',15),(35,5000,'AFN',5000,'AFN',5000,'AFN',17),(36,3005,'AFN',3005,'AFN',3005,'AFN',18),(37,300,'AFN',300,'AFN',300,'AFN',19),(38,4700,'AFN',4700,'AFN',4700,'AFN',20),(39,1416,'AFN',1416,'AFN',1416,'AFN',21),(40,1000,'AFN',1000,'AFN',1000,'AFN',22),(41,2300,'AFN',2300,'AFN',2300,'AFN',23),(43,2000,'AFN',2000,'AFN',2000,'AFN',25),(44,8500,'AFN',8500,'AFN',8500,'AFN',26);
/*!40000 ALTER TABLE `cashreceiptitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cashreceipts`
--

DROP TABLE IF EXISTS `cashreceipts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cashreceipts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `includeOldBalance` tinyint(1) DEFAULT 0,
  `journalId` int(11) DEFAULT NULL,
  `payerAccountId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `payerAccountId` (`payerAccountId`),
  KEY `cashAccountId` (`cashAccountId`),
  CONSTRAINT `cashreceipts_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cashreceipts_ibfk_2` FOREIGN KEY (`payerAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `cashreceipts_ibfk_3` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cashreceipts`
--

LOCK TABLES `cashreceipts` WRITE;
/*!40000 ALTER TABLE `cashreceipts` DISABLE KEYS */;
INSERT INTO `cashreceipts` VALUES (3,'{\"amount\":\"AFN 196,832\"}',0,219,56,1),(4,'{\"amount\":\"AFN 196,832\"}',0,220,95,1),(5,'{\"amount\":\"AFN 2,000\"}',0,287,68,1),(6,'{\"amount\":\"AFN 1,000\"}',0,289,72,1),(7,'{\"amount\":\"AFN 6,000\"}',0,315,114,1),(8,'{\"amount\":\"AFN 1,000\"}',0,347,72,1),(9,'{\"amount\":\"AFN 16,540\"}',0,355,113,1),(10,'{\"amount\":\"AFN 500\"}',0,361,74,1),(11,'{\"amount\":\"AFN 1,000\"}',0,410,72,1),(12,'{\"amount\":\"AFN 6,218\"}',0,412,114,1),(13,'{\"amount\":\"AFN 1,000\"}',0,443,106,1),(14,'{\"amount\":\"AFN 1,000\"}',0,456,72,1),(15,'{\"amount\":\"AFN 1,896\"}',0,482,119,1),(17,'{\"amount\":\"AFN 5,000\"}',1,488,118,1),(18,'{\"amount\":\"AFN 3,005\"}',0,489,90,1),(19,'{\"amount\":\"AFN 300\"}',0,490,85,1),(20,'{\"amount\":\"AFN 4,700\"}',0,504,106,1),(21,'{\"amount\":\"AFN 1,416\"}',0,505,61,1),(22,'{\"amount\":\"AFN 1,000\"}',1,526,72,1),(23,'{\"amount\":\"AFN 2,300\"}',0,529,70,1),(25,'{\"amount\":\"AFN 2,000\"}',0,553,90,1),(26,'{\"amount\":\"AFN 8,500\"}',0,571,118,1);
/*!40000 ALTER TABLE `cashreceipts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cashtransfers`
--

DROP TABLE IF EXISTS `cashtransfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cashtransfers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `includeOldBalance` tinyint(1) NOT NULL DEFAULT 0,
  `journalId` int(11) DEFAULT NULL,
  `fromAccountId` int(11) DEFAULT NULL,
  `toAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `fromAccountId` (`fromAccountId`),
  KEY `toAccountId` (`toAccountId`),
  CONSTRAINT `cashtransfers_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cashtransfers_ibfk_2` FOREIGN KEY (`fromAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `cashtransfers_ibfk_3` FOREIGN KEY (`toAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cashtransfers`
--

LOCK TABLES `cashtransfers` WRITE;
/*!40000 ALTER TABLE `cashtransfers` DISABLE KEYS */;
INSERT INTO `cashtransfers` VALUES (3,536365.05,'AFN',536365.05,'AFN',0,221,1,14),(4,14427.79,'AFN',14427.79,'AFN',0,226,1,14),(8,600,'USD',39030,'AFN',0,302,93,1),(9,50000,'AFN',50000,'AFN',0,388,1,93),(10,50000,'AFN',50000,'AFN',0,435,1,93),(11,50000,'AFN',50000,'AFN',0,460,93,1),(12,80000,'AFN',80000,'AFN',0,581,1,93);
/*!40000 ALTER TABLE `cashtransfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` char(3) NOT NULL,
  `isBaseCode` tinyint(1) DEFAULT 0,
  `isActive` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES (1,'afghani','AFN',1,1),(2,'united states dollar','USD',0,1),(3,'pakistani rupee','PKR',0,0),(4,'renminbi','CNY',0,0),(5,'iranian toman','TOM',0,0),(6,'pound sterling','GBP',0,0),(7,'euro','EUR',0,0),(8,'united arab emirates dirham','AED',0,0);
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employeeaccounts`
--

DROP TABLE IF EXISTS `employeeaccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employeeaccounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `fatherName` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `NID` varchar(255) DEFAULT NULL,
  `gender` varchar(255) NOT NULL,
  `language` varchar(255) NOT NULL,
  `position` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `salaryAmount` double NOT NULL,
  `salaryCode` char(3) NOT NULL,
  `photo` longtext DEFAULT NULL,
  `date` datetime NOT NULL,
  `isDeactivated` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `x` (`name`,`fatherName`,`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employeeaccounts`
--

LOCK TABLES `employeeaccounts` WRITE;
/*!40000 ALTER TABLE `employeeaccounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `employeeaccounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employeepaymentitems`
--

DROP TABLE IF EXISTS `employeepaymentitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employeepaymentitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `inExchangeForAmount` double NOT NULL,
  `inExchangeForCode` char(3) NOT NULL,
  `employeePaymentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `employeePaymentId` (`employeePaymentId`),
  CONSTRAINT `employeepaymentitems_ibfk_1` FOREIGN KEY (`employeePaymentId`) REFERENCES `employeepayments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employeepaymentitems`
--

LOCK TABLES `employeepaymentitems` WRITE;
/*!40000 ALTER TABLE `employeepaymentitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `employeepaymentitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employeepayments`
--

DROP TABLE IF EXISTS `employeepayments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employeepayments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `includeOldBalance` tinyint(1) DEFAULT 0,
  `journalId` int(11) DEFAULT NULL,
  `employeeAccountId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `employeeAccountId` (`employeeAccountId`),
  KEY `cashAccountId` (`cashAccountId`),
  KEY `employee_payments_type` (`type`),
  CONSTRAINT `employeepayments_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `employeepayments_ibfk_2` FOREIGN KEY (`employeeAccountId`) REFERENCES `employeeaccounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `employeepayments_ibfk_3` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employeepayments`
--

LOCK TABLES `employeepayments` WRITE;
/*!40000 ALTER TABLE `employeepayments` DISABLE KEYS */;
/*!40000 ALTER TABLE `employeepayments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `journalId` int(11) DEFAULT NULL,
  `expenseAccountId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `expenseAccountId` (`expenseAccountId`),
  KEY `cashAccountId` (`cashAccountId`),
  CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `expenses_ibfk_2` FOREIGN KEY (`expenseAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `expenses_ibfk_3` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses`
--

LOCK TABLES `expenses` WRITE;
/*!40000 ALTER TABLE `expenses` DISABLE KEYS */;
INSERT INTO `expenses` VALUES (7,9217.32,'AFN',9217.32,'AFN',227,97,1),(9,100,'AFN',100,'AFN',437,122,1),(10,100,'AFN',100,'AFN',518,122,1),(11,1600,'AFN',1600,'AFN',547,126,1);
/*!40000 ALTER TABLE `expenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financialperiods`
--

DROP TABLE IF EXISTS `financialperiods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `financialperiods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT 1,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `financialperiods_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financialperiods`
--

LOCK TABLES `financialperiods` WRITE;
/*!40000 ALTER TABLE `financialperiods` DISABLE KEYS */;
INSERT INTO `financialperiods` VALUES (1,'2026-03-28 17:28:39','',1,NULL);
/*!40000 ALTER TABLE `financialperiods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixedassetlqs`
--

DROP TABLE IF EXISTS `fixedassetlqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixedassetlqs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` varchar(255) DEFAULT NULL,
  `isDebt` varchar(255) NOT NULL DEFAULT '0',
  `calAmount` double NOT NULL,
  `calCode` char(3) NOT NULL,
  `baseCalAmount` double NOT NULL,
  `baseCalCode` char(3) NOT NULL,
  `salePriceAmount` double NOT NULL,
  `salePriceCode` char(3) NOT NULL,
  `baseSalePriceAmount` double NOT NULL,
  `baseSalePriceCode` char(3) NOT NULL,
  `journalId` int(11) DEFAULT NULL,
  `assetAccountId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  `itemId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `assetAccountId` (`assetAccountId`),
  KEY `cashAccountId` (`cashAccountId`),
  KEY `itemId` (`itemId`),
  KEY `fixed_asset_l_qs_is_debt` (`isDebt`),
  CONSTRAINT `fixedassetlqs_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fixedassetlqs_ibfk_2` FOREIGN KEY (`assetAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fixedassetlqs_ibfk_3` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fixedassetlqs_ibfk_4` FOREIGN KEY (`itemId`) REFERENCES `items` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixedassetlqs`
--

LOCK TABLES `fixedassetlqs` WRITE;
/*!40000 ALTER TABLE `fixedassetlqs` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixedassetlqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixedassets`
--

DROP TABLE IF EXISTS `fixedassets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixedassets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` varchar(255) DEFAULT NULL,
  `isDebt` varchar(255) NOT NULL DEFAULT '0',
  `unitPriceAmount` double NOT NULL,
  `unitPriceCode` char(3) NOT NULL,
  `baseUnitPriceAmount` double NOT NULL,
  `baseUnitPriceCode` char(3) NOT NULL,
  `journalId` int(11) DEFAULT NULL,
  `assetAccountId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  `itemId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `assetAccountId` (`assetAccountId`),
  KEY `cashAccountId` (`cashAccountId`),
  KEY `itemId` (`itemId`),
  KEY `fixed_assets_is_debt` (`isDebt`),
  CONSTRAINT `fixedassets_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fixedassets_ibfk_2` FOREIGN KEY (`assetAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fixedassets_ibfk_3` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fixedassets_ibfk_4` FOREIGN KEY (`itemId`) REFERENCES `items` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixedassets`
--

LOCK TABLES `fixedassets` WRITE;
/*!40000 ALTER TABLE `fixedassets` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixedassets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `investments`
--

DROP TABLE IF EXISTS `investments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `investments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `journalId` int(11) DEFAULT NULL,
  `investorId` int(11) DEFAULT NULL,
  `investedIntoId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `investorId` (`investorId`),
  KEY `investedIntoId` (`investedIntoId`),
  CONSTRAINT `investments_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `investments_ibfk_2` FOREIGN KEY (`investorId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `investments_ibfk_3` FOREIGN KEY (`investedIntoId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `investments`
--

LOCK TABLES `investments` WRITE;
/*!40000 ALTER TABLE `investments` DISABLE KEYS */;
/*!40000 ALTER TABLE `investments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `unit` varchar(255) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itemsubmissionitems`
--

DROP TABLE IF EXISTS `itemsubmissionitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemsubmissionitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit` varchar(255) NOT NULL,
  `quantity` double NOT NULL,
  `baseQuantity` double NOT NULL,
  `unitPriceAmount` double NOT NULL,
  `unitPriceCode` char(3) NOT NULL,
  `baseUnitPriceAmount` double NOT NULL,
  `baseUnitPriceCode` char(3) NOT NULL,
  `itemSubmissionId` int(11) DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  `stockAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `itemSubmissionId` (`itemSubmissionId`),
  KEY `stockItemId` (`stockItemId`),
  KEY `stockAccountId` (`stockAccountId`),
  CONSTRAINT `itemsubmissionitems_ibfk_1` FOREIGN KEY (`itemSubmissionId`) REFERENCES `itemsubmissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `itemsubmissionitems_ibfk_2` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `itemsubmissionitems_ibfk_3` FOREIGN KEY (`stockAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itemsubmissionitems`
--

LOCK TABLES `itemsubmissionitems` WRITE;
/*!40000 ALTER TABLE `itemsubmissionitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `itemsubmissionitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itemsubmissions`
--

DROP TABLE IF EXISTS `itemsubmissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemsubmissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currency` varchar(255) NOT NULL,
  `totalAmount` double NOT NULL,
  `totalCode` char(3) NOT NULL,
  `baseTotalAmount` double NOT NULL,
  `baseTotalCode` char(3) NOT NULL,
  `isReturn` tinyint(1) NOT NULL DEFAULT 0,
  `journalId` int(11) DEFAULT NULL,
  `marketerAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `marketerAccountId` (`marketerAccountId`),
  KEY `item_submissions_currency` (`currency`),
  KEY `item_submissions_is_return` (`isReturn`),
  CONSTRAINT `itemsubmissions_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `itemsubmissions_ibfk_2` FOREIGN KEY (`marketerAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itemsubmissions`
--

LOCK TABLES `itemsubmissions` WRITE;
/*!40000 ALTER TABLE `itemsubmissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `itemsubmissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journals`
--

DROP TABLE IF EXISTS `journals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `type` varchar(255) NOT NULL,
  `targetId` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `fpId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `parentId` (`parentId`),
  KEY `fpId` (`fpId`),
  KEY `journals_date` (`date`),
  KEY `journals_type` (`type`),
  CONSTRAINT `journals_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `journals_ibfk_2` FOREIGN KEY (`parentId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `journals_ibfk_3` FOREIGN KEY (`fpId`) REFERENCES `financialperiods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=584 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journals`
--

LOCK TABLES `journals` WRITE;
/*!40000 ALTER TABLE `journals` DISABLE KEYS */;
INSERT INTO `journals` VALUES (20,'2026-04-02 11:25:46','stockAdjustment','5','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(21,'2026-04-02 11:26:20','stockAdjustment','6','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(22,'2026-04-02 11:27:10','stockAdjustment','7','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(23,'2026-04-02 11:34:49','stockAdjustment','8','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(24,'2026-04-02 11:42:31','stockAdjustment','9','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(26,'2026-04-02 11:52:44','stockAdjustment','11','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(27,'2026-04-02 11:54:22','stockAdjustment','12','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(28,'2026-04-02 12:04:45','stockAdjustment','13','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(29,'2026-04-02 12:05:19','stockAdjustment','14','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(30,'2026-04-02 12:05:41','stockAdjustment','15','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(31,'2026-04-02 12:06:23','stockAdjustment','16','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(32,'2026-04-02 12:07:07','stockAdjustment','17','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(33,'2026-04-02 12:21:58','stockAdjustment','18','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(34,'2026-04-02 12:27:49','stockAdjustment','19','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(35,'2026-04-02 12:31:02','stockAdjustment','20','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(36,'2026-04-02 12:31:42','stockAdjustment','21','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(37,'2026-04-02 12:32:30','stockAdjustment','22','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(38,'2026-04-02 12:32:58','stockAdjustment','23','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(39,'2026-04-02 12:33:13','stockAdjustment','24','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(40,'2026-04-02 12:34:12','stockAdjustment','25','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(41,'2026-04-02 12:34:28','stockAdjustment','26','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(42,'2026-04-02 12:35:02','stockAdjustment','27','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(43,'2026-04-02 12:35:31','stockAdjustment','28','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(44,'2026-04-02 12:35:59','stockAdjustment','29','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(45,'2026-04-02 13:33:26','stockAdjustment','30','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(46,'2026-04-02 13:33:51','stockAdjustment','31','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(47,'2026-04-02 13:37:25','stockAdjustment','32','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(48,'2026-04-02 13:38:17','stockAdjustment','33','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(49,'2026-04-02 13:38:53','stockAdjustment','34','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(50,'2026-04-02 13:41:14','stockAdjustment','35','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(51,'2026-04-02 13:42:35','stockAdjustment','36','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(52,'2026-04-02 14:02:22','stockAdjustment','37','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(53,'2026-04-02 14:03:23','stockAdjustment','38','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(54,'2026-04-02 14:05:21','stockAdjustment','39','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(55,'2026-04-02 14:23:51','stockAdjustment','40','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(56,'2026-04-02 14:26:53','stockAdjustment','41','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(57,'2026-04-02 14:28:15','stockAdjustment','42','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(58,'2026-04-02 14:30:45','stockAdjustment','43','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(59,'2026-04-02 14:44:20','stockAdjustment','44','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(60,'2026-04-02 14:44:53','stockAdjustment','45','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(61,'2026-04-02 14:47:27','stockAdjustment','46','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(62,'2026-04-02 14:48:01','stockAdjustment','47','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(63,'2026-04-02 14:48:41','stockAdjustment','48','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(64,'2026-04-02 14:49:06','stockAdjustment','49','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(65,'2026-04-02 14:51:34','stockAdjustment','50','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(66,'2026-04-02 14:52:06','stockAdjustment','51','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(67,'2026-04-02 14:54:23','stockAdjustment','52','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(68,'2026-04-02 14:55:32','stockAdjustment','53','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(69,'2026-04-02 14:59:37','stockAdjustment','54','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(70,'2026-04-02 15:00:04','stockAdjustment','55','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(71,'2026-04-02 15:19:11','stockAdjustment','56','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(72,'2026-04-02 15:19:35','stockAdjustment','57','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(73,'2026-04-02 15:20:16','stockAdjustment','58','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(74,'2026-04-02 15:20:43','stockAdjustment','59','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(75,'2026-04-02 15:21:05','stockAdjustment','60','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(76,'2026-04-02 15:21:38','stockAdjustment','61','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(77,'2026-04-02 15:22:38','stockAdjustment','62','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(78,'2026-04-02 15:23:26','stockAdjustment','63','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(79,'2026-04-02 15:24:48','stockAdjustment','64','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(80,'2026-04-02 15:25:18','stockAdjustment','65','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(81,'2026-04-02 15:26:44','stockAdjustment','66','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(82,'2026-04-02 15:27:43','stockAdjustment','67','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(83,'2026-04-02 15:28:12','stockAdjustment','68','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(84,'2026-04-02 15:28:49','stockAdjustment','69','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(85,'2026-04-02 15:29:32','stockAdjustment','70','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(86,'2026-04-02 15:30:16','stockAdjustment','71','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(87,'2026-04-02 15:31:06','stockAdjustment','72','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(88,'2026-04-02 15:31:35','stockAdjustment','73','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(89,'2026-04-02 15:32:00','stockAdjustment','74','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(90,'2026-04-02 15:32:55','stockAdjustment','75','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(91,'2026-04-02 15:33:23','stockAdjustment','76','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(92,'2026-04-02 15:34:21','stockAdjustment','77','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(93,'2026-04-02 15:36:00','stockAdjustment','78','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(94,'2026-04-02 15:36:26','stockAdjustment','79','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(95,'2026-04-02 15:37:05','stockAdjustment','80','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(96,'2026-04-02 15:40:44','stockAdjustment','81','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(97,'2026-04-02 15:44:55','stockAdjustment','82','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(98,'2026-04-02 15:58:29','stockAdjustment','83','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(99,'2026-04-02 15:59:18','stockAdjustment','84','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(100,'2026-04-02 15:59:38','stockAdjustment','85','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(101,'2026-04-02 16:00:26','stockAdjustment','86','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(102,'2026-04-02 16:00:54','stockAdjustment','87','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(103,'2026-04-02 16:01:14','stockAdjustment','88','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(104,'2026-04-02 16:01:29','stockAdjustment','89','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(105,'2026-04-02 16:01:49','stockAdjustment','90','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(106,'2026-04-02 16:02:29','stockAdjustment','91','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(107,'2026-04-02 16:02:51','stockAdjustment','92','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(108,'2026-04-02 16:03:07','stockAdjustment','93','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(109,'2026-04-02 16:03:23','stockAdjustment','94','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(110,'2026-04-02 16:03:37','stockAdjustment','95','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(111,'2026-04-02 16:03:53','stockAdjustment','96','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(112,'2026-04-02 16:04:34','stockAdjustment','97','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(113,'2026-04-02 16:04:59','stockAdjustment','98','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(114,'2026-04-02 16:05:53','stockAdjustment','99','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(115,'2026-04-02 16:06:15','stockAdjustment','100','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(116,'2026-04-02 16:06:54','stockAdjustment','101','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(117,'2026-04-02 16:07:34','stockAdjustment','102','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(118,'2026-04-02 16:07:51','stockAdjustment','103','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(119,'2026-04-02 16:08:14','stockAdjustment','104','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(120,'2026-04-02 16:16:03','stockAdjustment','105','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(121,'2026-04-02 16:28:05','stockAdjustment','106','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(122,'2026-04-02 16:28:35','stockAdjustment','107','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(123,'2026-04-02 16:30:40','stockAdjustment','108','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(124,'2026-04-02 16:31:18','stockAdjustment','109','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(125,'2026-04-02 16:33:46','stockAdjustment','110','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(126,'2026-04-02 16:34:15','stockAdjustment','111','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(127,'2026-04-02 16:34:40','stockAdjustment','112','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(128,'2026-04-02 16:34:52','stockAdjustment','113','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(129,'2026-04-02 16:35:27','stockAdjustment','114','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(130,'2026-04-02 16:38:51','stockAdjustment','115','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(131,'2026-04-02 16:40:53','stockAdjustment','116','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(132,'2026-04-02 16:42:08','stockAdjustment','117','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(133,'2026-04-02 16:42:22','stockAdjustment','118','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(134,'2026-04-02 16:42:41','stockAdjustment','119','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(135,'2026-04-02 16:44:44','stockAdjustment','120','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(136,'2026-04-02 16:48:32','stockAdjustment','121','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(137,'2026-04-02 16:50:29','stockAdjustment','122','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(138,'2026-04-02 16:51:39','stockAdjustment','123','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(139,'2026-04-02 16:53:06','stockAdjustment','124','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(140,'2026-04-02 16:53:32','stockAdjustment','125','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(141,'2026-04-02 16:55:28','stockAdjustment','126','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(142,'2026-04-02 16:55:50','stockAdjustment','127','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(143,'2026-04-02 16:56:19','stockAdjustment','128','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(144,'2026-04-02 17:08:16','stockAdjustment','129','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(145,'2026-04-02 17:08:34','stockAdjustment','130','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(146,'2026-04-02 17:09:03','stockAdjustment','131','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(147,'2026-04-02 17:09:19','stockAdjustment','132','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(148,'2026-04-02 17:10:25','stockAdjustment','133','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(149,'2026-04-02 17:10:45','stockAdjustment','134','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(150,'2026-04-02 17:11:01','stockAdjustment','135','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(152,'2026-04-02 17:11:36','stockAdjustment','137','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(153,'2026-04-02 17:11:55','stockAdjustment','138','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(154,'2026-04-02 17:12:21','stockAdjustment','139','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(155,'2026-04-02 17:13:11','stockAdjustment','140','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(156,'2026-04-02 17:13:33','stockAdjustment','141','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(157,'2026-04-02 17:13:55','stockAdjustment','142','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(158,'2026-04-02 17:14:23','stockAdjustment','143','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(159,'2026-04-02 17:18:04','stockAdjustment','144','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(160,'2026-04-02 17:18:24','stockAdjustment','145','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(161,'2026-04-02 17:19:28','stockAdjustment','146','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(162,'2026-04-02 17:19:44','stockAdjustment','147','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(163,'2026-04-02 17:21:01','stockAdjustment','148','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(164,'2026-04-02 17:49:03','stockAdjustment','149','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(165,'2026-04-02 17:49:32','stockAdjustment','150','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(166,'2026-04-02 17:50:02','stockAdjustment','151','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(167,'2026-04-02 17:50:17','stockAdjustment','152','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(168,'2026-04-02 17:50:57','stockAdjustment','153','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(169,'2026-04-02 17:51:20','stockAdjustment','154','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(170,'2026-04-02 17:51:36','stockAdjustment','155','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(171,'2026-04-02 17:51:57','stockAdjustment','156','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(172,'2026-04-02 17:52:26','stockAdjustment','157','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(173,'2026-04-02 17:52:41','stockAdjustment','158','د تیر کال د حسابونو څخه را نقل سول',2,NULL,1),(174,'2026-04-03 09:53:45','balanceAdjustment','3','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(175,'2026-04-03 09:54:15','balanceAdjustment','4','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(176,'2026-04-03 09:54:39','balanceAdjustment','5','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(177,'2026-04-03 09:55:41','balanceAdjustment','6','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(178,'2026-04-03 09:55:57','balanceAdjustment','7','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(179,'2026-04-03 10:01:57','balanceAdjustment','8','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(180,'2026-04-03 10:02:10','balanceAdjustment','9','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(181,'2026-04-03 10:02:32','balanceAdjustment','10','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(182,'2026-04-03 10:03:37','balanceAdjustment','11','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(183,'2026-04-03 10:03:58','balanceAdjustment','12','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(184,'2026-04-03 10:04:25','balanceAdjustment','13','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(185,'2026-04-03 10:05:07','balanceAdjustment','14','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(186,'2026-04-03 10:05:56','balanceAdjustment','15','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(187,'2026-04-03 10:06:14','balanceAdjustment','16','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(188,'2026-04-03 10:06:38','balanceAdjustment','17','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(189,'2026-04-03 10:06:50','balanceAdjustment','18','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(190,'2026-04-03 10:07:06','balanceAdjustment','19','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(191,'2026-04-03 10:07:35','balanceAdjustment','20','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(192,'2026-04-03 10:07:54','balanceAdjustment','21','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(193,'2026-04-03 10:08:09','balanceAdjustment','22','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(194,'2026-04-03 19:43:52','balanceAdjustment','23','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(195,'2026-04-03 19:57:55','balanceAdjustment','24','د تیر کال د حسابونو څخه را نقل سوې',2,NULL,1),(196,'2026-04-03 20:21:35','stockPurchase','3','د چین څخه راتلونکی شیان',2,NULL,1),(197,'2026-04-03 20:23:15','stockPurchaseCost','1','د چین مصرف، د اجناسو د رانیولو کمیشن',2,196,1),(200,'2026-04-03 22:46:44','balanceAdjustment','27','د چین د شیانو پیسی چی ما په رانیولی وه، په دخل کی ونیول سول\nیعنی لومړی می همدومره اندازه پیسی دخل ته اضافه کړې، بیرته می په هغه اندازه په تمه بیل کی شیان رانیول (تمه بیل + مصرف یې )',2,NULL,1),(213,'2026-04-03 00:01:40','balanceAdjustment','31','د 1404 کال ټول مصرف پسی ولیکل سو',2,NULL,1),(214,'2026-04-03 00:02:05','balanceAdjustment','32','د 1404 کال ټول مصرف پسی ولیکل سو',2,NULL,1),(219,'2026-04-04 12:02:22','cashReceipt','3','د 1403کال او 1404 کال ګټه ورکړل شوه\n1403 ---- 81460 افغانی\n1404 ---- 115372',2,NULL,1),(220,'2026-04-04 12:02:42','cashReceipt','4','د 1403کال او 1404 کال ګټه ورکړل شوه\n1403 ---- 81460 افغانی\n1404 ---- 115372',2,NULL,1),(221,'2026-04-04 12:04:19','cashTransfer','3',NULL,2,NULL,1),(223,'2026-04-04 12:11:51','cashExchange','3',NULL,2,NULL,1),(226,'2026-04-04 15:39:50','cashTransfer','4',NULL,2,NULL,1),(227,'2026-04-04 15:52:37','expense','7',NULL,2,NULL,1),(236,'2026-03-29 00:00:00','stockSale','3',NULL,2,NULL,1),(237,'2026-03-29 00:00:00','stockSale','4','',2,NULL,1),(238,'2026-03-29 00:00:00','stockSale','5',NULL,2,NULL,1),(239,'2026-03-29 00:00:00','stockSale','6',NULL,2,NULL,1),(240,'2026-03-29 00:00:00','stockSale','7',NULL,2,NULL,1),(241,'2026-03-29 00:00:00','stockSale','8',NULL,2,NULL,1),(242,'2026-03-30 06:46:02','stockSale','9',NULL,2,NULL,1),(243,'2026-03-30 00:00:00','stockSale','10','Bill - 1041',2,NULL,1),(244,'2026-03-30 06:54:42','stockSale','11',NULL,2,NULL,1),(245,'2026-04-05 10:42:54','stockPurchase','4','Bill No - 91 - Whatsapp',2,NULL,1),(246,'2026-04-05 10:43:51','stockPurchase','5',NULL,2,NULL,1),(247,'2026-04-05 10:46:16','stockPurchase','6',NULL,2,NULL,1),(248,'2026-04-05 10:48:41','stockPurchase','7',NULL,2,NULL,1),(249,'2026-04-05 10:54:33','stockPurchase','8',NULL,2,NULL,1),(250,'2026-04-05 10:57:12','stockPurchase','9','Bill No - 9594 - Whatsapp',2,NULL,1),(251,'2026-04-05 11:09:51','stockPurchase','10','Bill No - 3740',2,NULL,1),(253,'2026-04-05 11:19:36','stockPurchase','11','Bill No - 0007822',2,NULL,1),(254,'2026-04-05 11:19:36','stockPurchaseBillCost','11',NULL,2,253,1),(255,'2026-04-05 11:22:15','stockPurchase','12',NULL,2,NULL,1),(256,'2026-04-05 11:23:33','stockPurchase','13','نقدی ورکول سوې',2,NULL,1),(257,'2026-03-31 11:31:41','stockSale','12','Bill - 1038 - Halimi House',2,NULL,1),(258,'2026-03-31 11:32:56','stockSale','13',NULL,2,NULL,1),(259,'2026-04-02 00:00:00','stockSale','14',NULL,2,NULL,1),(260,'2026-04-02 00:00:00','stockSale','15',NULL,2,NULL,1),(261,'2026-04-02 16:23:05','stockSale','16','د مکملی هفتې چکنه حساب ورسول سو',2,NULL,1),(262,'2026-04-02 16:35:21','stockSale','17','اغا شرکت - دوکان',2,NULL,1),(263,'2026-04-04 16:37:22','stockSale','18',NULL,2,NULL,1),(264,'2026-04-04 16:43:29','stockSale','19',NULL,2,NULL,1),(265,'2026-04-04 16:45:53','stockSale','20','بیل نمبر - 1049',2,NULL,1),(266,'2026-04-04 16:57:22','stockSale','21',NULL,2,NULL,1),(267,'2026-03-30 16:59:39','cashPayment','3','نغدی د اختر په شپه ورکول سوې تلویزونانو والا ته',2,NULL,1),(268,'2026-03-31 17:00:34','cashPayment','4','نقدی ورکول سوې',2,NULL,1),(269,'2026-03-31 00:00:00','cashPayment','5','نقدی ورکول سوې',2,NULL,1),(270,'2026-03-31 17:01:46','cashPayment','6','نقدی ورکول سوې',2,NULL,1),(271,'2026-03-31 17:02:49','cashPayment','7','نقدی ورکول سوې',2,NULL,1),(272,'2026-03-31 17:03:50','cashPayment','8','نقدی ورکول سوې',2,NULL,1),(273,'2026-03-28 17:11:56','cashPayment','9','د چکنه مصارفاتو لپاره',2,NULL,1),(274,'2026-04-05 17:12:18','cashPayment','10','د دوکان کرایه ورکول سول',2,NULL,1),(275,'2026-04-05 17:13:04','cashPayment','11','د انټرنيټ فیس',2,NULL,1),(276,'2026-03-31 17:14:32','cashPayment','12','د کوچنی اختر مصرف',2,NULL,1),(277,'2026-03-31 17:15:08','cashPayment','13','د کوچنی اختر مصرف',2,NULL,1),(278,'2026-03-26 17:15:44','cashPayment','14','د جیب خرڅ لپاره',2,NULL,1),(279,'2026-03-26 17:16:10','cashPayment','15','د جیب خرڅ لپاره',2,NULL,1),(280,'2026-03-21 17:17:11','cashPayment','16','د میاشتنی خرڅ لپاره',2,NULL,1),(281,'2026-04-01 17:18:04','cashPayment','17','د 1404 او 1405 کال مالیه',2,NULL,1),(282,'2026-04-02 17:18:29','cashPayment','18','د جیب خرڅ لپاره',2,NULL,1),(283,'2026-04-02 17:19:38','cashPayment','19','د جیب خرڅ او کور ته د دوا لپاره',2,NULL,1),(284,'2026-04-02 17:20:09','cashPayment','20','نصیب الله ته د کالو لپاره',2,NULL,1),(285,'2026-04-02 17:20:38','cashPayment','21','د دوکان د شاګرد هفته ګی',2,NULL,1),(286,'2026-04-05 17:22:08','cashPayment','22','د 1405 کال صفایی ورکول سول',2,NULL,1),(287,'2026-03-31 17:23:02','cashReceipt','5','نقدی په اختر کی تر لاسه سوې',2,NULL,1),(288,'2026-03-31 17:24:29','cashPayment','23','نقدی ورکول سوې په اختر کی',2,NULL,1),(289,'2026-04-04 17:26:17','cashReceipt','6','نقدی ورسیدی',2,NULL,1),(290,'2026-03-30 12:36:08','stockPurchase','14','Bill No - 3275',2,NULL,1),(291,'2026-03-30 12:36:08','stockPurchaseBillCost','14',NULL,2,290,1),(292,'2026-04-06 12:40:22','stockSale','22','Bill - 1046',2,NULL,1),(293,'2026-04-06 12:46:12','stockSale','23','Bill No - 1014',2,NULL,1),(296,'2026-04-06 15:28:38','cashExchange','5','500 ډالر نور رانیول سول د دوکان لپاره',2,NULL,1),(298,'2026-04-06 15:54:13','stockSale','24',NULL,2,NULL,1),(300,'2026-04-06 16:19:21','cashPayment','25','نقدی صرافی ته جمعه سوې',2,NULL,1),(301,'2026-04-06 16:20:37','cashExchange','7','ډالر رانیول سو',2,NULL,1),(302,'2026-04-06 16:21:40','cashTransfer','8','600 ډالر د دوکان دخل ته راوړل سوې',2,NULL,1),(303,'2026-04-06 16:33:30','stockSale','25','Bill No - 1040',2,NULL,1),(304,'2026-04-07 10:21:33','stockSale','26',NULL,2,NULL,1),(305,'2026-04-07 19:08:07','stockSale','27',NULL,2,NULL,1),(306,'2026-04-07 19:09:58','stockSale','28','پلازما یې خوشحال ته ورکړل',2,NULL,1),(307,'2026-04-08 10:13:15','stockSale','29',NULL,2,NULL,1),(308,'2026-04-08 12:18:06','stockSale','30',NULL,2,NULL,1),(310,'2026-04-06 11:16:01','stockPurchase','15','Bill No - 3429',2,NULL,1),(311,'2026-04-06 11:16:01','stockPurchaseBillCost','15',NULL,2,310,1),(312,'2026-04-05 11:09:51','stockPurchaseBillCost','10',NULL,2,251,1),(313,'2026-04-09 13:37:10','stockSale','32','Bill - 1042',2,NULL,1),(314,'2026-04-09 13:38:27','stockSale','33',NULL,2,NULL,1),(315,'2026-04-09 13:39:06','cashReceipt','7','نقدی یې دوکان ته راوړی',2,NULL,1),(316,'2026-04-09 14:13:17','cashPayment','26','د کور د خرڅ لپاره',2,NULL,1),(317,'2026-04-09 14:52:50','cashPayment','27','د دوکان شاګرد نصیب الله ته هفته ګی او د میلی لپاره',2,NULL,1),(318,'2026-04-09 14:53:03','cashPayment','28','د جیب خرڅ لپاره',2,NULL,1),(319,'2026-04-09 14:53:21','cashPayment','29','د جیب خرڅ لپاره',2,NULL,1),(320,'2026-04-09 14:53:39','cashPayment','30','د نانی د دوا لپاره',2,NULL,1),(321,'2026-04-09 14:55:37','stockSale','34','‌Bill No - 1055',2,NULL,1),(322,'2026-04-09 14:56:08','cashPayment','31','نقدی ورکول سوې',2,NULL,1),(323,'2026-04-09 15:17:28','stockPurchase','16',NULL,2,NULL,1),(324,'2026-04-09 15:18:25','stockPurchase','17',NULL,2,NULL,1),(325,'2026-04-09 15:19:55','stockPurchase','18',NULL,2,NULL,1),(326,'2026-04-09 15:27:48','stockSale','35',NULL,2,NULL,1),(327,'2026-04-09 15:51:58','cashPayment','32','نقدی ورکول سوې',2,NULL,1),(328,'2026-04-09 15:52:13','cashPayment','33','نقدی ورکول سوې',2,NULL,1),(329,'2026-04-09 16:31:27','cashPayment','34','حواله نمبر - 852',2,NULL,1),(330,'2026-04-09 16:33:04','cashPayment','35','حواله نمبر - 851',2,NULL,1),(331,'2026-04-09 16:33:24','cashPayment','36','نقدی ورکول سوې',2,NULL,1),(332,'2026-04-09 16:37:27','stockPurchase','19',NULL,2,NULL,1),(333,'2026-04-09 16:53:32','stockAdjustment','159','د تیر کال د حسابونو څخه را نقل سو',2,NULL,1),(334,'2026-04-09 16:55:10','stockSale','36','د کارټن کارخانه',2,NULL,1),(335,'2026-04-09 16:58:02','stockSale','37',NULL,2,NULL,1),(336,'2026-04-09 17:02:35','stockSale','38','د مکملی هفتې حساب ورسول سو',2,NULL,1),(337,'2026-04-09 17:08:07','stockPurchase','20',NULL,2,NULL,1),(338,'2026-04-09 17:08:42','stockPurchase','21',NULL,2,NULL,1),(339,'2026-04-09 17:19:40','stockSale','39','سرای سیدک',2,NULL,1),(340,'2026-04-09 17:47:00','stockSale','40','bill No - 1053 - مسعود، نظرجان سرای',2,NULL,1),(341,'2026-04-09 17:57:18','cashPayment','37','نقدی ورکول سوې',2,NULL,1),(342,'2026-04-09 17:58:11','stockPurchase','22',NULL,2,NULL,1),(343,'2026-04-09 18:30:30','stockSale','41',NULL,2,NULL,1),(344,'2026-04-09 18:38:08','stockSale','42',NULL,2,NULL,1),(345,'2026-04-09 18:38:08','stockSaleBillCost','42',NULL,2,344,1),(346,'2026-04-07 10:21:33','stockSaleBillCost','26',NULL,2,304,1),(347,'2026-04-11 10:44:25','cashReceipt','8','نقدی راوړل سوې',2,NULL,1),(348,'2026-04-11 12:07:37','cashPayment','38','نقدی د صرافی له لاری ورکول سوې',2,NULL,1),(349,'2026-04-11 12:07:53','cashPayment','39','نقدی ورکول سوې',2,NULL,1),(350,'2026-04-11 13:35:03','cashPayment','40','نقدی د سودا لپاره',2,NULL,1),(351,'2026-04-11 18:32:08','revenue','3','د وایفای کامرې کنکټ کول',2,NULL,1),(352,'2026-04-11 18:36:18','stockSale','43',NULL,2,NULL,1),(353,'2026-04-11 18:37:35','stockSale','44',NULL,2,NULL,1),(354,'2026-04-11 18:38:10','revenue','4','د انټرنیټ د لین جوړېدل',2,NULL,1),(355,'2026-04-12 19:24:55','cashReceipt','9','نقدی د سید علی څخه واخیستل سوې، ځکه چی پیسی یې د دواړو بیلانو دا سید علی چای والا - بولدک والا ته ورکړی وې',2,NULL,1),(356,'2026-04-12 19:28:26','cashPayment','41','د ویش څخه لینونه او چارجر ورته راوړل سو',2,NULL,1),(357,'2026-04-12 19:44:12','stockPurchase','23',NULL,2,NULL,1),(359,'2026-04-12 19:44:12','stockPurchaseBillCost','23',NULL,2,357,1),(360,'2026-04-13 14:58:21','stockSale','45',NULL,2,NULL,1),(361,'2026-04-13 19:48:45','cashReceipt','10','نقدی ورسیدی',2,NULL,1),(362,'2026-04-14 11:43:28','stockSale','46','بیل نمبر - 1058',2,NULL,1),(363,'2026-04-14 12:23:54','cashPayment','42','ګاز، د غنم اوړه کیدل، د کالو شامپو، د برق ګروپان او ولډران او سودا لپاره',2,NULL,1),(364,'2026-04-14 13:32:23','stockSale','47','غمی جان - احمد علی اخندزاده سرای',2,NULL,1),(365,'2026-04-14 13:33:14','stockPurchase','24','غمی جان - احمد علی اخندزاده سرای',2,NULL,1),(367,'2026-04-14 16:11:55','stockSale','49',NULL,2,NULL,1),(368,'2026-04-15 12:42:04','stockSale','50',NULL,2,NULL,1),(369,'2026-04-15 12:45:16','stockSale','51','1060 bill',2,NULL,1),(370,'2026-04-15 18:35:52','stockPurchase','25',NULL,2,NULL,1),(371,'2026-04-15 19:05:58','stockSale','52',NULL,2,NULL,1),(372,'2026-04-16 11:45:34','cashPayment','43','نقدی ورکول سوې',2,NULL,1),(373,'2026-04-16 11:58:55','cashPayment','44','نقدی ورکول سوې',2,NULL,1),(374,'2026-04-16 12:42:36','stockSale','53','د حضرت جی بابا ګیراک',2,NULL,1),(375,'2026-04-16 12:46:35','stockSale','54',NULL,2,NULL,1),(376,'2026-04-16 13:48:47','stockPurchase','26',NULL,2,NULL,1),(377,'2026-04-16 14:39:12','stockSale','55','معلم صاحب پمپ',2,NULL,1),(378,'2026-04-16 15:57:44','stockSale','56','عمر صابر',2,NULL,1),(379,'2026-04-16 15:59:29','stockSale','57',NULL,2,NULL,1),(380,'2026-04-16 16:04:42','stockSale','58',NULL,2,NULL,1),(381,'2026-04-16 16:04:42','stockSaleCashReceipt','58',NULL,2,380,1),(382,'2026-04-16 16:21:21','stockSale','59','د ټولی هفتې حساب ورسول سو',2,NULL,1),(383,'2026-04-16 16:26:29','stockSale','60','‌Bill No - 1063',2,NULL,1),(384,'2026-04-16 16:27:13','stockPurchase','27',NULL,2,NULL,1),(385,'2026-04-16 16:29:07','stockPurchase','28',NULL,2,NULL,1),(386,'2026-04-16 17:04:43','cashPayment','45','نقدی ورکول سوې',2,NULL,1),(387,'2026-04-16 17:06:43','cashExchange','8','نقدی و ډالرو ته واړول سوې',2,NULL,1),(388,'2026-04-16 17:07:13','cashTransfer','9','نقدی په صرافی کی جمعه سوې',2,NULL,1),(389,'2026-04-16 18:11:46','stockSale','61',NULL,2,NULL,1),(390,'2026-04-16 19:05:44','stockSale','62',NULL,2,NULL,1),(391,'2026-04-16 19:32:41','cashPayment','46','د دوکان د شاګرد هفته ګی',2,NULL,1),(392,'2026-04-16 19:32:57','cashPayment','47','د جیب خرڅ لپاره',2,NULL,1),(393,'2026-04-16 19:33:20','cashPayment','48','د جیب خرڅ لپاره',2,NULL,1),(394,'2026-04-19 10:59:34','stockPurchase','29',NULL,2,NULL,1),(396,'2026-04-19 11:13:11','stockPurchase','30','د حضرت شاه د ملګری څخه رانیول سول',2,NULL,1),(397,'2026-04-19 11:44:25','cashPayment','49','نقدی ورکول سوې',2,NULL,1),(398,'2026-04-19 11:51:14','cashPayment','50','نقدی د جواز لپاره ورکول سوې',2,NULL,1),(399,'2026-04-19 13:32:48','stockSale','64','Bill No - 1051',2,NULL,1),(400,'2026-04-19 14:07:58','stockSale','65','Bill No - 1050',2,NULL,1),(401,'2026-04-19 18:37:05','stockSale','66','بیل نمبر - 1056 - حقپال کور',2,NULL,1),(402,'2026-04-19 19:25:29','stockSale','67','ټوله حساب کمپیوټر ته را نقل شو - د عزت عادل کمپیوټر حساب',2,NULL,1),(403,'2026-04-19 19:26:07','balanceAdjustment','37','د تیر کال څخه حساب را نقل شو',2,NULL,1),(404,'2026-04-20 12:38:58','stockSale','68',NULL,2,NULL,1),(405,'2026-04-20 12:39:35','stockSale','69',NULL,2,NULL,1),(406,'2026-04-20 12:42:04','stockSale','70',NULL,2,NULL,1),(407,'2026-04-20 12:43:18','stockSale','71','د تیر کال د حساب څخه پر پاته دی',2,NULL,1),(408,'2026-04-20 12:43:57','balanceAdjustment','38','د تیر کال د حساب څخه پر پاته دی ',2,NULL,1),(410,'2026-04-21 11:26:04','cashReceipt','11','نغدی ورسیدلی',2,NULL,1),(411,'2026-04-21 11:27:11','cashPayment','51','د دوکان کرایه ورکول سوه',2,NULL,1),(412,'2026-04-21 12:13:42','cashReceipt','12','حواله نمبر - 4526',2,NULL,1),(413,'2026-04-21 12:44:46','stockSale','73','بیل نمبر - 1062 - عبیدی صاحب محترم',2,NULL,1),(414,'2026-04-21 17:33:21','cashPayment','52','نقدی ورکول سوې',2,NULL,1),(415,'2026-04-21 17:35:02','stockSale','74','فیضانی ته ورکول سوې',2,NULL,1),(416,'2026-04-21 17:36:40','stockSale','75',NULL,2,NULL,1),(417,'2026-04-21 17:36:57','stockSale','76',NULL,2,NULL,1),(418,'2026-04-21 18:36:06','stockPurchase','31',NULL,2,NULL,1),(419,'2026-04-21 18:40:23','stockPurchase','32',NULL,2,NULL,1),(420,'2026-04-21 18:40:56','stockPurchase','33',NULL,2,NULL,1),(421,'2026-04-22 10:11:52','stockPurchase','34','د حضرت شاه څخه رانیول سول',2,NULL,1),(422,'2026-04-22 10:13:25','stockPurchase','35',NULL,2,NULL,1),(423,'2026-04-22 10:21:56','stockSale','77','سوپر کولا - 1071 بیل نمبر',2,NULL,1),(424,'2026-04-22 10:30:37','stockPurchase','36',NULL,2,NULL,1),(425,'2026-04-22 12:30:50','stockPurchase','37',NULL,2,NULL,1),(426,'2026-04-22 12:43:59','stockSale','78','نظر جان سرای',2,NULL,1),(427,'2026-04-22 15:18:32','stockSale','79','منظور افغان شرکت',2,NULL,1),(428,'2026-04-22 19:34:41','cashPayment','53','نقدی مطیع الله ته د میاشتنی خرڅ لپاره ورکول سوې',2,NULL,1),(429,'2026-04-22 19:34:58','cashPayment','54','د خرڅ لپاره واخیستل سوې',2,NULL,1),(430,'2026-04-23 10:40:19','stockSale','80',NULL,2,NULL,1),(431,'2026-04-23 14:52:32','stockSale','81',NULL,2,NULL,1),(432,'2026-04-23 15:00:49','stockSale','82',NULL,2,NULL,1),(433,'2026-04-23 15:10:04','stockPurchase','38',NULL,2,NULL,1),(434,'2026-04-23 15:14:36','stockSale','83','د تیری هفتې مکملی حساب ورکول سو',2,NULL,1),(435,'2026-04-23 16:25:47','cashTransfer','10','نغدی په صرافی کی جمعه سوې',2,NULL,1),(436,'2026-04-23 16:27:03','cashPayment','55','الاحسان کمپیوټر - کابل ته حواله سوې\nحواله نمبر - 937',2,NULL,1),(437,'2026-04-23 16:28:18','expense','9','حواله نمبر - 937 - کمیشن',2,NULL,1),(438,'2026-04-23 16:53:20','cashPayment','56','نجار ته ورکول سوې',2,NULL,1),(439,'2026-04-23 16:54:09','cashPayment','57','د جیب خرڅ لپاره',2,NULL,1),(440,'2026-04-23 16:54:32','cashPayment','58','د دوکان د شاګرد هفته ګی',2,NULL,1),(441,'2026-04-23 16:54:51','cashPayment','59','د دوا لپاره',2,NULL,1),(442,'2026-04-23 16:58:55','stockSale','84',NULL,2,NULL,1),(443,'2026-04-23 17:25:22','cashReceipt','13','نقدی ورسیدی',2,NULL,1),(444,'2026-04-23 17:29:37','stockSale','85',NULL,2,NULL,1),(445,'2026-04-23 17:37:16','cashPayment','60','نقدی ورکول سوی فیصل ته',2,NULL,1),(446,'2026-04-23 18:02:02','stockPurchaseReturn','39',NULL,2,NULL,1),(447,'2026-04-23 18:03:33','cashPayment','61','نقدی ورکول سوې',2,NULL,1),(448,'2026-04-23 18:04:58','cashPayment','62','د جیب خرڅ لپاره',2,NULL,1),(449,'2026-04-23 18:12:42','cashPayment','63','د میاشتنی خرڅ لپاره',2,NULL,1),(450,'2026-04-23 18:23:17','stockSale','86','حنظله ته ورکول سول',2,NULL,1),(451,'2026-04-23 19:13:42','stockPurchase','40',NULL,2,NULL,1),(452,'2026-04-25 17:09:19','cashPayment','64','نقدی ورکول سوې',2,NULL,1),(453,'2026-04-25 18:22:49','balanceAdjustment','39','د پلازما د جوړولو حساب',2,NULL,1),(454,'2026-04-25 18:23:14','stockPurchase','41',NULL,2,NULL,1),(455,'2026-04-25 18:23:56','stockSale','87','2 tb هارډیسک',2,NULL,1),(456,'2026-04-26 10:38:36','cashReceipt','14','نقدی ورسیدی',2,NULL,1),(457,'2026-04-26 10:53:59','stockSale','88',NULL,2,NULL,1),(458,'2026-04-26 11:08:13','stockPurchase','42','د بابی نوی سړک والا څخه رانیول سول',2,NULL,1),(459,'2026-04-26 11:15:47','balanceAdjustment','40','ترمیم کامره ها، ترمیم دستګاه - بیل نمبر - 3740',2,NULL,1),(460,'2026-04-25 11:55:26','cashTransfer','11','د دوکان دخل ته راوړل سوې',2,NULL,1),(461,'2026-04-26 17:31:28','stockSale','89',NULL,2,NULL,1),(462,'2026-04-26 18:39:56','stockSale','90',NULL,2,NULL,1),(463,'2026-04-27 09:23:37','stockSale','91',NULL,2,NULL,1),(464,'2026-04-27 17:36:38','stockPurchase','43',NULL,2,NULL,1),(465,'2026-04-27 17:39:55','stockSale','92',NULL,2,NULL,1),(466,'2026-04-27 18:16:54','stockPurchase','44','Al Ehsan Computer - Bill No - 3815',2,NULL,1),(468,'2026-04-27 18:16:54','stockPurchaseBillCost','44',NULL,2,466,1),(469,'2026-04-27 18:21:31','stockPurchase','45','حیدری - بیل نمبر - 000204',2,NULL,1),(470,'2026-04-27 18:21:31','stockPurchaseBillCost','45',NULL,2,469,1),(471,'2026-04-27 18:22:47','stockPurchase','46','اسلام شینواری - بیل نمبر - 558',2,NULL,1),(472,'2026-04-27 18:22:47','stockPurchaseBillCost','46',NULL,2,471,1),(473,'2026-04-27 18:28:45','stockPurchase','47','بلال ټکنالوژي - بیل نمبر - 273',2,NULL,1),(474,'2026-04-27 18:28:45','stockPurchaseBillCost','47',NULL,2,473,1),(475,'2026-04-27 18:30:25','stockPurchaseReturn','48','واپس کامره',2,NULL,1),(476,'2026-04-27 19:41:00','stockPurchase','49','ملی ټکنالوژي - 10 دانې outdoor 5mp کامرې',2,NULL,1),(477,'2026-04-28 12:49:38','stockSale','93',NULL,2,NULL,1),(478,'2026-04-28 18:28:10','cashPayment','65','750 - غټه چوکۍ\n680 - د کوچنیانو دوا\n100\n450\n1000 پشه خانی\n250 - د اناناس جوس\n1500 - د کلکینانو جالی\n310  - د مور دوا',2,NULL,1),(479,'2026-04-29 19:21:00','stockSale','94','',2,NULL,1),(480,'2026-04-29 20:11:26','cashPayment','66','نقدی ورکول سوې',2,NULL,1),(481,'2026-04-29 20:12:42','stockSale','95','ذبیر احمد د ګل احمد ورور ته ورکول سو د فیصل احمد په قول',2,NULL,1),(482,'2026-04-29 20:14:48','cashReceipt','15','نقدی ورسول سوې',2,NULL,1),(483,'2026-04-29 20:39:06','stockSale','96',NULL,2,NULL,1),(484,'2026-04-30 11:25:12','stockPurchase','50',NULL,2,NULL,1),(485,'2026-04-30 11:30:25','stockSale','97','Bill - 1077',2,NULL,1),(486,'2026-04-30 12:16:42','cashPayment','67','د انټرنیټ فیس ورکول سو',2,NULL,1),(488,'2026-04-30 16:55:52','cashReceipt','17','نقدی ورسیدی',2,NULL,1),(489,'2026-04-30 17:16:54','cashReceipt','18','رسیده ګی توسط مطیع الله',2,NULL,1),(490,'2026-04-30 17:33:00','cashReceipt','19','نقدی ورسیدی',2,NULL,1),(491,'2026-04-30 20:10:51','stockSale','98',NULL,2,NULL,1),(492,'2026-04-30 20:16:50','stockPurchase','51',NULL,2,NULL,1),(493,'2026-04-30 20:17:32','stockSale','99','د ټولی هفتې حساب ولیکل سو',2,NULL,1),(494,'2026-04-30 20:18:07','cashPayment','68','نقدی ورکول سوې',2,NULL,1),(495,'2026-04-30 20:21:45','stockPurchase','52',NULL,2,NULL,1),(497,'2026-04-30 20:22:16','cashPayment','69','د جیب خرڅ لپاره',2,NULL,1),(498,'2026-04-30 20:22:35','cashPayment','70','د جیب خرڅ لپاره',2,NULL,1),(499,'2026-04-30 20:23:28','cashPayment','71','د دوکان د شاګرد هفته ګی',2,NULL,1),(500,'2026-05-02 10:24:23','stockPurchase','53',NULL,2,NULL,1),(501,'2026-05-02 10:27:44','stockSale','100',NULL,2,NULL,1),(502,'2026-05-02 15:37:43','stockSale','101',NULL,2,NULL,1),(503,'2026-05-02 15:52:21','stockSale','102','د رنګو شرکت بیل - 1065',2,NULL,1),(504,'2026-05-02 15:58:33','cashReceipt','20','نقدی ورسول سوې - د رنګو شرکت د بیل د کمیشن څخه',2,NULL,1),(505,'2026-05-02 16:06:20','cashReceipt','21','د رنګو شرکت په حساب کی ورسول سوې',2,NULL,1),(506,'2026-05-02 16:25:01','cashPayment','72','نقدی مطیع الله ته د میاشتنی خرڅ لپاره ورکول سوې',2,NULL,1),(507,'2026-05-02 16:31:26','stockPurchase','54',NULL,2,NULL,1),(508,'2026-05-02 16:31:26','stockPurchaseBillCost','54',NULL,2,507,1),(509,'2026-05-02 16:32:14','cashPayment','73','د کور لپاره د حمام شامپو رانیول سول په ویش کی',2,NULL,1),(510,'2026-05-02 17:33:28','cashPayment','74','نصیب الله ته د Bad او Pad لپاره ورکول سوې',2,NULL,1),(511,'2026-05-02 18:04:10','cashPayment','75','دموټرسیکل دچوړیدو لپاره',2,NULL,1),(512,'2026-05-02 18:55:25','cashPayment','76','نقدی ګل احمد ته ورکول سوې',2,NULL,1),(514,'2026-05-03 13:35:35','stockSale','104',NULL,2,NULL,1),(515,'2026-05-03 17:30:52','cashPayment','77','حواله نمبر - 4213',2,NULL,1),(517,'2026-04-30 20:21:45','stockPurchaseBillCost','52',NULL,2,495,1),(518,'2026-05-03 17:32:57','expense','10','بولدک ته حواله - کمیشن - حواله نمبر 4213',2,NULL,1),(519,'2026-05-03 20:15:03','cashPayment','78','د میز د سر الماری، ایګزاز او د کاریګر مزدوری',2,NULL,1),(520,'2026-05-04 14:09:00','stockSale','105',NULL,2,NULL,1),(521,'2026-05-04 17:22:15','cashPayment','79','دکور دګیس دپاره',2,NULL,1),(522,'2026-05-04 18:41:43','stockSale','106',NULL,2,NULL,1),(523,'2026-05-04 19:27:16','cashPayment','80','نقدي دحضرت و مور ته ورکول سوی',2,NULL,1),(524,'2026-05-04 19:30:13','cashPayment','81','دغاښو دپاره',2,NULL,1),(525,'2026-05-04 19:52:07','stockSale','107',NULL,2,NULL,1),(526,'2026-05-05 10:44:42','cashReceipt','22','نقدی ورسول سوې',2,NULL,1),(527,'2026-05-05 11:26:29','stockSale','108',NULL,2,NULL,1),(529,'2026-05-05 11:27:24','cashReceipt','23','رسیده ګی توسط جانان',2,NULL,1),(530,'2026-05-05 16:11:44','stockSale','109',NULL,2,NULL,1),(531,'2026-05-05 11:26:29','stockSaleCashReceipt','108',NULL,2,527,1),(532,'2026-05-05 16:20:57','stockSale','110',NULL,2,NULL,1),(533,'2026-05-05 16:37:04','stockPurchase','55',NULL,2,NULL,1),(534,'2026-05-05 16:41:13','stockPurchase','56',NULL,2,NULL,1),(535,'2026-05-06 11:09:36','stockPurchase','57','bill 3616',2,NULL,1),(536,'2026-05-06 11:09:36','stockPurchaseBillCost','57',NULL,2,535,1),(537,'2026-05-06 15:47:33','stockPurchase','58',NULL,2,NULL,1),(538,'2026-05-06 15:52:07','stockSale','111','Bill - 1082',2,NULL,1),(539,'2026-05-06 16:56:32','stockPurchase','59',NULL,2,NULL,1),(540,'2026-05-06 18:11:40','stockSale','112',NULL,2,NULL,1),(544,'2026-05-07 10:21:03','stockSale','113',NULL,2,NULL,1),(547,'2026-05-07 10:54:05','expense','11','نور احمد ته د صرافی مارکیټ د کار مزدوری ورکول سوه',2,NULL,1),(550,'2026-05-06 15:56:53','cashPayment','83','نقدی فیصل خان ته ورکول سوې',2,NULL,1),(551,'2026-05-07 16:21:45','stockSaleReturn','114',NULL,2,NULL,1),(552,'2026-05-07 17:44:01','stockSale','115','د حضرت شاه د ټولی هفتې حساب ورسول سو',2,NULL,1),(553,'2026-05-07 18:19:47','cashReceipt','25','نقدی ورسیدی',2,NULL,1),(554,'2026-05-07 19:30:38','cashPayment','84','دجییب خرځ لپاره',2,NULL,1),(555,'2026-05-07 19:31:32','cashPayment','85','دچیب خرڅ لپاره',2,NULL,1),(556,'2026-05-07 19:32:21','cashPayment','86','میوه او سودا لپاره',2,NULL,1),(557,'2026-05-07 19:33:18','cashPayment','87','د دوکان دشاګرد هفتګي',2,NULL,1),(558,'2026-05-09 10:37:06','stockSale','116',NULL,2,NULL,1),(559,'2026-05-09 11:48:03','stockSale','117',NULL,2,NULL,1),(560,'2026-05-09 14:24:42','stockSale','118',NULL,2,NULL,1),(561,'2026-05-09 14:30:23','stockSale','119','مطیع الله ته ورکول سو',2,NULL,1),(562,'2026-05-09 16:31:54','stockPurchase','60',NULL,2,NULL,1),(563,'2026-05-09 18:32:41','stockSale','120',NULL,2,NULL,1),(564,'2026-05-10 10:53:14','stockSale','121',NULL,2,NULL,1),(565,'2026-05-10 11:55:27','stockSale','122',NULL,2,NULL,1),(566,'2026-05-10 12:02:14','stockSale','123',NULL,2,NULL,1),(567,'2026-05-10 12:06:54','stockSale','124',NULL,2,NULL,1),(568,'2026-05-10 12:17:36','stockSale','125',NULL,2,NULL,1),(569,'2026-05-10 18:30:07','revenue','5','د DVR د پاسورډ ماتول',2,NULL,1),(570,'2026-05-10 18:33:22','stockSale','126',NULL,2,NULL,1),(571,'2026-05-10 18:34:29','cashReceipt','26',NULL,2,NULL,1),(572,'2026-05-10 18:36:18','cashPayment','88','دغاښو لپاره',2,NULL,1),(573,'2026-05-10 18:41:30','cashPayment','89','د ډاټابیس درانیولو لپاره',2,NULL,1),(574,'2026-05-11 12:16:36','stockPurchase','61',NULL,2,NULL,1),(575,'2026-05-11 12:17:08','stockPurchase','62',NULL,2,NULL,1),(576,'2026-05-11 12:18:48','stockPurchase','63',NULL,2,NULL,1),(578,'2026-05-11 12:17:08','stockPurchaseBillCost','62',NULL,2,575,1),(579,'2026-05-11 12:16:36','stockPurchaseBillCost','61',NULL,2,574,1),(580,'2026-05-11 12:18:48','stockPurchaseBillCost','63',NULL,2,576,1),(581,'2026-05-11 12:20:50','cashTransfer','12','نقدی صرافی ته یو وړل سوې',2,NULL,1),(582,'2026-05-11 15:44:05','stockSale','127','bill 1085',2,NULL,1),(583,'2026-05-11 16:54:54','stockSale','128',NULL,2,NULL,1);
/*!40000 ALTER TABLE `journals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keyvalues`
--

DROP TABLE IF EXISTS `keyvalues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keyvalues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keyvalues`
--

LOCK TABLES `keyvalues` WRITE;
/*!40000 ALTER TABLE `keyvalues` DISABLE KEYS */;
INSERT INTO `keyvalues` VALUES (1,'baseUnit','[\"متر\",\"دانه\"]'),(2,'units','[\"yard\",\"meter\",\"liter\",\"g\",\"kg\",\"unit\"]'),(3,'stockItemCategory','[\"1230t1-s5\",\"1509cp-a-led\",\"1500tp-z-a\",\"1200tp-z-a\",\"1200trqp-a\",\"1500trqp-a\",\"b1a21p\",\"t1a21p\",\"b1a51p\",\"t1a51p\",\"1200clqp-il-a\",\"1200clp-il-a\",\"1209tlqp-a-led\",\"عمومی\",\"1500clqp-il-a\",\"1500clp-il-a\",\"1509tlqp-a-led\",\"امنیتی کامرې\",\"د کامرو لین\",\"د کامرو میده سامان\"]'),(4,'position','[\"director\",\"manager\",\"computer operator\",\"labor\",\"marketer\"]'),(5,'$settings','{\"general\":{\"numOfDecimals\":2}}'),(6,'stockItemCompany','[\"پنچ - punch\",\"ویش والا\",\"استعمالی\",\"نوی\",\"د ویش هارډیسک\",\"دبی هارډیسک\",\"سرویلانس هارډیسک\",\"Hikvision Original\",\"د خلیل څخه رانیول سوی ډی وی آر\",\"کراچی والا\",\"عادل کمپیوټر\",\"حیدری\",\"لمر کمپیوټر\",\"د خلیل څخه رانیول سوی کامرې\",\"Islam Shinwari\",\"Dahua Copy\",\"دهوا\",\"کاپي\"]'),(7,'accountCategory','[\"کښتګر\",\"سرمایه\",\"انلاین مارکیټینګ\",\"عادی\",\"بازارموندونکی\",\"ورداش\",\"Kabul\",\"Boldak\",\"Farah\",\"Helmand\"]'),(8,'billCostDesc','[\"د کاریګر مزدوری\",\"کلیپ، تخته، میخ\",\"ساکټه\",\"مولد\",\"د tv پایه\",\"بورډونه\",\"کابل ټرانسپورټ مصارف\",\"بولدک ټرانسپورټ مصارف\",\"چین ټرانسپورټ مصارف\",\"دوبی ټرانسپورټ مصارف\"]'),(9,'$auto-backup','0');
/*!40000 ALTER TABLE `keyvalues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newfpitemvalues`
--

DROP TABLE IF EXISTS `newfpitemvalues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newfpitemvalues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `quantity` double NOT NULL,
  `journalId` int(11) DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `stockItemId` (`stockItemId`),
  CONSTRAINT `newfpitemvalues_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `newfpitemvalues_ibfk_2` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newfpitemvalues`
--

LOCK TABLES `newfpitemvalues` WRITE;
/*!40000 ALTER TABLE `newfpitemvalues` DISABLE KEYS */;
/*!40000 ALTER TABLE `newfpitemvalues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `note` varchar(255) NOT NULL,
  `importance` varchar(255) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `date` date NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
INSERT INTO `notes` VALUES (1,'aa','normal',NULL,'2026-04-25',2),(2,'a','normal',NULL,'2026-05-11',2);
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orginfomodels`
--

DROP TABLE IF EXISTS `orginfomodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orginfomodels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `abbreviation` varchar(255) NOT NULL,
  `contacts` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `currency` varchar(255) NOT NULL,
  `thermalPrinterTitle` varchar(255) DEFAULT NULL,
  `allowNegativeStock` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orginfomodels`
--

LOCK TABLES `orginfomodels` WRITE;
/*!40000 ALTER TABLE `orginfomodels` DISABLE KEYS */;
INSERT INTO `orginfomodels` VALUES (1,'Fazli Technology','','0705271068&|0705271068.whatsapp&#Abdullah.Fazli','Alama Habibi Waat, Oppisite to Kandahar Money Exchange Market, Fazli Technology','AFN','',0);
/*!40000 ALTER TABLE `orginfomodels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payrollitems`
--

DROP TABLE IF EXISTS `payrollitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payrollitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `salaryAmount` double NOT NULL,
  `salaryCode` char(3) NOT NULL,
  `baseSalaryAmount` double NOT NULL,
  `baseSalaryCode` char(3) NOT NULL,
  `payrollId` int(11) DEFAULT NULL,
  `employeeAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payrollId` (`payrollId`),
  KEY `employeeAccountId` (`employeeAccountId`),
  CONSTRAINT `payrollitems_ibfk_1` FOREIGN KEY (`payrollId`) REFERENCES `payrolls` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payrollitems_ibfk_2` FOREIGN KEY (`employeeAccountId`) REFERENCES `employeeaccounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payrollitems`
--

LOCK TABLES `payrollitems` WRITE;
/*!40000 ALTER TABLE `payrollitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `payrollitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payrolls`
--

DROP TABLE IF EXISTS `payrolls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payrolls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journalId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  CONSTRAINT `payrolls_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payrolls`
--

LOCK TABLES `payrolls` WRITE;
/*!40000 ALTER TABLE `payrolls` DISABLE KEYS */;
/*!40000 ALTER TABLE `payrolls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privileges`
--

DROP TABLE IF EXISTS `privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privileges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `rules` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privileges`
--

LOCK TABLES `privileges` WRITE;
/*!40000 ALTER TABLE `privileges` DISABLE KEYS */;
/*!40000 ALTER TABLE `privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profitdistributionitems`
--

DROP TABLE IF EXISTS `profitdistributionitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profitdistributionitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `percentage` double NOT NULL,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `profitDistributionId` int(11) DEFAULT NULL,
  `accountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profitDistributionId` (`profitDistributionId`),
  KEY `accountId` (`accountId`),
  CONSTRAINT `profitdistributionitems_ibfk_1` FOREIGN KEY (`profitDistributionId`) REFERENCES `profitdistributions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `profitdistributionitems_ibfk_2` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profitdistributionitems`
--

LOCK TABLES `profitdistributionitems` WRITE;
/*!40000 ALTER TABLE `profitdistributionitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `profitdistributionitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profitdistributions`
--

DROP TABLE IF EXISTS `profitdistributions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profitdistributions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `journalId` int(11) DEFAULT NULL,
  `profitAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `profitAccountId` (`profitAccountId`),
  CONSTRAINT `profitdistributions_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `profitdistributions_ibfk_2` FOREIGN KEY (`profitAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profitdistributions`
--

LOCK TABLES `profitdistributions` WRITE;
/*!40000 ALTER TABLE `profitdistributions` DISABLE KEYS */;
/*!40000 ALTER TABLE `profitdistributions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profitsharepercentages`
--

DROP TABLE IF EXISTS `profitsharepercentages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profitsharepercentages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `percentage` double NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `accountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `accountId` (`accountId`),
  CONSTRAINT `profitsharepercentages_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `profitsharepercentages_ibfk_2` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profitsharepercentages`
--

LOCK TABLES `profitsharepercentages` WRITE;
/*!40000 ALTER TABLE `profitsharepercentages` DISABLE KEYS */;
INSERT INTO `profitsharepercentages` VALUES (4,50,2,95),(5,50,2,56);
/*!40000 ALTER TABLE `profitsharepercentages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revenues`
--

DROP TABLE IF EXISTS `revenues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revenues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `isReturn` tinyint(1) NOT NULL DEFAULT 0,
  `journalId` int(11) DEFAULT NULL,
  `revenueAccountId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `revenueAccountId` (`revenueAccountId`),
  KEY `cashAccountId` (`cashAccountId`),
  CONSTRAINT `revenues_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `revenues_ibfk_2` FOREIGN KEY (`revenueAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `revenues_ibfk_3` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revenues`
--

LOCK TABLES `revenues` WRITE;
/*!40000 ALTER TABLE `revenues` DISABLE KEYS */;
INSERT INTO `revenues` VALUES (3,200,'AFN',200,'AFN',0,351,98,1),(4,30,'AFN',30,'AFN',0,354,98,1),(5,500,'AFN',500,'AFN',0,569,98,1);
/*!40000 ALTER TABLE `revenues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockadjustments`
--

DROP TABLE IF EXISTS `stockadjustments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockadjustments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` double NOT NULL,
  `baseQuantity` double NOT NULL,
  `unit` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `unitCostAmount` double NOT NULL,
  `unitCostCode` char(3) NOT NULL,
  `baseUnitCostAmount` double NOT NULL,
  `baseUnitCostCode` char(3) NOT NULL,
  `journalId` int(11) DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  `stockAccountId` int(11) DEFAULT NULL,
  `capitalAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `stockItemId` (`stockItemId`),
  KEY `stockAccountId` (`stockAccountId`),
  KEY `capitalAccountId` (`capitalAccountId`),
  CONSTRAINT `stockadjustments_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stockadjustments_ibfk_2` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stockadjustments_ibfk_3` FOREIGN KEY (`stockAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stockadjustments_ibfk_4` FOREIGN KEY (`capitalAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockadjustments`
--

LOCK TABLES `stockadjustments` WRITE;
/*!40000 ALTER TABLE `stockadjustments` DISABLE KEYS */;
INSERT INTO `stockadjustments` VALUES (5,99,99,'دانه','increase',117,'AFN',117,'AFN',20,9,2,14),(6,1,1,'دانه','increase',1500,'AFN',1500,'AFN',21,10,2,14),(7,114,114,'دانه','increase',12,'AFN',12,'AFN',22,11,2,14),(8,25,25,'دانه','increase',13,'AFN',13,'AFN',23,12,2,14),(9,57,57,'متر','increase',21,'AFN',21,'AFN',24,17,2,14),(11,2,610,'بنډل','increase',3660,'AFN',3660,'AFN',26,13,2,14),(12,6259,6259,'متر','increase',13,'AFN',13,'AFN',27,15,2,14),(13,4,800,'200 متره بنډل','increase',2200,'AFN',2200,'AFN',28,16,2,14),(14,10,10,'دانه','increase',807,'AFN',807,'AFN',29,18,2,14),(15,1,1,'دانه','increase',1500,'AFN',1500,'AFN',30,19,2,14),(16,3,3,'دانه','increase',1007,'AFN',1007,'AFN',31,20,2,14),(17,35,35,'دانه','increase',1005,'AFN',1005,'AFN',32,21,2,14),(18,11,11,'دانه','increase',1115,'AFN',1115,'AFN',33,22,2,14),(19,8,8,'دانه','increase',1151,'AFN',1151,'AFN',34,23,2,14),(20,6,6,'دانه','increase',960,'AFN',960,'AFN',35,24,2,14),(21,7,7,'دانه','increase',500,'AFN',500,'AFN',36,26,2,14),(22,2,2,'دانه','increase',918,'AFN',918,'AFN',37,27,2,14),(23,4,4,'دانه','increase',5049,'AFN',5049,'AFN',38,28,2,14),(24,1,1,'دانه','increase',151,'AFN',151,'AFN',39,29,2,14),(25,1,1,'دانه','increase',3375,'AFN',3375,'AFN',40,30,2,14),(26,1,1,'دانه','increase',6750,'AFN',6750,'AFN',41,31,2,14),(27,70,70,'دانه','increase',62,'AFN',62,'AFN',42,32,2,14),(28,16,16,'دانه','increase',163,'AFN',163,'AFN',43,33,2,14),(29,3,3,'دانه','increase',2703,'AFN',2703,'AFN',44,36,2,14),(30,12,12,'دانه','increase',781,'AFN',781,'AFN',45,34,2,14),(31,1,1,'دانه','increase',150,'AFN',150,'AFN',46,35,2,14),(32,11,11,'دانه','increase',1240,'AFN',1240,'AFN',47,39,2,14),(33,7,7,'دانه','increase',1155,'AFN',1155,'AFN',48,40,2,14),(34,12,12,'دانه','increase',796,'AFN',796,'AFN',49,41,2,14),(35,1,1,'دانه','increase',3206,'AFN',3206,'AFN',50,178,2,14),(36,23,23,'دانه','increase',799,'AFN',799,'AFN',51,42,2,14),(37,9,9,'دانه','increase',1039,'AFN',1039,'AFN',52,43,2,14),(38,10,10,'دانه','increase',1571,'AFN',1571,'AFN',53,44,2,14),(39,1,1,'دانه','increase',1571,'AFN',1571,'AFN',54,179,2,14),(40,6,6,'دانه','increase',1565,'AFN',1565,'AFN',55,46,2,14),(41,3,3,'دانه','increase',1334,'AFN',1334,'AFN',56,47,2,14),(42,1,1,'دانه','increase',3843,'AFN',3843,'AFN',57,48,2,14),(43,5,5,'دانه','increase',1324,'AFN',1324,'AFN',58,51,2,14),(44,4,4,'دانه','increase',1385,'AFN',1385,'AFN',59,52,2,14),(45,3,3,'دانه','increase',4556,'AFN',4556,'AFN',60,53,2,14),(46,3,3,'دانه','increase',7092,'AFN',7092,'AFN',61,54,2,14),(47,3,3,'دانه','increase',8172,'AFN',8172,'AFN',62,55,2,14),(48,1,1,'دانه','increase',14397,'AFN',14397,'AFN',63,56,2,14),(49,1,1,'دانه','increase',16304,'AFN',16304,'AFN',64,57,2,14),(50,2,2,'دانه','increase',1974,'AFN',1974,'AFN',65,58,2,14),(51,3,3,'دانه','increase',3130,'AFN',3130,'AFN',66,59,2,14),(52,2,2,'دانه','increase',3601,'AFN',3601,'AFN',67,60,2,14),(53,5,5,'دانه','increase',2626,'AFN',2626,'AFN',68,61,2,14),(54,2,2,'دانه','increase',3846,'AFN',3846,'AFN',69,62,2,14),(55,1,1,'دانه','increase',4869,'AFN',4869,'AFN',70,63,2,14),(56,2,2,'دانه','increase',4330,'AFN',4330,'AFN',71,64,2,14),(57,2,2,'دانه','increase',2000,'AFN',2000,'AFN',72,65,2,14),(58,4,4,'دانه','increase',4079,'AFN',4079,'AFN',73,66,2,14),(59,1,1,'دانه','increase',3850,'AFN',3850,'AFN',74,67,2,14),(60,3,3,'دانه','increase',900,'AFN',900,'AFN',75,68,2,14),(61,13,13,'دانه','increase',1625,'AFN',1625,'AFN',76,69,2,14),(62,5,5,'دانه','increase',1500,'AFN',1500,'AFN',77,71,2,14),(63,5,5,'دانه','increase',897,'AFN',897,'AFN',78,74,2,14),(64,1,1,'دانه','increase',1600,'AFN',1600,'AFN',79,75,2,14),(65,1,1,'دانه','increase',3100,'AFN',3100,'AFN',80,77,2,14),(66,1,1,'دانه','increase',3588,'AFN',3588,'AFN',81,180,2,14),(67,11,11,'دانه','increase',281,'AFN',281,'AFN',82,80,2,14),(68,23,23,'دانه','increase',53,'AFN',53,'AFN',83,81,2,14),(69,26,26,'دانه','increase',95,'AFN',95,'AFN',84,82,2,14),(70,85,85,'دانه','increase',55,'AFN',55,'AFN',85,83,2,14),(71,11,11,'دانه','increase',354,'AFN',354,'AFN',86,88,2,14),(72,2,2,'دانه','increase',270,'AFN',270,'AFN',87,182,2,14),(73,5,5,'دانه','increase',436,'AFN',436,'AFN',88,89,2,14),(74,7,7,'دانه','increase',728,'AFN',728,'AFN',89,90,2,14),(75,2,2,'دانه','increase',1268,'AFN',1268,'AFN',90,91,2,14),(76,15,15,'دانه','increase',75,'AFN',75,'AFN',91,84,2,14),(77,3,3,'دانه','increase',157,'AFN',157,'AFN',92,85,2,14),(78,10,10,'دانه','increase',117,'AFN',117,'AFN',93,86,2,14),(79,11,11,'دانه','increase',204,'AFN',204,'AFN',94,87,2,14),(80,4,4,'دانه','increase',2427,'AFN',2427,'AFN',95,94,2,14),(81,3,3,'دانه','increase',4044,'AFN',4044,'AFN',96,95,2,14),(82,2,2,'دانه','increase',6066,'AFN',6066,'AFN',97,100,2,14),(83,3,3,'دانه','increase',1517,'AFN',1517,'AFN',98,183,2,14),(84,2,2,'دانه','increase',1769,'AFN',1769,'AFN',99,93,2,14),(85,2,2,'دانه','increase',1972,'AFN',1972,'AFN',100,92,2,14),(86,5,5,'دانه','increase',108,'AFN',108,'AFN',101,101,2,14),(87,1,1,'دانه','increase',2440,'AFN',2440,'AFN',102,102,2,14),(88,1,1,'دانه','increase',3100,'AFN',3100,'AFN',103,103,2,14),(89,1,1,'دانه','increase',130,'AFN',130,'AFN',104,106,2,14),(90,3,3,'دانه','increase',340,'AFN',340,'AFN',105,104,2,14),(91,3,3,'دانه','increase',489,'AFN',489,'AFN',106,105,2,14),(92,3,3,'دانه','increase',50,'AFN',50,'AFN',107,107,2,14),(93,1,1,'دانه','increase',300,'AFN',300,'AFN',108,108,2,14),(94,3,3,'دانه','increase',1920,'AFN',1920,'AFN',109,109,2,14),(95,1,1,'دانه','increase',150,'AFN',150,'AFN',110,110,2,14),(96,1,1,'دانه','increase',218,'AFN',218,'AFN',111,112,2,14),(97,3,3,'دانه','increase',238,'AFN',238,'AFN',112,113,2,14),(98,1,1,'دانه','increase',670,'AFN',670,'AFN',113,114,2,14),(99,10,10,'دانه','increase',115,'AFN',115,'AFN',114,115,2,14),(100,18,18,'دانه','increase',1919,'AFN',1919,'AFN',115,116,2,14),(101,57,57,'دانه','increase',8,'AFN',8,'AFN',116,117,2,14),(102,315,315,'دانه','increase',15,'AFN',15,'AFN',117,118,2,14),(103,305,305,'دانه','increase',15,'AFN',15,'AFN',118,119,2,14),(104,1,1,'دانه','increase',252,'AFN',252,'AFN',119,120,2,14),(105,2,2,'دانه','increase',877,'AFN',877,'AFN',120,121,2,14),(106,2,2,'دانه','increase',795,'AFN',795,'AFN',121,122,2,14),(107,4,4,'دانه','increase',918,'AFN',918,'AFN',122,123,2,14),(108,2,2,'دانه','increase',1430,'AFN',1430,'AFN',123,124,2,14),(109,1,1,'دانه','increase',1756,'AFN',1756,'AFN',124,125,2,14),(110,2,2,'دانه','increase',2475,'AFN',2475,'AFN',125,126,2,14),(111,2,2,'دانه','increase',1620,'AFN',1620,'AFN',126,127,2,14),(112,1,1,'دانه','increase',3000,'AFN',3000,'AFN',127,128,2,14),(113,1,1,'دانه','increase',7000,'AFN',7000,'AFN',128,129,2,14),(114,86,86,'دانه','increase',13,'AFN',13,'AFN',129,130,2,14),(115,332,332,'دانه','increase',6,'AFN',6,'AFN',130,131,2,14),(116,7,7,'دانه','increase',450,'AFN',450,'AFN',131,132,2,14),(117,3,3,'دانه','increase',142,'AFN',142,'AFN',132,133,2,14),(118,1,1,'دانه','increase',560,'AFN',560,'AFN',133,134,2,14),(119,200,200,'دانه','increase',2,'AFN',2,'AFN',134,135,2,14),(120,109,109,'دانه','increase',3,'AFN',3,'AFN',135,136,2,14),(121,10,10,'دانه','increase',25,'AFN',25,'AFN',136,137,2,14),(122,2,2,'دانه','increase',1030,'AFN',1030,'AFN',137,138,2,14),(123,8,8,'دانه','increase',41,'AFN',41,'AFN',138,139,2,14),(124,1,1,'دانه','increase',970,'AFN',970,'AFN',139,140,2,14),(125,1,1,'دانه','increase',1216,'AFN',1216,'AFN',140,141,2,14),(126,13,13,'دانه','increase',355,'AFN',355,'AFN',141,142,2,14),(127,1,1,'دانه','increase',700,'AFN',700,'AFN',142,143,2,14),(128,3,3,'دانه','increase',329,'AFN',329,'AFN',143,144,2,14),(129,1,1,'دانه','increase',852,'AFN',852,'AFN',144,145,2,14),(130,3,3,'دانه','increase',1055,'AFN',1055,'AFN',145,146,2,14),(131,2,2,'دانه','increase',3500,'AFN',3500,'AFN',146,148,2,14),(132,2,2,'دانه','increase',2500,'AFN',2500,'AFN',147,147,2,14),(133,6,6,'دانه','increase',59,'AFN',59,'AFN',148,149,2,14),(134,7,7,'دانه','increase',105,'AFN',105,'AFN',149,150,2,14),(135,2,2,'دانه','increase',154,'AFN',154,'AFN',150,151,2,14),(137,2,2,'دانه','increase',347,'AFN',347,'AFN',152,153,2,14),(138,1,1,'دانه','increase',500,'AFN',500,'AFN',153,154,2,14),(139,5,5,'دانه','increase',51,'AFN',51,'AFN',154,155,2,14),(140,3,3,'دانه','increase',86,'AFN',86,'AFN',155,156,2,14),(141,2,2,'دانه','increase',121,'AFN',121,'AFN',156,157,2,14),(142,1,1,'دانه','increase',209,'AFN',209,'AFN',157,158,2,14),(143,1,1,'دانه','increase',470,'AFN',470,'AFN',158,159,2,14),(144,16,16,'دانه','increase',38,'AFN',38,'AFN',159,160,2,14),(145,2,2,'دانه','increase',65,'AFN',65,'AFN',160,161,2,14),(146,4,4,'دانه','increase',175,'AFN',175,'AFN',161,163,2,14),(147,6,6,'دانه','increase',80,'AFN',80,'AFN',162,164,2,14),(148,12,12,'دانه','increase',862,'AFN',862,'AFN',163,184,2,14),(149,2,2,'دانه','increase',1932,'AFN',1932,'AFN',164,166,2,14),(150,1,1,'دانه','increase',1365,'AFN',1365,'AFN',165,167,2,14),(151,2,2,'دانه','increase',1105,'AFN',1105,'AFN',166,168,2,14),(152,1,1,'دانه','increase',1106,'AFN',1106,'AFN',167,169,2,14),(153,1,1,'دانه','increase',1000,'AFN',1000,'AFN',168,171,2,14),(154,1,1,'دانه','increase',1520,'AFN',1520,'AFN',169,173,2,14),(155,1,1,'دانه','increase',1733,'AFN',1733,'AFN',170,174,2,14),(156,1,1,'دانه','increase',2432,'AFN',2432,'AFN',171,175,2,14),(157,4,4,'دانه','increase',1529,'AFN',1529,'AFN',172,176,2,14),(158,6,6,'دانه','increase',1000,'AFN',1000,'AFN',173,177,2,14),(159,1,1,'دانه','increase',1000,'AFN',1000,'AFN',333,191,2,14);
/*!40000 ALTER TABLE `stockadjustments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockexpiryalerts`
--

DROP TABLE IF EXISTS `stockexpiryalerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockexpiryalerts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expiryDate` date NOT NULL,
  `daysBefore` int(11) NOT NULL,
  `refId` int(11) DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stockItemId` (`stockItemId`),
  KEY `stock_expiry_alerts_expiry_date` (`expiryDate`),
  KEY `stock_expiry_alerts_ref_id` (`refId`),
  CONSTRAINT `stockexpiryalerts_ibfk_1` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockexpiryalerts`
--

LOCK TABLES `stockexpiryalerts` WRITE;
/*!40000 ALTER TABLE `stockexpiryalerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `stockexpiryalerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockitemexchanges`
--

DROP TABLE IF EXISTS `stockitemexchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockitemexchanges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `soldItemPriceAmount` double NOT NULL DEFAULT 0,
  `soldItemPriceCode` char(3) NOT NULL DEFAULT '0',
  `soldItemBasePriceAmount` double NOT NULL DEFAULT 0,
  `soldItemBasePriceCode` char(3) NOT NULL DEFAULT '0',
  `boughtItemPriceAmount` double NOT NULL DEFAULT 0,
  `boughtItemPriceCode` char(3) NOT NULL DEFAULT '0',
  `boughtItemBasePriceAmount` double NOT NULL DEFAULT 0,
  `boughtItemBasePriceCode` char(3) NOT NULL DEFAULT '0',
  `journalId` int(11) DEFAULT NULL,
  `soldItemId` int(11) DEFAULT NULL,
  `boughtItemId` int(11) DEFAULT NULL,
  `stockAccountId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `soldItemId` (`soldItemId`),
  KEY `boughtItemId` (`boughtItemId`),
  KEY `stockAccountId` (`stockAccountId`),
  KEY `cashAccountId` (`cashAccountId`),
  CONSTRAINT `stockitemexchanges_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stockitemexchanges_ibfk_2` FOREIGN KEY (`soldItemId`) REFERENCES `stockitems` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stockitemexchanges_ibfk_3` FOREIGN KEY (`boughtItemId`) REFERENCES `stockitems` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stockitemexchanges_ibfk_4` FOREIGN KEY (`stockAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stockitemexchanges_ibfk_5` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockitemexchanges`
--

LOCK TABLES `stockitemexchanges` WRITE;
/*!40000 ALTER TABLE `stockitemexchanges` DISABLE KEYS */;
/*!40000 ALTER TABLE `stockitemexchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockitems`
--

DROP TABLE IF EXISTS `stockitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `labelName` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `baseUnit` varchar(255) NOT NULL,
  `safetyStock` double DEFAULT NULL,
  `generateBarcode` tinyint(1) DEFAULT NULL,
  `barcode` text DEFAULT NULL,
  `purchasePriceAmount` double NOT NULL DEFAULT 0,
  `purchasePriceCode` char(3) NOT NULL,
  `salePriceAmount` double NOT NULL DEFAULT 0,
  `salePriceCode` char(3) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `x` (`name`),
  UNIQUE KEY `code` (`code`),
  KEY `userId` (`userId`),
  CONSTRAINT `stockitems_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockitems`
--

LOCK TABLES `stockitems` WRITE;
/*!40000 ALTER TABLE `stockitems` DISABLE KEYS */;
INSERT INTO `stockitems` VALUES (9,'2026-03-21 15:03:44','Adapter 12v',NULL,NULL,NULL,NULL,'دانه',30,1,'000000009',75,'AFN',300,'AFN',2),(10,'2026-04-01 15:03:59','Barcode Scanner',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000010',0,'AFN',1700,'AFN',2),(11,'2026-03-21 15:04:38','BNC',NULL,NULL,NULL,NULL,'دانه',100,1,'000000011',9,'AFN',30,'AFN',2),(12,'2026-03-21 15:05:55','BNC Wired',NULL,NULL,NULL,NULL,'دانه',20,1,'000000012',15,'AFN',20,'AFN',2),(13,'2026-04-01 15:07:37','Camera Cable ABL',NULL,NULL,'عادل کمپیوټر',NULL,'متر',NULL,1,'000000013',0,'AFN',20,'AFN',2),(15,'2026-04-01 15:08:48','Camera Cable HK',NULL,'haid','حیدری',NULL,'متر',1000,1,'000000015',12,'AFN',20,'AFN',2),(16,'2026-04-01 15:09:40','Camera Cable ISC - 200m',NULL,NULL,'Islam Shinwari',NULL,'متر',600,1,'000000016',0,'AFN',2400,'AFN',2),(17,'2026-04-01 15:13:19','Camera Cable 18.5',NULL,'18.5','لمر کمپیوټر',NULL,'متر',300,1,'000000017',21,'AFN',25,'AFN',2),(18,'2026-04-01 15:13:54','CCTV 2mp indoor',NULL,NULL,'کاپي',NULL,'دانه',NULL,1,'000000018',0,'AFN',1200,'AFN',2),(19,'2026-04-01 15:14:09','CCTV 360 ACC 5mp',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000019',0,'AFN',1700,'AFN',2),(20,'2026-04-01 15:14:24','CCTV 360 Dahua 2mp',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000020',0,'AFN',1200,'AFN',2),(21,'2026-04-01 15:14:51','CCTV 360 Dahua 2mp Fullcolor with Mic',NULL,NULL,NULL,NULL,'دانه',20,1,'000000021',0,'AFN',1200,'AFN',2),(22,'2026-04-01 15:15:22','CCTV 360 Sony 2mp Indoor',NULL,NULL,NULL,NULL,'دانه',20,1,'000000022',24,'USD',1400,'AFN',2),(23,'2026-04-01 15:15:50','CCTV 360 Sony 2mp Outdoor',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000023',14,'USD',1151,'AFN',2),(24,'2026-04-01 15:17:56','CCTV 5mp Indoor',NULL,NULL,'کاپي',NULL,'دانه',NULL,1,'000000024',0,'AFN',1200,'AFN',2),(26,'2026-04-01 15:43:34','CCTV BFK',NULL,NULL,'د خلیل څخه رانیول سوی کامرې',NULL,'دانه',NULL,1,'000000026',0,'AFN',1500,'AFN',2),(27,'2026-04-01 15:43:59','Dahua CCTV 5mp Outdoor C',NULL,NULL,'کاپي',NULL,'دانه',NULL,1,'000000027',0,'AFN',1300,'AFN',2),(28,'2026-04-01 15:44:45','CCTV Kit 4 Camera Sony',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000028',0,'AFN',6000,'AFN',2),(29,'2026-04-01 15:44:52','CCTV Mic',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000029',0,'AFN',200,'AFN',2),(30,'2026-04-01 15:49:35','NVR CCTV Kit 4 Camera',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000030',0,'AFN',5000,'AFN',2),(31,'2026-04-01 15:49:43','NVR CCTV Kit 8 Camera',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000031',0,'AFN',8000,'AFN',2),(32,'2026-04-01 15:49:51','CCTV Stand',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000032',0,'AFN',150,'AFN',2),(33,'2026-04-01 15:50:00','CCTV Used',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000033',0,'AFN',700,'AFN',2),(34,'2026-04-01 15:50:28','Computer Bag',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000034',0,'AFN',800,'AFN',2),(35,'2026-04-01 15:50:40','Conole Cable',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000035',0,'AFN',200,'AFN',2),(36,'2026-04-01 15:51:35','Dahua CCTV 2mp - 1200RP-Z-IRE6',NULL,'1200RPZ','دهوا',NULL,'دانه',2,1,'000000036',0,'AFN',3500,'AFN',2),(37,'2026-04-01 16:07:13','Dahua CCTV 2mp Indoor - full color with Mic',NULL,'1200CLQP-IL-A','دهوا','1200clqp-il-a','دانه',5,1,'000000037',0,'AFN',0,'AFN',2),(39,'2026-04-01 16:08:42','Dahua CCTV 2mp Outdoor - full color with Mic',NULL,'1200CLP-IL-A','دهوا','1200clp-il-a','دانه',5,1,'000000039',0,'AFN',1600,'AFN',2),(40,'2026-04-01 16:11:38','Dahua CCTV 2mp - Fullcolor with Mic',NULL,'1209TLQP-A-LED','دهوا','1209tlqp-a-led','دانه',5,1,'000000040',0,'AFN',1600,'AFN',2),(41,'2026-04-01 16:12:41','Dahua CCTV 2mp Indoor',NULL,'T1A21P','دهوا','t1a21p','دانه',5,1,'000000041',0,'AFN',1200,'AFN',2),(42,'2026-04-01 16:13:30','Dahua CCTV 2mp Outdoor',NULL,'B1A21P','دهوا','b1a21p','دانه',5,1,'000000042',12,'USD',1200,'AFN',2),(43,'2026-04-01 16:14:09','Dahua CCTV 2mp Indoor with Mic',NULL,'1200TRQP-A','دهوا','1200trqp-a','دانه',5,1,'000000043',0,'AFN',1400,'AFN',2),(44,'2026-04-01 16:17:32','Dahua CCTV 5mp Outdoor - Full Color with Mic',NULL,'1500CLP-IL-A','دهوا','1500clp-il-a','دانه',5,1,'000000044',0,'AFN',1800,'AFN',2),(45,'2026-04-01 16:17:55','Dahua CCTV 5mp Indoor - Full Color with Mic',NULL,'1500CLQP-IL-A','دهوا','1500clqp-il-a','دانه',5,1,'000000045',26,'USD',2000,'AFN',2),(46,'2026-04-01 16:18:52','Dahua CCTV 5mp In door - Full Color with Mic',NULL,'1509TLQP-A-LED','دهوا','1509tlqp-a-led','دانه',5,1,'000000046',20,'USD',1800,'AFN',2),(47,'2026-04-01 16:31:00','Dahua CCTV 5mp Indoor',NULL,'T1A51P','دهوا','t1a51p','دانه',5,1,'000000047',18,'USD',1500,'AFN',2),(48,'2026-04-01 16:31:37','Dahua CCTV 5mp Motorized Zoom',NULL,'1500TP-Z-A','دهوا','1500tp-z-a','دانه',2,1,'000000048',0,'AFN',500,'AFN',2),(51,'2026-04-01 16:32:39','Dahua CCTV 5mp Outdoor',NULL,'B1A51P','دهوا','b1a51p','دانه',5,1,'000000051',20,'USD',1600,'AFN',2),(52,'2026-04-01 16:45:38','Dahua CCTV 5mp Indoor with Mic',NULL,'1500TRQP-A','دهوا','1500trqp-a','دانه',5,1,'000000052',1500,'AFN',1700,'AFN',2),(53,'2026-04-01 17:53:09','Dahua DVR 16 Channel 2mp',NULL,'XVR1B16-I','دهوا',NULL,'دانه',2,1,'000000053',65,'USD',5500,'AFN',2),(54,'2026-04-01 17:53:46','Dahua DVR 16 Channel 5mp - I',NULL,'XVR1B16H-I','دهوا',NULL,'دانه',2,1,'000000054',0,'AFN',8000,'AFN',2),(55,'2026-04-01 17:54:40','Dahua DVR 16 Channel 5mp - i3',NULL,'XVR1B16HS-i3','دهوا',NULL,'دانه',2,1,'000000055',0,'AFN',8500,'AFN',2),(56,'2026-04-01 17:56:26','Dahua DVR 32 Channel 2mp',NULL,'XVR4232AN-I','دهوا',NULL,'دانه',1,1,'000000056',0,'AFN',15500,'AFN',2),(57,'2026-04-01 17:56:53','Dahua DVR 32 Channel 5mp',NULL,'XVR5232AN-i3','دهوا',NULL,'دانه',1,1,'000000057',0,'AFN',17500,'AFN',2),(58,'2026-04-01 17:57:40','Dahua DVR 4 Channel 2mp',NULL,'XVR1B04-I','دهوا',NULL,'دانه',3,1,'000000058',27,'USD',3000,'AFN',2),(59,'2026-04-01 17:59:29','Dahua DVR 4 Channel 5mp - I',NULL,'XVR1B04H-i','دهوا',NULL,'دانه',2,1,'000000059',38,'USD',4000,'AFN',2),(60,'2026-04-01 18:01:30','Dahua DVR 4 Channel 5mp - i3',NULL,'XVR5104HS-i3','دهوا',NULL,'دانه',1,1,'000000060',0,'AFN',4500,'AFN',2),(61,'2026-04-01 18:02:10','Dahua DVR 8 Channel 2mp',NULL,'XVR1B08-I','دهوا',NULL,'دانه',3,1,'000000061',36,'USD',3700,'AFN',2),(62,'2026-04-01 18:03:03','Dahua DVR 8 Channel 5mp - i',NULL,'XVR1B08H-i','دهوا',NULL,'دانه',2,1,'000000062',58,'USD',5000,'AFN',2),(63,'2026-04-01 18:03:47','Dahua DVR 8 Channel 5mp - i3',NULL,'XVR5108HS-i3','دهوا',NULL,'دانه',1,1,'000000063',0,'AFN',5500,'AFN',2),(64,'2026-04-01 18:04:43','DVR 16 Channel 2mp GSA',NULL,NULL,'کاپي',NULL,'دانه',1,1,'000000064',0,'AFN',4500,'AFN',2),(65,'2026-04-01 18:05:14','DVR 16 Channel 2mp Ceeper - Used',NULL,NULL,'کاپي',NULL,'دانه',1,1,'000000065',0,'AFN',2500,'AFN',2),(66,'2026-04-01 18:05:45','DVR 16 Channel 5mp Dahua C',NULL,NULL,'کاپي',NULL,'دانه',2,1,'000000066',0,'AFN',4800,'AFN',2),(67,'2026-04-01 18:06:04','DVR 16 Channel 5mp Giga',NULL,NULL,'کاپي',NULL,'دانه',1,1,'000000067',0,'AFN',4800,'AFN',2),(68,'2026-04-01 18:06:24','DVR 4 Channel 2mp - Used',NULL,NULL,'کاپي',NULL,'دانه',1,1,'000000068',0,'AFN',1500,'AFN',2),(69,'2026-04-01 18:19:09','DVR 4 Channel 5mp - Marwa',NULL,NULL,'کاپي',NULL,'دانه',2,1,'000000069',0,'AFN',2200,'AFN',2),(70,'2026-04-01 18:19:24','DVR 8 Channel 5mp ABL',NULL,NULL,'کاپي',NULL,'دانه',2,1,'000000070',2000,'AFN',3000,'AFN',2),(71,'2026-04-01 18:20:18','DVR BFK',NULL,'','د خلیل څخه رانیول سوی ډی وی آر',NULL,'دانه',NULL,1,'000000071',0,'AFN',3000,'AFN',2),(72,'2026-04-01 18:21:14','Hikvision NVR7608NXI 8 Port',NULL,NULL,'Hikvision Original',NULL,'دانه',NULL,1,'000000072',6500,'AFN',7300,'AFN',2),(73,'2026-04-01 18:21:45','Hikvision IP Camera 4mp - 1043',NULL,NULL,'Hikvision Original',NULL,'دانه',NULL,1,'000000073',3600,'AFN',4000,'AFN',2),(74,'2026-04-01 18:23:08','Hard Disk 1 TB',NULL,NULL,'د ویش هارډیسک',NULL,'دانه',5,1,'000000074',1335,'AFN',1800,'AFN',2),(75,'2026-04-01 18:23:22','Hard Disk 2 TB',NULL,NULL,'د ویش هارډیسک',NULL,'دانه',NULL,1,'000000075',2225,'AFN',3000,'AFN',2),(76,'2026-04-01 18:23:35','Hard Disk 2.5 TB',NULL,NULL,'د ویش هارډیسک',NULL,'دانه',NULL,1,'000000076',0,'AFN',0,'AFN',2),(77,'2026-04-01 18:23:46','Hard Disk 3 TB',NULL,NULL,'د ویش هارډیسک',NULL,'دانه',NULL,1,'000000077',4000,'AFN',5000,'AFN',2),(78,'2026-04-01 18:23:55','Hark Disk 4 TB',NULL,NULL,'د ویش هارډیسک',NULL,'دانه',NULL,1,'000000078',0,'AFN',0,'AFN',2),(79,'2026-04-01 18:24:04','Hard Disk 6 TB',NULL,NULL,'د ویش هارډیسک',NULL,'دانه',NULL,1,'000000079',0,'AFN',0,'AFN',2),(80,'2026-04-01 18:24:17','Hard Disk 500 GB',NULL,NULL,'د ویش هارډیسک',NULL,'دانه',NULL,1,'000000080',445,'AFN',800,'AFN',2),(81,'2026-04-01 18:25:05','HDMI Cable 1.5m',NULL,NULL,'نوی',NULL,'دانه',NULL,1,'000000081',0,'AFN',100,'AFN',2),(82,'2026-04-01 18:25:23','HDMI Cable 1.5m 4k',NULL,NULL,'نوی',NULL,'دانه',NULL,1,'000000082',0,'AFN',200,'AFN',2),(83,'2026-04-01 18:25:40','Hdmi Cable 1.5m - U',NULL,NULL,'استعمالی',NULL,'دانه',NULL,1,'000000083',0,'AFN',100,'AFN',2),(84,'2026-04-01 18:26:05','HDMI Cable 3m',NULL,NULL,'نوی',NULL,'دانه',NULL,1,'000000084',0,'AFN',150,'AFN',2),(85,'2026-04-01 18:26:14','HDMI Cable 3m 4k',NULL,NULL,'نوی',NULL,'دانه',NULL,1,'000000085',120,'AFN',300,'AFN',2),(86,'2026-04-01 18:26:27','HDMI Cable 5m',NULL,NULL,'نوی',NULL,'دانه',NULL,1,'000000086',0,'AFN',250,'AFN',2),(87,'2026-04-01 18:26:36','HDMI Cable 5m 4k',NULL,NULL,'نوی',NULL,'دانه',NULL,1,'000000087',0,'AFN',400,'AFN',2),(88,'2026-04-01 18:26:44','HDMI Cable 10m 4k',NULL,NULL,'نوی',NULL,'دانه',NULL,1,'000000088',0,'AFN',700,'AFN',2),(89,'2026-04-01 18:26:52','HDMI Cable 15m 4k',NULL,NULL,'نوی',NULL,'دانه',NULL,1,'000000089',0,'AFN',900,'AFN',2),(90,'2026-04-01 18:27:02','HDMI Cable 20m 4k',NULL,NULL,'نوی',NULL,'دانه',NULL,1,'000000090',0,'AFN',1150,'AFN',2),(91,'2026-04-01 18:27:11','HDMI Cable 30m 4k',NULL,NULL,'نوی',NULL,'دانه',NULL,1,'000000091',900,'AFN',1650,'AFN',2),(92,'2026-04-01 18:28:05','HDMI Cable Fiber 80m',NULL,NULL,'نوی',NULL,'دانه',1,1,'000000092',0,'AFN',3000,'AFN',2),(93,'2026-04-01 18:28:21','HDMI Cable Fiber 70m',NULL,NULL,'نوی',NULL,'دانه',1,1,'000000093',0,'AFN',2800,'AFN',2),(94,'2026-04-01 18:28:31','HDMI Cable Fiber 100m',NULL,NULL,'نوی',NULL,'دانه',1,1,'000000094',0,'AFN',3500,'AFN',2),(95,'2026-04-01 18:28:48','HDMI Cable Fiber 150m',NULL,NULL,'نوی',NULL,'دانه',1,1,'000000095',0,'AFN',5500,'AFN',2),(100,'2026-04-01 18:29:58','HDMI Cable Fiber 200m',NULL,'hdmifiber200m','نوی',NULL,'دانه',1,1,'000000100',0,'AFN',7500,'AFN',2),(101,'2026-04-01 18:31:13','HDMI Cable Mini',NULL,NULL,NULL,NULL,'دانه',1,1,'000000101',0,'AFN',150,'AFN',2),(102,'2026-04-01 18:31:40','HDMI Extender 4k 120m',NULL,NULL,NULL,NULL,'دانه',1,1,'000000102',0,'AFN',3000,'AFN',2),(103,'2026-04-01 18:31:50','HDMI Extender 4k 200m',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000103',0,'AFN',4000,'AFN',2),(104,'2026-04-01 18:32:15','HDMI Splitter 2 X 1',NULL,NULL,NULL,NULL,'دانه',2,1,'000000104',300,'AFN',550,'AFN',2),(105,'2026-04-01 18:32:25','HDMI Splitter 4 X 1',NULL,NULL,NULL,NULL,'دانه',2,1,'000000105',0,'AFN',800,'AFN',2),(106,'2026-04-01 18:32:45','HDMI Splitter 2 X 1 - Small',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000106',0,'AFN',200,'AFN',2),(107,'2026-04-01 18:58:42','HDMI to Mini Converter',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000107',0,'AFN',80,'AFN',2),(108,'2026-04-01 18:58:52','Headphone A3',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000108',0,'AFN',400,'AFN',2),(109,'2026-04-01 18:59:11','Hologram 3D',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000109',0,'AFN',2800,'AFN',2),(110,'2026-04-01 18:59:26','Mini Display Port Adapter',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000110',0,'AFN',200,'AFN',2),(112,'2026-04-01 18:59:58','Mouse Wireless A4Tech',NULL,'mwa4t',NULL,NULL,'دانه',NULL,1,'000000112',0,'AFN',300,'AFN',2),(113,'2026-04-01 19:00:18','Mouse Wireless DM',NULL,NULL,NULL,NULL,'دانه',5,1,'000000113',240,'AFN',300,'AFN',2),(114,'2026-04-01 19:00:42','Mouse Wireless Logitech M185 Original',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000114',0,'AFN',950,'AFN',2),(115,'2026-04-01 19:01:04','Mousepad with Wireless Charger',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000115',0,'AFN',200,'AFN',2),(116,'2026-04-01 19:01:24','NetSS Wifi Router',NULL,NULL,NULL,NULL,'دانه',2,1,'000000116',0,'AFN',3000,'AFN',2),(117,'2026-04-01 19:01:53','Network Cable 305m Green',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000117',0,'AFN',15,'AFN',2),(118,'2026-04-01 19:02:15','Network Cable Cat6E SFTP Aico',NULL,NULL,NULL,NULL,'دانه',305,1,'000000118',0.22950819672131148,'USD',20,'AFN',2),(119,'2026-04-01 19:02:23','Network Cable EMP',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000119',0,'AFN',20,'AFN',2),(120,'2026-04-01 19:02:38','Network Cable Tester',NULL,NULL,NULL,NULL,'دانه',1,1,'000000120',0,'AFN',300,'AFN',2),(121,'2026-04-01 19:02:55','Network Cable Tester - XQ - 350',NULL,NULL,NULL,NULL,'دانه',1,1,'000000121',0,'AFN',1000,'AFN',2),(122,'2026-04-01 19:03:58','Plasma 17 inch Sharp',NULL,NULL,'ویش والا',NULL,'دانه',1,1,'000000122',0,'AFN',1300,'AFN',2),(123,'2026-04-01 19:04:11','Plasma 19 inch Sharp',NULL,NULL,'ویش والا',NULL,'دانه',1,1,'000000123',0,'AFN',1500,'AFN',2),(124,'2026-04-01 19:04:26','Plasma 22 inch',NULL,NULL,'ویش والا',NULL,'دانه',2,1,'000000124',1280,'AFN',2000,'AFN',2),(125,'2026-04-01 19:04:41','Plasma 24 inch',NULL,NULL,'ویش والا',NULL,'دانه',2,1,'000000125',1500,'AFN',2500,'AFN',2),(126,'2026-04-01 19:04:59','Plasma 27 inch',NULL,NULL,'ویش والا',NULL,'دانه',2,1,'000000126',0,'AFN',3200,'AFN',2),(127,'2026-04-01 19:05:14','Plasma 27 inch - Small line',NULL,NULL,'ویش والا',NULL,'دانه',NULL,1,'000000127',0,'AFN',2500,'AFN',2),(128,'2026-04-01 19:05:34','Plasma 50 inch Sony',NULL,NULL,'ویش والا',NULL,'دانه',1,1,'000000128',0,'AFN',4000,'AFN',2),(129,'2026-04-01 19:05:53','Plasma 55 inch Samsung Curve',NULL,NULL,'ویش والا',NULL,'دانه',1,1,'000000129',0,'AFN',10000,'AFN',2),(130,'2026-04-01 19:06:24','Power Cable Two plugs',NULL,NULL,'استعمالی',NULL,'دانه',30,1,'000000130',0,'AFN',50,'AFN',2),(131,'2026-04-01 19:06:49','PIN',NULL,NULL,NULL,NULL,'دانه',100,1,'000000131',2.0186,'AFN',30,'AFN',2),(132,'2026-04-01 19:07:03','Printer Tonners',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000132',0,'AFN',500,'AFN',2),(133,'2026-04-01 19:07:42','Network Cable Cramper',NULL,NULL,'پنچ - punch',NULL,'دانه',2,1,'000000133',0,'AFN',300,'AFN',2),(134,'2026-04-01 19:08:08','Network Cable Cramper - New',NULL,NULL,'پنچ - punch',NULL,'دانه',1,1,'000000134',0,'AFN',800,'AFN',2),(135,'2026-04-01 19:08:27','RJ11 Connector',NULL,NULL,NULL,NULL,'دانه',50,1,'000000135',0,'AFN',5,'AFN',2),(136,'2026-04-01 19:08:36','RJ45 Connector',NULL,NULL,NULL,NULL,'دانه',200,1,'000000136',2.5,'AFN',5,'AFN',2),(137,'2026-04-01 19:08:46','RJ45 Joiner',NULL,NULL,NULL,NULL,'دانه',5,1,'000000137',25,'AFN',50,'AFN',2),(138,'2026-04-01 19:09:00','Router TP Link 300Mbps',NULL,NULL,NULL,NULL,'دانه',1,1,'000000138',0,'AFN',1300,'AFN',2),(139,'2026-04-01 19:09:10','Router USB Cable',NULL,NULL,NULL,NULL,'دانه',3,1,'000000139',0,'AFN',100,'AFN',2),(140,'2026-04-01 19:09:43','Sandisk Original USB - 128 GB',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000140',0,'AFN',1200,'AFN',2),(141,'2026-04-01 19:09:59','Sandisk Original USB - 256 GB',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000141',0,'AFN',1500,'AFN',2),(142,'2026-04-01 19:10:13','Sandisk Original USB - 64 GB',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000142',0,'AFN',500,'AFN',2),(143,'2026-04-01 19:10:42','Sandisk Original USB OTG - 128 GB',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000143',0,'AFN',800,'AFN',2),(144,'2026-04-01 19:10:55','Sandisk Original USB OTG - 32 GB',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000144',0,'AFN',500,'AFN',2),(145,'2026-04-01 19:11:18','Sandisk Original USB Type-C - 128 GB',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000145',0,'AFN',1200,'AFN',2),(146,'2026-04-01 19:11:32','Sim Wifi - W05',NULL,NULL,NULL,NULL,'دانه',2,1,'000000146',0,'AFN',1400,'AFN',2),(147,'2026-04-01 19:12:04','Hikvision Switch PoE 4 Port Giga',NULL,NULL,'Hikvision Original',NULL,'دانه',1,1,'000000147',0,'AFN',3500,'AFN',2),(148,'2026-04-01 19:12:16','Hikvision Switch PoE 8 Port Giga',NULL,NULL,'Hikvision Original',NULL,'دانه',1,1,'000000148',3500,'AFN',4500,'AFN',2),(149,'2026-04-01 19:12:38','USB 2.0 Cable 1.5m',NULL,NULL,NULL,NULL,'دانه',2,1,'000000149',0,'AFN',100,'AFN',2),(150,'2026-04-01 19:12:47','USB 2.0 Cable 3m',NULL,NULL,NULL,NULL,'دانه',2,1,'000000150',0,'AFN',200,'AFN',2),(151,'2026-04-01 19:12:55','USB 2.0 Cable 5m',NULL,NULL,NULL,NULL,'دانه',2,1,'000000151',150,'AFN',300,'AFN',2),(152,'2026-04-01 19:13:07','USB 2.0 Cable 10m',NULL,NULL,NULL,NULL,'دانه',1,1,'000000152',290,'AFN',500,'AFN',2),(153,'2026-04-01 19:13:29','USB Extender with RJ45 - 200m',NULL,NULL,NULL,NULL,'دانه',2,1,'000000153',350,'AFN',500,'AFN',2),(154,'2026-04-01 19:13:42','USB to HDMI Converter',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000154',0,'AFN',600,'AFN',2),(155,'2026-04-01 19:13:59','VGA Cable White 1.5m',NULL,NULL,NULL,NULL,'دانه',3,1,'000000155',0,'AFN',100,'AFN',2),(156,'2026-04-01 19:14:11','VGA Cable White 3m',NULL,NULL,NULL,NULL,'دانه',2,1,'000000156',0,'AFN',150,'AFN',2),(157,'2026-04-01 19:14:17','VGA Cable White 5m',NULL,NULL,NULL,NULL,'دانه',2,1,'000000157',0,'AFN',200,'AFN',2),(158,'2026-04-01 19:14:40','VGA Cable White 10m',NULL,NULL,NULL,NULL,'دانه',1,1,'000000158',0,'AFN',300,'AFN',2),(159,'2026-04-01 19:14:54','VGA Cable White 20m',NULL,NULL,NULL,NULL,'دانه',1,1,'000000159',0,'AFN',600,'AFN',2),(160,'2026-04-01 19:15:11','VGA Cable Black 1.5m',NULL,NULL,NULL,NULL,'دانه',2,1,'000000160',0,'AFN',100,'AFN',2),(161,'2026-04-01 19:15:17','VGA Cable Black 3m',NULL,NULL,NULL,NULL,'دانه',2,1,'000000161',0,'AFN',100,'AFN',2),(162,'2026-04-01 19:15:21','VGA Cable Black 5m',NULL,NULL,NULL,NULL,'دانه',2,1,'000000162',0,'AFN',0,'AFN',2),(163,'2026-04-01 19:15:29','VGA Cable Black 10m',NULL,NULL,NULL,NULL,'دانه',1,1,'000000163',0,'AFN',300,'AFN',2),(164,'2026-04-01 19:15:52','VGA Connector',NULL,NULL,NULL,NULL,'دانه',1,1,'000000164',0,'AFN',100,'AFN',2),(165,'2026-04-01 19:16:04','Wifi Camera - 360',NULL,NULL,NULL,NULL,'دانه',2,1,'000000165',0,'AFN',0,'AFN',2),(166,'2026-04-01 19:16:35','Wifi Camera - Battery - VQ001-W',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000166',0,'AFN',2100,'AFN',2),(167,'2026-04-01 19:18:12','Wifi Camera - dual lens- Battery',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000167',1500,'AFN',1650,'AFN',2),(168,'2026-04-01 19:18:30','Wifi Camera - V11',NULL,NULL,NULL,NULL,'دانه',5,1,'000000168',950,'AFN',1500,'AFN',2),(169,'2026-04-01 19:19:03','Wifi Camera- V38-H1-A',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000169',0,'AFN',1800,'AFN',2),(170,'2026-04-01 19:19:15','Wifi Camera - V9L',NULL,NULL,NULL,NULL,'دانه',5,1,'000000170',730,'AFN',1200,'AFN',2),(171,'2026-04-01 19:19:43','Wifi Camera - V9L - 4G',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000171',0,'AFN',1500,'AFN',2),(172,'2026-04-01 19:20:16','Wifi Camera V9L - New Design',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000172',0,'AFN',0,'AFN',2),(173,'2026-04-01 19:20:39','Wifi Camera with Battery - Hidden',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000173',0,'AFN',3000,'AFN',2),(174,'2026-04-01 19:20:51','Wifi Camera - Smart Charger',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000174',0,'AFN',3000,'AFN',2),(175,'2026-04-01 19:21:08','Wifi Camera - Solar',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000175',0,'AFN',3000,'AFN',2),(176,'2026-04-01 19:21:31','Wifi Camera Triple Lens - S302',NULL,NULL,NULL,NULL,'دانه',3,1,'000000176',1480,'AFN',1800,'AFN',2),(177,'2026-04-01 19:22:00','Wifi Camera - USB',NULL,NULL,NULL,NULL,'دانه',2,1,'000000177',0,'AFN',1400,'AFN',2),(178,'2026-04-02 13:40:13','Dahua CCTV 2mp Motorized Zoom',NULL,'1200TP-Z-A','دهوا','1200tp-z-a','دانه',1,1,'000000178',0,'AFN',3800,'AFN',2),(179,'2026-04-02 14:04:52','Dahua CCTV 5mp Outdoor Full with Mic',NULL,'1509CP-A-LED','دهوا','1509cp-a-led','دانه',5,0,'د تیر کال د حسابونو څخه را نقل سول',26,'USD',1800,'AFN',2),(180,'2026-04-02 15:26:17','Hard Disk 4 TB',NULL,'hdd4tb',NULL,NULL,'دانه',2,1,'000000180',4890,'AFN',6000,'AFN',2),(182,'2026-04-02 15:30:48','HDMI Cable 10m',NULL,'hdmi10m',NULL,NULL,'دانه',NULL,1,'000000182',0,'AFN',400,'AFN',2),(183,'2026-04-02 15:58:05','HDMI Cable Fiber 50m',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000183',0,'AFN',2500,'AFN',2),(184,'2026-04-02 17:20:43','Wifi Camera 360',NULL,NULL,NULL,NULL,'دانه',3,1,'000000184',0,'AFN',1500,'AFN',2),(185,'2026-04-03 20:12:45','Wifi Camera - Triple Lens - Battery',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000185',1056,'AFN',2000,'AFN',2),(186,'2026-04-03 20:15:33','Wifi Camera - P11',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000186',734,'AFN',1600,'AFN',2),(187,'2026-04-03 20:18:39','Camera Cable Fazli 18.5',NULL,NULL,NULL,NULL,'متر',NULL,1,'000000187',0,'AFN',0,'AFN',2),(188,'2026-04-03 20:20:09','Camera Cable - Fazli - 18.5',NULL,'fazlicable',NULL,NULL,'متر',NULL,1,'000000188',9.324590163934426,'AFN',0,'AFN',2),(189,'2026-04-09 15:19:37','Hard Disk 10 TB - Original',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000189',14500,'AFN',15000,'AFN',2),(190,'2026-04-09 16:37:12','Cooling Pad - 6 Fan',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000190',600,'AFN',700,'AFN',2),(191,'2026-04-09 16:53:06','Switch TP Link 24 Port - Used',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000191',0,'AFN',2000,'AFN',2),(192,'2026-04-09 17:05:36','Dahua DVR 4 Channel 2mp - Used',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000192',1500,'AFN',3200,'AFN',2),(193,'2026-04-12 19:29:44','Hard Disk 500 GB For PC',NULL,NULL,'د ویش هارډیسک',NULL,'دانه',NULL,1,'000000193',600,'AFN',800,'AFN',2),(194,'2026-04-12 19:31:20','Adapter 12v 2A',NULL,NULL,'استعمالی',NULL,'دانه',NULL,1,'000000194',40,'AFN',200,'AFN',2),(195,'2026-04-12 19:33:35','Adapter 12v 5A',NULL,NULL,'ویش والا',NULL,'دانه',NULL,1,'000000195',115,'AFN',350,'AFN',2),(196,'2026-04-12 19:35:36','Power Cable (Desktop)',NULL,NULL,'ویش والا',NULL,'دانه',NULL,1,'000000196',60,'AFN',80,'AFN',2),(197,'2026-04-12 19:39:59','Adapter 48v',NULL,NULL,'ویش والا',NULL,'دانه',NULL,1,'000000197',50,'AFN',400,'AFN',2),(198,'2026-04-16 13:48:21','Dahua CCTV 2mp Ip',NULL,NULL,NULL,'1230t1-s5','دانه',NULL,1,'000000198',525,'AFN',2000,'AFN',2),(199,'2026-04-16 16:26:52','Plasma 42 inch New',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000199',9000,'AFN',9500,'AFN',2),(200,'2026-04-16 16:28:46','TV Stand  - جیکی',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000200',200,'AFN',450,'AFN',2),(201,'2026-04-19 10:45:26','Hikvision DVR 7116HQHI M1 5MP',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000201',7300,'AFN',9000,'AFN',2),(202,'2026-04-19 10:46:00','Hikvision 10KFOT 5MP 3K COLOUR UV CAMERA',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000202',2200,'AFN',3000,'AFN',2),(203,'2026-04-19 11:12:32','Hard Disk 2 TB For PC',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000203',2700,'AFN',4000,'AFN',2),(204,'2026-04-21 18:36:30','Rack 4 U',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000204',50,'USD',5000,'AFN',2),(205,'2026-04-23 19:13:27','Hard Disk 1 TB for PC',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000205',1650,'AFN',0,'AFN',2),(206,'2026-04-26 11:04:16','CCTV 360 Used Dahua',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000206',400,'AFN',800,'AFN',2),(207,'2026-04-26 11:04:40','Dahua DVR 8 Camera 2mp - Used',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000207',1500,'AFN',3000,'AFN',2),(208,'2026-04-26 11:07:11','Dahua CCTV 2mp Indoor Fullcolor with Mic - Used - 1200CP-IL-A',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000208',450,'AFN',1000,'AFN',2),(209,'2026-04-27 18:14:18','Marwa HT - 60M 2mp',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000209',12.42,'USD',900,'AFN',2),(210,'2026-04-27 18:25:54','Wifi Camera Triple Lens - S304',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000210',1480,'AFN',2000,'AFN',2),(211,'2026-04-27 18:26:36','Wifi Camera Triple Lens - Battery - 3010 4G',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000211',2400,'AFN',3000,'AFN',2),(212,'2026-04-30 11:24:46','Switch - Dahua PoE - 8 Port - Giga',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000212',3600,'AFN',4500,'AFN',2),(213,'2026-04-30 20:15:27','Switch Ethernet 8 Port',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000213',500,'AFN',650,'AFN',2),(214,'2026-05-02 16:26:22','Plasma 55 inch Prism+ Andriod TV',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000214',6500,'AFN',10000,'AFN',2),(215,'2026-05-02 16:26:34','Plasma 55 inch Philphs',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000215',5000,'AFN',9500,'AFN',2),(216,'2026-05-05 16:38:40','Dahua CCTV IP 6 MP - 1639TC-A-IL',NULL,'1639TCAIL',NULL,NULL,'دانه',NULL,1,'000000216',75,'USD',5500,'AFN',2),(217,'2026-05-06 10:56:21','Dahua CCTV 5mp FullColor Mic - 1500Rip-il-aa',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000217',25,'USD',2000,'AFN',2),(218,'2026-05-06 11:02:33','switch POE 8 port',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000218',25,'USD',2800,'AFN',2),(219,'2026-05-06 11:05:04','daua invr 4k 8ch',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000219',0,'AFN',0,'AFN',2),(220,'2026-05-06 11:06:26','Dahua NVR 4k 8 Channel',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000220',80,'USD',5500,'AFN',2),(221,'2026-05-09 16:29:47','Dahua CCTV IP - 2mp - B1A29-A-IL',NULL,NULL,NULL,NULL,'دانه',NULL,1,'000000221',1850,'AFN',2400,'AFN',2);
/*!40000 ALTER TABLE `stockitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockitemunits`
--

DROP TABLE IF EXISTS `stockitemunits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockitemunits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `quantity` double NOT NULL,
  `salePriceAmount` double NOT NULL,
  `salePriceCode` char(3) NOT NULL,
  `isPurchaseUnit` tinyint(1) NOT NULL DEFAULT 0,
  `isSaleUnit` tinyint(1) NOT NULL DEFAULT 0,
  `barcode` text DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stockItemId` (`stockItemId`),
  CONSTRAINT `stockitemunits_ibfk_1` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockitemunits`
--

LOCK TABLES `stockitemunits` WRITE;
/*!40000 ALTER TABLE `stockitemunits` DISABLE KEYS */;
INSERT INTO `stockitemunits` VALUES (5,'کوتۍ',100,1500,'AFN',0,1,'900000111',11),(6,'کارتن',2500,30000,'AFN',1,0,'900000112',11),(7,'بسته',100,1500,'AFN',0,0,'900001311',131),(8,'کارتن',5000,75000,'AFN',1,0,'900001312',131),(9,'بنډل',100,2500,'AFN',1,1,'900000121',12),(25,'متر',1,20,'AFN',0,0,'900000171',17),(26,'305 متره بنډل',305,7000,'AFN',1,1,'900000172',17),(30,'متر',1,20,'AFN',0,0,'900000151',15),(31,'بنډل',300,4500,'AFN',1,1,'900000152',15),(32,'متر',1,20,'AFN',0,0,'900000131',13),(33,'بنډل',305,4575,'AFN',1,1,'900000132',13),(34,'بنډل',305,6100,'AFN',1,1,'900001881',188),(35,'200 متره بنډل',200,2600,'AFN',1,1,'900000161',16),(36,'بنډل',305,5000,'AFN',1,1,'900001181',118),(37,'بسته',100,400,'AFN',1,0,'900001361',136);
/*!40000 ALTER TABLE `stockitemunits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockitemvaluedists`
--

DROP TABLE IF EXISTS `stockitemvaluedists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockitemvaluedists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ratio` double NOT NULL,
  `baseQuantity` double NOT NULL,
  `journalId` int(11) DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  `stockAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `stockItemId` (`stockItemId`),
  KEY `stockAccountId` (`stockAccountId`),
  CONSTRAINT `stockitemvaluedists_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stockitemvaluedists_ibfk_2` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stockitemvaluedists_ibfk_3` FOREIGN KEY (`stockAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=334 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockitemvaluedists`
--

LOCK TABLES `stockitemvaluedists` WRITE;
/*!40000 ALTER TABLE `stockitemvaluedists` DISABLE KEYS */;
INSERT INTO `stockitemvaluedists` VALUES (11,1,99,20,9,2),(12,1,1,21,10,2),(13,1,114,22,11,2),(14,1,25,23,12,2),(15,1,57,24,17,2),(17,1,610,26,13,2),(18,1,6259,27,15,2),(19,1,800,28,16,2),(20,1,10,29,18,2),(21,1,1,30,19,2),(22,1,3,31,20,2),(23,1,35,32,21,2),(24,1,11,33,22,2),(25,1,8,34,23,2),(26,1,6,35,24,2),(27,1,7,36,26,2),(28,1,2,37,27,2),(29,1,4,38,28,2),(30,1,1,39,29,2),(31,1,1,40,30,2),(32,1,1,41,31,2),(33,1,70,42,32,2),(34,1,16,43,33,2),(35,1,3,44,36,2),(36,1,12,45,34,2),(37,1,1,46,35,2),(38,1,11,47,39,2),(39,1,7,48,40,2),(40,1,12,49,41,2),(41,1,1,50,178,2),(42,1,23,51,42,2),(43,1,9,52,43,2),(44,1,10,53,44,2),(45,1,1,54,179,2),(46,1,6,55,46,2),(47,1,3,56,47,2),(48,1,1,57,48,2),(49,1,5,58,51,2),(50,1,4,59,52,2),(51,1,3,60,53,2),(52,1,3,61,54,2),(53,1,3,62,55,2),(54,1,1,63,56,2),(55,1,1,64,57,2),(56,1,2,65,58,2),(57,1,3,66,59,2),(58,1,2,67,60,2),(59,1,5,68,61,2),(60,1,2,69,62,2),(61,1,1,70,63,2),(62,1,2,71,64,2),(63,1,2,72,65,2),(64,1,4,73,66,2),(65,1,1,74,67,2),(66,1,3,75,68,2),(67,1,13,76,69,2),(68,1,5,77,71,2),(69,1,5,78,74,2),(70,1,1,79,75,2),(71,1,1,80,77,2),(72,1,1,81,180,2),(73,1,11,82,80,2),(74,1,23,83,81,2),(75,1,26,84,82,2),(76,1,85,85,83,2),(77,1,11,86,88,2),(78,1,2,87,182,2),(79,1,5,88,89,2),(80,1,7,89,90,2),(81,1,2,90,91,2),(82,1,15,91,84,2),(83,1,3,92,85,2),(84,1,10,93,86,2),(85,1,11,94,87,2),(86,1,4,95,94,2),(87,1,3,96,95,2),(88,1,2,97,100,2),(89,1,3,98,183,2),(90,1,2,99,93,2),(91,1,2,100,92,2),(92,1,5,101,101,2),(93,1,1,102,102,2),(94,1,1,103,103,2),(95,1,1,104,106,2),(96,1,3,105,104,2),(97,1,3,106,105,2),(98,1,3,107,107,2),(99,1,1,108,108,2),(100,1,3,109,109,2),(101,1,1,110,110,2),(102,1,1,111,112,2),(103,1,3,112,113,2),(104,1,1,113,114,2),(105,1,10,114,115,2),(106,1,18,115,116,2),(107,1,57,116,117,2),(108,1,315,117,118,2),(109,1,305,118,119,2),(110,1,1,119,120,2),(111,1,2,120,121,2),(112,1,2,121,122,2),(113,1,4,122,123,2),(114,1,2,123,124,2),(115,1,1,124,125,2),(116,1,2,125,126,2),(117,1,2,126,127,2),(118,1,1,127,128,2),(119,1,1,128,129,2),(120,1,86,129,130,2),(121,1,332,130,131,2),(122,1,7,131,132,2),(123,1,3,132,133,2),(124,1,1,133,134,2),(125,1,200,134,135,2),(126,1,109,135,136,2),(127,1,10,136,137,2),(128,1,2,137,138,2),(129,1,8,138,139,2),(130,1,1,139,140,2),(131,1,1,140,141,2),(132,1,13,141,142,2),(133,1,1,142,143,2),(134,1,3,143,144,2),(135,1,1,144,145,2),(136,1,3,145,146,2),(137,1,2,146,148,2),(138,1,2,147,147,2),(139,1,6,148,149,2),(140,1,7,149,150,2),(141,1,2,150,151,2),(143,1,2,152,153,2),(144,1,1,153,154,2),(145,1,5,154,155,2),(146,1,3,155,156,2),(147,1,2,156,157,2),(148,1,1,157,158,2),(149,1,1,158,159,2),(150,1,16,159,160,2),(151,1,2,160,161,2),(152,1,4,161,163,2),(153,1,6,162,164,2),(154,1,12,163,184,2),(155,1,2,164,166,2),(156,1,1,165,167,2),(157,1,2,166,168,2),(158,1,1,167,169,2),(159,1,1,168,171,2),(160,1,1,169,173,2),(161,1,1,170,174,2),(162,1,1,171,175,2),(163,1,4,172,176,2),(164,1,6,173,177,2),(172,0.6240153276820994,34160,196,188,2),(173,0.048529823743410215,5000,196,11,2),(174,0.09202878250324714,64,196,186,2),(175,0.019772788270718523,5000,196,131,2),(176,0.09718502729949514,72,196,168,2),(177,0.02482520290959528,12,196,185,2),(178,0.09364304759143421,100,196,170,2),(179,0.09943181818181818,1,245,148,2),(180,0.7159090909090909,7,245,73,2),(181,0.1846590909090909,1,245,72,2),(182,1,5,246,170,2),(183,0.7575757575757576,5,247,70,2),(184,0.24242424242424243,1,247,77,2),(185,0.5652173913043478,2,248,74,2),(186,0.43478260869565216,1,248,75,2),(187,1,100,249,136,2),(188,1,610,250,118,2),(193,0.5783132530120482,30,253,113,2),(194,0.3614457831325301,500,253,11,2),(195,0.020080321285140562,10,253,137,2),(196,0.040160642570281124,200,253,136,2),(197,1,1,255,46,2),(198,1,1,256,77,2),(199,0.22099447513812154,5,290,179,2),(200,0.32044198895027626,3,290,62,2),(201,0.20994475138121546,3,290,59,2),(202,0.24861878453038674,5,290,58,2),(203,0.2962962962962963,6,310,52,2),(204,0.26666666666666666,3,310,61,2),(205,0.437037037037037,3,310,62,2),(206,0.1111111111111111,5,251,23,2),(207,0.8888888888888888,40,251,22,2),(208,1,1,323,74,2),(210,1,1,325,189,2),(211,1,1,332,190,2),(212,1,1,333,191,2),(213,1,1,337,192,2),(214,1,1,338,192,2),(215,1,5,324,179,2),(216,1,5,342,179,2),(227,0.008036431824270024,6,357,197,2),(228,0.07768550763461023,2,357,125,2),(229,0.13715510313420842,4,357,124,2),(230,0.04821859094562014,40,357,196,2),(231,0.12322528797214037,40,357,195,2),(232,0.12054647736405036,60,357,9,2),(233,0.031074203053844094,29,357,194,2),(234,0.06027323868202518,5,357,80,2),(235,0.32145727297080096,20,357,193,2),(236,0.07232788641843022,2,357,74,2),(237,1,1,365,192,2),(238,1,2,370,152,2),(239,1,2,376,198,2),(240,1,1,384,199,2),(241,1,1,385,200,2),(246,0.6835443037974683,2,396,203,2),(247,0.31645569620253167,1,396,77,2),(248,0.6439024390243903,6,394,202,2),(249,0.35609756097560974,1,394,201,2),(250,0.021739130434782608,1,418,200,2),(251,0.9782608695652174,1,418,199,2),(252,1,1,419,204,2),(253,1,1,420,75,2),(254,1,1,421,52,2),(255,1,1,422,52,2),(256,1,305,424,17,2),(257,1,1,425,91,2),(258,1,2,433,151,2),(259,1,1,446,91,2),(260,0.7746478873239436,1,451,205,2),(261,0.22535211267605634,8,451,196,2),(262,1,1,454,75,2),(263,0.06428571428571428,1,458,208,2),(264,0.21428571428571427,1,458,125,2),(265,0.10714285714285714,1,458,74,2),(266,0.21428571428571427,1,458,207,2),(267,0.4,7,458,206,2),(268,0.5526315789473685,5,464,75,2),(269,0.4263157894736842,6,464,74,2),(270,0.021052631578947368,1,464,80,2),(276,0.15757421974118246,10,466,209,2),(277,0.2283684344075108,10,466,47,2),(278,0.16493275818320224,2,466,53,2),(279,0.2283684344075108,5,466,61,2),(280,0.22075615326059378,3,466,62,2),(281,0.12804878048780488,3,469,153,2),(282,0.10975609756097561,3,469,104,2),(283,0.17682926829268292,5,469,152,2),(284,0.036585365853658534,2,469,151,2),(285,0.5487804878048781,5,469,91,2),(286,1,10,471,168,2),(287,0.3519061583577713,5,473,211,2),(288,0.21700879765395895,5,473,176,2),(289,0.21700879765395895,5,473,210,2),(290,0.21407624633431085,10,473,170,2),(291,1,1,475,167,2),(292,0.06250000000000001,1,476,42,2),(293,0.9375,9,476,51,2),(294,1,2,484,212,2),(295,1,1,492,213,2),(301,1,40,500,12,2),(302,0.43478260869565216,1,507,215,2),(303,0.5652173913043478,1,507,214,2),(309,0.2416306361951822,2,495,180,2),(310,0.19765287214329832,2,495,77,2),(311,0.2198888202594194,4,495,75,2),(312,0.16491661519456455,5,495,74,2),(313,0.17591105620753553,16,495,80,2),(315,0.8108108108108109,4,534,216,2),(316,0.1891891891891892,305,534,118,2),(317,0.11928429423459244,3,535,51,2),(318,0.15904572564612326,1,535,220,2),(319,0.049701789264413515,1,535,218,2),(320,0.2584493041749503,5,535,45,2),(321,0.4135188866799205,8,535,217,2),(322,1,1,537,85,2),(323,1,2,539,77,2),(324,1,610,533,17,2),(325,1,2,562,221,2),(330,1,5,575,45,2),(331,1,10,574,217,2),(332,0.6,300,576,15,2),(333,0.4,20,576,85,2);
/*!40000 ALTER TABLE `stockitemvaluedists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocklevels`
--

DROP TABLE IF EXISTS `stocklevels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocklevels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` double NOT NULL,
  `journalId` int(11) DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  `stockAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `stockItemId` (`stockItemId`),
  KEY `stockAccountId` (`stockAccountId`),
  CONSTRAINT `stocklevels_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stocklevels_ibfk_2` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stocklevels_ibfk_3` FOREIGN KEY (`stockAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1015 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocklevels`
--

LOCK TABLES `stocklevels` WRITE;
/*!40000 ALTER TABLE `stocklevels` DISABLE KEYS */;
INSERT INTO `stocklevels` VALUES (15,99,20,9,2),(16,1,21,10,2),(17,114,22,11,2),(18,25,23,12,2),(19,57,24,17,2),(21,610,26,13,2),(22,6259,27,15,2),(23,800,28,16,2),(24,10,29,18,2),(25,1,30,19,2),(26,3,31,20,2),(27,35,32,21,2),(28,11,33,22,2),(29,8,34,23,2),(30,6,35,24,2),(31,7,36,26,2),(32,2,37,27,2),(33,4,38,28,2),(34,1,39,29,2),(35,1,40,30,2),(36,1,41,31,2),(37,70,42,32,2),(38,16,43,33,2),(40,12,45,34,2),(41,1,46,35,2),(42,11,47,39,2),(43,7,48,40,2),(44,12,49,41,2),(45,1,50,178,2),(46,23,51,42,2),(47,9,52,43,2),(49,1,54,179,2),(50,10,53,44,2),(51,6,55,46,2),(52,3,56,47,2),(53,1,57,48,2),(54,5,58,51,2),(55,4,59,52,2),(56,3,60,53,2),(57,3,61,54,2),(58,3,62,55,2),(59,1,63,56,2),(60,1,64,57,2),(61,2,65,58,2),(63,2,67,60,2),(65,5,68,61,2),(66,2,69,62,2),(67,1,70,63,2),(68,2,71,64,2),(69,2,72,65,2),(70,4,73,66,2),(71,1,74,67,2),(72,3,75,68,2),(73,13,76,69,2),(74,5,77,71,2),(75,5,78,74,2),(76,1,79,75,2),(77,1,80,77,2),(78,1,81,180,2),(79,11,82,80,2),(80,23,83,81,2),(81,26,84,82,2),(82,85,85,83,2),(83,11,86,88,2),(84,2,87,182,2),(85,5,88,89,2),(86,7,89,90,2),(87,2,90,91,2),(88,15,91,84,2),(89,3,92,85,2),(90,10,93,86,2),(91,11,94,87,2),(92,4,95,94,2),(93,3,96,95,2),(94,2,97,100,2),(95,3,98,183,2),(96,2,99,93,2),(97,2,100,92,2),(98,5,101,101,2),(99,1,102,102,2),(100,1,103,103,2),(101,1,104,106,2),(102,3,105,104,2),(103,3,106,105,2),(104,3,107,107,2),(105,1,108,108,2),(106,3,109,109,2),(107,1,110,110,2),(108,1,111,112,2),(109,3,112,113,2),(110,1,113,114,2),(111,10,114,115,2),(112,18,115,116,2),(113,57,116,117,2),(114,315,117,118,2),(115,305,118,119,2),(116,1,119,120,2),(117,2,120,121,2),(118,2,121,122,2),(119,4,122,123,2),(120,2,123,124,2),(121,1,124,125,2),(122,2,125,126,2),(123,2,126,127,2),(124,1,127,128,2),(125,1,128,129,2),(126,86,129,130,2),(127,332,130,131,2),(128,7,131,132,2),(129,3,132,133,2),(130,1,133,134,2),(131,200,134,135,2),(132,109,135,136,2),(133,10,136,137,2),(134,2,137,138,2),(135,8,138,139,2),(136,1,139,140,2),(137,1,140,141,2),(138,13,141,142,2),(139,1,142,143,2),(140,3,143,144,2),(141,1,144,145,2),(142,3,145,146,2),(144,2,147,147,2),(145,2,146,148,2),(146,6,148,149,2),(148,2,150,151,2),(150,2,152,153,2),(151,1,153,154,2),(152,5,154,155,2),(153,3,155,156,2),(154,2,156,157,2),(155,1,157,158,2),(156,1,158,159,2),(157,16,159,160,2),(158,2,160,161,2),(159,4,161,163,2),(160,6,162,164,2),(161,12,163,184,2),(162,2,164,166,2),(163,1,165,167,2),(164,2,166,168,2),(165,1,167,169,2),(166,1,168,171,2),(167,1,169,173,2),(168,1,170,174,2),(169,1,171,175,2),(170,4,172,176,2),(171,6,173,177,2),(179,3,44,36,2),(180,34160,196,188,10),(181,5000,196,11,10),(182,64,196,186,10),(183,5000,196,131,10),(184,72,196,168,10),(185,12,196,185,10),(186,100,196,170,10),(187,7,149,150,2),(225,-1,241,9,2),(226,-1,241,125,2),(227,-34,240,15,2),(228,-4,240,131,2),(229,-8,240,11,2),(230,-1,240,74,2),(231,-1,240,61,2),(232,-3,240,41,2),(233,-1,240,22,2),(234,-19,239,11,2),(235,-1,239,74,2),(236,-1,239,53,2),(237,-1,239,11,2),(238,-2,238,11,2),(239,-1,238,131,2),(240,-16,238,15,2),(241,-1,238,42,2),(242,-1,237,80,2),(243,-14,237,118,2),(244,-2,237,136,2),(245,-1,237,62,2),(246,-1,236,176,2),(247,-1,242,151,2),(252,-2,243,9,2),(253,-6,243,131,2),(254,-12,243,12,2),(255,-6,243,46,2),(256,-1,244,51,2),(257,-1,244,116,2),(258,-281,244,15,2),(259,-5,244,131,2),(260,-15,244,11,2),(261,1,245,148,2),(262,7,245,73,2),(263,1,245,72,2),(264,5,246,170,2),(265,5,247,70,2),(266,1,247,77,2),(267,2,248,74,2),(268,1,248,75,2),(269,100,249,136,2),(270,610,250,118,2),(275,30,253,113,2),(276,500,253,11,2),(277,10,253,137,2),(278,200,253,136,2),(279,1,255,46,2),(280,1,256,77,2),(281,-1,257,148,2),(282,-1,257,113,2),(283,-1,257,85,2),(284,-21,257,136,2),(285,-1,257,77,2),(286,-7,257,73,2),(287,-1,257,72,2),(288,-25,258,118,2),(289,-7,258,136,2),(295,-2,259,9,2),(296,-1,260,39,2),(297,-1,261,9,2),(298,-1,261,121,2),(299,-1,261,11,2),(300,-1,261,70,2),(301,-1,261,82,2),(302,-1,261,42,2),(303,-1,261,113,2),(304,-6,261,15,2),(305,-1,261,131,2),(306,-2,261,11,2),(307,-1,261,52,2),(308,-1,261,59,2),(309,-1,262,80,2),(310,-22,262,15,2),(311,-1,262,9,2),(312,-3,262,131,2),(313,-1,262,85,2),(314,-1,262,59,2),(315,-2,262,44,2),(316,-7,262,11,2),(317,-2,263,168,2),(318,-10,264,12,2),(319,-27,264,15,2),(320,-1,264,80,2),(321,-1,264,113,2),(322,-1,264,80,2),(323,-1,264,74,2),(324,-1,264,9,2),(325,-13,264,131,2),(326,-16,264,11,2),(327,-1,264,42,2),(328,-15,264,15,2),(329,-1,264,150,2),(330,-3,265,21,2),(331,-3,265,40,2),(333,-2,266,131,2),(334,-3,266,12,2),(335,-1,266,39,2),(336,-1,266,21,2),(337,-1,266,59,2),(338,5,290,179,2),(339,3,290,62,2),(340,3,290,59,2),(341,5,290,58,2),(342,3,66,59,2),(343,-2,292,9,2),(344,-2,292,11,2),(345,-1,292,39,2),(346,-2,293,82,2),(347,-1,293,103,2),(348,-2,293,148,2),(349,-2,293,147,2),(350,-91,293,136,2),(351,-305,293,119,2),(352,-420,293,118,2),(353,-1,298,139,2),(354,-300,303,15,2),(355,-4,303,81,2),(356,-1,303,75,2),(357,-2,303,21,2),(358,-4,303,44,2),(359,-1,303,62,2),(365,-1,305,138,2),(366,-1,306,128,2),(367,-20,307,118,2),(368,-5,308,131,2),(369,-10,308,11,2),(371,6,310,52,2),(372,3,310,61,2),(373,3,310,62,2),(374,5,251,23,2),(375,40,251,22,2),(376,-2,313,70,2),(377,-2,313,74,2),(378,-144,314,16,2),(379,-1,314,81,2),(380,-2,314,131,2),(381,-2,321,170,2),(382,1,323,74,2),(384,1,325,189,2),(385,-1,326,113,2),(386,-1,326,9,2),(387,-3,326,131,2),(388,-2,326,11,2),(389,-1,326,43,2),(390,-1,326,21,2),(391,1,332,190,2),(392,1,333,191,2),(393,-4,334,11,2),(394,-1,334,21,2),(395,-169,334,118,2),(396,-22,334,136,2),(397,-1,334,191,2),(401,-59,336,15,2),(402,-1,336,9,2),(403,-7,336,131,2),(404,-14,336,11,2),(405,-2,336,21,2),(406,-1,335,9,2),(407,-1,335,61,2),(408,-1,335,21,2),(409,-1,335,131,2),(410,-17,335,15,2),(411,-8,335,11,2),(412,-1,335,81,2),(413,-2,335,136,2),(414,-6,335,118,2),(415,1,337,192,2),(416,1,338,192,2),(417,-1,339,190,2),(418,-61,339,15,2),(419,-1,339,81,2),(420,-1,339,9,2),(421,-6,339,131,2),(422,-12,339,11,2),(423,-1,339,189,2),(424,-1,339,48,2),(425,-1,339,62,2),(426,-5,339,179,2),(427,-60,340,15,2),(428,-1,340,83,2),(429,-3,340,32,2),(430,-1,340,113,2),(431,-3,340,131,2),(432,-6,340,11,2),(433,-1,340,74,2),(434,-3,340,21,2),(435,-1,340,192,2),(436,5,324,179,2),(437,5,342,179,2),(438,-1,343,137,2),(445,-1,344,81,2),(446,-40,344,15,2),(447,-4,344,131,2),(448,-8,344,11,2),(449,-1,344,62,2),(450,-3,344,179,2),(451,-1,304,58,2),(452,-70,304,15,2),(453,-6,304,131,2),(454,-6,304,11,2),(455,-2,304,40,2),(456,-31,352,15,2),(457,-1,352,81,2),(458,-1,352,131,2),(459,-2,352,11,2),(460,-1,352,9,2),(461,-1,352,80,2),(462,-1,352,21,2),(463,-2,353,136,2),(464,-8,353,118,2),(475,6,357,197,2),(476,2,357,125,2),(477,4,357,124,2),(478,40,357,196,2),(479,40,357,195,2),(480,60,357,9,2),(481,29,357,194,2),(482,5,357,80,2),(483,20,357,193,2),(484,2,357,74,2),(485,-1,360,176,2),(486,-1,360,131,2),(487,-2,360,11,2),(488,-1,360,9,2),(489,-1,360,9,2),(492,-2,362,11,2),(493,-1,362,179,2),(494,-27,364,15,2),(495,-1,364,131,2),(496,-2,364,11,2),(497,-1,364,22,2),(498,-1,364,61,2),(499,1,365,192,2),(501,-3,367,131,2),(502,-30,368,16,2),(503,-1,369,87,2),(504,-2,369,142,2),(505,2,370,152,2),(506,-2,371,11,2),(507,-1,374,179,2),(508,-6,375,52,2),(509,2,376,198,2),(510,-1,377,152,2),(511,-1,377,80,2),(512,-240,377,15,2),(513,-2,377,9,2),(514,-8,377,131,2),(515,-16,377,11,2),(516,-1,377,89,2),(517,-1,377,61,2),(518,-8,377,21,2),(519,-18,378,15,2),(520,-1,378,131,2),(521,-2,378,11,2),(522,-1,378,142,2),(523,-1,378,46,2),(524,-2,379,131,2),(525,-3,379,11,2),(526,-1,379,23,2),(527,-4,380,131,2),(528,-7,380,11,2),(529,-37,380,15,2),(530,-2,380,33,2),(559,1,384,199,2),(573,1,385,200,2),(574,-1,383,200,2),(575,-1,383,199,2),(576,-1,383,149,2),(577,-1,383,113,2),(578,-51,383,15,2),(579,-2,383,9,2),(580,-1,383,84,2),(581,-6,383,131,2),(582,-12,383,11,2),(583,-1,383,62,2),(584,-1,383,74,2),(585,-1,383,52,2),(586,-2,383,51,2),(587,-3,383,47,2),(588,-1,389,59,2),(589,-1,389,80,2),(590,-1,389,123,2),(591,-3,390,80,2),(592,-1,390,170,2),(593,-15,382,15,2),(594,-1,382,131,2),(595,-2,382,11,2),(596,-1,382,21,2),(597,-1,382,131,2),(598,-33,382,15,2),(599,-4,382,136,2),(600,-23,382,118,2),(601,-6,382,136,2),(602,-2,382,21,2),(603,-1,382,113,2),(604,-1,382,62,2),(605,-1,382,52,2),(606,-10,382,11,2),(607,-2,382,9,2),(608,-4,382,82,2),(614,2,396,203,2),(615,1,396,77,2),(616,6,394,202,2),(617,1,394,201,2),(618,-1,399,32,2),(619,-21,399,118,2),(620,-115,399,15,2),(621,-1,399,152,2),(622,-1,399,88,2),(623,-8,399,131,2),(624,-16,399,11,2),(625,-2,399,9,2),(626,-1,399,203,2),(627,-1,399,21,2),(628,-1,399,201,2),(629,-6,399,202,2),(630,-25,400,15,2),(631,-2,400,131,2),(632,-4,400,11,2),(633,-1,400,9,2),(634,-1,400,42,2),(635,-1,400,21,2),(636,-1,400,61,2),(637,-149,401,15,2),(638,-1,401,84,2),(639,-1,401,80,2),(640,-1,401,9,2),(641,-3,401,131,2),(642,-6,401,11,2),(643,-1,401,39,2),(644,-2,401,21,2),(645,-1,401,192,2),(652,-16,402,16,2),(653,-2,402,142,2),(654,-21,402,15,2),(655,-1,402,32,2),(656,-1,402,61,2),(657,-1,402,203,2),(658,-1,404,83,2),(659,-2,404,82,2),(660,-1,404,104,2),(661,-1,405,170,2),(662,-30,406,15,2),(663,-2,406,131,2),(664,-2,406,11,2),(665,-1,407,180,2),(667,-2,413,194,2),(668,-2,413,176,2),(669,-1,415,139,2),(670,-20,416,136,2),(671,-6,417,136,2),(672,1,418,200,2),(673,1,418,199,2),(674,1,419,204,2),(675,1,420,75,2),(676,1,421,52,2),(677,1,422,52,2),(678,-1,423,179,2),(679,-1,423,150,2),(680,-1,423,204,2),(681,-30,423,118,2),(682,-101,423,15,2),(683,-1,423,91,2),(684,-2,423,136,2),(685,-1,423,200,2),(686,-1,423,199,2),(687,-1,423,9,2),(688,-4,423,131,2),(689,-8,423,11,2),(690,-1,423,75,2),(691,-1,423,62,2),(692,-3,423,52,2),(693,305,424,17,2),(694,1,425,91,2),(695,-18,426,15,2),(696,-1,427,82,2),(697,-1,427,104,2),(698,-1,427,90,2),(699,-59,427,15,2),(700,-1,427,22,2),(701,-5,427,131,2),(702,-10,427,11,2),(703,-1,430,124,2),(704,-1,431,177,2),(705,-1,432,9,2),(706,-1,432,131,2),(707,-3,432,11,2),(708,-1,432,88,2),(709,-14,432,15,2),(710,-1,432,113,2),(711,-1,432,153,2),(712,-2,432,136,2),(713,-16,432,118,2),(714,2,433,151,2),(722,-1,434,85,2),(723,-169,434,15,2),(724,-2,434,151,2),(725,-11,434,131,2),(726,-25,434,11,2),(727,-2,434,9,2),(728,-3,434,179,2),(729,-1,442,74,2),(730,-1,444,9,2),(731,-1,444,22,2),(732,-305,444,17,2),(733,-10,444,11,2),(734,-110,444,15,2),(735,-2,444,42,2),(736,-1,446,91,2),(737,-20,450,11,2),(738,1,451,205,2),(739,8,451,196,2),(740,1,454,75,2),(742,-1,455,75,2),(743,-1,457,23,2),(744,1,458,208,2),(745,1,458,125,2),(746,1,458,74,2),(747,1,458,207,2),(748,7,458,206,2),(749,-1,461,170,2),(750,-1,462,116,2),(751,-1,463,151,2),(752,-1,463,113,2),(753,5,464,75,2),(754,6,464,74,2),(755,1,464,80,2),(765,10,466,209,2),(766,10,466,47,2),(767,2,466,53,2),(768,5,466,61,2),(769,3,466,62,2),(770,-2,465,75,2),(771,-2,465,74,2),(772,3,469,153,2),(773,3,469,104,2),(774,5,469,152,2),(775,2,469,151,2),(776,5,469,91,2),(777,10,471,168,2),(778,5,473,211,2),(779,5,473,176,2),(780,5,473,210,2),(781,10,473,170,2),(782,-1,475,167,2),(783,1,476,42,2),(784,9,476,51,2),(785,-1,477,131,2),(786,-2,477,136,2),(787,-1,477,210,2),(788,-1,477,9,2),(789,-1,479,104,2),(790,-1,481,57,2),(791,-1,483,170,2),(792,2,484,212,2),(793,-1,485,211,2),(794,-1,491,9,2),(795,-40,491,15,2),(796,-6,491,131,2),(797,-12,491,11,2),(798,-1,491,21,2),(799,-1,491,74,2),(800,-3,491,11,2),(801,1,492,213,2),(802,-1,493,213,2),(803,-1,493,212,2),(804,-4,493,136,2),(805,-2,493,118,2),(806,-1,493,42,2),(807,-1,493,62,2),(808,-2,493,9,2),(809,-1,493,131,2),(810,-4,493,11,2),(816,40,500,12,2),(817,-10,501,209,2),(818,-40,501,12,2),(819,-1,502,83,2),(820,-1,502,104,2),(831,1,507,215,2),(832,1,507,214,2),(834,-1,514,170,2),(840,2,495,180,2),(841,2,495,77,2),(842,4,495,75,2),(843,5,495,74,2),(844,16,495,80,2),(845,-1,520,170,2),(846,-3,522,75,2),(847,-1,525,11,2),(848,-1,525,9,2),(850,-1,530,170,2),(851,-20,527,11,2),(852,-200,527,16,2),(853,-1,532,116,2),(855,4,534,216,2),(856,305,534,118,2),(857,3,535,51,2),(858,1,535,220,2),(859,1,535,218,2),(860,5,535,45,2),(861,8,535,217,2),(862,1,537,85,2),(871,2,539,77,2),(872,-4,540,136,2),(873,-1,540,160,2),(874,-18,540,16,2),(875,-2,540,131,2),(876,-1,540,11,2),(897,-1,503,113,2),(898,-2,503,42,2),(899,-349,503,15,2),(900,-4,503,9,2),(901,-20,503,131,2),(902,-40,503,11,2),(903,-1,503,205,2),(904,-1,503,43,2),(905,-8,503,22,2),(906,-1,503,53,2),(915,-1,544,180,2),(932,-8,538,136,2),(933,-16,538,118,2),(934,-1,538,149,2),(935,-1,538,113,2),(936,-1,538,85,2),(937,-1,538,218,2),(938,-4,538,216,2),(939,-1,538,220,2),(940,610,533,17,2),(941,1,551,83,2),(942,1,551,104,2),(943,-3,552,22,2),(944,-1,552,136,2),(945,-1,552,74,2),(946,-1,552,113,2),(947,-1,552,149,2),(948,-1,552,87,2),(949,-1,552,122,2),(950,-1,552,80,2),(951,-1,552,192,2),(952,-2,552,41,2),(953,-2,552,22,2),(954,-4,552,9,2),(955,-10,552,131,2),(956,-17,552,136,2),(957,-100,552,118,2),(958,-158,552,15,2),(959,-19,552,11,2),(960,-1,558,176,2),(961,-1,559,74,2),(962,-1,560,88,2),(963,-1,561,75,2),(964,2,562,221,2),(965,-1,563,69,2),(966,-1,564,168,2),(967,-1,565,9,2),(968,-2,565,221,2),(969,-1,565,11,2),(970,-1,566,149,2),(971,-1,567,80,2),(972,-2,567,11,2),(973,-1,567,86,2),(974,-64,568,15,2),(975,-1,568,70,2),(976,-1,568,74,2),(977,-1,568,83,2),(978,-7,568,131,2),(979,-12,568,11,2),(980,-2,568,9,2),(981,-2,568,33,2),(982,-4,568,206,2),(983,-1,570,170,2),(988,5,575,45,2),(989,10,574,217,2),(990,300,576,15,2),(991,20,576,85,2),(1003,-1,582,20,2),(1004,-677,582,15,2),(1005,-11,582,131,2),(1006,-22,582,11,2),(1007,-5,582,9,2),(1008,-1,582,152,2),(1009,-1,582,88,2),(1010,-1,582,77,2),(1011,-1,582,55,2),(1012,-2,582,45,2),(1013,-8,582,217,2),(1014,-1,583,176,2);
/*!40000 ALTER TABLE `stocklevels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocklosses`
--

DROP TABLE IF EXISTS `stocklosses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocklosses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` double NOT NULL,
  `baseQuantity` double NOT NULL,
  `unit` varchar(255) NOT NULL,
  `journalId` int(11) DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  `stockAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `stockItemId` (`stockItemId`),
  KEY `stockAccountId` (`stockAccountId`),
  CONSTRAINT `stocklosses_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stocklosses_ibfk_2` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stocklosses_ibfk_3` FOREIGN KEY (`stockAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocklosses`
--

LOCK TABLES `stocklosses` WRITE;
/*!40000 ALTER TABLE `stocklosses` DISABLE KEYS */;
/*!40000 ALTER TABLE `stocklosses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockpossaleitems`
--

DROP TABLE IF EXISTS `stockpossaleitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockpossaleitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` double NOT NULL,
  `baseQuantity` double NOT NULL,
  `unit` varchar(255) NOT NULL,
  `unitPriceAmount` double NOT NULL,
  `unitPriceCode` char(3) NOT NULL,
  `baseUnitPriceAmount` double NOT NULL,
  `baseUnitPriceCode` char(3) NOT NULL,
  `discountAmount` double NOT NULL,
  `discountCode` char(3) NOT NULL,
  `baseDiscountAmount` double NOT NULL,
  `baseDiscountCode` char(3) NOT NULL,
  `stockPOSSaleId` int(11) DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stockPOSSaleId` (`stockPOSSaleId`),
  KEY `stockItemId` (`stockItemId`),
  CONSTRAINT `stockpossaleitems_ibfk_1` FOREIGN KEY (`stockPOSSaleId`) REFERENCES `stockpossales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stockpossaleitems_ibfk_2` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockpossaleitems`
--

LOCK TABLES `stockpossaleitems` WRITE;
/*!40000 ALTER TABLE `stockpossaleitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `stockpossaleitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockpossales`
--

DROP TABLE IF EXISTS `stockpossales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockpossales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer` varchar(255) NOT NULL,
  `isReturn` tinyint(1) NOT NULL,
  `totalAmount` double NOT NULL,
  `totalCode` char(3) NOT NULL,
  `baseTotalAmount` double NOT NULL,
  `baseTotalCode` char(3) NOT NULL,
  `discountAmount` double DEFAULT NULL,
  `discountCode` char(3) DEFAULT NULL,
  `partialPaymentAmount` double DEFAULT NULL,
  `partialPaymentCode` char(3) DEFAULT NULL,
  `journalId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  `stockAccountId` int(11) DEFAULT NULL,
  `partialPaymentAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `cashAccountId` (`cashAccountId`),
  KEY `stockAccountId` (`stockAccountId`),
  KEY `partialPaymentAccountId` (`partialPaymentAccountId`),
  KEY `stock_p_o_s_sales_is_return` (`isReturn`),
  CONSTRAINT `stockpossales_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stockpossales_ibfk_2` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stockpossales_ibfk_3` FOREIGN KEY (`stockAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stockpossales_ibfk_4` FOREIGN KEY (`partialPaymentAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockpossales`
--

LOCK TABLES `stockpossales` WRITE;
/*!40000 ALTER TABLE `stockpossales` DISABLE KEYS */;
/*!40000 ALTER TABLE `stockpossales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockpurchasebillcosts`
--

DROP TABLE IF EXISTS `stockpurchasebillcosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockpurchasebillcosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `stockPurchaseId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stockPurchaseId` (`stockPurchaseId`),
  KEY `cashAccountId` (`cashAccountId`),
  CONSTRAINT `stockpurchasebillcosts_ibfk_1` FOREIGN KEY (`stockPurchaseId`) REFERENCES `stockpurchases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stockpurchasebillcosts_ibfk_2` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockpurchasebillcosts`
--

LOCK TABLES `stockpurchasebillcosts` WRITE;
/*!40000 ALTER TABLE `stockpurchasebillcosts` DISABLE KEYS */;
INSERT INTO `stockpurchasebillcosts` VALUES (5,'costsOnUs','کابل ټرانسپورټ مصارف',350,'AFN',350,'AFN',11,1),(6,'costsOnUs','کابل ټرانسپورټ مصارف',200,'AFN',200,'AFN',14,1),(7,'costsOnUs','کابل ټرانسپورټ مصارف',400,'AFN',400,'AFN',15,1),(8,'costsOnUs','کابل ټرانسپورټ مصارف',500,'AFN',500,'AFN',10,1),(10,'costsOnUs','بولدک ټرانسپورټ مصارف',1160,'AFN',1160,'AFN',23,1),(11,'costsOnUs','کابل ټرانسپورټ مصارف',350,'AFN',350,'AFN',44,1),(12,'costsOnUs','کابل ټرانسپورټ مصارف',300,'AFN',300,'AFN',45,1),(13,'costsOnUs','کابل ټرانسپورټ مصارف',50,'AFN',50,'AFN',46,1),(14,'costsOnUs','کابل ټرانسپورټ مصارف',300,'AFN',300,'AFN',47,1),(16,'costsOnUs','بولدک ټرانسپورټ مصارف',1030,'AFN',1030,'AFN',54,1),(18,'costsOnUs','بولدک ټرانسپورټ مصارف',100,'AFN',100,'AFN',52,1),(19,'costsOnUs','کابل ټرانسپورټ مصارف',500,'AFN',500,'AFN',57,1),(21,'costsOnUs','کابل ټرانسپورټ مصارف',100,'AFN',100,'AFN',62,1),(22,'costsOnUs','کابل ټرانسپورټ مصارف',100,'AFN',100,'AFN',61,1),(23,'costsOnUs','کابل ټرانسپورټ مصارف',300,'AFN',300,'AFN',63,1);
/*!40000 ALTER TABLE `stockpurchasebillcosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockpurchasecloses`
--

DROP TABLE IF EXISTS `stockpurchasecloses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockpurchasecloses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journalId` int(11) DEFAULT NULL,
  `stockPurchaseId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `stockPurchaseId` (`stockPurchaseId`),
  CONSTRAINT `stockpurchasecloses_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stockpurchasecloses_ibfk_2` FOREIGN KEY (`stockPurchaseId`) REFERENCES `stockpurchases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockpurchasecloses`
--

LOCK TABLES `stockpurchasecloses` WRITE;
/*!40000 ALTER TABLE `stockpurchasecloses` DISABLE KEYS */;
/*!40000 ALTER TABLE `stockpurchasecloses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockpurchasecosts`
--

DROP TABLE IF EXISTS `stockpurchasecosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockpurchasecosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `journalId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `cashAccountId` (`cashAccountId`),
  CONSTRAINT `stockpurchasecosts_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stockpurchasecosts_ibfk_2` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockpurchasecosts`
--

LOCK TABLES `stockpurchasecosts` WRITE;
/*!40000 ALTER TABLE `stockpurchasecosts` DISABLE KEYS */;
INSERT INTO `stockpurchasecosts` VALUES (1,203000,'AFN',203000,'AFN',197,1);
/*!40000 ALTER TABLE `stockpurchasecosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockpurchaseitems`
--

DROP TABLE IF EXISTS `stockpurchaseitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockpurchaseitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit` varchar(255) NOT NULL,
  `quantity` double NOT NULL,
  `baseQuantity` double NOT NULL,
  `unitPriceAmount` double NOT NULL,
  `unitPriceCode` char(3) NOT NULL,
  `unitSalePriceAmount` double NOT NULL,
  `unitSalePriceCode` char(3) NOT NULL,
  `baseUnitPriceAmount` double NOT NULL,
  `baseUnitPriceCode` char(3) NOT NULL,
  `expiryDate` date DEFAULT NULL,
  `daysBefore` int(11) DEFAULT NULL,
  `stockPurchaseId` int(11) DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  `stockAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stockPurchaseId` (`stockPurchaseId`),
  KEY `stockItemId` (`stockItemId`),
  KEY `stockAccountId` (`stockAccountId`),
  CONSTRAINT `stockpurchaseitems_ibfk_1` FOREIGN KEY (`stockPurchaseId`) REFERENCES `stockpurchases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stockpurchaseitems_ibfk_2` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stockpurchaseitems_ibfk_3` FOREIGN KEY (`stockAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockpurchaseitems`
--

LOCK TABLES `stockpurchaseitems` WRITE;
/*!40000 ALTER TABLE `stockpurchaseitems` DISABLE KEYS */;
INSERT INTO `stockpurchaseitems` VALUES (14,'بنډل',112,34160,2844,'AFN',6100,'AFN',2844,'AFN',NULL,NULL,3,188,2),(15,'کارتن',2,5000,12386,'AFN',30000,'AFN',12386,'AFN',NULL,NULL,3,11,2),(16,'دانه',64,64,734,'AFN',1600,'AFN',734,'AFN',NULL,NULL,3,186,2),(17,'کارتن',1,5000,10093,'AFN',75000,'AFN',10093,'AFN',NULL,NULL,3,131,2),(18,'دانه',72,72,689,'AFN',1500,'AFN',689,'AFN',NULL,NULL,3,168,2),(19,'دانه',12,12,1056,'AFN',2000,'AFN',1056,'AFN',NULL,NULL,3,185,2),(20,'دانه',100,100,478,'AFN',1200,'AFN',478,'AFN',NULL,NULL,3,170,2),(21,'دانه',1,1,3500,'AFN',4500,'AFN',3500,'AFN',NULL,NULL,4,148,2),(22,'دانه',7,7,3600,'AFN',4000,'AFN',3600,'AFN',NULL,NULL,4,73,2),(23,'دانه',1,1,6500,'AFN',7300,'AFN',6500,'AFN',NULL,NULL,4,72,2),(24,'دانه',5,5,750,'AFN',1200,'AFN',750,'AFN',NULL,NULL,5,170,2),(25,'دانه',5,5,2000,'AFN',3000,'AFN',2000,'AFN',NULL,NULL,6,70,2),(26,'دانه',1,1,3200,'AFN',3500,'AFN',3200,'AFN',NULL,NULL,6,77,2),(27,'دانه',2,2,1300,'AFN',1500,'AFN',1300,'AFN',NULL,NULL,7,74,2),(28,'دانه',1,1,2000,'AFN',2500,'AFN',2000,'AFN',NULL,NULL,7,75,2),(29,'دانه',100,100,4,'AFN',5,'AFN',4,'AFN',NULL,NULL,8,136,2),(30,'بنډل',2,610,70,'USD',5000,'AFN',4536,'AFN',NULL,NULL,9,118,2),(35,'دانه',30,30,240,'AFN',300,'AFN',240,'AFN',NULL,NULL,11,113,2),(36,'کوتۍ',5,500,900,'AFN',1500,'AFN',900,'AFN',NULL,NULL,11,11,2),(37,'دانه',10,10,25,'AFN',50,'AFN',25,'AFN',NULL,NULL,11,137,2),(38,'بسته',2,200,250,'AFN',400,'AFN',250,'AFN',NULL,NULL,11,136,2),(39,'دانه',1,1,20,'USD',1800,'AFN',1296,'AFN',NULL,NULL,12,46,2),(40,'دانه',1,1,3100,'AFN',3500,'AFN',3100,'AFN',NULL,NULL,13,77,2),(41,'دانه',5,5,24,'USD',1800,'AFN',1560,'AFN',NULL,NULL,14,179,2),(42,'دانه',3,3,58,'USD',5000,'AFN',3770,'AFN',NULL,NULL,14,62,2),(43,'دانه',3,3,38,'USD',4000,'AFN',2470,'AFN',NULL,NULL,14,59,2),(44,'دانه',5,5,27,'USD',3000,'AFN',1755,'AFN',NULL,NULL,14,58,2),(45,'دانه',6,6,20,'USD',1700,'AFN',1301,'AFN',NULL,NULL,15,52,2),(46,'دانه',3,3,36,'USD',3700,'AFN',2341.7999999999997,'AFN',NULL,NULL,15,61,2),(47,'دانه',3,3,59,'USD',5000,'AFN',3837.95,'AFN',NULL,NULL,15,62,2),(48,'دانه',5,5,14,'USD',1151,'AFN',910.6999999999999,'AFN',NULL,NULL,10,23,2),(49,'دانه',40,40,14,'USD',1400,'AFN',910.6999999999999,'AFN',NULL,NULL,10,22,2),(50,'دانه',1,1,1300,'AFN',1500,'AFN',1300,'AFN',NULL,NULL,16,74,2),(52,'دانه',1,1,14500,'AFN',15000,'AFN',14500,'AFN',NULL,NULL,18,189,2),(53,'دانه',1,1,600,'AFN',700,'AFN',600,'AFN',NULL,NULL,19,190,2),(54,'دانه',1,1,1500,'AFN',0,'AFN',1500,'AFN',NULL,NULL,20,192,2),(55,'دانه',1,1,2200,'AFN',3200,'AFN',2200,'AFN',NULL,NULL,21,192,2),(56,'دانه',5,5,26,'USD',1800,'AFN',1690,'AFN',NULL,NULL,17,179,2),(57,'دانه',5,5,26,'USD',1800,'AFN',1690,'AFN',NULL,NULL,22,179,2),(68,'دانه',6,6,50,'AFN',400,'AFN',50,'AFN',NULL,NULL,23,197,2),(69,'دانه',2,2,1450,'AFN',2500,'AFN',1450,'AFN',NULL,NULL,23,125,2),(70,'دانه',4,4,1280,'AFN',2000,'AFN',1280,'AFN',NULL,NULL,23,124,2),(71,'دانه',40,40,45,'AFN',80,'AFN',45,'AFN',NULL,NULL,23,196,2),(72,'دانه',40,40,115,'AFN',350,'AFN',115,'AFN',NULL,NULL,23,195,2),(73,'دانه',60,60,75,'AFN',300,'AFN',75,'AFN',NULL,NULL,23,9,2),(74,'دانه',29,29,40,'AFN',200,'AFN',40,'AFN',NULL,NULL,23,194,2),(75,'دانه',5,5,450,'AFN',800,'AFN',450,'AFN',NULL,NULL,23,80,2),(76,'دانه',20,20,600,'AFN',800,'AFN',600,'AFN',NULL,NULL,23,193,2),(77,'دانه',2,2,1350,'AFN',1800,'AFN',1350,'AFN',NULL,NULL,23,74,2),(78,'دانه',1,1,1500,'AFN',3200,'AFN',1500,'AFN',NULL,NULL,24,192,2),(79,'دانه',2,2,400,'AFN',500,'AFN',400,'AFN',NULL,NULL,25,152,2),(80,'دانه',2,2,525,'AFN',2000,'AFN',525,'AFN',NULL,NULL,26,198,2),(81,'دانه',1,1,9000,'AFN',9500,'AFN',9000,'AFN',NULL,NULL,27,199,2),(82,'دانه',1,1,350,'AFN',450,'AFN',350,'AFN',NULL,NULL,28,200,2),(87,'دانه',2,2,2700,'AFN',4000,'AFN',2700,'AFN',NULL,NULL,30,203,2),(88,'دانه',1,1,2500,'AFN',3500,'AFN',2500,'AFN',NULL,NULL,30,77,2),(89,'دانه',6,6,2200,'AFN',3000,'AFN',2200,'AFN',NULL,NULL,29,202,2),(90,'دانه',1,1,7300,'AFN',9000,'AFN',7300,'AFN',NULL,NULL,29,201,2),(91,'دانه',1,1,200,'AFN',450,'AFN',200,'AFN',NULL,NULL,31,200,2),(92,'دانه',1,1,9000,'AFN',9500,'AFN',9000,'AFN',NULL,NULL,31,199,2),(93,'دانه',1,1,50,'USD',5000,'AFN',3246.5000000000005,'AFN',NULL,NULL,32,204,2),(94,'دانه',1,1,2800,'AFN',3000,'AFN',2800,'AFN',NULL,NULL,33,75,2),(95,'دانه',1,1,1300,'AFN',1700,'AFN',1300,'AFN',NULL,NULL,34,52,2),(96,'دانه',1,1,1500,'AFN',1700,'AFN',1500,'AFN',NULL,NULL,35,52,2),(97,'متر',305,305,21,'AFN',25,'AFN',21,'AFN',NULL,NULL,36,17,2),(98,'دانه',1,1,1100,'AFN',1650,'AFN',1100,'AFN',NULL,NULL,37,91,2),(99,'دانه',2,2,154,'AFN',300,'AFN',154,'AFN',NULL,NULL,38,151,2),(100,'دانه',1,1,1100,'AFN',1650,'AFN',1100,'AFN',NULL,NULL,39,91,2),(101,'دانه',1,1,1650,'AFN',0,'AFN',1650,'AFN',NULL,NULL,40,205,2),(102,'دانه',8,8,60,'AFN',80,'AFN',60,'AFN',NULL,NULL,40,196,2),(103,'دانه',1,1,2800,'AFN',3000,'AFN',2800,'AFN',NULL,NULL,41,75,2),(104,'دانه',1,1,450,'AFN',1000,'AFN',450,'AFN',NULL,NULL,42,208,2),(105,'دانه',1,1,1500,'AFN',2500,'AFN',1500,'AFN',NULL,NULL,42,125,2),(106,'دانه',1,1,750,'AFN',1800,'AFN',750,'AFN',NULL,NULL,42,74,2),(107,'دانه',1,1,1500,'AFN',3000,'AFN',1500,'AFN',NULL,NULL,42,207,2),(108,'دانه',7,7,400,'AFN',800,'AFN',400,'AFN',NULL,NULL,42,206,2),(109,'دانه',5,5,2100,'AFN',3000,'AFN',2100,'AFN',NULL,NULL,43,75,2),(110,'دانه',6,6,1350,'AFN',1800,'AFN',1350,'AFN',NULL,NULL,43,74,2),(111,'دانه',1,1,400,'AFN',800,'AFN',400,'AFN',NULL,NULL,43,80,2),(117,'دانه',10,10,12.42,'USD',900,'AFN',799.8480000000001,'AFN',NULL,NULL,44,209,2),(118,'دانه',10,10,18,'USD',1500,'AFN',1159.2,'AFN',NULL,NULL,44,47,2),(119,'دانه',2,2,65,'USD',5500,'AFN',4186,'AFN',NULL,NULL,44,53,2),(120,'دانه',5,5,36,'USD',3700,'AFN',2318.4,'AFN',NULL,NULL,44,61,2),(121,'دانه',3,3,58,'USD',5000,'AFN',3735.2000000000003,'AFN',NULL,NULL,44,62,2),(122,'دانه',3,3,350,'AFN',500,'AFN',350,'AFN',NULL,NULL,45,153,2),(123,'دانه',3,3,300,'AFN',550,'AFN',300,'AFN',NULL,NULL,45,104,2),(124,'دانه',5,5,290,'AFN',500,'AFN',290,'AFN',NULL,NULL,45,152,2),(125,'دانه',2,2,150,'AFN',300,'AFN',150,'AFN',NULL,NULL,45,151,2),(126,'دانه',5,5,900,'AFN',1650,'AFN',900,'AFN',NULL,NULL,45,91,2),(127,'دانه',10,10,950,'AFN',1500,'AFN',950,'AFN',NULL,NULL,46,168,2),(128,'دانه',5,5,2400,'AFN',3000,'AFN',2400,'AFN',NULL,NULL,47,211,2),(129,'دانه',5,5,1480,'AFN',1800,'AFN',1480,'AFN',NULL,NULL,47,176,2),(130,'دانه',5,5,1480,'AFN',2000,'AFN',1480,'AFN',NULL,NULL,47,210,2),(131,'دانه',10,10,730,'AFN',1200,'AFN',730,'AFN',NULL,NULL,47,170,2),(132,'دانه',1,1,1500,'AFN',1650,'AFN',1500,'AFN',NULL,NULL,48,167,2),(133,'دانه',1,1,12,'USD',1200,'AFN',772.8000000000001,'AFN',NULL,NULL,49,42,2),(134,'دانه',9,9,20,'USD',1600,'AFN',1288,'AFN',NULL,NULL,49,51,2),(135,'دانه',2,2,3600,'AFN',4500,'AFN',3600,'AFN',NULL,NULL,50,212,2),(136,'دانه',1,1,500,'AFN',650,'AFN',500,'AFN',NULL,NULL,51,213,2),(142,'دانه',40,40,15,'AFN',20,'AFN',15,'AFN',NULL,NULL,53,12,2),(143,'دانه',1,1,5000,'AFN',9500,'AFN',5000,'AFN',NULL,NULL,54,215,2),(144,'دانه',1,1,6500,'AFN',10000,'AFN',6500,'AFN',NULL,NULL,54,214,2),(150,'دانه',2,2,4890,'AFN',6000,'AFN',4890,'AFN',NULL,NULL,52,180,2),(151,'دانه',2,2,4000,'AFN',5000,'AFN',4000,'AFN',NULL,NULL,52,77,2),(152,'دانه',4,4,2225,'AFN',3000,'AFN',2225,'AFN',NULL,NULL,52,75,2),(153,'دانه',5,5,1335,'AFN',1800,'AFN',1335,'AFN',NULL,NULL,52,74,2),(154,'دانه',16,16,445,'AFN',800,'AFN',445,'AFN',NULL,NULL,52,80,2),(156,'دانه',4,4,75,'USD',5500,'AFN',4830,'AFN',NULL,NULL,56,216,2),(157,'بنډل',1,305,70,'USD',5000,'AFN',4508,'AFN',NULL,NULL,56,118,2),(158,'دانه',3,3,20,'USD',1600,'AFN',1282,'AFN',NULL,NULL,57,51,2),(159,'دانه',1,1,80,'USD',5500,'AFN',5128,'AFN',NULL,NULL,57,220,2),(160,'دانه',1,1,25,'USD',2800,'AFN',1602.4999999999998,'AFN',NULL,NULL,57,218,2),(161,'دانه',5,5,26,'USD',2000,'AFN',1666.6,'AFN',NULL,NULL,57,45,2),(162,'دانه',8,8,26,'USD',2000,'AFN',1666.6,'AFN',NULL,NULL,57,217,2),(163,'دانه',1,1,100,'AFN',300,'AFN',100,'AFN',NULL,NULL,58,85,2),(164,'دانه',2,2,4000,'AFN',5000,'AFN',4000,'AFN',NULL,NULL,59,77,2),(165,'305 متره بنډل',2,610,6100,'AFN',7000,'AFN',6100,'AFN',NULL,NULL,55,17,2),(166,'دانه',2,2,1850,'AFN',2400,'AFN',1850,'AFN',NULL,NULL,60,221,2),(171,'دانه',5,5,26,'USD',2000,'AFN',1651,'AFN',NULL,NULL,62,45,2),(172,'دانه',10,10,25,'USD',2000,'AFN',1587.5,'AFN',NULL,NULL,61,217,2),(173,'بنډل',1,300,3600,'AFN',4500,'AFN',3600,'AFN',NULL,NULL,63,15,2),(174,'دانه',20,20,120,'AFN',300,'AFN',120,'AFN',NULL,NULL,63,85,2);
/*!40000 ALTER TABLE `stockpurchaseitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockpurchases`
--

DROP TABLE IF EXISTS `stockpurchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockpurchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paymentType` varchar(255) NOT NULL,
  `currency` varchar(255) NOT NULL,
  `billNumber` varchar(255) DEFAULT NULL,
  `paidAmount` double NOT NULL,
  `paidCode` char(3) NOT NULL,
  `basePaidAmount` double NOT NULL,
  `basePaidCode` char(3) NOT NULL,
  `inExchangeForAmount` double NOT NULL,
  `inExchangeForCode` char(3) NOT NULL,
  `totalAmount` double NOT NULL,
  `totalCode` char(3) NOT NULL,
  `baseTotalAmount` double NOT NULL,
  `baseTotalCode` char(3) NOT NULL,
  `discount` double NOT NULL,
  `baseDiscount` double NOT NULL,
  `isReturn` tinyint(1) NOT NULL DEFAULT 0,
  `isPending` tinyint(1) NOT NULL DEFAULT 0,
  `journalId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  `vendorAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `cashAccountId` (`cashAccountId`),
  KEY `vendorAccountId` (`vendorAccountId`),
  KEY `stock_purchases_payment_type` (`paymentType`),
  KEY `stock_purchases_currency` (`currency`),
  KEY `stock_purchases_bill_number` (`billNumber`),
  KEY `stock_purchases_is_return` (`isReturn`),
  CONSTRAINT `stockpurchases_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stockpurchases_ibfk_2` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stockpurchases_ibfk_3` FOREIGN KEY (`vendorAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockpurchases`
--

LOCK TABLES `stockpurchases` WRITE;
/*!40000 ALTER TABLE `stockpurchases` DISABLE KEYS */;
INSERT INTO `stockpurchases` VALUES (3,'cash','AFN','د چین شیان',510449,'AFN',510449,'AFN',0,'AFN',510449,'AFN',510449,'AFN',0,0,0,1,196,1,NULL),(4,'credit','AFN','91',0,'AFN',0,'AFN',0,'AFN',35200,'AFN',35200,'AFN',0,0,0,0,245,NULL,85),(5,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',3750,'AFN',3750,'AFN',0,0,0,0,246,NULL,79),(6,'credit','AFN','2174',0,'AFN',0,'AFN',0,'AFN',13200,'AFN',13200,'AFN',0,0,0,0,247,NULL,80),(7,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',4600,'AFN',4600,'AFN',0,0,0,0,248,NULL,81),(8,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',400,'AFN',400,'AFN',0,0,0,0,249,NULL,82),(9,'credit','USD','9594',0,'AFN',0,'AFN',0,'USD',140,'USD',9072,'AFN',0,0,0,0,250,NULL,82),(10,'credit','USD','3740',0,'AFN',0,'AFN',0,'USD',630,'USD',40981.5,'AFN',0,0,0,0,251,NULL,76),(11,'credit','AFN','0007822',0,'AFN',0,'AFN',0,'AFN',12450,'AFN',12450,'AFN',0,0,0,0,253,NULL,77),(12,'credit','USD',NULL,0,'AFN',0,'AFN',0,'USD',20,'USD',1296,'AFN',0,0,0,0,255,NULL,83),(13,'cash','AFN',NULL,3100,'AFN',3100,'AFN',0,'AFN',3100,'AFN',3100,'AFN',0,0,0,0,256,1,90),(14,'credit','USD','3275',0,'AFN',0,'AFN',0,'USD',543,'USD',35295,'AFN',0,0,0,0,290,NULL,78),(15,'credit','USD','3429',0,'AFN',0,'AFN',0,'USD',405,'USD',26345.25,'AFN',0,0,0,0,310,NULL,78),(16,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',1300,'AFN',1300,'AFN',0,0,0,0,323,NULL,81),(17,'credit','USD',NULL,0,'AFN',0,'AFN',0,'USD',130,'USD',8450,'AFN',0,0,0,0,324,NULL,83),(18,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',14500,'AFN',14500,'AFN',0,0,0,0,325,NULL,115),(19,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',600,'AFN',600,'AFN',0,0,0,0,332,NULL,79),(20,'cash','AFN',NULL,1500,'AFN',1500,'AFN',0,'AFN',1500,'AFN',1500,'AFN',0,0,0,0,337,1,108),(21,'cash','AFN',NULL,2200,'AFN',2200,'AFN',0,'AFN',2200,'AFN',2200,'AFN',0,0,0,0,338,1,108),(22,'credit','USD',NULL,0,'AFN',0,'AFN',0,'USD',130,'USD',8450,'AFN',0,0,0,0,342,NULL,83),(23,'cash','AFN',NULL,37330,'AFN',37330,'AFN',0,'AFN',37330,'AFN',37330,'AFN',0,0,0,0,357,1,117),(24,'cash','AFN',NULL,1500,'AFN',1500,'AFN',0,'AFN',1500,'AFN',1500,'AFN',0,0,0,0,365,1,108),(25,'cash','AFN',NULL,800,'AFN',800,'AFN',0,'AFN',800,'AFN',800,'AFN',0,0,0,0,370,1,91),(26,'cash','AFN',NULL,1050,'AFN',1050,'AFN',0,'AFN',1050,'AFN',1050,'AFN',0,0,0,0,376,1,108),(27,'cash','AFN',NULL,9000,'AFN',9000,'AFN',0,'AFN',9000,'AFN',9000,'AFN',0,0,0,0,384,1,108),(28,'cash','AFN',NULL,350,'AFN',350,'AFN',0,'AFN',350,'AFN',350,'AFN',0,0,0,0,385,1,108),(29,'credit','AFN','290',0,'AFN',0,'AFN',0,'AFN',20500,'AFN',20500,'AFN',0,0,0,0,394,NULL,85),(30,'cash','AFN',NULL,7900,'AFN',7900,'AFN',0,'AFN',7900,'AFN',7900,'AFN',0,0,0,0,396,1,108),(31,'cash','AFN',NULL,9200,'AFN',9200,'AFN',0,'AFN',9200,'AFN',9200,'AFN',0,0,0,0,418,1,120),(32,'credit','USD',NULL,0,'AFN',0,'AFN',0,'USD',50,'USD',3246.5000000000005,'AFN',0,0,0,0,419,NULL,91),(33,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',2800,'AFN',2800,'AFN',0,0,0,0,420,NULL,91),(34,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',1300,'AFN',1300,'AFN',0,0,0,0,421,NULL,60),(35,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',1500,'AFN',1500,'AFN',0,0,0,0,422,NULL,118),(36,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',6405,'AFN',6405,'AFN',0,0,0,0,424,NULL,82),(37,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',1100,'AFN',1100,'AFN',0,0,0,0,425,NULL,91),(38,'cash','AFN',NULL,308,'AFN',308,'AFN',0,'AFN',308,'AFN',308,'AFN',0,0,0,0,433,1,NULL),(39,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',1100,'AFN',1100,'AFN',0,0,1,0,446,NULL,91),(40,'cash','AFN',NULL,2130,'AFN',2130,'AFN',0,'AFN',2130,'AFN',2130,'AFN',0,0,0,0,451,1,110),(41,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',2800,'AFN',2800,'AFN',0,0,0,0,454,NULL,91),(42,'cash','AFN',NULL,7000,'AFN',7000,'AFN',0,'AFN',7000,'AFN',7000,'AFN',0,0,0,0,458,1,108),(43,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',19000,'AFN',19000,'AFN',0,0,0,0,464,NULL,123),(44,'credit','USD',NULL,0,'AFN',0,'AFN',0,'USD',788.2,'USD',50760.079999999994,'AFN',0,0,0,0,466,NULL,78),(45,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',8200,'AFN',8200,'AFN',0,0,0,0,469,NULL,77),(46,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',9500,'AFN',9500,'AFN',0,0,0,0,471,NULL,86),(47,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',34100,'AFN',34100,'AFN',0,0,0,0,473,NULL,124),(48,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',1500,'AFN',1500,'AFN',0,0,1,0,475,NULL,124),(49,'credit','USD',NULL,0,'AFN',0,'AFN',0,'USD',192,'USD',12364.8,'AFN',0,0,0,0,476,NULL,76),(50,'cash','AFN',NULL,7200,'AFN',7200,'AFN',0,'AFN',7200,'AFN',7200,'AFN',0,0,0,0,484,1,85),(51,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',500,'AFN',500,'AFN',0,0,0,0,492,NULL,91),(52,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',40475,'AFN',40475,'AFN',0,0,0,0,495,NULL,125),(53,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',600,'AFN',600,'AFN',0,0,0,0,500,NULL,83),(54,'cash','AFN',NULL,11500,'AFN',11500,'AFN',0,'AFN',11500,'AFN',11500,'AFN',0,0,0,0,507,1,117),(55,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',12200,'AFN',12200,'AFN',0,0,0,0,533,NULL,82),(56,'credit','USD',NULL,0,'AFN',0,'AFN',0,'USD',370,'USD',23828,'AFN',0,0,0,0,534,NULL,82),(57,'credit','USD',NULL,0,'AFN',0,'AFN',0,'USD',503,'USD',32242.3,'AFN',0,0,0,0,535,NULL,76),(58,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',100,'AFN',100,'AFN',0,0,0,0,537,NULL,83),(59,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',8000,'AFN',8000,'AFN',0,0,0,0,539,NULL,83),(60,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',3700,'AFN',3700,'AFN',0,0,0,0,562,NULL,85),(61,'credit','USD',NULL,0,'AFN',0,'AFN',0,'USD',250,'USD',15875,'AFN',0,0,0,0,574,NULL,77),(62,'credit','USD',NULL,0,'AFN',0,'AFN',0,'USD',130,'USD',8255,'AFN',0,0,0,0,575,NULL,76),(63,'credit','AFN',NULL,0,'AFN',0,'AFN',0,'AFN',6000,'AFN',6000,'AFN',0,0,0,0,576,NULL,77);
/*!40000 ALTER TABLE `stockpurchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocksalebillcosts`
--

DROP TABLE IF EXISTS `stocksalebillcosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocksalebillcosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `stockSaleId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stockSaleId` (`stockSaleId`),
  KEY `cashAccountId` (`cashAccountId`),
  CONSTRAINT `stocksalebillcosts_ibfk_1` FOREIGN KEY (`stockSaleId`) REFERENCES `stocksales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stocksalebillcosts_ibfk_2` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocksalebillcosts`
--

LOCK TABLES `stocksalebillcosts` WRITE;
/*!40000 ALTER TABLE `stocksalebillcosts` DISABLE KEYS */;
INSERT INTO `stocksalebillcosts` VALUES (1,'costsOnUs','بولدک ټرانسپورټ مصارف',100,'AFN',100,'AFN',42,1),(2,'costsOnUs','بولدک ټرانسپورټ مصارف',150,'AFN',150,'AFN',26,1);
/*!40000 ALTER TABLE `stocksalebillcosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocksaleexcashes`
--

DROP TABLE IF EXISTS `stocksaleexcashes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocksaleexcashes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cashAmount` double NOT NULL,
  `cashCode` char(3) NOT NULL,
  `baseCashAmount` double NOT NULL,
  `baseCashCode` char(3) NOT NULL,
  `stockSaleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stockSaleId` (`stockSaleId`),
  CONSTRAINT `stocksaleexcashes_ibfk_1` FOREIGN KEY (`stockSaleId`) REFERENCES `stocksales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocksaleexcashes`
--

LOCK TABLES `stocksaleexcashes` WRITE;
/*!40000 ALTER TABLE `stocksaleexcashes` DISABLE KEYS */;
/*!40000 ALTER TABLE `stocksaleexcashes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocksaleitems`
--

DROP TABLE IF EXISTS `stocksaleitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocksaleitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit` varchar(255) NOT NULL,
  `quantity` double NOT NULL,
  `baseQuantity` double NOT NULL,
  `unitPriceAmount` double NOT NULL,
  `unitPriceCode` char(3) NOT NULL,
  `baseUnitPriceAmount` double NOT NULL,
  `baseUnitPriceCode` char(3) NOT NULL,
  `stockSaleId` int(11) DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  `stockAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stockSaleId` (`stockSaleId`),
  KEY `stockItemId` (`stockItemId`),
  KEY `stockAccountId` (`stockAccountId`),
  CONSTRAINT `stocksaleitems_ibfk_1` FOREIGN KEY (`stockSaleId`) REFERENCES `stocksales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stocksaleitems_ibfk_2` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stocksaleitems_ibfk_3` FOREIGN KEY (`stockAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=674 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocksaleitems`
--

LOCK TABLES `stocksaleitems` WRITE;
/*!40000 ALTER TABLE `stocksaleitems` DISABLE KEYS */;
INSERT INTO `stocksaleitems` VALUES (41,'دانه',1,1,200,'AFN',200,'AFN',8,9,2),(42,'دانه',1,1,2300,'AFN',2300,'AFN',8,125,2),(43,'متر',34,34,16,'AFN',16,'AFN',7,15,2),(44,'دانه',4,4,10,'AFN',10,'AFN',7,131,2),(45,'دانه',8,8,15,'AFN',15,'AFN',7,11,2),(46,'دانه',1,1,1000,'AFN',1000,'AFN',7,74,2),(47,'دانه',1,1,3200,'AFN',3200,'AFN',7,61,2),(48,'دانه',3,3,900,'AFN',900,'AFN',7,41,2),(49,'دانه',1,1,1250,'AFN',1250,'AFN',7,22,2),(50,'دانه',19,19,15,'AFN',15,'AFN',6,11,2),(51,'دانه',1,1,1100,'AFN',1100,'AFN',6,74,2),(52,'دانه',1,1,5000,'AFN',5000,'AFN',6,53,2),(53,'دانه',1,1,20,'AFN',20,'AFN',6,11,2),(54,'دانه',2,2,30,'AFN',30,'AFN',5,11,2),(55,'دانه',1,1,20,'AFN',20,'AFN',5,131,2),(56,'متر',16,16,20,'AFN',20,'AFN',5,15,2),(57,'دانه',1,1,1200,'AFN',1200,'AFN',5,42,2),(58,'دانه',1,1,500,'AFN',500,'AFN',4,80,2),(59,'دانه',14,14,20,'AFN',20,'AFN',4,118,2),(60,'دانه',2,2,5,'AFN',5,'AFN',4,136,2),(61,'دانه',1,1,5000,'AFN',5000,'AFN',4,62,2),(62,'دانه',1,1,1800,'AFN',1800,'AFN',3,176,2),(63,'دانه',1,1,180,'AFN',180,'AFN',9,151,2),(68,'دانه',2,2,300,'AFN',300,'AFN',10,9,2),(69,'دانه',6,6,20,'AFN',20,'AFN',10,131,2),(70,'دانه',12,12,25,'AFN',25,'AFN',10,12,2),(71,'دانه',6,6,1750,'AFN',1750,'AFN',10,46,2),(72,'دانه',1,1,1350,'AFN',1350,'AFN',11,51,2),(73,'دانه',1,1,2400,'AFN',2400,'AFN',11,116,2),(74,'متر',281,281,17,'AFN',17,'AFN',11,15,2),(75,'دانه',5,5,10,'AFN',10,'AFN',11,131,2),(76,'دانه',15,15,15,'AFN',15,'AFN',11,11,2),(77,'دانه',1,1,4300,'AFN',4300,'AFN',12,148,2),(78,'دانه',1,1,300,'AFN',300,'AFN',12,113,2),(79,'دانه',1,1,300,'AFN',300,'AFN',12,85,2),(80,'دانه',21,21,5,'AFN',5,'AFN',12,136,2),(81,'دانه',1,1,3800,'AFN',3800,'AFN',12,77,2),(82,'دانه',7,7,3950,'AFN',3950,'AFN',12,73,2),(83,'دانه',1,1,7300,'AFN',7300,'AFN',12,72,2),(84,'دانه',25,25,20,'AFN',20,'AFN',13,118,2),(85,'دانه',7,7,5,'AFN',5,'AFN',13,136,2),(91,'دانه',2,2,300,'AFN',300,'AFN',14,9,2),(92,'دانه',1,1,1500,'AFN',1500,'AFN',15,39,2),(93,'دانه',1,1,200,'AFN',200,'AFN',16,9,2),(94,'دانه',1,1,900,'AFN',900,'AFN',16,121,2),(95,'دانه',1,1,20,'AFN',20,'AFN',16,11,2),(96,'دانه',1,1,2400,'AFN',2400,'AFN',16,70,2),(97,'دانه',1,1,150,'AFN',150,'AFN',16,82,2),(98,'دانه',1,1,900,'AFN',900,'AFN',16,42,2),(99,'دانه',1,1,300,'AFN',300,'AFN',16,113,2),(100,'متر',6,6,16,'AFN',16,'AFN',16,15,2),(101,'دانه',1,1,10,'AFN',10,'AFN',16,131,2),(102,'دانه',2,2,15,'AFN',15,'AFN',16,11,2),(103,'دانه',1,1,1420,'AFN',1420,'AFN',16,52,2),(104,'دانه',1,1,3500,'AFN',3500,'AFN',16,59,2),(105,'دانه',1,1,700,'AFN',700,'AFN',17,80,2),(106,'متر',22,22,20,'AFN',20,'AFN',17,15,2),(107,'دانه',1,1,300,'AFN',300,'AFN',17,9,2),(108,'دانه',3,3,30,'AFN',30,'AFN',17,131,2),(109,'دانه',1,1,300,'AFN',300,'AFN',17,85,2),(110,'دانه',1,1,4500,'AFN',4500,'AFN',17,59,2),(111,'دانه',2,2,1800,'AFN',1800,'AFN',17,44,2),(112,'دانه',7,7,30,'AFN',30,'AFN',17,11,2),(113,'دانه',2,2,1200,'AFN',1200,'AFN',18,168,2),(114,'دانه',10,10,15,'AFN',15,'AFN',19,12,2),(115,'متر',27,27,17,'AFN',17,'AFN',19,15,2),(116,'دانه',1,1,400,'AFN',400,'AFN',19,80,2),(117,'دانه',1,1,300,'AFN',300,'AFN',19,113,2),(118,'دانه',1,1,300,'AFN',300,'AFN',19,80,2),(119,'دانه',1,1,1100,'AFN',1100,'AFN',19,74,2),(120,'دانه',1,1,200,'AFN',200,'AFN',19,9,2),(121,'دانه',13,13,10,'AFN',10,'AFN',19,131,2),(122,'دانه',16,16,15,'AFN',15,'AFN',19,11,2),(123,'دانه',1,1,900,'AFN',900,'AFN',19,42,2),(124,'متر',15,15,16,'AFN',16,'AFN',19,15,2),(125,'دانه',1,1,107,'AFN',107,'AFN',19,150,2),(126,'دانه',3,3,1050,'AFN',1050,'AFN',20,21,2),(127,'دانه',3,3,1250,'AFN',1250,'AFN',20,40,2),(128,'دانه',2,2,10,'AFN',10,'AFN',21,131,2),(129,'دانه',3,3,25,'AFN',25,'AFN',21,12,2),(130,'دانه',1,1,1350,'AFN',1350,'AFN',21,39,2),(131,'دانه',1,1,1100,'AFN',1100,'AFN',21,21,2),(132,'دانه',1,1,3250,'AFN',3250,'AFN',21,59,2),(133,'دانه',2,2,300,'AFN',300,'AFN',22,9,2),(134,'دانه',2,2,30,'AFN',30,'AFN',22,11,2),(135,'دانه',1,1,1500,'AFN',1500,'AFN',22,39,2),(136,'دانه',2,2,200,'AFN',200,'AFN',23,82,2),(137,'دانه',1,1,4000,'AFN',4000,'AFN',23,103,2),(138,'دانه',2,2,4500,'AFN',4500,'AFN',23,148,2),(139,'دانه',2,2,3300,'AFN',3300,'AFN',23,147,2),(140,'دانه',91,91,5,'AFN',5,'AFN',23,136,2),(141,'دانه',305,305,20,'AFN',20,'AFN',23,119,2),(142,'دانه',420,420,20,'AFN',20,'AFN',23,118,2),(143,'دانه',1,1,100,'AFN',100,'AFN',24,139,2),(144,'بنډل',1,300,5100,'AFN',5100,'AFN',25,15,2),(145,'دانه',4,4,75,'AFN',75,'AFN',25,81,2),(146,'دانه',1,1,2300,'AFN',2300,'AFN',25,75,2),(147,'دانه',2,2,1100,'AFN',1100,'AFN',25,21,2),(148,'دانه',4,4,1570,'AFN',1570,'AFN',25,44,2),(149,'دانه',1,1,4020,'AFN',4020,'AFN',25,62,2),(155,'دانه',1,1,1200,'AFN',1200,'AFN',27,138,2),(156,'دانه',1,1,3100,'AFN',3100,'AFN',28,128,2),(157,'دانه',20,20,18,'AFN',18,'AFN',29,118,2),(158,'دانه',5,5,10,'AFN',10,'AFN',30,131,2),(159,'دانه',10,10,15,'AFN',15,'AFN',30,11,2),(161,'دانه',2,2,2400,'AFN',2400,'AFN',32,70,2),(162,'دانه',2,2,1500,'AFN',1500,'AFN',32,74,2),(163,'متر',144,144,12,'AFN',12,'AFN',33,16,2),(164,'دانه',1,1,70,'AFN',70,'AFN',33,81,2),(165,'دانه',2,2,10,'AFN',10,'AFN',33,131,2),(166,'دانه',2,2,1100,'AFN',1100,'AFN',34,170,2),(167,'دانه',1,1,300,'AFN',300,'AFN',35,113,2),(168,'دانه',1,1,200,'AFN',200,'AFN',35,9,2),(169,'دانه',3,3,10,'AFN',10,'AFN',35,131,2),(170,'دانه',2,2,15,'AFN',15,'AFN',35,11,2),(171,'دانه',1,1,1250,'AFN',1250,'AFN',35,43,2),(172,'دانه',1,1,1100,'AFN',1100,'AFN',35,21,2),(173,'دانه',4,4,30,'AFN',30,'AFN',36,11,2),(174,'دانه',1,1,1200,'AFN',1200,'AFN',36,21,2),(175,'دانه',169,169,25,'AFN',25,'AFN',36,118,2),(176,'دانه',22,22,5,'AFN',5,'AFN',36,136,2),(177,'دانه',1,1,2000,'AFN',2000,'AFN',36,191,2),(181,'متر',59,59,16,'AFN',16,'AFN',38,15,2),(182,'دانه',1,1,200,'AFN',200,'AFN',38,9,2),(183,'دانه',7,7,10,'AFN',10,'AFN',38,131,2),(184,'دانه',14,14,15,'AFN',15,'AFN',38,11,2),(185,'دانه',2,2,1100,'AFN',1100,'AFN',38,21,2),(186,'دانه',1,1,300,'AFN',300,'AFN',37,9,2),(187,'دانه',1,1,4000,'AFN',4000,'AFN',37,61,2),(188,'دانه',1,1,1200,'AFN',1200,'AFN',37,21,2),(189,'دانه',1,1,30,'AFN',30,'AFN',37,131,2),(190,'متر',17,17,20,'AFN',20,'AFN',37,15,2),(191,'دانه',8,8,30,'AFN',30,'AFN',37,11,2),(192,'دانه',1,1,100,'AFN',100,'AFN',37,81,2),(193,'دانه',2,2,5,'AFN',5,'AFN',37,136,2),(194,'دانه',6,6,20,'AFN',20,'AFN',37,118,2),(195,'دانه',1,1,700,'AFN',700,'AFN',39,190,2),(196,'متر',61,61,20,'AFN',20,'AFN',39,15,2),(197,'دانه',1,1,100,'AFN',100,'AFN',39,81,2),(198,'دانه',1,1,250,'AFN',250,'AFN',39,9,2),(199,'دانه',6,6,30,'AFN',30,'AFN',39,131,2),(200,'دانه',12,12,30,'AFN',30,'AFN',39,11,2),(201,'دانه',1,1,15000,'AFN',15000,'AFN',39,189,2),(202,'دانه',1,1,4500,'AFN',4500,'AFN',39,48,2),(203,'دانه',1,1,4800,'AFN',4800,'AFN',39,62,2),(204,'دانه',5,5,1680,'AFN',1680,'AFN',39,179,2),(205,'متر',60,60,20,'AFN',20,'AFN',40,15,2),(206,'دانه',1,1,80,'AFN',80,'AFN',40,83,2),(207,'دانه',3,3,150,'AFN',150,'AFN',40,32,2),(208,'دانه',1,1,300,'AFN',300,'AFN',40,113,2),(209,'دانه',3,3,30,'AFN',30,'AFN',40,131,2),(210,'دانه',6,6,30,'AFN',30,'AFN',40,11,2),(211,'دانه',1,1,1600,'AFN',1600,'AFN',40,74,2),(212,'دانه',3,3,1150,'AFN',1150,'AFN',40,21,2),(213,'دانه',1,1,3000,'AFN',3000,'AFN',40,192,2),(214,'دانه',1,1,50,'AFN',50,'AFN',41,137,2),(221,'دانه',1,1,80,'AFN',80,'AFN',42,81,2),(222,'متر',40,40,15,'AFN',15,'AFN',42,15,2),(223,'دانه',4,4,10,'AFN',10,'AFN',42,131,2),(224,'دانه',8,8,15,'AFN',15,'AFN',42,11,2),(225,'دانه',1,1,4200,'AFN',4200,'AFN',42,62,2),(226,'دانه',3,3,1700,'AFN',1700,'AFN',42,179,2),(227,'دانه',1,1,2400,'AFN',2400,'AFN',26,58,2),(228,'متر',70,70,15,'AFN',15,'AFN',26,15,2),(229,'دانه',6,6,10,'AFN',10,'AFN',26,131,2),(230,'دانه',6,6,15,'AFN',15,'AFN',26,11,2),(231,'دانه',2,2,1400,'AFN',1400,'AFN',26,40,2),(232,'متر',31,31,20,'AFN',20,'AFN',43,15,2),(233,'دانه',1,1,90,'AFN',90,'AFN',43,81,2),(234,'دانه',1,1,30,'AFN',30,'AFN',43,131,2),(235,'دانه',2,2,30,'AFN',30,'AFN',43,11,2),(236,'دانه',1,1,250,'AFN',250,'AFN',43,9,2),(237,'دانه',1,1,700,'AFN',700,'AFN',43,80,2),(238,'دانه',1,1,1159,'AFN',1159,'AFN',43,21,2),(239,'دانه',2,2,5,'AFN',5,'AFN',44,136,2),(240,'دانه',8,8,20,'AFN',20,'AFN',44,118,2),(241,'دانه',1,1,1900,'AFN',1900,'AFN',45,176,2),(242,'دانه',1,1,30,'AFN',30,'AFN',45,131,2),(243,'دانه',2,2,30,'AFN',30,'AFN',45,11,2),(244,'دانه',1,1,200,'AFN',200,'AFN',45,9,2),(245,'دانه',1,1,300,'AFN',300,'AFN',45,9,2),(248,'دانه',2,2,25,'AFN',25,'AFN',46,11,2),(249,'دانه',1,1,1750,'AFN',1750,'AFN',46,179,2),(250,'متر',27,27,20,'AFN',20,'AFN',47,15,2),(251,'دانه',1,1,30,'AFN',30,'AFN',47,131,2),(252,'دانه',2,2,30,'AFN',30,'AFN',47,11,2),(253,'دانه',1,1,1220,'AFN',1220,'AFN',47,22,2),(254,'دانه',1,1,3800,'AFN',3800,'AFN',47,61,2),(256,'دانه',3,3,30,'AFN',30,'AFN',49,131,2),(257,'متر',30,30,15,'AFN',15,'AFN',50,16,2),(258,'دانه',1,1,400,'AFN',400,'AFN',51,87,2),(259,'دانه',2,2,450,'AFN',450,'AFN',51,142,2),(260,'دانه',2,2,30,'AFN',30,'AFN',52,11,2),(261,'دانه',1,1,1800,'AFN',1800,'AFN',53,179,2),(262,'دانه',6,6,1416,'AFN',1416,'AFN',54,52,2),(263,'دانه',1,1,450,'AFN',450,'AFN',55,152,2),(264,'دانه',1,1,600,'AFN',600,'AFN',55,80,2),(265,'متر',240,240,16,'AFN',16,'AFN',55,15,2),(266,'دانه',2,2,200,'AFN',200,'AFN',55,9,2),(267,'دانه',8,8,10,'AFN',10,'AFN',55,131,2),(268,'دانه',16,16,15,'AFN',15,'AFN',55,11,2),(269,'دانه',1,1,700,'AFN',700,'AFN',55,89,2),(270,'دانه',1,1,3200,'AFN',3200,'AFN',55,61,2),(271,'دانه',8,8,1100,'AFN',1100,'AFN',55,21,2),(272,'متر',18,18,15,'AFN',15,'AFN',56,15,2),(273,'دانه',1,1,20,'AFN',20,'AFN',56,131,2),(274,'دانه',2,2,30,'AFN',30,'AFN',56,11,2),(275,'دانه',1,1,400,'AFN',400,'AFN',56,142,2),(276,'دانه',1,1,1650,'AFN',1650,'AFN',56,46,2),(277,'دانه',2,2,30,'AFN',30,'AFN',57,131,2),(278,'دانه',3,3,30,'AFN',30,'AFN',57,11,2),(279,'دانه',1,1,1500,'AFN',1500,'AFN',57,23,2),(280,'دانه',4,4,30,'AFN',30,'AFN',58,131,2),(281,'دانه',7,7,30,'AFN',30,'AFN',58,11,2),(282,'متر',37,37,18,'AFN',18,'AFN',58,15,2),(283,'دانه',2,2,700,'AFN',700,'AFN',58,33,2),(325,'دانه',1,1,450,'AFN',450,'AFN',60,200,2),(326,'دانه',1,1,9200,'AFN',9200,'AFN',60,199,2),(327,'دانه',1,1,90,'AFN',90,'AFN',60,149,2),(328,'دانه',1,1,300,'AFN',300,'AFN',60,113,2),(329,'متر',51,51,20,'AFN',20,'AFN',60,15,2),(330,'دانه',2,2,300,'AFN',300,'AFN',60,9,2),(331,'دانه',1,1,200,'AFN',200,'AFN',60,84,2),(332,'دانه',6,6,30,'AFN',30,'AFN',60,131,2),(333,'دانه',12,12,30,'AFN',30,'AFN',60,11,2),(334,'دانه',1,1,5000,'AFN',5000,'AFN',60,62,2),(335,'دانه',1,1,1500,'AFN',1500,'AFN',60,74,2),(336,'دانه',1,1,1600,'AFN',1600,'AFN',60,52,2),(337,'دانه',2,2,1500,'AFN',1500,'AFN',60,51,2),(338,'دانه',3,3,1500,'AFN',1500,'AFN',60,47,2),(339,'دانه',1,1,3350,'AFN',3350,'AFN',61,59,2),(340,'دانه',1,1,550,'AFN',550,'AFN',61,80,2),(341,'دانه',1,1,1350,'AFN',1350,'AFN',61,123,2),(342,'دانه',3,3,600,'AFN',600,'AFN',62,80,2),(343,'دانه',1,1,800,'AFN',800,'AFN',62,170,2),(344,'متر',15,15,20,'AFN',20,'AFN',59,15,2),(345,'دانه',1,1,30,'AFN',30,'AFN',59,131,2),(346,'دانه',2,2,30,'AFN',30,'AFN',59,11,2),(347,'دانه',1,1,1100,'AFN',1100,'AFN',59,21,2),(348,'دانه',1,1,10,'AFN',10,'AFN',59,131,2),(349,'متر',33,33,16,'AFN',16,'AFN',59,15,2),(350,'دانه',4,4,5,'AFN',5,'AFN',59,136,2),(351,'دانه',23,23,17,'AFN',17,'AFN',59,118,2),(352,'دانه',6,6,10,'AFN',10,'AFN',59,136,2),(353,'دانه',2,2,1200,'AFN',1200,'AFN',59,21,2),(354,'دانه',1,1,300,'AFN',300,'AFN',59,113,2),(355,'دانه',1,1,4500,'AFN',4500,'AFN',59,62,2),(356,'دانه',1,1,1450,'AFN',1450,'AFN',59,52,2),(357,'دانه',10,10,15,'AFN',15,'AFN',59,11,2),(358,'دانه',2,2,200,'AFN',200,'AFN',59,9,2),(359,'دانه',4,4,150,'AFN',150,'AFN',59,82,2),(361,'دانه',1,1,150,'AFN',150,'AFN',64,32,2),(362,'دانه',21,21,20,'AFN',20,'AFN',64,118,2),(363,'متر',115,115,20,'AFN',20,'AFN',64,15,2),(364,'دانه',1,1,450,'AFN',450,'AFN',64,152,2),(365,'دانه',1,1,650,'AFN',650,'AFN',64,88,2),(366,'دانه',8,8,30,'AFN',30,'AFN',64,131,2),(367,'دانه',16,16,30,'AFN',30,'AFN',64,11,2),(368,'دانه',2,2,300,'AFN',300,'AFN',64,9,2),(369,'دانه',1,1,3000,'AFN',3000,'AFN',64,203,2),(370,'دانه',1,1,1150,'AFN',1150,'AFN',64,21,2),(371,'دانه',1,1,8080,'AFN',8080,'AFN',64,201,2),(372,'دانه',6,6,2700,'AFN',2700,'AFN',64,202,2),(373,'متر',25,25,20,'AFN',20,'AFN',65,15,2),(374,'دانه',2,2,30,'AFN',30,'AFN',65,131,2),(375,'دانه',4,4,30,'AFN',30,'AFN',65,11,2),(376,'دانه',1,1,300,'AFN',300,'AFN',65,9,2),(377,'دانه',1,1,1100,'AFN',1100,'AFN',65,42,2),(378,'دانه',1,1,1100,'AFN',1100,'AFN',65,21,2),(379,'دانه',1,1,3920,'AFN',3920,'AFN',65,61,2),(380,'متر',149,149,18,'AFN',18,'AFN',66,15,2),(381,'دانه',1,1,148,'AFN',148,'AFN',66,84,2),(382,'دانه',1,1,650,'AFN',650,'AFN',66,80,2),(383,'دانه',1,1,250,'AFN',250,'AFN',66,9,2),(384,'دانه',3,3,30,'AFN',30,'AFN',66,131,2),(385,'دانه',6,6,30,'AFN',30,'AFN',66,11,2),(386,'دانه',1,1,1500,'AFN',1500,'AFN',66,39,2),(387,'دانه',2,2,1100,'AFN',1100,'AFN',66,21,2),(388,'دانه',1,1,2900,'AFN',2900,'AFN',66,192,2),(395,'متر',16,16,13,'AFN',13,'AFN',67,16,2),(396,'دانه',2,2,400,'AFN',400,'AFN',67,142,2),(397,'متر',21,21,15,'AFN',15,'AFN',67,15,2),(398,'دانه',1,1,80,'AFN',80,'AFN',67,32,2),(399,'دانه',1,1,2800,'AFN',2800,'AFN',67,61,2),(400,'دانه',1,1,3200,'AFN',3200,'AFN',67,203,2),(401,'دانه',1,1,80,'AFN',80,'AFN',68,83,2),(402,'دانه',2,2,150,'AFN',150,'AFN',68,82,2),(403,'دانه',1,1,450,'AFN',450,'AFN',68,104,2),(404,'دانه',1,1,1000,'AFN',1000,'AFN',69,170,2),(405,'متر',30,30,16,'AFN',16,'AFN',70,15,2),(406,'دانه',2,2,10,'AFN',10,'AFN',70,131,2),(407,'دانه',2,2,15,'AFN',15,'AFN',70,11,2),(408,'دانه',1,1,4700,'AFN',4700,'AFN',71,180,2),(410,'دانه',2,2,150,'AFN',150,'AFN',73,194,2),(411,'دانه',2,2,1750,'AFN',1750,'AFN',73,176,2),(412,'دانه',1,1,70,'AFN',70,'AFN',74,139,2),(413,'دانه',20,20,8.5,'AFN',8.5,'AFN',75,136,2),(414,'دانه',6,6,5,'AFN',5,'AFN',76,136,2),(415,'دانه',1,1,1850,'AFN',1850,'AFN',77,179,2),(416,'دانه',1,1,200,'AFN',200,'AFN',77,150,2),(417,'دانه',1,1,4500,'AFN',4500,'AFN',77,204,2),(418,'دانه',30,30,20,'AFN',20,'AFN',77,118,2),(419,'متر',101,101,20,'AFN',20,'AFN',77,15,2),(420,'دانه',1,1,1700,'AFN',1700,'AFN',77,91,2),(421,'دانه',2,2,10,'AFN',10,'AFN',77,136,2),(422,'دانه',1,1,350,'AFN',350,'AFN',77,200,2),(423,'دانه',1,1,9500,'AFN',9500,'AFN',77,199,2),(424,'دانه',1,1,300,'AFN',300,'AFN',77,9,2),(425,'دانه',4,4,30,'AFN',30,'AFN',77,131,2),(426,'دانه',8,8,30,'AFN',30,'AFN',77,11,2),(427,'دانه',1,1,3000,'AFN',3000,'AFN',77,75,2),(428,'دانه',1,1,5000,'AFN',5000,'AFN',77,62,2),(429,'دانه',3,3,1850,'AFN',1850,'AFN',77,52,2),(430,'متر',18,18,20,'AFN',20,'AFN',78,15,2),(431,'دانه',1,1,197,'AFN',197,'AFN',79,82,2),(432,'دانه',1,1,550,'AFN',550,'AFN',79,104,2),(433,'دانه',1,1,1200,'AFN',1200,'AFN',79,90,2),(434,'متر',59,59,17,'AFN',17,'AFN',79,15,2),(435,'دانه',1,1,1150,'AFN',1150,'AFN',79,22,2),(436,'دانه',5,5,30,'AFN',30,'AFN',79,131,2),(437,'دانه',10,10,30,'AFN',30,'AFN',79,11,2),(438,'دانه',1,1,1700,'AFN',1700,'AFN',80,124,2),(439,'دانه',1,1,1100,'AFN',1100,'AFN',81,177,2),(440,'دانه',1,1,300,'AFN',300,'AFN',82,9,2),(441,'دانه',1,1,30,'AFN',30,'AFN',82,131,2),(442,'دانه',3,3,30,'AFN',30,'AFN',82,11,2),(443,'دانه',1,1,650,'AFN',650,'AFN',82,88,2),(444,'متر',14,14,20,'AFN',20,'AFN',82,15,2),(445,'دانه',1,1,350,'AFN',350,'AFN',82,113,2),(446,'دانه',1,1,600,'AFN',600,'AFN',82,153,2),(447,'دانه',2,2,10,'AFN',10,'AFN',82,136,2),(448,'دانه',16,16,25,'AFN',25,'AFN',82,118,2),(456,'دانه',1,1,200,'AFN',200,'AFN',83,85,2),(457,'متر',169,169,16,'AFN',16,'AFN',83,15,2),(458,'دانه',2,2,200,'AFN',200,'AFN',83,151,2),(459,'دانه',11,11,10,'AFN',10,'AFN',83,131,2),(460,'دانه',25,25,15,'AFN',15,'AFN',83,11,2),(461,'دانه',2,2,200,'AFN',200,'AFN',83,9,2),(462,'دانه',3,3,1800,'AFN',1800,'AFN',83,179,2),(463,'دانه',1,1,1600,'AFN',1600,'AFN',84,74,2),(464,'دانه',1,1,200,'AFN',200,'AFN',85,9,2),(465,'دانه',1,1,1250,'AFN',1250,'AFN',85,22,2),(466,'متر',305,305,23,'AFN',23,'AFN',85,17,2),(467,'دانه',10,10,15,'AFN',15,'AFN',85,11,2),(468,'متر',110,110,16,'AFN',16,'AFN',85,15,2),(469,'دانه',2,2,950,'AFN',950,'AFN',85,42,2),(470,'دانه',20,20,15,'AFN',15,'AFN',86,11,2),(472,'دانه',1,1,3000,'AFN',3000,'AFN',87,75,2),(473,'دانه',1,1,1350,'AFN',1350,'AFN',88,23,2),(474,'دانه',1,1,1200,'AFN',1200,'AFN',89,170,2),(475,'دانه',1,1,2400,'AFN',2400,'AFN',90,116,2),(476,'دانه',1,1,300,'AFN',300,'AFN',91,151,2),(477,'دانه',1,1,350,'AFN',350,'AFN',91,113,2),(482,'دانه',2,2,2450,'AFN',2450,'AFN',92,75,2),(483,'دانه',2,2,1550,'AFN',1550,'AFN',92,74,2),(484,'دانه',1,1,10,'AFN',10,'AFN',93,131,2),(485,'دانه',2,2,10,'AFN',10,'AFN',93,136,2),(486,'دانه',1,1,2000,'AFN',2000,'AFN',93,210,2),(487,'دانه',1,1,300,'AFN',300,'AFN',93,9,2),(488,'دانه',1,1,550,'AFN',550,'AFN',94,104,2),(489,'دانه',1,1,260,'USD',16744,'AFN',95,57,2),(490,'دانه',1,1,1050,'AFN',1050,'AFN',96,170,2),(491,'دانه',1,1,3000,'AFN',3000,'AFN',97,211,2),(492,'دانه',1,1,200,'AFN',200,'AFN',98,9,2),(493,'متر',40,40,16,'AFN',16,'AFN',98,15,2),(494,'دانه',6,6,10,'AFN',10,'AFN',98,131,2),(495,'دانه',12,12,15,'AFN',15,'AFN',98,11,2),(496,'دانه',1,1,1100,'AFN',1100,'AFN',98,21,2),(497,'دانه',1,1,1800,'AFN',1800,'AFN',98,74,2),(498,'دانه',3,3,20,'AFN',20,'AFN',98,11,2),(499,'دانه',1,1,650,'AFN',650,'AFN',99,213,2),(500,'دانه',1,1,650,'AFN',650,'AFN',99,212,2),(501,'دانه',4,4,5,'AFN',5,'AFN',99,136,2),(502,'دانه',2,2,20,'AFN',20,'AFN',99,118,2),(503,'دانه',1,1,1200,'AFN',1200,'AFN',99,42,2),(504,'دانه',1,1,5000,'AFN',5000,'AFN',99,62,2),(505,'دانه',2,2,300,'AFN',300,'AFN',99,9,2),(506,'دانه',1,1,30,'AFN',30,'AFN',99,131,2),(507,'دانه',4,4,30,'AFN',30,'AFN',99,11,2),(508,'دانه',10,10,850,'AFN',850,'AFN',100,209,2),(509,'دانه',40,40,20,'AFN',20,'AFN',100,12,2),(510,'دانه',1,1,100,'AFN',100,'AFN',101,83,2),(511,'دانه',1,1,500,'AFN',500,'AFN',101,104,2),(523,'دانه',1,1,900,'AFN',900,'AFN',104,170,2),(524,'دانه',1,1,1150,'AFN',1150,'AFN',105,170,2),(525,'دانه',3,3,2500,'AFN',2500,'AFN',106,75,2),(526,'دانه',1,1,30,'AFN',30,'AFN',107,11,2),(527,'دانه',1,1,300,'AFN',300,'AFN',107,9,2),(529,'دانه',1,1,1200,'AFN',1200,'AFN',109,170,2),(530,'دانه',20,20,15,'AFN',15,'AFN',108,11,2),(531,'200 متره بنډل',1,200,2400,'AFN',2400,'AFN',108,16,2),(532,'دانه',1,1,2400,'AFN',2400,'AFN',110,116,2),(541,'دانه',4,4,5,'AFN',5,'AFN',112,136,2),(542,'دانه',1,1,60,'AFN',60,'AFN',112,160,2),(543,'متر',18,18,13,'AFN',13,'AFN',112,16,2),(544,'دانه',2,2,10,'AFN',10,'AFN',112,131,2),(545,'دانه',1,1,15,'AFN',15,'AFN',112,11,2),(566,'دانه',1,1,300,'AFN',300,'AFN',102,113,2),(567,'دانه',2,2,950,'AFN',950,'AFN',102,42,2),(568,'متر',349,349,16,'AFN',16,'AFN',102,15,2),(569,'دانه',4,4,200,'AFN',200,'AFN',102,9,2),(570,'دانه',20,20,10,'AFN',10,'AFN',102,131,2),(571,'دانه',40,40,15,'AFN',15,'AFN',102,11,2),(572,'دانه',1,1,2000,'AFN',2000,'AFN',102,205,2),(573,'دانه',1,1,1200,'AFN',1200,'AFN',102,43,2),(574,'دانه',8,8,1250,'AFN',1250,'AFN',102,22,2),(575,'دانه',1,1,4800,'AFN',4800,'AFN',102,53,2),(584,'دانه',1,1,5500,'AFN',5500,'AFN',113,180,2),(601,'دانه',8,8,5,'AFN',5,'AFN',111,136,2),(602,'دانه',16,16,18,'AFN',18,'AFN',111,118,2),(603,'دانه',1,1,100,'AFN',100,'AFN',111,149,2),(604,'دانه',1,1,300,'AFN',300,'AFN',111,113,2),(605,'دانه',1,1,200,'AFN',200,'AFN',111,85,2),(606,'دانه',1,1,2760,'AFN',2760,'AFN',111,218,2),(607,'دانه',4,4,5000,'AFN',5000,'AFN',111,216,2),(608,'دانه',1,1,5500,'AFN',5500,'AFN',111,220,2),(609,'دانه',1,1,100,'AFN',100,'AFN',114,83,2),(610,'دانه',1,1,500,'AFN',500,'AFN',114,104,2),(611,'دانه',3,3,1150,'AFN',1150,'AFN',115,22,2),(612,'دانه',1,1,10,'AFN',10,'AFN',115,136,2),(613,'دانه',1,1,1600,'AFN',1600,'AFN',115,74,2),(614,'دانه',1,1,300,'AFN',300,'AFN',115,113,2),(615,'دانه',1,1,80,'AFN',80,'AFN',115,149,2),(616,'دانه',1,1,350,'AFN',350,'AFN',115,87,2),(617,'دانه',1,1,1150,'AFN',1150,'AFN',115,122,2),(618,'دانه',1,1,550,'AFN',550,'AFN',115,80,2),(619,'دانه',1,1,2300,'AFN',2300,'AFN',115,192,2),(620,'دانه',2,2,950,'AFN',950,'AFN',115,41,2),(621,'دانه',2,2,1200,'AFN',1200,'AFN',115,22,2),(622,'دانه',4,4,200,'AFN',200,'AFN',115,9,2),(623,'دانه',10,10,10,'AFN',10,'AFN',115,131,2),(624,'دانه',17,17,5,'AFN',5,'AFN',115,136,2),(625,'دانه',100,100,17,'AFN',17,'AFN',115,118,2),(626,'متر',158,158,16,'AFN',16,'AFN',115,15,2),(627,'دانه',19,19,15,'AFN',15,'AFN',115,11,2),(628,'دانه',1,1,1900,'AFN',1900,'AFN',116,176,2),(629,'دانه',1,1,1550,'AFN',1550,'AFN',117,74,2),(630,'دانه',1,1,650,'AFN',650,'AFN',118,88,2),(631,'دانه',1,1,2550,'AFN',2550,'AFN',119,75,2),(632,'دانه',1,1,1800,'AFN',1800,'AFN',120,69,2),(633,'دانه',1,1,1450,'AFN',1450,'AFN',121,168,2),(634,'دانه',1,1,200,'AFN',200,'AFN',122,9,2),(635,'دانه',2,2,2000,'AFN',2000,'AFN',122,221,2),(636,'دانه',1,1,30,'AFN',30,'AFN',122,11,2),(637,'دانه',1,1,80,'AFN',80,'AFN',123,149,2),(638,'دانه',1,1,700,'AFN',700,'AFN',124,80,2),(639,'دانه',2,2,20,'AFN',20,'AFN',124,11,2),(640,'دانه',1,1,300,'AFN',300,'AFN',124,86,2),(641,'متر',64,64,20,'AFN',20,'AFN',125,15,2),(642,'دانه',1,1,3000,'AFN',3000,'AFN',125,70,2),(643,'دانه',1,1,1800,'AFN',1800,'AFN',125,74,2),(644,'دانه',1,1,100,'AFN',100,'AFN',125,83,2),(645,'دانه',7,7,30,'AFN',30,'AFN',125,131,2),(646,'دانه',12,12,30,'AFN',30,'AFN',125,11,2),(647,'دانه',2,2,300,'AFN',300,'AFN',125,9,2),(648,'دانه',2,2,500,'AFN',500,'AFN',125,33,2),(649,'دانه',4,4,700,'AFN',700,'AFN',125,206,2),(650,'دانه',1,1,1200,'AFN',1200,'AFN',126,170,2),(662,'دانه',1,1,1200,'AFN',1200,'AFN',127,20,2),(663,'متر',677,677,20,'AFN',20,'AFN',127,15,2),(664,'دانه',11,11,30,'AFN',30,'AFN',127,131,2),(665,'دانه',22,22,30,'AFN',30,'AFN',127,11,2),(666,'دانه',5,5,300,'AFN',300,'AFN',127,9,2),(667,'دانه',1,1,450,'AFN',450,'AFN',127,152,2),(668,'دانه',1,1,600,'AFN',600,'AFN',127,88,2),(669,'دانه',1,1,4900,'AFN',4900,'AFN',127,77,2),(670,'دانه',1,1,8700,'AFN',8700,'AFN',127,55,2),(671,'دانه',2,2,2000,'AFN',2000,'AFN',127,45,2),(672,'دانه',8,8,2000,'AFN',2000,'AFN',127,217,2),(673,'دانه',1,1,1750,'AFN',1750,'AFN',128,176,2);
/*!40000 ALTER TABLE `stocksaleitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocksales`
--

DROP TABLE IF EXISTS `stocksales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocksales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paymentType` varchar(255) NOT NULL,
  `currency` varchar(255) NOT NULL,
  `receivedAmount` double NOT NULL,
  `receivedCode` char(3) NOT NULL,
  `baseReceivedAmount` double NOT NULL,
  `baseReceivedCode` char(3) NOT NULL,
  `inExchangeForAmount` double NOT NULL,
  `inExchangeForCode` char(3) NOT NULL,
  `totalAmount` double NOT NULL,
  `totalCode` char(3) NOT NULL,
  `discountAmount` double NOT NULL,
  `discountCode` char(3) NOT NULL,
  `baseTotalAmount` double NOT NULL,
  `baseTotalCode` char(3) NOT NULL,
  `isReturn` tinyint(1) NOT NULL DEFAULT 0,
  `includeRemainingAmount` tinyint(1) NOT NULL DEFAULT 0,
  `journalId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  `customerAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `cashAccountId` (`cashAccountId`),
  KEY `customerAccountId` (`customerAccountId`),
  KEY `stock_sales_payment_type` (`paymentType`),
  KEY `stock_sales_currency` (`currency`),
  KEY `stock_sales_is_return` (`isReturn`),
  CONSTRAINT `stocksales_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stocksales_ibfk_2` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stocksales_ibfk_3` FOREIGN KEY (`customerAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocksales`
--

LOCK TABLES `stocksales` WRITE;
/*!40000 ALTER TABLE `stocksales` DISABLE KEYS */;
INSERT INTO `stocksales` VALUES (3,'cash','AFN',1800,'AFN',1800,'AFN',0,'AFN',1800,'AFN',0,'AFN',1800,'AFN',0,0,236,1,NULL),(4,'cash','AFN',5790,'AFN',5790,'AFN',0,'AFN',5790,'AFN',0,'AFN',5790,'AFN',0,0,237,1,NULL),(5,'cash','AFN',1600,'AFN',1600,'AFN',0,'AFN',1600,'AFN',0,'AFN',1600,'AFN',0,0,238,1,NULL),(6,'cash','AFN',6405,'AFN',6405,'AFN',0,'AFN',6405,'AFN',0,'AFN',6405,'AFN',0,0,239,1,105),(7,'cash','AFN',8854,'AFN',8854,'AFN',0,'AFN',8854,'AFN',0,'AFN',8854,'AFN',0,0,240,1,106),(8,'cash','AFN',2500,'AFN',2500,'AFN',0,'AFN',2500,'AFN',0,'AFN',2500,'AFN',0,0,241,1,NULL),(9,'cash','AFN',180,'AFN',180,'AFN',0,'AFN',180,'AFN',0,'AFN',180,'AFN',0,0,242,1,108),(10,'cash','AFN',11520,'AFN',11520,'AFN',0,'AFN',11520,'AFN',0,'AFN',11520,'AFN',0,0,243,1,108),(11,'cash','AFN',8802,'AFN',8802,'AFN',0,'AFN',8802,'AFN',0,'AFN',8802,'AFN',0,0,244,1,107),(12,'cash','AFN',43755,'AFN',43755,'AFN',0,'AFN',43755,'AFN',0,'AFN',43755,'AFN',0,0,257,1,NULL),(13,'cash','AFN',535,'AFN',535,'AFN',0,'AFN',535,'AFN',0,'AFN',535,'AFN',0,0,258,1,NULL),(14,'cash','AFN',600,'AFN',600,'AFN',0,'AFN',600,'AFN',0,'AFN',600,'AFN',0,0,259,1,109),(15,'cash','AFN',1500,'AFN',1500,'AFN',0,'AFN',1500,'AFN',0,'AFN',1500,'AFN',0,0,260,1,108),(16,'cash','AFN',9926,'AFN',9926,'AFN',0,'AFN',9926,'AFN',0,'AFN',9926,'AFN',0,0,261,1,105),(17,'cash','AFN',10140,'AFN',10140,'AFN',0,'AFN',10140,'AFN',0,'AFN',10140,'AFN',0,0,262,1,108),(18,'cash','AFN',2400,'AFN',2400,'AFN',0,'AFN',2400,'AFN',0,'AFN',2400,'AFN',0,0,263,1,110),(19,'cash','AFN',4526,'AFN',4526,'AFN',0,'AFN',4526,'AFN',0,'AFN',4526,'AFN',0,0,264,1,106),(20,'cash','AFN',6900,'AFN',6900,'AFN',0,'AFN',6900,'AFN',0,'AFN',6900,'AFN',0,0,265,1,NULL),(21,'cash','AFN',5795,'AFN',5795,'AFN',0,'AFN',5795,'AFN',0,'AFN',5795,'AFN',0,0,266,1,111),(22,'cash','AFN',2160,'AFN',2160,'AFN',0,'AFN',2160,'AFN',0,'AFN',2160,'AFN',0,0,292,1,NULL),(23,'cash','AFN',34955,'AFN',34955,'AFN',0,'AFN',34955,'AFN',0,'AFN',34955,'AFN',0,0,293,1,NULL),(24,'cash','AFN',100,'AFN',100,'AFN',0,'AFN',100,'AFN',0,'AFN',100,'AFN',0,0,298,1,108),(25,'cash','AFN',20200,'AFN',20200,'AFN',0,'AFN',20200,'AFN',0,'AFN',20200,'AFN',0,0,303,1,112),(26,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',6400,'AFN',0,'AFN',6400,'AFN',0,1,304,NULL,113),(27,'cash','AFN',1200,'AFN',1200,'AFN',0,'AFN',1200,'AFN',0,'AFN',1200,'AFN',0,0,305,1,NULL),(28,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',3100,'AFN',0,'AFN',3100,'AFN',0,0,306,NULL,102),(29,'cash','AFN',360,'AFN',360,'AFN',0,'AFN',360,'AFN',0,'AFN',360,'AFN',0,0,307,1,108),(30,'cash','AFN',200,'AFN',200,'AFN',0,'AFN',200,'AFN',0,'AFN',200,'AFN',0,0,308,1,106),(32,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',7800,'AFN',0,'AFN',7800,'AFN',0,0,313,NULL,114),(33,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',1818,'AFN',0,'AFN',1818,'AFN',0,0,314,NULL,114),(34,'cash','AFN',2200,'AFN',2200,'AFN',0,'AFN',2200,'AFN',0,'AFN',2200,'AFN',0,0,321,1,108),(35,'cash','AFN',2910,'AFN',2910,'AFN',0,'AFN',2910,'AFN',0,'AFN',2910,'AFN',0,0,326,1,107),(36,'cash','AFN',7655,'AFN',7655,'AFN',0,'AFN',7655,'AFN',0,'AFN',7655,'AFN',0,0,334,1,108),(37,'cash','AFN',6340,'AFN',6340,'AFN',0,'AFN',6340,'AFN',0,'AFN',6340,'AFN',0,0,335,1,108),(38,'cash','AFN',3624,'AFN',3624,'AFN',0,'AFN',3624,'AFN',0,'AFN',3624,'AFN',0,0,336,1,105),(39,'cash','AFN',35510,'AFN',35510,'AFN',0,'AFN',35510,'AFN',0,'AFN',35510,'AFN',0,0,339,1,116),(40,'cash','AFN',10350,'AFN',10350,'AFN',0,'AFN',10350,'AFN',0,'AFN',10350,'AFN',0,0,340,1,108),(41,'cash','AFN',50,'AFN',50,'AFN',0,'AFN',50,'AFN',0,'AFN',50,'AFN',0,0,343,1,108),(42,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',10140,'AFN',0,'AFN',10140,'AFN',0,0,344,NULL,113),(43,'cash','AFN',2909,'AFN',2909,'AFN',0,'AFN',2909,'AFN',0,'AFN',2909,'AFN',0,0,352,1,108),(44,'cash','AFN',170,'AFN',170,'AFN',0,'AFN',170,'AFN',0,'AFN',170,'AFN',0,0,353,1,108),(45,'cash','AFN',2490,'AFN',2490,'AFN',0,'AFN',2490,'AFN',0,'AFN',2490,'AFN',0,0,360,1,107),(46,'cash','AFN',1800,'AFN',1800,'AFN',0,'AFN',1800,'AFN',0,'AFN',1800,'AFN',0,0,362,1,108),(47,'cash','AFN',5650,'AFN',5650,'AFN',0,'AFN',5650,'AFN',0,'AFN',5650,'AFN',0,0,364,1,108),(49,'cash','AFN',90,'AFN',90,'AFN',0,'AFN',90,'AFN',0,'AFN',90,'AFN',0,0,367,1,108),(50,'cash','AFN',450,'AFN',450,'AFN',0,'AFN',450,'AFN',0,'AFN',450,'AFN',0,0,368,1,108),(51,'cash','AFN',1300,'AFN',1300,'AFN',0,'AFN',1300,'AFN',0,'AFN',1300,'AFN',0,0,369,1,108),(52,'cash','AFN',60,'AFN',60,'AFN',0,'AFN',60,'AFN',0,'AFN',60,'AFN',0,0,371,1,108),(53,'cash','AFN',1800,'AFN',1800,'AFN',0,'AFN',1800,'AFN',0,'AFN',1800,'AFN',0,0,374,1,108),(54,'cash','AFN',8496,'AFN',8496,'AFN',0,'AFN',8496,'AFN',0,'AFN',8496,'AFN',0,0,375,1,118),(55,'cash','AFN',18310,'AFN',18310,'AFN',0,'AFN',18310,'AFN',0,'AFN',18310,'AFN',0,0,377,1,107),(56,'cash','AFN',2400,'AFN',2400,'AFN',0,'AFN',2400,'AFN',0,'AFN',2400,'AFN',0,0,378,1,108),(57,'cash','AFN',1650,'AFN',1650,'AFN',0,'AFN',1650,'AFN',0,'AFN',1650,'AFN',0,0,379,1,108),(58,'credit','AFN',500,'AFN',500,'AFN',0,'AFN',2396,'AFN',0,'AFN',2396,'AFN',0,0,380,1,119),(59,'cash','AFN',12299,'AFN',12299,'AFN',0,'AFN',12299,'AFN',0,'AFN',12299,'AFN',0,0,382,1,105),(60,'cash','AFN',28000,'AFN',28000,'AFN',0,'AFN',28000,'AFN',0,'AFN',28000,'AFN',0,0,383,1,108),(61,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',5250,'AFN',0,'AFN',5250,'AFN',0,0,389,NULL,112),(62,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',2600,'AFN',0,'AFN',2600,'AFN',0,1,390,NULL,114),(64,'cash','AFN',33720,'AFN',33720,'AFN',0,'AFN',33720,'AFN',0,'AFN',33720,'AFN',0,0,399,1,108),(65,'cash','AFN',7100,'AFN',7100,'AFN',0,'AFN',7100,'AFN',0,'AFN',7100,'AFN',0,0,400,1,108),(66,'cash','AFN',10600,'AFN',10600,'AFN',0,'AFN',10600,'AFN',0,'AFN',10600,'AFN',0,0,401,1,108),(67,'cash','AFN',7403,'AFN',7403,'AFN',0,'AFN',7403,'AFN',0,'AFN',7403,'AFN',0,0,402,1,108),(68,'cash','AFN',830,'AFN',830,'AFN',0,'AFN',830,'AFN',0,'AFN',830,'AFN',0,0,404,1,107),(69,'cash','AFN',1000,'AFN',1000,'AFN',0,'AFN',1000,'AFN',0,'AFN',1000,'AFN',0,0,405,1,108),(70,'cash','AFN',530,'AFN',530,'AFN',0,'AFN',530,'AFN',0,'AFN',530,'AFN',0,0,406,1,106),(71,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',4700,'AFN',0,'AFN',4700,'AFN',0,0,407,NULL,106),(73,'cash','AFN',3800,'AFN',3800,'AFN',0,'AFN',3800,'AFN',0,'AFN',3800,'AFN',0,0,413,1,108),(74,'cash','AFN',70,'AFN',70,'AFN',0,'AFN',70,'AFN',0,'AFN',70,'AFN',0,0,415,1,108),(75,'cash','AFN',170,'AFN',170,'AFN',0,'AFN',170,'AFN',0,'AFN',170,'AFN',0,0,416,1,108),(76,'cash','AFN',30,'AFN',30,'AFN',0,'AFN',30,'AFN',0,'AFN',30,'AFN',0,0,417,1,108),(77,'cash','AFN',34950,'AFN',34950,'AFN',0,'AFN',34950,'AFN',0,'AFN',34950,'AFN',0,0,423,1,108),(78,'cash','AFN',360,'AFN',360,'AFN',0,'AFN',360,'AFN',0,'AFN',360,'AFN',0,0,426,1,108),(79,'cash','AFN',4550,'AFN',4550,'AFN',0,'AFN',4550,'AFN',0,'AFN',4550,'AFN',0,0,427,1,108),(80,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',1700,'AFN',0,'AFN',1700,'AFN',0,0,430,NULL,83),(81,'cash','AFN',1100,'AFN',1100,'AFN',0,'AFN',1100,'AFN',0,'AFN',1100,'AFN',0,0,431,1,121),(82,'cash','AFN',2720,'AFN',2720,'AFN',0,'AFN',2720,'AFN',0,'AFN',2720,'AFN',0,0,432,1,108),(83,'cash','AFN',9589,'AFN',9589,'AFN',0,'AFN',9589,'AFN',0,'AFN',9589,'AFN',0,0,434,1,105),(84,'cash','AFN',1600,'AFN',1600,'AFN',0,'AFN',1600,'AFN',0,'AFN',1600,'AFN',0,0,442,1,106),(85,'cash','AFN',12275,'AFN',12275,'AFN',0,'AFN',12275,'AFN',0,'AFN',12275,'AFN',0,0,444,1,106),(86,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',300,'AFN',0,'AFN',300,'AFN',0,0,450,NULL,85),(87,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',3000,'AFN',0,'AFN',3000,'AFN',0,0,455,NULL,112),(88,'cash','AFN',1350,'AFN',1350,'AFN',0,'AFN',1350,'AFN',0,'AFN',1350,'AFN',0,0,457,1,108),(89,'cash','AFN',1200,'AFN',1200,'AFN',0,'AFN',1200,'AFN',0,'AFN',1200,'AFN',0,0,461,1,108),(90,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',2400,'AFN',0,'AFN',2400,'AFN',0,0,462,NULL,83),(91,'cash','AFN',650,'AFN',650,'AFN',0,'AFN',650,'AFN',0,'AFN',650,'AFN',0,0,463,1,108),(92,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',8000,'AFN',0,'AFN',8000,'AFN',0,0,465,NULL,118),(93,'cash','AFN',2330,'AFN',2330,'AFN',0,'AFN',2330,'AFN',0,'AFN',2330,'AFN',0,0,477,1,108),(94,'cash','AFN',550,'AFN',550,'AFN',0,'AFN',550,'AFN',0,'AFN',550,'AFN',0,0,479,1,108),(95,'credit','USD',0,'AFN',0,'AFN',0,'USD',260,'USD',0,'USD',16744,'AFN',0,0,481,NULL,82),(96,'cash','AFN',1050,'AFN',1050,'AFN',0,'AFN',1050,'AFN',0,'AFN',1050,'AFN',0,0,483,1,108),(97,'cash','AFN',3000,'AFN',3000,'AFN',0,'AFN',3000,'AFN',0,'AFN',3000,'AFN',0,0,485,1,108),(98,'cash','AFN',4040,'AFN',4040,'AFN',0,'AFN',4040,'AFN',0,'AFN',4040,'AFN',0,0,491,1,105),(99,'cash','AFN',8310,'AFN',8310,'AFN',0,'AFN',8310,'AFN',0,'AFN',8310,'AFN',0,0,493,1,108),(100,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',9300,'AFN',0,'AFN',9300,'AFN',0,1,501,NULL,114),(101,'cash','AFN',600,'AFN',600,'AFN',0,'AFN',600,'AFN',0,'AFN',600,'AFN',0,0,502,1,108),(102,'cash','AFN',27384,'AFN',27384,'AFN',0,'AFN',27384,'AFN',0,'AFN',27384,'AFN',0,0,503,1,106),(104,'cash','AFN',900,'AFN',900,'AFN',0,'AFN',900,'AFN',0,'AFN',900,'AFN',0,0,514,1,107),(105,'cash','AFN',1150,'AFN',1150,'AFN',0,'AFN',1150,'AFN',0,'AFN',1150,'AFN',0,0,520,1,108),(106,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',7500,'AFN',0,'AFN',7500,'AFN',0,0,522,NULL,85),(107,'cash','AFN',330,'AFN',330,'AFN',0,'AFN',330,'AFN',0,'AFN',330,'AFN',0,0,525,1,108),(108,'credit','AFN',400,'AFN',400,'AFN',0,'AFN',2700,'AFN',0,'AFN',2700,'AFN',0,0,527,1,70),(109,'cash','AFN',1200,'AFN',1200,'AFN',0,'AFN',1200,'AFN',0,'AFN',1200,'AFN',0,0,530,1,108),(110,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',2400,'AFN',0,'AFN',2400,'AFN',0,1,532,NULL,114),(111,'cash','AFN',29188,'AFN',29188,'AFN',0,'AFN',29188,'AFN',0,'AFN',29188,'AFN',0,0,538,1,108),(112,'cash','AFN',349,'AFN',349,'AFN',0,'AFN',349,'AFN',0,'AFN',349,'AFN',0,0,540,1,107),(113,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',5500,'AFN',0,'AFN',5500,'AFN',0,0,544,NULL,118),(114,'cash','AFN',600,'AFN',600,'AFN',0,'AFN',600,'AFN',0,'AFN',600,'AFN',1,0,551,1,108),(115,'cash','AFN',19588,'AFN',19588,'AFN',0,'AFN',19588,'AFN',0,'AFN',19588,'AFN',0,0,552,1,105),(116,'cash','AFN',1900,'AFN',1900,'AFN',0,'AFN',1900,'AFN',0,'AFN',1900,'AFN',0,0,558,1,108),(117,'cash','AFN',1550,'AFN',1550,'AFN',0,'AFN',1550,'AFN',0,'AFN',1550,'AFN',0,0,559,1,108),(118,'cash','AFN',650,'AFN',650,'AFN',0,'AFN',650,'AFN',0,'AFN',650,'AFN',0,0,560,1,NULL),(119,'credit','AFN',0,'AFN',0,'AFN',0,'AFN',2550,'AFN',0,'AFN',2550,'AFN',0,1,561,NULL,90),(120,'cash','AFN',1800,'AFN',1800,'AFN',0,'AFN',1800,'AFN',0,'AFN',1800,'AFN',0,0,563,1,108),(121,'cash','AFN',1450,'AFN',1450,'AFN',0,'AFN',1450,'AFN',0,'AFN',1450,'AFN',0,0,564,1,108),(122,'cash','AFN',4230,'AFN',4230,'AFN',0,'AFN',4230,'AFN',0,'AFN',4230,'AFN',0,0,565,1,111),(123,'cash','AFN',80,'AFN',80,'AFN',0,'AFN',80,'AFN',0,'AFN',80,'AFN',0,0,566,1,107),(124,'cash','AFN',1040,'AFN',1040,'AFN',0,'AFN',1040,'AFN',0,'AFN',1040,'AFN',0,0,567,1,108),(125,'cash','AFN',11150,'AFN',11150,'AFN',0,'AFN',11150,'AFN',0,'AFN',11150,'AFN',0,0,568,1,108),(126,'cash','AFN',1200,'AFN',1200,'AFN',0,'AFN',1200,'AFN',0,'AFN',1200,'AFN',0,0,570,1,108),(127,'cash','AFN',51880,'AFN',51880,'AFN',0,'AFN',51880,'AFN',0,'AFN',51880,'AFN',0,0,582,1,108),(128,'cash','AFN',1750,'AFN',1750,'AFN',0,'AFN',1750,'AFN',0,'AFN',1750,'AFN',0,0,583,1,108);
/*!40000 ALTER TABLE `stocksales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocktransfercostdists`
--

DROP TABLE IF EXISTS `stocktransfercostdists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocktransfercostdists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ratio` double NOT NULL,
  `stockTransferId` int(11) DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stockTransferId` (`stockTransferId`),
  KEY `stockItemId` (`stockItemId`),
  CONSTRAINT `stocktransfercostdists_ibfk_1` FOREIGN KEY (`stockTransferId`) REFERENCES `stocktransfers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stocktransfercostdists_ibfk_2` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocktransfercostdists`
--

LOCK TABLES `stocktransfercostdists` WRITE;
/*!40000 ALTER TABLE `stocktransfercostdists` DISABLE KEYS */;
/*!40000 ALTER TABLE `stocktransfercostdists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocktransfercosts`
--

DROP TABLE IF EXISTS `stocktransfercosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocktransfercosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `stockTransferId` int(11) DEFAULT NULL,
  `accountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stockTransferId` (`stockTransferId`),
  KEY `accountId` (`accountId`),
  CONSTRAINT `stocktransfercosts_ibfk_1` FOREIGN KEY (`stockTransferId`) REFERENCES `stocktransfers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stocktransfercosts_ibfk_2` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocktransfercosts`
--

LOCK TABLES `stocktransfercosts` WRITE;
/*!40000 ALTER TABLE `stocktransfercosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `stocktransfercosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocktransferitems`
--

DROP TABLE IF EXISTS `stocktransferitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocktransferitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` double NOT NULL,
  `baseQuantity` double NOT NULL,
  `unit` varchar(255) NOT NULL,
  `stockTransferId` int(11) DEFAULT NULL,
  `stockItemId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stockTransferId` (`stockTransferId`),
  KEY `stockItemId` (`stockItemId`),
  CONSTRAINT `stocktransferitems_ibfk_1` FOREIGN KEY (`stockTransferId`) REFERENCES `stocktransfers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stocktransferitems_ibfk_2` FOREIGN KEY (`stockItemId`) REFERENCES `stockitems` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocktransferitems`
--

LOCK TABLES `stocktransferitems` WRITE;
/*!40000 ALTER TABLE `stocktransferitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `stocktransferitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocktransfers`
--

DROP TABLE IF EXISTS `stocktransfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocktransfers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journalId` int(11) DEFAULT NULL,
  `fromStockAccountId` int(11) DEFAULT NULL,
  `toStockAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `fromStockAccountId` (`fromStockAccountId`),
  KEY `toStockAccountId` (`toStockAccountId`),
  CONSTRAINT `stocktransfers_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stocktransfers_ibfk_2` FOREIGN KEY (`fromStockAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `stocktransfers_ibfk_3` FOREIGN KEY (`toStockAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocktransfers`
--

LOCK TABLES `stocktransfers` WRITE;
/*!40000 ALTER TABLE `stocktransfers` DISABLE KEYS */;
/*!40000 ALTER TABLE `stocktransfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` char(2) NOT NULL,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `journalId` int(11) DEFAULT NULL,
  `accountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `accountId` (`accountId`),
  KEY `transactions_code` (`code`),
  KEY `transactions_type` (`type`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1419 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (47,'dr',11583,'AFN',11583,'AFN',NULL,20,2),(48,'cr',11583,'AFN',11583,'AFN',NULL,20,14),(49,'dr',1500,'AFN',1500,'AFN',NULL,21,2),(50,'cr',1500,'AFN',1500,'AFN',NULL,21,14),(51,'dr',1368,'AFN',1368,'AFN',NULL,22,2),(52,'cr',1368,'AFN',1368,'AFN',NULL,22,14),(53,'dr',325,'AFN',325,'AFN',NULL,23,2),(54,'cr',325,'AFN',325,'AFN',NULL,23,14),(55,'dr',1197,'AFN',1197,'AFN',NULL,24,2),(56,'cr',1197,'AFN',1197,'AFN',NULL,24,14),(59,'dr',7320,'AFN',7320,'AFN',NULL,26,2),(60,'cr',7320,'AFN',7320,'AFN',NULL,26,14),(61,'dr',81367,'AFN',81367,'AFN',NULL,27,2),(62,'cr',81367,'AFN',81367,'AFN',NULL,27,14),(63,'dr',8800,'AFN',8800,'AFN',NULL,28,2),(64,'cr',8800,'AFN',8800,'AFN',NULL,28,14),(65,'dr',8070,'AFN',8070,'AFN',NULL,29,2),(66,'cr',8070,'AFN',8070,'AFN',NULL,29,14),(67,'dr',1500,'AFN',1500,'AFN',NULL,30,2),(68,'cr',1500,'AFN',1500,'AFN',NULL,30,14),(69,'dr',3021,'AFN',3021,'AFN',NULL,31,2),(70,'cr',3021,'AFN',3021,'AFN',NULL,31,14),(71,'dr',35175,'AFN',35175,'AFN',NULL,32,2),(72,'cr',35175,'AFN',35175,'AFN',NULL,32,14),(73,'dr',12265,'AFN',12265,'AFN',NULL,33,2),(74,'cr',12265,'AFN',12265,'AFN',NULL,33,14),(75,'dr',9208,'AFN',9208,'AFN',NULL,34,2),(76,'cr',9208,'AFN',9208,'AFN',NULL,34,14),(77,'dr',5760,'AFN',5760,'AFN',NULL,35,2),(78,'cr',5760,'AFN',5760,'AFN',NULL,35,14),(79,'dr',3500,'AFN',3500,'AFN',NULL,36,2),(80,'cr',3500,'AFN',3500,'AFN',NULL,36,14),(81,'dr',1836,'AFN',1836,'AFN',NULL,37,2),(82,'cr',1836,'AFN',1836,'AFN',NULL,37,14),(83,'dr',20196,'AFN',20196,'AFN',NULL,38,2),(84,'cr',20196,'AFN',20196,'AFN',NULL,38,14),(85,'dr',151,'AFN',151,'AFN',NULL,39,2),(86,'cr',151,'AFN',151,'AFN',NULL,39,14),(87,'dr',3375,'AFN',3375,'AFN',NULL,40,2),(88,'cr',3375,'AFN',3375,'AFN',NULL,40,14),(89,'dr',6750,'AFN',6750,'AFN',NULL,41,2),(90,'cr',6750,'AFN',6750,'AFN',NULL,41,14),(91,'dr',4340,'AFN',4340,'AFN',NULL,42,2),(92,'cr',4340,'AFN',4340,'AFN',NULL,42,14),(93,'dr',2608,'AFN',2608,'AFN',NULL,43,2),(94,'cr',2608,'AFN',2608,'AFN',NULL,43,14),(97,'dr',9372,'AFN',9372,'AFN',NULL,45,2),(98,'cr',9372,'AFN',9372,'AFN',NULL,45,14),(99,'dr',150,'AFN',150,'AFN',NULL,46,2),(100,'cr',150,'AFN',150,'AFN',NULL,46,14),(101,'dr',13640,'AFN',13640,'AFN',NULL,47,2),(102,'cr',13640,'AFN',13640,'AFN',NULL,47,14),(103,'dr',8085,'AFN',8085,'AFN',NULL,48,2),(104,'cr',8085,'AFN',8085,'AFN',NULL,48,14),(105,'dr',9552,'AFN',9552,'AFN',NULL,49,2),(106,'cr',9552,'AFN',9552,'AFN',NULL,49,14),(107,'dr',3206,'AFN',3206,'AFN',NULL,50,2),(108,'cr',3206,'AFN',3206,'AFN',NULL,50,14),(109,'dr',18377,'AFN',18377,'AFN',NULL,51,2),(110,'cr',18377,'AFN',18377,'AFN',NULL,51,14),(111,'dr',9351,'AFN',9351,'AFN',NULL,52,2),(112,'cr',9351,'AFN',9351,'AFN',NULL,52,14),(115,'dr',1571,'AFN',1571,'AFN',NULL,54,2),(116,'cr',1571,'AFN',1571,'AFN',NULL,54,14),(117,'dr',15710,'AFN',15710,'AFN',NULL,53,2),(118,'cr',15710,'AFN',15710,'AFN',NULL,53,14),(119,'dr',9390,'AFN',9390,'AFN',NULL,55,2),(120,'cr',9390,'AFN',9390,'AFN',NULL,55,14),(121,'dr',4002,'AFN',4002,'AFN',NULL,56,2),(122,'cr',4002,'AFN',4002,'AFN',NULL,56,14),(123,'dr',3843,'AFN',3843,'AFN',NULL,57,2),(124,'cr',3843,'AFN',3843,'AFN',NULL,57,14),(125,'dr',6620,'AFN',6620,'AFN',NULL,58,2),(126,'cr',6620,'AFN',6620,'AFN',NULL,58,14),(127,'dr',5540,'AFN',5540,'AFN',NULL,59,2),(128,'cr',5540,'AFN',5540,'AFN',NULL,59,14),(129,'dr',13668,'AFN',13668,'AFN',NULL,60,2),(130,'cr',13668,'AFN',13668,'AFN',NULL,60,14),(131,'dr',21276,'AFN',21276,'AFN',NULL,61,2),(132,'cr',21276,'AFN',21276,'AFN',NULL,61,14),(133,'dr',24516,'AFN',24516,'AFN',NULL,62,2),(134,'cr',24516,'AFN',24516,'AFN',NULL,62,14),(135,'dr',14397,'AFN',14397,'AFN',NULL,63,2),(136,'cr',14397,'AFN',14397,'AFN',NULL,63,14),(137,'dr',16304,'AFN',16304,'AFN',NULL,64,2),(138,'cr',16304,'AFN',16304,'AFN',NULL,64,14),(139,'dr',3948,'AFN',3948,'AFN',NULL,65,2),(140,'cr',3948,'AFN',3948,'AFN',NULL,65,14),(143,'dr',7202,'AFN',7202,'AFN',NULL,67,2),(144,'cr',7202,'AFN',7202,'AFN',NULL,67,14),(147,'dr',13130,'AFN',13130,'AFN',NULL,68,2),(148,'cr',13130,'AFN',13130,'AFN',NULL,68,14),(149,'dr',7692,'AFN',7692,'AFN',NULL,69,2),(150,'cr',7692,'AFN',7692,'AFN',NULL,69,14),(151,'dr',4869,'AFN',4869,'AFN',NULL,70,2),(152,'cr',4869,'AFN',4869,'AFN',NULL,70,14),(153,'dr',8660,'AFN',8660,'AFN',NULL,71,2),(154,'cr',8660,'AFN',8660,'AFN',NULL,71,14),(155,'dr',4000,'AFN',4000,'AFN',NULL,72,2),(156,'cr',4000,'AFN',4000,'AFN',NULL,72,14),(157,'dr',16316,'AFN',16316,'AFN',NULL,73,2),(158,'cr',16316,'AFN',16316,'AFN',NULL,73,14),(159,'dr',3850,'AFN',3850,'AFN',NULL,74,2),(160,'cr',3850,'AFN',3850,'AFN',NULL,74,14),(161,'dr',2700,'AFN',2700,'AFN',NULL,75,2),(162,'cr',2700,'AFN',2700,'AFN',NULL,75,14),(163,'dr',21125,'AFN',21125,'AFN',NULL,76,2),(164,'cr',21125,'AFN',21125,'AFN',NULL,76,14),(165,'dr',7500,'AFN',7500,'AFN',NULL,77,2),(166,'cr',7500,'AFN',7500,'AFN',NULL,77,14),(167,'dr',4485,'AFN',4485,'AFN',NULL,78,2),(168,'cr',4485,'AFN',4485,'AFN',NULL,78,14),(169,'dr',1600,'AFN',1600,'AFN',NULL,79,2),(170,'cr',1600,'AFN',1600,'AFN',NULL,79,14),(171,'dr',3100,'AFN',3100,'AFN',NULL,80,2),(172,'cr',3100,'AFN',3100,'AFN',NULL,80,14),(173,'dr',3588,'AFN',3588,'AFN',NULL,81,2),(174,'cr',3588,'AFN',3588,'AFN',NULL,81,14),(175,'dr',3091,'AFN',3091,'AFN',NULL,82,2),(176,'cr',3091,'AFN',3091,'AFN',NULL,82,14),(177,'dr',1219,'AFN',1219,'AFN',NULL,83,2),(178,'cr',1219,'AFN',1219,'AFN',NULL,83,14),(179,'dr',2470,'AFN',2470,'AFN',NULL,84,2),(180,'cr',2470,'AFN',2470,'AFN',NULL,84,14),(181,'dr',4675,'AFN',4675,'AFN',NULL,85,2),(182,'cr',4675,'AFN',4675,'AFN',NULL,85,14),(183,'dr',3894,'AFN',3894,'AFN',NULL,86,2),(184,'cr',3894,'AFN',3894,'AFN',NULL,86,14),(185,'dr',540,'AFN',540,'AFN',NULL,87,2),(186,'cr',540,'AFN',540,'AFN',NULL,87,14),(187,'dr',2180,'AFN',2180,'AFN',NULL,88,2),(188,'cr',2180,'AFN',2180,'AFN',NULL,88,14),(189,'dr',5096,'AFN',5096,'AFN',NULL,89,2),(190,'cr',5096,'AFN',5096,'AFN',NULL,89,14),(191,'dr',2536,'AFN',2536,'AFN',NULL,90,2),(192,'cr',2536,'AFN',2536,'AFN',NULL,90,14),(193,'dr',1125,'AFN',1125,'AFN',NULL,91,2),(194,'cr',1125,'AFN',1125,'AFN',NULL,91,14),(195,'dr',471,'AFN',471,'AFN',NULL,92,2),(196,'cr',471,'AFN',471,'AFN',NULL,92,14),(197,'dr',1170,'AFN',1170,'AFN',NULL,93,2),(198,'cr',1170,'AFN',1170,'AFN',NULL,93,14),(199,'dr',2244,'AFN',2244,'AFN',NULL,94,2),(200,'cr',2244,'AFN',2244,'AFN',NULL,94,14),(201,'dr',9708,'AFN',9708,'AFN',NULL,95,2),(202,'cr',9708,'AFN',9708,'AFN',NULL,95,14),(203,'dr',12132,'AFN',12132,'AFN',NULL,96,2),(204,'cr',12132,'AFN',12132,'AFN',NULL,96,14),(205,'dr',12132,'AFN',12132,'AFN',NULL,97,2),(206,'cr',12132,'AFN',12132,'AFN',NULL,97,14),(207,'dr',4551,'AFN',4551,'AFN',NULL,98,2),(208,'cr',4551,'AFN',4551,'AFN',NULL,98,14),(209,'dr',3538,'AFN',3538,'AFN',NULL,99,2),(210,'cr',3538,'AFN',3538,'AFN',NULL,99,14),(211,'dr',3944,'AFN',3944,'AFN',NULL,100,2),(212,'cr',3944,'AFN',3944,'AFN',NULL,100,14),(213,'dr',540,'AFN',540,'AFN',NULL,101,2),(214,'cr',540,'AFN',540,'AFN',NULL,101,14),(215,'dr',2440,'AFN',2440,'AFN',NULL,102,2),(216,'cr',2440,'AFN',2440,'AFN',NULL,102,14),(217,'dr',3100,'AFN',3100,'AFN',NULL,103,2),(218,'cr',3100,'AFN',3100,'AFN',NULL,103,14),(219,'dr',130,'AFN',130,'AFN',NULL,104,2),(220,'cr',130,'AFN',130,'AFN',NULL,104,14),(221,'dr',1020,'AFN',1020,'AFN',NULL,105,2),(222,'cr',1020,'AFN',1020,'AFN',NULL,105,14),(223,'dr',1467,'AFN',1467,'AFN',NULL,106,2),(224,'cr',1467,'AFN',1467,'AFN',NULL,106,14),(225,'dr',150,'AFN',150,'AFN',NULL,107,2),(226,'cr',150,'AFN',150,'AFN',NULL,107,14),(227,'dr',300,'AFN',300,'AFN',NULL,108,2),(228,'cr',300,'AFN',300,'AFN',NULL,108,14),(229,'dr',5760,'AFN',5760,'AFN',NULL,109,2),(230,'cr',5760,'AFN',5760,'AFN',NULL,109,14),(231,'dr',150,'AFN',150,'AFN',NULL,110,2),(232,'cr',150,'AFN',150,'AFN',NULL,110,14),(233,'dr',218,'AFN',218,'AFN',NULL,111,2),(234,'cr',218,'AFN',218,'AFN',NULL,111,14),(235,'dr',714,'AFN',714,'AFN',NULL,112,2),(236,'cr',714,'AFN',714,'AFN',NULL,112,14),(237,'dr',670,'AFN',670,'AFN',NULL,113,2),(238,'cr',670,'AFN',670,'AFN',NULL,113,14),(239,'dr',1150,'AFN',1150,'AFN',NULL,114,2),(240,'cr',1150,'AFN',1150,'AFN',NULL,114,14),(241,'dr',34542,'AFN',34542,'AFN',NULL,115,2),(242,'cr',34542,'AFN',34542,'AFN',NULL,115,14),(243,'dr',456,'AFN',456,'AFN',NULL,116,2),(244,'cr',456,'AFN',456,'AFN',NULL,116,14),(245,'dr',4725,'AFN',4725,'AFN',NULL,117,2),(246,'cr',4725,'AFN',4725,'AFN',NULL,117,14),(247,'dr',4575,'AFN',4575,'AFN',NULL,118,2),(248,'cr',4575,'AFN',4575,'AFN',NULL,118,14),(249,'dr',252,'AFN',252,'AFN',NULL,119,2),(250,'cr',252,'AFN',252,'AFN',NULL,119,14),(251,'dr',1754,'AFN',1754,'AFN',NULL,120,2),(252,'cr',1754,'AFN',1754,'AFN',NULL,120,14),(253,'dr',1590,'AFN',1590,'AFN',NULL,121,2),(254,'cr',1590,'AFN',1590,'AFN',NULL,121,14),(255,'dr',3672,'AFN',3672,'AFN',NULL,122,2),(256,'cr',3672,'AFN',3672,'AFN',NULL,122,14),(257,'dr',2860,'AFN',2860,'AFN',NULL,123,2),(258,'cr',2860,'AFN',2860,'AFN',NULL,123,14),(259,'dr',1756,'AFN',1756,'AFN',NULL,124,2),(260,'cr',1756,'AFN',1756,'AFN',NULL,124,14),(261,'dr',4950,'AFN',4950,'AFN',NULL,125,2),(262,'cr',4950,'AFN',4950,'AFN',NULL,125,14),(263,'dr',3240,'AFN',3240,'AFN',NULL,126,2),(264,'cr',3240,'AFN',3240,'AFN',NULL,126,14),(265,'dr',3000,'AFN',3000,'AFN',NULL,127,2),(266,'cr',3000,'AFN',3000,'AFN',NULL,127,14),(267,'dr',7000,'AFN',7000,'AFN',NULL,128,2),(268,'cr',7000,'AFN',7000,'AFN',NULL,128,14),(269,'dr',1118,'AFN',1118,'AFN',NULL,129,2),(270,'cr',1118,'AFN',1118,'AFN',NULL,129,14),(271,'dr',1992,'AFN',1992,'AFN',NULL,130,2),(272,'cr',1992,'AFN',1992,'AFN',NULL,130,14),(273,'dr',3150,'AFN',3150,'AFN',NULL,131,2),(274,'cr',3150,'AFN',3150,'AFN',NULL,131,14),(275,'dr',426,'AFN',426,'AFN',NULL,132,2),(276,'cr',426,'AFN',426,'AFN',NULL,132,14),(277,'dr',560,'AFN',560,'AFN',NULL,133,2),(278,'cr',560,'AFN',560,'AFN',NULL,133,14),(279,'dr',400,'AFN',400,'AFN',NULL,134,2),(280,'cr',400,'AFN',400,'AFN',NULL,134,14),(281,'dr',327,'AFN',327,'AFN',NULL,135,2),(282,'cr',327,'AFN',327,'AFN',NULL,135,14),(283,'dr',250,'AFN',250,'AFN',NULL,136,2),(284,'cr',250,'AFN',250,'AFN',NULL,136,14),(285,'dr',2060,'AFN',2060,'AFN',NULL,137,2),(286,'cr',2060,'AFN',2060,'AFN',NULL,137,14),(287,'dr',328,'AFN',328,'AFN',NULL,138,2),(288,'cr',328,'AFN',328,'AFN',NULL,138,14),(289,'dr',970,'AFN',970,'AFN',NULL,139,2),(290,'cr',970,'AFN',970,'AFN',NULL,139,14),(291,'dr',1216,'AFN',1216,'AFN',NULL,140,2),(292,'cr',1216,'AFN',1216,'AFN',NULL,140,14),(293,'dr',4615,'AFN',4615,'AFN',NULL,141,2),(294,'cr',4615,'AFN',4615,'AFN',NULL,141,14),(295,'dr',700,'AFN',700,'AFN',NULL,142,2),(296,'cr',700,'AFN',700,'AFN',NULL,142,14),(297,'dr',987,'AFN',987,'AFN',NULL,143,2),(298,'cr',987,'AFN',987,'AFN',NULL,143,14),(299,'dr',852,'AFN',852,'AFN',NULL,144,2),(300,'cr',852,'AFN',852,'AFN',NULL,144,14),(301,'dr',3165,'AFN',3165,'AFN',NULL,145,2),(302,'cr',3165,'AFN',3165,'AFN',NULL,145,14),(305,'dr',5000,'AFN',5000,'AFN',NULL,147,2),(306,'cr',5000,'AFN',5000,'AFN',NULL,147,14),(307,'dr',7000,'AFN',7000,'AFN',NULL,146,2),(308,'cr',7000,'AFN',7000,'AFN',NULL,146,14),(309,'dr',354,'AFN',354,'AFN',NULL,148,2),(310,'cr',354,'AFN',354,'AFN',NULL,148,14),(313,'dr',308,'AFN',308,'AFN',NULL,150,2),(314,'cr',308,'AFN',308,'AFN',NULL,150,14),(317,'dr',694,'AFN',694,'AFN',NULL,152,2),(318,'cr',694,'AFN',694,'AFN',NULL,152,14),(319,'dr',500,'AFN',500,'AFN',NULL,153,2),(320,'cr',500,'AFN',500,'AFN',NULL,153,14),(321,'dr',255,'AFN',255,'AFN',NULL,154,2),(322,'cr',255,'AFN',255,'AFN',NULL,154,14),(323,'dr',258,'AFN',258,'AFN',NULL,155,2),(324,'cr',258,'AFN',258,'AFN',NULL,155,14),(325,'dr',242,'AFN',242,'AFN',NULL,156,2),(326,'cr',242,'AFN',242,'AFN',NULL,156,14),(327,'dr',209,'AFN',209,'AFN',NULL,157,2),(328,'cr',209,'AFN',209,'AFN',NULL,157,14),(329,'dr',470,'AFN',470,'AFN',NULL,158,2),(330,'cr',470,'AFN',470,'AFN',NULL,158,14),(331,'dr',608,'AFN',608,'AFN',NULL,159,2),(332,'cr',608,'AFN',608,'AFN',NULL,159,14),(333,'dr',130,'AFN',130,'AFN',NULL,160,2),(334,'cr',130,'AFN',130,'AFN',NULL,160,14),(335,'dr',700,'AFN',700,'AFN',NULL,161,2),(336,'cr',700,'AFN',700,'AFN',NULL,161,14),(337,'dr',480,'AFN',480,'AFN',NULL,162,2),(338,'cr',480,'AFN',480,'AFN',NULL,162,14),(339,'dr',10344,'AFN',10344,'AFN',NULL,163,2),(340,'cr',10344,'AFN',10344,'AFN',NULL,163,14),(341,'dr',3864,'AFN',3864,'AFN',NULL,164,2),(342,'cr',3864,'AFN',3864,'AFN',NULL,164,14),(343,'dr',1365,'AFN',1365,'AFN',NULL,165,2),(344,'cr',1365,'AFN',1365,'AFN',NULL,165,14),(345,'dr',2210,'AFN',2210,'AFN',NULL,166,2),(346,'cr',2210,'AFN',2210,'AFN',NULL,166,14),(347,'dr',1106,'AFN',1106,'AFN',NULL,167,2),(348,'cr',1106,'AFN',1106,'AFN',NULL,167,14),(349,'dr',1000,'AFN',1000,'AFN',NULL,168,2),(350,'cr',1000,'AFN',1000,'AFN',NULL,168,14),(351,'dr',1520,'AFN',1520,'AFN',NULL,169,2),(352,'cr',1520,'AFN',1520,'AFN',NULL,169,14),(353,'dr',1733,'AFN',1733,'AFN',NULL,170,2),(354,'cr',1733,'AFN',1733,'AFN',NULL,170,14),(355,'dr',2432,'AFN',2432,'AFN',NULL,171,2),(356,'cr',2432,'AFN',2432,'AFN',NULL,171,14),(357,'dr',6116,'AFN',6116,'AFN',NULL,172,2),(358,'cr',6116,'AFN',6116,'AFN',NULL,172,14),(359,'dr',6000,'AFN',6000,'AFN',NULL,173,2),(360,'cr',6000,'AFN',6000,'AFN',NULL,173,14),(363,'cr',77050,'AFN',77050,'AFN',NULL,175,77),(364,'dr',77050,'AFN',77050,'AFN',NULL,175,14),(367,'dr',26438,'AFN',26438,'AFN',NULL,177,61),(368,'cr',26438,'AFN',26438,'AFN',NULL,177,14),(369,'dr',15050,'AFN',15050,'AFN',NULL,178,60),(370,'cr',15050,'AFN',15050,'AFN',NULL,178,14),(371,'dr',8100,'AFN',8100,'AFN',NULL,179,62),(372,'cr',8100,'AFN',8100,'AFN',NULL,179,14),(373,'dr',35000,'AFN',35000,'AFN',NULL,180,63),(374,'cr',35000,'AFN',35000,'AFN',NULL,180,14),(375,'dr',5248,'AFN',5248,'AFN',NULL,181,64),(376,'cr',5248,'AFN',5248,'AFN',NULL,181,14),(377,'dr',1500,'AFN',1500,'AFN',NULL,182,65),(378,'cr',1500,'AFN',1500,'AFN',NULL,182,14),(379,'dr',2072,'AFN',2072,'AFN',NULL,183,66),(380,'cr',2072,'AFN',2072,'AFN',NULL,183,14),(381,'dr',7472,'AFN',7472,'AFN',NULL,184,67),(382,'cr',7472,'AFN',7472,'AFN',NULL,184,14),(383,'dr',13000,'AFN',13000,'AFN',NULL,185,68),(384,'cr',13000,'AFN',13000,'AFN',NULL,185,14),(385,'dr',15000,'AFN',15000,'AFN',NULL,186,92),(386,'cr',15000,'AFN',15000,'AFN',NULL,186,14),(387,'dr',5000,'AFN',5000,'AFN',NULL,187,69),(388,'cr',5000,'AFN',5000,'AFN',NULL,187,14),(389,'dr',72900,'AFN',72900,'AFN',NULL,188,70),(390,'cr',72900,'AFN',72900,'AFN',NULL,188,14),(391,'dr',8500,'AFN',8500,'AFN',NULL,189,71),(392,'cr',8500,'AFN',8500,'AFN',NULL,189,14),(393,'dr',24500,'AFN',24500,'AFN',NULL,190,72),(394,'cr',24500,'AFN',24500,'AFN',NULL,190,14),(395,'cr',19500,'USD',1271400,'AFN',NULL,191,75),(396,'dr',19500,'USD',1271400,'AFN',NULL,191,14),(397,'cr',2000,'USD',130400,'AFN',NULL,192,74),(398,'dr',2000,'USD',130400,'AFN',NULL,192,14),(399,'cr',1500,'USD',97800,'AFN',NULL,193,73),(400,'dr',1500,'USD',97800,'AFN',NULL,193,14),(403,'cr',60,'AFN',60,'AFN',NULL,194,93),(404,'dr',60,'AFN',60,'AFN',NULL,194,14),(417,'dr',8109,'AFN',8109,'AFN',NULL,44,2),(418,'cr',8109,'AFN',8109,'AFN',NULL,44,14),(419,'dr',510449,'AFN',510449,'AFN',NULL,196,10),(420,'cr',510449,'AFN',510449,'AFN',NULL,196,1),(455,'dr',158700,'AFN',158700,'AFN',NULL,213,56),(456,'cr',158700,'AFN',158700,'AFN',NULL,213,14),(457,'dr',190540,'AFN',190540,'AFN',NULL,214,95),(458,'cr',190540,'AFN',190540,'AFN',NULL,214,14),(459,'dr',735,'AFN',735,'AFN',NULL,149,2),(460,'cr',735,'AFN',735,'AFN',NULL,149,14),(473,'cr',536365.05,'AFN',536365.05,'AFN',NULL,221,1),(474,'dr',536365.05,'AFN',536365.05,'AFN',NULL,221,14),(477,'cr',23043.3,'USD',1502423.16,'AFN',NULL,223,14),(478,'dr',1502423.16,'AFN',1502423.16,'AFN',NULL,223,14),(505,'dr',203000,'AFN',203000,'AFN',NULL,197,10),(506,'cr',203000,'AFN',203000,'AFN',NULL,197,1),(507,'dr',715280,'AFN',715280,'AFN',NULL,200,1),(508,'cr',715280,'AFN',715280,'AFN',NULL,200,14),(517,'cr',14427.79,'AFN',14427.79,'AFN',NULL,226,1),(518,'dr',14427.79,'AFN',14427.79,'AFN',NULL,226,14),(521,'dr',92373,'AFN',92373,'AFN',NULL,195,1),(522,'cr',92373,'AFN',92373,'AFN',NULL,195,14),(577,'dr',9217.32,'AFN',9217.32,'AFN',NULL,227,97),(578,'cr',9217.32,'AFN',9217.32,'AFN',NULL,227,1),(597,'dr',2500,'AFN',2500,'AFN',NULL,241,1),(598,'cr',2500,'AFN',2500,'AFN',NULL,241,9),(599,'dr',8854,'AFN',8854,'AFN',NULL,240,1),(600,'cr',8854,'AFN',8854,'AFN',NULL,240,9),(601,'dr',6405,'AFN',6405,'AFN',NULL,239,1),(602,'cr',6405,'AFN',6405,'AFN',NULL,239,9),(603,'dr',1600,'AFN',1600,'AFN',NULL,238,1),(604,'cr',1600,'AFN',1600,'AFN',NULL,238,9),(605,'dr',5790,'AFN',5790,'AFN',NULL,237,1),(606,'cr',5790,'AFN',5790,'AFN',NULL,237,9),(607,'dr',1800,'AFN',1800,'AFN',NULL,236,1),(608,'cr',1800,'AFN',1800,'AFN',NULL,236,9),(609,'dr',180,'AFN',180,'AFN',NULL,242,1),(610,'cr',180,'AFN',180,'AFN',NULL,242,9),(613,'dr',11520,'AFN',11520,'AFN',NULL,243,1),(614,'cr',11520,'AFN',11520,'AFN',NULL,243,9),(615,'dr',8802,'AFN',8802,'AFN',NULL,244,1),(616,'cr',8802,'AFN',8802,'AFN',NULL,244,9),(617,'dr',35200,'AFN',35200,'AFN',NULL,245,2),(618,'cr',35200,'AFN',35200,'AFN',NULL,245,85),(619,'dr',3750,'AFN',3750,'AFN',NULL,246,2),(620,'cr',3750,'AFN',3750,'AFN',NULL,246,79),(621,'dr',13200,'AFN',13200,'AFN',NULL,247,2),(622,'cr',13200,'AFN',13200,'AFN',NULL,247,80),(623,'dr',4600,'AFN',4600,'AFN',NULL,248,2),(624,'cr',4600,'AFN',4600,'AFN',NULL,248,81),(625,'dr',400,'AFN',400,'AFN',NULL,249,2),(626,'cr',400,'AFN',400,'AFN',NULL,249,82),(627,'dr',9072,'AFN',9072,'AFN',NULL,250,2),(628,'cr',140,'USD',9072,'AFN',NULL,250,82),(635,'cr',350,'AFN',350,'AFN',NULL,254,1),(636,'dr',350,'AFN',350,'AFN',NULL,254,2),(637,'dr',12450,'AFN',12450,'AFN',NULL,253,2),(638,'cr',12450,'AFN',12450,'AFN',NULL,253,77),(639,'dr',1296,'AFN',1296,'AFN',NULL,255,2),(640,'cr',20,'USD',1296,'AFN',NULL,255,83),(641,'dr',3100,'AFN',3100,'AFN',NULL,256,2),(642,'cr',3100,'AFN',3100,'AFN',NULL,256,1),(643,'dr',43755,'AFN',43755,'AFN',NULL,257,1),(644,'cr',43755,'AFN',43755,'AFN',NULL,257,9),(645,'dr',535,'AFN',535,'AFN',NULL,258,1),(646,'cr',535,'AFN',535,'AFN',NULL,258,9),(657,'dr',600,'AFN',600,'AFN',NULL,259,1),(658,'cr',600,'AFN',600,'AFN',NULL,259,9),(659,'dr',1500,'AFN',1500,'AFN',NULL,260,1),(660,'cr',1500,'AFN',1500,'AFN',NULL,260,9),(661,'dr',9926,'AFN',9926,'AFN',NULL,261,1),(662,'cr',9926,'AFN',9926,'AFN',NULL,261,9),(663,'dr',10140,'AFN',10140,'AFN',NULL,262,1),(664,'cr',10140,'AFN',10140,'AFN',NULL,262,9),(665,'dr',2400,'AFN',2400,'AFN',NULL,263,1),(666,'cr',2400,'AFN',2400,'AFN',NULL,263,9),(667,'dr',4526,'AFN',4526,'AFN',NULL,264,1),(668,'cr',4526,'AFN',4526,'AFN',NULL,264,9),(669,'dr',6900,'AFN',6900,'AFN',NULL,265,1),(670,'cr',6900,'AFN',6900,'AFN',NULL,265,9),(673,'dr',5795,'AFN',5795,'AFN',NULL,266,1),(674,'cr',5795,'AFN',5795,'AFN',NULL,266,9),(675,'dr',30000,'AFN',30000,'AFN',NULL,267,85),(676,'cr',30000,'AFN',30000,'AFN',NULL,267,1),(677,'dr',5200,'AFN',5200,'AFN',NULL,268,85),(678,'cr',5200,'AFN',5200,'AFN',NULL,268,1),(681,'dr',3750,'AFN',3750,'AFN',NULL,270,79),(682,'cr',3750,'AFN',3750,'AFN',NULL,270,1),(683,'dr',3200,'AFN',3200,'AFN',NULL,271,80),(684,'cr',3200,'AFN',3200,'AFN',NULL,271,1),(685,'dr',20,'USD',1300,'AFN',NULL,272,83),(686,'cr',1300,'AFN',1300,'AFN',NULL,272,1),(687,'dr',4600,'AFN',4600,'AFN',NULL,269,81),(688,'cr',4600,'AFN',4600,'AFN',NULL,269,1),(689,'dr',3000,'AFN',3000,'AFN',NULL,273,104),(690,'cr',3000,'AFN',3000,'AFN',NULL,273,1),(691,'dr',11000,'AFN',11000,'AFN',NULL,274,104),(692,'cr',11000,'AFN',11000,'AFN',NULL,274,1),(693,'dr',1100,'AFN',1100,'AFN',NULL,275,104),(694,'cr',1100,'AFN',1100,'AFN',NULL,275,1),(695,'dr',11700,'AFN',11700,'AFN',NULL,276,101),(696,'cr',11700,'AFN',11700,'AFN',NULL,276,1),(697,'dr',10000,'AFN',10000,'AFN',NULL,277,102),(698,'cr',10000,'AFN',10000,'AFN',NULL,277,1),(699,'dr',2500,'AFN',2500,'AFN',NULL,278,102),(700,'cr',2500,'AFN',2500,'AFN',NULL,278,1),(701,'dr',2000,'AFN',2000,'AFN',NULL,279,101),(702,'cr',2000,'AFN',2000,'AFN',NULL,279,1),(703,'dr',6705,'AFN',6705,'AFN',NULL,280,103),(704,'cr',6705,'AFN',6705,'AFN',NULL,280,1),(705,'dr',6000,'AFN',6000,'AFN',NULL,281,104),(706,'cr',6000,'AFN',6000,'AFN',NULL,281,1),(707,'dr',2500,'AFN',2500,'AFN',NULL,282,102),(708,'cr',2500,'AFN',2500,'AFN',NULL,282,1),(711,'dr',500,'AFN',500,'AFN',NULL,284,103),(712,'cr',500,'AFN',500,'AFN',NULL,284,1),(713,'dr',300,'AFN',300,'AFN',NULL,285,104),(714,'cr',300,'AFN',300,'AFN',NULL,285,1),(715,'dr',2140,'AFN',2140,'AFN',NULL,286,104),(716,'cr',2140,'AFN',2140,'AFN',NULL,286,1),(719,'dr',2000,'AFN',2000,'AFN',NULL,287,1),(720,'cr',2000,'AFN',2000,'AFN',NULL,287,68),(721,'dr',3000,'AFN',3000,'AFN',NULL,288,68),(722,'cr',3000,'AFN',3000,'AFN',NULL,288,1),(723,'dr',1000,'AFN',1000,'AFN',NULL,289,1),(724,'cr',1000,'AFN',1000,'AFN',NULL,289,72),(725,'cr',200,'AFN',200,'AFN',NULL,291,1),(726,'dr',200,'AFN',200,'AFN',NULL,291,2),(727,'dr',35295,'AFN',35295,'AFN',NULL,290,2),(728,'cr',543,'USD',35295,'AFN',NULL,290,78),(729,'dr',9390,'AFN',9390,'AFN',NULL,66,2),(730,'cr',9390,'AFN',9390,'AFN',NULL,66,14),(731,'dr',2160,'AFN',2160,'AFN',NULL,292,1),(732,'cr',2160,'AFN',2160,'AFN',NULL,292,9),(733,'dr',34955,'AFN',34955,'AFN',NULL,293,1),(734,'cr',34955,'AFN',34955,'AFN',NULL,293,9),(741,'cr',32525,'AFN',32525,'AFN',NULL,296,1),(742,'dr',500,'USD',32525,'AFN',NULL,296,1),(745,'dr',100,'AFN',100,'AFN',NULL,298,1),(746,'cr',100,'AFN',100,'AFN',NULL,298,9),(751,'cr',104080,'AFN',104080,'AFN',NULL,301,93),(752,'dr',1600,'USD',104080,'AFN',NULL,301,93),(753,'dr',100140,'AFN',100140,'AFN',NULL,300,93),(754,'cr',100140,'AFN',100140,'AFN',NULL,300,1),(757,'cr',600,'USD',39030,'AFN',NULL,302,93),(758,'dr',600,'USD',39030,'AFN',NULL,302,1),(759,'dr',20200,'AFN',20200,'AFN',NULL,303,1),(760,'cr',20200,'AFN',20200,'AFN',NULL,303,9),(763,'dr',1200,'AFN',1200,'AFN',NULL,305,1),(764,'cr',1200,'AFN',1200,'AFN',NULL,305,9),(765,'dr',3100,'AFN',3100,'AFN',NULL,306,102),(766,'cr',3100,'AFN',3100,'AFN',NULL,306,9),(767,'dr',360,'AFN',360,'AFN',NULL,307,1),(768,'cr',360,'AFN',360,'AFN',NULL,307,9),(769,'dr',200,'AFN',200,'AFN',NULL,308,1),(770,'cr',200,'AFN',200,'AFN',NULL,308,9),(773,'cr',400,'AFN',400,'AFN',NULL,311,1),(774,'dr',400,'AFN',400,'AFN',NULL,311,2),(775,'dr',26345.25,'AFN',26345.25,'AFN',NULL,310,2),(776,'cr',405,'USD',26345.25,'AFN',NULL,310,78),(777,'cr',500,'AFN',500,'AFN',NULL,312,1),(778,'dr',499.99999999999994,'AFN',499.99999999999994,'AFN',NULL,312,2),(779,'dr',40981.5,'AFN',40981.5,'AFN',NULL,251,2),(780,'cr',630,'USD',40981.5,'AFN',NULL,251,76),(781,'dr',7800,'AFN',7800,'AFN',NULL,313,114),(782,'cr',7800,'AFN',7800,'AFN',NULL,313,9),(783,'dr',1818,'AFN',1818,'AFN',NULL,314,114),(784,'cr',1818,'AFN',1818,'AFN',NULL,314,9),(785,'dr',6000,'AFN',6000,'AFN',NULL,315,1),(786,'cr',6000,'AFN',6000,'AFN',NULL,315,114),(787,'dr',2795,'AFN',2795,'AFN',NULL,316,103),(788,'cr',2795,'AFN',2795,'AFN',NULL,316,1),(789,'dr',600,'AFN',600,'AFN',NULL,317,104),(790,'cr',600,'AFN',600,'AFN',NULL,317,1),(791,'dr',2500,'AFN',2500,'AFN',NULL,318,102),(792,'cr',2500,'AFN',2500,'AFN',NULL,318,1),(793,'dr',2000,'AFN',2000,'AFN',NULL,319,101),(794,'cr',2000,'AFN',2000,'AFN',NULL,319,1),(795,'dr',1000,'AFN',1000,'AFN',NULL,320,101),(796,'cr',1000,'AFN',1000,'AFN',NULL,320,1),(797,'dr',2200,'AFN',2200,'AFN',NULL,321,1),(798,'cr',2200,'AFN',2200,'AFN',NULL,321,9),(799,'dr',3000,'AFN',3000,'AFN',NULL,322,80),(800,'cr',3000,'AFN',3000,'AFN',NULL,322,1),(801,'dr',1300,'AFN',1300,'AFN',NULL,323,2),(802,'cr',1300,'AFN',1300,'AFN',NULL,323,81),(805,'dr',14500,'AFN',14500,'AFN',NULL,325,2),(806,'cr',14500,'AFN',14500,'AFN',NULL,325,115),(807,'dr',2910,'AFN',2910,'AFN',NULL,326,1),(808,'cr',2910,'AFN',2910,'AFN',NULL,326,9),(809,'dr',100,'USD',6470,'AFN',NULL,327,82),(810,'cr',100,'USD',6470,'AFN',NULL,327,1),(811,'dr',40,'USD',2600,'AFN',NULL,327,82),(812,'cr',2600,'AFN',2600,'AFN',NULL,327,1),(813,'dr',400,'AFN',400,'AFN',NULL,328,82),(814,'cr',400,'AFN',400,'AFN',NULL,328,1),(815,'dr',3000,'AFN',3000,'AFN',NULL,283,101),(816,'cr',3000,'AFN',3000,'AFN',NULL,283,1),(817,'dr',500,'USD',32350,'AFN',NULL,329,76),(818,'cr',500,'USD',32350,'AFN',NULL,329,93),(819,'dr',500,'USD',32350,'AFN',NULL,330,78),(820,'cr',500,'USD',32350,'AFN',NULL,330,93),(821,'dr',14500,'AFN',14500,'AFN',NULL,331,115),(822,'cr',14500,'AFN',14500,'AFN',NULL,331,1),(823,'dr',600,'AFN',600,'AFN',NULL,332,2),(824,'cr',600,'AFN',600,'AFN',NULL,332,79),(825,'dr',1000,'AFN',1000,'AFN',NULL,333,2),(826,'cr',1000,'AFN',1000,'AFN',NULL,333,14),(827,'dr',7655,'AFN',7655,'AFN',NULL,334,1),(828,'cr',7655,'AFN',7655,'AFN',NULL,334,9),(831,'dr',3624,'AFN',3624,'AFN',NULL,336,1),(832,'cr',3624,'AFN',3624,'AFN',NULL,336,9),(833,'dr',6340,'AFN',6340,'AFN',NULL,335,1),(834,'cr',6340,'AFN',6340,'AFN',NULL,335,9),(835,'dr',1500,'AFN',1500,'AFN',NULL,337,2),(836,'cr',1500,'AFN',1500,'AFN',NULL,337,1),(837,'dr',2200,'AFN',2200,'AFN',NULL,338,2),(838,'cr',2200,'AFN',2200,'AFN',NULL,338,1),(839,'dr',35510,'AFN',35510,'AFN',NULL,339,1),(840,'cr',35510,'AFN',35510,'AFN',NULL,339,9),(841,'dr',10350,'AFN',10350,'AFN',NULL,340,1),(842,'cr',10350,'AFN',10350,'AFN',NULL,340,9),(843,'dr',8450,'AFN',8450,'AFN',NULL,324,2),(844,'cr',130,'USD',8450,'AFN',NULL,324,83),(845,'dr',130,'USD',8450,'AFN',NULL,341,83),(846,'cr',8450,'AFN',8450,'AFN',NULL,341,1),(847,'dr',8450,'AFN',8450,'AFN',NULL,342,2),(848,'cr',130,'USD',8450,'AFN',NULL,342,83),(849,'dr',50,'AFN',50,'AFN',NULL,343,1),(850,'cr',50,'AFN',50,'AFN',NULL,343,9),(853,'dr',10140,'AFN',10140,'AFN',NULL,344,113),(854,'cr',10140,'AFN',10140,'AFN',NULL,344,9),(855,'cr',100,'AFN',100,'AFN',NULL,345,1),(856,'dr',100,'AFN',100,'AFN',NULL,345,16),(857,'dr',6400,'AFN',6400,'AFN',NULL,304,113),(858,'cr',6400,'AFN',6400,'AFN',NULL,304,9),(859,'cr',150,'AFN',150,'AFN',NULL,346,1),(860,'dr',150,'AFN',150,'AFN',NULL,346,16),(861,'dr',1000,'AFN',1000,'AFN',NULL,347,1),(862,'cr',1000,'AFN',1000,'AFN',NULL,347,72),(863,'dr',1000,'USD',64700,'AFN',NULL,348,73),(864,'cr',1000,'USD',64700,'AFN',NULL,348,1),(865,'dr',4000,'AFN',4000,'AFN',NULL,349,93),(866,'cr',4000,'AFN',4000,'AFN',NULL,349,1),(867,'dr',500,'AFN',500,'AFN',NULL,350,103),(868,'cr',500,'AFN',500,'AFN',NULL,350,1),(869,'dr',200,'AFN',200,'AFN',NULL,351,1),(870,'cr',200,'AFN',200,'AFN',NULL,351,98),(871,'dr',2909,'AFN',2909,'AFN',NULL,352,1),(872,'cr',2909,'AFN',2909,'AFN',NULL,352,9),(873,'dr',170,'AFN',170,'AFN',NULL,353,1),(874,'cr',170,'AFN',170,'AFN',NULL,353,9),(875,'dr',30,'AFN',30,'AFN',NULL,354,1),(876,'cr',30,'AFN',30,'AFN',NULL,354,98),(877,'dr',16540,'AFN',16540,'AFN',NULL,355,1),(878,'cr',16540,'AFN',16540,'AFN',NULL,355,113),(879,'dr',500,'AFN',500,'AFN',NULL,356,74),(880,'cr',500,'AFN',500,'AFN',NULL,356,1),(885,'cr',1160,'AFN',1160,'AFN',NULL,359,1),(886,'dr',1159.9999999999998,'AFN',1159.9999999999998,'AFN',NULL,359,2),(887,'dr',37330,'AFN',37330,'AFN',NULL,357,2),(888,'cr',37330,'AFN',37330,'AFN',NULL,357,1),(889,'dr',2490,'AFN',2490,'AFN',NULL,360,1),(890,'cr',2490,'AFN',2490,'AFN',NULL,360,9),(891,'dr',500,'AFN',500,'AFN',NULL,361,1),(892,'cr',500,'AFN',500,'AFN',NULL,361,74),(899,'dr',196832,'AFN',196832,'AFN',NULL,220,1),(900,'cr',196832,'AFN',196832,'AFN',NULL,220,95),(901,'dr',196832,'AFN',196832,'AFN',NULL,219,1),(902,'cr',196832,'AFN',196832,'AFN',NULL,219,56),(903,'dr',1800,'AFN',1800,'AFN',NULL,362,1),(904,'cr',1800,'AFN',1800,'AFN',NULL,362,9),(905,'dr',3000,'AFN',3000,'AFN',NULL,363,103),(906,'cr',3000,'AFN',3000,'AFN',NULL,363,1),(907,'dr',5650,'AFN',5650,'AFN',NULL,364,1),(908,'cr',5650,'AFN',5650,'AFN',NULL,364,9),(909,'dr',1500,'AFN',1500,'AFN',NULL,365,2),(910,'cr',1500,'AFN',1500,'AFN',NULL,365,1),(913,'dr',90,'AFN',90,'AFN',NULL,367,1),(914,'cr',90,'AFN',90,'AFN',NULL,367,9),(915,'dr',450,'AFN',450,'AFN',NULL,368,1),(916,'cr',450,'AFN',450,'AFN',NULL,368,9),(917,'dr',1300,'AFN',1300,'AFN',NULL,369,1),(918,'cr',1300,'AFN',1300,'AFN',NULL,369,9),(919,'dr',800,'AFN',800,'AFN',NULL,370,2),(920,'cr',800,'AFN',800,'AFN',NULL,370,1),(921,'dr',60,'AFN',60,'AFN',NULL,371,1),(922,'cr',60,'AFN',60,'AFN',NULL,371,9),(923,'dr',7000,'AFN',7000,'AFN',NULL,372,80),(924,'cr',7000,'AFN',7000,'AFN',NULL,372,1),(925,'dr',600,'AFN',600,'AFN',NULL,373,79),(926,'cr',600,'AFN',600,'AFN',NULL,373,1),(927,'dr',1800,'AFN',1800,'AFN',NULL,374,1),(928,'cr',1800,'AFN',1800,'AFN',NULL,374,9),(929,'dr',8496,'AFN',8496,'AFN',NULL,375,1),(930,'cr',8496,'AFN',8496,'AFN',NULL,375,9),(931,'dr',1050,'AFN',1050,'AFN',NULL,376,2),(932,'cr',1050,'AFN',1050,'AFN',NULL,376,1),(933,'dr',18310,'AFN',18310,'AFN',NULL,377,1),(934,'cr',18310,'AFN',18310,'AFN',NULL,377,9),(935,'dr',2400,'AFN',2400,'AFN',NULL,378,1),(936,'cr',2400,'AFN',2400,'AFN',NULL,378,9),(937,'dr',1650,'AFN',1650,'AFN',NULL,379,1),(938,'cr',1650,'AFN',1650,'AFN',NULL,379,9),(939,'dr',2396,'AFN',2396,'AFN',NULL,380,119),(940,'cr',2396,'AFN',2396,'AFN',NULL,380,9),(941,'dr',500,'AFN',500,'AFN',NULL,381,1),(942,'cr',500,'AFN',500,'AFN',NULL,381,119),(947,'dr',9000,'AFN',9000,'AFN',NULL,384,2),(948,'cr',9000,'AFN',9000,'AFN',NULL,384,1),(951,'dr',350,'AFN',350,'AFN',NULL,385,2),(952,'cr',350,'AFN',350,'AFN',NULL,385,1),(953,'dr',28000,'AFN',28000,'AFN',NULL,383,1),(954,'cr',28000,'AFN',28000,'AFN',NULL,383,9),(955,'dr',1300,'AFN',1300,'AFN',NULL,386,81),(956,'cr',1300,'AFN',1300,'AFN',NULL,386,1),(957,'cr',19480,'AFN',19479.000000000004,'AFN',NULL,387,1),(958,'dr',300,'USD',19479.000000000004,'AFN',NULL,387,1),(959,'cr',50000,'AFN',50000,'AFN',NULL,388,1),(960,'dr',50000,'AFN',50000,'AFN',NULL,388,93),(961,'dr',5250,'AFN',5250,'AFN',NULL,389,112),(962,'cr',5250,'AFN',5250,'AFN',NULL,389,9),(963,'dr',2600,'AFN',2600,'AFN',NULL,390,114),(964,'cr',2600,'AFN',2600,'AFN',NULL,390,9),(965,'dr',12299,'AFN',12299,'AFN',NULL,382,1),(966,'cr',12299,'AFN',12299,'AFN',NULL,382,9),(967,'dr',600,'AFN',600,'AFN',NULL,391,104),(968,'cr',600,'AFN',600,'AFN',NULL,391,1),(969,'dr',2500,'AFN',2500,'AFN',NULL,392,102),(970,'cr',2500,'AFN',2500,'AFN',NULL,392,1),(971,'dr',2000,'AFN',2000,'AFN',NULL,393,101),(972,'cr',2000,'AFN',2000,'AFN',NULL,393,1),(979,'dr',7900,'AFN',7900,'AFN',NULL,396,2),(980,'cr',7900,'AFN',7900,'AFN',NULL,396,1),(981,'dr',20500,'AFN',20500,'AFN',NULL,394,2),(982,'cr',20500,'AFN',20500,'AFN',NULL,394,85),(983,'dr',20500,'AFN',20500,'AFN',NULL,397,85),(984,'cr',20500,'AFN',20500,'AFN',NULL,397,1),(985,'dr',3000,'AFN',3000,'AFN',NULL,398,104),(986,'cr',3000,'AFN',3000,'AFN',NULL,398,1),(987,'cr',85475,'AFN',85475,'AFN',NULL,176,78),(988,'dr',85475,'AFN',85475,'AFN',NULL,176,14),(989,'dr',33720,'AFN',33720,'AFN',NULL,399,1),(990,'cr',33720,'AFN',33720,'AFN',NULL,399,9),(991,'dr',7100,'AFN',7100,'AFN',NULL,400,1),(992,'cr',7100,'AFN',7100,'AFN',NULL,400,9),(993,'dr',10600,'AFN',10600,'AFN',NULL,401,1),(994,'cr',10600,'AFN',10600,'AFN',NULL,401,9),(999,'dr',7403,'AFN',7403,'AFN',NULL,402,1),(1000,'cr',7403,'AFN',7403,'AFN',NULL,402,9),(1001,'dr',8155,'AFN',8155,'AFN',NULL,403,90),(1002,'cr',8155,'AFN',8155,'AFN',NULL,403,14),(1003,'dr',830,'AFN',830,'AFN',NULL,404,1),(1004,'cr',830,'AFN',830,'AFN',NULL,404,9),(1005,'dr',1000,'AFN',1000,'AFN',NULL,405,1),(1006,'cr',1000,'AFN',1000,'AFN',NULL,405,9),(1007,'dr',530,'AFN',530,'AFN',NULL,406,1),(1008,'cr',530,'AFN',530,'AFN',NULL,406,9),(1009,'dr',4700,'AFN',4700,'AFN',NULL,407,106),(1010,'cr',4700,'AFN',4700,'AFN',NULL,407,9),(1011,'dr',1000,'AFN',1000,'AFN',NULL,408,106),(1012,'cr',1000,'AFN',1000,'AFN',NULL,408,14),(1015,'dr',1000,'AFN',1000,'AFN',NULL,410,1),(1016,'cr',1000,'AFN',1000,'AFN',NULL,410,72),(1017,'dr',11000,'AFN',11000,'AFN',NULL,411,104),(1018,'cr',11000,'AFN',11000,'AFN',NULL,411,1),(1019,'dr',6218,'AFN',6218,'AFN',NULL,412,1),(1020,'cr',6218,'AFN',6218,'AFN',NULL,412,114),(1021,'dr',3800,'AFN',3800,'AFN',NULL,413,1),(1022,'cr',3800,'AFN',3800,'AFN',NULL,413,9),(1023,'dr',130,'USD',8450,'AFN',NULL,414,83),(1024,'cr',8450,'AFN',8450,'AFN',NULL,414,1),(1025,'dr',70,'AFN',70,'AFN',NULL,415,1),(1026,'cr',70,'AFN',70,'AFN',NULL,415,9),(1027,'dr',170,'AFN',170,'AFN',NULL,416,1),(1028,'cr',170,'AFN',170,'AFN',NULL,416,9),(1029,'dr',30,'AFN',30,'AFN',NULL,417,1),(1030,'cr',30,'AFN',30,'AFN',NULL,417,9),(1031,'dr',9200,'AFN',9200,'AFN',NULL,418,2),(1032,'cr',9200,'AFN',9200,'AFN',NULL,418,1),(1033,'dr',3246.5000000000005,'AFN',3246.5000000000005,'AFN',NULL,419,2),(1034,'cr',50,'USD',3246.5000000000005,'AFN',NULL,419,91),(1035,'dr',2800,'AFN',2800,'AFN',NULL,420,2),(1036,'cr',2800,'AFN',2800,'AFN',NULL,420,91),(1037,'dr',1300,'AFN',1300,'AFN',NULL,421,2),(1038,'cr',1300,'AFN',1300,'AFN',NULL,421,60),(1039,'dr',1500,'AFN',1500,'AFN',NULL,422,2),(1040,'cr',1500,'AFN',1500,'AFN',NULL,422,118),(1041,'dr',34950,'AFN',34950,'AFN',NULL,423,1),(1042,'cr',34950,'AFN',34950,'AFN',NULL,423,9),(1043,'dr',6405,'AFN',6405,'AFN',NULL,424,2),(1044,'cr',6405,'AFN',6405,'AFN',NULL,424,82),(1045,'dr',1100,'AFN',1100,'AFN',NULL,425,2),(1046,'cr',1100,'AFN',1100,'AFN',NULL,425,91),(1047,'dr',360,'AFN',360,'AFN',NULL,426,1),(1048,'cr',360,'AFN',360,'AFN',NULL,426,9),(1049,'dr',4550,'AFN',4550,'AFN',NULL,427,1),(1050,'cr',4550,'AFN',4550,'AFN',NULL,427,9),(1051,'dr',4500,'AFN',4500,'AFN',NULL,428,103),(1052,'cr',4500,'AFN',4500,'AFN',NULL,428,1),(1053,'dr',2000,'AFN',2000,'AFN',NULL,429,103),(1054,'cr',2000,'AFN',2000,'AFN',NULL,429,1),(1055,'dr',1700,'AFN',1700,'AFN',NULL,430,83),(1056,'cr',1700,'AFN',1700,'AFN',NULL,430,9),(1057,'dr',1100,'AFN',1100,'AFN',NULL,431,1),(1058,'cr',1100,'AFN',1100,'AFN',NULL,431,9),(1059,'dr',2720,'AFN',2720,'AFN',NULL,432,1),(1060,'cr',2720,'AFN',2720,'AFN',NULL,432,9),(1061,'dr',308,'AFN',308,'AFN',NULL,433,2),(1062,'cr',308,'AFN',308,'AFN',NULL,433,1),(1065,'dr',9589,'AFN',9589,'AFN',NULL,434,1),(1066,'cr',9589,'AFN',9589,'AFN',NULL,434,9),(1067,'cr',50000,'AFN',50000,'AFN',NULL,435,1),(1068,'dr',50000,'AFN',50000,'AFN',NULL,435,93),(1071,'dr',100,'AFN',100,'AFN',NULL,437,122),(1072,'cr',100,'AFN',100,'AFN',NULL,437,1),(1073,'dr',500,'AFN',500,'AFN',NULL,438,102),(1074,'cr',500,'AFN',500,'AFN',NULL,438,1),(1075,'dr',2500,'AFN',2500,'AFN',NULL,439,102),(1076,'cr',2500,'AFN',2500,'AFN',NULL,439,1),(1077,'dr',500,'AFN',500,'AFN',NULL,440,104),(1078,'cr',500,'AFN',500,'AFN',NULL,440,1),(1079,'dr',1000,'AFN',1000,'AFN',NULL,441,101),(1080,'cr',1000,'AFN',1000,'AFN',NULL,441,1),(1081,'dr',1600,'AFN',1600,'AFN',NULL,442,1),(1082,'cr',1600,'AFN',1600,'AFN',NULL,442,9),(1083,'dr',1000,'AFN',1000,'AFN',NULL,443,1),(1084,'cr',1000,'AFN',1000,'AFN',NULL,443,106),(1085,'dr',12275,'AFN',12275,'AFN',NULL,444,1),(1086,'cr',12275,'AFN',12275,'AFN',NULL,444,9),(1087,'dr',6405,'AFN',6405,'AFN',NULL,445,82),(1088,'cr',6405,'AFN',6405,'AFN',NULL,445,1),(1089,'cr',1100,'AFN',1100,'AFN',NULL,446,2),(1090,'dr',1100,'AFN',1100,'AFN',NULL,446,91),(1091,'dr',50,'USD',3250,'AFN',NULL,447,91),(1092,'cr',3250,'AFN',3250,'AFN',NULL,447,1),(1093,'dr',2800,'AFN',2800,'AFN',NULL,447,91),(1094,'cr',2800,'AFN',2800,'AFN',NULL,447,1),(1095,'dr',2500,'AFN',2500,'AFN',NULL,448,101),(1096,'cr',2500,'AFN',2500,'AFN',NULL,448,1),(1097,'dr',3000,'AFN',3000,'AFN',NULL,449,104),(1098,'cr',3000,'AFN',3000,'AFN',NULL,449,1),(1099,'dr',300,'AFN',300,'AFN',NULL,450,85),(1100,'cr',300,'AFN',300,'AFN',NULL,450,9),(1101,'dr',2130,'AFN',2130,'AFN',NULL,451,2),(1102,'cr',2130,'AFN',2130,'AFN',NULL,451,1),(1103,'dr',50000,'AFN',50000,'AFN',NULL,436,78),(1104,'cr',50000,'AFN',50000,'AFN',NULL,436,93),(1105,'dr',1500,'AFN',1500,'AFN',NULL,452,118),(1106,'cr',1500,'AFN',1500,'AFN',NULL,452,1),(1107,'dr',300,'AFN',300,'AFN',NULL,453,112),(1108,'cr',300,'AFN',300,'AFN',NULL,453,14),(1109,'dr',2800,'AFN',2800,'AFN',NULL,454,2),(1110,'cr',2800,'AFN',2800,'AFN',NULL,454,91),(1113,'dr',3000,'AFN',3000,'AFN',NULL,455,112),(1114,'cr',3000,'AFN',3000,'AFN',NULL,455,9),(1115,'dr',1000,'AFN',1000,'AFN',NULL,456,1),(1116,'cr',1000,'AFN',1000,'AFN',NULL,456,72),(1117,'dr',1350,'AFN',1350,'AFN',NULL,457,1),(1118,'cr',1350,'AFN',1350,'AFN',NULL,457,9),(1119,'dr',7000,'AFN',7000,'AFN',NULL,458,2),(1120,'cr',7000,'AFN',7000,'AFN',NULL,458,1),(1121,'cr',33.8,'USD',2194.634,'AFN',NULL,459,76),(1122,'dr',33.8,'USD',2194.634,'AFN',NULL,459,14),(1123,'cr',34.3,'USD',2227.099,'AFN',NULL,174,76),(1124,'dr',34.3,'USD',2227.099,'AFN',NULL,174,14),(1125,'cr',50000,'AFN',50000,'AFN',NULL,460,93),(1126,'dr',50000,'AFN',50000,'AFN',NULL,460,1),(1127,'dr',1200,'AFN',1200,'AFN',NULL,461,1),(1128,'cr',1200,'AFN',1200,'AFN',NULL,461,9),(1129,'dr',2400,'AFN',2400,'AFN',NULL,462,83),(1130,'cr',2400,'AFN',2400,'AFN',NULL,462,9),(1131,'dr',650,'AFN',650,'AFN',NULL,463,1),(1132,'cr',650,'AFN',650,'AFN',NULL,463,9),(1133,'dr',19000,'AFN',19000,'AFN',NULL,464,2),(1134,'cr',19000,'AFN',19000,'AFN',NULL,464,123),(1143,'cr',350,'AFN',350,'AFN',NULL,468,1),(1144,'dr',350.00000000000006,'AFN',350.00000000000006,'AFN',NULL,468,2),(1145,'dr',50760.079999999994,'AFN',50760.079999999994,'AFN',NULL,466,2),(1146,'cr',788.2,'USD',50760.079999999994,'AFN',NULL,466,78),(1147,'dr',8000,'AFN',8000,'AFN',NULL,465,118),(1148,'cr',8000,'AFN',8000,'AFN',NULL,465,9),(1149,'cr',300,'AFN',300,'AFN',NULL,470,1),(1150,'dr',300,'AFN',300,'AFN',NULL,470,2),(1151,'dr',8200,'AFN',8200,'AFN',NULL,469,2),(1152,'cr',8200,'AFN',8200,'AFN',NULL,469,77),(1153,'cr',50,'AFN',50,'AFN',NULL,472,1),(1154,'dr',50,'AFN',50,'AFN',NULL,472,2),(1155,'dr',9500,'AFN',9500,'AFN',NULL,471,2),(1156,'cr',9500,'AFN',9500,'AFN',NULL,471,86),(1157,'cr',300,'AFN',300,'AFN',NULL,474,1),(1158,'dr',300,'AFN',300,'AFN',NULL,474,2),(1159,'dr',34100,'AFN',34100,'AFN',NULL,473,2),(1160,'cr',34100,'AFN',34100,'AFN',NULL,473,124),(1161,'cr',1500,'AFN',1500,'AFN',NULL,475,2),(1162,'dr',1500,'AFN',1500,'AFN',NULL,475,124),(1163,'dr',12364.8,'AFN',12364.8,'AFN',NULL,476,2),(1164,'cr',192,'USD',12364.8,'AFN',NULL,476,76),(1165,'dr',2330,'AFN',2330,'AFN',NULL,477,1),(1166,'cr',2330,'AFN',2330,'AFN',NULL,477,9),(1169,'dr',5040,'AFN',5040,'AFN',NULL,478,103),(1170,'cr',5040,'AFN',5040,'AFN',NULL,478,1),(1171,'dr',550,'AFN',550,'AFN',NULL,479,1),(1172,'cr',550,'AFN',550,'AFN',NULL,479,9),(1173,'dr',19000,'AFN',19000,'AFN',NULL,480,123),(1174,'cr',19000,'AFN',19000,'AFN',NULL,480,1),(1175,'dr',260,'USD',16744,'AFN',NULL,481,82),(1176,'cr',260,'USD',16744,'AFN',NULL,481,9),(1177,'dr',1896,'AFN',1896,'AFN',NULL,482,1),(1178,'cr',1896,'AFN',1896,'AFN',NULL,482,119),(1179,'dr',1050,'AFN',1050,'AFN',NULL,483,1),(1180,'cr',1050,'AFN',1050,'AFN',NULL,483,9),(1181,'dr',7200,'AFN',7200,'AFN',NULL,484,2),(1182,'cr',7200,'AFN',7200,'AFN',NULL,484,1),(1183,'dr',3000,'AFN',3000,'AFN',NULL,485,1),(1184,'cr',3000,'AFN',3000,'AFN',NULL,485,9),(1185,'dr',1100,'AFN',1100,'AFN',NULL,486,104),(1186,'cr',1100,'AFN',1100,'AFN',NULL,486,1),(1189,'dr',5000,'AFN',5000,'AFN',NULL,488,1),(1190,'cr',5000,'AFN',5000,'AFN',NULL,488,118),(1191,'dr',3005,'AFN',3005,'AFN',NULL,489,1),(1192,'cr',3005,'AFN',3005,'AFN',NULL,489,90),(1193,'dr',300,'AFN',300,'AFN',NULL,490,1),(1194,'cr',300,'AFN',300,'AFN',NULL,490,85),(1195,'dr',4040,'AFN',4040,'AFN',NULL,491,1),(1196,'cr',4040,'AFN',4040,'AFN',NULL,491,9),(1197,'dr',500,'AFN',500,'AFN',NULL,492,2),(1198,'cr',500,'AFN',500,'AFN',NULL,492,91),(1199,'dr',8310,'AFN',8310,'AFN',NULL,493,1),(1200,'cr',8310,'AFN',8310,'AFN',NULL,493,9),(1201,'dr',3300,'AFN',3300,'AFN',NULL,494,91),(1202,'cr',3300,'AFN',3300,'AFN',NULL,494,1),(1207,'dr',2500,'AFN',2500,'AFN',NULL,497,102),(1208,'cr',2500,'AFN',2500,'AFN',NULL,497,1),(1209,'dr',2500,'AFN',2500,'AFN',NULL,498,101),(1210,'cr',2500,'AFN',2500,'AFN',NULL,498,1),(1211,'dr',300,'AFN',300,'AFN',NULL,499,104),(1212,'cr',300,'AFN',300,'AFN',NULL,499,1),(1213,'dr',600,'AFN',600,'AFN',NULL,500,2),(1214,'cr',600,'AFN',600,'AFN',NULL,500,83),(1215,'dr',9300,'AFN',9300,'AFN',NULL,501,114),(1216,'cr',9300,'AFN',9300,'AFN',NULL,501,9),(1217,'dr',600,'AFN',600,'AFN',NULL,502,1),(1218,'cr',600,'AFN',600,'AFN',NULL,502,9),(1221,'dr',4700,'AFN',4700,'AFN',NULL,504,1),(1222,'cr',4700,'AFN',4700,'AFN',NULL,504,106),(1223,'dr',1416,'AFN',1416,'AFN',NULL,505,1),(1224,'cr',1416,'AFN',1416,'AFN',NULL,505,61),(1225,'dr',4500,'AFN',4500,'AFN',NULL,506,103),(1226,'cr',4500,'AFN',4500,'AFN',NULL,506,1),(1227,'cr',1030,'AFN',1030,'AFN',NULL,508,1),(1228,'dr',1030,'AFN',1030,'AFN',NULL,508,2),(1229,'dr',11500,'AFN',11500,'AFN',NULL,507,2),(1230,'cr',11500,'AFN',11500,'AFN',NULL,507,1),(1231,'dr',600,'AFN',600,'AFN',NULL,509,103),(1232,'cr',600,'AFN',600,'AFN',NULL,509,1),(1233,'dr',2500,'AFN',2500,'AFN',NULL,510,103),(1234,'cr',2500,'AFN',2500,'AFN',NULL,510,1),(1235,'dr',1000,'AFN',1000,'AFN',NULL,511,101),(1236,'cr',1000,'AFN',1000,'AFN',NULL,511,1),(1237,'dr',4000,'AFN',4000,'AFN',NULL,512,61),(1238,'cr',4000,'AFN',4000,'AFN',NULL,512,1),(1241,'dr',900,'AFN',900,'AFN',NULL,514,1),(1242,'cr',900,'AFN',900,'AFN',NULL,514,9),(1249,'cr',100,'AFN',100,'AFN',NULL,517,1),(1250,'dr',100.00000000000001,'AFN',100.00000000000001,'AFN',NULL,517,2),(1251,'dr',40475,'AFN',40475,'AFN',NULL,495,2),(1252,'cr',40475,'AFN',40475,'AFN',NULL,495,125),(1253,'dr',100,'AFN',100,'AFN',NULL,518,122),(1254,'cr',100,'AFN',100,'AFN',NULL,518,1),(1255,'dr',40475,'AFN',40475,'AFN',NULL,515,125),(1256,'cr',40475,'AFN',40475,'AFN',NULL,515,1),(1257,'dr',1550,'AFN',1550,'AFN',NULL,519,104),(1258,'cr',1550,'AFN',1550,'AFN',NULL,519,1),(1259,'dr',1150,'AFN',1150,'AFN',NULL,520,1),(1260,'cr',1150,'AFN',1150,'AFN',NULL,520,9),(1261,'dr',1160,'AFN',1160,'AFN',NULL,521,103),(1262,'cr',1160,'AFN',1160,'AFN',NULL,521,1),(1263,'dr',7500,'AFN',7500,'AFN',NULL,522,85),(1264,'cr',7500,'AFN',7500,'AFN',NULL,522,9),(1265,'dr',6000,'AFN',6000,'AFN',NULL,523,68),(1266,'cr',6000,'AFN',6000,'AFN',NULL,523,1),(1267,'dr',2000,'AFN',2000,'AFN',NULL,524,101),(1268,'cr',2000,'AFN',2000,'AFN',NULL,524,1),(1269,'dr',330,'AFN',330,'AFN',NULL,525,1),(1270,'cr',330,'AFN',330,'AFN',NULL,525,9),(1271,'dr',1000,'AFN',1000,'AFN',NULL,526,1),(1272,'cr',1000,'AFN',1000,'AFN',NULL,526,72),(1277,'dr',2300,'AFN',2300,'AFN',NULL,529,1),(1278,'cr',2300,'AFN',2300,'AFN',NULL,529,70),(1279,'dr',1200,'AFN',1200,'AFN',NULL,530,1),(1280,'cr',1200,'AFN',1200,'AFN',NULL,530,9),(1281,'dr',2700,'AFN',2700,'AFN',NULL,527,70),(1282,'cr',2700,'AFN',2700,'AFN',NULL,527,9),(1283,'dr',400,'AFN',400,'AFN',NULL,531,1),(1284,'cr',400,'AFN',400,'AFN',NULL,531,70),(1285,'dr',2400,'AFN',2400,'AFN',NULL,532,114),(1286,'cr',2400,'AFN',2400,'AFN',NULL,532,9),(1289,'dr',23828,'AFN',23828,'AFN',NULL,534,2),(1290,'cr',370,'USD',23828,'AFN',NULL,534,82),(1291,'cr',500,'AFN',500,'AFN',NULL,536,1),(1292,'dr',499.99999999999994,'AFN',499.99999999999994,'AFN',NULL,536,2),(1293,'dr',32242.3,'AFN',32242.3,'AFN',NULL,535,2),(1294,'cr',503,'USD',32242.3,'AFN',NULL,535,76),(1295,'dr',100,'AFN',100,'AFN',NULL,537,2),(1296,'cr',100,'AFN',100,'AFN',NULL,537,83),(1299,'dr',8000,'AFN',8000,'AFN',NULL,539,2),(1300,'cr',8000,'AFN',8000,'AFN',NULL,539,83),(1301,'dr',349,'AFN',349,'AFN',NULL,540,1),(1302,'cr',349,'AFN',349,'AFN',NULL,540,9),(1311,'dr',27384,'AFN',27384,'AFN',NULL,503,1),(1312,'cr',27384,'AFN',27384,'AFN',NULL,503,9),(1317,'dr',5500,'AFN',5500,'AFN',NULL,544,118),(1318,'cr',5500,'AFN',5500,'AFN',NULL,544,9),(1333,'dr',1600,'AFN',1600,'AFN',NULL,547,126),(1334,'cr',1600,'AFN',1600,'AFN',NULL,547,1),(1337,'dr',29188,'AFN',29188,'AFN',NULL,538,1),(1338,'cr',29188,'AFN',29188,'AFN',NULL,538,9),(1341,'dr',12200,'AFN',12200,'AFN',NULL,533,2),(1342,'cr',12200,'AFN',12200,'AFN',NULL,533,82),(1343,'dr',110,'USD',7030,'AFN',NULL,550,82),(1344,'cr',7030,'AFN',7030,'AFN',NULL,550,1),(1345,'cr',600,'AFN',600,'AFN',NULL,551,1),(1346,'dr',600,'AFN',600,'AFN',NULL,551,9),(1347,'dr',19588,'AFN',19588,'AFN',NULL,552,1),(1348,'cr',19588,'AFN',19588,'AFN',NULL,552,9),(1349,'dr',2000,'AFN',2000,'AFN',NULL,553,1),(1350,'cr',2000,'AFN',2000,'AFN',NULL,553,90),(1351,'dr',2000,'AFN',2000,'AFN',NULL,554,101),(1352,'cr',2000,'AFN',2000,'AFN',NULL,554,1),(1353,'dr',2500,'AFN',2500,'AFN',NULL,555,102),(1354,'cr',2500,'AFN',2500,'AFN',NULL,555,1),(1355,'dr',1000,'AFN',1000,'AFN',NULL,556,103),(1356,'cr',1000,'AFN',1000,'AFN',NULL,556,1),(1357,'dr',300,'AFN',300,'AFN',NULL,557,104),(1358,'cr',300,'AFN',300,'AFN',NULL,557,1),(1359,'dr',1900,'AFN',1900,'AFN',NULL,558,1),(1360,'cr',1900,'AFN',1900,'AFN',NULL,558,9),(1361,'dr',1550,'AFN',1550,'AFN',NULL,559,1),(1362,'cr',1550,'AFN',1550,'AFN',NULL,559,9),(1363,'dr',650,'AFN',650,'AFN',NULL,560,1),(1364,'cr',650,'AFN',650,'AFN',NULL,560,9),(1365,'dr',2550,'AFN',2550,'AFN',NULL,561,90),(1366,'cr',2550,'AFN',2550,'AFN',NULL,561,9),(1367,'dr',3700,'AFN',3700,'AFN',NULL,562,2),(1368,'cr',3700,'AFN',3700,'AFN',NULL,562,85),(1369,'dr',1800,'AFN',1800,'AFN',NULL,563,1),(1370,'cr',1800,'AFN',1800,'AFN',NULL,563,9),(1371,'dr',1450,'AFN',1450,'AFN',NULL,564,1),(1372,'cr',1450,'AFN',1450,'AFN',NULL,564,9),(1373,'dr',4230,'AFN',4230,'AFN',NULL,565,1),(1374,'cr',4230,'AFN',4230,'AFN',NULL,565,9),(1375,'dr',80,'AFN',80,'AFN',NULL,566,1),(1376,'cr',80,'AFN',80,'AFN',NULL,566,9),(1377,'dr',1040,'AFN',1040,'AFN',NULL,567,1),(1378,'cr',1040,'AFN',1040,'AFN',NULL,567,9),(1379,'dr',11150,'AFN',11150,'AFN',NULL,568,1),(1380,'cr',11150,'AFN',11150,'AFN',NULL,568,9),(1381,'dr',500,'AFN',500,'AFN',NULL,569,1),(1382,'cr',500,'AFN',500,'AFN',NULL,569,98),(1383,'dr',1200,'AFN',1200,'AFN',NULL,570,1),(1384,'cr',1200,'AFN',1200,'AFN',NULL,570,9),(1385,'dr',8500,'AFN',8500,'AFN',NULL,571,1),(1386,'cr',8500,'AFN',8500,'AFN',NULL,571,118),(1387,'dr',7500,'AFN',7500,'AFN',NULL,572,101),(1388,'cr',7500,'AFN',7500,'AFN',NULL,572,1),(1389,'dr',18000,'AFN',18000,'AFN',NULL,573,104),(1390,'cr',18000,'AFN',18000,'AFN',NULL,573,1),(1399,'cr',100,'AFN',100,'AFN',NULL,578,1),(1400,'dr',100,'AFN',100,'AFN',NULL,578,2),(1401,'dr',8255,'AFN',8255,'AFN',NULL,575,2),(1402,'cr',130,'USD',8255,'AFN',NULL,575,76),(1403,'cr',100,'AFN',100,'AFN',NULL,579,1),(1404,'dr',100,'AFN',100,'AFN',NULL,579,2),(1405,'dr',15875,'AFN',15875,'AFN',NULL,574,2),(1406,'cr',250,'USD',15875,'AFN',NULL,574,77),(1407,'cr',300,'AFN',300,'AFN',NULL,580,1),(1408,'dr',300,'AFN',300,'AFN',NULL,580,2),(1409,'dr',6000,'AFN',6000,'AFN',NULL,576,2),(1410,'cr',6000,'AFN',6000,'AFN',NULL,576,77),(1411,'cr',80000,'AFN',80000,'AFN',NULL,581,1),(1412,'dr',80000,'AFN',80000,'AFN',NULL,581,93),(1415,'dr',51880,'AFN',51880,'AFN',NULL,582,1),(1416,'cr',51880,'AFN',51880,'AFN',NULL,582,9),(1417,'dr',1750,'AFN',1750,'AFN',NULL,583,1),(1418,'cr',1750,'AFN',1750,'AFN',NULL,583,9);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT 0,
  `isActive` tinyint(1) NOT NULL DEFAULT 1,
  `date` date NOT NULL,
  `msdp` double NOT NULL DEFAULT 0,
  `allowBonus` tinyint(1) DEFAULT 0,
  `allowPriceEditing` tinyint(1) DEFAULT 0,
  `noCogsAlert` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'administrator','90f2c9c53f66540e67349e0ab83d8cd0',1,1,'2026-03-28',0,0,0,0),(2,'admin','c4ca4238a0b923820dcc509a6f75849b',0,1,'2026-03-28',0,0,0,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usersprivileges`
--

DROP TABLE IF EXISTS `usersprivileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usersprivileges` (
  `privilegeId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`privilegeId`,`userId`),
  KEY `userId` (`userId`),
  CONSTRAINT `usersprivileges_ibfk_1` FOREIGN KEY (`privilegeId`) REFERENCES `privileges` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usersprivileges_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usersprivileges`
--

LOCK TABLES `usersprivileges` WRITE;
/*!40000 ALTER TABLE `usersprivileges` DISABLE KEYS */;
/*!40000 ALTER TABLE `usersprivileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `walkincustomers`
--

DROP TABLE IF EXISTS `walkincustomers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `walkincustomers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerName` varchar(255) DEFAULT NULL,
  `customerPhone` varchar(255) DEFAULT NULL,
  `customerAddress` varchar(255) DEFAULT NULL,
  `stockSaleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stockSaleId` (`stockSaleId`),
  CONSTRAINT `walkincustomers_ibfk_1` FOREIGN KEY (`stockSaleId`) REFERENCES `stocksales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `walkincustomers`
--

LOCK TABLES `walkincustomers` WRITE;
/*!40000 ALTER TABLE `walkincustomers` DISABLE KEYS */;
INSERT INTO `walkincustomers` VALUES (9,'محمد پرچون والا','','',8),(10,'ګیراک','','',5),(11,'Hanif Aloko','','Mirwais Market',4),(12,'ګیراک','','',3),(13,'Mohammad Halimi',NULL,'kandahar',12),(14,'ښادمن علمی خزانه',NULL,'کندهار',13),(15,'اسمان صالون',NULL,'کندهار',20),(16,'احمد موسی هادین عنایت',NULL,'کندهار',22),(17,'Intersos',NULL,'Kandahar',23),(18,'همسایه، کلچو والا',NULL,'کندهار',27),(19,'انوار شرکت',NULL,'کندهار',118);
/*!40000 ALTER TABLE `walkincustomers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `withdrawals`
--

DROP TABLE IF EXISTS `withdrawals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `withdrawals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `code` char(3) NOT NULL,
  `baseAmount` double NOT NULL,
  `baseCode` char(3) NOT NULL,
  `journalId` int(11) DEFAULT NULL,
  `withdrawalAccountId` int(11) DEFAULT NULL,
  `cashAccountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journalId` (`journalId`),
  KEY `withdrawalAccountId` (`withdrawalAccountId`),
  KEY `cashAccountId` (`cashAccountId`),
  CONSTRAINT `withdrawals_ibfk_1` FOREIGN KEY (`journalId`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `withdrawals_ibfk_2` FOREIGN KEY (`withdrawalAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `withdrawals_ibfk_3` FOREIGN KEY (`cashAccountId`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdrawals`
--

LOCK TABLES `withdrawals` WRITE;
/*!40000 ALTER TABLE `withdrawals` DISABLE KEYS */;
/*!40000 ALTER TABLE `withdrawals` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-11 20:07:17
