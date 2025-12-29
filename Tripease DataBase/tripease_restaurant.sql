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
  `image_url` varchar(255) DEFAULT NULL,
  `total_seats` int NOT NULL DEFAULT '50',
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
INSERT INTO `restaurant` VALUES (1,1,'Empire Restaurant','Biryani & Kebabs',4.4,9876541002,450.00,12.9358,77.6098,'https://images.unsplash.com/photo-1498654896293-37aacf113fd9?w=800',80),(2,1,'Meghana Foods','Biryani',4.6,9876542002,380.00,12.9346,77.6122,'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=800',65),(3,1,'Truffles','American Cafe',4.5,9876542006,500.00,12.9348,77.6113,'https://images.pexels.com/photos/2619967/pexels-photo-2619967.jpeg',75),(4,1,'Onesta Pizza','Italian',4.1,9876542004,350.00,12.9294,77.6347,'https://www.crazymasalafood.com/wp-content/images/20-best-pizza-joints-in-bangalore/onesta.jpg',100),(5,1,'Taco Bell','Mexican Fast Food',4.0,9876542005,300.00,12.9278,77.645,'https://media-cdn.tripadvisor.com/media/photo-p/11/8d/80/d2/photo2jpg.jpg',70),(6,1,'Green Leaf Veg','Vegetarian',4.1,9876541005,220.00,12.9105,77.6003,'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',90),(7,1,'BBQ Nation','Buffet & Grill',4.5,9876542001,950.00,12.9718,77.6411,'https://img.freepik.com/premium-photo/indian-food-banana-leaf_958782-158.jpg',120),(8,3,'Biryani Paradise','Hyderabadi',4.6,9876543001,400.00,17.385,78.4867,'https://b.zmtcdn.com/data/pictures/1/18275021/818de1d37ec1bda7d23dd3f93c75d02e_o2_featured_v2.jpg?output-format=webp&fit=around|771.75:416.25&crop=771.75:416.25;*,*',90),(9,2,'Murugan Idli Shop','South Indian',4.4,9876543002,180.00,13.0827,80.2707,'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800',110),(10,6,'Taj Lands End Dining','Fine Dining',4.7,9876543003,1500.00,19.0435,72.8204,'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=800',60),(11,7,'Karim’s Delhi','Mughlai',4.5,9876543004,500.00,28.6565,77.2303,'https://images.unsplash.com/photo-1529070538774-1843cb3265df?w=800',100),(12,11,'Chokhi Dhani','Traditional Rajasthani',4.6,9876543101,900.00,26.85,75.8,'https://images.unsplash.com/photo-1525755662778-989d0524087e?w=800',150),(13,12,'Vaishali Restaurant','South Indian',4.5,9876543102,300.00,18.5204,73.8567,'https://images.unsplash.com/photo-1528605248644-14dd04022da1?w=800',120),(14,13,'The Sitting Elephant','Multi-Cuisine Rooftop',4.7,9876543103,700.00,30.0869,78.2676,'https://images.unsplash.com/photo-1544148103-0773bf10d330?w=800',85),(15,14,'Kashi Chat Bhandar','Street Food',4.4,9876543104,150.00,25.3176,82.9739,'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=800',60),(16,15,'Cloud Street Cafe','Cafe & Bakery',4.3,9876543105,450.00,10.2381,77.4892,'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',70),(17,16,'Ambrai Restaurant','Lake View Dining',4.6,9876543106,1200.00,24.5764,73.686,'https://images.unsplash.com/photo-1514933651103-005eec06c04b?w=800',100);
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

-- Dump completed on 2025-12-29 11:03:39
