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
-- Table structure for table `flight_booking`
--

DROP TABLE IF EXISTS `flight_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight_booking` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `flight_id` int DEFAULT NULL,
  `num_seats` int DEFAULT NULL,
  `travel_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Confirmed',
  PRIMARY KEY (`booking_id`),
  KEY `flight_id` (`flight_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `flight_booking_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`flight_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_booking`
--

LOCK TABLES `flight_booking` WRITE;
/*!40000 ALTER TABLE `flight_booking` DISABLE KEYS */;
INSERT INTO `flight_booking` VALUES (1,3,13,1,'2025-12-29','Cancelled'),(2,3,1,1,'2025-12-29','Cancelled'),(3,3,13,1,'2025-12-29','Cancelled'),(4,3,13,1,'2025-12-29','Confirmed'),(5,3,13,1,'2025-12-29','Cancelled'),(6,3,2,1,'2025-12-29','Confirmed'),(7,3,13,1,'2025-12-29','Confirmed'),(8,3,13,1,'2025-12-30','Confirmed'),(9,3,13,1,'2025-12-30','Confirmed'),(10,1,13,1,'2025-12-30','Confirmed'),(11,3,13,1,'2025-12-30','Confirmed'),(12,18,13,1,'2025-12-30','Confirmed');
/*!40000 ALTER TABLE `flight_booking` ENABLE KEYS */;
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
