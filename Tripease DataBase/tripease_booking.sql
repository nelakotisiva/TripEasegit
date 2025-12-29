-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: tripease
-- ------------------------------------------------------
-- Server version	8.0.42

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

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `destination_id` int DEFAULT NULL,
  `booking_date` date DEFAULT NULL,
  `travel_date` date DEFAULT NULL,
  `status` enum('Pending','Confirmed','Cancelled') DEFAULT NULL,
  `num_of_people` int DEFAULT NULL,
  `service_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  UNIQUE KEY `booking_id_UNIQUE` (`booking_id`),
  KEY `user_id_idx` (`user_id`),
  KEY `destination_id_idx` (`destination_id`),
  CONSTRAINT `fk_booking_destination` FOREIGN KEY (`destination_id`) REFERENCES `destination` (`destination_id`),
  CONSTRAINT `fk_booking_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (36,18,1,'2025-12-21','2025-12-22','Confirmed',1,'CAB'),(38,18,1,'2025-12-21','2025-12-22','Confirmed',1,'CAB'),(39,18,3,'2025-12-21','2025-12-21','Confirmed',2,'CAB'),(40,18,1,'2025-12-21','2025-12-30','Confirmed',1,'CAB'),(42,18,1,'2025-12-22','2025-12-23','Confirmed',1,'CAB'),(58,3,2,'2025-12-30',NULL,'Confirmed',5,'RESTAURANT'),(59,3,13,'2025-12-28',NULL,'Pending',0,'FLIGHT'),(61,1,NULL,'2025-12-29',NULL,'Confirmed',NULL,'HOTEL'),(62,1,NULL,'2025-12-29',NULL,'Confirmed',NULL,'HOTEL'),(63,3,NULL,'2025-12-29',NULL,'Confirmed',NULL,'HOTEL'),(64,3,13,'2025-12-29',NULL,'Confirmed',NULL,'FLIGHT'),(65,3,NULL,'2025-12-29',NULL,'Confirmed',NULL,'HOTEL'),(66,3,2,'2025-12-31',NULL,'Confirmed',5,'RESTAURANT'),(67,1,13,'2025-12-29',NULL,'Confirmed',NULL,'FLIGHT'),(68,1,11,'2025-12-30',NULL,'Confirmed',2,'RESTAURANT'),(73,3,2,'2025-12-30',NULL,'Confirmed',2,'RESTAURANT'),(74,3,NULL,'2025-12-29',NULL,'Confirmed',NULL,'HOTEL'),(75,3,13,'2025-12-29',NULL,'Confirmed',NULL,'FLIGHT'),(76,18,NULL,'2025-12-29',NULL,'Confirmed',NULL,'HOTEL'),(77,18,13,'2025-12-29',NULL,'Confirmed',NULL,'FLIGHT'),(78,18,15,'2025-12-30',NULL,'Confirmed',2,'RESTAURANT');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 11:03:41
