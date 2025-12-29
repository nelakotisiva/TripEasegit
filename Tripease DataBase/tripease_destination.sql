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
-- Table structure for table `destination`
--

DROP TABLE IF EXISTS `destination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `destination` (
  `destination_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `image_url` varchar(455) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`destination_id`),
  UNIQUE KEY `destination_id_UNIQUE` (`destination_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destination`
--

LOCK TABLES `destination` WRITE;
/*!40000 ALTER TABLE `destination` DISABLE KEYS */;
INSERT INTO `destination` VALUES (1,'Bangalore','Bangalore, India','IT hub','https://images.unsplash.com/photo-1596176530529-78163a4f7af2',10000.00),(2,'Chennai','Chennai, India','Coastal city','https://images.unsplash.com/photo-1582510003544-4d00b7f74220',9000.00),(3,'Hyderabad','Hyderabad, India','City of Pearls','https://images.unsplash.com/photo-1624023307905-000b1b63f77d',9500.00),(6,'Mumbai','Mumbai, India','Financial capital','https://images.unsplash.com/photo-1505739773434-c44e6c0b6c16',12000.00),(7,'Delhi','Delhi, India','Capital city','https://images.unsplash.com/photo-1587474260584-136574528ed5',11000.00),(11,'Jaipur','Jaipur, India','Pink City','https://images.unsplash.com/photo-1599661046827-dacff0a1e18f',8500.00),(12,'Pune','Pune, India','Education hub','https://images.unsplash.com/photo-1601579112948-6f1e7a5c9f4a',8000.00),(13,'Rishikesh','Rishikesh, India','Yoga capital','https://images.unsplash.com/photo-1593693397690-362cb9666fc2',7000.00),(14,'Varanasi','Varanasi, India','Spiritual city','https://images.unsplash.com/photo-1548013146-72479768bada',6000.00),(15,'Munnar','Munnar, India','Hill station','https://images.unsplash.com/photo-1602216056096-3b40cc0c9944',11000.00),(16,'Udaipur','Udaipur, India','City of Lakes','https://images.unsplash.com/photo-1518684079-2ca7d07f5d68',10000.00);
/*!40000 ALTER TABLE `destination` ENABLE KEYS */;
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
