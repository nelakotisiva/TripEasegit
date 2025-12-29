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
-- Table structure for table `cab_booking`
--

DROP TABLE IF EXISTS `cab_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cab_booking` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `rental_id` int NOT NULL,
  `model` varchar(100) NOT NULL,
  `seater_type` enum('4 Seater','5 Seater','7 Seater') NOT NULL,
  `passengers` int NOT NULL,
  `booking_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(45) DEFAULT 'Booked',
  PRIMARY KEY (`booking_id`),
  KEY `rental_id` (`rental_id`),
  KEY `idx_cb_booking_id` (`booking_id`),
  CONSTRAINT `cab_booking_ibfk_1` FOREIGN KEY (`rental_id`) REFERENCES `cab_rental` (`rental_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cab_booking`
--

LOCK TABLES `cab_booking` WRITE;
/*!40000 ALTER TABLE `cab_booking` DISABLE KEYS */;
INSERT INTO `cab_booking` VALUES (36,18,8,'Tata Nexon','5 Seater',1,'2025-12-25 16:27:16','Active'),(38,3,5,'Maruti Ertiga','5 Seater',1,'2025-12-28 12:26:58','Cancelled'),(39,3,9,'Mahindra XUV700','7 Seater',2,'2025-12-28 12:49:59','Cancelled'),(40,3,6,'Skoda Slavia','4 Seater',2,'2025-12-28 13:28:00','Cancelled'),(42,3,14,'kia Sonnet','7 Seater',2,'2025-12-28 14:36:11','Active'),(48,3,9,'Mahindra XUV700','7 Seater',2,'2025-12-29 05:13:43','Active'),(49,3,5,'Maruti Ertiga','5 Seater',2,'2025-12-29 05:24:38','Cancelled'),(50,18,9,'Mahindra XUV700','7 Seater',2,'2025-12-29 05:30:51','Active');
/*!40000 ALTER TABLE `cab_booking` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 11:03:39
