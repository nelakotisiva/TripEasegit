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
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `flight_id` int NOT NULL AUTO_INCREMENT,
  `airline` varchar(100) DEFAULT NULL,
  `source` varchar(100) DEFAULT NULL,
  `destination` varchar(100) DEFAULT NULL,
  `departure_time` varchar(20) DEFAULT NULL,
  `arrival_time` varchar(20) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `seats_available` int DEFAULT NULL,
  PRIMARY KEY (`flight_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES (1,'IndiGo','Bangalore','Delhi','06:00','08:30','2h 30m',5500,13),(2,'Air India','Bangalore','Delhi','15:00','17:30','2h 30m',6500,7),(3,'Vistara','Delhi','Mumbai','07:00','09:10','2h 10m',5000,45),(4,'IndiGo','Delhi','Mumbai','18:00','20:10','2h 10m',5200,35),(5,'SpiceJet','Mumbai','Hyderabad','09:00','10:30','1h 30m',3500,50),(6,'Vistara','Mumbai','Hyderabad','21:00','22:30','1h 30m',4800,25),(7,'AirAsia','Hyderabad','Chennai','05:30','06:45','1h 15m',3200,30),(8,'IndiGo','Hyderabad','Chennai','14:00','15:15','1h 15m',3600,20),(9,'IndiGo','Chennai','Bellary','10:00','11:40','1h 40m',4000,20),(10,'SpiceJet','Chennai','Bellary','19:00','20:40','1h 40m',4200,18),(11,'Air India','Bellary','Bangalore','07:00','08:10','1h 10m',2800,25),(12,'IndiGo','Bellary','Bangalore','16:00','17:10','1h 10m',3000,30),(13,'IndiGo','Bangalore','Delhi','06:00','08:30','2h 30m',5500,39),(14,'Air India','Delhi','Bangalore','09:00','11:30','2h 30m',6000,35),(15,'Vistara','Bangalore','Mumbai','07:00','09:05','2h 05m',4800,35),(16,'IndiGo','Mumbai','Bangalore','19:00','21:05','2h 05m',5000,25),(17,'SpiceJet','Bangalore','Hyderabad','08:00','09:10','1h 10m',3200,47),(18,'AirAsia','Hyderabad','Bangalore','15:00','16:10','1h 10m',3400,27),(19,'IndiGo','Bangalore','Chennai','05:30','06:30','1h',2500,45),(20,'Akasa Air','Chennai','Bangalore','18:00','19:00','1h',2700,32),(21,'Air India','Bangalore','Kolkata','10:00','13:00','3h',7200,30),(22,'Vistara','Kolkata','Bangalore','14:00','17:00','3h',7000,25),(23,'IndiGo','Mumbai','Delhi','06:00','08:10','2h 10m',5200,40),(24,'Vistara','Delhi','Mumbai','20:00','22:10','2h 10m',5400,33),(25,'SpiceJet','Hyderabad','Mumbai','09:00','10:30','1h 30m',3800,42),(26,'Vistara','Mumbai','Hyderabad','21:00','22:30','1h 30m',4100,28),(27,'IndiGo','Chennai','Delhi','07:00','09:40','2h 40m',6200,36),(28,'Air India','Delhi','Chennai','17:00','19:40','2h 40m',6400,28),(29,'Vistara','Kolkata','Mumbai','06:00','08:40','2h 40m',6500,40),(30,'IndiGo','Mumbai','Kolkata','16:00','18:40','2h 40m',6700,33),(31,'SpiceJet','Jaipur','Bangalore','12:00','14:30','2h 30m',6100,26),(32,'IndiGo','Bangalore','Jaipur','17:00','19:30','2h 30m',6000,29),(33,'AirAsia','Pune','Delhi','05:00','07:10','2h 10m',5500,38),(34,'IndiGo','Delhi','Pune','15:00','17:10','2h 10m',5700,34),(35,'SpiceJet','Goa','Mumbai','09:00','10:10','1h 10m',2800,44),(36,'IndiGo','Mumbai','Goa','19:00','20:10','1h 10m',3000,28),(37,'IndiGo','Kochi','Bangalore','11:00','12:00','1h',2600,36),(38,'AirAsia','Bangalore','Kochi','17:00','18:00','1h',2700,29),(39,'IndiGo','Bellary','Bangalore','07:00','08:10','1h 10m',2400,30),(40,'Air India','Bangalore','Bellary','14:00','15:10','1h 10m',2500,17);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
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
