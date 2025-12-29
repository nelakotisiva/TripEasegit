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
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS `hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel` (
  `hotel_id` int NOT NULL AUTO_INCREMENT,
  `destination_id` int DEFAULT NULL,
  `hotel_name` varchar(100) DEFAULT NULL,
  `price_per_night` decimal(10,2) DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `near_location` varchar(255) DEFAULT NULL,
  `rooms_available` int DEFAULT '0',
  `image_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`hotel_id`),
  UNIQUE KEY `hotel_id_UNIQUE` (`hotel_id`),
  KEY `destination_id_idx` (`destination_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel`
--

LOCK TABLES `hotel` WRITE;
/*!40000 ALTER TABLE `hotel` DISABLE KEYS */;
INSERT INTO `hotel` VALUES (1,1,'Taj Hotel',5000.00,4.5,'9876543210','Bangalore',5,'https://images.unsplash.com/photo-1566073771259-6a8506099945'),(26,1,'The Leela Palace',7500.00,4.8,'9000000002','Bangalore',5,'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b'),(27,1,'ITC Gardenia',6800.00,4.7,'9000000003','Bangalore',4,'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb'),(28,1,'Radisson Blu',4600.00,4.3,'9000000004','Bangalore',3,'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa'),(29,1,'Hotel Royal Orchid',3900.00,4.1,'9000000005','Bangalore',5,'https://images.unsplash.com/photo-1611892440504-42a792e24d32'),(30,1,'Lemon Tree Hotel',3400.00,4.0,'9000000006','Bangalore',6,'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267'),(31,1,'Oakwood Premier',6100.00,4.5,'9000000007','Bangalore',2,'https://images.unsplash.com/photo-1501117716987-c8e093657e3c'),(32,1,'City Inn Bangalore',2800.00,3.8,'9000000008','Bangalore',4,'https://images.unsplash.com/photo-1505691938895-1758d7feb511'),(33,1,'Blue Lotus Residency',3200.00,4.4,'9876543210','Indiranagar',12,'https://media.istockphoto.com/id/487042276/photo/hotel-sign.jpg?s=612x612&w=0&k=20&c=DjEVAoFnjB2cWwX28cxSKWkxsbze7o9jgkYrhyfmq9E='),(34,1,'Palm Tree Suites',2800.00,4.2,'9876543211','Koramangala',15,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeuffyYgvL-bm9vzoRrxKEfkHeuVssPK_w_A&s'),(35,1,'Green View Comforts',2600.00,4.0,'9876543212','Jayanagar',10,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRahMCe50pKRTjHbAcVIC6xJsnBu-UffluPw&s'),(36,2,'Urban Elite Suites',3500.00,4.5,'9876500001','Banjara Hills',18,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRHgcZypjHli15ZOCeUoLgQv40HtZhUQsGHA&s'),(37,2,'Pearl Continental',3000.00,4.3,'9876500002','Jubilee Hills',20,'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/32/18/1e/tulip-inn-koramangala.jpg?w=1200&h=-1&s=1'),(38,2,'Hitech Comfort Inn',2700.00,4.1,'9876500003','HITEC City',12,'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/01/c9/a1/b4/celebrity-club.jpg?w=1200&h=-1&s=1'),(39,3,'Ocean Breeze Resort',5400.00,4.6,'9876600001','Calangute Beach',25,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4tTlIcx7Bwsji8yZFT0uweVPJUnfxcEo8Yw&s');
/*!40000 ALTER TABLE `hotel` ENABLE KEYS */;
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
