CREATE DATABASE  IF NOT EXISTS `securecorp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `securecorp`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: securecorp
-- ------------------------------------------------------
-- Server version	9.5.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '8bee1456-d514-11f0-8f05-88aedd5e48ec:1-1142';

--
-- Table structure for table `activity_logs`
--

DROP TABLE IF EXISTS `activity_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `entity_type` varchar(30) DEFAULT NULL,
  `entity_id` bigint unsigned DEFAULT NULL,
  `description` text,
  `ip_address` varchar(45) DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_activity_user` (`user_id`),
  KEY `idx_activity_action` (`action`),
  KEY `idx_activity_entity` (`entity_type`,`entity_id`),
  KEY `idx_activity_created` (`created_at`),
  CONSTRAINT `fk_activity_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_logs`
--

LOCK TABLES `activity_logs` WRITE;
/*!40000 ALTER TABLE `activity_logs` DISABLE KEYS */;
INSERT INTO `activity_logs` VALUES (1,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:36:13'),(2,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:37:22'),(3,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:37:48'),(4,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:37:54'),(5,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:39:15'),(6,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:39:27'),(7,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:39:32'),(8,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:41:25'),(9,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:41:30'),(10,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:43:35'),(11,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:48:03'),(12,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:48:12'),(13,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:48:24'),(14,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:50:01'),(15,NULL,'USER_CREATED','USER',30,'Utente creato: dario (USER)','::1','{\"username\": \"dario\", \"user_type\": \"USER\", \"created_by\": \"admin\"}','2026-02-11 22:50:16'),(16,NULL,'TICKET_MESSAGE_ADDED','TICKET',6,'Risposta aggiunta al ticket: \"dasdasdsa\"','::1','{\"sender\": \"admin\", \"ticket_id\": 6, \"message_preview\": \"ciaooo\\n\"}','2026-02-11 22:50:29'),(17,NULL,'TICKET_STATUS_CHANGED','TICKET',6,'Status ticket modificato: \"dasdasdsa\" (CLOSED → OPEN)','::1','{\"ticket_id\": 6, \"changed_by\": \"admin\", \"new_status\": \"OPEN\", \"old_status\": \"CLOSED\"}','2026-02-11 22:50:33'),(18,NULL,'TICKET_MESSAGE_ADDED','TICKET',4,'Risposta aggiunta al ticket: \"dasdsadsadas\"','::1','{\"sender\": \"admin\", \"ticket_id\": 4, \"message_preview\": \"dasdsadsa\"}','2026-02-11 22:50:36'),(19,NULL,'TICKET_STATUS_CHANGED','TICKET',4,'Status ticket modificato: \"dasdsadsadas\" (IN_PROGRESS → CLOSED)','::1','{\"ticket_id\": 4, \"changed_by\": \"admin\", \"new_status\": \"CLOSED\", \"old_status\": \"IN_PROGRESS\"}','2026-02-11 22:50:40'),(20,NULL,'USER_DELETED','USER',30,'Utente eliminato: dario','::1','{\"deleted_by\": \"admin\", \"deleted_user\": \"dario\"}','2026-02-11 22:50:44'),(21,NULL,'LOGOUT','AUTH',28,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-11 22:51:12'),(22,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 22:51:14'),(23,NULL,'LOGIN_SUCCESS','AUTH',29,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-11 23:00:09'),(24,NULL,'LOGOUT','AUTH',29,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-11 23:00:15'),(25,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:00:20'),(26,NULL,'LOGOUT','AUTH',28,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-11 23:00:28'),(27,NULL,'LOGIN_SUCCESS','AUTH',29,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-11 23:00:31'),(28,NULL,'TICKET_CREATED','TICKET',7,'Ticket creato: \"ddasdas\"','::1','{\"title\": \"ddasdas\", \"creator\": \"utente\", \"ticket_type\": \"ACCESS\"}','2026-02-11 23:00:35'),(29,NULL,'LOGOUT','AUTH',29,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-11 23:00:37'),(30,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:00:40'),(31,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:03:27'),(32,NULL,'TICKET_MESSAGE_ADDED','TICKET',7,'Risposta aggiunta al ticket: \"ddasdas\"','::1','{\"sender\": \"admin\", \"ticket_id\": 7, \"message_preview\": \"dasdasd\"}','2026-02-11 23:03:33'),(33,NULL,'TICKET_MESSAGE_ADDED','TICKET',7,'Risposta aggiunta al ticket: \"ddasdas\"','::1','{\"sender\": \"admin\", \"ticket_id\": 7, \"message_preview\": \"dasdasd\"}','2026-02-11 23:03:33'),(34,NULL,'TICKET_MESSAGE_ADDED','TICKET',7,'Risposta aggiunta al ticket: \"ddasdas\"','::1','{\"sender\": \"admin\", \"ticket_id\": 7, \"message_preview\": \"dasdasd\"}','2026-02-11 23:03:34'),(35,NULL,'TICKET_MESSAGE_ADDED','TICKET',7,'Risposta aggiunta al ticket: \"ddasdas\"','::1','{\"sender\": \"admin\", \"ticket_id\": 7, \"message_preview\": \"dasdasd\"}','2026-02-11 23:03:34'),(36,NULL,'TICKET_MESSAGE_ADDED','TICKET',7,'Risposta aggiunta al ticket: \"ddasdas\"','::1','{\"sender\": \"admin\", \"ticket_id\": 7, \"message_preview\": \"dasdasd\"}','2026-02-11 23:03:34'),(37,NULL,'TICKET_STATUS_CHANGED','TICKET',7,'Status ticket modificato: \"ddasdas\" (OPEN → IN_PROGRESS)','::1','{\"ticket_id\": 7, \"changed_by\": \"admin\", \"new_status\": \"IN_PROGRESS\", \"old_status\": \"OPEN\"}','2026-02-11 23:03:37'),(38,NULL,'LOGOUT','AUTH',28,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-11 23:03:38'),(39,NULL,'LOGIN_SUCCESS','AUTH',29,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-11 23:03:43'),(40,NULL,'LOGIN_SUCCESS','AUTH',29,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-11 23:06:59'),(41,NULL,'LOGOUT','AUTH',29,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-11 23:07:04'),(42,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:07:06'),(43,NULL,'TICKET_MESSAGE_ADDED','TICKET',7,'Risposta aggiunta al ticket: \"ddasdas\"','::1','{\"sender\": \"admin\", \"ticket_id\": 7, \"message_preview\": \"dasd\"}','2026-02-11 23:07:10'),(44,NULL,'TICKET_STATUS_CHANGED','TICKET',7,'Status ticket modificato: \"ddasdas\" (IN_PROGRESS → CLOSED)','::1','{\"ticket_id\": 7, \"changed_by\": \"admin\", \"new_status\": \"CLOSED\", \"old_status\": \"IN_PROGRESS\"}','2026-02-11 23:07:25'),(45,NULL,'LOGOUT','AUTH',28,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-11 23:07:28'),(46,NULL,'LOGIN_SUCCESS','AUTH',29,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-11 23:07:34'),(47,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:10:37'),(48,NULL,'TICKET_MESSAGE_ADDED','TICKET',7,'Risposta aggiunta al ticket: \"ddasdas\"','::1','{\"sender\": \"admin\", \"ticket_id\": 7, \"message_preview\": \"ciao\"}','2026-02-11 23:10:46'),(49,NULL,'TICKET_STATUS_CHANGED','TICKET',7,'Status ticket modificato: \"ddasdas\" (CLOSED → OPEN)','::1','{\"ticket_id\": 7, \"changed_by\": \"admin\", \"new_status\": \"OPEN\", \"old_status\": \"CLOSED\"}','2026-02-11 23:10:52'),(50,NULL,'TICKET_STATUS_CHANGED','TICKET',7,'Status ticket modificato: \"ddasdas\" (OPEN → IN_PROGRESS)','::1','{\"ticket_id\": 7, \"changed_by\": \"admin\", \"new_status\": \"IN_PROGRESS\", \"old_status\": \"OPEN\"}','2026-02-11 23:10:54'),(51,NULL,'LOGOUT','AUTH',28,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-11 23:11:04'),(52,NULL,'LOGIN_SUCCESS','AUTH',29,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-11 23:11:06'),(53,NULL,'LOGOUT','AUTH',29,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-11 23:13:09'),(54,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:13:20'),(55,NULL,'TICKET_MESSAGE_ADDED','TICKET',7,'Risposta aggiunta al ticket: \"ddasdas\"','::1','{\"sender\": \"admin\", \"ticket_id\": 7, \"message_preview\": \"uffa\\n\"}','2026-02-11 23:13:28'),(56,NULL,'TICKET_STATUS_CHANGED','TICKET',7,'Status ticket modificato: \"ddasdas\" (IN_PROGRESS → CLOSED)','::1','{\"ticket_id\": 7, \"changed_by\": \"admin\", \"new_status\": \"CLOSED\", \"old_status\": \"IN_PROGRESS\"}','2026-02-11 23:13:42'),(57,NULL,'LOGOUT','AUTH',28,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-11 23:13:43'),(58,NULL,'LOGIN_SUCCESS','AUTH',29,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-11 23:13:46'),(59,NULL,'TICKET_CREATED','TICKET',8,'Ticket creato: \"prova123\"','::1','{\"title\": \"prova123\", \"creator\": \"utente\", \"ticket_type\": \"BUG\"}','2026-02-11 23:13:56'),(60,NULL,'LOGOUT','AUTH',29,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-11 23:13:59'),(61,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:14:01'),(62,NULL,'TICKET_MESSAGE_ADDED','TICKET',8,'Risposta aggiunta al ticket: \"prova123\"','::1','{\"sender\": \"admin\", \"ticket_id\": 8, \"message_preview\": \"si prova\"}','2026-02-11 23:14:07'),(63,NULL,'TICKET_STATUS_CHANGED','TICKET',8,'Status ticket modificato: \"prova123\" (OPEN → IN_PROGRESS)','::1','{\"ticket_id\": 8, \"changed_by\": \"admin\", \"new_status\": \"IN_PROGRESS\", \"old_status\": \"OPEN\"}','2026-02-11 23:14:10'),(64,NULL,'LOGOUT','AUTH',28,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-11 23:14:15'),(65,NULL,'LOGIN_SUCCESS','AUTH',29,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-11 23:14:18'),(66,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:16:48'),(67,NULL,'TICKET_MESSAGE_ADDED','TICKET',8,'Risposta aggiunta al ticket: \"prova123\"','::1','{\"sender\": \"admin\", \"ticket_id\": 8, \"message_preview\": \"provaaa\"}','2026-02-11 23:16:53'),(68,NULL,'TICKET_STATUS_CHANGED','TICKET',8,'Status ticket modificato: \"prova123\" (IN_PROGRESS → OPEN)','::1','{\"ticket_id\": 8, \"changed_by\": \"admin\", \"new_status\": \"OPEN\", \"old_status\": \"IN_PROGRESS\"}','2026-02-11 23:16:58'),(69,NULL,'LOGOUT','AUTH',28,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-11 23:17:00'),(70,NULL,'LOGIN_SUCCESS','AUTH',29,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-11 23:17:03'),(71,NULL,'LOGIN_SUCCESS','AUTH',29,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-11 23:21:16'),(72,NULL,'TICKET_CREATED','TICKET',9,'Ticket creato: \"dsadasdas\"','::1','{\"title\": \"dsadasdas\", \"creator\": \"utente\", \"ticket_type\": \"SUPPORT\"}','2026-02-11 23:21:24'),(73,NULL,'TICKET_CREATED','TICKET',10,'Ticket creato: \"783578954546576\"','::1','{\"title\": \"783578954546576\", \"creator\": \"utente\", \"ticket_type\": \"BUG\"}','2026-02-11 23:21:29'),(74,NULL,'LOGOUT','AUTH',29,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-11 23:21:30'),(75,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:21:32'),(76,NULL,'TICKET_STATUS_CHANGED','TICKET',10,'Status ticket modificato: \"783578954546576\" (OPEN → IN_PROGRESS)','::1','{\"ticket_id\": 10, \"changed_by\": \"admin\", \"new_status\": \"IN_PROGRESS\", \"old_status\": \"OPEN\"}','2026-02-11 23:21:36'),(77,NULL,'TICKET_MESSAGE_ADDED','TICKET',10,'Risposta aggiunta al ticket: \"783578954546576\"','::1','{\"sender\": \"admin\", \"ticket_id\": 10, \"message_preview\": \"1213213123123\"}','2026-02-11 23:21:40'),(78,NULL,'LOGOUT','AUTH',28,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-11 23:21:45'),(79,NULL,'LOGIN_SUCCESS','AUTH',29,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-11 23:21:49'),(80,NULL,'LOGOUT','AUTH',29,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-11 23:21:53'),(81,NULL,'LOGIN_SUCCESS','AUTH',29,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-11 23:24:23'),(82,NULL,'LOGOUT','AUTH',29,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-11 23:24:25'),(83,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:24:28'),(84,NULL,'TICKET_MESSAGE_ADDED','TICKET',10,'Risposta aggiunta al ticket: \"783578954546576\"','::1','{\"sender\": \"admin\", \"ticket_id\": 10, \"message_preview\": \"dsadas\"}','2026-02-11 23:24:32'),(85,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::ffff:127.0.0.1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:29:30'),(86,NULL,'USER_CREATED','USER',31,'Utente creato: davide (USER)','::1','{\"username\": \"davide\", \"user_type\": \"USER\", \"created_by\": \"admin\"}','2026-02-11 23:29:44'),(87,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:31:07'),(88,NULL,'TICKET_MESSAGE_ADDED','TICKET',10,'Risposta aggiunta al ticket: \"783578954546576\"','::1','{\"sender\": \"admin\", \"ticket_id\": 10, \"message_preview\": \"dasda\"}','2026-02-11 23:31:26'),(89,NULL,'LOGOUT','AUTH',28,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-11 23:32:00'),(90,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:32:57'),(91,NULL,'LOGOUT','AUTH',28,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-11 23:33:02'),(92,NULL,'LOGIN_SUCCESS','AUTH',29,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-11 23:33:21'),(93,NULL,'LOGOUT','AUTH',29,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-11 23:33:31'),(94,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:35:47'),(95,NULL,'LOGIN_SUCCESS','AUTH',28,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-11 23:35:54'),(96,NULL,'LOGIN_FAILED','AUTH',28,'Tentativo di login fallito: password errata (admin)','::1','{\"reason\": \"wrong_password\", \"username\": \"admin\"}','2026-02-12 14:11:30'),(97,32,'LOGIN_FAILED','AUTH',32,'Tentativo di login fallito: password errata (admin)','::1','{\"reason\": \"wrong_password\", \"username\": \"admin\"}','2026-02-12 14:11:41'),(98,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 14:11:48'),(99,32,'TICKET_MESSAGE_ADDED','TICKET',10,'Risposta aggiunta al ticket: \"783578954546576\"','::1','{\"sender\": \"admin\", \"ticket_id\": 10, \"message_preview\": \"cadfasds\"}','2026-02-12 14:12:07'),(100,32,'TICKET_MESSAGE_ADDED','TICKET',10,'Risposta aggiunta al ticket: \"783578954546576\"','::1','{\"sender\": \"admin\", \"ticket_id\": 10, \"message_preview\": \"dsadas\"}','2026-02-12 14:12:08'),(101,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 14:23:31'),(102,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 14:23:34'),(103,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 14:52:46'),(104,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 14:52:57'),(105,33,'TICKET_CREATED','TICKET',11,'Ticket creato: \"sadasdasd\"','::1','{\"title\": \"sadasdasd\", \"creator\": \"utente\", \"ticket_type\": \"SUPPORT\"}','2026-02-12 14:53:01'),(106,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 14:53:07'),(107,32,'TICKET_MESSAGE_ADDED','TICKET',11,'Risposta aggiunta al ticket: \"sadasdasd\"','::1','{\"sender\": \"admin\", \"ticket_id\": 11, \"message_preview\": \"dasdasdas\"}','2026-02-12 14:53:11'),(108,32,'TICKET_STATUS_CHANGED','TICKET',11,'Status ticket modificato: \"sadasdasd\" (OPEN → IN_PROGRESS)','::1','{\"ticket_id\": 11, \"changed_by\": \"admin\", \"new_status\": \"IN_PROGRESS\", \"old_status\": \"OPEN\"}','2026-02-12 14:53:15'),(109,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 14:53:20'),(110,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 14:55:06'),(111,32,'TICKET_MESSAGE_ADDED','TICKET',11,'Risposta aggiunta al ticket: \"sadasdasd\"','::1','{\"sender\": \"admin\", \"ticket_id\": 11, \"message_preview\": \"dasdasdasdasdas\"}','2026-02-12 14:55:17'),(112,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 14:55:17'),(113,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 14:55:20'),(114,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-12 14:55:25'),(115,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 14:56:21'),(116,32,'TICKET_MESSAGE_ADDED','TICKET',11,'Risposta aggiunta al ticket: \"sadasdasd\"','::1','{\"sender\": \"admin\", \"ticket_id\": 11, \"message_preview\": \"6m7m6i76mi7\"}','2026-02-12 14:56:28'),(117,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 14:56:35'),(118,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 14:56:38'),(119,33,'TICKET_CREATED','TICKET',12,'Ticket creato: \"hn5u6een5u6\"','::1','{\"title\": \"hn5u6een5u6\", \"creator\": \"utente\", \"ticket_type\": \"SUPPORT\"}','2026-02-12 14:56:53'),(120,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-12 14:56:57'),(121,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 14:56:59'),(122,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 15:01:55'),(123,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:01:58'),(124,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 15:02:01'),(125,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:02:22'),(126,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 15:02:27'),(127,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 15:02:30'),(128,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-12 15:03:03'),(129,32,'LOGIN_FAILED','AUTH',32,'Tentativo di login fallito: password errata (admin)','::1','{\"reason\": \"wrong_password\", \"username\": \"admin\"}','2026-02-12 15:06:25'),(130,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:06:29'),(131,32,'TICKET_MESSAGE_ADDED','TICKET',12,'Risposta aggiunta al ticket: \"hn5u6een5u6\"','::1','{\"sender\": \"admin\", \"ticket_id\": 12, \"message_preview\": \"dasdasdasdasd\"}','2026-02-12 15:06:39'),(132,32,'TICKET_STATUS_CHANGED','TICKET',12,'Status ticket modificato: \"hn5u6een5u6\" (OPEN → IN_PROGRESS)','::1','{\"ticket_id\": 12, \"changed_by\": \"admin\", \"new_status\": \"IN_PROGRESS\", \"old_status\": \"OPEN\"}','2026-02-12 15:06:42'),(133,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 15:06:43'),(134,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 15:06:45'),(135,33,'TICKET_CREATED','TICKET',13,'Ticket creato: \"7689879769879\"','::1','{\"title\": \"7689879769879\", \"creator\": \"utente\", \"ticket_type\": \"BUG\"}','2026-02-12 15:06:55'),(136,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-12 15:06:57'),(137,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:06:59'),(138,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 15:08:29'),(139,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:08:32'),(140,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 15:08:43'),(141,32,'TICKET_MESSAGE_ADDED','TICKET',13,'Risposta aggiunta al ticket: \"7689879769879\"','::1','{\"sender\": \"admin\", \"ticket_id\": 13, \"message_preview\": \"576567765765765567\"}','2026-02-12 15:08:48'),(142,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 15:08:54'),(143,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-12 15:08:59'),(144,32,'TICKET_MESSAGE_ADDED','TICKET',13,'Risposta aggiunta al ticket: \"7689879769879\"','::1','{\"sender\": \"admin\", \"ticket_id\": 13, \"message_preview\": \"57657566576\"}','2026-02-12 15:09:02'),(145,32,'TICKET_MESSAGE_ADDED','TICKET',13,'Risposta aggiunta al ticket: \"7689879769879\"','::1','{\"sender\": \"admin\", \"ticket_id\": 13, \"message_preview\": \"76575\"}','2026-02-12 15:09:04'),(146,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 15:09:08'),(147,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:26:01'),(148,32,'TICKET_MESSAGE_ADDED','TICKET',13,'Risposta aggiunta al ticket: \"7689879769879\"','::1','{\"sender\": \"admin\", \"ticket_id\": 13, \"message_preview\": \"45645456456\"}','2026-02-12 15:26:09'),(149,32,'TICKET_STATUS_CHANGED','TICKET',13,'Status ticket modificato: \"7689879769879\" (OPEN → IN_PROGRESS)','::1','{\"ticket_id\": 13, \"changed_by\": \"admin\", \"new_status\": \"IN_PROGRESS\", \"old_status\": \"OPEN\"}','2026-02-12 15:26:14'),(150,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 15:26:18'),(151,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 15:26:21'),(152,33,'TICKET_CREATED','TICKET',14,'Ticket creato: \"dasdasdas\"','::1','{\"title\": \"dasdasdas\", \"creator\": \"utente\", \"ticket_type\": \"BUG\"}','2026-02-12 15:26:40'),(153,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-12 15:26:42'),(154,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:26:44'),(155,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:28:25'),(156,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:31:15'),(157,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 15:31:21'),(158,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 15:31:23'),(159,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:46:35'),(160,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:46:46'),(161,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 15:46:57'),(162,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:47:08'),(163,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:50:28'),(164,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:51:19'),(165,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:54:45'),(166,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:54:53'),(167,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 15:57:23'),(168,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:06:06'),(169,32,'TICKET_MESSAGE_ADDED','TICKET',14,'Risposta aggiunta al ticket: \"dasdasdas\"','::1','{\"sender\": \"admin\", \"ticket_id\": 14, \"message_preview\": \"adsdaasd\"}','2026-02-12 16:06:23'),(170,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 16:06:26'),(171,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 16:06:30'),(172,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-12 16:06:39'),(173,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:06:45'),(174,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:09:42'),(175,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:12:39'),(176,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 16:16:19'),(177,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:16:41'),(178,32,'TICKET_MESSAGE_ADDED','TICKET',14,'Risposta aggiunta al ticket: \"dasdasdas\"','::1','{\"sender\": \"admin\", \"ticket_id\": 14, \"message_preview\": \"dsada\"}','2026-02-12 16:23:08'),(179,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 16:23:09'),(180,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 16:23:12'),(181,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::ffff:127.0.0.1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 16:25:48'),(182,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-12 16:25:55'),(183,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:25:57'),(184,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 16:26:02'),(185,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 16:26:06'),(186,33,'TICKET_CREATED','TICKET',15,'Ticket creato: \"3432424234\"','::1','{\"title\": \"3432424234\", \"creator\": \"utente\", \"ticket_type\": \"BUG\"}','2026-02-12 16:26:12'),(187,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-12 16:26:13'),(188,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:26:16'),(189,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 16:27:20'),(190,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:45:05'),(191,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 16:45:18'),(192,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 16:45:21'),(193,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:48:15'),(194,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 16:48:23'),(195,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:49:04'),(196,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 16:50:25'),(197,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 16:50:28'),(198,33,'TICKET_CREATED','TICKET',16,'Ticket creato: \"bbvbvvbbbg\"','::1','{\"title\": \"bbvbvvbbbg\", \"creator\": \"utente\", \"ticket_type\": \"ACCESS\"}','2026-02-12 16:50:35'),(199,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-12 16:50:38'),(200,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:50:41'),(201,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:52:14'),(202,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:54:02'),(203,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:55:21'),(204,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:56:20'),(205,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 16:58:10'),(206,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 17:00:42'),(207,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 17:09:43'),(208,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 17:10:04'),(209,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-12 17:10:17'),(210,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 17:10:19'),(211,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 17:15:42'),(212,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 17:15:57'),(213,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::ffff:127.0.0.1','{\"username\": \"utente\"}','2026-02-12 17:18:34'),(214,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 17:18:42'),(215,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 17:32:43'),(216,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 17:32:47'),(217,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 17:35:33'),(218,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 17:35:38'),(219,33,'TICKET_UPDATED','TICKET',14,'Ticket modificato: \"dasdasdas\"','::1','{\"new_title\": \"dasdasdas\", \"old_title\": \"dasdasdas\", \"updated_by\": \"utente\"}','2026-02-12 17:35:47'),(220,32,'TICKET_STATUS_CHANGED','TICKET',16,'Status ticket modificato: \"bbvbvvbbbg\" (OPEN → IN_PROGRESS)','::1','{\"ticket_id\": 16, \"changed_by\": \"admin\", \"new_status\": \"IN_PROGRESS\", \"old_status\": \"OPEN\"}','2026-02-12 17:36:02'),(221,32,'TICKET_STATUS_CHANGED','TICKET',5,'Status ticket modificato: \"dsadasdsadasdasdsa\" (OPEN → CLOSED)','::1','{\"ticket_id\": 5, \"changed_by\": \"admin\", \"new_status\": \"CLOSED\", \"old_status\": \"OPEN\"}','2026-02-12 17:36:09'),(222,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 17:37:27'),(223,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 17:37:32'),(224,32,'TICKET_STATUS_CHANGED','TICKET',16,'Status ticket modificato: \"bbvbvvbbbg\" (IN_PROGRESS → OPEN)','::1','{\"ticket_id\": 16, \"changed_by\": \"admin\", \"new_status\": \"OPEN\", \"old_status\": \"IN_PROGRESS\"}','2026-02-12 17:37:39'),(225,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 17:39:59'),(226,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 17:40:12'),(227,32,'TICKET_STATUS_CHANGED','TICKET',16,'Status ticket modificato: \"bbvbvvbbbg\" (OPEN → CLOSED)','::1','{\"ticket_id\": 16, \"changed_by\": \"admin\", \"new_status\": \"CLOSED\", \"old_status\": \"OPEN\"}','2026-02-12 17:40:26'),(228,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 17:41:41'),(229,32,'TICKET_STATUS_CHANGED','TICKET',16,'Status ticket modificato: \"bbvbvvbbbg\" (CLOSED → IN_PROGRESS)','::1','{\"ticket_id\": 16, \"changed_by\": \"admin\", \"new_status\": \"IN_PROGRESS\", \"old_status\": \"CLOSED\"}','2026-02-12 17:41:45'),(230,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 17:41:50'),(231,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 17:49:48'),(232,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 17:49:59'),(233,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 17:52:05'),(234,32,'TICKET_STATUS_CHANGED','TICKET',16,'Status ticket modificato: \"bbvbvvbbbg\" (IN_PROGRESS → CLOSED)','::1','{\"ticket_id\": 16, \"changed_by\": \"admin\", \"new_status\": \"CLOSED\", \"old_status\": \"IN_PROGRESS\"}','2026-02-12 17:52:20'),(235,32,'USER_DELETED','USER',31,'Utente eliminato: davide','::1','{\"deleted_by\": \"admin\", \"deleted_user\": \"davide\"}','2026-02-12 17:52:24'),(236,32,'USER_CREATED','USER',34,'Utente creato: darioo (USER)','::1','{\"username\": \"darioo\", \"user_type\": \"USER\", \"created_by\": \"admin\"}','2026-02-12 17:52:29'),(237,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 17:52:38'),(238,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 17:52:41'),(239,33,'TICKET_CREATED','TICKET',17,'Ticket creato: \"ciaooooooo\"','::1','{\"title\": \"ciaooooooo\", \"creator\": \"utente\", \"ticket_type\": \"SUPPORT\"}','2026-02-12 17:53:20'),(240,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-12 17:53:29'),(241,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 17:53:33'),(242,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-12 17:53:54'),(243,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 17:53:57'),(244,32,'TICKET_STATUS_CHANGED','TICKET',17,'Status ticket modificato: \"ciaooooooo\" (OPEN → IN_PROGRESS)','::1','{\"ticket_id\": 17, \"changed_by\": \"admin\", \"new_status\": \"IN_PROGRESS\", \"old_status\": \"OPEN\"}','2026-02-12 17:54:17'),(245,32,'LOGOUT','AUTH',32,'Logout effettuato: admin','::1','{\"username\": \"admin\"}','2026-02-12 17:54:18'),(246,33,'LOGIN_SUCCESS','AUTH',33,'Login riuscito: utente','::1','{\"username\": \"utente\", \"user_type\": \"USER\"}','2026-02-12 17:54:20'),(247,33,'LOGOUT','AUTH',33,'Logout effettuato: utente','::1','{\"username\": \"utente\"}','2026-02-12 17:54:33'),(248,32,'LOGIN_SUCCESS','AUTH',32,'Login riuscito: admin','::1','{\"username\": \"admin\", \"user_type\": \"ADMIN\"}','2026-02-12 18:05:43');
/*!40000 ALTER TABLE `activity_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `action` varchar(50) NOT NULL,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` bigint unsigned NOT NULL,
  `details` text,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_action` (`user_id`,`action`),
  KEY `idx_entity` (`entity_type`,`entity_id`),
  KEY `idx_created` (`created_at`),
  CONSTRAINT `fk_audit_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jwt`
--

DROP TABLE IF EXISTS `jwt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jwt` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `jti` char(36) NOT NULL,
  `token_hash` varchar(255) NOT NULL,
  `issued_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime NOT NULL,
  `revoked_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_jwt_jti` (`jti`),
  KEY `idx_jwt_user_expires` (`user_id`,`expires_at`),
  KEY `idx_jwt_expires` (`expires_at`),
  CONSTRAINT `fk_jwt_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jwt`
--

LOCK TABLES `jwt` WRITE;
/*!40000 ALTER TABLE `jwt` DISABLE KEYS */;
INSERT INTO `jwt` VALUES (29,13,'794dbb21-0c91-4c98-a5d5-f93644ab89cc','$2a$10$XCTxxMGJjYwrN2QKTreqXeCxDbyd2r.aAh3whzjg4ea4mHSGk6Pay','2026-02-04 15:29:47','2026-02-11 15:29:47','2026-02-04 15:33:22'),(30,15,'101007a1-2e49-45ad-80b6-3df59dc2ab4c','$2a$10$caIPj7lNJDGIvT3Bw9fZ0OenajGuNxvYp31lBItBRzf2ovxdfyBr2','2026-02-04 15:32:56','2026-02-11 15:32:57','2026-02-04 15:33:23'),(31,13,'abc5ab17-848f-43f3-8575-a6df4f6689c9','$2a$10$/depvtu0SHklc87kcMgy/u3OuPqktvBzRsuj1VmR2sfjqzyt9/EqW','2026-02-04 17:51:47','2026-02-11 17:51:48',NULL),(32,13,'b7ef3edd-4eae-4d2d-9050-45bdae1298a3','$2a$10$geDHiVuvpNDc0Tc3fs9WEuGQHopHJM4t0/EseYwv64UaThYlpv7A2','2026-02-05 15:23:12','2026-02-12 15:23:12','2026-02-05 15:23:26'),(33,13,'b7f13a2d-ed70-4bec-9b0e-3b2e268427fe','$2a$10$keW3nbs.6pCjkQFQ/wZr2evtc/V/YLqJ2RXIcnod2zz.ycekIdjAu','2026-02-05 15:33:24','2026-02-12 15:33:24','2026-02-05 15:34:15'),(34,15,'a0e3fffa-2e59-4bd0-a1f5-818b15b0e2c5','$2a$10$L/1Y07BakdqwuXn14O8WvO.zLkPYZgJ0LTQjDByXuYQwVPJWF4CkK','2026-02-05 15:34:19','2026-02-12 15:34:20',NULL),(35,13,'c0ed8488-477d-4161-9421-f2f3285d5444','$2a$10$K1zha6qk/1U2Se3dTLwLWeLbniAKiC13w41s4HgDAqaqwPzt7R45G','2026-02-05 15:44:07','2026-02-12 15:44:08','2026-02-05 15:58:27'),(36,13,'4d1103b4-656d-450c-a235-0b730a80898e','$2a$10$oGA6vBUncDHhOSs6l5wQ3eMX0p0bFuQnGiyB8t6hnMIoDWzo705Ga','2026-02-05 15:58:30','2026-02-12 15:58:31','2026-02-05 15:58:39'),(37,15,'15ee9d85-3f1a-4daa-9239-3a08d892fca6','$2a$10$/nzQJ6MBu3OTgvbWPkBTaeK.VgVD2tBNueFqeBtmKlzAByXb/cHQ6','2026-02-05 15:58:47','2026-02-12 15:58:48',NULL),(38,13,'0142786b-dc62-4c4b-85e4-72b281213b4e','$2a$10$fqPCbVv.Lvp2v67SAO5uLOiQVPfbjtzRyHnxydaRNoV0p0oucnxjW','2026-02-05 16:01:28','2026-02-12 16:01:29','2026-02-05 16:01:31'),(39,13,'e25c0140-2461-4c66-8f5e-87e2e5760fd2','$2a$10$nexN1O.y/Un4iZCCgh6Er.xxbAidUVGZ5DyItHwbmJZEFlVpWrwom','2026-02-05 16:19:33','2026-02-12 16:19:33',NULL),(40,13,'10075f44-6ad6-4c99-bc4a-11947e3e335d','$2a$10$afnavOOYwxQRp41gJzOJb.MnOSAaQfHNFIqLNigMHSVB27odKai8u','2026-02-05 16:55:58','2026-02-12 16:55:58',NULL),(41,13,'11bc7658-f215-43fd-acb1-9b632dd93b47','$2a$10$E17P68t3SpECeMx9zqlMkOk3fRVIgEnjsgHnaJ1bXfivwZEK2KbTS','2026-02-05 17:10:30','2026-02-12 17:10:30','2026-02-05 17:11:17'),(42,15,'e696aa36-858c-466e-8a31-1376891c8bfc','$2a$10$.gkjX0fe4wYK/R6m3YMBG.Lm.LkdLc9jixoqQt58nyiil6MIV6FU6','2026-02-05 17:11:27','2026-02-12 17:11:27','2026-02-05 17:11:50'),(125,32,'ed2e481d-b962-4693-bd8f-5b8257ae400f','$2a$10$C0/7obWi8buoFIBxVxzJsuw.QReXuayCZu81SYryZV.ZbI1dSwKeK','2026-02-12 15:11:48','2026-02-19 15:11:48','2026-02-12 15:23:31'),(126,32,'24a55a80-8479-41e9-806c-ce06bd008084','$2a$10$nlAxaq5oXlBR9C.l2l6.aODjy3nropRZ5DUBD9/KTjx68bola0Ga2','2026-02-12 15:23:34','2026-02-19 15:23:35',NULL),(127,32,'c3976e74-8b2e-4686-8f98-27deeabf998e','$2a$10$052IKzeShCt2/uWvIbF6BObfa9cp6ORtzJBNoGeYSmCl2a5ctepRS','2026-02-12 15:52:46','2026-02-19 15:52:46',NULL),(128,33,'75540e4b-eb32-4099-a2f2-fe5ce1487d1c','$2a$10$zlT18JzOGupi7dckwoELouaSNHiqRLzoxB2bD7oIbrelzdGIghw46','2026-02-12 15:52:57','2026-02-19 15:52:57',NULL),(129,32,'6539e38a-0285-404b-b412-9f283f341abc','$2a$10$wMuh48JeCL2FHuSctcmNluiC2UpMmHoVdRyjKTu71677kqaiQXDoK','2026-02-12 15:53:07','2026-02-19 15:53:08',NULL),(130,33,'4c543359-b7fa-4481-bce1-0fe0fce23477','$2a$10$f610MQ7GZzkhKDIidqMvFengh4HcfugzYzSn.ddZnhayzy3KmaIpK','2026-02-12 15:53:20','2026-02-19 15:53:21',NULL),(131,32,'b364f76e-bfae-4f39-968e-48b6ebd7b64b','$2a$10$zc9Tg30z2t0Nhpq0JXdyLeUeKLw6vwHMOS8Pd62aIOMJVA0h/Bdwq','2026-02-12 15:55:06','2026-02-19 15:55:06','2026-02-12 15:55:17'),(132,33,'cd9bba02-53d0-418d-a523-0dfc70da8bc7','$2a$10$Yel4lmE7BaA7FqMV0EC86Ot0LU9oZdktbDN0lKMpxnYNinkl48ZRq','2026-02-12 15:55:20','2026-02-19 15:55:20','2026-02-12 15:55:25'),(133,32,'9ef4495b-0cbb-43ed-b1f2-bd05fc562447','$2a$10$9gFPR2EQLN0Ejs7Hn3MXDOmi3Za/fKfvlTHBmAJ305TjxExzrBfCi','2026-02-12 15:56:21','2026-02-19 15:56:21','2026-02-12 15:56:35'),(134,33,'365c06d4-9a23-4d05-8667-a9209b87516e','$2a$10$Shp58md4KTRfjpY6wNjih.wYo/S5IFE5on/6ke377UxHGqPdtSogS','2026-02-12 15:56:38','2026-02-19 15:56:38','2026-02-12 15:56:57'),(135,32,'c9c23684-b029-4122-ae26-af7341f57f7d','$2a$10$DYAOlQh38zqkwzuxkkN.Bexr5wmr3Nqc5TsWkmqml/eLhmN5mXvrO','2026-02-12 15:56:59','2026-02-19 15:57:00','2026-02-12 16:01:55'),(136,32,'7b6280d9-d449-46c7-8526-22ec585d2dc0','$2a$10$djzBPeKfv3rkyKww0sT6x.FPgTZblRNQJPcnewALEsps3ylKu.k3e','2026-02-12 16:01:58','2026-02-19 16:01:58','2026-02-12 16:02:01'),(137,32,'e0121911-f38f-4ee7-93e0-9801a1ac79e5','$2a$10$wukUMEwloE/WPq61Rbh7BOGo/9sv/YaCcrarLRJEPJKM6SV8k0uia','2026-02-12 16:02:22','2026-02-19 16:02:22','2026-02-12 16:02:27'),(138,33,'4bba08da-e381-4700-b869-9e975e46fde2','$2a$10$rKg2u6W70YuwjPzEl5XyK.YeKv5xxn3zWeS4kb6g.Q91etFt3KTES','2026-02-12 16:02:30','2026-02-19 16:02:31','2026-02-12 16:03:03'),(139,32,'96a10323-778c-4dcf-a45c-4e7a33ed0cab','$2a$10$7u6frjcbIkCd1eRK6.YgJOnrOSRtgmIAWZBS57RrtY2QSNKUa.5Tq','2026-02-12 16:06:29','2026-02-19 16:06:30','2026-02-12 16:06:43'),(140,33,'d08a60fa-b9e2-4e17-88fe-cb40b44d3ca4','$2a$10$xCVXr4vgmuxXdsYHhDJ1f.aXFlCEM9PBSC9uM/9wTNIW.nzZE8DUC','2026-02-12 16:06:45','2026-02-19 16:06:46','2026-02-12 16:06:57'),(141,32,'ec2f98ae-3a73-47d4-8373-b819b4d42907','$2a$10$1OLHfqDLZ2B0/2tGRb4gWe9lC5Y..mSsgB8OtrEcKbmEGErouQ3gy','2026-02-12 16:06:59','2026-02-19 16:07:00','2026-02-12 16:08:29'),(142,32,'af0984af-7f6f-4791-9b25-cab191c62354','$2a$10$nSHxOzQ6mRkwq21C6FAsF.xtAJwZDPUbQOBhrs61oV.Qc75A/V7FG','2026-02-12 16:08:32','2026-02-19 16:08:32',NULL),(143,33,'80e4281f-ddfc-47e7-a370-dfc41441f8ff','$2a$10$UiW/oRA60SfAH2Zh3atF4epkBq8ApbG2cONDe6Vv2CMtU6RoDofhi','2026-02-12 16:08:43','2026-02-19 16:08:43',NULL),(144,33,'d89f30bf-e12f-4fa1-b7f0-6c37e56c3117','$2a$10$3byUi.68uT1bX.d/Zz6rmusa0oGMHw1T5uKXZGFUhItNhAiM3QLe6','2026-02-12 16:08:54','2026-02-19 16:08:55','2026-02-12 16:08:59'),(145,33,'b402ba7d-86da-462a-bf15-c4694d0c2e1a','$2a$10$OcpLAbOlneznPOCibSU9NOyLGGM/3SPvNzI0bNU0vu5CxPVE4YcO.','2026-02-12 16:09:08','2026-02-19 16:09:09',NULL),(146,32,'16087e4b-c5ea-416e-b8f7-e667c4c3d084','$2a$10$entyF6v33dL22kAxL.SUqucAmaUzBH6OSrplN7sG75zXMOZtX4FIW','2026-02-12 16:26:01','2026-02-19 16:26:01','2026-02-12 16:26:18'),(147,33,'e8e1558a-f90c-4689-93df-5a3db45728c6','$2a$10$hQ00QsRYJUe/DhQs/gDfPOwRfGULnmImiZSsQM/4C4.Mm.RrA6pqu','2026-02-12 16:26:21','2026-02-19 16:26:21','2026-02-12 16:26:42'),(148,32,'437c8955-d510-4093-9bdc-e6b252cc1ff5','$2a$10$5DPbF7o7gSOEVRGOa04uRuj7b6v6C4KUPo0LD9b067n2.UJRiWxpi','2026-02-12 16:26:44','2026-02-19 16:26:45',NULL),(149,32,'51a26b26-b8ae-41fe-9ff2-0e1fb3ca6d5a','$2a$10$I0J5g8oE3GdVXJgPJoCKhuMSoMoM5.bgHAGuR31O7g0eh/bTmXCsq','2026-02-12 16:28:25','2026-02-19 16:28:25',NULL),(150,32,'1e0aa8fa-6c8b-4656-adf4-d3ef1b196582','$2a$10$uPznsv1hVgyDgM6jYq53pu2hbegAdOcLtxJBPcmjOnZscPAkRlAB.','2026-02-12 16:31:15','2026-02-19 16:31:15','2026-02-12 16:31:21'),(151,33,'bcc8bd3d-64cb-4a46-b420-ececee0e2e6a','$2a$10$5PPPjCFq0FzFlTV/slGMceY6L8jMPK6KtVsDN/vwWFPvaAnoHXU46','2026-02-12 16:31:23','2026-02-19 16:31:24',NULL),(152,32,'46c234fa-62c0-40aa-95cb-88e6fd3bf939','$2a$10$4KFhBdLZ4XRC7meei0EmPeGSdOYiSxiQsaETE1YAgyq9uJ0QgFMWq','2026-02-12 16:46:35','2026-02-19 16:46:35',NULL),(153,32,'b2c17ecf-c032-4f4c-9d89-ec7575564c43','$2a$10$WhsOqUBfP4zKntlyaWtk0OkNZWD5HN83uZs/gesmcwhINLpo1KcVS','2026-02-12 16:46:46','2026-02-19 16:46:46',NULL),(154,33,'ee6aefd1-a8e3-4560-b517-328ef87b0cec','$2a$10$UsVb90H49GozrZ0pKzU0E.F.7sZzT2hDL0tip7Uc8mArhg2g5Wd8S','2026-02-12 16:46:57','2026-02-19 16:46:57',NULL),(155,32,'a326feda-6400-49f3-976f-89e72fc41f58','$2a$10$fhos0B5FdEhyBvH5COCNVeKOlgjLQWE/v/YeDbOU9LkFwRPCgg13q','2026-02-12 16:47:08','2026-02-19 16:47:08',NULL),(156,32,'d9e2c4f4-8016-4f6b-ae64-5a9d4c524bea','$2a$10$kV1civtDXC7bdorR2yhzhe/3jCbuO69yG4GaIu34hUXiM1eMcdFwm','2026-02-12 16:50:28','2026-02-19 16:50:28',NULL),(157,32,'3fb81ebc-293e-4cc7-9007-282fe2358149','$2a$10$LEkD7cfUbtXQ7I3XSG0qZOW7Y42wlEF.yd.z78Djc01EoUDlEx6zi','2026-02-12 16:51:19','2026-02-19 16:51:20',NULL),(158,32,'bb152919-3230-445c-8aae-9d20bbeba609','$2a$10$sRxG0OpiQVRqxJh9vBJrN.uvcpXgXbGgyWVqgFjobF4xXgBtiR36q','2026-02-12 16:54:45','2026-02-19 16:54:45',NULL),(159,32,'f785b35b-34ab-4946-8db8-1c4eb2890ad6','$2a$10$so5aLBvxejGWS9ulSNLmn.ZJsQUdSEEXlPKXC/VE1hRa/lHzTtBXC','2026-02-12 16:54:53','2026-02-19 16:54:54',NULL),(160,32,'04173f90-fb4c-4879-852f-b249696393f8','$2a$10$vwBHTDGE.sIy7xzluiGkJOaOF3osZADFAc.0fzepqdeNeAya2y2LO','2026-02-12 16:57:23','2026-02-19 16:57:23',NULL),(161,32,'9eb4fcbb-a769-4605-b71d-e08a92033bdd','$2a$10$sYhHEt8LVZ3SePT.Lq.8Pum4HxcC5G.Ey5bEmeunVPvSWnKXn89lm','2026-02-12 17:06:06','2026-02-19 17:06:06','2026-02-12 17:06:26'),(162,33,'281f101a-e16c-442b-b4ba-9fc339677860','$2a$10$ZibJdsOKmzbugdctZkf2pe5aDgqsTTS/htUZLRfm2owJsmC9wq0TS','2026-02-12 17:06:30','2026-02-19 17:06:30','2026-02-12 17:06:39'),(163,32,'16940d75-dc8c-4573-a393-e36bd5abc6cf','$2a$10$8U6J0bupA30FUdIQE7blsO19GF84TGUSbKltH8BEKUFw5Vp41UHz.','2026-02-12 17:06:45','2026-02-19 17:06:45',NULL),(164,32,'173c7454-37e8-4671-975e-38b975898fea','$2a$10$9j/yRPyP0beYDDMTZ1BCXus.X02DOhH1m4CmB3fa7cWT5Ws8K2N9m','2026-02-12 17:09:42','2026-02-19 17:09:43',NULL),(165,32,'d0a7aa84-5b35-4b45-9ed7-50dad86f6acb','$2a$10$OaPJvgX3mPuUfX0Mxrdyi.IIqNMzFfP5IPo17imWflChkoWFW7LH6','2026-02-12 17:12:39','2026-02-19 17:12:40','2026-02-12 17:16:19'),(166,32,'a251b421-d081-4a64-b0cf-ba70cc08151c','$2a$10$2G5//UfLBlMhB3kvt4c53..PiR6Du1mzUMbNcUwxmx1HFbtQzYFWq','2026-02-12 17:16:41','2026-02-19 17:16:42','2026-02-12 17:23:09'),(167,33,'69162439-54fe-4960-8152-39b234a89306','$2a$10$D2brQ1IqdxB5VWAuKpNzEeHlRPKf0uiqCX3o5bvvzEuKbP83U9GF6','2026-02-12 17:23:12','2026-02-19 17:23:13',NULL),(168,33,'a6f5a9fa-5841-477e-8949-4dfc4987aa05','$2a$10$vtddBdDPPRqHiae/p5HdoemA0iQkB8KoFdsywCQchNzlBB40BbuyS','2026-02-12 17:25:48','2026-02-19 17:25:48','2026-02-12 17:25:55'),(169,32,'09af5bd2-1447-43d4-a990-9eb1eda1ce93','$2a$10$mAt1JfcpASPBQfHipyd8PuGyS/.kCMlrzsU4nAfhYTHkn0obqjB/G','2026-02-12 17:25:57','2026-02-19 17:25:57','2026-02-12 17:26:02'),(170,33,'4e4a95cc-c8d1-44bb-8b88-7db130b6b357','$2a$10$FBZekLn41KVFO6yrg4fVX.JPs2KE1R9mPrPg3ndD2hc972JnV0qMW','2026-02-12 17:26:06','2026-02-19 17:26:06','2026-02-12 17:26:13'),(171,32,'fdb81ed6-f8e4-4b4b-a8c6-54ef45329490','$2a$10$R..9RXdduhmnsoidgRQneu10NwC6J4phb40tyev9ToQs5S8Y41Mv6','2026-02-12 17:26:16','2026-02-19 17:26:16','2026-02-12 17:27:20'),(172,32,'b95870ef-5236-4824-b6f2-887acfc6281b','$2a$10$X.v7quRJ/UWpbTjNFcTdZOw.apqt1tjCBz3QJFXoQ1q8ZubLELkva','2026-02-12 17:45:05','2026-02-19 17:45:05','2026-02-12 17:45:18'),(173,33,'8738a100-c6fa-4e9e-8429-549d16b531c2','$2a$10$9vaopibQjvRZpMYF5hIAMuCQC4AJTgUqr/BcUMYyhGPyIeDYAKNcO','2026-02-12 17:45:21','2026-02-19 17:45:22',NULL),(174,32,'cac7df60-3fb9-4db3-8335-cab1c797d76f','$2a$10$KsWsmo8pV/3.p5CJYUgWquxPUUWZyOxWcaSIH4wwKy.mvLKUcuaOa','2026-02-12 17:48:15','2026-02-19 17:48:15','2026-02-12 17:48:23'),(175,32,'d82280db-ead1-4bd4-b28a-bba1a711ae7f','$2a$10$sfqe.9wBmoSgLzAgAIcjQu1FE2E8JD52Uaw9.Wwbo2S9Q4SzglhD2','2026-02-12 17:49:04','2026-02-19 17:49:04','2026-02-12 17:50:25'),(176,33,'39d0db20-2708-4938-83ab-78f90378372b','$2a$10$u0tmszvrwEGOnJa8GnRWTu6Khe1vHglDPX8xL1VLUo5s/WYih22XW','2026-02-12 17:50:28','2026-02-19 17:50:29','2026-02-12 17:50:38'),(177,32,'841b8385-6db3-4535-90ca-27f9e0af7e93','$2a$10$Bk9JVUvfPxO/78Mfb8tXzeonjJ4RGQbjxbHgg/P8qKPYGdJT6Ckny','2026-02-12 17:50:41','2026-02-19 17:50:41',NULL),(178,32,'571fc21f-2240-4dcd-85d6-975caa58d450','$2a$10$WJ9YCia/wk7weeWhAc4zOeEoKNV2emCRc5QwLHbOnS0EZ/K/2fL.O','2026-02-12 17:52:14','2026-02-19 17:52:15',NULL),(179,32,'4e4c2eac-d616-4f4a-b2a7-71bf8577907c','$2a$10$eYkjxK9J5fVF/D3U7UNcOuBJryVDTKXLrZs317sCpGDM3IZ1U7Z/q','2026-02-12 17:54:02','2026-02-19 17:54:03',NULL),(180,32,'7362f977-c54c-4768-b582-928f11f15404','$2a$10$FQ4eHkKUYQkNBn266bfTyuaakxxEmX00mU01BFgtisLxXLtxpMY3m','2026-02-12 17:55:21','2026-02-19 17:55:21',NULL),(181,32,'3e08f0ad-9b6a-4b5a-8cf8-82a3cf5cf4e2','$2a$10$AD.yZjdivbOEruWRRYb1Uuep8GUAdid81EzjKb.eQMHxcieA7c956','2026-02-12 17:56:20','2026-02-19 17:56:21',NULL),(182,32,'647f85ab-e17e-400a-a325-33344b870ee2','$2a$10$E0ed1sRYbpKrujPCaJNLeOyvjZnQIPswsjq9v3TIeYatb2yHEzHrC','2026-02-12 17:58:10','2026-02-19 17:58:10',NULL),(183,32,'93bbed55-4c1f-478e-b494-df5c4f6c1d8c','$2a$10$2p2VD4BeDm4pyYYzUpn4f.lI3BIin2FciAaqvVQUEeY6MhMzn0qaC','2026-02-12 18:00:42','2026-02-19 18:00:42',NULL),(184,32,'d4832b23-33a4-4035-a44a-ccabf4b9dfa4','$2a$10$xcIe1gmfD0tlPiDdcd4w6uZ2WTeUPa9braugytfHkHDLl7qnUN8p6','2026-02-12 18:09:43','2026-02-19 18:09:44',NULL),(185,33,'c1762759-9e43-4d12-bebe-4d6eeca374da','$2a$10$jCGG3eNy1/KGJHxnJ3DRNeT0jb8vzuL9uUz2T4KqipYkp04BjvIHW','2026-02-12 18:10:04','2026-02-19 18:10:05','2026-02-12 18:10:17'),(186,32,'4bf9ca13-22d6-412c-bfb0-2f8a7abcd87b','$2a$10$3lqH1F0hKIPiQOXLGq8CXuPC62ix2Ierdq6H9FhqLg0aLKcUeaATa','2026-02-12 18:10:19','2026-02-19 18:10:19',NULL),(187,32,'d5ecb0ee-d781-4ff4-957f-f798c1491634','$2a$10$wz60zB0TnIBMneWyrSG2lOBwDitBVK3AL.J7mQaovEG8aTfsniKOq','2026-02-12 18:15:42','2026-02-19 18:15:43',NULL),(188,33,'81f1da0e-274d-4d06-970f-ffcb2795d4a1','$2a$10$18.uqcC5A9GaZy9AUia9A.jDOjeedagDXRA2rr/XP3WWpT5eN/UE.','2026-02-12 18:15:57','2026-02-19 18:15:57','2026-02-12 18:18:34'),(189,33,'d32900f0-73b7-4ac0-a637-a47fd45b6b59','$2a$10$xxRw90MoyN2JKOjWYyvAeOZvs.rVgRQfM6Zkw65eTWcxOZJ6jBpAa','2026-02-12 18:18:42','2026-02-19 18:18:42',NULL),(190,32,'afecf83b-b09f-424c-ac63-de6739a76543','$2a$10$e6yTEobvsEsXjixW/zDA5uPEadXaQ2ZXXXsLgcKdDUfovJbcS60Ue','2026-02-12 18:32:43','2026-02-19 18:32:43',NULL),(191,33,'be920ec3-324c-4429-a245-65a4fa787025','$2a$10$WLet6iKkcbSO7Vc5.F6e/O.FW9wlt9dYT0RXpUzzrboWwEj2RhCcu','2026-02-12 18:32:47','2026-02-19 18:32:48',NULL),(192,32,'69fb86bf-6ebf-4534-bbe3-373103af0340','$2a$10$xQrJrZTYyCUhzgl4iGYyh.CEE7Zo2jbNXlk8PZpbSdC4n0WNGAs86','2026-02-12 18:35:33','2026-02-19 18:35:34',NULL),(193,33,'1470ccc2-2353-4926-a2dd-ea0aecd6eeb9','$2a$10$b.piciDMHtErVebPBqy5XerqXSx.2wGmLYcbLUBtTRepw0aocEzym','2026-02-12 18:35:38','2026-02-19 18:35:39',NULL),(194,32,'275eb268-c79a-4b84-942d-aa5752ee1950','$2a$10$UWpzyTij.mbxIsQhwUz/R.vN5sr0jO8ls7TKSYnNcWj0N9fyHn04u','2026-02-12 18:37:27','2026-02-19 18:37:28',NULL),(195,33,'d300958c-7ff1-41e8-8df2-804eabda25df','$2a$10$jcc/u9ChIAQCfsR7SKoc5urXnymYvrTlOkTPW1CiMJoXIMjnoFH7K','2026-02-12 18:37:32','2026-02-19 18:37:33',NULL),(196,32,'aeaa208a-3238-4a13-befe-cadacd96a051','$2a$10$bFRDhVMB26EmBaPtTNHA2.nVa89XRKOXYPSJrlKAckmcOXS6IZHVu','2026-02-12 18:39:59','2026-02-19 18:39:59',NULL),(197,33,'a412dae6-1d60-4996-bccc-b6db0e787985','$2a$10$s80.WI.ZUct25hQQ3WF3eO6VA/LpdFHqD9Twb2.VzGtma0/qnB6ha','2026-02-12 18:40:12','2026-02-19 18:40:12',NULL),(198,32,'c24c43b0-4f51-40d8-9f3b-d614f340fe7b','$2a$10$G2JHPTNY8nQPj1w9KjcbFuVUFRkBBU5WVe8954SNdyD78HcW0KfYe','2026-02-12 18:41:41','2026-02-19 18:41:41',NULL),(199,33,'b7c485f0-1860-462e-a36c-79f3f334c624','$2a$10$drQ0EmRstuuCL2bTlIOLP.gG0WOGspRbnM6ylKGyu1/O069U13Uey','2026-02-12 18:41:50','2026-02-19 18:41:50',NULL),(200,32,'f6e4beb6-18d3-49d9-9301-fcb0d6784e3c','$2a$10$XCirhuuHfjJ0Kn7BV0X63.fO3nEUsF27jTRB4iXuDz8CmR/6gqY9.','2026-02-12 18:49:48','2026-02-19 18:49:48',NULL),(201,32,'4f074148-f293-4790-84a2-849a70050008','$2a$10$HKhhkz2w/wBSTIKQBugZ4.KMh9RQwcmGqASWfzpNx.2dGoYAW/hGS','2026-02-12 18:49:59','2026-02-19 18:50:00',NULL),(202,32,'e0fad047-8165-45c7-a711-d51166b0f16d','$2a$10$rNHSJSxWBr8VA4pDWf9GiuWKemjwLzP384ofvPKFekIYUQkkmJdfy','2026-02-12 18:52:05','2026-02-19 18:52:06','2026-02-12 18:52:38'),(203,33,'72dfc94a-aa77-47a7-adbc-fbf77bf8f1b8','$2a$10$cQthv17R26e3hrNgro6/xetLFnAPQ.16hOzkAcXwa3EC.UO/dSerK','2026-02-12 18:52:41','2026-02-19 18:52:42','2026-02-12 18:53:29'),(204,33,'a8b735e6-8023-4e84-b1f1-f8118e916c8f','$2a$10$hWauXMKUAF7OyexNVIIUdeaRZH3xszvq8gs1O/4q3Td8uGGsuHQge','2026-02-12 18:53:33','2026-02-19 18:53:34','2026-02-12 18:53:54'),(205,32,'f3c3a156-698e-4483-85b6-95be2ce09ead','$2a$10$WRXXTw7V63I67HlC2UKrgOHMQVZrxyFzoPmCsz9wcN51FHpvMwMsW','2026-02-12 18:53:57','2026-02-19 18:53:57','2026-02-12 18:54:18'),(206,33,'229e394d-386b-4788-a9ce-f8767ba33e99','$2a$10$Pic0pyuBcvcODAKEwy9CoOU7P9n0v35B7zLBh780sakcJUY7R7cVK','2026-02-12 18:54:20','2026-02-19 18:54:21','2026-02-12 18:54:33'),(207,32,'cb58edcd-21a8-446e-8b86-085740a88696','$2a$10$A7W.Jmdcsh6gjI6v4YL3EOVBY4ihjrhfNxl4RhTgL7g3KaCvKisTW','2026-02-12 19:05:43','2026-02-19 19:05:44',NULL);
/*!40000 ALTER TABLE `jwt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `new_view`
--

DROP TABLE IF EXISTS `new_view`;
/*!50001 DROP VIEW IF EXISTS `new_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `new_view` AS SELECT 
 1 AS `code`,
 1 AS `description`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `type` varchar(50) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `ticket_id` bigint unsigned DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`),
  KEY `idx_user_read` (`user_id`,`is_read`),
  KEY `idx_created` (`created_at`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (13,32,'new_ticket','ciaooooooo','Nuovo ticket creato da utente',17,1,'2026-02-12 17:53:20');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `ticket_type_id` smallint unsigned NOT NULL,
  `ticket_status_id` tinyint unsigned NOT NULL,
  `title` varchar(120) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ticket_user_created` (`user_id`,`created_at`),
  KEY `idx_ticket_status_created` (`ticket_status_id`,`created_at`),
  KEY `idx_ticket_type` (`ticket_type_id`),
  KEY `idx_deleted` (`deleted`,`deleted_at`),
  KEY `fk_ticket_deleted_by` (`deleted_by`),
  CONSTRAINT `fk_ticket_deleted_by` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_ticket_status` FOREIGN KEY (`ticket_status_id`) REFERENCES `ticket_status` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ticket_type` FOREIGN KEY (`ticket_type_id`) REFERENCES `ticket_type` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ticket_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1,NULL,3,2,'prova123','provaaaaaaaaaaaaaa','2026-02-03 14:16:30','2026-02-12 18:11:10',0,NULL,NULL),(2,15,2,3,'dsadasd','dasdasdada','2026-02-05 14:34:25','2026-02-11 20:50:12',0,NULL,NULL),(3,NULL,2,1,'heila','heiladasdasd','2026-02-11 20:50:37','2026-02-11 21:38:23',0,NULL,NULL),(4,NULL,3,3,'dasdsadsadas','dsadasdsad','2026-02-11 21:38:19','2026-02-11 22:50:40',0,NULL,NULL),(5,NULL,2,3,'dsadasdsadasdasdsa','asdasddasdsad','2026-02-11 21:43:10','2026-02-12 17:36:09',0,NULL,NULL),(6,NULL,2,1,'dasdasdsa','dasdsadas','2026-02-11 21:44:01','2026-02-11 22:50:33',0,NULL,NULL),(7,NULL,3,3,'ddasdas','dasdsads','2026-02-11 23:00:35','2026-02-11 23:13:42',0,NULL,NULL),(8,NULL,1,1,'prova123','prova123\n','2026-02-11 23:13:56','2026-02-11 23:16:58',0,NULL,NULL),(9,NULL,2,1,'dsadasdas','dsadsad','2026-02-11 23:21:23',NULL,0,NULL,NULL),(10,NULL,1,2,'783578954546576','65564745647654675','2026-02-11 23:21:29','2026-02-11 23:21:36',0,NULL,NULL),(11,33,2,2,'sadasdasd','dasdas','2026-02-12 14:53:01','2026-02-12 14:53:15',0,NULL,NULL),(12,33,2,2,'hn5u6een5u6','nu5n5n5u6','2026-02-12 14:56:53','2026-02-12 15:06:42',0,NULL,NULL),(13,33,1,2,'7689879769879','789789879789','2026-02-12 15:06:55','2026-02-12 15:26:14',0,NULL,NULL),(14,33,1,1,'dasdasdas','dasdasdasdadasdsdasdas','2026-02-12 15:26:40','2026-02-12 17:35:47',0,NULL,NULL),(15,33,1,1,'3432424234','3423423423','2026-02-12 16:26:12',NULL,0,NULL,NULL),(16,33,3,3,'bbvbvvbbbg','bbbbbbgbh','2026-02-12 16:50:35','2026-02-12 17:52:20',0,NULL,NULL),(17,33,2,2,'ciaooooooo','ciaooooooooooo','2026-02-12 17:53:20','2026-02-12 17:54:17',0,NULL,NULL);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_message`
--

DROP TABLE IF EXISTS `ticket_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_message` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_message_ticket` (`ticket_id`),
  KEY `fk_message_user` (`user_id`),
  CONSTRAINT `fk_message_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_message_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_message`
--

LOCK TABLES `ticket_message` WRITE;
/*!40000 ALTER TABLE `ticket_message` DISABLE KEYS */;
INSERT INTO `ticket_message` VALUES (1,16,32,'dasd','2026-02-12 17:09:49'),(2,16,32,'dasdas','2026-02-12 17:09:50'),(3,16,32,'adasdasd','2026-02-12 17:09:51'),(4,16,32,'dasdasdad','2026-02-12 17:09:52'),(5,16,32,'crazy','2026-02-12 17:09:54'),(6,16,33,'hdasgiduas','2026-02-12 17:10:10'),(7,16,33,'hdhgfdhgfhfg','2026-02-12 17:10:11'),(8,16,33,'hgfh','2026-02-12 17:10:11'),(9,16,33,'gfh','2026-02-12 17:10:11'),(10,16,33,'fgh','2026-02-12 17:10:11'),(11,16,33,'gfh','2026-02-12 17:10:11'),(12,16,32,'dadasd','2026-02-12 17:15:48'),(13,16,32,'dasdasd','2026-02-12 17:15:49'),(14,16,32,'dasd','2026-02-12 17:15:50'),(15,16,33,'dassda','2026-02-12 17:16:01'),(16,16,32,'aa','2026-02-12 17:18:50'),(17,16,33,'aa','2026-02-12 17:18:53'),(18,14,33,'dasda','2026-02-12 17:35:44'),(19,9,32,'dasdad','2026-02-12 17:35:58'),(20,12,32,'dsadas','2026-02-12 17:40:05'),(21,12,32,'dsada','2026-02-12 17:40:06'),(22,16,32,'dasda','2026-02-12 17:52:15'),(23,16,33,'ddasdas','2026-02-12 17:52:46'),(24,17,33,'dasdasd','2026-02-12 17:53:25'),(25,17,32,'dsadsada','2026-02-12 17:54:04');
/*!40000 ALTER TABLE `ticket_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_status`
--

DROP TABLE IF EXISTS `ticket_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_status` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL,
  `description` varchar(120) NOT NULL,
  `is_terminal` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ticket_status_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_status`
--

LOCK TABLES `ticket_status` WRITE;
/*!40000 ALTER TABLE `ticket_status` DISABLE KEYS */;
INSERT INTO `ticket_status` VALUES (1,'OPEN','Ticket aperto',0),(2,'IN_PROGRESS','In lavorazione',0),(3,'CLOSED','Ticket chiuso',1);
/*!40000 ALTER TABLE `ticket_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_type`
--

DROP TABLE IF EXISTS `ticket_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_type` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL,
  `description` varchar(120) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ticket_type_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_type`
--

LOCK TABLES `ticket_type` WRITE;
/*!40000 ALTER TABLE `ticket_type` DISABLE KEYS */;
INSERT INTO `ticket_type` VALUES (1,'BUG','Segnalazione bug'),(2,'SUPPORT','Richiesta supporto'),(3,'ACCESS','Richiesta accesso');
/*!40000 ALTER TABLE `ticket_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_type_id` tinyint unsigned NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_username` (`username`),
  KEY `idx_user_user_type_id` (`user_type_id`),
  CONSTRAINT `fk_user_user_type` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (32,2,'admin','$2a$10$zZhqzCEqqI9NSNSudO9XRuDil4438lOgMoSZ76CZ1vVQh3oXg.1TW',1,'2026-02-12 14:11:37'),(33,1,'utente','$2a$10$9/f7l9w8CPs/I//wR66C3.E2nZvKd3knfPF/efh.sNCZ5bIuaWa9G',1,'2026-02-12 14:11:37'),(34,1,'darioo','$2a$10$ua5pEXp41SYfl9NVaN99buuuqBoI3h2OV3phEtxJn0eHKsdLUyGqK',1,'2026-02-12 17:52:29'),(35,1,'testuser_check','hash',1,'2026-02-12 18:11:10');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_type`
--

DROP TABLE IF EXISTS `user_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_type` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `description` varchar(120) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_type_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_type`
--

LOCK TABLES `user_type` WRITE;
/*!40000 ALTER TABLE `user_type` DISABLE KEYS */;
INSERT INTO `user_type` VALUES (1,'USER','Utente standard'),(2,'ADMIN','Amministratore');
/*!40000 ALTER TABLE `user_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'securecorp'
--

--
-- Dumping routines for database 'securecorp'
--
/*!50003 DROP PROCEDURE IF EXISTS `delete_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user`(
  IN p_user_id INT
)
BEGIN
  DELETE FROM `user`
  WHERE id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getusertype` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getusertype`()
BEGIN
    SELECT ut.code, ut.description
    FROM securecorp.user_type ut;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_me` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_me`(
  IN p_user_id INT
)
BEGIN
  SELECT 
    u.id,
    u.username,
    ut.code AS user_type,
    u.created_at
  FROM `user` u
  JOIN user_type ut ON ut.id = u.user_type_id
  WHERE u.id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_users` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_users`()
BEGIN
  SELECT 
    u.id,
    u.username,
    ut.code AS user_type,
    ut.description AS user_type_desc,
    u.is_active,
    u.created_at
  FROM `user` u
  JOIN user_type ut ON ut.id = u.user_type_id
  ORDER BY u.created_at DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_jwt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_jwt`(
    IN p_user_id INT,
    IN p_jti VARCHAR(255),
    IN p_token_hash VARCHAR(255),
    IN p_expires_at DATETIME
)
BEGIN
    INSERT INTO jwt (user_id, jti, token_hash, expires_at)
    VALUES (p_user_id, p_jti, p_token_hash, p_expires_at);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `login_jwt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `login_jwt`(
    IN p_user_id INT,
    IN p_jti VARCHAR(255),
    IN p_token_hash VARCHAR(255),
    IN p_expires_at DATETIME
)
BEGIN
    INSERT INTO jwt (user_id, jti, token_hash, expires_at)
    VALUES (p_user_id, p_jti, p_token_hash, p_expires_at);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `logout_jwt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `logout_jwt`(
  IN p_jti CHAR(36),
  IN p_user_id INT
)
BEGIN
  UPDATE jwt
  SET revoked_at = CURRENT_TIMESTAMP
  WHERE jti = p_jti
    AND user_id = p_user_id
    AND revoked_at IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `refresh_jwt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `refresh_jwt`(
  IN p_jti CHAR(36)
)
BEGIN
  SELECT 
    t.user_id,
    t.token_hash,
    u.username,
    ut.code AS user_type_code
  FROM jwt t
  JOIN `user` u ON u.id = t.user_id
  JOIN user_type ut ON ut.id = u.user_type_id
  WHERE t.jti = p_jti
    AND t.revoked_at IS NULL
    AND t.expires_at > CURRENT_TIMESTAMP;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_jwt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_jwt`(
    IN p_username VARCHAR(50),
    IN p_password_hash VARCHAR(255),
    IN p_user_type_code VARCHAR(20)
)
BEGIN
    DECLARE v_user_type_id INT;

    -- recupera id del tipo utente
    SELECT id
    INTO v_user_type_id
    FROM user_type
    WHERE code = p_user_type_code
    LIMIT 1;

    IF v_user_type_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo utente non valido';
    END IF;

    -- inserimento utente
    INSERT INTO `user` (username, password_hash, user_type_id, created_at)
    VALUES (p_username, p_password_hash, v_user_type_id, NOW());

    -- ritorna l'id creato
    SELECT LAST_INSERT_ID() AS user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_user`(
    IN p_username VARCHAR(50),
    IN p_password_hash VARCHAR(255),
    IN p_user_type_code VARCHAR(20)
)
BEGIN
    DECLARE v_user_type_id INT;

    -- recupera id del tipo utente
    SELECT id
    INTO v_user_type_id
    FROM user_type
    WHERE code = p_user_type_code
    LIMIT 1;

    IF v_user_type_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo utente non valido';
    END IF;

    -- inserimento utente
    INSERT INTO `user` (username, password_hash, user_type_id, created_at)
    VALUES (p_username, p_password_hash, v_user_type_id, NOW());

    -- ritorna l'id creato
    SELECT LAST_INSERT_ID() AS user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_add_notification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_notification`(
                    IN p_user_id INT,
                    IN p_type VARCHAR(50),
                    IN p_title VARCHAR(255),
                    IN p_message TEXT,
                    IN p_ticket_id BIGINT
                )
BEGIN
                    INSERT INTO notifications (user_id, type, title, message, ticket_id, created_at)
                    VALUES (p_user_id, p_type, p_title, p_message, p_ticket_id, NOW());
                    SELECT LAST_INSERT_ID() as notification_id;
                END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_add_ticket_message` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_ticket_message`(
    IN p_ticket_id BIGINT,
    IN p_user_id INT,
    IN p_message TEXT
)
BEGIN
    INSERT INTO ticket_message (ticket_id, user_id, message, created_at)
    VALUES (p_ticket_id, p_user_id, p_message, NOW());
    
    -- Restituisce l'ID del messaggio appena inserito
    SELECT LAST_INSERT_ID() as message_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_check_ticket_access` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_check_ticket_access`(
    IN p_ticket_id INT
)
BEGIN
    SELECT 
        t.id, 
        t.title, 
        t.user_id, 
        ts.code as status 
    FROM ticket t 
    JOIN ticket_status ts ON t.ticket_status_id = ts.id 
    WHERE t.id = p_ticket_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_count_activity_logs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_count_activity_logs`(
  IN p_filter_action VARCHAR(50),
  IN p_filter_user_id INT,
  IN p_filter_entity_type VARCHAR(30),
  IN p_date_from DATETIME,
  IN p_date_to DATETIME
)
BEGIN
  SELECT COUNT(*) AS total
  FROM activity_logs al
  WHERE 
    (p_filter_action IS NULL OR al.action = p_filter_action)
    AND (p_filter_user_id IS NULL OR al.user_id = p_filter_user_id)
    AND (p_filter_entity_type IS NULL OR al.entity_type = p_filter_entity_type)
    AND (p_date_from IS NULL OR al.created_at >= p_date_from)
    AND (p_date_to IS NULL OR al.created_at <= p_date_to);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_count_unread_notifications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_count_unread_notifications`(
                    IN p_user_id INT
                )
BEGIN
                    SELECT COUNT(*) as unread_count 
                    FROM notifications 
                    WHERE user_id = p_user_id AND is_read = 0;
                END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_activity_log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_activity_log`(
  IN p_user_id INT,
  IN p_action VARCHAR(50),
  IN p_entity_type VARCHAR(30),
  IN p_entity_id BIGINT,
  IN p_description TEXT,
  IN p_ip_address VARCHAR(45),
  IN p_metadata_json JSON
)
BEGIN
  INSERT INTO activity_logs (
    user_id,
    action,
    entity_type,
    entity_id,
    description,
    ip_address,
    metadata
  ) VALUES (
    p_user_id,
    p_action,
    p_entity_type,
    p_entity_id,
    p_description,
    p_ip_address,
    p_metadata_json
  );
  
  SELECT LAST_INSERT_ID() AS log_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_ticket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_ticket`(
    IN p_user_id INT,
    IN p_ticket_type_code VARCHAR(20),
    IN p_title VARCHAR(120),
    IN p_description TEXT,
    OUT p_ticket_id INT
)
BEGIN
    DECLARE v_ticket_type_id INT;
    DECLARE v_ticket_status_id INT;
    
    -- Get type ID
    SELECT id INTO v_ticket_type_id FROM ticket_type WHERE code = p_ticket_type_code;
    
    -- Get initial status ID (OPEN)
    SELECT id INTO v_ticket_status_id FROM ticket_status WHERE code = 'OPEN';
    
    IF v_ticket_type_id IS NOT NULL AND v_ticket_status_id IS NOT NULL THEN
        INSERT INTO ticket (user_id, ticket_type_id, ticket_status_id, title, description)
        VALUES (p_user_id, v_ticket_type_id, v_ticket_status_id, p_title, p_description);
        
        SET p_ticket_id = LAST_INSERT_ID();
    ELSE
        SET p_ticket_id = NULL;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_notification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_notification`(
                    IN p_notification_id INT,
                    IN p_user_id INT
                )
BEGIN
                    DELETE FROM notifications 
                    WHERE id = p_notification_id AND user_id = p_user_id;
                END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_activity_logs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_activity_logs`(
  IN p_limit INT,
  IN p_offset INT,
  IN p_filter_action VARCHAR(50),
  IN p_filter_user_id INT,
  IN p_filter_entity_type VARCHAR(30),
  IN p_date_from DATETIME,
  IN p_date_to DATETIME
)
BEGIN
  SELECT 
    al.id,
    al.user_id,
    COALESCE(u.username, 'Sistema') AS username,
    al.action,
    al.entity_type,
    al.entity_id,
    al.description,
    al.ip_address,
    al.metadata,
    al.created_at
  FROM activity_logs al
  LEFT JOIN `user` u ON al.user_id = u.id
  WHERE 
    (p_filter_action IS NULL OR al.action = p_filter_action)
    AND (p_filter_user_id IS NULL OR al.user_id = p_filter_user_id)
    AND (p_filter_entity_type IS NULL OR al.entity_type = p_filter_entity_type)
    AND (p_date_from IS NULL OR al.created_at >= p_date_from)
    AND (p_date_to IS NULL OR al.created_at <= p_date_to)
  ORDER BY al.created_at DESC
  LIMIT p_limit OFFSET p_offset;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_admin_users` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_admin_users`()
BEGIN
    SELECT u.id 
    FROM user u 
    JOIN user_type ut ON u.user_type_id = ut.id 
    WHERE ut.code = 'ADMIN' AND u.is_active = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_tickets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_tickets`(
    IN p_user_id INT,
    IN p_search VARCHAR(255),
    IN p_status_code VARCHAR(50),
    IN p_type_code VARCHAR(50),
    IN p_is_admin BOOLEAN
)
BEGIN
    SELECT 
        t.id, 
        t.title, 
        t.description, 
        t.created_at, 
        t.updated_at, 
        COALESCE(u.username, "Utente Eliminato") as creator, 
        tt.code as ticket_type, 
        tt.description as ticket_type_desc, 
        ts.code as status, 
        ts.description as status_desc 
    FROM ticket t 
    LEFT JOIN user u ON t.user_id = u.id 
    JOIN ticket_type tt ON t.ticket_type_id = tt.id 
    JOIN ticket_status ts ON t.ticket_status_id = ts.id
    WHERE 
        (p_is_admin = 1 OR t.user_id = p_user_id)
        AND (p_search IS NULL OR t.title LIKE CONCAT('%', p_search, '%') OR u.username LIKE CONCAT('%', p_search, '%'))
        AND (p_status_code IS NULL OR ts.code = p_status_code)
        AND (p_type_code IS NULL OR tt.code = p_type_code)
    ORDER BY t.created_at DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_ticket_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_ticket_details`(
    IN p_ticket_id INT
)
BEGIN
    SELECT 
        t.id, 
        t.title, 
        t.description, 
        t.created_at, 
        t.updated_at, 
        t.user_id, 
        COALESCE(u.username, "Utente Eliminato") as creator, 
        tt.code as ticket_type, 
        tt.description as ticket_type_desc, 
        ts.code as status, 
        ts.description as status_desc 
    FROM ticket t 
    LEFT JOIN user u ON t.user_id = u.id 
    JOIN ticket_type tt ON t.ticket_type_id = tt.id 
    JOIN ticket_status ts ON t.ticket_status_id = ts.id 
    WHERE t.id = p_ticket_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_ticket_messages` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_ticket_messages`(
    IN p_ticket_id BIGINT
)
BEGIN
    SELECT 
        m.id, 
        m.message, 
        m.created_at, 
        m.user_id, 
        u.username, 
        ut.code as sender_role
    FROM ticket_message m
    JOIN user u ON m.user_id = u.id
    JOIN user_type ut ON u.user_type_id = ut.id
    WHERE m.ticket_id = p_ticket_id
    ORDER BY m.created_at ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_ticket_statuses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_ticket_statuses`()
BEGIN
    SELECT code, description FROM ticket_status ORDER BY id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_ticket_types` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_ticket_types`()
BEGIN
    SELECT code, description FROM ticket_type ORDER BY description;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_user_notifications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_user_notifications`(
                    IN p_user_id INT,
                    IN p_limit INT
                )
BEGIN
                    SELECT * 
                    FROM notifications 
                    WHERE user_id = p_user_id 
                    ORDER BY created_at DESC 
                    LIMIT p_limit;
                END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mark_all_notifications_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mark_all_notifications_read`(
                    IN p_user_id INT
                )
BEGIN
                    UPDATE notifications 
                    SET is_read = 1 
                    WHERE user_id = p_user_id AND is_read = 0;
                END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mark_notification_read` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mark_notification_read`(
                    IN p_notification_id INT,
                    IN p_user_id INT
                )
BEGIN
                    UPDATE notifications 
                    SET is_read = 1 
                    WHERE id = p_notification_id AND user_id = p_user_id;
                END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_ticket_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_ticket_status`(
    IN p_ticket_id INT,
    IN p_status_code VARCHAR(20)
)
BEGIN
    DECLARE v_status_id INT;
    
    SELECT id INTO v_status_id FROM ticket_status WHERE code = p_status_code;
    
    IF v_status_id IS NOT NULL THEN
        UPDATE ticket SET ticket_status_id = v_status_id WHERE id = p_ticket_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user`(
  IN p_user_id INT,
  IN p_username VARCHAR(50),
  IN p_user_type_id INT,
  IN p_is_active BOOLEAN
)
BEGIN
  UPDATE `user`
  SET
    username = COALESCE(p_username, username),
    user_type_id = COALESCE(p_user_type_id, user_type_id),
    is_active = COALESCE(p_is_active, is_active)
  WHERE id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_user_password` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user_password`(
  IN p_user_id INT,
  IN p_password_hash VARCHAR(255)
)
BEGIN
  UPDATE `user`
  SET password_hash = p_password_hash
  WHERE id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `new_view`
--

/*!50001 DROP VIEW IF EXISTS `new_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `new_view` AS select `ut`.`code` AS `code`,`ut`.`description` AS `description` from `user_type` `ut` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-12 19:15:16
