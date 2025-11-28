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
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `restaurant_id` int NOT NULL AUTO_INCREMENT,
  `destination_id` int DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  `contact` bigint DEFAULT NULL,
  `avg_price` decimal(10,2) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`),
  UNIQUE KEY `restaurent_id_UNIQUE` (`restaurant_id`),
  KEY `des na on_id_idx` (`destination_id`),
  CONSTRAINT `des na on_id` FOREIGN KEY (`destination_id`) REFERENCES `destination` (`destination_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,101,'Koramangala Spice Hub','Indian',4.4,9876541001,350.00,12.9352,77.6245),(2,101,'Empire Restaurant','Non-Veg',4.3,9876541002,500.00,12.936,77.6106),(3,101,'Meghana Foods','Biryani',4.6,9876542002,350.00,12.9346,77.6122),(4,101,'Truffles','Cafe',4.4,9876542006,450.00,12.9348,77.6113),(5,101,'Onesta Pizza','Italian',4.0,9876542004,300.00,12.9294,77.6347),(6,101,'Taco Bell','Mexican',4.0,9876542005,250.00,12.9278,77.645),(7,101,'Green Leaf Veg','Vegetarian',4.0,9876541005,200.00,12.9105,77.6003),(8,101,'Biryani Bliss','Indian',4.2,9876541003,300.00,12.914,77.612),(9,101,'China Town Dine','Chinese',4.3,9876541007,400.00,12.93,77.61),(10,101,'BBQ Nation','Buffet',4.5,9876542001,900.00,12.9718,77.6411),(11,101,'Chai Point','Cafe',4.2,9876542009,120.00,12.9385,77.6198),(12,101,'Third Wave Coffee','Cafe',4.5,9876542010,200.00,12.93,77.622),(13,101,'Beijing Bites','Chinese',4.0,9876542013,320.00,12.9111,77.6305),(14,101,'WOW! Momo','Fast Food',4.2,9876542014,180.00,12.9422,77.6127),(15,101,'Sri Udupi Park','Veg',4.2,9876542020,160.00,12.9134,77.6022),(16,101,'Cafe Coffee Day','Cafe',4.0,9876541006,180.00,12.928,77.6472),(17,101,'Pizza Town','Fast Food',4.1,9876541004,250.00,12.918,77.62),(18,101,'Royal Biryani House','Indian',4.4,9876544444,450.00,12.97,77.58);
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-28 10:06:43
