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
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `destination` varchar(100) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text,
  `days` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `details` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packages`
--

LOCK TABLES `packages` WRITE;
/*!40000 ALTER TABLE `packages` DISABLE KEYS */;
INSERT INTO `packages` VALUES (1,'Goa','Goa Premium Beach Package','5 days stay at luxury resort + water sports',5,25000.00,'Includes water sports + cruise dinner'),(2,'Goa','South Goa Family Special','Family-friendly tour covering major attractions',3,15000.00,'Includes dolphin ride'),(3,'Goa','North Goa Party Tour','Explore clubs and nightlife of North Goa',2,9000.00,'Includes DJ pass'),(4,'Mysore','Mysore Heritage Day','Explore palaces and gardens in Mysore',1,2500.00,'Guide and entry tickets included'),(5,'Bengaluru','Bengaluru Weekend','City tour, museum entry and food walk',2,6000.00,'Includes food walk'),(6,'Ooty','Ooty Honeymoon Escape','Romantic spots + lake view stay',3,18000.00,'Boating and candlelight dinner'),(7,'Ooty','Ooty Adventure Trek','Hill trekking + camping experience',2,12000.00,'Campfire, tent stay included'),(8,'Kodaikanal','Kodaikanal Nature Retreat','Caves, waterfalls, lake tour',3,17000.00,'Free cycle ride'),(9,'Kodaikanal','Kodai Budget Trip','Best for students',2,8000.00,'Shared rooms + bike ride'),(10,'Kerala','Kerala Backwater Houseboat','Stay inside luxury houseboat',2,20000.00,'All meals included'),(11,'Kerala','Munnar + Alleppey Combo','Tea gardens + backwaters',4,30000.00,'Jeep safari included'),(12,'Manali','Snow Adventure Package','Skiing + Snow point day tour',4,22000.00,'Includes skiing gear'),(13,'Manali','Manali Road Trip','Delhi to Manali trip',3,12000.00,'Volvo bus + hotel'),(14,'Shimla','Shimla Queen of Hills','Mall road + Jakhu temple',3,14000.00,'Includes ropeway'),(15,'Shimla','Shimla Kufri Adventure','Theme park + Horse riding',2,10000.00,'Includes Kufri tickets'),(16,'Agra','Taj Mahal Sunrise Tour','Sunrise view + Guide',1,3000.00,'Agra Fort + Local market'),(17,'Agra','Agra Mathura Vrindavan','Temple tour + Taj Mahal',2,7000.00,'Transport included'),(18,'Delhi','Delhi Heritage Walk','India Gate + Qutub Minar',1,1500.00,'Local guide included'),(19,'Delhi','Old Delhi Street Food Tour','Chandni Chowk food walk',1,1200.00,'Unlimited tasting'),(20,'Chennai','Mahabalipuram Shore Tour','Beach temples + UNESCO sites',1,2000.00,'Guide included'),(21,'Chennai','Pondicherry Weekend Trip','French colony + beaches',2,8000.00,'Hotel + breakfast'),(22,'Pune','Pune Lavasa Day Trip','Lake city visit',1,1800.00,'Transport included'),(23,'Mumbai','EsselWorld + Water Kingdom','Full-day fun',1,2500.00,'Tickets included'),(24,'Jaipur','Jaipur Royal Heritage Tour','Amber fort + Hawa Mahal',2,9000.00,'Elephant ride included'),(25,'Kolkata','Kolkata Cultural Walk','Dakshineswar + Victoria',1,1500.00,'Guide included'),(26,'Hyderabad','Hyderabad Food & Forts','Charminar + biryani special',1,1800.00,'Food tasting included');
/*!40000 ALTER TABLE `packages` ENABLE KEYS */;
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
