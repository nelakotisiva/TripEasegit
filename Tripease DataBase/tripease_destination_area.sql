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
-- Table structure for table `destination_area`
--

DROP TABLE IF EXISTS `destination_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `destination_area` (
  `area_id` int NOT NULL AUTO_INCREMENT,
  `destination_id` int NOT NULL,
  `area_name` varchar(150) NOT NULL,
  PRIMARY KEY (`area_id`),
  KEY `destination_id` (`destination_id`),
  CONSTRAINT `destination_area_ibfk_1` FOREIGN KEY (`destination_id`) REFERENCES `destination1` (`destination_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destination_area`
--

LOCK TABLES `destination_area` WRITE;
/*!40000 ALTER TABLE `destination_area` DISABLE KEYS */;
INSERT INTO `destination_area` VALUES (1,1,'Koramangala'),(2,1,'Indiranagar'),(3,1,'Jayanagar'),(4,1,'BTM Layout'),(5,1,'Whitefield'),(6,1,'HSR Layout'),(7,2,'Madhapur'),(8,2,'HITEC City'),(9,2,'Banjara Hills'),(10,2,'Jubilee Hills'),(11,3,'T Nagar'),(12,3,'Velachery'),(13,3,'Anna Nagar'),(14,4,'Calangute'),(15,4,'Baga'),(16,4,'Candolim'),(17,5,'Old Manali'),(18,5,'Mall Road'),(19,5,'Solang Valley'),(20,6,'Bandra'),(21,6,'Andheri'),(22,6,'Colaba'),(23,9,'Salt Lake'),(24,9,'Park Street'),(25,9,'Howrah'),(26,8,'Vijayanagar'),(27,8,'Jayalakshmipuram');
/*!40000 ALTER TABLE `destination_area` ENABLE KEYS */;
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
