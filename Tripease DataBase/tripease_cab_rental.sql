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
-- Table structure for table `cab_rental`
--

DROP TABLE IF EXISTS `cab_rental`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cab_rental` (
  `rental_id` int NOT NULL AUTO_INCREMENT,
  `seater_type` enum('4 Seater','5 Seater','7 Seater') NOT NULL,
  `model` varchar(100) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `price_per_day` decimal(10,2) NOT NULL,
  `availability` varchar(45) NOT NULL DEFAULT 'Available',
  `destination_id` int NOT NULL,
  PRIMARY KEY (`rental_id`),
  KEY `destination_id` (`destination_id`),
  CONSTRAINT `cab_rental_ibfk_1` FOREIGN KEY (`destination_id`) REFERENCES `cab_destination` (`destination_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cab_rental`
--

LOCK TABLES `cab_rental` WRITE;
/*!40000 ALTER TABLE `cab_rental` DISABLE KEYS */;
INSERT INTO `cab_rental` VALUES (2,'5 Seater','Innova Crysta','https://th.bing.com/th/id/OIP.2Ntt5fp3em9FX5Ra9nvqrwHaDz?w=316&h=179&c=7&r=0&o=7&cb=ucfimg2&dpr=1.3&pid=1.7&rm=3&ucfimg=1',2600.00,'Booked',2),(3,'4 Seater','Honda City','https://tse1.mm.bing.net/th/id/OIP.r35GFyMQXgsgIv4qvO3yzQHaEy?pid=Api&P=0&h=180',2200.00,'Available',3),(4,'7 Seater','Hyundai Verna','https://tse4.mm.bing.net/th/id/OIP.2Ntt5fp3em9FX5Ra9nvqrwHaDz?pid=Api&P=0&h=180',2000.00,'Booked',4),(5,'5 Seater','Maruti Ertiga','https://tse1.mm.bing.net/th/id/OIP.2INsrIdZslmGQN_uCY_M0AHaE0?pid=Api&P=0&h=180',2100.00,'Available',1),(6,'4 Seater','Skoda Slavia','https://tse2.mm.bing.net/th/id/OIP.j5X0W3uPmwMibPaWklmciQHaE8?pid=Api&P=0&h=180',2400.00,'Available',2),(7,'7 Seater','Toyota Fortuner','https://tse4.mm.bing.net/th/id/OIP.jVl0sTAXiCFe5_zG-mVhgwHaFj?pid=Api&P=0&h=180',3200.00,'Available',3),(8,'5 Seater','Tata Nexon','https://th.bing.com/th/id/OIP.8zUEsLVDIwXNy4P26Hjj8QHaEK?w=294&h=180&c=7&r=0&o=7&cb=ucfimg2&dpr=1.3&pid=1.7&rm=3&ucfimg=1',1900.00,'Booked',4),(9,'7 Seater','Mahindra XUV700','https://mda.spinny.com/sp-file-system/public/2025-02-28/6e328039e5ae443ab02cab3b40b178a7/raw/file.jpg',3400.00,'Available',1),(10,'4 Seater','Kia Seltos','https://tse3.mm.bing.net/th/id/OIP.KfS8mBKx7KM-XRbfVRZ6ywHaE8?cb=ucfimg2&ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3',2300.00,'Available',2),(11,'5 Seater','MG Hector','https://fastly-production.24c.in/hello-ar/dev/uploads/9ac006e5-2d64-4b0f-bc0f-23d6c3b0ed8d/f60940eb-cfaf-4439-a8a2-2e4461bbc1fe/43.jpg',2500.00,'Available',3),(13,'4 Seater','Toyota Glanza','https://th.bing.com/th?q=Glanza+White+Car&w=120&h=120&c=1&rs=1&qlt=70&o=7&cb=1&dpr=1.3&pid=InlineBlock&rm=3&ucfimg=1&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247',1700.00,'Available',1),(14,'7 Seater','kia Sonnet','https://tse2.mm.bing.net/th/id/OIP.0VlpjwKnOAO9lnKTBBh5PwHaE6?pid=Api&P=0&h=180',10000.00,'Available',1),(15,'4 Seater','indigo','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJaNuPcjPai9NrRpwsuXNh0T5SVuvLRfj9jA&s',1400.00,'Available',1);
/*!40000 ALTER TABLE `cab_rental` ENABLE KEYS */;
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
