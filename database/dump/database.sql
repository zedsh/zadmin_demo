-- MySQL dump 10.13  Distrib 5.7.28, for Linux (x86_64)
--
-- Host: localhost    Database: dev
-- ------------------------------------------------------
-- Server version	5.7.28

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
-- Table structure for table `artist_socials`
--

DROP TABLE IF EXISTS `artist_socials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist_socials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `artist_id` bigint(20) unsigned NOT NULL,
  `social_id` bigint(20) unsigned NOT NULL,
  `link` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `artist_socials_artist_id_foreign` (`artist_id`),
  KEY `artist_socials_social_id_foreign` (`social_id`),
  CONSTRAINT `artist_socials_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `artist_socials_social_id_foreign` FOREIGN KEY (`social_id`) REFERENCES `socials` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_socials`
--

LOCK TABLES `artist_socials` WRITE;
/*!40000 ALTER TABLE `artist_socials` DISABLE KEYS */;
INSERT INTO `artist_socials` VALUES (1,1,1,'http://ya.ru');
/*!40000 ALTER TABLE `artist_socials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist_types`
--

DROP TABLE IF EXISTS `artist_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `artist_types_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_types`
--

LOCK TABLES `artist_types` WRITE;
/*!40000 ALTER TABLE `artist_types` DISABLE KEYS */;
INSERT INTO `artist_types` VALUES (1,'Артисты','artists'),(2,'Ведущие','leading'),(3,'Юмористы','comedians'),(4,'Режиссёры','producers');
/*!40000 ALTER TABLE `artist_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artists`
--

DROP TABLE IF EXISTS `artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `artist_type_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `artists_artist_type_id_foreign` (`artist_type_id`),
  FULLTEXT KEY `artists_name_full` (`name`),
  CONSTRAINT `artists_artist_type_id_foreign` FOREIGN KEY (`artist_type_id`) REFERENCES `artist_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artists`
--

LOCK TABLES `artists` WRITE;
/*!40000 ALTER TABLE `artists` DISABLE KEYS */;
INSERT INTO `artists` VALUES (1,1,'Сергей И́горевич Пахомов','<p>Я вообще был художником, картины рисовал в середине восьмидесятых.</p>\r\n<p>И все иностранцы ко мне приходили, там, послы разные, и давали мне очень много денег за картины и потом их в музеях разных выставляли.</p>','artists/January2020/09LpiAcycqVdjy7M7lzE.jpg','2020-01-26 09:47:00','2020-01-26 11:02:22'),(2,1,'Филип Киркоров','<p>Цвет настроения синий</p>','artists/January2020/KlKopNcjtejCTMKyxDRw.jpg','2020-01-26 11:57:53','2020-01-26 11:57:53');
/*!40000 ALTER TABLE `artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,NULL,1,'Category 1','category-1','2020-01-26 07:51:00','2020-01-26 07:51:00'),(2,NULL,1,'Category 2','category-2','2020-01-26 07:51:00','2020-01-26 07:51:00');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_rows`
--

DROP TABLE IF EXISTS `data_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_rows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_type_id` int(10) unsigned NOT NULL,
  `field` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `browse` tinyint(1) NOT NULL DEFAULT '1',
  `read` tinyint(1) NOT NULL DEFAULT '1',
  `edit` tinyint(1) NOT NULL DEFAULT '1',
  `add` tinyint(1) NOT NULL DEFAULT '1',
  `delete` tinyint(1) NOT NULL DEFAULT '1',
  `details` text COLLATE utf8mb4_unicode_ci,
  `order` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `data_rows_data_type_id_foreign` (`data_type_id`),
  CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_rows`
--

LOCK TABLES `data_rows` WRITE;
/*!40000 ALTER TABLE `data_rows` DISABLE KEYS */;
INSERT INTO `data_rows` VALUES (1,1,'id','number','ID',1,0,0,0,0,0,NULL,1),(2,1,'name','text','Имя',1,1,1,1,1,1,NULL,2),(3,1,'email','text','Email',1,1,1,1,1,1,NULL,3),(4,1,'password','password','Пароль',1,0,0,1,1,0,NULL,4),(5,1,'remember_token','text','Токен восстановления',0,0,0,0,0,0,NULL,5),(6,1,'created_at','timestamp','Дата создания',0,1,1,0,0,0,NULL,6),(7,1,'updated_at','timestamp','Дата обновления',0,0,0,0,0,0,NULL,7),(8,1,'avatar','image','Аватар',0,1,1,1,1,1,NULL,8),(9,1,'user_belongsto_role_relationship','relationship','Роль',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":0}',10),(10,1,'user_belongstomany_role_relationship','relationship','Roles',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}',11),(11,1,'settings','hidden','Settings',0,0,0,0,0,0,NULL,12),(12,2,'id','number','ID',1,0,0,0,0,0,NULL,1),(13,2,'name','text','Имя',1,1,1,1,1,1,NULL,2),(14,2,'created_at','timestamp','Дата создания',0,0,0,0,0,0,NULL,3),(15,2,'updated_at','timestamp','Дата обновления',0,0,0,0,0,0,NULL,4),(16,3,'id','number','ID',1,0,0,0,0,0,NULL,1),(17,3,'name','text','Имя',1,1,1,1,1,1,NULL,2),(18,3,'created_at','timestamp','Дата создания',0,0,0,0,0,0,NULL,3),(19,3,'updated_at','timestamp','Дата обновления',0,0,0,0,0,0,NULL,4),(20,3,'display_name','text','Отображаемое имя',1,1,1,1,1,1,NULL,5),(21,1,'role_id','text','Роль',1,1,1,1,1,1,NULL,9),(22,4,'id','number','ID',1,0,0,0,0,0,NULL,1),(23,4,'parent_id','select_dropdown','Родитель',0,0,1,1,1,1,'{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- None --\"},\"relationship\":{\"key\":\"id\",\"label\":\"name\"}}',2),(24,4,'order','text','Сортировка',1,1,1,1,1,1,'{\"default\":1}',3),(25,4,'name','text','Имя',1,1,1,1,1,1,NULL,4),(26,4,'slug','text','Slug (ЧПУ)',1,1,1,1,1,1,'{\"slugify\":{\"origin\":\"name\"}}',5),(27,4,'created_at','timestamp','Дата создания',0,0,1,0,0,0,NULL,6),(28,4,'updated_at','timestamp','Дата обновления',0,0,0,0,0,0,NULL,7),(29,5,'id','number','ID',1,0,0,0,0,0,NULL,1),(30,5,'author_id','text','Автор',1,0,1,1,0,1,NULL,2),(31,5,'category_id','text','Категория',1,0,1,1,1,0,NULL,3),(32,5,'title','text','Название',1,1,1,1,1,1,NULL,4),(33,5,'excerpt','text_area','Отрывок',1,0,1,1,1,1,NULL,5),(34,5,'body','rich_text_box','Содержимое',1,0,1,1,1,1,NULL,6),(35,5,'image','image','Изображение Статьи',0,1,1,1,1,1,'{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}',7),(36,5,'slug','text','Slug (ЧПУ)',1,0,1,1,1,1,'{\"slugify\":{\"origin\":\"title\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:posts,slug\"}}',8),(37,5,'meta_description','text_area','Meta Description',1,0,1,1,1,1,NULL,9),(38,5,'meta_keywords','text_area','Meta Keywords',1,0,1,1,1,1,NULL,10),(39,5,'status','select_dropdown','Статус',1,1,1,1,1,1,'{\"default\":\"DRAFT\",\"options\":{\"PUBLISHED\":\"published\",\"DRAFT\":\"draft\",\"PENDING\":\"pending\"}}',11),(40,5,'created_at','timestamp','Дата создания',0,1,1,0,0,0,NULL,12),(41,5,'updated_at','timestamp','Дата обновления',0,0,0,0,0,0,NULL,13),(42,5,'seo_title','text','SEO Название',0,1,1,1,1,1,NULL,14),(43,5,'featured','checkbox','Рекомендовано',1,1,1,1,1,1,NULL,15),(44,6,'id','number','ID',1,0,0,0,0,0,NULL,1),(45,6,'author_id','text','Автор',1,0,0,0,0,0,NULL,2),(46,6,'title','text','Название',1,1,1,1,1,1,NULL,3),(47,6,'excerpt','text_area','Отрывок',1,0,1,1,1,1,NULL,4),(48,6,'body','rich_text_box','Содержимое',1,0,1,1,1,1,NULL,5),(49,6,'slug','text','Slug (ЧПУ)',1,0,1,1,1,1,'{\"slugify\":{\"origin\":\"title\"},\"validation\":{\"rule\":\"unique:pages,slug\"}}',6),(50,6,'meta_description','text','Meta Description',1,0,1,1,1,1,NULL,7),(51,6,'meta_keywords','text','Meta Keywords',1,0,1,1,1,1,NULL,8),(52,6,'status','select_dropdown','Статус',1,1,1,1,1,1,'{\"default\":\"INACTIVE\",\"options\":{\"INACTIVE\":\"INACTIVE\",\"ACTIVE\":\"ACTIVE\"}}',9),(53,6,'created_at','timestamp','Дата создания',1,1,1,0,0,0,NULL,10),(54,6,'updated_at','timestamp','Дата обновления',1,0,0,0,0,0,NULL,11),(55,6,'image','image','Изображение Страницы',0,1,1,1,1,1,NULL,12),(56,8,'id','text','Id',1,0,0,0,0,0,'{}',1),(57,8,'name','text','Название',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',2),(58,8,'slug','text','Символьный код',1,1,1,1,1,1,'{\"slugify\":{\"origin\":\"name\",\"forceUpdate\":false}}',3),(59,9,'id','text','Id',1,0,0,0,0,0,'{}',1),(60,9,'name','text','Название',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',2),(61,9,'slug','text','Символьный код',1,1,1,1,1,1,'{\"slugify\":{\"origin\":\"name\",\"forceUpdate\":false},\"validation\":{\"rule\":\"required\"}}',3),(62,10,'id','text','Id',1,0,0,0,0,0,'{}',1),(63,10,'artist_type_id','text','Artist Type Id',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',2),(64,10,'name','text','Имя',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',3),(65,10,'description','rich_text_box','Описание',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',4),(66,10,'photo','image','Фото',1,1,1,1,1,1,'{}',5),(67,10,'artist_belongsto_artist_type_relationship','relationship','Тип артиста',0,1,1,1,1,1,'{\"model\":\"App\\\\ArtistType\",\"table\":\"artist_types\",\"type\":\"belongsTo\",\"column\":\"artist_type_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"artist_socials\",\"pivot\":\"0\",\"taggable\":\"0\"}',6),(68,10,'created_at','timestamp','Created At',0,1,1,1,0,1,'{}',6),(69,10,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'{}',7),(70,11,'id','text','Id',1,0,0,0,0,0,'{}',1),(71,11,'artist_id','text','Artist Id',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',2),(72,11,'social_id','text','Social Id',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',3),(73,11,'link','text','Ссылка',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required|url\"}}',4),(75,11,'artist_social_belongsto_social_relationship','relationship','Социальная сеть',0,1,1,1,1,1,'{\"model\":\"App\\\\Social\",\"table\":\"socials\",\"type\":\"belongsTo\",\"column\":\"social_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"artist_socials\",\"pivot\":\"0\",\"taggable\":\"0\"}',5),(76,11,'artist_social_belongsto_artist_relationship','relationship','Артист',0,1,1,1,1,1,'{\"model\":\"App\\\\Artist\",\"table\":\"artists\",\"type\":\"belongsTo\",\"column\":\"artist_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"artist_socials\",\"pivot\":\"0\",\"taggable\":\"0\"}',6);
/*!40000 ALTER TABLE `data_rows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_types`
--

DROP TABLE IF EXISTS `data_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_singular` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_plural` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `policy_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `controller` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT '0',
  `server_side` tinyint(4) NOT NULL DEFAULT '0',
  `details` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_types_name_unique` (`name`),
  UNIQUE KEY `data_types_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_types`
--

LOCK TABLES `data_types` WRITE;
/*!40000 ALTER TABLE `data_types` DISABLE KEYS */;
INSERT INTO `data_types` VALUES (1,'users','users','Пользователь','Пользователи','voyager-person','TCG\\Voyager\\Models\\User','TCG\\Voyager\\Policies\\UserPolicy','TCG\\Voyager\\Http\\Controllers\\VoyagerUserController','',1,0,NULL,'2020-01-26 07:50:59','2020-01-26 07:50:59'),(2,'menus','menus','Меню','Меню','voyager-list','TCG\\Voyager\\Models\\Menu',NULL,'','',1,0,NULL,'2020-01-26 07:50:59','2020-01-26 07:50:59'),(3,'roles','roles','Роль','Роли','voyager-lock','TCG\\Voyager\\Models\\Role',NULL,'','',1,0,NULL,'2020-01-26 07:50:59','2020-01-26 07:50:59'),(4,'categories','categories','Категория','Категории','voyager-categories','TCG\\Voyager\\Models\\Category',NULL,'','',1,0,NULL,'2020-01-26 07:51:00','2020-01-26 07:51:00'),(5,'posts','posts','Статья','Статьи','voyager-news','TCG\\Voyager\\Models\\Post','TCG\\Voyager\\Policies\\PostPolicy','','',1,0,NULL,'2020-01-26 07:51:00','2020-01-26 07:51:00'),(6,'pages','pages','Страница','Страницы','voyager-file-text','TCG\\Voyager\\Models\\Page',NULL,'','',1,0,NULL,'2020-01-26 07:51:00','2020-01-26 07:51:00'),(8,'artist_types','artist-types','Тип артистов','Типы артистов',NULL,'App\\ArtistType',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2020-01-26 07:53:16','2020-01-26 10:00:06'),(9,'socials','socials','Социальная сеть','Социальные сети',NULL,'App\\Social',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2020-01-26 09:23:04','2020-01-26 10:01:48'),(10,'artists','artists','Артист','Артисты','voyager-people','App\\Artist',NULL,NULL,NULL,1,1,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"name\",\"scope\":null}','2020-01-26 09:25:16','2020-01-26 11:11:25'),(11,'artist_socials','artist-socials','Социальная сеть артиста','Социальные сети артистов',NULL,'App\\ArtistSocial',NULL,NULL,NULL,1,1,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2020-01-26 09:52:07','2020-01-26 09:59:54');
/*!40000 ALTER TABLE `data_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(10) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `menu_items_menu_id_foreign` (`menu_id`),
  CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES (1,1,'Панель управления','','_self','voyager-boat',NULL,NULL,1,'2020-01-26 07:50:59','2020-01-26 07:50:59','voyager.dashboard',NULL),(2,1,'Медиа','','_self','voyager-images',NULL,5,5,'2020-01-26 07:50:59','2020-01-26 11:17:31','voyager.media.index',NULL),(3,1,'Пользователи','','_self','voyager-person',NULL,5,2,'2020-01-26 07:50:59','2020-01-26 11:17:31','voyager.users.index',NULL),(4,1,'Роли','','_self','voyager-lock',NULL,5,7,'2020-01-26 07:50:59','2020-01-26 11:17:31','voyager.roles.index',NULL),(5,1,'Инструменты','','_self','voyager-tools',NULL,NULL,2,'2020-01-26 07:50:59','2020-01-26 11:04:52',NULL,NULL),(6,1,'Конструктор Меню','','_self','voyager-list',NULL,5,8,'2020-01-26 07:50:59','2020-01-26 11:17:31','voyager.menus.index',NULL),(7,1,'База данных','','_self','voyager-data',NULL,5,9,'2020-01-26 07:50:59','2020-01-26 11:17:31','voyager.database.index',NULL),(8,1,'Compass','','_self','voyager-compass',NULL,5,10,'2020-01-26 07:50:59','2020-01-26 11:17:31','voyager.compass.index',NULL),(9,1,'BREAD','','_self','voyager-bread',NULL,5,11,'2020-01-26 07:50:59','2020-01-26 11:17:31','voyager.bread.index',NULL),(10,1,'Настройки','','_self','voyager-settings',NULL,5,1,'2020-01-26 07:50:59','2020-01-26 11:17:31','voyager.settings.index',NULL),(11,1,'Категории','','_self','voyager-categories',NULL,5,3,'2020-01-26 07:51:00','2020-01-26 11:17:31','voyager.categories.index',NULL),(12,1,'Статьи','','_self','voyager-news',NULL,5,6,'2020-01-26 07:51:00','2020-01-26 11:17:31','voyager.posts.index',NULL),(13,1,'Страницы','','_self','voyager-file-text',NULL,5,4,'2020-01-26 07:51:00','2020-01-26 11:17:31','voyager.pages.index',NULL),(14,1,'Hooks','','_self','voyager-hook',NULL,5,12,'2020-01-26 07:51:00','2020-01-26 11:17:31','voyager.hooks',NULL),(15,1,'Типы артистов','','_self','voyager-certificate','#000000',NULL,3,'2020-01-26 07:53:16','2020-01-26 11:17:31','voyager.artist-types.index','null'),(16,1,'Социальные сети','','_self','voyager-facebook','#000000',NULL,4,'2020-01-26 09:23:04','2020-01-26 11:17:31','voyager.socials.index','null'),(17,1,'Артисты','','_self','voyager-people','#000000',NULL,5,'2020-01-26 09:25:16','2020-01-26 11:17:31','voyager.artists.index','null'),(18,1,'Социальные сети артистов','','_self','voyager-medal-rank-star','#000000',NULL,6,'2020-01-26 09:52:07','2020-01-26 11:17:31','voyager.artist-socials.index','null');
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'admin','2020-01-26 07:50:59','2020-01-26 07:50:59');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (31,'2014_10_12_000000_create_users_table',1),(32,'2014_10_12_100000_create_password_resets_table',1),(33,'2016_01_01_000000_add_voyager_user_fields',1),(34,'2016_01_01_000000_create_data_types_table',1),(35,'2016_01_01_000000_create_pages_table',1),(36,'2016_01_01_000000_create_posts_table',1),(37,'2016_02_15_204651_create_categories_table',1),(38,'2016_05_19_173453_create_menu_table',1),(39,'2016_10_21_190000_create_roles_table',1),(40,'2016_10_21_190000_create_settings_table',1),(41,'2016_11_30_135954_create_permission_table',1),(42,'2016_11_30_141208_create_permission_role_table',1),(43,'2016_12_26_201236_data_types__add__server_side',1),(44,'2017_01_13_000000_add_route_to_menu_items_table',1),(45,'2017_01_14_005015_create_translations_table',1),(46,'2017_01_15_000000_make_table_name_nullable_in_permissions_table',1),(47,'2017_03_06_000000_add_controller_to_data_types_table',1),(48,'2017_04_11_000000_alter_post_nullable_fields_table',1),(49,'2017_04_21_000000_add_order_to_data_rows_table',1),(50,'2017_07_05_210000_add_policyname_to_data_types_table',1),(51,'2017_08_05_000000_add_group_to_settings_table',1),(52,'2017_11_26_013050_add_user_role_relationship',1),(53,'2017_11_26_015000_create_user_roles_table',1),(54,'2018_03_11_000000_add_user_settings',1),(55,'2018_03_14_000000_add_details_to_data_types_table',1),(56,'2018_03_16_000000_make_settings_value_nullable',1),(57,'2020_01_25_224404_create_artist_types_table',1),(58,'2020_01_25_224407_create_artists_table',1),(59,'2020_01_26_104058_create_socials_table',1),(60,'2020_01_26_105643_create_artist_socials_table',1),(61,'2020_01_26_124248_update_artists_table',2),(62,'2020_01_26_152144_change_artists_table_add_fulltext',3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci,
  `body` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,0,'Hello World','Hang the jib grog grog blossom grapple dance the hempen jig gangway pressgang bilge rat to go on account lugger. Nelsons folly gabion line draught scallywag fire ship gaff fluke fathom case shot. Sea Legs bilge rat sloop matey gabion long clothes run a shot across the bow Gold Road cog league.','<p>Hello World. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>','pages/page1.jpg','hello-world','Yar Meta Description','Keyword1, Keyword2','ACTIVE','2020-01-26 07:51:00','2020-01-26 07:51:00');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
-- Table structure for table `permission_role`
--

DROP TABLE IF EXISTS `permission_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_role` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_permission_id_index` (`permission_id`),
  KEY `permission_role_role_id_index` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_role`
--

LOCK TABLES `permission_role` WRITE;
/*!40000 ALTER TABLE `permission_role` DISABLE KEYS */;
INSERT INTO `permission_role` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1),(39,1),(40,1),(42,1),(43,1),(44,1),(45,1),(46,1),(47,1),(48,1),(49,1),(50,1),(51,1),(52,1),(53,1),(54,1),(55,1),(56,1),(57,1),(58,1),(59,1),(60,1),(61,1);
/*!40000 ALTER TABLE `permission_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'browse_admin',NULL,'2020-01-26 07:50:59','2020-01-26 07:50:59'),(2,'browse_bread',NULL,'2020-01-26 07:50:59','2020-01-26 07:50:59'),(3,'browse_database',NULL,'2020-01-26 07:51:00','2020-01-26 07:51:00'),(4,'browse_media',NULL,'2020-01-26 07:51:00','2020-01-26 07:51:00'),(5,'browse_compass',NULL,'2020-01-26 07:51:00','2020-01-26 07:51:00'),(6,'browse_menus','menus','2020-01-26 07:51:00','2020-01-26 07:51:00'),(7,'read_menus','menus','2020-01-26 07:51:00','2020-01-26 07:51:00'),(8,'edit_menus','menus','2020-01-26 07:51:00','2020-01-26 07:51:00'),(9,'add_menus','menus','2020-01-26 07:51:00','2020-01-26 07:51:00'),(10,'delete_menus','menus','2020-01-26 07:51:00','2020-01-26 07:51:00'),(11,'browse_roles','roles','2020-01-26 07:51:00','2020-01-26 07:51:00'),(12,'read_roles','roles','2020-01-26 07:51:00','2020-01-26 07:51:00'),(13,'edit_roles','roles','2020-01-26 07:51:00','2020-01-26 07:51:00'),(14,'add_roles','roles','2020-01-26 07:51:00','2020-01-26 07:51:00'),(15,'delete_roles','roles','2020-01-26 07:51:00','2020-01-26 07:51:00'),(16,'browse_users','users','2020-01-26 07:51:00','2020-01-26 07:51:00'),(17,'read_users','users','2020-01-26 07:51:00','2020-01-26 07:51:00'),(18,'edit_users','users','2020-01-26 07:51:00','2020-01-26 07:51:00'),(19,'add_users','users','2020-01-26 07:51:00','2020-01-26 07:51:00'),(20,'delete_users','users','2020-01-26 07:51:00','2020-01-26 07:51:00'),(21,'browse_settings','settings','2020-01-26 07:51:00','2020-01-26 07:51:00'),(22,'read_settings','settings','2020-01-26 07:51:00','2020-01-26 07:51:00'),(23,'edit_settings','settings','2020-01-26 07:51:00','2020-01-26 07:51:00'),(24,'add_settings','settings','2020-01-26 07:51:00','2020-01-26 07:51:00'),(25,'delete_settings','settings','2020-01-26 07:51:00','2020-01-26 07:51:00'),(26,'browse_categories','categories','2020-01-26 07:51:00','2020-01-26 07:51:00'),(27,'read_categories','categories','2020-01-26 07:51:00','2020-01-26 07:51:00'),(28,'edit_categories','categories','2020-01-26 07:51:00','2020-01-26 07:51:00'),(29,'add_categories','categories','2020-01-26 07:51:00','2020-01-26 07:51:00'),(30,'delete_categories','categories','2020-01-26 07:51:00','2020-01-26 07:51:00'),(31,'browse_posts','posts','2020-01-26 07:51:00','2020-01-26 07:51:00'),(32,'read_posts','posts','2020-01-26 07:51:00','2020-01-26 07:51:00'),(33,'edit_posts','posts','2020-01-26 07:51:00','2020-01-26 07:51:00'),(34,'add_posts','posts','2020-01-26 07:51:00','2020-01-26 07:51:00'),(35,'delete_posts','posts','2020-01-26 07:51:00','2020-01-26 07:51:00'),(36,'browse_pages','pages','2020-01-26 07:51:00','2020-01-26 07:51:00'),(37,'read_pages','pages','2020-01-26 07:51:00','2020-01-26 07:51:00'),(38,'edit_pages','pages','2020-01-26 07:51:00','2020-01-26 07:51:00'),(39,'add_pages','pages','2020-01-26 07:51:00','2020-01-26 07:51:00'),(40,'delete_pages','pages','2020-01-26 07:51:00','2020-01-26 07:51:00'),(41,'browse_hooks',NULL,'2020-01-26 07:51:00','2020-01-26 07:51:00'),(42,'browse_artist_types','artist_types','2020-01-26 07:53:16','2020-01-26 07:53:16'),(43,'read_artist_types','artist_types','2020-01-26 07:53:16','2020-01-26 07:53:16'),(44,'edit_artist_types','artist_types','2020-01-26 07:53:16','2020-01-26 07:53:16'),(45,'add_artist_types','artist_types','2020-01-26 07:53:16','2020-01-26 07:53:16'),(46,'delete_artist_types','artist_types','2020-01-26 07:53:16','2020-01-26 07:53:16'),(47,'browse_socials','socials','2020-01-26 09:23:04','2020-01-26 09:23:04'),(48,'read_socials','socials','2020-01-26 09:23:04','2020-01-26 09:23:04'),(49,'edit_socials','socials','2020-01-26 09:23:04','2020-01-26 09:23:04'),(50,'add_socials','socials','2020-01-26 09:23:04','2020-01-26 09:23:04'),(51,'delete_socials','socials','2020-01-26 09:23:04','2020-01-26 09:23:04'),(52,'browse_artists','artists','2020-01-26 09:25:16','2020-01-26 09:25:16'),(53,'read_artists','artists','2020-01-26 09:25:16','2020-01-26 09:25:16'),(54,'edit_artists','artists','2020-01-26 09:25:16','2020-01-26 09:25:16'),(55,'add_artists','artists','2020-01-26 09:25:16','2020-01-26 09:25:16'),(56,'delete_artists','artists','2020-01-26 09:25:16','2020-01-26 09:25:16'),(57,'browse_artist_socials','artist_socials','2020-01-26 09:52:07','2020-01-26 09:52:07'),(58,'read_artist_socials','artist_socials','2020-01-26 09:52:07','2020-01-26 09:52:07'),(59,'edit_artist_socials','artist_socials','2020-01-26 09:52:07','2020-01-26 09:52:07'),(60,'add_artist_socials','artist_socials','2020-01-26 09:52:07','2020-01-26 09:52:07'),(61,'delete_artist_socials','artist_socials','2020-01-26 09:52:07','2020-01-26 09:52:07');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci,
  `status` enum('PUBLISHED','DRAFT','PENDING') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,0,NULL,'Lorem Ipsum Post',NULL,'This is the excerpt for the Lorem Ipsum Post','<p>This is the body of the lorem ipsum post</p>','posts/post1.jpg','lorem-ipsum-post','This is the meta description','keyword1, keyword2, keyword3','PUBLISHED',0,'2020-01-26 07:51:00','2020-01-26 07:51:00'),(2,0,NULL,'My Sample Post',NULL,'This is the excerpt for the sample Post','<p>This is the body for the sample post, which includes the body.</p>\n                <h2>We can use all kinds of format!</h2>\n                <p>And include a bunch of other stuff.</p>','posts/post2.jpg','my-sample-post','Meta Description for sample post','keyword1, keyword2, keyword3','PUBLISHED',0,'2020-01-26 07:51:00','2020-01-26 07:51:00'),(3,0,NULL,'Latest Post',NULL,'This is the excerpt for the latest post','<p>This is the body for the latest post</p>','posts/post3.jpg','latest-post','This is the meta description','keyword1, keyword2, keyword3','PUBLISHED',0,'2020-01-26 07:51:00','2020-01-26 07:51:00'),(4,0,NULL,'Yarr Post',NULL,'Reef sails nipperkin bring a spring upon her cable coffer jury mast spike marooned Pieces of Eight poop deck pillage. Clipper driver coxswain galleon hempen halter come about pressgang gangplank boatswain swing the lead. Nipperkin yard skysail swab lanyard Blimey bilge water ho quarter Buccaneer.','<p>Swab deadlights Buccaneer fire ship square-rigged dance the hempen jig weigh anchor cackle fruit grog furl. Crack Jennys tea cup chase guns pressgang hearties spirits hogshead Gold Road six pounders fathom measured fer yer chains. Main sheet provost come about trysail barkadeer crimp scuttle mizzenmast brig plunder.</p>\n<p>Mizzen league keelhaul galleon tender cog chase Barbary Coast doubloon crack Jennys tea cup. Blow the man down lugsail fire ship pinnace cackle fruit line warp Admiral of the Black strike colors doubloon. Tackle Jack Ketch come about crimp rum draft scuppers run a shot across the bow haul wind maroon.</p>\n<p>Interloper heave down list driver pressgang holystone scuppers tackle scallywag bilged on her anchor. Jack Tar interloper draught grapple mizzenmast hulk knave cable transom hogshead. Gaff pillage to go on account grog aft chase guns piracy yardarm knave clap of thunder.</p>','posts/post4.jpg','yarr-post','this be a meta descript','keyword1, keyword2, keyword3','PUBLISHED',0,'2020-01-26 07:51:00','2020-01-26 07:51:00');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','Администратор','2020-01-26 07:50:59','2020-01-26 07:50:59'),(2,'user','Обычный Пользователь','2020-01-26 07:50:59','2020-01-26 07:50:59');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `details` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'site.title','Название Сайта','Название Сайта','','text',1,'Site'),(2,'site.description','Описание Сайта','Описание Сайта','','text',2,'Site'),(3,'site.logo','Логотип Сайта','','','image',3,'Site'),(4,'site.google_analytics_tracking_id','Google Analytics Tracking ID',NULL,'','text',4,'Site'),(5,'admin.bg_image','Фоновое Изображение для Админки','','','image',5,'Admin'),(6,'admin.title','Название Админки','Voyager','','text',1,'Admin'),(7,'admin.description','Описание Админки','Добро пожаловать в Voyager. Пропавшую Админку для Laravel','','text',2,'Admin'),(8,'admin.loader','Загрузчик Админки','','','image',3,'Admin'),(9,'admin.icon_image','Иконка Админки','','','image',4,'Admin'),(10,'admin.google_analytics_client_id','Google Analytics Client ID (используется для панели администратора)',NULL,'','text',1,'Admin'),(11,'site.paginateCount','Элементов в пагинации','1',NULL,'text',6,'Site');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socials`
--

DROP TABLE IF EXISTS `socials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socials_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socials`
--

LOCK TABLES `socials` WRITE;
/*!40000 ALTER TABLE `socials` DISABLE KEYS */;
INSERT INTO `socials` VALUES (1,'Vk','vk'),(2,'Facebook','facebook'),(3,'Instagram','instagram'),(4,'Twitter','twitter'),(5,'Ok','ok'),(6,'Web-сайт','web');
/*!40000 ALTER TABLE `socials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foreign_key` int(10) unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations`
--

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
INSERT INTO `translations` VALUES (1,'data_types','display_name_singular',5,'pt','Post','2020-01-26 07:51:00','2020-01-26 07:51:00'),(2,'data_types','display_name_singular',6,'pt','Página','2020-01-26 07:51:00','2020-01-26 07:51:00'),(3,'data_types','display_name_singular',1,'pt','Utilizador','2020-01-26 07:51:00','2020-01-26 07:51:00'),(4,'data_types','display_name_singular',4,'pt','Categoria','2020-01-26 07:51:00','2020-01-26 07:51:00'),(5,'data_types','display_name_singular',2,'pt','Menu','2020-01-26 07:51:00','2020-01-26 07:51:00'),(6,'data_types','display_name_singular',3,'pt','Função','2020-01-26 07:51:00','2020-01-26 07:51:00'),(7,'data_types','display_name_plural',5,'pt','Posts','2020-01-26 07:51:00','2020-01-26 07:51:00'),(8,'data_types','display_name_plural',6,'pt','Páginas','2020-01-26 07:51:00','2020-01-26 07:51:00'),(9,'data_types','display_name_plural',1,'pt','Utilizadores','2020-01-26 07:51:00','2020-01-26 07:51:00'),(10,'data_types','display_name_plural',4,'pt','Categorias','2020-01-26 07:51:00','2020-01-26 07:51:00'),(11,'data_types','display_name_plural',2,'pt','Menus','2020-01-26 07:51:00','2020-01-26 07:51:00'),(12,'data_types','display_name_plural',3,'pt','Funções','2020-01-26 07:51:00','2020-01-26 07:51:00'),(13,'categories','slug',1,'pt','categoria-1','2020-01-26 07:51:00','2020-01-26 07:51:00'),(14,'categories','name',1,'pt','Categoria 1','2020-01-26 07:51:00','2020-01-26 07:51:00'),(15,'categories','slug',2,'pt','categoria-2','2020-01-26 07:51:00','2020-01-26 07:51:00'),(16,'categories','name',2,'pt','Categoria 2','2020-01-26 07:51:00','2020-01-26 07:51:00'),(17,'pages','title',1,'pt','Olá Mundo','2020-01-26 07:51:00','2020-01-26 07:51:00'),(18,'pages','slug',1,'pt','ola-mundo','2020-01-26 07:51:00','2020-01-26 07:51:00'),(19,'pages','body',1,'pt','<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>','2020-01-26 07:51:00','2020-01-26 07:51:00'),(20,'menu_items','title',1,'pt','Painel de Controle','2020-01-26 07:51:00','2020-01-26 07:51:00'),(21,'menu_items','title',2,'pt','Media','2020-01-26 07:51:00','2020-01-26 07:51:00'),(22,'menu_items','title',12,'pt','Publicações','2020-01-26 07:51:00','2020-01-26 07:51:00'),(23,'menu_items','title',3,'pt','Utilizadores','2020-01-26 07:51:00','2020-01-26 07:51:00'),(24,'menu_items','title',11,'pt','Categorias','2020-01-26 07:51:00','2020-01-26 07:51:00'),(25,'menu_items','title',13,'pt','Páginas','2020-01-26 07:51:00','2020-01-26 07:51:00'),(26,'menu_items','title',4,'pt','Funções','2020-01-26 07:51:00','2020-01-26 07:51:00'),(27,'menu_items','title',5,'pt','Ferramentas','2020-01-26 07:51:00','2020-01-26 07:51:00'),(28,'menu_items','title',6,'pt','Menus','2020-01-26 07:51:00','2020-01-26 07:51:00'),(29,'menu_items','title',7,'pt','Base de dados','2020-01-26 07:51:00','2020-01-26 07:51:00'),(30,'menu_items','title',10,'pt','Configurações','2020-01-26 07:51:00','2020-01-26 07:51:00');
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_roles_user_id_index` (`user_id`),
  KEY `user_roles_role_id_index` (`role_id`),
  CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'Admin','admin@admin.com','users/default.png',NULL,'$2y$10$d948VkxO/muRDvAXeR.umu0xyUtDF7EX6dQvIlJyNfyi5W/yG4qL6','VYxwPtSW0zbCSuz8FgpvOXF2QB3bylj7H3HVM5JoSUrspX46avIHnFKesT5W',NULL,'2020-01-26 07:51:00','2020-01-26 07:51:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-26 19:01:11
