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
-- Table structure for table `restaurant_booking`
--

DROP TABLE IF EXISTS `restaurant_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_booking` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `restaurant_id` int DEFAULT NULL,
  `booking_date` date DEFAULT NULL,
  `num_people` int DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `user_id` (`user_id`),
  KEY `restaurant_booking_ibfk_2` (`restaurant_id`),
  CONSTRAINT `restaurant_booking_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `restaurant_booking_ibfk_2` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_booking`
--

LOCK TABLES `restaurant_booking` WRITE;
/*!40000 ALTER TABLE `restaurant_booking` DISABLE KEYS */;
INSERT INTO `restaurant_booking` VALUES (1,2,1,'2025-12-05',1,'Booked'),(2,2,1,'2025-12-05',1,'Booked'),(3,8,5,'2025-12-09',1,'Booked'),(4,8,2,'2025-12-18',2,'Booked'),(5,8,2,'2025-12-18',2,'Booked'),(6,8,3,'2025-12-18',3,'Booked'),(7,8,3,'2025-12-18',2,'Booked'),(8,18,3,'2025-12-23',1,'Booked'),(9,18,1,'2025-12-24',2,'Booked'),(10,18,1,'2025-12-24',2,'Booked'),(11,18,1,'2025-12-24',2,'Booked'),(12,18,1,'2025-12-24',2,'Booked'),(13,18,1,'2025-12-26',2,'Booked'),(14,18,1,'2025-12-26',2,'Booked'),(15,3,2,'2025-12-26',2,'Cancelled'),(16,3,2,'2025-12-28',2,'Cancelled'),(17,3,9,'2025-12-29',2,'Cancelled'),(18,3,9,'2025-12-29',2,'Booked'),(19,3,9,'2026-01-06',4,'Booked'),(20,3,9,'2025-12-29',2,'Booked'),(21,3,9,'2025-12-29',5,'Booked'),(22,3,9,'2025-12-30',5,'Booked'),(23,3,9,'2025-12-31',5,'Booked'),(24,1,12,'2025-12-30',2,'Booked'),(25,3,9,'2025-12-30',2,'Booked'),(26,18,16,'2025-12-30',2,'Booked');
/*!40000 ALTER TABLE `restaurant_booking` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 11:03:40
