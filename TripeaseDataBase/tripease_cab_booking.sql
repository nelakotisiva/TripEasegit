-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: tripease
-- ------------------------------------------------------
-- Server version	8.0.43

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
  CONSTRAINT `cab_booking_ibfk_1` FOREIGN KEY (`rental_id`) REFERENCES `cab_rental` (`rental_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cab_booking`
--

LOCK TABLES `cab_booking` WRITE;
/*!40000 ALTER TABLE `cab_booking` DISABLE KEYS */;
INSERT INTO `cab_booking` VALUES (1,1098,4,'','4 Seater',1,'2025-12-04 16:19:12','Booked'),(2,1098,8,'','4 Seater',11,'2025-12-04 16:19:33','Booked'),(3,1098,2,'','4 Seater',2,'2025-12-04 16:27:44','Booked'),(4,1098,7,'Toyota Fortuner','7 Seater',3,'2025-12-04 16:38:47','Booked'),(5,12,6,'Skoda Slavia','4 Seater',1,'2025-12-05 13:19:31','Booked'),(17,8,6,'Skoda Slavia','4 Seater',1,'2025-12-13 08:27:53','Booked'),(19,3,5,'Maruti Ertiga','5 Seater',9,'2025-12-13 16:21:51','Booked'),(20,3,2,'Innova Crysta','5 Seater',8,'2025-12-13 16:22:11','Booked'),(23,8,9,'Mahindra XUV700','7 Seater',2,'2025-12-14 06:55:08','Booked'),(24,8,13,'Toyota Glanza','4 Seater',5,'2025-12-14 06:55:26','Booked');
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

-- Dump completed on 2025-12-15  0:19:48
