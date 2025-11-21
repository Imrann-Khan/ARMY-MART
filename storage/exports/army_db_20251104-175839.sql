-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: army_db
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

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
-- Current Database: `army_db`
--

/*!40000 DROP DATABASE IF EXISTS `army_db`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `army_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `army_db`;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addresses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `address_type` varchar(255) NOT NULL,
  `parent_address_id` int(10) unsigned DEFAULT NULL,
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'null if guest checkout',
  `cart_id` int(10) unsigned DEFAULT NULL COMMENT 'only for cart_addresses',
  `order_id` int(10) unsigned DEFAULT NULL COMMENT 'only for order_addresses',
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `vat_id` varchar(255) DEFAULT NULL,
  `default_address` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'only for customer_addresses',
  `use_for_shipping` tinyint(1) NOT NULL DEFAULT 0,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `addresses_customer_id_foreign` (`customer_id`),
  KEY `addresses_cart_id_foreign` (`cart_id`),
  KEY `addresses_order_id_foreign` (`order_id`),
  KEY `addresses_parent_address_id_foreign` (`parent_address_id`),
  CONSTRAINT `addresses_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE,
  CONSTRAINT `addresses_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `addresses_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `addresses_parent_address_id_foreign` FOREIGN KEY (`parent_address_id`) REFERENCES `addresses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_password_resets`
--

DROP TABLE IF EXISTS `admin_password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `admin_password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_password_resets`
--

LOCK TABLES `admin_password_resets` WRITE;
/*!40000 ALTER TABLE `admin_password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `api_token` varchar(80) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `role_id` int(10) unsigned NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_email_unique` (`email`),
  UNIQUE KEY `admins_api_token_unique` (`api_token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'Example','admin@example.com','$2y$12$rI5.QSXLVlpJwdg1AkIb2.2UoegDVv6os2a/r8XzxPYKUYJkaObEC','qMAx8IOUOEPxwyCXLGpYzNoPF6Cguz2o8SmPUDUPBCXtZbml44wn4ZPbVPu4mWwuxi3iayFAYWW4P07w',1,1,NULL,NULL,'2025-11-04 01:10:10','2025-11-04 01:10:10');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_families`
--

DROP TABLE IF EXISTS `attribute_families`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribute_families` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `is_user_defined` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_families`
--

LOCK TABLES `attribute_families` WRITE;
/*!40000 ALTER TABLE `attribute_families` DISABLE KEYS */;
INSERT INTO `attribute_families` VALUES (1,'default','Default',0,1);
/*!40000 ALTER TABLE `attribute_families` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_group_mappings`
--

DROP TABLE IF EXISTS `attribute_group_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribute_group_mappings` (
  `attribute_id` int(10) unsigned NOT NULL,
  `attribute_group_id` int(10) unsigned NOT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`attribute_id`,`attribute_group_id`),
  KEY `attribute_group_mappings_attribute_group_id_foreign` (`attribute_group_id`),
  CONSTRAINT `attribute_group_mappings_attribute_group_id_foreign` FOREIGN KEY (`attribute_group_id`) REFERENCES `attribute_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `attribute_group_mappings_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_group_mappings`
--

LOCK TABLES `attribute_group_mappings` WRITE;
/*!40000 ALTER TABLE `attribute_group_mappings` DISABLE KEYS */;
INSERT INTO `attribute_group_mappings` VALUES (1,1,1),(2,1,3),(3,1,4),(4,1,5),(5,6,1),(6,6,2),(7,6,3),(8,6,4),(9,2,1),(10,2,2),(11,4,1),(12,4,2),(13,4,3),(14,4,4),(15,4,5),(16,3,1),(17,3,2),(18,3,3),(19,5,1),(20,5,2),(21,5,3),(22,5,4),(23,1,6),(24,1,7),(25,1,8),(26,6,5),(27,1,2),(28,7,1);
/*!40000 ALTER TABLE `attribute_group_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_groups`
--

DROP TABLE IF EXISTS `attribute_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribute_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `attribute_family_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `column` int(11) NOT NULL DEFAULT 1,
  `position` int(11) NOT NULL,
  `is_user_defined` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attribute_groups_attribute_family_id_name_unique` (`attribute_family_id`,`name`),
  CONSTRAINT `attribute_groups_attribute_family_id_foreign` FOREIGN KEY (`attribute_family_id`) REFERENCES `attribute_families` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_groups`
--

LOCK TABLES `attribute_groups` WRITE;
/*!40000 ALTER TABLE `attribute_groups` DISABLE KEYS */;
INSERT INTO `attribute_groups` VALUES (1,'general',1,'General',1,1,0),(2,'description',1,'Description',1,2,0),(3,'meta_description',1,'Meta Description',1,3,0),(4,'price',1,'Price',2,1,0),(5,'shipping',1,'Shipping',2,2,0),(6,'settings',1,'Settings',2,3,0),(7,'inventories',1,'Inventories',2,4,0);
/*!40000 ALTER TABLE `attribute_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_option_translations`
--

DROP TABLE IF EXISTS `attribute_option_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribute_option_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attribute_option_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `label` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attribute_option_locale_unique` (`attribute_option_id`,`locale`),
  CONSTRAINT `attribute_option_translations_attribute_option_id_foreign` FOREIGN KEY (`attribute_option_id`) REFERENCES `attribute_options` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_option_translations`
--

LOCK TABLES `attribute_option_translations` WRITE;
/*!40000 ALTER TABLE `attribute_option_translations` DISABLE KEYS */;
INSERT INTO `attribute_option_translations` VALUES (1,1,'en','Red'),(2,2,'en','Green'),(3,3,'en','Yellow'),(4,4,'en','Black'),(5,5,'en','White'),(6,6,'en','S'),(7,7,'en','M'),(8,8,'en','L'),(9,9,'en','XL');
/*!40000 ALTER TABLE `attribute_option_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_options`
--

DROP TABLE IF EXISTS `attribute_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribute_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attribute_id` int(10) unsigned NOT NULL,
  `admin_name` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `swatch_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attribute_options_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `attribute_options_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_options`
--

LOCK TABLES `attribute_options` WRITE;
/*!40000 ALTER TABLE `attribute_options` DISABLE KEYS */;
INSERT INTO `attribute_options` VALUES (1,23,'Red',1,NULL),(2,23,'Green',2,NULL),(3,23,'Yellow',3,NULL),(4,23,'Black',4,NULL),(5,23,'White',5,NULL),(6,24,'S',1,NULL),(7,24,'M',2,NULL),(8,24,'L',3,NULL),(9,24,'XL',4,NULL);
/*!40000 ALTER TABLE `attribute_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_translations`
--

DROP TABLE IF EXISTS `attribute_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribute_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attribute_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `name` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attribute_translations_attribute_id_locale_unique` (`attribute_id`,`locale`),
  CONSTRAINT `attribute_translations_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_translations`
--

LOCK TABLES `attribute_translations` WRITE;
/*!40000 ALTER TABLE `attribute_translations` DISABLE KEYS */;
INSERT INTO `attribute_translations` VALUES (1,1,'en','SKU'),(2,2,'en','Name'),(3,3,'en','URL Key'),(4,4,'en','Tax Category'),(5,5,'en','New'),(6,6,'en','Featured'),(7,7,'en','Visible Individually'),(8,8,'en','Status'),(9,9,'en','Short Description'),(10,10,'en','Description'),(11,11,'en','Price'),(12,12,'en','Cost'),(13,13,'en','Special Price'),(14,14,'en','Special Price From'),(15,15,'en','Special Price To'),(16,16,'en','Meta Title'),(17,17,'en','Meta Keywords'),(18,18,'en','Meta Description'),(19,19,'en','Length'),(20,20,'en','Width'),(21,21,'en','Height'),(22,22,'en','Weight'),(23,23,'en','Color'),(24,24,'en','Size'),(25,25,'en','Brand'),(26,26,'en','Guest Checkout'),(27,27,'en','Product Number'),(28,28,'en','Manage Stock');
/*!40000 ALTER TABLE `attribute_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attributes`
--

DROP TABLE IF EXISTS `attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attributes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `admin_name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `swatch_type` varchar(255) DEFAULT NULL,
  `validation` varchar(255) DEFAULT NULL,
  `regex` varchar(255) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `is_unique` tinyint(1) NOT NULL DEFAULT 0,
  `is_filterable` tinyint(1) NOT NULL DEFAULT 0,
  `is_comparable` tinyint(1) NOT NULL DEFAULT 0,
  `is_configurable` tinyint(1) NOT NULL DEFAULT 0,
  `is_user_defined` tinyint(1) NOT NULL DEFAULT 1,
  `is_visible_on_front` tinyint(1) NOT NULL DEFAULT 0,
  `value_per_locale` tinyint(1) NOT NULL DEFAULT 0,
  `value_per_channel` tinyint(1) NOT NULL DEFAULT 0,
  `default_value` int(11) DEFAULT NULL,
  `enable_wysiwyg` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attributes_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attributes`
--

LOCK TABLES `attributes` WRITE;
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
INSERT INTO `attributes` VALUES (1,'sku','SKU','text',NULL,NULL,NULL,1,1,1,0,0,0,0,0,0,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(2,'name','Name','text',NULL,NULL,NULL,3,1,0,0,1,0,0,0,1,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(3,'url_key','URL Key','text',NULL,NULL,NULL,4,1,1,0,0,0,0,0,1,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(4,'tax_category_id','Tax Category','select',NULL,NULL,NULL,5,0,0,0,0,0,0,0,0,1,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(5,'new','New','boolean',NULL,NULL,NULL,6,0,0,0,0,0,0,0,0,0,1,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(6,'featured','Featured','boolean',NULL,NULL,NULL,7,0,0,0,0,0,0,0,0,0,1,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(7,'visible_individually','Visible Individually','boolean',NULL,NULL,NULL,9,1,0,0,0,0,0,0,0,0,1,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(8,'status','Status','boolean',NULL,NULL,NULL,10,1,0,0,0,0,0,0,0,1,1,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(9,'short_description','Short Description','textarea',NULL,NULL,NULL,11,1,0,0,0,0,0,0,1,0,NULL,1,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(10,'description','Description','textarea',NULL,NULL,NULL,12,1,0,0,1,0,0,0,1,0,NULL,1,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(11,'price','Price','price',NULL,'decimal',NULL,13,1,0,1,1,0,0,0,0,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(12,'cost','Cost','price',NULL,'decimal',NULL,14,0,0,0,0,0,1,0,0,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(13,'special_price','Special Price','price',NULL,'decimal',NULL,15,0,0,0,0,0,0,0,0,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(14,'special_price_from','Special Price From','date',NULL,NULL,NULL,16,0,0,0,0,0,0,0,0,1,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(15,'special_price_to','Special Price To','date',NULL,NULL,NULL,17,0,0,0,0,0,0,0,0,1,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(16,'meta_title','Meta Title','textarea',NULL,NULL,NULL,18,0,0,0,0,0,0,0,1,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(17,'meta_keywords','Meta Keywords','textarea',NULL,NULL,NULL,20,0,0,0,0,0,0,0,1,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(18,'meta_description','Meta Description','textarea',NULL,NULL,NULL,21,0,0,0,0,0,1,0,1,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(19,'length','Length','text',NULL,'decimal',NULL,22,0,0,0,0,0,1,0,0,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(20,'width','Width','text',NULL,'decimal',NULL,23,0,0,0,0,0,1,0,0,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(21,'height','Height','text',NULL,'decimal',NULL,24,0,0,0,0,0,1,0,0,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(22,'weight','Weight','text',NULL,'decimal',NULL,25,1,0,0,0,0,0,0,0,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(23,'color','Color','select',NULL,NULL,NULL,26,0,0,1,0,1,1,0,0,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(24,'size','Size','select',NULL,NULL,NULL,27,0,0,1,0,1,1,0,0,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(25,'brand','Brand','select',NULL,NULL,NULL,28,0,0,1,0,0,1,1,0,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(26,'guest_checkout','Guest Checkout','boolean',NULL,NULL,NULL,8,1,0,0,0,0,0,0,0,0,1,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(27,'product_number','Product Number','text',NULL,NULL,NULL,2,0,1,0,0,0,0,0,0,0,NULL,0,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(28,'manage_stock','Manage Stock','boolean',NULL,NULL,NULL,1,0,0,0,0,0,0,0,0,1,1,0,'2025-11-04 01:10:09','2025-11-04 01:10:09');
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_product_appointment_slots`
--

DROP TABLE IF EXISTS `booking_product_appointment_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking_product_appointment_slots` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_product_id` int(10) unsigned NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `break_time` int(11) DEFAULT NULL,
  `same_slot_all_days` tinyint(1) DEFAULT NULL,
  `slots` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`slots`)),
  PRIMARY KEY (`id`),
  KEY `booking_product_appointment_slots_booking_product_id_foreign` (`booking_product_id`),
  CONSTRAINT `booking_product_appointment_slots_booking_product_id_foreign` FOREIGN KEY (`booking_product_id`) REFERENCES `booking_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_product_appointment_slots`
--

LOCK TABLES `booking_product_appointment_slots` WRITE;
/*!40000 ALTER TABLE `booking_product_appointment_slots` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_product_appointment_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_product_default_slots`
--

DROP TABLE IF EXISTS `booking_product_default_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking_product_default_slots` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_product_id` int(10) unsigned NOT NULL,
  `booking_type` varchar(255) NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `break_time` int(11) DEFAULT NULL,
  `slots` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`slots`)),
  PRIMARY KEY (`id`),
  KEY `booking_product_default_slots_booking_product_id_foreign` (`booking_product_id`),
  CONSTRAINT `booking_product_default_slots_booking_product_id_foreign` FOREIGN KEY (`booking_product_id`) REFERENCES `booking_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_product_default_slots`
--

LOCK TABLES `booking_product_default_slots` WRITE;
/*!40000 ALTER TABLE `booking_product_default_slots` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_product_default_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_product_event_ticket_translations`
--

DROP TABLE IF EXISTS `booking_product_event_ticket_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking_product_event_ticket_translations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_product_event_ticket_id` bigint(20) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `name` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bpet_locale_unique` (`booking_product_event_ticket_id`,`locale`),
  CONSTRAINT `bpet_translations_fk` FOREIGN KEY (`booking_product_event_ticket_id`) REFERENCES `booking_product_event_tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_product_event_ticket_translations`
--

LOCK TABLES `booking_product_event_ticket_translations` WRITE;
/*!40000 ALTER TABLE `booking_product_event_ticket_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_product_event_ticket_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_product_event_tickets`
--

DROP TABLE IF EXISTS `booking_product_event_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking_product_event_tickets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_product_id` int(10) unsigned NOT NULL,
  `price` decimal(12,4) DEFAULT 0.0000,
  `qty` int(11) DEFAULT 0,
  `special_price` decimal(12,4) DEFAULT NULL,
  `special_price_from` datetime DEFAULT NULL,
  `special_price_to` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_product_event_tickets_booking_product_id_foreign` (`booking_product_id`),
  CONSTRAINT `booking_product_event_tickets_booking_product_id_foreign` FOREIGN KEY (`booking_product_id`) REFERENCES `booking_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_product_event_tickets`
--

LOCK TABLES `booking_product_event_tickets` WRITE;
/*!40000 ALTER TABLE `booking_product_event_tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_product_event_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_product_rental_slots`
--

DROP TABLE IF EXISTS `booking_product_rental_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking_product_rental_slots` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_product_id` int(10) unsigned NOT NULL,
  `renting_type` varchar(255) NOT NULL,
  `daily_price` decimal(12,4) DEFAULT 0.0000,
  `hourly_price` decimal(12,4) DEFAULT 0.0000,
  `same_slot_all_days` tinyint(1) DEFAULT NULL,
  `slots` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`slots`)),
  PRIMARY KEY (`id`),
  KEY `booking_product_rental_slots_booking_product_id_foreign` (`booking_product_id`),
  CONSTRAINT `booking_product_rental_slots_booking_product_id_foreign` FOREIGN KEY (`booking_product_id`) REFERENCES `booking_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_product_rental_slots`
--

LOCK TABLES `booking_product_rental_slots` WRITE;
/*!40000 ALTER TABLE `booking_product_rental_slots` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_product_rental_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_product_table_slots`
--

DROP TABLE IF EXISTS `booking_product_table_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking_product_table_slots` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_product_id` int(10) unsigned NOT NULL,
  `price_type` varchar(255) NOT NULL,
  `guest_limit` int(11) NOT NULL DEFAULT 0,
  `duration` int(11) NOT NULL,
  `break_time` int(11) NOT NULL,
  `prevent_scheduling_before` int(11) NOT NULL,
  `same_slot_all_days` tinyint(1) DEFAULT NULL,
  `slots` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`slots`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_product_table_slots_booking_product_id_foreign` (`booking_product_id`),
  CONSTRAINT `booking_product_table_slots_booking_product_id_foreign` FOREIGN KEY (`booking_product_id`) REFERENCES `booking_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_product_table_slots`
--

LOCK TABLES `booking_product_table_slots` WRITE;
/*!40000 ALTER TABLE `booking_product_table_slots` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_product_table_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_products`
--

DROP TABLE IF EXISTS `booking_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking_products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `qty` int(11) DEFAULT 0,
  `location` varchar(255) DEFAULT NULL,
  `show_location` tinyint(1) NOT NULL DEFAULT 0,
  `available_every_week` tinyint(1) DEFAULT NULL,
  `available_from` datetime DEFAULT NULL,
  `available_to` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_products_product_id_foreign` (`product_id`),
  CONSTRAINT `booking_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_products`
--

LOCK TABLES `booking_products` WRITE;
/*!40000 ALTER TABLE `booking_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned DEFAULT NULL,
  `order_item_id` int(10) unsigned DEFAULT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  `qty` int(11) DEFAULT 0,
  `from` int(11) DEFAULT NULL,
  `to` int(11) DEFAULT NULL,
  `booking_product_event_ticket_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_order_item_id_foreign` (`order_item_id`),
  KEY `bookings_booking_product_event_ticket_id_foreign` (`booking_product_event_ticket_id`),
  KEY `bookings_order_id_foreign` (`order_id`),
  KEY `bookings_product_id_foreign` (`product_id`),
  CONSTRAINT `bookings_booking_product_event_ticket_id_foreign` FOREIGN KEY (`booking_product_event_ticket_id`) REFERENCES `booking_product_event_tickets` (`id`) ON DELETE SET NULL,
  CONSTRAINT `bookings_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL,
  CONSTRAINT `bookings_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE SET NULL,
  CONSTRAINT `bookings_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_email` varchar(255) DEFAULT NULL,
  `customer_first_name` varchar(255) DEFAULT NULL,
  `customer_last_name` varchar(255) DEFAULT NULL,
  `shipping_method` varchar(255) DEFAULT NULL,
  `coupon_code` varchar(255) DEFAULT NULL,
  `is_gift` tinyint(1) NOT NULL DEFAULT 0,
  `items_count` int(11) DEFAULT NULL,
  `items_qty` decimal(12,4) DEFAULT NULL,
  `exchange_rate` decimal(12,4) DEFAULT NULL,
  `global_currency_code` varchar(255) DEFAULT NULL,
  `base_currency_code` varchar(255) DEFAULT NULL,
  `channel_currency_code` varchar(255) DEFAULT NULL,
  `cart_currency_code` varchar(255) DEFAULT NULL,
  `grand_total` decimal(12,4) DEFAULT 0.0000,
  `base_grand_total` decimal(12,4) DEFAULT 0.0000,
  `sub_total` decimal(12,4) DEFAULT 0.0000,
  `base_sub_total` decimal(12,4) DEFAULT 0.0000,
  `tax_total` decimal(12,4) DEFAULT 0.0000,
  `base_tax_total` decimal(12,4) DEFAULT 0.0000,
  `discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `shipping_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_shipping_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `checkout_method` varchar(255) DEFAULT NULL,
  `is_guest` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `applied_cart_rule_ids` varchar(255) DEFAULT NULL,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_customer_id_foreign` (`customer_id`),
  KEY `cart_channel_id_foreign` (`channel_id`),
  CONSTRAINT `cart_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item_inventories`
--

DROP TABLE IF EXISTS `cart_item_inventories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_item_inventories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qty` int(10) unsigned NOT NULL DEFAULT 0,
  `inventory_source_id` int(10) unsigned DEFAULT NULL,
  `cart_item_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item_inventories`
--

LOCK TABLES `cart_item_inventories` WRITE;
/*!40000 ALTER TABLE `cart_item_inventories` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_item_inventories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quantity` int(10) unsigned NOT NULL DEFAULT 0,
  `sku` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `coupon_code` varchar(255) DEFAULT NULL,
  `weight` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `total_weight` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total_weight` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `price` decimal(12,4) NOT NULL DEFAULT 1.0000,
  `base_price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `custom_price` decimal(12,4) DEFAULT NULL,
  `total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `tax_percent` decimal(12,4) DEFAULT 0.0000,
  `tax_amount` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) DEFAULT 0.0000,
  `discount_percent` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `discount_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `price_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_price_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `applied_tax_rate` varchar(255) DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `cart_id` int(10) unsigned NOT NULL,
  `tax_category_id` int(10) unsigned DEFAULT NULL,
  `applied_cart_rule_ids` varchar(255) DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_items_parent_id_foreign` (`parent_id`),
  KEY `cart_items_product_id_foreign` (`product_id`),
  KEY `cart_items_cart_id_foreign` (`cart_id`),
  KEY `cart_items_tax_category_id_foreign` (`tax_category_id`),
  CONSTRAINT `cart_items_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `cart_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_tax_category_id_foreign` FOREIGN KEY (`tax_category_id`) REFERENCES `tax_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_payment`
--

DROP TABLE IF EXISTS `cart_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `method` varchar(255) NOT NULL,
  `method_title` varchar(255) DEFAULT NULL,
  `cart_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_payment_cart_id_foreign` (`cart_id`),
  CONSTRAINT `cart_payment_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_payment`
--

LOCK TABLES `cart_payment` WRITE;
/*!40000 ALTER TABLE `cart_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rule_channels`
--

DROP TABLE IF EXISTS `cart_rule_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_rule_channels` (
  `cart_rule_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cart_rule_id`,`channel_id`),
  KEY `cart_rule_channels_channel_id_foreign` (`channel_id`),
  CONSTRAINT `cart_rule_channels_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_rule_channels_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rule_channels`
--

LOCK TABLES `cart_rule_channels` WRITE;
/*!40000 ALTER TABLE `cart_rule_channels` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rule_channels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rule_coupon_usage`
--

DROP TABLE IF EXISTS `cart_rule_coupon_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_rule_coupon_usage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `times_used` int(11) NOT NULL DEFAULT 0,
  `cart_rule_coupon_id` int(10) unsigned NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_rule_coupon_usage_cart_rule_coupon_id_foreign` (`cart_rule_coupon_id`),
  KEY `cart_rule_coupon_usage_customer_id_foreign` (`customer_id`),
  CONSTRAINT `cart_rule_coupon_usage_cart_rule_coupon_id_foreign` FOREIGN KEY (`cart_rule_coupon_id`) REFERENCES `cart_rule_coupons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_rule_coupon_usage_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rule_coupon_usage`
--

LOCK TABLES `cart_rule_coupon_usage` WRITE;
/*!40000 ALTER TABLE `cart_rule_coupon_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rule_coupon_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rule_coupons`
--

DROP TABLE IF EXISTS `cart_rule_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_rule_coupons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `usage_limit` int(10) unsigned NOT NULL DEFAULT 0,
  `usage_per_customer` int(10) unsigned NOT NULL DEFAULT 0,
  `times_used` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(10) unsigned NOT NULL DEFAULT 0,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `expired_at` date DEFAULT NULL,
  `cart_rule_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_rule_coupons_cart_rule_id_foreign` (`cart_rule_id`),
  CONSTRAINT `cart_rule_coupons_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rule_coupons`
--

LOCK TABLES `cart_rule_coupons` WRITE;
/*!40000 ALTER TABLE `cart_rule_coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rule_coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rule_customer_groups`
--

DROP TABLE IF EXISTS `cart_rule_customer_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_rule_customer_groups` (
  `cart_rule_id` int(10) unsigned NOT NULL,
  `customer_group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cart_rule_id`,`customer_group_id`),
  KEY `cart_rule_customer_groups_customer_group_id_foreign` (`customer_group_id`),
  CONSTRAINT `cart_rule_customer_groups_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_rule_customer_groups_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rule_customer_groups`
--

LOCK TABLES `cart_rule_customer_groups` WRITE;
/*!40000 ALTER TABLE `cart_rule_customer_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rule_customer_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rule_customers`
--

DROP TABLE IF EXISTS `cart_rule_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_rule_customers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `times_used` bigint(20) unsigned NOT NULL DEFAULT 0,
  `customer_id` int(10) unsigned NOT NULL,
  `cart_rule_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_rule_customers_cart_rule_id_foreign` (`cart_rule_id`),
  KEY `cart_rule_customers_customer_id_foreign` (`customer_id`),
  CONSTRAINT `cart_rule_customers_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_rule_customers_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rule_customers`
--

LOCK TABLES `cart_rule_customers` WRITE;
/*!40000 ALTER TABLE `cart_rule_customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rule_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rule_translations`
--

DROP TABLE IF EXISTS `cart_rule_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_rule_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(255) NOT NULL,
  `label` text DEFAULT NULL,
  `cart_rule_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cart_rule_translations_cart_rule_id_locale_unique` (`cart_rule_id`,`locale`),
  CONSTRAINT `cart_rule_translations_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rule_translations`
--

LOCK TABLES `cart_rule_translations` WRITE;
/*!40000 ALTER TABLE `cart_rule_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rule_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rules`
--

DROP TABLE IF EXISTS `cart_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `starts_from` datetime DEFAULT NULL,
  `ends_till` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `coupon_type` int(11) NOT NULL DEFAULT 1,
  `use_auto_generation` tinyint(1) NOT NULL DEFAULT 0,
  `usage_per_customer` int(11) NOT NULL DEFAULT 0,
  `uses_per_coupon` int(11) NOT NULL DEFAULT 0,
  `times_used` int(10) unsigned NOT NULL DEFAULT 0,
  `condition_type` tinyint(1) NOT NULL DEFAULT 1,
  `conditions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`conditions`)),
  `end_other_rules` tinyint(1) NOT NULL DEFAULT 0,
  `uses_attribute_conditions` tinyint(1) NOT NULL DEFAULT 0,
  `action_type` varchar(255) DEFAULT NULL,
  `discount_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `discount_quantity` int(11) NOT NULL DEFAULT 1,
  `discount_step` varchar(255) NOT NULL DEFAULT '1',
  `apply_to_shipping` tinyint(1) NOT NULL DEFAULT 0,
  `free_shipping` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rules`
--

LOCK TABLES `cart_rules` WRITE;
/*!40000 ALTER TABLE `cart_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_shipping_rates`
--

DROP TABLE IF EXISTS `cart_shipping_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_shipping_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `carrier` varchar(255) NOT NULL,
  `carrier_title` varchar(255) NOT NULL,
  `method` varchar(255) NOT NULL,
  `method_title` varchar(255) NOT NULL,
  `method_description` varchar(255) DEFAULT NULL,
  `price` double DEFAULT 0,
  `base_price` double DEFAULT 0,
  `discount_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `tax_percent` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `tax_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `price_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_price_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `applied_tax_rate` varchar(255) DEFAULT NULL,
  `is_calculate_tax` tinyint(1) NOT NULL DEFAULT 1,
  `cart_address_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cart_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_shipping_rates_cart_id_foreign` (`cart_id`),
  CONSTRAINT `cart_shipping_rates_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_shipping_rates`
--

LOCK TABLES `cart_shipping_rates` WRITE;
/*!40000 ALTER TABLE `cart_shipping_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_shipping_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_rule_channels`
--

DROP TABLE IF EXISTS `catalog_rule_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_rule_channels` (
  `catalog_rule_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`catalog_rule_id`,`channel_id`),
  KEY `catalog_rule_channels_channel_id_foreign` (`channel_id`),
  CONSTRAINT `catalog_rule_channels_catalog_rule_id_foreign` FOREIGN KEY (`catalog_rule_id`) REFERENCES `catalog_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_channels_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_rule_channels`
--

LOCK TABLES `catalog_rule_channels` WRITE;
/*!40000 ALTER TABLE `catalog_rule_channels` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_rule_channels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_rule_customer_groups`
--

DROP TABLE IF EXISTS `catalog_rule_customer_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_rule_customer_groups` (
  `catalog_rule_id` int(10) unsigned NOT NULL,
  `customer_group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`catalog_rule_id`,`customer_group_id`),
  KEY `catalog_rule_customer_groups_customer_group_id_foreign` (`customer_group_id`),
  CONSTRAINT `catalog_rule_customer_groups_catalog_rule_id_foreign` FOREIGN KEY (`catalog_rule_id`) REFERENCES `catalog_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_customer_groups_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_rule_customer_groups`
--

LOCK TABLES `catalog_rule_customer_groups` WRITE;
/*!40000 ALTER TABLE `catalog_rule_customer_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_rule_customer_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_rule_product_prices`
--

DROP TABLE IF EXISTS `catalog_rule_product_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_rule_product_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `rule_date` date NOT NULL,
  `starts_from` datetime DEFAULT NULL,
  `ends_till` datetime DEFAULT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `customer_group_id` int(10) unsigned NOT NULL,
  `catalog_rule_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalog_rule_product_prices_product_id_foreign` (`product_id`),
  KEY `catalog_rule_product_prices_customer_group_id_foreign` (`customer_group_id`),
  KEY `catalog_rule_product_prices_catalog_rule_id_foreign` (`catalog_rule_id`),
  KEY `catalog_rule_product_prices_channel_id_foreign` (`channel_id`),
  CONSTRAINT `catalog_rule_product_prices_catalog_rule_id_foreign` FOREIGN KEY (`catalog_rule_id`) REFERENCES `catalog_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_product_prices_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_product_prices_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_product_prices_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_rule_product_prices`
--

LOCK TABLES `catalog_rule_product_prices` WRITE;
/*!40000 ALTER TABLE `catalog_rule_product_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_rule_product_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_rule_products`
--

DROP TABLE IF EXISTS `catalog_rule_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_rule_products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `starts_from` datetime DEFAULT NULL,
  `ends_till` datetime DEFAULT NULL,
  `end_other_rules` tinyint(1) NOT NULL DEFAULT 0,
  `action_type` varchar(255) DEFAULT NULL,
  `discount_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `sort_order` int(10) unsigned NOT NULL DEFAULT 0,
  `product_id` int(10) unsigned NOT NULL,
  `customer_group_id` int(10) unsigned NOT NULL,
  `catalog_rule_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalog_rule_products_product_id_foreign` (`product_id`),
  KEY `catalog_rule_products_customer_group_id_foreign` (`customer_group_id`),
  KEY `catalog_rule_products_catalog_rule_id_foreign` (`catalog_rule_id`),
  KEY `catalog_rule_products_channel_id_foreign` (`channel_id`),
  CONSTRAINT `catalog_rule_products_catalog_rule_id_foreign` FOREIGN KEY (`catalog_rule_id`) REFERENCES `catalog_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_products_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_products_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `catalog_rule_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_rule_products`
--

LOCK TABLES `catalog_rule_products` WRITE;
/*!40000 ALTER TABLE `catalog_rule_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_rule_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_rules`
--

DROP TABLE IF EXISTS `catalog_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `starts_from` date DEFAULT NULL,
  `ends_till` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `condition_type` tinyint(1) NOT NULL DEFAULT 1,
  `conditions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`conditions`)),
  `end_other_rules` tinyint(1) NOT NULL DEFAULT 0,
  `action_type` varchar(255) DEFAULT NULL,
  `discount_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `sort_order` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_rules`
--

LOCK TABLES `catalog_rules` WRITE;
/*!40000 ALTER TABLE `catalog_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `position` int(11) NOT NULL DEFAULT 0,
  `logo_path` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `display_mode` varchar(255) DEFAULT 'products_and_description',
  `_lft` int(10) unsigned NOT NULL DEFAULT 0,
  `_rgt` int(10) unsigned NOT NULL DEFAULT 0,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `banner_path` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories__lft__rgt_parent_id_index` (`_lft`,`_rgt`,`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,1,NULL,1,'products_and_description',1,12,NULL,NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(2,1,'category/2/zH8xRqAIpXU6m9NjmlZcZEAv4qCA8oIlDqtEY7ZD.webp',1,'products_and_description',6,7,1,NULL,'category/2/NjtoWtTIYfesGsiY8nnrNPUbVnNMSTsC3zomZmMs.webp','2025-11-04 09:33:55','2025-11-04 09:33:55'),(3,1,'category/3/uXpjxjir1pzd2cAWSe7jydYhEUP4lL0YcIALx8jB.webp',1,'products_and_description',8,9,1,NULL,'category/3/epbvkLm73i8QBciAi6KoBdXb4rH0bn4opDGz8jec.webp','2025-11-04 09:34:47','2025-11-04 09:36:35'),(4,1,'category/4/ZCW39MeIEUrFUvOl8JZquiXWx48233MWScN5NZiU.webp',1,'products_and_description',10,11,1,NULL,'category/4/maVWedHebQgqA9hTHJ3QXwUPdn763NhoDP4yqeh5.webp','2025-11-04 09:36:13','2025-11-04 09:36:49');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_filterable_attributes`
--

DROP TABLE IF EXISTS `category_filterable_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_filterable_attributes` (
  `category_id` int(10) unsigned NOT NULL,
  `attribute_id` int(10) unsigned NOT NULL,
  KEY `category_filterable_attributes_category_id_foreign` (`category_id`),
  KEY `category_filterable_attributes_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `category_filterable_attributes_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `category_filterable_attributes_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_filterable_attributes`
--

LOCK TABLES `category_filterable_attributes` WRITE;
/*!40000 ALTER TABLE `category_filterable_attributes` DISABLE KEYS */;
INSERT INTO `category_filterable_attributes` VALUES (2,11),(2,24),(3,11),(3,24),(4,11);
/*!40000 ALTER TABLE `category_filterable_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_translations`
--

DROP TABLE IF EXISTS `category_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `name` text NOT NULL,
  `slug` varchar(255) NOT NULL,
  `url_path` varchar(2048) NOT NULL,
  `description` text DEFAULT NULL,
  `meta_title` text DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `locale_id` int(10) unsigned DEFAULT NULL,
  `locale` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_translations_category_id_slug_locale_unique` (`category_id`,`slug`,`locale`),
  KEY `category_translations_locale_id_foreign` (`locale_id`),
  CONSTRAINT `category_translations_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `category_translations_locale_id_foreign` FOREIGN KEY (`locale_id`) REFERENCES `locales` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_translations`
--

LOCK TABLES `category_translations` WRITE;
/*!40000 ALTER TABLE `category_translations` DISABLE KEYS */;
INSERT INTO `category_translations` VALUES (1,1,'Root','root','','Root Category Description','','','',NULL,'en'),(2,2,'Clothes','clothes','','<p>.</p>','Category','','',1,'en'),(3,3,'Shoes','shoes','','<p>.</p>','Category','','',1,'en'),(4,4,'Accessories','accessories','','<p>.</p>','Category','','',1,'en');
/*!40000 ALTER TABLE `category_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel_currencies`
--

DROP TABLE IF EXISTS `channel_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `channel_currencies` (
  `channel_id` int(10) unsigned NOT NULL,
  `currency_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`channel_id`,`currency_id`),
  KEY `channel_currencies_currency_id_foreign` (`currency_id`),
  CONSTRAINT `channel_currencies_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `channel_currencies_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_currencies`
--

LOCK TABLES `channel_currencies` WRITE;
/*!40000 ALTER TABLE `channel_currencies` DISABLE KEYS */;
INSERT INTO `channel_currencies` VALUES (1,1);
/*!40000 ALTER TABLE `channel_currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel_inventory_sources`
--

DROP TABLE IF EXISTS `channel_inventory_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `channel_inventory_sources` (
  `channel_id` int(10) unsigned NOT NULL,
  `inventory_source_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `channel_inventory_source_unique` (`channel_id`,`inventory_source_id`),
  KEY `channel_inventory_sources_inventory_source_id_foreign` (`inventory_source_id`),
  CONSTRAINT `channel_inventory_sources_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `channel_inventory_sources_inventory_source_id_foreign` FOREIGN KEY (`inventory_source_id`) REFERENCES `inventory_sources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_inventory_sources`
--

LOCK TABLES `channel_inventory_sources` WRITE;
/*!40000 ALTER TABLE `channel_inventory_sources` DISABLE KEYS */;
INSERT INTO `channel_inventory_sources` VALUES (1,1);
/*!40000 ALTER TABLE `channel_inventory_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel_locales`
--

DROP TABLE IF EXISTS `channel_locales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `channel_locales` (
  `channel_id` int(10) unsigned NOT NULL,
  `locale_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`channel_id`,`locale_id`),
  KEY `channel_locales_locale_id_foreign` (`locale_id`),
  CONSTRAINT `channel_locales_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `channel_locales_locale_id_foreign` FOREIGN KEY (`locale_id`) REFERENCES `locales` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_locales`
--

LOCK TABLES `channel_locales` WRITE;
/*!40000 ALTER TABLE `channel_locales` DISABLE KEYS */;
INSERT INTO `channel_locales` VALUES (1,1);
/*!40000 ALTER TABLE `channel_locales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel_translations`
--

DROP TABLE IF EXISTS `channel_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `channel_translations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `maintenance_mode_text` text DEFAULT NULL,
  `home_seo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`home_seo`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `channel_translations_channel_id_locale_unique` (`channel_id`,`locale`),
  KEY `channel_translations_locale_index` (`locale`),
  CONSTRAINT `channel_translations_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_translations`
--

LOCK TABLES `channel_translations` WRITE;
/*!40000 ALTER TABLE `channel_translations` DISABLE KEYS */;
INSERT INTO `channel_translations` VALUES (1,1,'en','Army Mart',NULL,'','{\"meta_title\":\"Army Mart\",\"meta_description\":\"Army Mart\",\"meta_keywords\":\"Army mart meta keyword\"}',NULL,'2025-11-04 11:03:54');
/*!40000 ALTER TABLE `channel_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channels`
--

DROP TABLE IF EXISTS `channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `channels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `theme` varchar(255) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `favicon` varchar(255) DEFAULT NULL,
  `home_seo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`home_seo`)),
  `is_maintenance_on` tinyint(1) NOT NULL DEFAULT 0,
  `allowed_ips` text DEFAULT NULL,
  `root_category_id` int(10) unsigned DEFAULT NULL,
  `default_locale_id` int(10) unsigned NOT NULL,
  `base_currency_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `channels_root_category_id_foreign` (`root_category_id`),
  KEY `channels_default_locale_id_foreign` (`default_locale_id`),
  KEY `channels_base_currency_id_foreign` (`base_currency_id`),
  CONSTRAINT `channels_base_currency_id_foreign` FOREIGN KEY (`base_currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `channels_default_locale_id_foreign` FOREIGN KEY (`default_locale_id`) REFERENCES `locales` (`id`),
  CONSTRAINT `channels_root_category_id_foreign` FOREIGN KEY (`root_category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channels`
--

LOCK TABLES `channels` WRITE;
/*!40000 ALTER TABLE `channels` DISABLE KEYS */;
INSERT INTO `channels` VALUES (1,'default',NULL,'default','http://localhost/army-mart/public','channel/1/a31xSMFEmx1uaB13F9IM9WGlUM320fjrE3F56l9B.png','channel/1/PSD4lL3cWYSTOoVsljY1r6PvZWctOlemcmlt71Iz.png',NULL,0,'',1,1,1,'2025-11-04 01:10:09','2025-11-04 11:09:52');
/*!40000 ALTER TABLE `channels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_page_channels`
--

DROP TABLE IF EXISTS `cms_page_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_page_channels` (
  `cms_page_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `cms_page_channels_cms_page_id_channel_id_unique` (`cms_page_id`,`channel_id`),
  KEY `cms_page_channels_channel_id_foreign` (`channel_id`),
  CONSTRAINT `cms_page_channels_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_page_channels_cms_page_id_foreign` FOREIGN KEY (`cms_page_id`) REFERENCES `cms_pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_page_channels`
--

LOCK TABLES `cms_page_channels` WRITE;
/*!40000 ALTER TABLE `cms_page_channels` DISABLE KEYS */;
INSERT INTO `cms_page_channels` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1);
/*!40000 ALTER TABLE `cms_page_channels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_page_translations`
--

DROP TABLE IF EXISTS `cms_page_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_page_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_title` varchar(255) NOT NULL,
  `url_key` varchar(255) NOT NULL,
  `html_content` longtext DEFAULT NULL,
  `meta_title` text DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `locale` varchar(255) NOT NULL,
  `cms_page_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_page_translations_cms_page_id_url_key_locale_unique` (`cms_page_id`,`url_key`,`locale`),
  CONSTRAINT `cms_page_translations_cms_page_id_foreign` FOREIGN KEY (`cms_page_id`) REFERENCES `cms_pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_page_translations`
--

LOCK TABLES `cms_page_translations` WRITE;
/*!40000 ALTER TABLE `cms_page_translations` DISABLE KEYS */;
INSERT INTO `cms_page_translations` VALUES (1,'About Us','about-us','<div class=\"static-container\"><div class=\"mb-5\">About Us Page Content</div></div>','about us','','aboutus','en',1),(2,'Return Policy','return-policy','<div class=\"static-container\"><div class=\"mb-5\">Return Policy Page Content</div></div>','return policy','','return, policy','en',2),(3,'Refund Policy','refund-policy','<div class=\"static-container\"><div class=\"mb-5\">Refund Policy Page Content</div></div>','Refund policy','','refund, policy','en',3),(4,'Terms & Conditions','terms-conditions','<div class=\"static-container\"><div class=\"mb-5\">Terms & Conditions Page Content</div></div>','Terms & Conditions','','term, conditions','en',4),(5,'Terms of Use','terms-of-use','<div class=\"static-container\"><div class=\"mb-5\">Terms of Use Page Content</div></div>','Terms of use','','term, use','en',5),(6,'Customer Service','customer-service','<div class=\"static-container\"><div class=\"mb-5\">Customer Service Page Content</div></div>','Customer Service','','customer, service','en',6),(7,'What\'s New','whats-new','<div class=\"static-container\"><div class=\"mb-5\">What\'s New page content</div></div>','What\'s New','','new','en',7),(8,'Payment Policy','payment-policy','<div class=\"static-container\"><div class=\"mb-5\">Payment Policy Page Content</div></div>','Payment Policy','','payment, policy','en',8),(9,'Shipping Policy','shipping-policy','<div class=\"static-container\"><div class=\"mb-5\">Shipping Policy Page Content</div></div>','Shipping Policy','','shipping, policy','en',9),(10,'Privacy Policy','privacy-policy','<div class=\"static-container\"><div class=\"mb-5\">Privacy Policy Page Content</div></div>','Privacy Policy','','privacy, policy','en',10);
/*!40000 ALTER TABLE `cms_page_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_pages`
--

DROP TABLE IF EXISTS `cms_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `layout` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_pages`
--

LOCK TABLES `cms_pages` WRITE;
/*!40000 ALTER TABLE `cms_pages` DISABLE KEYS */;
INSERT INTO `cms_pages` VALUES (1,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(2,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(3,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(4,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(5,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(6,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(7,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(8,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(9,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(10,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09');
/*!40000 ALTER TABLE `cms_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compare_items`
--

DROP TABLE IF EXISTS `compare_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compare_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `compare_items_product_id_foreign` (`product_id`),
  KEY `compare_items_customer_id_foreign` (`customer_id`),
  CONSTRAINT `compare_items_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `compare_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compare_items`
--

LOCK TABLES `compare_items` WRITE;
/*!40000 ALTER TABLE `compare_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `compare_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_config`
--

DROP TABLE IF EXISTS `core_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `channel_code` varchar(255) DEFAULT NULL,
  `locale_code` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_config`
--

LOCK TABLES `core_config` WRITE;
/*!40000 ALTER TABLE `core_config` DISABLE KEYS */;
INSERT INTO `core_config` VALUES (1,'sales.checkout.shopping_cart.allow_guest_checkout','1',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(2,'emails.general.notifications.emails.general.notifications.verification','1',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(3,'emails.general.notifications.emails.general.notifications.registration','1',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(4,'emails.general.notifications.emails.general.notifications.customer_registration_confirmation_mail_to_admin','0',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(5,'emails.general.notifications.emails.general.notifications.customer_account_credentials','1',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(6,'emails.general.notifications.emails.general.notifications.new_order','1',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(7,'emails.general.notifications.emails.general.notifications.new_order_mail_to_admin','1',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(8,'emails.general.notifications.emails.general.notifications.new_invoice','1',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(9,'emails.general.notifications.emails.general.notifications.new_invoice_mail_to_admin','0',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(10,'emails.general.notifications.emails.general.notifications.new_refund','1',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(11,'emails.general.notifications.emails.general.notifications.new_refund_mail_to_admin','0',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(12,'emails.general.notifications.emails.general.notifications.new_shipment','1',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(13,'emails.general.notifications.emails.general.notifications.new_shipment_mail_to_admin','0',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(14,'emails.general.notifications.emails.general.notifications.new_inventory_source','1',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(15,'emails.general.notifications.emails.general.notifications.cancel_order','1',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(16,'emails.general.notifications.emails.general.notifications.cancel_order_mail_to_admin','0',NULL,NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(17,'customer.settings.social_login.enable_facebook','1','default',NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(18,'customer.settings.social_login.enable_twitter','1','default',NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(19,'customer.settings.social_login.enable_google','1','default',NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(20,'customer.settings.social_login.enable_linkedin','1','default',NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(21,'customer.settings.social_login.enable_github','1','default',NULL,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(22,'general.design.categories.category_view','default',NULL,NULL,'2025-11-04 10:24:04','2025-11-04 10:24:04'),(23,'general.design.admin_logo.logo_image','configuration/Vs2EpdCCmuDvdtzz7B8ULLJqGzwwrWTg53ULZ7wA.png',NULL,NULL,'2025-11-04 10:24:05','2025-11-04 10:24:05'),(24,'general.design.admin_logo.favicon','configuration/igMBjlcU7sQF4Xf5lwhvVVF3CGxS9Rux5PJgrhMg.png',NULL,NULL,'2025-11-04 10:24:05','2025-11-04 10:24:05');
/*!40000 ALTER TABLE `core_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'AF','Afghanistan'),(2,'AX','├àland Islands'),(3,'AL','Albania'),(4,'DZ','Algeria'),(5,'AS','American Samoa'),(6,'AD','Andorra'),(7,'AO','Angola'),(8,'AI','Anguilla'),(9,'AQ','Antarctica'),(10,'AG','Antigua & Barbuda'),(11,'AR','Argentina'),(12,'AM','Armenia'),(13,'AW','Aruba'),(14,'AC','Ascension Island'),(15,'AU','Australia'),(16,'AT','Austria'),(17,'AZ','Azerbaijan'),(18,'BS','Bahamas'),(19,'BH','Bahrain'),(20,'BD','Bangladesh'),(21,'BB','Barbados'),(22,'BY','Belarus'),(23,'BE','Belgium'),(24,'BZ','Belize'),(25,'BJ','Benin'),(26,'BM','Bermuda'),(27,'BT','Bhutan'),(28,'BO','Bolivia'),(29,'BA','Bosnia & Herzegovina'),(30,'BW','Botswana'),(31,'BR','Brazil'),(32,'IO','British Indian Ocean Territory'),(33,'VG','British Virgin Islands'),(34,'BN','Brunei'),(35,'BG','Bulgaria'),(36,'BF','Burkina Faso'),(37,'BI','Burundi'),(38,'KH','Cambodia'),(39,'CM','Cameroon'),(40,'CA','Canada'),(41,'IC','Canary Islands'),(42,'CV','Cape Verde'),(43,'BQ','Caribbean Netherlands'),(44,'KY','Cayman Islands'),(45,'CF','Central African Republic'),(46,'EA','Ceuta & Melilla'),(47,'TD','Chad'),(48,'CL','Chile'),(49,'CN','China'),(50,'CX','Christmas Island'),(51,'CC','Cocos (Keeling) Islands'),(52,'CO','Colombia'),(53,'KM','Comoros'),(54,'CG','Congo - Brazzaville'),(55,'CD','Congo - Kinshasa'),(56,'CK','Cook Islands'),(57,'CR','Costa Rica'),(58,'CI','C├┤te dΓÇÖIvoire'),(59,'HR','Croatia'),(60,'CU','Cuba'),(61,'CW','Cura├ºao'),(62,'CY','Cyprus'),(63,'CZ','Czechia'),(64,'DK','Denmark'),(65,'DG','Diego Garcia'),(66,'DJ','Djibouti'),(67,'DM','Dominica'),(68,'DO','Dominican Republic'),(69,'EC','Ecuador'),(70,'EG','Egypt'),(71,'SV','El Salvador'),(72,'GQ','Equatorial Guinea'),(73,'ER','Eritrea'),(74,'EE','Estonia'),(75,'ET','Ethiopia'),(76,'EZ','Eurozone'),(77,'FK','Falkland Islands'),(78,'FO','Faroe Islands'),(79,'FJ','Fiji'),(80,'FI','Finland'),(81,'FR','France'),(82,'GF','French Guiana'),(83,'PF','French Polynesia'),(84,'TF','French Southern Territories'),(85,'GA','Gabon'),(86,'GM','Gambia'),(87,'GE','Georgia'),(88,'DE','Germany'),(89,'GH','Ghana'),(90,'GI','Gibraltar'),(91,'GR','Greece'),(92,'GL','Greenland'),(93,'GD','Grenada'),(94,'GP','Guadeloupe'),(95,'GU','Guam'),(96,'GT','Guatemala'),(97,'GG','Guernsey'),(98,'GN','Guinea'),(99,'GW','Guinea-Bissau'),(100,'GY','Guyana'),(101,'HT','Haiti'),(102,'HN','Honduras'),(103,'HK','Hong Kong SAR China'),(104,'HU','Hungary'),(105,'IS','Iceland'),(106,'IN','India'),(107,'ID','Indonesia'),(108,'IR','Iran'),(109,'IQ','Iraq'),(110,'IE','Ireland'),(111,'IM','Isle of Man'),(112,'IL','Israel'),(113,'IT','Italy'),(114,'JM','Jamaica'),(115,'JP','Japan'),(116,'JE','Jersey'),(117,'JO','Jordan'),(118,'KZ','Kazakhstan'),(119,'KE','Kenya'),(120,'KI','Kiribati'),(121,'XK','Kosovo'),(122,'KW','Kuwait'),(123,'KG','Kyrgyzstan'),(124,'LA','Laos'),(125,'LV','Latvia'),(126,'LB','Lebanon'),(127,'LS','Lesotho'),(128,'LR','Liberia'),(129,'LY','Libya'),(130,'LI','Liechtenstein'),(131,'LT','Lithuania'),(132,'LU','Luxembourg'),(133,'MO','Macau SAR China'),(134,'MK','Macedonia'),(135,'MG','Madagascar'),(136,'MW','Malawi'),(137,'MY','Malaysia'),(138,'MV','Maldives'),(139,'ML','Mali'),(140,'MT','Malta'),(141,'MH','Marshall Islands'),(142,'MQ','Martinique'),(143,'MR','Mauritania'),(144,'MU','Mauritius'),(145,'YT','Mayotte'),(146,'MX','Mexico'),(147,'FM','Micronesia'),(148,'MD','Moldova'),(149,'MC','Monaco'),(150,'MN','Mongolia'),(151,'ME','Montenegro'),(152,'MS','Montserrat'),(153,'MA','Morocco'),(154,'MZ','Mozambique'),(155,'MM','Myanmar (Burma)'),(156,'NA','Namibia'),(157,'NR','Nauru'),(158,'NP','Nepal'),(159,'NL','Netherlands'),(160,'NC','New Caledonia'),(161,'NZ','New Zealand'),(162,'NI','Nicaragua'),(163,'NE','Niger'),(164,'NG','Nigeria'),(165,'NU','Niue'),(166,'NF','Norfolk Island'),(167,'KP','North Korea'),(168,'MP','Northern Mariana Islands'),(169,'NO','Norway'),(170,'OM','Oman'),(171,'PK','Pakistan'),(172,'PW','Palau'),(173,'PS','Palestinian Territories'),(174,'PA','Panama'),(175,'PG','Papua New Guinea'),(176,'PY','Paraguay'),(177,'PE','Peru'),(178,'PH','Philippines'),(179,'PN','Pitcairn Islands'),(180,'PL','Poland'),(181,'PT','Portugal'),(182,'PR','Puerto Rico'),(183,'QA','Qatar'),(184,'RE','R├⌐union'),(185,'RO','Romania'),(186,'RU','Russia'),(187,'RW','Rwanda'),(188,'WS','Samoa'),(189,'SM','San Marino'),(190,'ST','S├úo Tom├⌐ & Pr├¡ncipe'),(191,'SA','Saudi Arabia'),(192,'SN','Senegal'),(193,'RS','Serbia'),(194,'SC','Seychelles'),(195,'SL','Sierra Leone'),(196,'SG','Singapore'),(197,'SX','Sint Maarten'),(198,'SK','Slovakia'),(199,'SI','Slovenia'),(200,'SB','Solomon Islands'),(201,'SO','Somalia'),(202,'ZA','South Africa'),(203,'GS','South Georgia & South Sandwich Islands'),(204,'KR','South Korea'),(205,'SS','South Sudan'),(206,'ES','Spain'),(207,'LK','Sri Lanka'),(208,'BL','St. Barth├⌐lemy'),(209,'SH','St. Helena'),(210,'KN','St. Kitts & Nevis'),(211,'LC','St. Lucia'),(212,'MF','St. Martin'),(213,'PM','St. Pierre & Miquelon'),(214,'VC','St. Vincent & Grenadines'),(215,'SD','Sudan'),(216,'SR','Suriname'),(217,'SJ','Svalbard & Jan Mayen'),(218,'SZ','Swaziland'),(219,'SE','Sweden'),(220,'CH','Switzerland'),(221,'SY','Syria'),(222,'TW','Taiwan'),(223,'TJ','Tajikistan'),(224,'TZ','Tanzania'),(225,'TH','Thailand'),(226,'TL','Timor-Leste'),(227,'TG','Togo'),(228,'TK','Tokelau'),(229,'TO','Tonga'),(230,'TT','Trinidad & Tobago'),(231,'TA','Tristan da Cunha'),(232,'TN','Tunisia'),(233,'TR','Turkey'),(234,'TM','Turkmenistan'),(235,'TC','Turks & Caicos Islands'),(236,'TV','Tuvalu'),(237,'UM','U.S. Outlying Islands'),(238,'VI','U.S. Virgin Islands'),(239,'UG','Uganda'),(240,'UA','Ukraine'),(241,'AE','United Arab Emirates'),(242,'GB','United Kingdom'),(244,'US','United States'),(245,'UY','Uruguay'),(246,'UZ','Uzbekistan'),(247,'VU','Vanuatu'),(248,'VA','Vatican City'),(249,'VE','Venezuela'),(250,'VN','Vietnam'),(251,'WF','Wallis & Futuna'),(252,'EH','Western Sahara'),(253,'YE','Yemen'),(254,'ZM','Zambia'),(255,'ZW','Zimbabwe');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country_state_translations`
--

DROP TABLE IF EXISTS `country_state_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country_state_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country_state_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `default_name` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_state_translations_country_state_id_foreign` (`country_state_id`),
  CONSTRAINT `country_state_translations_country_state_id_foreign` FOREIGN KEY (`country_state_id`) REFERENCES `country_states` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_state_translations`
--

LOCK TABLES `country_state_translations` WRITE;
/*!40000 ALTER TABLE `country_state_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `country_state_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country_states`
--

DROP TABLE IF EXISTS `country_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country_states` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int(10) unsigned DEFAULT NULL,
  `country_code` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `default_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_states_country_id_foreign` (`country_id`),
  CONSTRAINT `country_states_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=587 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_states`
--

LOCK TABLES `country_states` WRITE;
/*!40000 ALTER TABLE `country_states` DISABLE KEYS */;
INSERT INTO `country_states` VALUES (1,244,'US','AL','Alabama'),(2,244,'US','AK','Alaska'),(3,244,'US','AS','American Samoa'),(4,244,'US','AZ','Arizona'),(5,244,'US','AR','Arkansas'),(6,244,'US','AE','Armed Forces Africa'),(7,244,'US','AA','Armed Forces Americas'),(8,244,'US','AE','Armed Forces Canada'),(9,244,'US','AE','Armed Forces Europe'),(10,244,'US','AE','Armed Forces Middle East'),(11,244,'US','AP','Armed Forces Pacific'),(12,244,'US','CA','California'),(13,244,'US','CO','Colorado'),(14,244,'US','CT','Connecticut'),(15,244,'US','DE','Delaware'),(16,244,'US','DC','District of Columbia'),(17,244,'US','FM','Federated States Of Micronesia'),(18,244,'US','FL','Florida'),(19,244,'US','GA','Georgia'),(20,244,'US','GU','Guam'),(21,244,'US','HI','Hawaii'),(22,244,'US','ID','Idaho'),(23,244,'US','IL','Illinois'),(24,244,'US','IN','Indiana'),(25,244,'US','IA','Iowa'),(26,244,'US','KS','Kansas'),(27,244,'US','KY','Kentucky'),(28,244,'US','LA','Louisiana'),(29,244,'US','ME','Maine'),(30,244,'US','MH','Marshall Islands'),(31,244,'US','MD','Maryland'),(32,244,'US','MA','Massachusetts'),(33,244,'US','MI','Michigan'),(34,244,'US','MN','Minnesota'),(35,244,'US','MS','Mississippi'),(36,244,'US','MO','Missouri'),(37,244,'US','MT','Montana'),(38,244,'US','NE','Nebraska'),(39,244,'US','NV','Nevada'),(40,244,'US','NH','New Hampshire'),(41,244,'US','NJ','New Jersey'),(42,244,'US','NM','New Mexico'),(43,244,'US','NY','New York'),(44,244,'US','NC','North Carolina'),(45,244,'US','ND','North Dakota'),(46,244,'US','MP','Northern Mariana Islands'),(47,244,'US','OH','Ohio'),(48,244,'US','OK','Oklahoma'),(49,244,'US','OR','Oregon'),(50,244,'US','PW','Palau'),(51,244,'US','PA','Pennsylvania'),(52,244,'US','PR','Puerto Rico'),(53,244,'US','RI','Rhode Island'),(54,244,'US','SC','South Carolina'),(55,244,'US','SD','South Dakota'),(56,244,'US','TN','Tennessee'),(57,244,'US','TX','Texas'),(58,244,'US','UT','Utah'),(59,244,'US','VT','Vermont'),(60,244,'US','VI','Virgin Islands'),(61,244,'US','VA','Virginia'),(62,244,'US','WA','Washington'),(63,244,'US','WV','West Virginia'),(64,244,'US','WI','Wisconsin'),(65,244,'US','WY','Wyoming'),(66,40,'CA','AB','Alberta'),(67,40,'CA','BC','British Columbia'),(68,40,'CA','MB','Manitoba'),(69,40,'CA','NL','Newfoundland and Labrador'),(70,40,'CA','NB','New Brunswick'),(71,40,'CA','NS','Nova Scotia'),(72,40,'CA','NT','Northwest Territories'),(73,40,'CA','NU','Nunavut'),(74,40,'CA','ON','Ontario'),(75,40,'CA','PE','Prince Edward Island'),(76,40,'CA','QC','Quebec'),(77,40,'CA','SK','Saskatchewan'),(78,40,'CA','YT','Yukon Territory'),(79,88,'DE','NDS','Niedersachsen'),(80,88,'DE','BAW','Baden-W├╝rttemberg'),(81,88,'DE','BAY','Bayern'),(82,88,'DE','BER','Berlin'),(83,88,'DE','BRG','Brandenburg'),(84,88,'DE','BRE','Bremen'),(85,88,'DE','HAM','Hamburg'),(86,88,'DE','HES','Hessen'),(87,88,'DE','MEC','Mecklenburg-Vorpommern'),(88,88,'DE','NRW','Nordrhein-Westfalen'),(89,88,'DE','RHE','Rheinland-Pfalz'),(90,88,'DE','SAR','Saarland'),(91,88,'DE','SAS','Sachsen'),(92,88,'DE','SAC','Sachsen-Anhalt'),(93,88,'DE','SCN','Schleswig-Holstein'),(94,88,'DE','THE','Th├╝ringen'),(95,16,'AT','WI','Wien'),(96,16,'AT','NO','Nieder├╢sterreich'),(97,16,'AT','OO','Ober├╢sterreich'),(98,16,'AT','SB','Salzburg'),(99,16,'AT','KN','K├ñrnten'),(100,16,'AT','ST','Steiermark'),(101,16,'AT','TI','Tirol'),(102,16,'AT','BL','Burgenland'),(103,16,'AT','VB','Vorarlberg'),(104,220,'CH','AG','Aargau'),(105,220,'CH','AI','Appenzell Innerrhoden'),(106,220,'CH','AR','Appenzell Ausserrhoden'),(107,220,'CH','BE','Bern'),(108,220,'CH','BL','Basel-Landschaft'),(109,220,'CH','BS','Basel-Stadt'),(110,220,'CH','FR','Freiburg'),(111,220,'CH','GE','Genf'),(112,220,'CH','GL','Glarus'),(113,220,'CH','GR','Graub├╝nden'),(114,220,'CH','JU','Jura'),(115,220,'CH','LU','Luzern'),(116,220,'CH','NE','Neuenburg'),(117,220,'CH','NW','Nidwalden'),(118,220,'CH','OW','Obwalden'),(119,220,'CH','SG','St. Gallen'),(120,220,'CH','SH','Schaffhausen'),(121,220,'CH','SO','Solothurn'),(122,220,'CH','SZ','Schwyz'),(123,220,'CH','TG','Thurgau'),(124,220,'CH','TI','Tessin'),(125,220,'CH','UR','Uri'),(126,220,'CH','VD','Waadt'),(127,220,'CH','VS','Wallis'),(128,220,'CH','ZG','Zug'),(129,220,'CH','ZH','Z├╝rich'),(130,206,'ES','A Coru╤üa','A Coru├▒a'),(131,206,'ES','Alava','Alava'),(132,206,'ES','Albacete','Albacete'),(133,206,'ES','Alicante','Alicante'),(134,206,'ES','Almeria','Almeria'),(135,206,'ES','Asturias','Asturias'),(136,206,'ES','Avila','Avila'),(137,206,'ES','Badajoz','Badajoz'),(138,206,'ES','Baleares','Baleares'),(139,206,'ES','Barcelona','Barcelona'),(140,206,'ES','Burgos','Burgos'),(141,206,'ES','Caceres','Caceres'),(142,206,'ES','Cadiz','Cadiz'),(143,206,'ES','Cantabria','Cantabria'),(144,206,'ES','Castellon','Castellon'),(145,206,'ES','Ceuta','Ceuta'),(146,206,'ES','Ciudad Real','Ciudad Real'),(147,206,'ES','Cordoba','Cordoba'),(148,206,'ES','Cuenca','Cuenca'),(149,206,'ES','Girona','Girona'),(150,206,'ES','Granada','Granada'),(151,206,'ES','Guadalajara','Guadalajara'),(152,206,'ES','Guipuzcoa','Guipuzcoa'),(153,206,'ES','Huelva','Huelva'),(154,206,'ES','Huesca','Huesca'),(155,206,'ES','Jaen','Jaen'),(156,206,'ES','La Rioja','La Rioja'),(157,206,'ES','Las Palmas','Las Palmas'),(158,206,'ES','Leon','Leon'),(159,206,'ES','Lleida','Lleida'),(160,206,'ES','Lugo','Lugo'),(161,206,'ES','Madrid','Madrid'),(162,206,'ES','Malaga','Malaga'),(163,206,'ES','Melilla','Melilla'),(164,206,'ES','Murcia','Murcia'),(165,206,'ES','Navarra','Navarra'),(166,206,'ES','Ourense','Ourense'),(167,206,'ES','Palencia','Palencia'),(168,206,'ES','Pontevedra','Pontevedra'),(169,206,'ES','Salamanca','Salamanca'),(170,206,'ES','Santa Cruz de Tenerife','Santa Cruz de Tenerife'),(171,206,'ES','Segovia','Segovia'),(172,206,'ES','Sevilla','Sevilla'),(173,206,'ES','Soria','Soria'),(174,206,'ES','Tarragona','Tarragona'),(175,206,'ES','Teruel','Teruel'),(176,206,'ES','Toledo','Toledo'),(177,206,'ES','Valencia','Valencia'),(178,206,'ES','Valladolid','Valladolid'),(179,206,'ES','Vizcaya','Vizcaya'),(180,206,'ES','Zamora','Zamora'),(181,206,'ES','Zaragoza','Zaragoza'),(182,81,'FR','1','Ain'),(183,81,'FR','2','Aisne'),(184,81,'FR','3','Allier'),(185,81,'FR','4','Alpes-de-Haute-Provence'),(186,81,'FR','5','Hautes-Alpes'),(187,81,'FR','6','Alpes-Maritimes'),(188,81,'FR','7','Ard├¿che'),(189,81,'FR','8','Ardennes'),(190,81,'FR','9','Ari├¿ge'),(191,81,'FR','10','Aube'),(192,81,'FR','11','Aude'),(193,81,'FR','12','Aveyron'),(194,81,'FR','13','Bouches-du-Rh├┤ne'),(195,81,'FR','14','Calvados'),(196,81,'FR','15','Cantal'),(197,81,'FR','16','Charente'),(198,81,'FR','17','Charente-Maritime'),(199,81,'FR','18','Cher'),(200,81,'FR','19','Corr├¿ze'),(201,81,'FR','2A','Corse-du-Sud'),(202,81,'FR','2B','Haute-Corse'),(203,81,'FR','21','C├┤te-d\'Or'),(204,81,'FR','22','C├┤tes-d\'Armor'),(205,81,'FR','23','Creuse'),(206,81,'FR','24','Dordogne'),(207,81,'FR','25','Doubs'),(208,81,'FR','26','Dr├┤me'),(209,81,'FR','27','Eure'),(210,81,'FR','28','Eure-et-Loir'),(211,81,'FR','29','Finist├¿re'),(212,81,'FR','30','Gard'),(213,81,'FR','31','Haute-Garonne'),(214,81,'FR','32','Gers'),(215,81,'FR','33','Gironde'),(216,81,'FR','34','H├⌐rault'),(217,81,'FR','35','Ille-et-Vilaine'),(218,81,'FR','36','Indre'),(219,81,'FR','37','Indre-et-Loire'),(220,81,'FR','38','Is├¿re'),(221,81,'FR','39','Jura'),(222,81,'FR','40','Landes'),(223,81,'FR','41','Loir-et-Cher'),(224,81,'FR','42','Loire'),(225,81,'FR','43','Haute-Loire'),(226,81,'FR','44','Loire-Atlantique'),(227,81,'FR','45','Loiret'),(228,81,'FR','46','Lot'),(229,81,'FR','47','Lot-et-Garonne'),(230,81,'FR','48','Loz├¿re'),(231,81,'FR','49','Maine-et-Loire'),(232,81,'FR','50','Manche'),(233,81,'FR','51','Marne'),(234,81,'FR','52','Haute-Marne'),(235,81,'FR','53','Mayenne'),(236,81,'FR','54','Meurthe-et-Moselle'),(237,81,'FR','55','Meuse'),(238,81,'FR','56','Morbihan'),(239,81,'FR','57','Moselle'),(240,81,'FR','58','Ni├¿vre'),(241,81,'FR','59','Nord'),(242,81,'FR','60','Oise'),(243,81,'FR','61','Orne'),(244,81,'FR','62','Pas-de-Calais'),(245,81,'FR','63','Puy-de-D├┤me'),(246,81,'FR','64','Pyr├⌐n├⌐es-Atlantiques'),(247,81,'FR','65','Hautes-Pyr├⌐n├⌐es'),(248,81,'FR','66','Pyr├⌐n├⌐es-Orientales'),(249,81,'FR','67','Bas-Rhin'),(250,81,'FR','68','Haut-Rhin'),(251,81,'FR','69','Rh├┤ne'),(252,81,'FR','70','Haute-Sa├┤ne'),(253,81,'FR','71','Sa├┤ne-et-Loire'),(254,81,'FR','72','Sarthe'),(255,81,'FR','73','Savoie'),(256,81,'FR','74','Haute-Savoie'),(257,81,'FR','75','Paris'),(258,81,'FR','76','Seine-Maritime'),(259,81,'FR','77','Seine-et-Marne'),(260,81,'FR','78','Yvelines'),(261,81,'FR','79','Deux-S├¿vres'),(262,81,'FR','80','Somme'),(263,81,'FR','81','Tarn'),(264,81,'FR','82','Tarn-et-Garonne'),(265,81,'FR','83','Var'),(266,81,'FR','84','Vaucluse'),(267,81,'FR','85','Vend├⌐e'),(268,81,'FR','86','Vienne'),(269,81,'FR','87','Haute-Vienne'),(270,81,'FR','88','Vosges'),(271,81,'FR','89','Yonne'),(272,81,'FR','90','Territoire-de-Belfort'),(273,81,'FR','91','Essonne'),(274,81,'FR','92','Hauts-de-Seine'),(275,81,'FR','93','Seine-Saint-Denis'),(276,81,'FR','94','Val-de-Marne'),(277,81,'FR','95','Val-d\'Oise'),(278,185,'RO','AB','Alba'),(279,185,'RO','AR','Arad'),(280,185,'RO','AG','Arge┼ƒ'),(281,185,'RO','BC','Bac─âu'),(282,185,'RO','BH','Bihor'),(283,185,'RO','BN','Bistri┼úa-N─âs─âud'),(284,185,'RO','BT','Boto┼ƒani'),(285,185,'RO','BV','Bra┼ƒov'),(286,185,'RO','BR','Br─âila'),(287,185,'RO','B','Bucure┼ƒti'),(288,185,'RO','BZ','Buz─âu'),(289,185,'RO','CS','Cara┼ƒ-Severin'),(290,185,'RO','CL','C─âl─âra┼ƒi'),(291,185,'RO','CJ','Cluj'),(292,185,'RO','CT','Constan┼úa'),(293,185,'RO','CV','Covasna'),(294,185,'RO','DB','D├ómbovi┼úa'),(295,185,'RO','DJ','Dolj'),(296,185,'RO','GL','Gala┼úi'),(297,185,'RO','GR','Giurgiu'),(298,185,'RO','GJ','Gorj'),(299,185,'RO','HR','Harghita'),(300,185,'RO','HD','Hunedoara'),(301,185,'RO','IL','Ialomi┼úa'),(302,185,'RO','IS','Ia┼ƒi'),(303,185,'RO','IF','Ilfov'),(304,185,'RO','MM','Maramure┼ƒ'),(305,185,'RO','MH','Mehedin┼úi'),(306,185,'RO','MS','Mure┼ƒ'),(307,185,'RO','NT','Neam┼ú'),(308,185,'RO','OT','Olt'),(309,185,'RO','PH','Prahova'),(310,185,'RO','SM','Satu-Mare'),(311,185,'RO','SJ','S─âlaj'),(312,185,'RO','SB','Sibiu'),(313,185,'RO','SV','Suceava'),(314,185,'RO','TR','Teleorman'),(315,185,'RO','TM','Timi┼ƒ'),(316,185,'RO','TL','Tulcea'),(317,185,'RO','VS','Vaslui'),(318,185,'RO','VL','V├ólcea'),(319,185,'RO','VN','Vrancea'),(320,80,'FI','Lappi','Lappi'),(321,80,'FI','Pohjois-Pohjanmaa','Pohjois-Pohjanmaa'),(322,80,'FI','Kainuu','Kainuu'),(323,80,'FI','Pohjois-Karjala','Pohjois-Karjala'),(324,80,'FI','Pohjois-Savo','Pohjois-Savo'),(325,80,'FI','Etel├ñ-Savo','Etel├ñ-Savo'),(326,80,'FI','Etel├ñ-Pohjanmaa','Etel├ñ-Pohjanmaa'),(327,80,'FI','Pohjanmaa','Pohjanmaa'),(328,80,'FI','Pirkanmaa','Pirkanmaa'),(329,80,'FI','Satakunta','Satakunta'),(330,80,'FI','Keski-Pohjanmaa','Keski-Pohjanmaa'),(331,80,'FI','Keski-Suomi','Keski-Suomi'),(332,80,'FI','Varsinais-Suomi','Varsinais-Suomi'),(333,80,'FI','Etel├ñ-Karjala','Etel├ñ-Karjala'),(334,80,'FI','P├ñij├ñt-H├ñme','P├ñij├ñt-H├ñme'),(335,80,'FI','Kanta-H├ñme','Kanta-H├ñme'),(336,80,'FI','Uusimaa','Uusimaa'),(337,80,'FI','It├ñ-Uusimaa','It├ñ-Uusimaa'),(338,80,'FI','Kymenlaakso','Kymenlaakso'),(339,80,'FI','Ahvenanmaa','Ahvenanmaa'),(340,74,'EE','EE-37','Harjumaa'),(341,74,'EE','EE-39','Hiiumaa'),(342,74,'EE','EE-44','Ida-Virumaa'),(343,74,'EE','EE-49','J├╡gevamaa'),(344,74,'EE','EE-51','J├ñrvamaa'),(345,74,'EE','EE-57','L├ñ├ñnemaa'),(346,74,'EE','EE-59','L├ñ├ñne-Virumaa'),(347,74,'EE','EE-65','P├╡lvamaa'),(348,74,'EE','EE-67','P├ñrnumaa'),(349,74,'EE','EE-70','Raplamaa'),(350,74,'EE','EE-74','Saaremaa'),(351,74,'EE','EE-78','Tartumaa'),(352,74,'EE','EE-82','Valgamaa'),(353,74,'EE','EE-84','Viljandimaa'),(354,74,'EE','EE-86','V├╡rumaa'),(355,125,'LV','LV-DGV','Daugavpils'),(356,125,'LV','LV-JEL','Jelgava'),(357,125,'LV','J─ôkabpils','J─ôkabpils'),(358,125,'LV','LV-JUR','J┼½rmala'),(359,125,'LV','LV-LPX','Liep─üja'),(360,125,'LV','LV-LE','Liep─üjas novads'),(361,125,'LV','LV-REZ','R─ôzekne'),(362,125,'LV','LV-RIX','R─½ga'),(363,125,'LV','LV-RI','R─½gas novads'),(364,125,'LV','Valmiera','Valmiera'),(365,125,'LV','LV-VEN','Ventspils'),(366,125,'LV','Aglonas novads','Aglonas novads'),(367,125,'LV','LV-AI','Aizkraukles novads'),(368,125,'LV','Aizputes novads','Aizputes novads'),(369,125,'LV','Akn─½stes novads','Akn─½stes novads'),(370,125,'LV','Alojas novads','Alojas novads'),(371,125,'LV','Alsungas novads','Alsungas novads'),(372,125,'LV','LV-AL','Al┼½ksnes novads'),(373,125,'LV','Amatas novads','Amatas novads'),(374,125,'LV','Apes novads','Apes novads'),(375,125,'LV','Auces novads','Auces novads'),(376,125,'LV','Bab─½tes novads','Bab─½tes novads'),(377,125,'LV','Baldones novads','Baldones novads'),(378,125,'LV','Baltinavas novads','Baltinavas novads'),(379,125,'LV','LV-BL','Balvu novads'),(380,125,'LV','LV-BU','Bauskas novads'),(381,125,'LV','Bever─½nas novads','Bever─½nas novads'),(382,125,'LV','Broc─ônu novads','Broc─ônu novads'),(383,125,'LV','Burtnieku novads','Burtnieku novads'),(384,125,'LV','Carnikavas novads','Carnikavas novads'),(385,125,'LV','Cesvaines novads','Cesvaines novads'),(386,125,'LV','Ciblas novads','Ciblas novads'),(387,125,'LV','LV-CE','C─ôsu novads'),(388,125,'LV','Dagdas novads','Dagdas novads'),(389,125,'LV','LV-DA','Daugavpils novads'),(390,125,'LV','LV-DO','Dobeles novads'),(391,125,'LV','Dundagas novads','Dundagas novads'),(392,125,'LV','Durbes novads','Durbes novads'),(393,125,'LV','Engures novads','Engures novads'),(394,125,'LV','Garkalnes novads','Garkalnes novads'),(395,125,'LV','Grobi┼åas novads','Grobi┼åas novads'),(396,125,'LV','LV-GU','Gulbenes novads'),(397,125,'LV','Iecavas novads','Iecavas novads'),(398,125,'LV','Ik┼í─╖iles novads','Ik┼í─╖iles novads'),(399,125,'LV','Il┼½kstes novads','Il┼½kstes novads'),(400,125,'LV','In─ìukalna novads','In─ìukalna novads'),(401,125,'LV','Jaunjelgavas novads','Jaunjelgavas novads'),(402,125,'LV','Jaunpiebalgas novads','Jaunpiebalgas novads'),(403,125,'LV','Jaunpils novads','Jaunpils novads'),(404,125,'LV','LV-JL','Jelgavas novads'),(405,125,'LV','LV-JK','J─ôkabpils novads'),(406,125,'LV','Kandavas novads','Kandavas novads'),(407,125,'LV','Kokneses novads','Kokneses novads'),(408,125,'LV','Krimuldas novads','Krimuldas novads'),(409,125,'LV','Krustpils novads','Krustpils novads'),(410,125,'LV','LV-KR','Kr─üslavas novads'),(411,125,'LV','LV-KU','Kuld─½gas novads'),(412,125,'LV','K─ürsavas novads','K─ürsavas novads'),(413,125,'LV','Lielv─ürdes novads','Lielv─ürdes novads'),(414,125,'LV','LV-LM','Limba┼╛u novads'),(415,125,'LV','Lub─ünas novads','Lub─ünas novads'),(416,125,'LV','LV-LU','Ludzas novads'),(417,125,'LV','L─½gatnes novads','L─½gatnes novads'),(418,125,'LV','L─½v─ünu novads','L─½v─ünu novads'),(419,125,'LV','LV-MA','Madonas novads'),(420,125,'LV','Mazsalacas novads','Mazsalacas novads'),(421,125,'LV','M─ülpils novads','M─ülpils novads'),(422,125,'LV','M─ürupes novads','M─ürupes novads'),(423,125,'LV','Nauk┼í─ônu novads','Nauk┼í─ônu novads'),(424,125,'LV','Neretas novads','Neretas novads'),(425,125,'LV','N─½cas novads','N─½cas novads'),(426,125,'LV','LV-OG','Ogres novads'),(427,125,'LV','Olaines novads','Olaines novads'),(428,125,'LV','Ozolnieku novads','Ozolnieku novads'),(429,125,'LV','LV-PR','Prei─╝u novads'),(430,125,'LV','Priekules novads','Priekules novads'),(431,125,'LV','Prieku─╝u novads','Prieku─╝u novads'),(432,125,'LV','P─ürgaujas novads','P─ürgaujas novads'),(433,125,'LV','P─üvilostas novads','P─üvilostas novads'),(434,125,'LV','P─╝avi┼åu novads','P─╝avi┼åu novads'),(435,125,'LV','Raunas novads','Raunas novads'),(436,125,'LV','Riebi┼åu novads','Riebi┼åu novads'),(437,125,'LV','Rojas novads','Rojas novads'),(438,125,'LV','Ropa┼╛u novads','Ropa┼╛u novads'),(439,125,'LV','Rucavas novads','Rucavas novads'),(440,125,'LV','Rug─üju novads','Rug─üju novads'),(441,125,'LV','Rund─üles novads','Rund─üles novads'),(442,125,'LV','LV-RE','R─ôzeknes novads'),(443,125,'LV','R┼½jienas novads','R┼½jienas novads'),(444,125,'LV','Salacgr─½vas novads','Salacgr─½vas novads'),(445,125,'LV','Salas novads','Salas novads'),(446,125,'LV','Salaspils novads','Salaspils novads'),(447,125,'LV','LV-SA','Saldus novads'),(448,125,'LV','Saulkrastu novads','Saulkrastu novads'),(449,125,'LV','Siguldas novads','Siguldas novads'),(450,125,'LV','Skrundas novads','Skrundas novads'),(451,125,'LV','Skr─½veru novads','Skr─½veru novads'),(452,125,'LV','Smiltenes novads','Smiltenes novads'),(453,125,'LV','Stopi┼åu novads','Stopi┼åu novads'),(454,125,'LV','Stren─ìu novads','Stren─ìu novads'),(455,125,'LV','S─ôjas novads','S─ôjas novads'),(456,125,'LV','LV-TA','Talsu novads'),(457,125,'LV','LV-TU','Tukuma novads'),(458,125,'LV','T─ôrvetes novads','T─ôrvetes novads'),(459,125,'LV','Vai┼åodes novads','Vai┼åodes novads'),(460,125,'LV','LV-VK','Valkas novads'),(461,125,'LV','LV-VM','Valmieras novads'),(462,125,'LV','Varak─╝─ünu novads','Varak─╝─ünu novads'),(463,125,'LV','Vecpiebalgas novads','Vecpiebalgas novads'),(464,125,'LV','Vecumnieku novads','Vecumnieku novads'),(465,125,'LV','LV-VE','Ventspils novads'),(466,125,'LV','Vies─½tes novads','Vies─½tes novads'),(467,125,'LV','Vi─╝akas novads','Vi─╝akas novads'),(468,125,'LV','Vi─╝─ünu novads','Vi─╝─ünu novads'),(469,125,'LV','V─ürkavas novads','V─ürkavas novads'),(470,125,'LV','Zilupes novads','Zilupes novads'),(471,125,'LV','─Çda┼╛u novads','─Çda┼╛u novads'),(472,125,'LV','─Ærg─╝u novads','─Ærg─╝u novads'),(473,125,'LV','─╢eguma novads','─╢eguma novads'),(474,125,'LV','─╢ekavas novads','─╢ekavas novads'),(475,131,'LT','LT-AL','Alytaus Apskritis'),(476,131,'LT','LT-KU','Kauno Apskritis'),(477,131,'LT','LT-KL','Klaip─ùdos Apskritis'),(478,131,'LT','LT-MR','Marijampol─ùs Apskritis'),(479,131,'LT','LT-PN','Panev─ù┼╛io Apskritis'),(480,131,'LT','LT-SA','┼áiauli┼│ Apskritis'),(481,131,'LT','LT-TA','Taurag─ùs Apskritis'),(482,131,'LT','LT-TE','Tel┼íi┼│ Apskritis'),(483,131,'LT','LT-UT','Utenos Apskritis'),(484,131,'LT','LT-VL','Vilniaus Apskritis'),(485,31,'BR','AC','Acre'),(486,31,'BR','AL','Alagoas'),(487,31,'BR','AP','Amap├í'),(488,31,'BR','AM','Amazonas'),(489,31,'BR','BA','Bahia'),(490,31,'BR','CE','Cear├í'),(491,31,'BR','ES','Esp├¡rito Santo'),(492,31,'BR','GO','Goi├ís'),(493,31,'BR','MA','Maranh├úo'),(494,31,'BR','MT','Mato Grosso'),(495,31,'BR','MS','Mato Grosso do Sul'),(496,31,'BR','MG','Minas Gerais'),(497,31,'BR','PA','Par├í'),(498,31,'BR','PB','Para├¡ba'),(499,31,'BR','PR','Paran├í'),(500,31,'BR','PE','Pernambuco'),(501,31,'BR','PI','Piau├¡'),(502,31,'BR','RJ','Rio de Janeiro'),(503,31,'BR','RN','Rio Grande do Norte'),(504,31,'BR','RS','Rio Grande do Sul'),(505,31,'BR','RO','Rond├┤nia'),(506,31,'BR','RR','Roraima'),(507,31,'BR','SC','Santa Catarina'),(508,31,'BR','SP','S├úo Paulo'),(509,31,'BR','SE','Sergipe'),(510,31,'BR','TO','Tocantins'),(511,31,'BR','DF','Distrito Federal'),(512,59,'HR','HR-01','Zagreba─ìka ┼╛upanija'),(513,59,'HR','HR-02','Krapinsko-zagorska ┼╛upanija'),(514,59,'HR','HR-03','Sisa─ìko-moslava─ìka ┼╛upanija'),(515,59,'HR','HR-04','Karlova─ìka ┼╛upanija'),(516,59,'HR','HR-05','Vara┼╛dinska ┼╛upanija'),(517,59,'HR','HR-06','Koprivni─ìko-kri┼╛eva─ìka ┼╛upanija'),(518,59,'HR','HR-07','Bjelovarsko-bilogorska ┼╛upanija'),(519,59,'HR','HR-08','Primorsko-goranska ┼╛upanija'),(520,59,'HR','HR-09','Li─ìko-senjska ┼╛upanija'),(521,59,'HR','HR-10','Viroviti─ìko-podravska ┼╛upanija'),(522,59,'HR','HR-11','Po┼╛e┼íko-slavonska ┼╛upanija'),(523,59,'HR','HR-12','Brodsko-posavska ┼╛upanija'),(524,59,'HR','HR-13','Zadarska ┼╛upanija'),(525,59,'HR','HR-14','Osje─ìko-baranjska ┼╛upanija'),(526,59,'HR','HR-15','┼áibensko-kninska ┼╛upanija'),(527,59,'HR','HR-16','Vukovarsko-srijemska ┼╛upanija'),(528,59,'HR','HR-17','Splitsko-dalmatinska ┼╛upanija'),(529,59,'HR','HR-18','Istarska ┼╛upanija'),(530,59,'HR','HR-19','Dubrova─ìko-neretvanska ┼╛upanija'),(531,59,'HR','HR-20','Me─æimurska ┼╛upanija'),(532,59,'HR','HR-21','Grad Zagreb'),(533,106,'IN','AN','Andaman and Nicobar Islands'),(534,106,'IN','AP','Andhra Pradesh'),(535,106,'IN','AR','Arunachal Pradesh'),(536,106,'IN','AS','Assam'),(537,106,'IN','BR','Bihar'),(538,106,'IN','CH','Chandigarh'),(539,106,'IN','CT','Chhattisgarh'),(540,106,'IN','DN','Dadra and Nagar Haveli'),(541,106,'IN','DD','Daman and Diu'),(542,106,'IN','DL','Delhi'),(543,106,'IN','GA','Goa'),(544,106,'IN','GJ','Gujarat'),(545,106,'IN','HR','Haryana'),(546,106,'IN','HP','Himachal Pradesh'),(547,106,'IN','JK','Jammu and Kashmir'),(548,106,'IN','JH','Jharkhand'),(549,106,'IN','KA','Karnataka'),(550,106,'IN','KL','Kerala'),(551,106,'IN','LD','Lakshadweep'),(552,106,'IN','MP','Madhya Pradesh'),(553,106,'IN','MH','Maharashtra'),(554,106,'IN','MN','Manipur'),(555,106,'IN','ML','Meghalaya'),(556,106,'IN','MZ','Mizoram'),(557,106,'IN','NL','Nagaland'),(558,106,'IN','OR','Odisha'),(559,106,'IN','PY','Puducherry'),(560,106,'IN','PB','Punjab'),(561,106,'IN','RJ','Rajasthan'),(562,106,'IN','SK','Sikkim'),(563,106,'IN','TN','Tamil Nadu'),(564,106,'IN','TG','Telangana'),(565,106,'IN','TR','Tripura'),(566,106,'IN','UP','Uttar Pradesh'),(567,106,'IN','UT','Uttarakhand'),(568,106,'IN','WB','West Bengal'),(569,176,'PY','PY-16','Alto Paraguay'),(570,176,'PY','PY-10','Alto Paran├í'),(571,176,'PY','PY-13','Amambay'),(572,176,'PY','PY-ASU','Asunci├│n'),(573,176,'PY','PY-19','Boquer├│n'),(574,176,'PY','PY-5','Caaguaz├║'),(575,176,'PY','PY-6','Caazap├í'),(576,176,'PY','PY-14','Canindey├║'),(577,176,'PY','PY-11','Central'),(578,176,'PY','PY-1','Concepci├│n'),(579,176,'PY','PY-3','Cordillera'),(580,176,'PY','PY-4','Guair├í'),(581,176,'PY','PY-7','Itap├║a'),(582,176,'PY','PY-8','Misiones'),(583,176,'PY','PY-9','Paraguar├¡'),(584,176,'PY','PY-15','Presidente Hayes'),(585,176,'PY','PY-2','San Pedro'),(586,176,'PY','PY-12','├æeembuc├║');
/*!40000 ALTER TABLE `country_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country_translations`
--

DROP TABLE IF EXISTS `country_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `name` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_translations_country_id_foreign` (`country_id`),
  CONSTRAINT `country_translations_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_translations`
--

LOCK TABLES `country_translations` WRITE;
/*!40000 ALTER TABLE `country_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `country_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `symbol` varchar(255) DEFAULT NULL,
  `decimal` int(10) unsigned NOT NULL DEFAULT 2,
  `group_separator` varchar(255) NOT NULL DEFAULT ',',
  `decimal_separator` varchar(255) NOT NULL DEFAULT '.',
  `currency_position` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES (1,'BDT','Bangladeshi Taka','αº│',2,',','.',NULL,NULL,NULL);
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency_exchange_rates`
--

DROP TABLE IF EXISTS `currency_exchange_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency_exchange_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rate` decimal(24,12) NOT NULL,
  `target_currency` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `currency_exchange_rates_target_currency_unique` (`target_currency`),
  CONSTRAINT `currency_exchange_rates_target_currency_foreign` FOREIGN KEY (`target_currency`) REFERENCES `currencies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_exchange_rates`
--

LOCK TABLES `currency_exchange_rates` WRITE;
/*!40000 ALTER TABLE `currency_exchange_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `currency_exchange_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_groups`
--

DROP TABLE IF EXISTS `customer_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_user_defined` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_groups_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_groups`
--

LOCK TABLES `customer_groups` WRITE;
/*!40000 ALTER TABLE `customer_groups` DISABLE KEYS */;
INSERT INTO `customer_groups` VALUES (1,'guest','Guest',0,NULL,NULL),(2,'general','General',0,NULL,NULL),(3,'wholesale','Wholesale',0,NULL,NULL);
/*!40000 ALTER TABLE `customer_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_notes`
--

DROP TABLE IF EXISTS `customer_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_notes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `note` text NOT NULL,
  `customer_notified` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_notes_customer_id_foreign` (`customer_id`),
  CONSTRAINT `customer_notes_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_notes`
--

LOCK TABLES `customer_notes` WRITE;
/*!40000 ALTER TABLE `customer_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_password_resets`
--

DROP TABLE IF EXISTS `customer_password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `customer_password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_password_resets`
--

LOCK TABLES `customer_password_resets` WRITE;
/*!40000 ALTER TABLE `customer_password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_social_accounts`
--

DROP TABLE IF EXISTS `customer_social_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_social_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned NOT NULL,
  `provider_name` varchar(255) DEFAULT NULL,
  `provider_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_social_accounts_provider_id_unique` (`provider_id`),
  KEY `customer_social_accounts_customer_id_foreign` (`customer_id`),
  CONSTRAINT `customer_social_accounts_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_social_accounts`
--

LOCK TABLES `customer_social_accounts` WRITE;
/*!40000 ALTER TABLE `customer_social_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_social_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `password` varchar(255) DEFAULT NULL,
  `api_token` varchar(80) DEFAULT NULL,
  `customer_group_id` int(10) unsigned DEFAULT NULL,
  `channel_id` int(10) unsigned DEFAULT NULL,
  `subscribed_to_news_letter` tinyint(1) NOT NULL DEFAULT 0,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `is_suspended` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `token` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_email_unique` (`email`),
  UNIQUE KEY `customers_phone_unique` (`phone`),
  UNIQUE KEY `customers_api_token_unique` (`api_token`),
  KEY `customers_customer_group_id_foreign` (`customer_group_id`),
  KEY `customers_channel_id_foreign` (`channel_id`),
  CONSTRAINT `customers_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE SET NULL,
  CONSTRAINT `customers_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Imran','Khan',NULL,NULL,'ik11150500218@gmail.com',NULL,NULL,1,'$2y$12$QGPB9KY9cPHgyel7b0xccePRUvo.ABzJH.q150RgA7bLmmIu91ALi','I1CYZUyKTrhJ1ghERoUpZBHHxLcRBh5z2ErQRVV4mhupvBKxFKkKPauvdbKHTftpZBfoqnyhE5i1Jbtg',1,1,0,1,0,'a639db6851b63c1f086c903983c586d1',NULL,'2025-11-04 10:18:45','2025-11-04 10:18:45');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datagrid_saved_filters`
--

DROP TABLE IF EXISTS `datagrid_saved_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datagrid_saved_filters` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `src` varchar(255) NOT NULL,
  `applied` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`applied`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `datagrid_saved_filters_user_id_name_src_unique` (`user_id`,`name`,`src`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datagrid_saved_filters`
--

LOCK TABLES `datagrid_saved_filters` WRITE;
/*!40000 ALTER TABLE `datagrid_saved_filters` DISABLE KEYS */;
/*!40000 ALTER TABLE `datagrid_saved_filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `downloadable_link_purchased`
--

DROP TABLE IF EXISTS `downloadable_link_purchased`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `downloadable_link_purchased` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `download_bought` int(11) NOT NULL DEFAULT 0,
  `download_used` int(11) NOT NULL DEFAULT 0,
  `status` varchar(255) DEFAULT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `order_item_id` int(10) unsigned NOT NULL,
  `download_canceled` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `downloadable_link_purchased_customer_id_foreign` (`customer_id`),
  KEY `downloadable_link_purchased_order_id_foreign` (`order_id`),
  KEY `downloadable_link_purchased_order_item_id_foreign` (`order_item_id`),
  CONSTRAINT `downloadable_link_purchased_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `downloadable_link_purchased_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `downloadable_link_purchased_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `downloadable_link_purchased`
--

LOCK TABLES `downloadable_link_purchased` WRITE;
/*!40000 ALTER TABLE `downloadable_link_purchased` DISABLE KEYS */;
/*!40000 ALTER TABLE `downloadable_link_purchased` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gdpr_data_request`
--

DROP TABLE IF EXISTS `gdpr_data_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gdpr_data_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `message` varchar(500) NOT NULL,
  `revoked_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gdpr_data_request_customer_id_foreign` (`customer_id`),
  CONSTRAINT `gdpr_data_request_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gdpr_data_request`
--

LOCK TABLES `gdpr_data_request` WRITE;
/*!40000 ALTER TABLE `gdpr_data_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `gdpr_data_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_batches`
--

DROP TABLE IF EXISTS `import_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_batches` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `state` varchar(255) NOT NULL DEFAULT 'pending',
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`)),
  `summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`summary`)),
  `import_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `import_batches_import_id_foreign` (`import_id`),
  CONSTRAINT `import_batches_import_id_foreign` FOREIGN KEY (`import_id`) REFERENCES `imports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_batches`
--

LOCK TABLES `import_batches` WRITE;
/*!40000 ALTER TABLE `import_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imports`
--

DROP TABLE IF EXISTS `imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `state` varchar(255) NOT NULL DEFAULT 'pending',
  `process_in_queue` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `validation_strategy` varchar(255) NOT NULL,
  `allowed_errors` int(11) NOT NULL DEFAULT 0,
  `processed_rows_count` int(11) NOT NULL DEFAULT 0,
  `invalid_rows_count` int(11) NOT NULL DEFAULT 0,
  `errors_count` int(11) NOT NULL DEFAULT 0,
  `errors` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`errors`)),
  `field_separator` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `images_directory_path` varchar(255) DEFAULT NULL,
  `error_file_path` varchar(255) DEFAULT NULL,
  `summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`summary`)),
  `started_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imports`
--

LOCK TABLES `imports` WRITE;
/*!40000 ALTER TABLE `imports` DISABLE KEYS */;
/*!40000 ALTER TABLE `imports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_sources`
--

DROP TABLE IF EXISTS `inventory_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory_sources` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `contact_name` varchar(255) NOT NULL,
  `contact_email` varchar(255) NOT NULL,
  `contact_number` varchar(255) NOT NULL,
  `contact_fax` varchar(255) DEFAULT NULL,
  `country` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `postcode` varchar(255) NOT NULL,
  `priority` int(11) NOT NULL DEFAULT 0,
  `latitude` decimal(10,5) DEFAULT NULL,
  `longitude` decimal(10,5) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inventory_sources_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_sources`
--

LOCK TABLES `inventory_sources` WRITE;
/*!40000 ALTER TABLE `inventory_sources` DISABLE KEYS */;
INSERT INTO `inventory_sources` VALUES (1,'default','Default',NULL,'Default','warehouse@example.com','1234567899',NULL,'US','MI','Detroit','12th Street','48127',0,NULL,NULL,1,NULL,NULL);
/*!40000 ALTER TABLE `inventory_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_items`
--

DROP TABLE IF EXISTS `invoice_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `tax_amount` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) DEFAULT 0.0000,
  `discount_percent` decimal(12,4) DEFAULT 0.0000,
  `discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `price_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_price_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `product_id` int(10) unsigned DEFAULT NULL,
  `product_type` varchar(255) DEFAULT NULL,
  `order_item_id` int(10) unsigned DEFAULT NULL,
  `invoice_id` int(10) unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_items_invoice_id_foreign` (`invoice_id`),
  KEY `invoice_items_parent_id_foreign` (`parent_id`),
  CONSTRAINT `invoice_items_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoice_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `invoice_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_items`
--

LOCK TABLES `invoice_items` WRITE;
/*!40000 ALTER TABLE `invoice_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `increment_id` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `email_sent` tinyint(1) NOT NULL DEFAULT 0,
  `total_qty` int(11) DEFAULT NULL,
  `base_currency_code` varchar(255) DEFAULT NULL,
  `channel_currency_code` varchar(255) DEFAULT NULL,
  `order_currency_code` varchar(255) DEFAULT NULL,
  `sub_total` decimal(12,4) DEFAULT 0.0000,
  `base_sub_total` decimal(12,4) DEFAULT 0.0000,
  `grand_total` decimal(12,4) DEFAULT 0.0000,
  `base_grand_total` decimal(12,4) DEFAULT 0.0000,
  `shipping_amount` decimal(12,4) DEFAULT 0.0000,
  `base_shipping_amount` decimal(12,4) DEFAULT 0.0000,
  `tax_amount` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) DEFAULT 0.0000,
  `discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `shipping_tax_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_shipping_tax_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `order_id` int(10) unsigned DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `reminders` int(11) NOT NULL DEFAULT 0,
  `next_reminder_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoices_order_id_foreign` (`order_id`),
  CONSTRAINT `invoices_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` text NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales`
--

DROP TABLE IF EXISTS `locales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `direction` enum('ltr','rtl') NOT NULL DEFAULT 'ltr',
  `logo_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `locales_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales`
--

LOCK TABLES `locales` WRITE;
/*!40000 ALTER TABLE `locales` DISABLE KEYS */;
INSERT INTO `locales` VALUES (1,'en','English','ltr','locales/en.png',NULL,'2025-11-04 11:11:03');
/*!40000 ALTER TABLE `locales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marketing_campaigns`
--

DROP TABLE IF EXISTS `marketing_campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marketing_campaigns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `type` varchar(255) NOT NULL,
  `mail_to` varchar(255) NOT NULL,
  `spooling` varchar(255) DEFAULT NULL,
  `channel_id` int(10) unsigned DEFAULT NULL,
  `customer_group_id` int(10) unsigned DEFAULT NULL,
  `marketing_template_id` int(10) unsigned DEFAULT NULL,
  `marketing_event_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `marketing_campaigns_channel_id_foreign` (`channel_id`),
  KEY `marketing_campaigns_customer_group_id_foreign` (`customer_group_id`),
  KEY `marketing_campaigns_marketing_template_id_foreign` (`marketing_template_id`),
  KEY `marketing_campaigns_marketing_event_id_foreign` (`marketing_event_id`),
  CONSTRAINT `marketing_campaigns_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE SET NULL,
  CONSTRAINT `marketing_campaigns_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE SET NULL,
  CONSTRAINT `marketing_campaigns_marketing_event_id_foreign` FOREIGN KEY (`marketing_event_id`) REFERENCES `marketing_events` (`id`) ON DELETE SET NULL,
  CONSTRAINT `marketing_campaigns_marketing_template_id_foreign` FOREIGN KEY (`marketing_template_id`) REFERENCES `marketing_templates` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marketing_campaigns`
--

LOCK TABLES `marketing_campaigns` WRITE;
/*!40000 ALTER TABLE `marketing_campaigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `marketing_campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marketing_events`
--

DROP TABLE IF EXISTS `marketing_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marketing_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marketing_events`
--

LOCK TABLES `marketing_events` WRITE;
/*!40000 ALTER TABLE `marketing_events` DISABLE KEYS */;
INSERT INTO `marketing_events` VALUES (1,'Birthday','Birthday',NULL,NULL,NULL);
/*!40000 ALTER TABLE `marketing_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marketing_templates`
--

DROP TABLE IF EXISTS `marketing_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marketing_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marketing_templates`
--

LOCK TABLES `marketing_templates` WRITE;
/*!40000 ALTER TABLE `marketing_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `marketing_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_admin_password_resets_table',1),(3,'2014_10_12_100000_create_password_resets_table',1),(4,'2018_06_12_111907_create_admins_table',1),(5,'2018_06_13_055341_create_roles_table',1),(6,'2018_07_05_130148_create_attributes_table',1),(7,'2018_07_05_132854_create_attribute_translations_table',1),(8,'2018_07_05_135150_create_attribute_families_table',1),(9,'2018_07_05_135152_create_attribute_groups_table',1),(10,'2018_07_05_140832_create_attribute_options_table',1),(11,'2018_07_05_140856_create_attribute_option_translations_table',1),(12,'2018_07_05_142820_create_categories_table',1),(13,'2018_07_10_055143_create_locales_table',1),(14,'2018_07_20_054426_create_countries_table',1),(15,'2018_07_20_054502_create_currencies_table',1),(16,'2018_07_20_054542_create_currency_exchange_rates_table',1),(17,'2018_07_20_064849_create_channels_table',1),(18,'2018_07_21_142836_create_category_translations_table',1),(19,'2018_07_23_110040_create_inventory_sources_table',1),(20,'2018_07_24_082635_create_customer_groups_table',1),(21,'2018_07_24_082930_create_customers_table',1),(22,'2018_07_27_065727_create_products_table',1),(23,'2018_07_27_070011_create_product_attribute_values_table',1),(24,'2018_07_27_092623_create_product_reviews_table',1),(25,'2018_07_27_113941_create_product_images_table',1),(26,'2018_07_27_113956_create_product_inventories_table',1),(27,'2018_08_30_064755_create_tax_categories_table',1),(28,'2018_08_30_065042_create_tax_rates_table',1),(29,'2018_08_30_065840_create_tax_mappings_table',1),(30,'2018_09_05_150444_create_cart_table',1),(31,'2018_09_05_150915_create_cart_items_table',1),(32,'2018_09_11_064045_customer_password_resets',1),(33,'2018_09_19_093453_create_cart_payment',1),(34,'2018_09_19_093508_create_cart_shipping_rates_table',1),(35,'2018_09_20_060658_create_core_config_table',1),(36,'2018_09_27_113154_create_orders_table',1),(37,'2018_09_27_113207_create_order_items_table',1),(38,'2018_09_27_115022_create_shipments_table',1),(39,'2018_09_27_115029_create_shipment_items_table',1),(40,'2018_09_27_115135_create_invoices_table',1),(41,'2018_09_27_115144_create_invoice_items_table',1),(42,'2018_10_01_095504_create_order_payment_table',1),(43,'2018_10_03_025230_create_wishlist_table',1),(44,'2018_10_12_101803_create_country_translations_table',1),(45,'2018_10_12_101913_create_country_states_table',1),(46,'2018_10_12_101923_create_country_state_translations_table',1),(47,'2018_11_16_173504_create_subscribers_list_table',1),(48,'2018_11_21_144411_create_cart_item_inventories_table',1),(49,'2018_12_06_185202_create_product_flat_table',1),(50,'2018_12_24_123812_create_channel_inventory_sources_table',1),(51,'2018_12_26_165327_create_product_ordered_inventories_table',1),(52,'2019_05_13_024321_create_cart_rules_table',1),(53,'2019_05_13_024322_create_cart_rule_channels_table',1),(54,'2019_05_13_024323_create_cart_rule_customer_groups_table',1),(55,'2019_05_13_024324_create_cart_rule_translations_table',1),(56,'2019_05_13_024325_create_cart_rule_customers_table',1),(57,'2019_05_13_024326_create_cart_rule_coupons_table',1),(58,'2019_05_13_024327_create_cart_rule_coupon_usage_table',1),(59,'2019_06_17_180258_create_product_downloadable_samples_table',1),(60,'2019_06_17_180314_create_product_downloadable_sample_translations_table',1),(61,'2019_06_17_180325_create_product_downloadable_links_table',1),(62,'2019_06_17_180346_create_product_downloadable_link_translations_table',1),(63,'2019_06_21_202249_create_downloadable_link_purchased_table',1),(64,'2019_07_02_180307_create_booking_products_table',1),(65,'2019_07_05_154415_create_booking_product_default_slots_table',1),(66,'2019_07_05_154429_create_booking_product_appointment_slots_table',1),(67,'2019_07_05_154440_create_booking_product_event_tickets_table',1),(68,'2019_07_05_154451_create_booking_product_rental_slots_table',1),(69,'2019_07_05_154502_create_booking_product_table_slots_table',1),(70,'2019_07_30_153530_create_cms_pages_table',1),(71,'2019_07_31_143339_create_category_filterable_attributes_table',1),(72,'2019_08_02_105320_create_product_grouped_products_table',1),(73,'2019_08_20_170510_create_product_bundle_options_table',1),(74,'2019_08_20_170520_create_product_bundle_option_translations_table',1),(75,'2019_08_20_170528_create_product_bundle_option_products_table',1),(76,'2019_09_11_184511_create_refunds_table',1),(77,'2019_09_11_184519_create_refund_items_table',1),(78,'2019_12_03_184613_create_catalog_rules_table',1),(79,'2019_12_03_184651_create_catalog_rule_channels_table',1),(80,'2019_12_03_184732_create_catalog_rule_customer_groups_table',1),(81,'2019_12_06_101110_create_catalog_rule_products_table',1),(82,'2019_12_06_110507_create_catalog_rule_product_prices_table',1),(83,'2019_12_14_000001_create_personal_access_tokens_table',1),(84,'2020_01_14_191854_create_cms_page_translations_table',1),(85,'2020_01_15_130209_create_cms_page_channels_table',1),(86,'2020_02_18_165639_create_bookings_table',1),(87,'2020_02_21_121201_create_booking_product_event_ticket_translations_table',1),(88,'2020_04_16_185147_add_table_addresses',1),(89,'2020_05_06_171638_create_order_comments_table',1),(90,'2020_05_21_171500_create_product_customer_group_prices_table',1),(91,'2020_06_25_162154_create_customer_social_accounts_table',1),(92,'2020_08_07_174804_create_gdpr_data_request_table',1),(93,'2020_11_19_112228_create_product_videos_table',1),(94,'2020_11_26_141455_create_marketing_templates_table',1),(95,'2020_11_26_150534_create_marketing_events_table',1),(96,'2020_11_26_150644_create_marketing_campaigns_table',1),(97,'2020_12_21_000200_create_channel_translations_table',1),(98,'2020_12_27_121950_create_jobs_table',1),(99,'2021_03_11_212124_create_order_transactions_table',1),(100,'2021_04_07_132010_create_product_review_images_table',1),(101,'2021_12_15_104544_notifications',1),(102,'2022_03_15_160510_create_failed_jobs_table',1),(103,'2022_04_01_094622_create_sitemaps_table',1),(104,'2022_10_03_144232_create_product_price_indices_table',1),(105,'2022_10_04_144444_create_job_batches_table',1),(106,'2022_10_08_134150_create_product_inventory_indices_table',1),(107,'2023_05_26_213105_create_wishlist_items_table',1),(108,'2023_05_26_213120_create_compare_items_table',1),(109,'2023_06_27_163529_rename_product_review_images_to_product_review_attachments',1),(110,'2023_07_06_140013_add_logo_path_column_to_locales',1),(111,'2023_07_10_184256_create_theme_customizations_table',1),(112,'2023_07_12_181722_remove_home_page_and_footer_content_column_from_channel_translations_table',1),(113,'2023_07_20_185324_add_column_column_in_attribute_groups_table',1),(114,'2023_07_25_145943_add_regex_column_in_attributes_table',1),(115,'2023_07_25_165945_drop_notes_column_from_customers_table',1),(116,'2023_07_25_171058_create_customer_notes_table',1),(117,'2023_07_31_125232_rename_image_and_category_banner_columns_from_categories_table',1),(118,'2023_09_15_170053_create_theme_customization_translations_table',1),(119,'2023_09_20_102031_add_default_value_column_in_attributes_table',1),(120,'2023_09_20_102635_add_inventories_group_in_attribute_groups_table',1),(121,'2023_09_26_155709_add_columns_to_currencies',1),(122,'2023_10_05_163612_create_visits_table',1),(123,'2023_10_12_090446_add_tax_category_id_column_in_order_items_table',1),(124,'2023_11_08_054614_add_code_column_in_attribute_groups_table',1),(125,'2023_11_08_140116_create_search_terms_table',1),(126,'2023_11_09_162805_create_url_rewrites_table',1),(127,'2023_11_17_150401_create_search_synonyms_table',1),(128,'2023_12_11_054614_add_channel_id_column_in_product_price_indices_table',1),(129,'2024_01_11_154640_create_imports_table',1),(130,'2024_01_11_154741_create_import_batches_table',1),(131,'2024_01_19_170350_add_unique_id_column_in_product_attribute_values_table',1),(132,'2024_01_19_170350_add_unique_id_column_in_product_customer_group_prices_table',1),(133,'2024_01_22_170814_add_unique_index_in_mapping_tables',1),(134,'2024_02_26_153000_add_columns_to_addresses_table',1),(135,'2024_03_07_193421_rename_address1_column_in_addresses_table',1),(136,'2024_04_16_144400_add_cart_id_column_in_cart_shipping_rates_table',1),(137,'2024_04_19_102939_add_incl_tax_columns_in_orders_table',1),(138,'2024_04_19_135405_add_incl_tax_columns_in_cart_items_table',1),(139,'2024_04_19_144641_add_incl_tax_columns_in_order_items_table',1),(140,'2024_04_23_133154_add_incl_tax_columns_in_cart_table',1),(141,'2024_04_23_150945_add_incl_tax_columns_in_cart_shipping_rates_table',1),(142,'2024_04_24_102939_add_incl_tax_columns_in_invoices_table',1),(143,'2024_04_24_102939_add_incl_tax_columns_in_refunds_table',1),(144,'2024_04_24_144641_add_incl_tax_columns_in_invoice_items_table',1),(145,'2024_04_24_144641_add_incl_tax_columns_in_refund_items_table',1),(146,'2024_04_24_144641_add_incl_tax_columns_in_shipment_items_table',1),(147,'2024_05_10_152848_create_saved_filters_table',1),(148,'2024_06_03_174128_create_product_channels_table',1),(149,'2024_06_04_130527_add_channel_id_column_in_customers_table',1),(150,'2024_06_04_134403_add_channel_id_column_in_visits_table',1),(151,'2024_06_13_184426_add_theme_column_into_theme_customizations_table',1),(152,'2024_07_17_172645_add_additional_column_to_sitemaps_table',1),(153,'2024_10_11_135010_create_product_customizable_options_table',1),(154,'2024_10_11_135110_create_product_customizable_option_translations_table',1),(155,'2024_10_11_135228_create_product_customizable_option_prices_table',1),(156,'2025_05_07_121250_update_total_weight_columns_in_shipments_and_weight_shipment_items_tables',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `order_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_order_id_foreign` (`order_id`),
  CONSTRAINT `notifications_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_comments`
--

DROP TABLE IF EXISTS `order_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `comment` text NOT NULL,
  `customer_notified` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_comments_order_id_foreign` (`order_id`),
  CONSTRAINT `order_comments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_comments`
--

LOCK TABLES `order_comments` WRITE;
/*!40000 ALTER TABLE `order_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `coupon_code` varchar(255) DEFAULT NULL,
  `weight` decimal(12,4) DEFAULT 0.0000,
  `total_weight` decimal(12,4) DEFAULT 0.0000,
  `qty_ordered` int(11) DEFAULT 0,
  `qty_shipped` int(11) DEFAULT 0,
  `qty_invoiced` int(11) DEFAULT 0,
  `qty_canceled` int(11) DEFAULT 0,
  `qty_refunded` int(11) DEFAULT 0,
  `price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `total_invoiced` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total_invoiced` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `amount_refunded` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_amount_refunded` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `discount_percent` decimal(12,4) DEFAULT 0.0000,
  `discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `discount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `base_discount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `discount_refunded` decimal(12,4) DEFAULT 0.0000,
  `base_discount_refunded` decimal(12,4) DEFAULT 0.0000,
  `tax_percent` decimal(12,4) DEFAULT 0.0000,
  `tax_amount` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) DEFAULT 0.0000,
  `tax_amount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `tax_amount_refunded` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount_refunded` decimal(12,4) DEFAULT 0.0000,
  `price_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_price_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `product_id` int(10) unsigned DEFAULT NULL,
  `product_type` varchar(255) DEFAULT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  `tax_category_id` int(10) unsigned DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_parent_id_foreign` (`parent_id`),
  KEY `order_items_tax_category_id_foreign` (`tax_category_id`),
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_tax_category_id_foreign` FOREIGN KEY (`tax_category_id`) REFERENCES `tax_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_payment`
--

DROP TABLE IF EXISTS `order_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `method` varchar(255) NOT NULL,
  `method_title` varchar(255) DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_payment_order_id_foreign` (`order_id`),
  CONSTRAINT `order_payment_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_payment`
--

LOCK TABLES `order_payment` WRITE;
/*!40000 ALTER TABLE `order_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_transactions`
--

DROP TABLE IF EXISTS `order_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `amount` decimal(12,4) DEFAULT 0.0000,
  `payment_method` varchar(255) DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `invoice_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_transactions_order_id_foreign` (`order_id`),
  CONSTRAINT `order_transactions_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_transactions`
--

LOCK TABLES `order_transactions` WRITE;
/*!40000 ALTER TABLE `order_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `increment_id` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `channel_name` varchar(255) DEFAULT NULL,
  `is_guest` tinyint(1) DEFAULT NULL,
  `customer_email` varchar(255) DEFAULT NULL,
  `customer_first_name` varchar(255) DEFAULT NULL,
  `customer_last_name` varchar(255) DEFAULT NULL,
  `shipping_method` varchar(255) DEFAULT NULL,
  `shipping_title` varchar(255) DEFAULT NULL,
  `shipping_description` varchar(255) DEFAULT NULL,
  `coupon_code` varchar(255) DEFAULT NULL,
  `is_gift` tinyint(1) NOT NULL DEFAULT 0,
  `total_item_count` int(11) DEFAULT NULL,
  `total_qty_ordered` int(11) DEFAULT NULL,
  `base_currency_code` varchar(255) DEFAULT NULL,
  `channel_currency_code` varchar(255) DEFAULT NULL,
  `order_currency_code` varchar(255) DEFAULT NULL,
  `grand_total` decimal(12,4) DEFAULT 0.0000,
  `base_grand_total` decimal(12,4) DEFAULT 0.0000,
  `grand_total_invoiced` decimal(12,4) DEFAULT 0.0000,
  `base_grand_total_invoiced` decimal(12,4) DEFAULT 0.0000,
  `grand_total_refunded` decimal(12,4) DEFAULT 0.0000,
  `base_grand_total_refunded` decimal(12,4) DEFAULT 0.0000,
  `sub_total` decimal(12,4) DEFAULT 0.0000,
  `base_sub_total` decimal(12,4) DEFAULT 0.0000,
  `sub_total_invoiced` decimal(12,4) DEFAULT 0.0000,
  `base_sub_total_invoiced` decimal(12,4) DEFAULT 0.0000,
  `sub_total_refunded` decimal(12,4) DEFAULT 0.0000,
  `base_sub_total_refunded` decimal(12,4) DEFAULT 0.0000,
  `discount_percent` decimal(12,4) DEFAULT 0.0000,
  `discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `discount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `base_discount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `discount_refunded` decimal(12,4) DEFAULT 0.0000,
  `base_discount_refunded` decimal(12,4) DEFAULT 0.0000,
  `tax_amount` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) DEFAULT 0.0000,
  `tax_amount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `tax_amount_refunded` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount_refunded` decimal(12,4) DEFAULT 0.0000,
  `shipping_amount` decimal(12,4) DEFAULT 0.0000,
  `base_shipping_amount` decimal(12,4) DEFAULT 0.0000,
  `shipping_invoiced` decimal(12,4) DEFAULT 0.0000,
  `base_shipping_invoiced` decimal(12,4) DEFAULT 0.0000,
  `shipping_refunded` decimal(12,4) DEFAULT 0.0000,
  `base_shipping_refunded` decimal(12,4) DEFAULT 0.0000,
  `shipping_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_shipping_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `shipping_tax_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_shipping_tax_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `shipping_tax_refunded` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_shipping_tax_refunded` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `customer_type` varchar(255) DEFAULT NULL,
  `channel_id` int(10) unsigned DEFAULT NULL,
  `channel_type` varchar(255) DEFAULT NULL,
  `cart_id` int(11) DEFAULT NULL,
  `applied_cart_rule_ids` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_increment_id_unique` (`increment_id`),
  KEY `orders_customer_id_foreign` (`customer_id`),
  KEY `orders_channel_id_foreign` (`channel_id`),
  CONSTRAINT `orders_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_attribute_values`
--

DROP TABLE IF EXISTS `product_attribute_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_attribute_values` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(255) DEFAULT NULL,
  `channel` varchar(255) DEFAULT NULL,
  `text_value` text DEFAULT NULL,
  `boolean_value` tinyint(1) DEFAULT NULL,
  `integer_value` int(11) DEFAULT NULL,
  `float_value` decimal(12,4) DEFAULT NULL,
  `datetime_value` datetime DEFAULT NULL,
  `date_value` date DEFAULT NULL,
  `json_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_value`)),
  `product_id` int(10) unsigned NOT NULL,
  `attribute_id` int(10) unsigned NOT NULL,
  `unique_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chanel_locale_attribute_value_index_unique` (`channel`,`locale`,`attribute_id`,`product_id`),
  UNIQUE KEY `product_attribute_values_unique_id_unique` (`unique_id`),
  KEY `product_attribute_values_product_id_foreign` (`product_id`),
  KEY `product_attribute_values_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `product_attribute_values_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_attribute_values_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_attribute_values`
--

LOCK TABLES `product_attribute_values` WRITE;
/*!40000 ALTER TABLE `product_attribute_values` DISABLE KEYS */;
INSERT INTO `product_attribute_values` VALUES (1,'en',NULL,'<p>.</p>',NULL,NULL,NULL,NULL,NULL,NULL,1,9,'en|1|9'),(2,'en',NULL,'<p>.</p>',NULL,NULL,NULL,NULL,NULL,NULL,1,10,'en|1|10'),(3,NULL,NULL,'CL-SAN-LT-8-BLU',NULL,NULL,NULL,NULL,NULL,NULL,1,1,'1|1'),(4,'en',NULL,'Long Shoes',NULL,NULL,NULL,NULL,NULL,NULL,1,2,'en|1|2'),(5,'en',NULL,'long-shoes',NULL,NULL,NULL,NULL,NULL,NULL,1,3,'en|1|3'),(6,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,1,23,'1|23'),(7,NULL,NULL,NULL,NULL,6,NULL,NULL,NULL,NULL,1,24,'1|24'),(8,NULL,NULL,'25325661',NULL,NULL,NULL,NULL,NULL,NULL,1,27,'1|27'),(9,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,1,28,'default|1|28'),(10,'en',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,1,16,'en|1|16'),(11,'en',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,1,17,'en|1|17'),(12,'en',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,1,18,'en|1|18'),(13,NULL,NULL,NULL,NULL,NULL,1999.0000,NULL,NULL,NULL,1,11,'1|11'),(14,NULL,NULL,NULL,NULL,NULL,1200.0000,NULL,NULL,NULL,1,12,'1|12'),(15,NULL,NULL,NULL,NULL,NULL,1899.0000,NULL,NULL,NULL,1,13,'1|13'),(16,NULL,'default',NULL,NULL,NULL,NULL,NULL,'2025-11-04',NULL,1,14,'default|1|14'),(17,NULL,'default',NULL,NULL,NULL,NULL,NULL,'2025-11-13',NULL,1,15,'default|1|15'),(18,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,1,5,'1|5'),(19,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,1,6,'1|6'),(20,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,1,7,'1|7'),(21,NULL,'default',NULL,1,NULL,NULL,NULL,NULL,NULL,1,8,'default|1|8'),(22,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,1,26,'1|26'),(23,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,1,19,'1|19'),(24,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,1,20,'1|20'),(25,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,1,21,'1|21'),(26,NULL,NULL,'0.248',NULL,NULL,NULL,NULL,NULL,NULL,1,22,'1|22');
/*!40000 ALTER TABLE `product_attribute_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_bundle_option_products`
--

DROP TABLE IF EXISTS `product_bundle_option_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_bundle_option_products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `product_bundle_option_id` int(10) unsigned NOT NULL,
  `qty` int(11) NOT NULL DEFAULT 0,
  `is_user_defined` tinyint(1) NOT NULL DEFAULT 1,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bundle_option_products_product_id_bundle_option_id_unique` (`product_id`,`product_bundle_option_id`),
  KEY `product_bundle_option_id_foreign` (`product_bundle_option_id`),
  CONSTRAINT `product_bundle_option_id_foreign` FOREIGN KEY (`product_bundle_option_id`) REFERENCES `product_bundle_options` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_bundle_option_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_bundle_option_products`
--

LOCK TABLES `product_bundle_option_products` WRITE;
/*!40000 ALTER TABLE `product_bundle_option_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_bundle_option_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_bundle_option_translations`
--

DROP TABLE IF EXISTS `product_bundle_option_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_bundle_option_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(255) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `product_bundle_option_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_bundle_option_translations_option_id_locale_unique` (`product_bundle_option_id`,`locale`),
  UNIQUE KEY `bundle_option_translations_locale_label_bundle_option_id_unique` (`locale`,`label`,`product_bundle_option_id`),
  CONSTRAINT `product_bundle_option_translations_option_id_foreign` FOREIGN KEY (`product_bundle_option_id`) REFERENCES `product_bundle_options` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_bundle_option_translations`
--

LOCK TABLES `product_bundle_option_translations` WRITE;
/*!40000 ALTER TABLE `product_bundle_option_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_bundle_option_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_bundle_options`
--

DROP TABLE IF EXISTS `product_bundle_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_bundle_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `product_bundle_options_product_id_foreign` (`product_id`),
  CONSTRAINT `product_bundle_options_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_bundle_options`
--

LOCK TABLES `product_bundle_options` WRITE;
/*!40000 ALTER TABLE `product_bundle_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_bundle_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_categories` (
  `product_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `product_categories_product_id_category_id_unique` (`product_id`,`category_id`),
  KEY `product_categories_category_id_foreign` (`category_id`),
  CONSTRAINT `product_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_categories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_categories`
--

LOCK TABLES `product_categories` WRITE;
/*!40000 ALTER TABLE `product_categories` DISABLE KEYS */;
INSERT INTO `product_categories` VALUES (1,3);
/*!40000 ALTER TABLE `product_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_channels`
--

DROP TABLE IF EXISTS `product_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_channels` (
  `product_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `product_channels_product_id_channel_id_unique` (`product_id`,`channel_id`),
  KEY `product_channels_channel_id_foreign` (`channel_id`),
  CONSTRAINT `product_channels_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_channels_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_channels`
--

LOCK TABLES `product_channels` WRITE;
/*!40000 ALTER TABLE `product_channels` DISABLE KEYS */;
INSERT INTO `product_channels` VALUES (1,1);
/*!40000 ALTER TABLE `product_channels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_cross_sells`
--

DROP TABLE IF EXISTS `product_cross_sells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_cross_sells` (
  `parent_id` int(10) unsigned NOT NULL,
  `child_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `product_cross_sells_parent_id_child_id_unique` (`parent_id`,`child_id`),
  KEY `product_cross_sells_child_id_foreign` (`child_id`),
  CONSTRAINT `product_cross_sells_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_cross_sells_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_cross_sells`
--

LOCK TABLES `product_cross_sells` WRITE;
/*!40000 ALTER TABLE `product_cross_sells` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_cross_sells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_customer_group_prices`
--

DROP TABLE IF EXISTS `product_customer_group_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_customer_group_prices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL DEFAULT 0,
  `value_type` varchar(255) NOT NULL,
  `value` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `product_id` int(10) unsigned NOT NULL,
  `customer_group_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `unique_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_customer_group_prices_unique_id_unique` (`unique_id`),
  KEY `product_customer_group_prices_product_id_foreign` (`product_id`),
  KEY `product_customer_group_prices_customer_group_id_foreign` (`customer_group_id`),
  CONSTRAINT `product_customer_group_prices_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_customer_group_prices_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_customer_group_prices`
--

LOCK TABLES `product_customer_group_prices` WRITE;
/*!40000 ALTER TABLE `product_customer_group_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_customer_group_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_customizable_option_prices`
--

DROP TABLE IF EXISTS `product_customizable_option_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_customizable_option_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` text DEFAULT NULL,
  `price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `product_customizable_option_id` int(10) unsigned NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `pcop_product_customizable_option_id_foreign` (`product_customizable_option_id`),
  CONSTRAINT `pcop_product_customizable_option_id_foreign` FOREIGN KEY (`product_customizable_option_id`) REFERENCES `product_customizable_options` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_customizable_option_prices`
--

LOCK TABLES `product_customizable_option_prices` WRITE;
/*!40000 ALTER TABLE `product_customizable_option_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_customizable_option_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_customizable_option_translations`
--

DROP TABLE IF EXISTS `product_customizable_option_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_customizable_option_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(255) NOT NULL,
  `label` text DEFAULT NULL,
  `product_customizable_option_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_customizable_option_id_locale_unique` (`product_customizable_option_id`,`locale`),
  CONSTRAINT `pcot_product_customizable_option_id_foreign` FOREIGN KEY (`product_customizable_option_id`) REFERENCES `product_customizable_options` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_customizable_option_translations`
--

LOCK TABLES `product_customizable_option_translations` WRITE;
/*!40000 ALTER TABLE `product_customizable_option_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_customizable_option_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_customizable_options`
--

DROP TABLE IF EXISTS `product_customizable_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_customizable_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 1,
  `max_characters` text DEFAULT NULL,
  `supported_file_extensions` text DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `product_customizable_options_product_id_foreign` (`product_id`),
  CONSTRAINT `product_customizable_options_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_customizable_options`
--

LOCK TABLES `product_customizable_options` WRITE;
/*!40000 ALTER TABLE `product_customizable_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_customizable_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_downloadable_link_translations`
--

DROP TABLE IF EXISTS `product_downloadable_link_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_downloadable_link_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_downloadable_link_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `link_translations_link_id_foreign` (`product_downloadable_link_id`),
  CONSTRAINT `link_translations_link_id_foreign` FOREIGN KEY (`product_downloadable_link_id`) REFERENCES `product_downloadable_links` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_downloadable_link_translations`
--

LOCK TABLES `product_downloadable_link_translations` WRITE;
/*!40000 ALTER TABLE `product_downloadable_link_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_downloadable_link_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_downloadable_links`
--

DROP TABLE IF EXISTS `product_downloadable_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_downloadable_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `sample_url` varchar(255) DEFAULT NULL,
  `sample_file` varchar(255) DEFAULT NULL,
  `sample_file_name` varchar(255) DEFAULT NULL,
  `sample_type` varchar(255) DEFAULT NULL,
  `downloads` int(11) NOT NULL DEFAULT 0,
  `sort_order` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_downloadable_links_product_id_foreign` (`product_id`),
  CONSTRAINT `product_downloadable_links_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_downloadable_links`
--

LOCK TABLES `product_downloadable_links` WRITE;
/*!40000 ALTER TABLE `product_downloadable_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_downloadable_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_downloadable_sample_translations`
--

DROP TABLE IF EXISTS `product_downloadable_sample_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_downloadable_sample_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_downloadable_sample_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sample_translations_sample_id_foreign` (`product_downloadable_sample_id`),
  CONSTRAINT `sample_translations_sample_id_foreign` FOREIGN KEY (`product_downloadable_sample_id`) REFERENCES `product_downloadable_samples` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_downloadable_sample_translations`
--

LOCK TABLES `product_downloadable_sample_translations` WRITE;
/*!40000 ALTER TABLE `product_downloadable_sample_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_downloadable_sample_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_downloadable_samples`
--

DROP TABLE IF EXISTS `product_downloadable_samples`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_downloadable_samples` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_downloadable_samples_product_id_foreign` (`product_id`),
  CONSTRAINT `product_downloadable_samples_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_downloadable_samples`
--

LOCK TABLES `product_downloadable_samples` WRITE;
/*!40000 ALTER TABLE `product_downloadable_samples` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_downloadable_samples` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_flat`
--

DROP TABLE IF EXISTS `product_flat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_flat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `short_description` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `url_key` varchar(255) DEFAULT NULL,
  `new` tinyint(1) DEFAULT NULL,
  `featured` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `meta_title` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `price` decimal(12,4) DEFAULT NULL,
  `special_price` decimal(12,4) DEFAULT NULL,
  `special_price_from` date DEFAULT NULL,
  `special_price_to` date DEFAULT NULL,
  `weight` decimal(12,4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `locale` varchar(255) DEFAULT NULL,
  `channel` varchar(255) DEFAULT NULL,
  `attribute_family_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `visible_individually` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_flat_unique_index` (`product_id`,`channel`,`locale`),
  KEY `product_flat_attribute_family_id_foreign` (`attribute_family_id`),
  KEY `product_flat_parent_id_foreign` (`parent_id`),
  CONSTRAINT `product_flat_attribute_family_id_foreign` FOREIGN KEY (`attribute_family_id`) REFERENCES `attribute_families` (`id`),
  CONSTRAINT `product_flat_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `product_flat` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_flat_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_flat`
--

LOCK TABLES `product_flat` WRITE;
/*!40000 ALTER TABLE `product_flat` DISABLE KEYS */;
INSERT INTO `product_flat` VALUES (1,'CL-SAN-LT-8-BLU','simple','25325661','Long Shoes','<p>.</p>','<p>.</p>','long-shoes',1,1,1,'','','',1999.0000,1899.0000,'2025-11-04','2025-11-13',0.2480,'2025-11-04 17:12:52','en','default',1,1,'2025-11-04 17:15:34',NULL,1);
/*!40000 ALTER TABLE `product_flat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_grouped_products`
--

DROP TABLE IF EXISTS `product_grouped_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_grouped_products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `associated_product_id` int(10) unsigned NOT NULL,
  `qty` int(11) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `grouped_products_product_id_associated_product_id_unique` (`product_id`,`associated_product_id`),
  KEY `product_grouped_products_associated_product_id_foreign` (`associated_product_id`),
  CONSTRAINT `product_grouped_products_associated_product_id_foreign` FOREIGN KEY (`associated_product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_grouped_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_grouped_products`
--

LOCK TABLES `product_grouped_products` WRITE;
/*!40000 ALTER TABLE `product_grouped_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_grouped_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_images` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `product_images_product_id_foreign` (`product_id`),
  CONSTRAINT `product_images_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (1,'images','product/1/NhzGrIqNLgT7ISQbeoNrpsiVTxhMf5OvZbMxlBGY.webp',1,1),(2,'images','product/1/dBia5wmDK5CYU4ZW1rAOOyA7GFyRyEh0QLrGUEgd.webp',1,2);
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_inventories`
--

DROP TABLE IF EXISTS `product_inventories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_inventories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL DEFAULT 0,
  `product_id` int(10) unsigned NOT NULL,
  `vendor_id` int(11) NOT NULL DEFAULT 0,
  `inventory_source_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_source_vendor_index_unique` (`product_id`,`inventory_source_id`,`vendor_id`),
  KEY `product_inventories_inventory_source_id_foreign` (`inventory_source_id`),
  CONSTRAINT `product_inventories_inventory_source_id_foreign` FOREIGN KEY (`inventory_source_id`) REFERENCES `inventory_sources` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_inventories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_inventories`
--

LOCK TABLES `product_inventories` WRITE;
/*!40000 ALTER TABLE `product_inventories` DISABLE KEYS */;
INSERT INTO `product_inventories` VALUES (1,0,1,0,1);
/*!40000 ALTER TABLE `product_inventories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_inventory_indices`
--

DROP TABLE IF EXISTS `product_inventory_indices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_inventory_indices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL DEFAULT 0,
  `product_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_inventory_indices_product_id_channel_id_unique` (`product_id`,`channel_id`),
  KEY `product_inventory_indices_channel_id_foreign` (`channel_id`),
  CONSTRAINT `product_inventory_indices_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_inventory_indices_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_inventory_indices`
--

LOCK TABLES `product_inventory_indices` WRITE;
/*!40000 ALTER TABLE `product_inventory_indices` DISABLE KEYS */;
INSERT INTO `product_inventory_indices` VALUES (1,0,1,1,NULL,NULL);
/*!40000 ALTER TABLE `product_inventory_indices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_ordered_inventories`
--

DROP TABLE IF EXISTS `product_ordered_inventories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_ordered_inventories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL DEFAULT 0,
  `product_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_ordered_inventories_product_id_channel_id_unique` (`product_id`,`channel_id`),
  KEY `product_ordered_inventories_channel_id_foreign` (`channel_id`),
  CONSTRAINT `product_ordered_inventories_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_ordered_inventories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_ordered_inventories`
--

LOCK TABLES `product_ordered_inventories` WRITE;
/*!40000 ALTER TABLE `product_ordered_inventories` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_ordered_inventories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_price_indices`
--

DROP TABLE IF EXISTS `product_price_indices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_price_indices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `customer_group_id` int(10) unsigned DEFAULT NULL,
  `channel_id` int(10) unsigned NOT NULL DEFAULT 1,
  `min_price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `regular_min_price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `max_price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `regular_max_price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `price_indices_product_id_customer_group_id_channel_id_unique` (`product_id`,`customer_group_id`,`channel_id`),
  KEY `product_price_indices_customer_group_id_foreign` (`customer_group_id`),
  KEY `product_price_indices_channel_id_foreign` (`channel_id`),
  CONSTRAINT `product_price_indices_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_price_indices_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_price_indices_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_price_indices`
--

LOCK TABLES `product_price_indices` WRITE;
/*!40000 ALTER TABLE `product_price_indices` DISABLE KEYS */;
INSERT INTO `product_price_indices` VALUES (1,1,1,1,1899.0000,1999.0000,1899.0000,1999.0000,NULL,NULL),(2,1,2,1,1899.0000,1999.0000,1899.0000,1999.0000,NULL,NULL),(3,1,3,1,1899.0000,1999.0000,1899.0000,1999.0000,NULL,NULL);
/*!40000 ALTER TABLE `product_price_indices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_relations`
--

DROP TABLE IF EXISTS `product_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_relations` (
  `parent_id` int(10) unsigned NOT NULL,
  `child_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `product_relations_parent_id_child_id_unique` (`parent_id`,`child_id`),
  KEY `product_relations_child_id_foreign` (`child_id`),
  CONSTRAINT `product_relations_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_relations_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_relations`
--

LOCK TABLES `product_relations` WRITE;
/*!40000 ALTER TABLE `product_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_review_attachments`
--

DROP TABLE IF EXISTS `product_review_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_review_attachments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `review_id` int(10) unsigned NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'image',
  `mime_type` varchar(255) DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_review_images_review_id_foreign` (`review_id`),
  CONSTRAINT `product_review_images_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `product_reviews` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_review_attachments`
--

LOCK TABLES `product_review_attachments` WRITE;
/*!40000 ALTER TABLE `product_review_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_review_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_reviews`
--

DROP TABLE IF EXISTS `product_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_reviews` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_reviews_product_id_foreign` (`product_id`),
  CONSTRAINT `product_reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_reviews`
--

LOCK TABLES `product_reviews` WRITE;
/*!40000 ALTER TABLE `product_reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_super_attributes`
--

DROP TABLE IF EXISTS `product_super_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_super_attributes` (
  `product_id` int(10) unsigned NOT NULL,
  `attribute_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `product_super_attributes_product_id_attribute_id_unique` (`product_id`,`attribute_id`),
  KEY `product_super_attributes_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `product_super_attributes_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`),
  CONSTRAINT `product_super_attributes_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_super_attributes`
--

LOCK TABLES `product_super_attributes` WRITE;
/*!40000 ALTER TABLE `product_super_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_super_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_up_sells`
--

DROP TABLE IF EXISTS `product_up_sells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_up_sells` (
  `parent_id` int(10) unsigned NOT NULL,
  `child_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `product_up_sells_parent_id_child_id_unique` (`parent_id`,`child_id`),
  KEY `product_up_sells_child_id_foreign` (`child_id`),
  CONSTRAINT `product_up_sells_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_up_sells_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_up_sells`
--

LOCK TABLES `product_up_sells` WRITE;
/*!40000 ALTER TABLE `product_up_sells` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_up_sells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_videos`
--

DROP TABLE IF EXISTS `product_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_videos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `product_videos_product_id_foreign` (`product_id`),
  CONSTRAINT `product_videos_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_videos`
--

LOCK TABLES `product_videos` WRITE;
/*!40000 ALTER TABLE `product_videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `attribute_family_id` int(10) unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_sku_unique` (`sku`),
  KEY `products_attribute_family_id_foreign` (`attribute_family_id`),
  KEY `products_parent_id_foreign` (`parent_id`),
  CONSTRAINT `products_attribute_family_id_foreign` FOREIGN KEY (`attribute_family_id`) REFERENCES `attribute_families` (`id`),
  CONSTRAINT `products_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'CL-SAN-LT-8-BLU','simple',NULL,1,NULL,'2025-11-04 11:12:52','2025-11-04 11:12:52');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refund_items`
--

DROP TABLE IF EXISTS `refund_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `refund_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `tax_amount` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) DEFAULT 0.0000,
  `discount_percent` decimal(12,4) DEFAULT 0.0000,
  `discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `price_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_price_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `product_id` int(10) unsigned DEFAULT NULL,
  `product_type` varchar(255) DEFAULT NULL,
  `order_item_id` int(10) unsigned DEFAULT NULL,
  `refund_id` int(10) unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `refund_items_parent_id_foreign` (`parent_id`),
  KEY `refund_items_order_item_id_foreign` (`order_item_id`),
  KEY `refund_items_refund_id_foreign` (`refund_id`),
  CONSTRAINT `refund_items_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `refund_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `refund_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `refund_items_refund_id_foreign` FOREIGN KEY (`refund_id`) REFERENCES `refunds` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refund_items`
--

LOCK TABLES `refund_items` WRITE;
/*!40000 ALTER TABLE `refund_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `refund_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refunds`
--

DROP TABLE IF EXISTS `refunds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `refunds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `increment_id` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `email_sent` tinyint(1) NOT NULL DEFAULT 0,
  `total_qty` int(11) DEFAULT NULL,
  `base_currency_code` varchar(255) DEFAULT NULL,
  `channel_currency_code` varchar(255) DEFAULT NULL,
  `order_currency_code` varchar(255) DEFAULT NULL,
  `adjustment_refund` decimal(12,4) DEFAULT 0.0000,
  `base_adjustment_refund` decimal(12,4) DEFAULT 0.0000,
  `adjustment_fee` decimal(12,4) DEFAULT 0.0000,
  `base_adjustment_fee` decimal(12,4) DEFAULT 0.0000,
  `sub_total` decimal(12,4) DEFAULT 0.0000,
  `base_sub_total` decimal(12,4) DEFAULT 0.0000,
  `grand_total` decimal(12,4) DEFAULT 0.0000,
  `base_grand_total` decimal(12,4) DEFAULT 0.0000,
  `shipping_amount` decimal(12,4) DEFAULT 0.0000,
  `base_shipping_amount` decimal(12,4) DEFAULT 0.0000,
  `tax_amount` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) DEFAULT 0.0000,
  `discount_percent` decimal(12,4) DEFAULT 0.0000,
  `discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `shipping_tax_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_shipping_tax_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_sub_total_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_shipping_amount_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `order_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `refunds_order_id_foreign` (`order_id`),
  CONSTRAINT `refunds_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refunds`
--

LOCK TABLES `refunds` WRITE;
/*!40000 ALTER TABLE `refunds` DISABLE KEYS */;
/*!40000 ALTER TABLE `refunds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `permission_type` varchar(255) NOT NULL,
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permissions`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrator','This role users will have all the access','all',NULL,NULL,NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_synonyms`
--

DROP TABLE IF EXISTS `search_synonyms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_synonyms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `terms` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_synonyms`
--

LOCK TABLES `search_synonyms` WRITE;
/*!40000 ALTER TABLE `search_synonyms` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_synonyms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_terms`
--

DROP TABLE IF EXISTS `search_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_terms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `term` varchar(255) NOT NULL,
  `results` int(11) NOT NULL DEFAULT 0,
  `uses` int(11) NOT NULL DEFAULT 0,
  `redirect_url` varchar(255) DEFAULT NULL,
  `display_in_suggested_terms` tinyint(1) NOT NULL DEFAULT 0,
  `locale` varchar(255) NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `search_terms_channel_id_foreign` (`channel_id`),
  CONSTRAINT `search_terms_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_terms`
--

LOCK TABLES `search_terms` WRITE;
/*!40000 ALTER TABLE `search_terms` DISABLE KEYS */;
INSERT INTO `search_terms` VALUES (1,'Long',1,1,NULL,0,'en',1,'2025-11-04 11:17:43','2025-11-04 11:17:43');
/*!40000 ALTER TABLE `search_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipment_items`
--

DROP TABLE IF EXISTS `shipment_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipment_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `weight` decimal(12,4) DEFAULT NULL,
  `price` decimal(12,4) DEFAULT 0.0000,
  `base_price` decimal(12,4) DEFAULT 0.0000,
  `total` decimal(12,4) DEFAULT 0.0000,
  `base_total` decimal(12,4) DEFAULT 0.0000,
  `price_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_price_incl_tax` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `product_id` int(10) unsigned DEFAULT NULL,
  `product_type` varchar(255) DEFAULT NULL,
  `order_item_id` int(10) unsigned DEFAULT NULL,
  `shipment_id` int(10) unsigned NOT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipment_items_shipment_id_foreign` (`shipment_id`),
  CONSTRAINT `shipment_items_shipment_id_foreign` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipment_items`
--

LOCK TABLES `shipment_items` WRITE;
/*!40000 ALTER TABLE `shipment_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipment_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipments`
--

DROP TABLE IF EXISTS `shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(255) DEFAULT NULL,
  `total_qty` int(11) DEFAULT NULL,
  `total_weight` decimal(12,4) DEFAULT NULL,
  `carrier_code` varchar(255) DEFAULT NULL,
  `carrier_title` varchar(255) DEFAULT NULL,
  `track_number` text DEFAULT NULL,
  `email_sent` tinyint(1) NOT NULL DEFAULT 0,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `customer_type` varchar(255) DEFAULT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `order_address_id` int(10) unsigned DEFAULT NULL,
  `inventory_source_id` int(10) unsigned DEFAULT NULL,
  `inventory_source_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipments_order_id_foreign` (`order_id`),
  KEY `shipments_inventory_source_id_foreign` (`inventory_source_id`),
  CONSTRAINT `shipments_inventory_source_id_foreign` FOREIGN KEY (`inventory_source_id`) REFERENCES `inventory_sources` (`id`) ON DELETE SET NULL,
  CONSTRAINT `shipments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipments`
--

LOCK TABLES `shipments` WRITE;
/*!40000 ALTER TABLE `shipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sitemaps`
--

DROP TABLE IF EXISTS `sitemaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitemaps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `generated_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sitemaps`
--

LOCK TABLES `sitemaps` WRITE;
/*!40000 ALTER TABLE `sitemaps` DISABLE KEYS */;
/*!40000 ALTER TABLE `sitemaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscribers_list`
--

DROP TABLE IF EXISTS `subscribers_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscribers_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `is_subscribed` tinyint(1) NOT NULL DEFAULT 0,
  `token` varchar(255) DEFAULT NULL,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscribers_list_customer_id_foreign` (`customer_id`),
  KEY `subscribers_list_channel_id_foreign` (`channel_id`),
  CONSTRAINT `subscribers_list_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscribers_list_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscribers_list`
--

LOCK TABLES `subscribers_list` WRITE;
/*!40000 ALTER TABLE `subscribers_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscribers_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_categories`
--

DROP TABLE IF EXISTS `tax_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tax_categories_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_categories`
--

LOCK TABLES `tax_categories` WRITE;
/*!40000 ALTER TABLE `tax_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_categories_tax_rates`
--

DROP TABLE IF EXISTS `tax_categories_tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_categories_tax_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tax_category_id` int(10) unsigned NOT NULL,
  `tax_rate_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tax_map_index_unique` (`tax_category_id`,`tax_rate_id`),
  KEY `tax_categories_tax_rates_tax_rate_id_foreign` (`tax_rate_id`),
  CONSTRAINT `tax_categories_tax_rates_tax_category_id_foreign` FOREIGN KEY (`tax_category_id`) REFERENCES `tax_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tax_categories_tax_rates_tax_rate_id_foreign` FOREIGN KEY (`tax_rate_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_categories_tax_rates`
--

LOCK TABLES `tax_categories_tax_rates` WRITE;
/*!40000 ALTER TABLE `tax_categories_tax_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_categories_tax_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_rates`
--

DROP TABLE IF EXISTS `tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `is_zip` tinyint(1) NOT NULL DEFAULT 0,
  `zip_code` varchar(255) DEFAULT NULL,
  `zip_from` varchar(255) DEFAULT NULL,
  `zip_to` varchar(255) DEFAULT NULL,
  `state` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `tax_rate` decimal(12,4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tax_rates_identifier_unique` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_rates`
--

LOCK TABLES `tax_rates` WRITE;
/*!40000 ALTER TABLE `tax_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theme_customization_translations`
--

DROP TABLE IF EXISTS `theme_customization_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `theme_customization_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `theme_customization_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`options`)),
  PRIMARY KEY (`id`),
  KEY `theme_customization_id_foreign` (`theme_customization_id`),
  CONSTRAINT `theme_customization_id_foreign` FOREIGN KEY (`theme_customization_id`) REFERENCES `theme_customizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theme_customization_translations`
--

LOCK TABLES `theme_customization_translations` WRITE;
/*!40000 ALTER TABLE `theme_customization_translations` DISABLE KEYS */;
INSERT INTO `theme_customization_translations` VALUES (1,1,'en','{\"images\":[{\"image\":\"storage\\/theme\\/1\\/vkhgEQ5fQmLaKJmjyaKxB4shlpbrRm1Un6D0CCXp.webp\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/clothes\",\"title\":\"Home\"},{\"image\":\"storage\\/theme\\/1\\/dzAlZjOOkL1tbW5z9q3LYlqvbyR5c06UAtZLRphT.webp\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/clothes\",\"title\":\"Home2\"},{\"image\":\"storage\\/theme\\/1\\/74i3EIlFzJd0PNeHgOmZBGfGkova07iHFMJEPYFc.webp\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/shoes\",\"title\":\"Shoes\"},{\"image\":\"storage\\/theme\\/1\\/6YvtxLLemzjpx6B9fts8WBlHnIpGTmgIcK6Wjoqc.webp\",\"link\":\"http:\\/\\/127.0.0.1:8000\\/accessories\",\"title\":\"Accessories\"}]}'),(2,2,'en','{\"html\":\"<div class=\\\"home-offer\\\"><h1>Get UPTO 40% OFF on your 1st order SHOP NOW<\\/h1><\\/div>\",\"css\":\".home-offer h1 {display: block;font-weight: 500;text-align: center;font-size: 22px;font-family: DM Serif Display;background-color: #E8EDFE;padding-top: 20px;padding-bottom: 20px;}@media (max-width:768px){.home-offer h1 {font-size:18px;padding-top: 10px;padding-bottom: 10px;}@media (max-width:525px) {.home-offer h1 {font-size:14px;padding-top: 6px;padding-bottom: 6px;}}\"}'),(3,3,'en','{\"filters\":{\"parent_id\":1,\"sort\":\"asc\",\"limit\":10}}'),(4,4,'en','{\"title\":\"New Products\",\"filters\":{\"new\":1,\"sort\":\"name-asc\",\"limit\":12}}'),(5,5,'en','{\"html\":\"<div class=\\\"top-collection-container\\\">\\r\\n    <div class=\\\"top-collection-header\\\">\\r\\n         <h2>The game with our new additions!<\\/h2>\\r\\n\\r\\n    <\\/div>\\r\\n    <div class=\\\"top-collection-grid container\\\">\\r\\n      <div class=\\\"top-collection-card\\\">\\r\\n            <img src=\\\"\\\" data-src=\\\"storage\\/theme\\/5\\/IMG-20251029-WA0007.jpg\\\" class=\\\"lazy\\\" width=\\\"396\\\" height=\\\"396\\\" alt=\\\"The game with our new additions!\\\">\\r\\n             <h3>Our Collections<\\/h3>\\r\\n\\r\\n        <\\/div>\\r\\n      <div class=\\\"top-collection-card\\\">\\r\\n            <img src=\\\"\\\" data-src=\\\"storage\\/theme\\/5\\/IMG-20251029-WA0002.jpg\\\" class=\\\"lazy\\\" width=\\\"396\\\" height=\\\"396\\\" alt=\\\"The game with our new additions!\\\">\\r\\n             <h3>Our Collections<\\/h3>\\r\\n\\r\\n        <\\/div>\\r\\n      <div class=\\\"top-collection-card\\\">\\r\\n            <img src=\\\"\\\" data-src=\\\"storage\\/theme\\/5\\/IMG-20251029-WA0004.jpg\\\" class=\\\"lazy\\\" width=\\\"396\\\" height=\\\"396\\\" alt=\\\"The game with our new additions!\\\">\\r\\n             <h3>Our Collections<\\/h3>\\r\\n\\r\\n        <\\/div>\\r\\n      <div class=\\\"top-collection-card\\\">\\r\\n            <img src=\\\"\\\" data-src=\\\"storage\\/theme\\/5\\/IMG-20251029-WA0012.jpg\\\" class=\\\"lazy\\\" width=\\\"396\\\" height=\\\"396\\\" alt=\\\"The game with our new additions!\\\">\\r\\n             <h3>Our Collections<\\/h3>\\r\\n\\r\\n        <\\/div>\\r\\n      <div class=\\\"top-collection-card\\\">\\r\\n            <img src=\\\"\\\" data-src=\\\"storage\\/theme\\/5\\/IMG-20251029-WA0013.jpg\\\" class=\\\"lazy\\\" width=\\\"396\\\" height=\\\"396\\\" alt=\\\"The game with our new additions!\\\">\\r\\n             <h3>Our Collections<\\/h3>\\r\\n\\r\\n        <\\/div>\\r\\n      <div class=\\\"top-collection-card\\\">\\r\\n            <img src=\\\"\\\" data-src=\\\"storage\\/theme\\/5\\/IMG-20251029-WA0015.jpg\\\" class=\\\"lazy\\\" width=\\\"396\\\" height=\\\"396\\\" alt=\\\"The game with our new additions!\\\">\\r\\n             <h3>Our Collections<\\/h3>\\r\\n\\r\\n        <\\/div>\\r\\n      <div class=\\\"top-collection-card\\\">\\r\\n            <img src=\\\"\\\" data-src=\\\"storage\\/theme\\/5\\/IMG-20251029-WA0002.jpg\\\" class=\\\"lazy\\\" width=\\\"396\\\" height=\\\"396\\\" alt=\\\"The game with our new additions!\\\">\\r\\n             <h3>Our Collections<\\/h3>\\r\\n\\r\\n        <\\/div>\\r\\n    <\\/div>\\r\\n<\\/div>\",\"css\":\".top-collection-container {overflow: hidden;}.top-collection-header {padding-left: 15px;padding-right: 15px;text-align: center;font-size: 70px;line-height: 90px;color: #060C3B;margin-top: 80px;}.top-collection-header h2 {max-width: 595px;margin-left: auto;margin-right: auto;font-family: DM Serif Display;}.top-collection-grid {display: flex;flex-wrap: wrap;gap: 32px;justify-content: center;margin-top: 60px;width: 100%;margin-right: auto;margin-left: auto;padding-right: 90px;padding-left: 90px;}.top-collection-card {position: relative;background: #f9fafb;overflow:hidden;border-radius:20px;}.top-collection-card img {border-radius: 16px;max-width: 100%;text-indent:-9999px;transition: transform 300ms ease;transform: scale(1);}.top-collection-card:hover img {transform: scale(1.05);transition: all 300ms ease;}.top-collection-card h3 {color: #060C3B;font-size: 30px;font-family: DM Serif Display;transform: translateX(-50%);width: max-content;left: 50%;bottom: 30px;position: absolute;margin: 0;font-weight: inherit;}@media not all and (min-width: 525px) {.top-collection-header {margin-top: 28px;font-size: 20px;line-height: 1.5;}.top-collection-grid {gap: 10px}}@media not all and (min-width: 768px) {.top-collection-header {margin-top: 30px;font-size: 28px;line-height: 3;}.top-collection-header h2 {line-height:2; margin-bottom:20px;} .top-collection-grid {gap: 14px}} @media not all and (min-width: 1024px) {.top-collection-grid {padding-left: 30px;padding-right: 30px;}}@media (max-width: 768px) {.top-collection-grid { row-gap:15px; column-gap:0px;justify-content: space-between;margin-top: 0px;} .top-collection-card{width:48%} .top-collection-card img {width:100%;} .top-collection-card h3 {font-size:24px; bottom: 16px;}}@media (max-width:520px) { .top-collection-grid{padding-left: 15px;padding-right: 15px;} .top-collection-card h3 {font-size:18px; bottom: 10px;}}\"}'),(6,6,'en','{\"html\":\"<div class=\\\"section-gap bold-collections container\\\">\\r\\n    <div class=\\\"inline-col-wrapper\\\">\\r\\n        <div class=\\\"inline-col-image-wrapper\\\">\\r\\n            <img src=\\\"\\\" data-src=\\\"storage\\/theme\\/6\\/IMG-20251029-WA0012.jpg\\\" class=\\\"lazy\\\" width=\\\"632\\\" height=\\\"510\\\" alt=\\\"Get Ready for our new Bold Collections!\\\">\\r\\n        <\\/div>\\r\\n        <div class=\\\"inline-col-content-wrapper\\\">\\r\\n             <h2 class=\\\"inline-col-title\\\"> Get Ready for our new Bold Collections! <\\/h2> \\r\\n            <p class=\\\"inline-col-description\\\">Introducing Our New Bold Collections! Elevate your style with daring designs and vibrant statements. Explore striking patterns and bold colors that redefine your wardrobe. Get ready to embrace the extraordinary!<\\/p>\\r\\n            <button class=\\\"primary-button max-md:rounded-lg max-md:px-4 max-md:py-2.5 max-md:text-sm\\\">\\r\\n          \\t\\t<a href=\\\"{{ url(\'\\/clothes\') }}\\\"\\r\\n                   class=\\\"primary-button max-md:rounded-lg max-md:px-4 max-md:py-2.5 max-md:text-sm\\\">\\r\\n                   View Collections\\r\\n                <\\/a>\\r\\n          <\\/button>\\r\\n        <\\/div>\\r\\n    <\\/div>\\r\\n<\\/div>\",\"css\":\".section-gap{margin-top:80px}.direction-ltr{direction:ltr}.direction-rtl{direction:rtl}.inline-col-wrapper{display:grid;grid-template-columns:auto 1fr;grid-gap:60px;align-items:center}.inline-col-wrapper .inline-col-image-wrapper{overflow:hidden}.inline-col-wrapper .inline-col-image-wrapper img{max-width:100%;height:auto;border-radius:16px;text-indent:-9999px}.inline-col-wrapper .inline-col-content-wrapper{display:flex;flex-wrap:wrap;gap:20px;max-width:464px}.inline-col-wrapper .inline-col-content-wrapper .inline-col-title{max-width:442px;font-size:60px;font-weight:400;color:#060c3b;line-height:70px;font-family:DM Serif Display;margin:0}.inline-col-wrapper .inline-col-content-wrapper .inline-col-description{margin:0;font-size:18px;color:#6e6e6e;font-family:Poppins}@media (max-width:991px){.inline-col-wrapper{grid-template-columns:1fr;grid-gap:16px}.inline-col-wrapper .inline-col-content-wrapper{gap:10px}} @media (max-width:768px){.inline-col-wrapper .inline-col-image-wrapper img {width:100%;} .inline-col-wrapper .inline-col-content-wrapper .inline-col-title{font-size:28px !important;line-height:normal !important}} @media (max-width:525px){.inline-col-wrapper .inline-col-content-wrapper .inline-col-title{font-size:20px !important;} .inline-col-description{font-size:16px} .inline-col-wrapper{grid-gap:10px}}\"}'),(7,7,'en','{\"title\":\"FTop Selling Products\",\"filters\":{\"sort\":\"name-desc\",\"limit\":\"12\",\"featured\":\"1\"}}'),(8,8,'en','{\"html\":\"<div class=\\\"section-game\\\">\\r\\n    <div class=\\\"section-title\\\">\\r\\n         <h2>The game with our new additions!<\\/h2> \\r\\n    <\\/div>\\r\\n    <div class=\\\"section-gap container\\\">\\r\\n        <div class=\\\"collection-card-wrapper\\\">\\r\\n            <div class=\\\"single-collection-card\\\">\\r\\n                <img src=\\\"\\\" data-src=\\\"storage\\/theme\\/8\\/IMG-20251029-WA0007.jpg\\\" class=\\\"lazy\\\" width=\\\"615\\\" height=\\\"600\\\" alt=\\\"The game with our new additions!\\\">\\r\\n                 <h3 class=\\\"overlay-text\\\">Our Collections<\\/h3> \\r\\n            <\\/div>\\r\\n            <div class=\\\"single-collection-card\\\">\\r\\n                <img src=\\\"\\\" data-src=\\\"storage\\/theme\\/8\\/IMG-20251029-WA0012.jpg\\\" class=\\\"lazy\\\" width=\\\"615\\\" height=\\\"600\\\" alt=\\\"The game with our new additions!\\\">\\r\\n                 <h3 class=\\\"overlay-text\\\"> Our Collections <\\/h3> \\r\\n            <\\/div>\\r\\n          <div class=\\\"single-collection-card\\\">\\r\\n                <img src=\\\"\\\" data-src=\\\"storage\\/theme\\/8\\/IMG-20251029-WA0013.jpg\\\" class=\\\"lazy\\\" width=\\\"615\\\" height=\\\"600\\\" alt=\\\"The game with our new additions!\\\">\\r\\n                 <h3 class=\\\"overlay-text\\\"> Our Collections <\\/h3> \\r\\n            <\\/div>\\r\\n        <\\/div>\\r\\n    <\\/div>\\r\\n<\\/div>\",\"css\":\".section-game {overflow: hidden;}.section-title,.section-title h2{font-weight:400;font-family:DM Serif Display}.section-title{margin-top:80px;padding-left:15px;padding-right:15px;text-align:center;line-height:90px}.section-title h2{font-size:70px;color:#060c3b;max-width:595px;margin:auto}.collection-card-wrapper{display:flex;flex-wrap:wrap;justify-content:center;gap:30px}.collection-card-wrapper .single-collection-card{position:relative}.collection-card-wrapper .single-collection-card img{border-radius:16px;background-color:#f5f5f5;max-width:100%;height:auto;text-indent:-9999px}.collection-card-wrapper .single-collection-card .overlay-text{font-size:50px;font-weight:400;max-width:234px;font-style:italic;color:#060c3b;font-family:DM Serif Display;position:absolute;bottom:30px;left:30px;margin:0}@media (max-width:1024px){.section-title{padding:0 30px}}@media (max-width:991px){.collection-card-wrapper{flex-wrap:wrap}}@media (max-width:768px) {.collection-card-wrapper .single-collection-card .overlay-text{font-size:32px; bottom:20px}.section-title{margin-top:32px}.section-title h2{font-size:28px;line-height:normal}} @media (max-width:525px){.collection-card-wrapper .single-collection-card .overlay-text{font-size:18px; bottom:10px} .section-title{margin-top:28px}.section-title h2{font-size:20px;} .collection-card-wrapper{gap:10px; 15px; row-gap:15px; column-gap:0px;justify-content: space-between;margin-top: 15px;} .collection-card-wrapper .single-collection-card {width:48%;}}\"}'),(9,9,'en','{\"title\":\"All Products\",\"filters\":{\"sort\":\"name-desc\",\"limit\":12}}'),(10,10,'en','{\"html\":\"<div class=\\\"section-gap bold-collections container\\\">\\r\\n    <div class=\\\"inline-col-wrapper direction-rtl\\\">\\r\\n        <div class=\\\"inline-col-image-wrapper\\\">\\r\\n            <img src=\\\"\\\" data-src=\\\"storage\\/theme\\/10\\/IMG-20251029-WA0010.jpg\\\" class=\\\"lazy\\\" width=\\\"632\\\" height=\\\"510\\\" alt=\\\"Get Ready for our new Bold Collections!\\\">\\r\\n        <\\/div>\\r\\n        <div class=\\\"inline-col-content-wrapper direction-ltr\\\">\\r\\n             <h2 class=\\\"inline-col-title\\\"> Get Ready for our new Bold Collections! <\\/h2> \\r\\n            <p class=\\\"inline-col-description\\\">Introducing Our New Bold Collections! Elevate your style with daring designs and vibrant statements. Explore striking patterns and bold colors that redefine your wardrobe. Get ready to embrace the extraordinary!<\\/p>\\r\\n            <button class=\\\"primary-button max-md:rounded-lg max-md:px-4 max-md:py-2.5 max-md:text-sm\\\">\\r\\n            <a href=\\\"{{ url(\'\\/shoes\') }}\\\"\\r\\n               class=\\\"primary-button max-md:rounded-lg max-md:px-4 max-md:py-2.5 max-md:text-sm\\\">\\r\\n               View Collections\\r\\n           <\\/a>\\t\\t\\r\\n          <\\/button>\\r\\n        <\\/div>\\r\\n    <\\/div>\\r\\n<\\/div>\",\"css\":\".section-gap{margin-top:80px}.direction-ltr{direction:ltr}.direction-rtl{direction:rtl}.inline-col-wrapper{display:grid;grid-template-columns:auto 1fr;grid-gap:60px;align-items:center}.inline-col-wrapper .inline-col-image-wrapper{overflow:hidden}.inline-col-wrapper .inline-col-image-wrapper img{max-width:100%;height:auto;border-radius:16px;text-indent:-9999px}.inline-col-wrapper .inline-col-content-wrapper{display:flex;flex-wrap:wrap;gap:20px;max-width:464px}.inline-col-wrapper .inline-col-content-wrapper .inline-col-title{max-width:442px;font-size:60px;font-weight:400;color:#060c3b;line-height:70px;font-family:DM Serif Display;margin:0}.inline-col-wrapper .inline-col-content-wrapper .inline-col-description{margin:0;font-size:18px;color:#6e6e6e;font-family:Poppins}@media (max-width:991px){.inline-col-wrapper{grid-template-columns:1fr;grid-gap:16px}.inline-col-wrapper .inline-col-content-wrapper{gap:10px}}@media (max-width:768px) {.inline-col-wrapper .inline-col-image-wrapper img {max-width:100%;}.inline-col-wrapper .inline-col-content-wrapper{max-width:100%;justify-content:center; text-align:center} .section-gap{padding:0 30px; gap:20px;margin-top:24px} .bold-collections{margin-top:32px;}} @media (max-width:525px){.inline-col-wrapper .inline-col-content-wrapper{gap:10px} .inline-col-wrapper .inline-col-content-wrapper .inline-col-title{font-size:20px;line-height:normal} .section-gap{padding:0 15px; gap:15px;margin-top:10px} .bold-collections{margin-top:28px;}  .inline-col-description{font-size:16px !important} .inline-col-wrapper{grid-gap:15px}\"}'),(11,11,'en','{\"column_1\":[{\"url\":\"http:\\/\\/localhost\\/army-mart\\/public\\/about-us\",\"title\":\"About Us\",\"sort_order\":\"1\"},{\"url\":\"http:\\/\\/localhost\\/army-mart\\/public\\/contact-us\",\"title\":\"Contact Us\",\"sort_order\":\"2\"},{\"url\":\"http:\\/\\/localhost\\/army-mart\\/public\\/customer-service\",\"title\":\"Customer Service\",\"sort_order\":\"3\"},{\"url\":\"http:\\/\\/localhost\\/army-mart\\/public\\/whats-new\",\"title\":\"What\'s New\",\"sort_order\":\"4\"},{\"url\":\"http:\\/\\/localhost\\/army-mart\\/public\\/terms-of-use\",\"title\":\"Terms of Use\",\"sort_order\":\"5\"},{\"url\":\"http:\\/\\/localhost\\/army-mart\\/public\\/terms-conditions\",\"title\":\"Terms & Conditions\",\"sort_order\":\"6\"}],\"column_2\":[{\"url\":\"http:\\/\\/localhost\\/army-mart\\/public\\/privacy-policy\",\"title\":\"Privacy Policy\",\"sort_order\":\"1\"},{\"url\":\"http:\\/\\/localhost\\/army-mart\\/public\\/payment-policy\",\"title\":\"Payment Policy\",\"sort_order\":\"2\"},{\"url\":\"http:\\/\\/localhost\\/army-mart\\/public\\/page\\/shipping-policy\",\"title\":\"Shipping Policy\",\"sort_order\":\"3\"},{\"url\":\"http:\\/\\/localhost\\/army-mart\\/public\\/page\\/refund-policy\",\"title\":\"Refund Policy\",\"sort_order\":\"4\"},{\"url\":\"http:\\/\\/localhost\\/army-mart\\/public\\/page\\/return-policy\",\"title\":\"Return Policy\",\"sort_order\":\"5\"}]}'),(12,12,'en','{\"services\":[{\"title\":\"Free Shipping\",\"description\":\"Enjoy free shipping on all orders\",\"service_icon\":\"icon-truck\"},{\"title\":\"Product Replace\",\"description\":\"Easy Product Replacement Available!\",\"service_icon\":\"icon-product\"},{\"title\":\"Emi Available\",\"description\":\"No cost EMI available on all major credit cards\",\"service_icon\":\"icon-dollar-sign\"},{\"title\":\"24\\/7 Support\",\"description\":\"Dedicated 24\\/7 support via chat and email\",\"service_icon\":\"icon-support\"}]}');
/*!40000 ALTER TABLE `theme_customization_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theme_customizations`
--

DROP TABLE IF EXISTS `theme_customizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `theme_customizations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `theme_code` varchar(255) DEFAULT 'default',
  `type` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `channel_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `theme_customizations_channel_id_foreign` (`channel_id`),
  CONSTRAINT `theme_customizations_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theme_customizations`
--

LOCK TABLES `theme_customizations` WRITE;
/*!40000 ALTER TABLE `theme_customizations` DISABLE KEYS */;
INSERT INTO `theme_customizations` VALUES (1,'default','image_carousel','Image Carousel',1,1,1,'2025-11-04 01:10:09','2025-11-04 09:41:31'),(2,'default','static_content','Offer Information',2,1,1,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(3,'default','category_carousel','Categories Collections',3,1,1,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(4,'default','product_carousel','New Products',4,1,1,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(5,'default','static_content','Top Collections',5,1,1,'2025-11-04 01:10:09','2025-11-04 09:48:17'),(6,'default','static_content','Bold Collections',6,1,1,'2025-11-04 01:10:09','2025-11-04 10:06:37'),(7,'default','product_carousel','Featured Collections',7,1,1,'2025-11-04 01:10:09','2025-11-04 09:58:39'),(8,'default','static_content','Game Container',8,1,1,'2025-11-04 01:10:09','2025-11-04 10:00:00'),(9,'default','product_carousel','All Products',9,1,1,'2025-11-04 01:10:09','2025-11-04 01:10:09'),(10,'default','static_content','Bold Collections',10,1,1,'2025-11-04 01:10:09','2025-11-04 10:10:06'),(11,'default','footer_links','Footer Links',11,1,1,'2025-11-04 01:10:09','2025-11-04 10:30:31'),(12,'default','services_content','Services Content',12,1,1,'2025-11-04 01:10:09','2025-11-04 01:10:09');
/*!40000 ALTER TABLE `theme_customizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_rewrites`
--

DROP TABLE IF EXISTS `url_rewrites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_rewrites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(255) NOT NULL,
  `request_path` varchar(255) NOT NULL,
  `target_path` varchar(255) NOT NULL,
  `redirect_type` varchar(255) DEFAULT NULL,
  `locale` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_rewrites`
--

LOCK TABLES `url_rewrites` WRITE;
/*!40000 ALTER TABLE `url_rewrites` DISABLE KEYS */;
/*!40000 ALTER TABLE `url_rewrites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visits`
--

DROP TABLE IF EXISTS `visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visits` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `method` varchar(255) DEFAULT NULL,
  `request` mediumtext DEFAULT NULL,
  `url` mediumtext DEFAULT NULL,
  `referer` mediumtext DEFAULT NULL,
  `languages` text DEFAULT NULL,
  `useragent` text DEFAULT NULL,
  `headers` text DEFAULT NULL,
  `device` text DEFAULT NULL,
  `platform` text DEFAULT NULL,
  `browser` text DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `visitable_type` varchar(255) DEFAULT NULL,
  `visitable_id` bigint(20) unsigned DEFAULT NULL,
  `visitor_type` varchar(255) DEFAULT NULL,
  `visitor_id` bigint(20) unsigned DEFAULT NULL,
  `channel_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `visits_visitable_type_visitable_id_index` (`visitable_type`,`visitable_id`),
  KEY `visits_visitor_type_visitor_id_index` (`visitor_type`,`visitor_id`),
  KEY `visits_channel_id_foreign` (`channel_id`),
  CONSTRAINT `visits_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visits`
--

LOCK TABLES `visits` WRITE;
/*!40000 ALTER TABLE `visits` DISABLE KEYS */;
INSERT INTO `visits` VALUES (1,'GET','[]','http://127.0.0.1:8000',NULL,'[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"none\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-user\":[\"?1\"],\"sec-fetch-dest\":[\"document\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 01:12:13','2025-11-04 01:12:13'),(2,'GET','[]','http://127.0.0.1:8000/shoes','http://127.0.0.1:8000/','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-purpose\":[\"prefetch;prerender\"],\"sec-speculation-tags\":[\"null\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-dest\":[\"document\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IndTTys3ZjNpdFN1SVhSS3VFOG40YlE9PSIsInZhbHVlIjoiU2NqV1E2aXpWV0ZXcERlZlRFODhMdFlCME0raEtVcjUxV1NTOEw3anJudDV2dTlLdTJ3V3Q2ODNnQk9VNG0yUDRablZOMkxHbFZaZzk1ZVAwZGpaMUVKMmJCa2R0M2lKdFNnRjJtNlBuNlkxdkNnVTZmalZ4Q3RUdXg4ZlY5VGwiLCJtYWMiOiIxNTMxMTYzMzQ3NmZkMTAzYWM3ODdkZDFkMDQyYWI4MTE3N2JmZGI1ODRkNTJkNzA3MWIxYTk1OGEyNDVlNWRhIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6Ik04aUZvSTAvQUtXZWVyUC8rSnpyTEE9PSIsInZhbHVlIjoiRi9hbHhtTm04b05RQ1VOczQ5TEFWNjFCYXU2SWsyMTc0anFvU0FzV2VOVG5nVkgxK1NVU1ZIcjBNSEJDb3VNWEN2Q3VDd2w0MGNOYmxjSE5FSy9WamJ2SklpMHprWDhwdkZTT0g2alNZeElvYXVVS2lYTWVtL2tDcTVsWXBTWDYiLCJtYWMiOiI0NzE5ZTU3MzUwNDUyODI0ZmI2ZWIxNjg0N2ZkMGNjZDBlM2UwZDIzOThlYmVlNWYzZDExMWI3YWUzZDllMDVmIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1','Webkul\\Category\\Models\\Category',3,NULL,NULL,1,'2025-11-04 09:37:25','2025-11-04 09:37:25'),(3,'GET','[]','http://127.0.0.1:8000/clothes','http://127.0.0.1:8000/','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-purpose\":[\"prefetch;prerender\"],\"sec-speculation-tags\":[\"null\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-dest\":[\"document\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6ImtiYkVhNkZKMDJ6Qy9LQm8yVmlXMEE9PSIsInZhbHVlIjoiZVJrTzk4VE1xdHpmUERnZmJ6RTFzVDZYd2orREtuRnpHTFh6akt5ZjJRVm1NR0t3OUNlc0VXZ0cwc0xnVmpNNC9IN1hPcWZUTVB0bTdsQkJNQStDeHQ1NUJzS0VCRW4rMm9MWU81YVVBWUlSb1VJQm05VE40YTdQLytOVTVFTzYiLCJtYWMiOiI4NGJlYWJmNTU0ZGQ3MTE4YjUyMTBjODNmMzg4ODEzZmRlMzhkYzFkMzg2M2Q2NzBjNjM1MTJkNWE5ZDRiODI1IiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6ImVJaHMwT09IeUg5cHZQbVdsYjNUZ3c9PSIsInZhbHVlIjoibjExTjdOUEwvdFhJNzdHSGFzSmd1UW5iLzViZmFQdFEvTFdWWU00TTRDSjFGNEtyajFMbW5TLytLMkUyL3dwQUpqcVJNQzZ4L0FxM0V5enI1cGllZ1NaMWtzUGk0dkc1OGlINDFLTUVha2Nld05UeWRpYTBLVkpwNWtaMjUxVDMiLCJtYWMiOiJmN2Y1MDEzNmIyY2IwYmI0ZTA0ZGI0N2U2ZDQ3MzYwMDE3MDAyYmMzMGVjNWI0YzE2NzAxNmVhZGQ1YjM0ZDc1IiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1','Webkul\\Category\\Models\\Category',2,NULL,NULL,1,'2025-11-04 09:37:29','2025-11-04 09:37:29'),(4,'GET','[]','http://127.0.0.1:8000/accessories','http://127.0.0.1:8000/','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-purpose\":[\"prefetch;prerender\"],\"sec-speculation-tags\":[\"null\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-dest\":[\"document\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IjR6NGQ2NGFpVmJ2amt1U1NycU40Znc9PSIsInZhbHVlIjoiK3pUTWhuMWNyUmJ2OWQ2bThpbHgxMlBsbnQybG9tZFpLaDJIdGFCMHZuKzZKVG5KTzNlZ0NlYUpVZkkzVDRJekNQUGZCamxkby8xUVhKQ1ljTjRPR2JpSnBQdlhhSjkwcWtXMGx1bjBGVUx0cnVGSVJURFBEb3Y5MVk3QVducGkiLCJtYWMiOiIxMjZiM2I0MjVmMGVlZDllODQ5NjBkYTkxZjg4M2RiZjllOTFlMTk4Njg0ZGJmNmUxZTU1Y2U4YjY0NzgzYjNlIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IkVCb1FyanBzbWg5UVFqckF2cDV4V0E9PSIsInZhbHVlIjoiekRhQjM1OXlxVWxncW5JU2UyTkEveXJ1VXNXdGtXNG00Zlo5SE92TGF3YU5MeXBGRlZTdzNTZHpvQ045bk1ITU9tRzdFejU1VDVHQllwUTYyUlhPeVhKT3d3bnNFbVUyMjBaM3NRam9UWGFPbEVlL2Z5cTBTN0pGNkVQMGZHSnQiLCJtYWMiOiIxOGY2ODAyYzg5YWYxM2VlZmJmMTJlOTFhMGRmMjM0ZWEzOWMwOGE5NjQyZDkyNjE0Y2RlMjlhZDc3ZGRhZjJmIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1','Webkul\\Category\\Models\\Category',4,NULL,NULL,1,'2025-11-04 09:37:31','2025-11-04 09:37:31'),(5,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','http://127.0.0.1:8000/','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-purpose\":[\"prefetch;prerender\"],\"sec-speculation-tags\":[\"null\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-dest\":[\"document\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IjRDWmdwaSsrMmhGRlA1bXIxaWJtZmc9PSIsInZhbHVlIjoiSGdUV3pmTHN4M0lYZlAvbEgxWDBZb2grc2MzMUFydlZnSjc5bjlYZHkyOVp0WHV3S1NEemg5NmFEck0xL3YyODloTitLZWdYczA3TUdhdW5FUERCemFhOEFFN2JIaGRmNzQvdHZLVGhHMmx4SmFLSkRteVlXamZNVEtzaDg4Y0kiLCJtYWMiOiIxMTgyZTdiYzE3MmExMGZmYWE5ODZhNmE2ZDg0MjVkODY1NTlhZWIwOWYyZmM3MTY1Mzc1NzMwZGRiMGE5MDNmIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6ImN4eUFITjVVT2NidlI3ci85azh2bFE9PSIsInZhbHVlIjoiOFgrdFBUWDhsZlVYSHdXaVh1MVlmejk5MVlrK09DUnNNblcrbHRpd1psN0xBWnpTRENwVlJIZEh5alZOT3dnUXhzS0VUcWtGYktXdGc5VEloSmpMdjVFVncyMWlzZGZ0Q1RtcTFxeHE2NDBjZW1NNGRZZUluSW5XUzF6ZmpGeUkiLCJtYWMiOiJhN2JkOTE4ZjkzNGFhMTYxZDlhNTA2Y2FhOGM4NmRkMDBmZmMyZjJiZDIxZTE1MDBkOGJmNTI1NGQzMGI0ODFjIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:07','2025-11-04 10:07:07'),(6,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/storage/theme/1/vkhgEQ5fQmLaKJmjyaKxB4shlpbrRm1Un6D0CCXp.webp','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-purpose\":[\"prefetch;prerender\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IkFEaVBPeUlVWFhXVGE4b01Xb1QwSGc9PSIsInZhbHVlIjoiZmVKUEhLcVU0cnFWM0NCSldEMWIyQzJxZEhWSW9MRDFLUG5OVzlaOUE1a0VuQWdWdE4reHE2bkxMTXNvQ3lGK0lhc1g5eEkrRm52QVBteU41ZkREUDZOY2dhaFhFZUtoZUVDeHJzSkFFSyt2bWVqcStuNDJ0d2VFaUNvOTJmNDEiLCJtYWMiOiJjN2M1N2ZkMThkNWJiMjkwYWYxMTg5NDE5MWE4NjkyNzgwMjUwOGI5ZDdjNzI3N2U4Y2MxOTg4OGE0YzlhNjE5IiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6Ik5wK2dtcHVXWEVRTE55V2dic0krS0E9PSIsInZhbHVlIjoibTlsdmhNTGx3WVVna3Yva2dpUHBOYW43MEpZM0lKNjNWSlBEYSsrZVBucmNPQjQrNXcyRVhaTEdSVHY5NXJPcTNhMWdFTWQvL0FiV0ttUWd2cDYyMkQvR3dLY2lxVGw0N0lBZHFXV3AxcTNRcFVrQWU3clNqRTY3MjZoQ3VsdUwiLCJtYWMiOiJmY2Q1MzhkZGJmNzBmZTBkZGRkZWZkNzViOTc5OWM3OGJhZjgyMTU5MGQ2NWFlMmNkNTUyZmEzNDUxMDRiMmY0IiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:13','2025-11-04 10:07:13'),(7,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/storage/theme/1/dzAlZjOOkL1tbW5z9q3LYlqvbyR5c06UAtZLRphT.webp','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IkVpZCtJOUtoc0dFMlFxeWJOTzRWQ0E9PSIsInZhbHVlIjoiQmdYdU9oc2xVdmh4c2dPWjQrMUdRNmt3NjRpYzZFcER5aktQSEhnaVJ4bjlCY1NQUm9zdWhFcUN4cWZTZ1h1b2tvUVZPVFVtdlZHQjVFUmRKQjJObWxuT3pNdnJTOXF3eUtpR3dTdW9tbXZ5ajJXVjgzaHNtejVuZkJtMWg5TDAiLCJtYWMiOiI0ZGNhNWQ0NDc5YWM5YjBjZmI3NTY3NDZlZTUwM2RjMzE4MjIzNTE5NGI5Y2NjZmJjOTFhZTlkYzI0OWZjMGNlIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IlFhWHFVSkdYQ3FJTXhTTmNFQ2Z4b1E9PSIsInZhbHVlIjoiWXVOdXZmalZIdVVTMzJhc3EzU2VFK21yVVg0Z3pYT1FIdllNNDladWhJRTArSDlxMitMRWdkMlllaEpkd1VHRzhWbEZGTmozRGg1S29WYXlSN2dKam9PZmhKM003dEZuUllZRmZ3M3pEdnVXWU1UYVdta1Q3NFNrYWM4OFRGRmsiLCJtYWMiOiI5MjgwNTY1MmNjY2U3ZThjN2Q2ZjljNjMyNDhlNTQyMGRjODMwY2M4YzM0MWE3Nzg1YWQ1MTAwN2Q2OTdiMzBiIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:15','2025-11-04 10:07:15'),(8,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/storage/theme/1/74i3EIlFzJd0PNeHgOmZBGfGkova07iHFMJEPYFc.webp','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IkVpZCtJOUtoc0dFMlFxeWJOTzRWQ0E9PSIsInZhbHVlIjoiQmdYdU9oc2xVdmh4c2dPWjQrMUdRNmt3NjRpYzZFcER5aktQSEhnaVJ4bjlCY1NQUm9zdWhFcUN4cWZTZ1h1b2tvUVZPVFVtdlZHQjVFUmRKQjJObWxuT3pNdnJTOXF3eUtpR3dTdW9tbXZ5ajJXVjgzaHNtejVuZkJtMWg5TDAiLCJtYWMiOiI0ZGNhNWQ0NDc5YWM5YjBjZmI3NTY3NDZlZTUwM2RjMzE4MjIzNTE5NGI5Y2NjZmJjOTFhZTlkYzI0OWZjMGNlIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IlFhWHFVSkdYQ3FJTXhTTmNFQ2Z4b1E9PSIsInZhbHVlIjoiWXVOdXZmalZIdVVTMzJhc3EzU2VFK21yVVg0Z3pYT1FIdllNNDladWhJRTArSDlxMitMRWdkMlllaEpkd1VHRzhWbEZGTmozRGg1S29WYXlSN2dKam9PZmhKM003dEZuUllZRmZ3M3pEdnVXWU1UYVdta1Q3NFNrYWM4OFRGRmsiLCJtYWMiOiI5MjgwNTY1MmNjY2U3ZThjN2Q2ZjljNjMyNDhlNTQyMGRjODMwY2M4YzM0MWE3Nzg1YWQ1MTAwN2Q2OTdiMzBiIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:16','2025-11-04 10:07:16'),(9,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/storage/theme/1/6YvtxLLemzjpx6B9fts8WBlHnIpGTmgIcK6Wjoqc.webp','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IkVpZCtJOUtoc0dFMlFxeWJOTzRWQ0E9PSIsInZhbHVlIjoiQmdYdU9oc2xVdmh4c2dPWjQrMUdRNmt3NjRpYzZFcER5aktQSEhnaVJ4bjlCY1NQUm9zdWhFcUN4cWZTZ1h1b2tvUVZPVFVtdlZHQjVFUmRKQjJObWxuT3pNdnJTOXF3eUtpR3dTdW9tbXZ5ajJXVjgzaHNtejVuZkJtMWg5TDAiLCJtYWMiOiI0ZGNhNWQ0NDc5YWM5YjBjZmI3NTY3NDZlZTUwM2RjMzE4MjIzNTE5NGI5Y2NjZmJjOTFhZTlkYzI0OWZjMGNlIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IlFhWHFVSkdYQ3FJTXhTTmNFQ2Z4b1E9PSIsInZhbHVlIjoiWXVOdXZmalZIdVVTMzJhc3EzU2VFK21yVVg0Z3pYT1FIdllNNDladWhJRTArSDlxMitMRWdkMlllaEpkd1VHRzhWbEZGTmozRGg1S29WYXlSN2dKam9PZmhKM003dEZuUllZRmZ3M3pEdnVXWU1UYVdta1Q3NFNrYWM4OFRGRmsiLCJtYWMiOiI5MjgwNTY1MmNjY2U3ZThjN2Q2ZjljNjMyNDhlNTQyMGRjODMwY2M4YzM0MWE3Nzg1YWQ1MTAwN2Q2OTdiMzBiIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:18','2025-11-04 10:07:18'),(10,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/storage/theme/5/IMG-20251029-WA0007.jpg','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IlpPcU9MMjF5cXgxWGU2dzdwV3hsMkE9PSIsInZhbHVlIjoiMGRVTFZZT2VLbVFPSkVEdC9ieU9ibWhGZm05K3NvenJyaEN0NnNaSklTSDJaVVJOQ083UWdIajIzcmdFUGdhd0RzcXdMYTJrSWxqaWpmMDgvTGozelB6eXllT1dicHc2TVdyeFFhWCt3OGZZNnRCRXVnMGxjaVZIZFlXaE1SeloiLCJtYWMiOiJjZWYyMzMzZTE3Y2VhNDI1MTI2M2NhOWRmOGI2ZGJlOGQ4NzYyYjQ3MTI0YWYwZGNkNjU2MGFiNjgxZWQ1OGVkIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IkxXRW5sd1FqNUxjTFZRZkxacUxuWWc9PSIsInZhbHVlIjoiQUhlOHNad09wTEY0RDFSbXNMSXBnaFFqTXNxUXZPSTF3K1l4eE81SWlVcmxRaUY0WnB6WDZkbjk4bWg2cWV0UE43d2Z6cVlrd2FKZHlsR0dWRmFoQ3h6VjRONjJRM1ViRlJKN1p4ODFPbC84Q0tiZnlhM0cvR3daQ1E4WG0rSzgiLCJtYWMiOiIyM2I4ZTUzOTMxYmQzNDIwZWY5YjVjMTM4YWJmYWUzYzVmZmUxOWZiZGE2ZTYwZDhlZTAxZThkZTE0NzJmNDM4IiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:25','2025-11-04 10:07:25'),(11,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/storage/theme/5/IMG-20251029-WA0002.jpg','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IlpPcU9MMjF5cXgxWGU2dzdwV3hsMkE9PSIsInZhbHVlIjoiMGRVTFZZT2VLbVFPSkVEdC9ieU9ibWhGZm05K3NvenJyaEN0NnNaSklTSDJaVVJOQ083UWdIajIzcmdFUGdhd0RzcXdMYTJrSWxqaWpmMDgvTGozelB6eXllT1dicHc2TVdyeFFhWCt3OGZZNnRCRXVnMGxjaVZIZFlXaE1SeloiLCJtYWMiOiJjZWYyMzMzZTE3Y2VhNDI1MTI2M2NhOWRmOGI2ZGJlOGQ4NzYyYjQ3MTI0YWYwZGNkNjU2MGFiNjgxZWQ1OGVkIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IkxXRW5sd1FqNUxjTFZRZkxacUxuWWc9PSIsInZhbHVlIjoiQUhlOHNad09wTEY0RDFSbXNMSXBnaFFqTXNxUXZPSTF3K1l4eE81SWlVcmxRaUY0WnB6WDZkbjk4bWg2cWV0UE43d2Z6cVlrd2FKZHlsR0dWRmFoQ3h6VjRONjJRM1ViRlJKN1p4ODFPbC84Q0tiZnlhM0cvR3daQ1E4WG0rSzgiLCJtYWMiOiIyM2I4ZTUzOTMxYmQzNDIwZWY5YjVjMTM4YWJmYWUzYzVmZmUxOWZiZGE2ZTYwZDhlZTAxZThkZTE0NzJmNDM4IiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:26','2025-11-04 10:07:26'),(12,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/storage/theme/5/IMG-20251029-WA0004.jpg','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IlpPcU9MMjF5cXgxWGU2dzdwV3hsMkE9PSIsInZhbHVlIjoiMGRVTFZZT2VLbVFPSkVEdC9ieU9ibWhGZm05K3NvenJyaEN0NnNaSklTSDJaVVJOQ083UWdIajIzcmdFUGdhd0RzcXdMYTJrSWxqaWpmMDgvTGozelB6eXllT1dicHc2TVdyeFFhWCt3OGZZNnRCRXVnMGxjaVZIZFlXaE1SeloiLCJtYWMiOiJjZWYyMzMzZTE3Y2VhNDI1MTI2M2NhOWRmOGI2ZGJlOGQ4NzYyYjQ3MTI0YWYwZGNkNjU2MGFiNjgxZWQ1OGVkIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IkxXRW5sd1FqNUxjTFZRZkxacUxuWWc9PSIsInZhbHVlIjoiQUhlOHNad09wTEY0RDFSbXNMSXBnaFFqTXNxUXZPSTF3K1l4eE81SWlVcmxRaUY0WnB6WDZkbjk4bWg2cWV0UE43d2Z6cVlrd2FKZHlsR0dWRmFoQ3h6VjRONjJRM1ViRlJKN1p4ODFPbC84Q0tiZnlhM0cvR3daQ1E4WG0rSzgiLCJtYWMiOiIyM2I4ZTUzOTMxYmQzNDIwZWY5YjVjMTM4YWJmYWUzYzVmZmUxOWZiZGE2ZTYwZDhlZTAxZThkZTE0NzJmNDM4IiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:28','2025-11-04 10:07:28'),(13,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/storage/theme/5/IMG-20251029-WA0013.jpg','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IlpPcU9MMjF5cXgxWGU2dzdwV3hsMkE9PSIsInZhbHVlIjoiMGRVTFZZT2VLbVFPSkVEdC9ieU9ibWhGZm05K3NvenJyaEN0NnNaSklTSDJaVVJOQ083UWdIajIzcmdFUGdhd0RzcXdMYTJrSWxqaWpmMDgvTGozelB6eXllT1dicHc2TVdyeFFhWCt3OGZZNnRCRXVnMGxjaVZIZFlXaE1SeloiLCJtYWMiOiJjZWYyMzMzZTE3Y2VhNDI1MTI2M2NhOWRmOGI2ZGJlOGQ4NzYyYjQ3MTI0YWYwZGNkNjU2MGFiNjgxZWQ1OGVkIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IkxXRW5sd1FqNUxjTFZRZkxacUxuWWc9PSIsInZhbHVlIjoiQUhlOHNad09wTEY0RDFSbXNMSXBnaFFqTXNxUXZPSTF3K1l4eE81SWlVcmxRaUY0WnB6WDZkbjk4bWg2cWV0UE43d2Z6cVlrd2FKZHlsR0dWRmFoQ3h6VjRONjJRM1ViRlJKN1p4ODFPbC84Q0tiZnlhM0cvR3daQ1E4WG0rSzgiLCJtYWMiOiIyM2I4ZTUzOTMxYmQzNDIwZWY5YjVjMTM4YWJmYWUzYzVmZmUxOWZiZGE2ZTYwZDhlZTAxZThkZTE0NzJmNDM4IiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:29','2025-11-04 10:07:29'),(14,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/storage/theme/5/IMG-20251029-WA0015.jpg','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IlpPcU9MMjF5cXgxWGU2dzdwV3hsMkE9PSIsInZhbHVlIjoiMGRVTFZZT2VLbVFPSkVEdC9ieU9ibWhGZm05K3NvenJyaEN0NnNaSklTSDJaVVJOQ083UWdIajIzcmdFUGdhd0RzcXdMYTJrSWxqaWpmMDgvTGozelB6eXllT1dicHc2TVdyeFFhWCt3OGZZNnRCRXVnMGxjaVZIZFlXaE1SeloiLCJtYWMiOiJjZWYyMzMzZTE3Y2VhNDI1MTI2M2NhOWRmOGI2ZGJlOGQ4NzYyYjQ3MTI0YWYwZGNkNjU2MGFiNjgxZWQ1OGVkIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IkxXRW5sd1FqNUxjTFZRZkxacUxuWWc9PSIsInZhbHVlIjoiQUhlOHNad09wTEY0RDFSbXNMSXBnaFFqTXNxUXZPSTF3K1l4eE81SWlVcmxRaUY0WnB6WDZkbjk4bWg2cWV0UE43d2Z6cVlrd2FKZHlsR0dWRmFoQ3h6VjRONjJRM1ViRlJKN1p4ODFPbC84Q0tiZnlhM0cvR3daQ1E4WG0rSzgiLCJtYWMiOiIyM2I4ZTUzOTMxYmQzNDIwZWY5YjVjMTM4YWJmYWUzYzVmZmUxOWZiZGE2ZTYwZDhlZTAxZThkZTE0NzJmNDM4IiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:31','2025-11-04 10:07:31'),(15,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/storage/theme/5/IMG-20251029-WA0012.jpg','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IlpPcU9MMjF5cXgxWGU2dzdwV3hsMkE9PSIsInZhbHVlIjoiMGRVTFZZT2VLbVFPSkVEdC9ieU9ibWhGZm05K3NvenJyaEN0NnNaSklTSDJaVVJOQ083UWdIajIzcmdFUGdhd0RzcXdMYTJrSWxqaWpmMDgvTGozelB6eXllT1dicHc2TVdyeFFhWCt3OGZZNnRCRXVnMGxjaVZIZFlXaE1SeloiLCJtYWMiOiJjZWYyMzMzZTE3Y2VhNDI1MTI2M2NhOWRmOGI2ZGJlOGQ4NzYyYjQ3MTI0YWYwZGNkNjU2MGFiNjgxZWQ1OGVkIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IkxXRW5sd1FqNUxjTFZRZkxacUxuWWc9PSIsInZhbHVlIjoiQUhlOHNad09wTEY0RDFSbXNMSXBnaFFqTXNxUXZPSTF3K1l4eE81SWlVcmxRaUY0WnB6WDZkbjk4bWg2cWV0UE43d2Z6cVlrd2FKZHlsR0dWRmFoQ3h6VjRONjJRM1ViRlJKN1p4ODFPbC84Q0tiZnlhM0cvR3daQ1E4WG0rSzgiLCJtYWMiOiIyM2I4ZTUzOTMxYmQzNDIwZWY5YjVjMTM4YWJmYWUzYzVmZmUxOWZiZGE2ZTYwZDhlZTAxZThkZTE0NzJmNDM4IiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:32','2025-11-04 10:07:32'),(16,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/storage/theme/6/IMG-20251029-WA0012.jpg','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6InRvZ2FIUXdGM2RKS0tjTUhJdDY1WUE9PSIsInZhbHVlIjoia3haV3JlYlV6VzNjb21vTnN1Mk1xNmhjVi91aHlNWWdsT0p1SXhTUmkvcEJJZUJrdUk3cldSOEo2Q2dqMFl0cGlBbWFydmV0YURYNWxtZFRITWIyVkgxNkt6QWh0R0xlWTkzcGNVcHdwOCt6Y1lxVHNxN3d3VTZSSFhOclNIenIiLCJtYWMiOiI1MzJmNGM0MDVhYjgxYzlmOGYxNTlmNmVkMWMyZDY3ODgxOGQyMWU1YzFiYjYxNzE1YTUxNjEzYTMxOTEyNGExIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6ImRnT1RhSmNFdkk1YXA3di8vVzVLN2c9PSIsInZhbHVlIjoiYjlnZWlVbVNOZ256OHNNUU9EZXpTUmxUQVB6cnNFNDVOeUgzWHVGeG93MTUxNnFaZUJqamJYa3NRWmwxQ3p2Zm5JRzk5YlAvamZLdVRGenY3bzY1YzN6WHV4YjVhYVRiMzFjdFdWU1RyNHdUakk1YnRDU2NSbmM2NXR3Wk9jMEoiLCJtYWMiOiJjZWNjODk0ZDM1ODZjNWM0NGZmMGFiZDRiNTM2NWM2NTUxNTFjMDg5ZmIwNmQwOGQ3NzQ2MzJlZDVmZjkyNWUwIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:34','2025-11-04 10:07:34'),(17,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/storage/theme/8/IMG-20251029-WA0007.jpg','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IlRtWUx1RHpSRlpDU0xjUzNwYXR2cVE9PSIsInZhbHVlIjoidk1BcVYzd2VZSWdZaGU1VHA0NWtIU1hBQURlWGZIOWhBV0owcndaMVpGTnA1Snd5QVFvRHA4QjcrZkpYdTN5dWpkL09iZExYQm5pczd3M3JCSWZNcmg3YjlFb2djdERQamo0TzRTTGwraGFxQmhTeEhmekhLVXRiTnVxL2NhS1ciLCJtYWMiOiIxZDE3OWYyMWE5MDg3ODY5N2Q4OTJiZmZlOWZhMDBiMmYwNDdjZjc4ZGQ3YmU4YjBmMmQyNDI4ZTkzNGYxZGIwIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6InkrdVlNcElHWS9QZlNzREZJZzg0bFE9PSIsInZhbHVlIjoiV0JwbkNWaVM3WHVqZGNzNFRwQkZxRzBCNFdkYVRESVFJMG5tc1cyaHZsNE80eGlTYlNXSm1EMjU3TnA2R1BrWUZtWTZGV01QMDJsL2pKMnlNcWRlU3p3RlN5TTVtcFJRUGFUaUxHL3lGSm56OW5ONU9sSEZuMU5JbTRkcVV0QlIiLCJtYWMiOiIzNTk1MjQ2YTBmNGE2NzliY2Q2ZjcwYzZiNjQzYTI1M2ExMzQ5MzIyZmUxMTBmZmJhZWNiMGVkYjUwZmVlMTFmIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:41','2025-11-04 10:07:41'),(18,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/%7B%7B%20url(\'/clothes\')%20%7D%7D','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-purpose\":[\"prefetch;prerender\"],\"sec-speculation-tags\":[\"null\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-dest\":[\"document\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IlowODJoNzZkeE9NY3Z6RmJDMU9oQ1E9PSIsInZhbHVlIjoienBNWE1KQzVUbHI4OWwvNmpaL2k0cHFBMWJlRmlzd3ZTbjg0T1AwRUZra0FNTTZVSmNyMkg3KzBvRjN6RUc0cHlXQUJrY3JMVXlUUFo1R0lTaEF1bnRHVHRucDJRa1NEMUt6b1JTTkJEenpvQldjNXQwL3o5TXpsZ05VLzFoU3YiLCJtYWMiOiJjNTBkOTM2MDk2NWRiN2Y5MzRiY2FhY2RiYzdlMTFhMTAwYjA1YmNhNTVkN2U4MTYwZGJmMTAzODIzOTljOWIzIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IjZQcUJFYWE0THFPOU9JZlgxTy9Sd1E9PSIsInZhbHVlIjoiRzhGUStPUENDWU5tWW9wbUx2V21ncnF3ajY2T2xNVnZmT0lJZEMvUC9wdVlWMWd5SU1kKzArTUtCTmhiQWd6dlRoZkNsR0xjYUt4MUk1eDN4UjB4Wm45aWNNbzB3SmJaNEo1L2NNUmJzUzBCYjVmT2k1TFBGOXdDdGd6Z0NZNTgiLCJtYWMiOiIwMDA2NWQxMDk2NmJmYzM1ZTFmYzIyNDA3ZGM2N2I0N2Y5MWE2NjQ3MmE0ZDQ4OTkyZjQ0NTljYjBjNDkyYjlhIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:42','2025-11-04 10:07:42'),(19,'GET','[]','http://127.0.0.1:8000/%7B%7B%20url(\'/storage/theme/8/IMG-20251029-WA0012.jpg','http://127.0.0.1:8000/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IlRtWUx1RHpSRlpDU0xjUzNwYXR2cVE9PSIsInZhbHVlIjoidk1BcVYzd2VZSWdZaGU1VHA0NWtIU1hBQURlWGZIOWhBV0owcndaMVpGTnA1Snd5QVFvRHA4QjcrZkpYdTN5dWpkL09iZExYQm5pczd3M3JCSWZNcmg3YjlFb2djdERQamo0TzRTTGwraGFxQmhTeEhmekhLVXRiTnVxL2NhS1ciLCJtYWMiOiIxZDE3OWYyMWE5MDg3ODY5N2Q4OTJiZmZlOWZhMDBiMmYwNDdjZjc4ZGQ3YmU4YjBmMmQyNDI4ZTkzNGYxZGIwIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6InkrdVlNcElHWS9QZlNzREZJZzg0bFE9PSIsInZhbHVlIjoiV0JwbkNWaVM3WHVqZGNzNFRwQkZxRzBCNFdkYVRESVFJMG5tc1cyaHZsNE80eGlTYlNXSm1EMjU3TnA2R1BrWUZtWTZGV01QMDJsL2pKMnlNcWRlU3p3RlN5TTVtcFJRUGFUaUxHL3lGSm56OW5ONU9sSEZuMU5JbTRkcVV0QlIiLCJtYWMiOiIzNTk1MjQ2YTBmNGE2NzliY2Q2ZjcwYzZiNjQzYTI1M2ExMzQ5MzIyZmUxMTBmZmJhZWNiMGVkYjUwZmVlMTFmIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:07:44','2025-11-04 10:07:44'),(20,'GET','[]','http://127.0.0.1:8000','http://127.0.0.1:8000/customer/login','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"cache-control\":[\"max-age=0\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-user\":[\"?1\"],\"sec-fetch-dest\":[\"document\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/customer\\/login\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6IlFGMU02b0R5ejV2Y1FpSTVCUFdFT2c9PSIsInZhbHVlIjoid0YwTGlRcmowR01nWDAwb3JIa1g1VjUvb3kveFQrUXVTOCs2a294WEZZenk1RnlBc2g3bytaakMwaG9vQmE5VUptVHZ0dGVTV1Y0Y3Z5ejhidStITWVTQ25RaGFjWVhLaUpESm1obHJyUW9QRTEyUG5IeDQvd1JsRHMvaXlSNmYiLCJtYWMiOiI0ZmUwOWIxMjNhYTJkMzRmNjAyOTRjNGExMmViZDc3OWYxY2YwMjhmMmJkN2U4YzBkYzJmNzlmZDM2NzBmOWFmIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IlA1bDRTc0htOXl1T2xKdnBxUzQ4Vmc9PSIsInZhbHVlIjoiRS9qZXM1VUxxY0ZNSzh4dTVSdXQzcjUwTUgrYXVVVG1kcWs1R1dpSlFkVElKZEdVS2pKUDRIUkllNVV2UElnUGM5QlpGQTE5VTJvSDd0Y21IRDB0NTJvcDUvNXZmMndkOHBMWWNuTkNvekhTRW9ndlNqNkFsMy9PdXZpQ2kvUDgiLCJtYWMiOiI0ODliMTZkMTU5M2IyNDA3NTFjNGIwY2I0M2ZmNmRkZWNkOWJjYWU2ZGIzOTkxYmEzODdkYjk5ZDlhZDY2ZTAyIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,'Webkul\\Customer\\Models\\Customer',1,1,'2025-11-04 10:19:05','2025-11-04 10:19:05'),(21,'GET','[]','http://127.0.0.1:8000/accessories','http://127.0.0.1:8000/','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"127.0.0.1:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-purpose\":[\"prefetch;prerender\"],\"sec-speculation-tags\":[\"null\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-dest\":[\"document\"],\"referer\":[\"http:\\/\\/127.0.0.1:8000\\/\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"dark_mode=1; XSRF-TOKEN=eyJpdiI6ImZFWXRqMzNKZVpOZlBsOVkyZE1sZ2c9PSIsInZhbHVlIjoiZ2F5dHEyOHV5Mkw1aHozR050OUhkZmF2MFV2WUg1WGdwcGpyNkQvWStPVk43ZXpSd3pSWDluZC94Z0tVNDd0SFhuaTIrVzdkWW14aHJZY1lBb29CTzZYekxZaFpsYklIREFSVCtXYUNZLzdxQThSaE5qTjZxNTR1WEFiQlFIUmsiLCJtYWMiOiIxMWM0ODk5NzQ0ZmQ2YzYwMGIwMmYxZDllZmI3ZmRhNTc0YjQ1NGYxMzFlMTEzMGM3MDZkMGM0MDFkOWI3N2I2IiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IlFDZHI4dFJoU1MzY3RpYzRaZXBnemc9PSIsInZhbHVlIjoiaER2ZkJDYnRhSzdjekFIc0xJSGJCNjZOWDZFU01NQnNRZ2JVSFgxSFplMmttNnh4enhYUEs0UXJNY3pqWks0VlRrVTM1Z1pEejd6ZEFjL2dXMnZUM01ld2ZHUlR4aHl3K2xicW9KblRVWERjSm1hVDJiY3l0SFNPUm5vQTNLenciLCJtYWMiOiJmYzBkOTFmZDlhZDhmYmVlZWY2N2JmYjRiZmQ3YTdkYjliYTkxMWYxNmEwYWMyYTk2YmUyMjc5ZDQxZjBjNWNjIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1','Webkul\\Category\\Models\\Category',4,'Webkul\\Customer\\Models\\Customer',1,1,'2025-11-04 10:19:17','2025-11-04 10:19:17'),(22,'GET','[]','http://localhost:8000',NULL,'[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"localhost:8000\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"none\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-user\":[\"?1\"],\"sec-fetch-dest\":[\"document\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"__clerk_db_jwt_byUN4R6R=dvb_317AykrzhBv85np3Y6NqHyxVB26; __clerk_db_jwt=dvb_317AykrzhBv85np3Y6NqHyxVB26; __stripe_mid=09a3a013-b998-4525-a2df-636a13fd5bd9933c8e; __session=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __session_byUN4R6R=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __client_uat_byUN4R6R=1758067319; __client_uat=1758067319; dark_mode=1; XSRF-TOKEN=eyJpdiI6ImFTd3Z5QW9Uc2ZLdWxBRkJTZTdoY0E9PSIsInZhbHVlIjoiK2JMK0N6NzVCSVpmamxKZFJSdnBXNGVKd2VnVzJjNlZNU3ZhMERBTENFdFYwTFJudE9YZHVQSnRCNFRJbG12YzVETWg2M2hlK1J3N2k2WXUrWEVaaHZmbTNIUW1iTmhwTnJBL3YyNXJ3R05KdHBGREdNZEM1aFU3cWNFeTBybnQiLCJtYWMiOiJhYTVmNWNjZGJhZGZjMGNmZmJhMDYzODJiNDYwMjgwNWFjM2M1NDc1YTk0YTcyODZkNWUzNTI2ZTgwNmUyMzVlIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6InNhYUJJSFhtcmw4QWdrOEN5YVM2dFE9PSIsInZhbHVlIjoiUlhBdlhDMWVzbHMzV09XWUhObmxBdlhrYllMMDdNSlF1TWZDd2JScmlmcVdJM0RDS3BZaHZMd0cwVitqZU5hV0l0Y1pkN1BRYzNoalc4emtXUnM0b25ZaEtEZTdXOTFieEhMd094TUNYOXYwTFlMNVl6RWViT0FTdndRcjhhQzUiLCJtYWMiOiJhY2JmYjRhZmM4YzUyN2ZhOGE4OWMwZTMwNDgyZjA3MTU0Y2RiNDk1ZGNjYzlkYzZkYTE0NDc2MTliM2ZmYzAyIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','127.0.0.1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:25:53','2025-11-04 10:25:53'),(23,'GET','[]','http://localhost/army-mart/public/accessories','http://localhost/army-mart/public/about-us','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"localhost\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-purpose\":[\"prefetch;prerender\"],\"sec-speculation-tags\":[\"null\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-dest\":[\"document\"],\"referer\":[\"http:\\/\\/localhost\\/army-mart\\/public\\/about-us\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"__clerk_db_jwt_byUN4R6R=dvb_317AykrzhBv85np3Y6NqHyxVB26; __clerk_db_jwt=dvb_317AykrzhBv85np3Y6NqHyxVB26; __stripe_mid=09a3a013-b998-4525-a2df-636a13fd5bd9933c8e; __session=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __session_byUN4R6R=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __client_uat_byUN4R6R=1758067319; __client_uat=1758067319; dark_mode=1; XSRF-TOKEN=eyJpdiI6Ikc0ZE9LRTE0NVpsc0NuQmxXY1BZQ2c9PSIsInZhbHVlIjoiMXJHQnp4VFBXNUNIcm9jTmZZTXU0U01lbVdmZWJCak44d3ZVbm9FWDVCUVFkelc2WTNWMllOeXYvZVEya0g3SmwyYWtuWTViK096b0NrbFJyS2ttU1ZGcC81TFRENzJRT0hPZktHczJ3enRwWTBvcGpBc3BaTFYyWHI5UmVNeUQiLCJtYWMiOiIzOGQ2ZTViOTQ3MTllZTgyZWUwNjQ3OWQ3NmE3YTE4MTlmNDhhYzdkZWZlNmQwZTFmYzBiOGY5ZmMzMzI2MDk4IiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IktnSDNPWlZzVTVxdXZLSTE4ZFcxVUE9PSIsInZhbHVlIjoidzhacXlBaCt4TlVEcmdnVTRPRlo4bTFsem9SYlFlZEJLdlRlL3cwWGtmcitwOFZTR2ZQcTZRTnU4OU1VR3pxNDJxeXZhL1hHNnhlekRvdnN1ckVYRDdMKzQybWlqRjBKeUFQc0h0VzNVZ2NiWXpXNkc3OUtVdWtxMnZFS1BiOGoiLCJtYWMiOiIwMmZiMzNiNWZjMmEzZmM2MzRhYTRjNDMyODJmMWQ4MmYwZGY3ZGFjOTUzN2EwNGQ0NWQyZDNkYWUxNzdhMmIyIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','::1','Webkul\\Category\\Models\\Category',4,NULL,NULL,1,'2025-11-04 10:27:00','2025-11-04 10:27:00'),(24,'GET','[]','http://localhost/army-mart/public','http://localhost/army-mart/public/about-us','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"localhost\"],\"connection\":[\"keep-alive\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-purpose\":[\"prefetch;prerender\"],\"sec-speculation-tags\":[\"null\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-dest\":[\"document\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"referer\":[\"http:\\/\\/localhost\\/army-mart\\/public\\/about-us\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"__clerk_db_jwt_byUN4R6R=dvb_317AykrzhBv85np3Y6NqHyxVB26; __clerk_db_jwt=dvb_317AykrzhBv85np3Y6NqHyxVB26; __stripe_mid=09a3a013-b998-4525-a2df-636a13fd5bd9933c8e; __session=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __session_byUN4R6R=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __client_uat_byUN4R6R=1758067319; __client_uat=1758067319; dark_mode=1; XSRF-TOKEN=eyJpdiI6ImE4dWUwNzhqN0wyeldCVXp4alp0ZUE9PSIsInZhbHVlIjoiak8xdXNjcG40MTdyYVRLZjVuUXRETm9Nc0lod3ZUM1ZobVJmMnV6bCtJaHR1cUxjZEZNeXI1c3FTbERMVWNkMENEdjdGTnF5VHhNRmtBSUpDMDFEcVRzVmgzRWtwbDVPZXo4TGQ4SGxva3RpMDVJcEhpWDE3dU9KbGtOdHp1M2siLCJtYWMiOiIwOGUyZWVhNzQ3YTQyYzk1NjQwZjk0NjkzNmZjNDQyNWNiY2FiMDZkZmU0MWYwYjdhNzczYjNhZGU5MGVkNmI4IiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6ImE5Y0QwWkJmWmlrYlRSOFpLTjI3MEE9PSIsInZhbHVlIjoiaGltTDdKZHhHL0JBM3FMNy90RTFKWWFnckwzeUExVGw3OFh2cWhvd2hQczA0Qkc4eEZueE9FcXNIRmVvR0lvMWlhSXBpb2x3Y2h4TlVlU2JmOGJGNHdwTHlhVVpUR0xsUXNtdGlZczFBY2hWbVlURFpSMktOeXBqVDZ4dlpmQSsiLCJtYWMiOiJkODA2YjcxNjlmMDVjYjY4ODdmMTM4NzQ0NzY0OTIyNjRiZTAyZWVhZjE4NzNjNDM1OTVjNTdhOTEzNzZkNDRjIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','::1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:28:59','2025-11-04 10:28:59'),(25,'GET','[]','http://localhost/army-mart/public/clothes','http://localhost/army-mart/public/','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"localhost\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-purpose\":[\"prefetch;prerender\"],\"sec-speculation-tags\":[\"null\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-dest\":[\"document\"],\"referer\":[\"http:\\/\\/localhost\\/army-mart\\/public\\/\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"__clerk_db_jwt_byUN4R6R=dvb_317AykrzhBv85np3Y6NqHyxVB26; __clerk_db_jwt=dvb_317AykrzhBv85np3Y6NqHyxVB26; __stripe_mid=09a3a013-b998-4525-a2df-636a13fd5bd9933c8e; __session=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __session_byUN4R6R=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __client_uat_byUN4R6R=1758067319; __client_uat=1758067319; dark_mode=1; XSRF-TOKEN=eyJpdiI6Ilc5N3NYWFpWd0xXL2c0UjFyTXYraGc9PSIsInZhbHVlIjoiUXlJaTI5ajRxdmZ0V01Pd3JSRHNtcGVkcXRCNHErNWNzM2NqaXNKVjh2WGJkMUd2SitkRUxzdVpJNFpJVVBReEVXUHZFeTY5bU8xZytEVjRhb1hyYlNEakFFTG5OTzR5NWxZL2lsQm96OEo3UHo0Qm0zeVkxdWtJSXJwZ0c4MFkiLCJtYWMiOiI4OWI1NDEwNTlmNmMwZDVjM2I3NjE4YTRkY2U4MWIyZDE5NjE3ZTAxMjBjMDlhYjlhOGVmYzhhNjg4MTM5MjFhIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6ImppWjJGQjR0ejUvZkF6SjRuM2RzK3c9PSIsInZhbHVlIjoiWGs1TTdDVmMvdytsUkIwWml4T0F3UzEzTFBDNUcwR1NmRnF2Mm05dHZWdGdIQzhkZHFlUTZPSFNlWlF5d0VMcjREd3orV3JMcDZtOTA2REZ1WExoUU1NNWNyWkc2cXF6Z1ptejN3ZElpZFd6TVo5Z2ZjRWVSL2EzbHF6Z3d2MEgiLCJtYWMiOiJkMDM0NGY2YTRiMjM1ZDI2MWY2ZmJlMjYwYzdhNzI1NjI2MDcxNzIzZTY0ZWUxN2M3MGYxNmYzNGI3ZGIxMzdmIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','::1','Webkul\\Category\\Models\\Category',2,NULL,NULL,1,'2025-11-04 10:36:04','2025-11-04 10:36:04'),(26,'GET','[]','http://localhost/army-mart/public/shoes','http://localhost/army-mart/public/','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"localhost\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-purpose\":[\"prefetch;prerender\"],\"sec-speculation-tags\":[\"null\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-dest\":[\"document\"],\"referer\":[\"http:\\/\\/localhost\\/army-mart\\/public\\/\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"__clerk_db_jwt_byUN4R6R=dvb_317AykrzhBv85np3Y6NqHyxVB26; __clerk_db_jwt=dvb_317AykrzhBv85np3Y6NqHyxVB26; __stripe_mid=09a3a013-b998-4525-a2df-636a13fd5bd9933c8e; __session=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __session_byUN4R6R=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __client_uat_byUN4R6R=1758067319; __client_uat=1758067319; dark_mode=1; XSRF-TOKEN=eyJpdiI6Inkxc3RLMnBGRm5TVHM5V3JRZHVldHc9PSIsInZhbHVlIjoiSE01cWtYSytBL1ZYbjByODRoMjJBS2NGWlFJK0ZwblVkTU8rTlNmVkd2bGRUdDFSTHBrZWZMaXVwTTd6RG5uNlpGaUlmdWpQdjRuSm9hLytuZHQ0dzVhSVNTQlFSeHdNektmUk5qcjNnbTJLa0xVNXgvSUdURi9qUGd3UHdPU1kiLCJtYWMiOiIwMDMxZWI2ZDFhODdhNTJjZjRmZGE0YTk2ZjUwZmU0NjhmNDk5ZjUzZjJmMWU4OTg3ZDM2ZTQzYjhjZmY4Nzc5IiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IlBQSDVodUxzWnFCa0lPQXFvUnNPSkE9PSIsInZhbHVlIjoiUlBhazlFZUFJK2tjeEMyeHkxRFNtVVhmb1dpa0pnYUM0OUw3L2dsQ1hIRm5mNVBLUmN5dkJ5OTBiajhMUmRoak14dDZLL0VxTy84R3IxQmdtNzhya0RKcnArZVo4VDVRdEVYRzhFU2JUcWJ3TVhxZW1CWGFBeldQbmJ6dzkvWDAiLCJtYWMiOiI0MTBkM2RiNTEwMTQ1YWQwNDY1Yzc5NmE1YjFlMDg1ZDdhMDY5NTNmYjU2MzkzZGU5ZWU3ZDE4N2ZlZWE4MWFjIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','::1','Webkul\\Category\\Models\\Category',3,NULL,NULL,1,'2025-11-04 10:50:03','2025-11-04 10:50:03'),(27,'GET','[]','http://localhost/army-mart/public/images/favicon.png','http://localhost/army-mart/public/customer/login','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"localhost\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/localhost\\/army-mart\\/public\\/customer\\/login\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"__clerk_db_jwt_byUN4R6R=dvb_317AykrzhBv85np3Y6NqHyxVB26; __clerk_db_jwt=dvb_317AykrzhBv85np3Y6NqHyxVB26; __stripe_mid=09a3a013-b998-4525-a2df-636a13fd5bd9933c8e; __session=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __session_byUN4R6R=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __client_uat_byUN4R6R=1758067319; __client_uat=1758067319; dark_mode=1; XSRF-TOKEN=eyJpdiI6InkybjFTYVp6TmhFc2k0dXNzYTNUY1E9PSIsInZhbHVlIjoiTHFKTDcwZjBEZ2pxbUFRQlQ5bGVxTHZQRzltSFBEYjM2ckVyR3k4eVhuVXVUWkVnYnJRSmpYYXJTQm1GekFaeHIvWGZUcVVySTVoYWJZVTJzVFdMZ0lORlRCRnVyZzB6S3JpYUhOQ3puMVlXdWhqV0IyZzFvMlBaZEhMOGNjRlciLCJtYWMiOiI4Njg5ZDk5NGJjOTE1NTI1YTU2YjcxM2FjZjliNjNjODc1MGJhNGU3ZmY5YmY1ZDA4NjhhMzg4YjhhMDU1NzQxIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IjZNcm83M01lWVQ2ZGxLVldEVDZTNWc9PSIsInZhbHVlIjoiN1NFN3NXUDVBeDJkd3ZKK0NKTkV3amVJTjVpRU8zYXFYWElsTUQzSTNQZGx1RkxGTG9aL3NNV05PMDVoZFlYTUVMVFFQN0tWeEd2L25lLzRTODdlMGJNTW9HVi9FcTJaWmg4NlhUTzUrTmYrckFKdzBYQVdQcU4reXdLTXQ4aHgiLCJtYWMiOiIxODg2YmQ3YjQ3ZjdhYjVlNTFiY2I2Y2NkNTg1YzZhMWU0YTAyM2MyMGM0ODA3Y2M5YmRiN2VhYzI2Njc0NzliIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','::1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:56:38','2025-11-04 10:56:38'),(28,'GET','[]','http://localhost/army-mart/public/images/ARMY%20MART.png','http://localhost/army-mart/public/','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"localhost\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/localhost\\/army-mart\\/public\\/\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"__clerk_db_jwt_byUN4R6R=dvb_317AykrzhBv85np3Y6NqHyxVB26; __clerk_db_jwt=dvb_317AykrzhBv85np3Y6NqHyxVB26; __stripe_mid=09a3a013-b998-4525-a2df-636a13fd5bd9933c8e; __session=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __session_byUN4R6R=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __client_uat_byUN4R6R=1758067319; __client_uat=1758067319; dark_mode=1; XSRF-TOKEN=eyJpdiI6ImM5TjF2SmVvNWIyMWt4eWppMnVwU1E9PSIsInZhbHVlIjoiOG5uaW1WM1poTG1ZQ0N4Q0tpYUhEN1VuTFBmRUpKcEl3QWhTNmFobFhPTVNKdFJKdEJLek1vNUV3bEJyekl1elNJd3ZLcmEzSXhTbnh2Z0Voam1UMktTcXdKMFp4a2FFRXdHWENKNFJkemNLSytTUjBvU0xtZVMxRjZVcmJPTTgiLCJtYWMiOiJjM2I3Njk2NzU1NjU2YWQ5ODQ3NjhjZmUzNjgyOTRkOGZkYjlkYmUyNDk3ODliMWY2OGU5NjYxNTA5OWRiNzMyIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IkltRysyTDdTTjF4QTc4K04rZllmTEE9PSIsInZhbHVlIjoiWEI4dEwrMmtVbU5iU0FxN00wR25JdmN4K2hXN3pnZEVGRWRGSWxJb1lXRjQzT3pGbUQzZlFac3ZUNGI1YmsrU013ZWpMUHBRbVZ5eS9UTFVVZ2VxUEdjUFAxQnQydHJXeGc3aWk3QTB6aXhDdjhsRWpyV0NnRysyWVV0MEVOOVYiLCJtYWMiOiIyY2FkNGU3ZWM2ZjIwNjQzNWZlZGE1YWE0MzNhMWY4MzE4YTUxMDMzNjdiZDUwZGU2ODM2MzlkNmY1NGI0YmQ2IiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','::1',NULL,NULL,NULL,NULL,1,'2025-11-04 10:56:59','2025-11-04 10:56:59'),(29,'GET','[]','http://localhost/army-mart/public/long-shoes','http://localhost/army-mart/public/shoes','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"localhost\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-purpose\":[\"prefetch;prerender\"],\"sec-speculation-tags\":[\"null\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-dest\":[\"document\"],\"referer\":[\"http:\\/\\/localhost\\/army-mart\\/public\\/shoes\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"__clerk_db_jwt_byUN4R6R=dvb_317AykrzhBv85np3Y6NqHyxVB26; __clerk_db_jwt=dvb_317AykrzhBv85np3Y6NqHyxVB26; __stripe_mid=09a3a013-b998-4525-a2df-636a13fd5bd9933c8e; __session=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __session_byUN4R6R=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __client_uat_byUN4R6R=1758067319; __client_uat=1758067319; dark_mode=1; XSRF-TOKEN=eyJpdiI6Inl1OGFxYnNjbkJzWGYxUFh4QlBxS2c9PSIsInZhbHVlIjoiN3dCaDBBZ3p0NlpFMVNOYVFKZml3d2MyNWxadmhvREkxQ2FhaDdyZnYrSjc2SHU4QXo0OGIrYnVXRk5mV29VM2Z2UVpCYjVuZkhuMklqOC9BYlNabXNNTmgwQXRaOC9vUFJNcDM5bGIzcjlGRGEyYmMzNmJFQ0xHRjJGdWRzc08iLCJtYWMiOiIwY2Y5YWM1NjAyYmUyOTY4NmNkY2ZmYzZjZDdiYTE0MWNkYmEzYzc1MmI4ZjgwYTYyYzJiODIxZTdmOGVlMmExIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IkIrb3VNNjdRS3BGeG12eU9kNEdYcWc9PSIsInZhbHVlIjoidnlPTFlxOHFubFNaSHBOc0psMm1hWk9sZE1qUWdqdW0rYTZnVTVyVGNNbXlHSmNBVmw2d3JlQzJyR2FDVjR1REs4RWEvZlYyOC9aUllHSVRPaDZlNUc2c25iU2NZbU9nc3lONkc3SVdQUEd3ZmkxaHJEWUNrTlR1QWJPVzREQjUiLCJtYWMiOiJlNDU0ZjA5MzE5Y2FkOTcxNjMzODFlOWRlODIxY2EyZWNkZGU1OGVlNWI5NjZiOTFkZjFhYjAwYzAyYzU2NWU0IiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','::1','Webkul\\Product\\Models\\Product',1,NULL,NULL,1,'2025-11-04 11:16:30','2025-11-04 11:16:31'),(30,'GET','[]','http://localhost/army-mart/public/%7B%7B%20url(\'/clothes\')%20%7D%7D','http://localhost/army-mart/public/','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"localhost\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-purpose\":[\"prefetch;prerender\"],\"sec-speculation-tags\":[\"null\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-dest\":[\"document\"],\"referer\":[\"http:\\/\\/localhost\\/army-mart\\/public\\/\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"__clerk_db_jwt_byUN4R6R=dvb_317AykrzhBv85np3Y6NqHyxVB26; __clerk_db_jwt=dvb_317AykrzhBv85np3Y6NqHyxVB26; __stripe_mid=09a3a013-b998-4525-a2df-636a13fd5bd9933c8e; __session=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __session_byUN4R6R=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __client_uat_byUN4R6R=1758067319; __client_uat=1758067319; dark_mode=1; XSRF-TOKEN=eyJpdiI6Ik4zM2Y5cnFhWHlWQ3MrRE9XMTFXTXc9PSIsInZhbHVlIjoibm1mNXNNKzE3bzFLcUIxN21ZTU5aSkVuUzJIT1dkN2UvdDdwNzdzanhVZHVhQS81Ni85dlM5bVNhOGZhMGVpR0M5M0NFdnE3bm9VVVh0b2RBWkhrdGVyVFByZjFuZmtTS1VyeGFxNEh6eng3eGJ5TnprMitNYjFqekd5djNqUWciLCJtYWMiOiJkOTU1NTFlZTJkN2ZjNzgyOGEzYTY3MWZmZTM4MmUwMmQ0MjU1OTQwODI1ODMxNTBkYzdjNDJkMDhhZWIzODM4IiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IlRmZFRxSERnbnVXTldSTUZwdHFYZXc9PSIsInZhbHVlIjoiUW85R1ZPSythVkFwRTZmZ0d2REJmMUd6RlZaL2wxaDU1eFBYaFRqOXd3NGpDWXVNL044bDd5VDBYbWxPWG9TVnlDWUY0eDNxVnBseFh4UllpSndlSVNEOStSUms1WFU1UFZHMWxaK25JNVBzOVVWQkp2cmZrZmhkNExUbGI1UVgiLCJtYWMiOiJlN2UwNWQ5MDU1NDM5YWJkYTczYWIxZDRlOWI3OWM3MWFhMTkxZTA1ODI3MGNmNTIzNTljOGVjMmIzMGM1ZWEwIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','::1',NULL,NULL,NULL,NULL,1,'2025-11-04 11:19:18','2025-11-04 11:19:18'),(31,'GET','[]','http://localhost/army-mart/public/%7B%7B%20url(\'/storage/theme/1/vkhgEQ5fQmLaKJmjyaKxB4shlpbrRm1Un6D0CCXp.webp','http://localhost/army-mart/public/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"localhost\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/localhost\\/army-mart\\/public\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"__clerk_db_jwt_byUN4R6R=dvb_317AykrzhBv85np3Y6NqHyxVB26; __clerk_db_jwt=dvb_317AykrzhBv85np3Y6NqHyxVB26; __stripe_mid=09a3a013-b998-4525-a2df-636a13fd5bd9933c8e; __session=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __session_byUN4R6R=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __client_uat_byUN4R6R=1758067319; __client_uat=1758067319; dark_mode=1; XSRF-TOKEN=eyJpdiI6ImRWazlOUkFWV0Q2eVV5VVQ2R1VDRXc9PSIsInZhbHVlIjoiSkNnWlNxVXBnalQyY2trYTFGK2huOWhROTNRajBIeEJKY05qYVZ0NitHRWRNb1h0dVUrT3NWSGJ5c2oyS1lhUlIvY3JLWjgyaExqT3Q0SURQM2owYTY5SkNZazV0S0dqVjdpZE0rVzVFNHludTZrQXZxU1FsWmJEYkhZS2sxb3MiLCJtYWMiOiI0YzQyNWYzZDlmOTQ2OGZiZmI3ZDFkOWM3NWYzMjA2OTQ0YmUzNmE2ZmE2YWQ3ODUwNTE4MGI3Njg2YTBlYzY3IiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IlRpQ25MdlFLTFFNdVRGeEJyT0tPNEE9PSIsInZhbHVlIjoiaDFkNCthY3dsbHRDbjBDK0FyTVY1cVFYYy96Z0ozTjZOZmg3OFFjYTNiNE9yTnY3Mm5yQStnVkd4d3VqNjZmc3hQZ0VncjQ5MjdqcC81eE5xZExHWXhNWGc4ckpaZFUyR2F3VE50MExzeEZaUWdYSytzUTArV3FXOGRHbWZxcWYiLCJtYWMiOiI4MjI0YmNlOGQyNWZhMWNmYWIyZjU3M2Y0MTZhYjM2MWEwNzkzYzQzNjI3Nzg1M2NmYjFlYWUwNTk2YzM2OGQ2IiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','::1',NULL,NULL,NULL,NULL,1,'2025-11-04 11:19:21','2025-11-04 11:19:21'),(32,'GET','[]','http://localhost/army-mart/public/%7B%7B%20url(\'/storage/theme/1/dzAlZjOOkL1tbW5z9q3LYlqvbyR5c06UAtZLRphT.webp','http://localhost/army-mart/public/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"localhost\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/localhost\\/army-mart\\/public\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"__clerk_db_jwt_byUN4R6R=dvb_317AykrzhBv85np3Y6NqHyxVB26; __clerk_db_jwt=dvb_317AykrzhBv85np3Y6NqHyxVB26; __stripe_mid=09a3a013-b998-4525-a2df-636a13fd5bd9933c8e; __session=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __session_byUN4R6R=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __client_uat_byUN4R6R=1758067319; __client_uat=1758067319; dark_mode=1; XSRF-TOKEN=eyJpdiI6ImRWazlOUkFWV0Q2eVV5VVQ2R1VDRXc9PSIsInZhbHVlIjoiSkNnWlNxVXBnalQyY2trYTFGK2huOWhROTNRajBIeEJKY05qYVZ0NitHRWRNb1h0dVUrT3NWSGJ5c2oyS1lhUlIvY3JLWjgyaExqT3Q0SURQM2owYTY5SkNZazV0S0dqVjdpZE0rVzVFNHludTZrQXZxU1FsWmJEYkhZS2sxb3MiLCJtYWMiOiI0YzQyNWYzZDlmOTQ2OGZiZmI3ZDFkOWM3NWYzMjA2OTQ0YmUzNmE2ZmE2YWQ3ODUwNTE4MGI3Njg2YTBlYzY3IiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IlRpQ25MdlFLTFFNdVRGeEJyT0tPNEE9PSIsInZhbHVlIjoiaDFkNCthY3dsbHRDbjBDK0FyTVY1cVFYYy96Z0ozTjZOZmg3OFFjYTNiNE9yTnY3Mm5yQStnVkd4d3VqNjZmc3hQZ0VncjQ5MjdqcC81eE5xZExHWXhNWGc4ckpaZFUyR2F3VE50MExzeEZaUWdYSytzUTArV3FXOGRHbWZxcWYiLCJtYWMiOiI4MjI0YmNlOGQyNWZhMWNmYWIyZjU3M2Y0MTZhYjM2MWEwNzkzYzQzNjI3Nzg1M2NmYjFlYWUwNTk2YzM2OGQ2IiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','::1',NULL,NULL,NULL,NULL,1,'2025-11-04 11:19:21','2025-11-04 11:19:21'),(33,'GET','[]','http://localhost/army-mart/public/%7B%7B%20url(\'/storage/theme/1/74i3EIlFzJd0PNeHgOmZBGfGkova07iHFMJEPYFc.webp','http://localhost/army-mart/public/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"localhost\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/localhost\\/army-mart\\/public\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"__clerk_db_jwt_byUN4R6R=dvb_317AykrzhBv85np3Y6NqHyxVB26; __clerk_db_jwt=dvb_317AykrzhBv85np3Y6NqHyxVB26; __stripe_mid=09a3a013-b998-4525-a2df-636a13fd5bd9933c8e; __session=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __session_byUN4R6R=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __client_uat_byUN4R6R=1758067319; __client_uat=1758067319; dark_mode=1; XSRF-TOKEN=eyJpdiI6ImRWazlOUkFWV0Q2eVV5VVQ2R1VDRXc9PSIsInZhbHVlIjoiSkNnWlNxVXBnalQyY2trYTFGK2huOWhROTNRajBIeEJKY05qYVZ0NitHRWRNb1h0dVUrT3NWSGJ5c2oyS1lhUlIvY3JLWjgyaExqT3Q0SURQM2owYTY5SkNZazV0S0dqVjdpZE0rVzVFNHludTZrQXZxU1FsWmJEYkhZS2sxb3MiLCJtYWMiOiI0YzQyNWYzZDlmOTQ2OGZiZmI3ZDFkOWM3NWYzMjA2OTQ0YmUzNmE2ZmE2YWQ3ODUwNTE4MGI3Njg2YTBlYzY3IiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IlRpQ25MdlFLTFFNdVRGeEJyT0tPNEE9PSIsInZhbHVlIjoiaDFkNCthY3dsbHRDbjBDK0FyTVY1cVFYYy96Z0ozTjZOZmg3OFFjYTNiNE9yTnY3Mm5yQStnVkd4d3VqNjZmc3hQZ0VncjQ5MjdqcC81eE5xZExHWXhNWGc4ckpaZFUyR2F3VE50MExzeEZaUWdYSytzUTArV3FXOGRHbWZxcWYiLCJtYWMiOiI4MjI0YmNlOGQyNWZhMWNmYWIyZjU3M2Y0MTZhYjM2MWEwNzkzYzQzNjI3Nzg1M2NmYjFlYWUwNTk2YzM2OGQ2IiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','::1',NULL,NULL,NULL,NULL,1,'2025-11-04 11:19:21','2025-11-04 11:19:21'),(34,'GET','[]','http://localhost/army-mart/public/%7B%7B%20url(\'/storage/theme/1/6YvtxLLemzjpx6B9fts8WBlHnIpGTmgIcK6Wjoqc.webp','http://localhost/army-mart/public/%7B%7B%20url(\'/clothes\')%20%7D%7D','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"localhost\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"accept\":[\"image\\/avif,image\\/webp,image\\/apng,image\\/svg+xml,image\\/*,*\\/*;q=0.8\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"no-cors\"],\"sec-fetch-dest\":[\"image\"],\"referer\":[\"http:\\/\\/localhost\\/army-mart\\/public\\/%7B%7B%20url(\'\\/clothes\')%20%7D%7D\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"__clerk_db_jwt_byUN4R6R=dvb_317AykrzhBv85np3Y6NqHyxVB26; __clerk_db_jwt=dvb_317AykrzhBv85np3Y6NqHyxVB26; __stripe_mid=09a3a013-b998-4525-a2df-636a13fd5bd9933c8e; __session=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __session_byUN4R6R=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __client_uat_byUN4R6R=1758067319; __client_uat=1758067319; dark_mode=1; XSRF-TOKEN=eyJpdiI6ImRWazlOUkFWV0Q2eVV5VVQ2R1VDRXc9PSIsInZhbHVlIjoiSkNnWlNxVXBnalQyY2trYTFGK2huOWhROTNRajBIeEJKY05qYVZ0NitHRWRNb1h0dVUrT3NWSGJ5c2oyS1lhUlIvY3JLWjgyaExqT3Q0SURQM2owYTY5SkNZazV0S0dqVjdpZE0rVzVFNHludTZrQXZxU1FsWmJEYkhZS2sxb3MiLCJtYWMiOiI0YzQyNWYzZDlmOTQ2OGZiZmI3ZDFkOWM3NWYzMjA2OTQ0YmUzNmE2ZmE2YWQ3ODUwNTE4MGI3Njg2YTBlYzY3IiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6IlRpQ25MdlFLTFFNdVRGeEJyT0tPNEE9PSIsInZhbHVlIjoiaDFkNCthY3dsbHRDbjBDK0FyTVY1cVFYYy96Z0ozTjZOZmg3OFFjYTNiNE9yTnY3Mm5yQStnVkd4d3VqNjZmc3hQZ0VncjQ5MjdqcC81eE5xZExHWXhNWGc4ckpaZFUyR2F3VE50MExzeEZaUWdYSytzUTArV3FXOGRHbWZxcWYiLCJtYWMiOiI4MjI0YmNlOGQyNWZhMWNmYWIyZjU3M2Y0MTZhYjM2MWEwNzkzYzQzNjI3Nzg1M2NmYjFlYWUwNTk2YzM2OGQ2IiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','::1',NULL,NULL,NULL,NULL,1,'2025-11-04 11:19:21','2025-11-04 11:19:21'),(35,'GET','[]','http://localhost/army-mart/public/%7B%7B%20url(\'/shoes\')%20%7D%7D','http://localhost/army-mart/public/','[]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0','{\"host\":[\"localhost\"],\"connection\":[\"keep-alive\"],\"sec-ch-ua\":[\"\\\"Chromium\\\";v=\\\"142\\\", \\\"Microsoft Edge\\\";v=\\\"142\\\", \\\"Not_A Brand\\\";v=\\\"99\\\"\"],\"sec-ch-ua-mobile\":[\"?0\"],\"sec-ch-ua-platform\":[\"\\\"Windows\\\"\"],\"upgrade-insecure-requests\":[\"1\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/142.0.0.0 Safari\\/537.36 Edg\\/142.0.0.0\"],\"sec-purpose\":[\"prefetch;prerender\"],\"sec-speculation-tags\":[\"null\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.7\"],\"sec-fetch-site\":[\"same-origin\"],\"sec-fetch-mode\":[\"navigate\"],\"sec-fetch-dest\":[\"document\"],\"referer\":[\"http:\\/\\/localhost\\/army-mart\\/public\\/\"],\"accept-encoding\":[\"gzip, deflate, br, zstd\"],\"accept-language\":[\"en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ru;q=0.6,id;q=0.5\"],\"cookie\":[\"__clerk_db_jwt_byUN4R6R=dvb_317AykrzhBv85np3Y6NqHyxVB26; __clerk_db_jwt=dvb_317AykrzhBv85np3Y6NqHyxVB26; __stripe_mid=09a3a013-b998-4525-a2df-636a13fd5bd9933c8e; __session=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __session_byUN4R6R=eyJhbGciOiJSUzI1NiIsImNhdCI6ImNsX0I3ZDRQRDExMUFBQSIsImtpZCI6Imluc18zMTc5dXdzbThaSXJzZ3l0MjN5SXlRbXRreUgiLCJ0eXAiOiJKV1QifQ.eyJhenAiOiJodHRwOi8vbG9jYWxob3N0OjUxNzMiLCJleHAiOjE3NTgwNzMzMTUsImZlYSI6InU6YXJ0aWNsZV9nZW5lcmF0aW9uLHU6Y3JlYXRlX2ltYWdlLHU6cmVtb3ZlX2JhY2tncm91bmQsdTpyZW1vdmVfb2JqZWN0LHU6cmVzdW1lX3Jldmlldyx1OnRpdGxlX2dlbmVyYXRpb24iLCJmdmEiOls5OCwtMV0sImlhdCI6MTc1ODA3MzI1NSwiaXNzIjoiaHR0cHM6Ly9vYmxpZ2luZy10cm9sbC01Ny5jbGVyay5hY2NvdW50cy5kZXYiLCJuYmYiOjE3NTgwNzMyNDUsInBsYSI6InU6cHJlbWl1bSIsInNpZCI6InNlc3NfMzJucmtLbWlqMmZEeHFlN0x2ZlRKYU9zNHJUIiwic3RzIjoiYWN0aXZlIiwic3ViIjoidXNlcl8zMm5uQkZvM2pCUzUxM1p1aXVic1cybGRTRDEiLCJ2IjoyfQ.HV9MdMJNvjZQ2YU_McID8tV09nlARV7XHvkNVFNp-MHXvbP8G1HxrMZanM5Nup3edKmlJCVlKXvNUsBfQkEYG39VFOU6xG0reyixPJjZXCnQ2ZNCrckEs6ITf1RxpSdW1tXYfRpKAiGw7MKFtSNAgaAdtF1SGWh9PB3kIonQZxNaTFvC-gPX1M7aLCTr7GyhpW0XYbl8cVegogtFsGM0Jfy4l6nwvPP1QILvN0xmNzI5nElEdel_8eJnkaoXQogEW-SaMjbDwDY9Q9P9ugfN8dN-loUDlX2SUIxtwplH1vkHTEeIxEPYKFYaOqJf8MkcSjybmqJeD65ySEvxNg1CbA; __client_uat_byUN4R6R=1758067319; __client_uat=1758067319; dark_mode=1; laravel_session=eyJpdiI6IjlSQWFISU5FVHVVRzBveEtobmQ5emc9PSIsInZhbHVlIjoiTkxGQ1o5V3VPbndVRWZzYlBtQWRzdUlHWXBnekNZYWpTZW0xdGhjOFhSenhZWTdGcjIyTXNKbmRKeEFsSzF0STBiRnVPWkNtTW0xeUlLTmFMOWJMeVNqUFRKY3RrdFgzQ1VPaUQvUm5EbHFqcDA3VmJKd0lVNDNsY0FJck5OYTYiLCJtYWMiOiJkYjJhNTk1NjU1MWYxYjEyZjU1NDk4YzlhOGE1NWQ3NzU3ZTBhZTg3MDgzYWQzZjVhNjUwOTA4MjliYzU1NzY4IiwidGFnIjoiIn0%3D; XSRF-TOKEN=eyJpdiI6Ijh2QWpXVW0yUURmY0ZRcTVVNTlNNHc9PSIsInZhbHVlIjoiWEtBYmN3UUpIYjcwYUVOMURUcUNoenNVV2hyZmdZdjRlVzU2Y0NKak9rT1NjNnFra3VadnREa3hJQTdSNHdtSGM1bGUxdmgzSERVVUxpdjg2MEFkaDZpUzB6WTd6ZjR5ajVnRkNVZFNKRVlxdFB5TjEvRTRERTFXK3cxR1dQdGkiLCJtYWMiOiI4NzAyZGQ5NDljNTM4NmE3NzcwZWRmODM1OTMzYzg0ZmIzZGE4ZjlmMzQ5ZjIyMWQ5ZGM3NGExZmRkZTA4ZTRhIiwidGFnIjoiIn0%3D; army_mart_session=eyJpdiI6ImNWT25WKzJlNEU1aU5BU0dnU1BMcFE9PSIsInZhbHVlIjoiRGthWVU4US8vdU9wRkJydGNvenV1Q3YzNk4zaXMxWFFvQmhKMHM4V1lPUlJJejlnM3VPdWhyOW9YYkVGby9MQmcrUnlzakd1NkkwWUtjMkdUeENJaVorVUQwbm1kUXkrTEhjZVJHOHMwMkRlVWpsY0ZnU2dic0VNU3ZwREl5bFoiLCJtYWMiOiJkNmM3ZTJmMzgxZDBlNzVlZTg5ZDNmNGEwNzJkYzJkNGZhMTk0Y2M2ZGVjMTFiMzliYzBlODc1NjUzMTJjYzBmIiwidGFnIjoiIn0%3D\"]}','','Windows','Edge','::1',NULL,NULL,NULL,NULL,1,'2025-11-04 11:25:38','2025-11-04 11:25:38');
/*!40000 ALTER TABLE `visits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wishlist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `item_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`item_options`)),
  `moved_to_cart` date DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  `time_of_moving` date DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wishlist_channel_id_foreign` (`channel_id`),
  KEY `wishlist_product_id_foreign` (`product_id`),
  KEY `wishlist_customer_id_foreign` (`customer_id`),
  CONSTRAINT `wishlist_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist_items`
--

DROP TABLE IF EXISTS `wishlist_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wishlist_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `moved_to_cart` date DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wishlist_items_channel_id_foreign` (`channel_id`),
  KEY `wishlist_items_product_id_foreign` (`product_id`),
  KEY `wishlist_items_customer_id_foreign` (`customer_id`),
  CONSTRAINT `wishlist_items_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_items_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist_items`
--

LOCK TABLES `wishlist_items` WRITE;
/*!40000 ALTER TABLE `wishlist_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist_items` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-04 17:58:40

