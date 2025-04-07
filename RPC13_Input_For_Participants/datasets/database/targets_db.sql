CREATE DATABASE  IF NOT EXISTS `targets_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `targets_db`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: targets_db
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `city_target_passenger_rating`
--

DROP TABLE IF EXISTS `city_target_passenger_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city_target_passenger_rating` (
  `city_id` varchar(5) NOT NULL,
  `target_avg_passenger_rating` decimal(3,2) DEFAULT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city_target_passenger_rating`
--

LOCK TABLES `city_target_passenger_rating` WRITE;
/*!40000 ALTER TABLE `city_target_passenger_rating` DISABLE KEYS */;
INSERT INTO `city_target_passenger_rating` VALUES ('AP01',8.50),('CH01',8.00),('GJ01',7.00),('GJ02',7.50),('KA01',8.50),('KL01',8.50),('MP01',8.00),('RJ01',8.25),('TN01',8.25),('UP01',7.25);
/*!40000 ALTER TABLE `city_target_passenger_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monthly_target_new_passengers`
--

DROP TABLE IF EXISTS `monthly_target_new_passengers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monthly_target_new_passengers` (
  `month` date NOT NULL,
  `city_id` varchar(5) NOT NULL,
  `target_new_passengers` int DEFAULT NULL,
  PRIMARY KEY (`month`,`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monthly_target_new_passengers`
--

LOCK TABLES `monthly_target_new_passengers` WRITE;
/*!40000 ALTER TABLE `monthly_target_new_passengers` DISABLE KEYS */;
INSERT INTO `monthly_target_new_passengers` VALUES ('2024-01-01','AP01',2500),('2024-01-01','CH01',4000),('2024-01-01','GJ01',2000),('2024-01-01','GJ02',1800),('2024-01-01','KA01',2000),('2024-01-01','KL01',5000),('2024-01-01','MP01',2700),('2024-01-01','RJ01',12000),('2024-01-01','TN01',1500),('2024-01-01','UP01',3200),('2024-02-01','AP01',2500),('2024-02-01','CH01',4000),('2024-02-01','GJ01',2000),('2024-02-01','GJ02',1800),('2024-02-01','KA01',2000),('2024-02-01','KL01',5000),('2024-02-01','MP01',2700),('2024-02-01','RJ01',12000),('2024-02-01','TN01',1500),('2024-02-01','UP01',3200),('2024-03-01','AP01',2500),('2024-03-01','CH01',4000),('2024-03-01','GJ01',2000),('2024-03-01','GJ02',1800),('2024-03-01','KA01',2000),('2024-03-01','KL01',5000),('2024-03-01','MP01',2700),('2024-03-01','RJ01',12000),('2024-03-01','TN01',1500),('2024-03-01','UP01',3200),('2024-04-01','AP01',2000),('2024-04-01','CH01',3000),('2024-04-01','GJ01',1500),('2024-04-01','GJ02',1500),('2024-04-01','KA01',2000),('2024-04-01','KL01',4000),('2024-04-01','MP01',2000),('2024-04-01','RJ01',6000),('2024-04-01','TN01',1000),('2024-04-01','UP01',2000),('2024-05-01','AP01',2000),('2024-05-01','CH01',3000),('2024-05-01','GJ01',1500),('2024-05-01','GJ02',1500),('2024-05-01','KA01',2000),('2024-05-01','KL01',4000),('2024-05-01','MP01',2000),('2024-05-01','RJ01',6000),('2024-05-01','TN01',1000),('2024-05-01','UP01',2000),('2024-06-01','AP01',2000),('2024-06-01','CH01',3000),('2024-06-01','GJ01',1500),('2024-06-01','GJ02',1500),('2024-06-01','KA01',2000),('2024-06-01','KL01',4000),('2024-06-01','MP01',2000),('2024-06-01','RJ01',6000),('2024-06-01','TN01',1000),('2024-06-01','UP01',2000);
/*!40000 ALTER TABLE `monthly_target_new_passengers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monthly_target_trips`
--

DROP TABLE IF EXISTS `monthly_target_trips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monthly_target_trips` (
  `month` date NOT NULL,
  `city_id` varchar(5) NOT NULL,
  `total_target_trips` int DEFAULT NULL,
  PRIMARY KEY (`month`,`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monthly_target_trips`
--

LOCK TABLES `monthly_target_trips` WRITE;
/*!40000 ALTER TABLE `monthly_target_trips` DISABLE KEYS */;
INSERT INTO `monthly_target_trips` VALUES ('2024-01-01','AP01',4500),('2024-01-01','CH01',7000),('2024-01-01','GJ01',9000),('2024-01-01','GJ02',6000),('2024-01-01','KA01',2000),('2024-01-01','KL01',7500),('2024-01-01','MP01',7000),('2024-01-01','RJ01',13000),('2024-01-01','TN01',3500),('2024-01-01','UP01',13000),('2024-02-01','AP01',4500),('2024-02-01','CH01',7000),('2024-02-01','GJ01',9000),('2024-02-01','GJ02',6000),('2024-02-01','KA01',2000),('2024-02-01','KL01',7500),('2024-02-01','MP01',7000),('2024-02-01','RJ01',13000),('2024-02-01','TN01',3500),('2024-02-01','UP01',13000),('2024-03-01','AP01',4500),('2024-03-01','CH01',7000),('2024-03-01','GJ01',9000),('2024-03-01','GJ02',6000),('2024-03-01','KA01',2000),('2024-03-01','KL01',7500),('2024-03-01','MP01',7000),('2024-03-01','RJ01',13000),('2024-03-01','TN01',3500),('2024-03-01','UP01',13000),('2024-04-01','AP01',5000),('2024-04-01','CH01',6000),('2024-04-01','GJ01',10000),('2024-04-01','GJ02',6500),('2024-04-01','KA01',2500),('2024-04-01','KL01',9000),('2024-04-01','MP01',7500),('2024-04-01','RJ01',9500),('2024-04-01','TN01',3500),('2024-04-01','UP01',11000),('2024-05-01','AP01',5000),('2024-05-01','CH01',6000),('2024-05-01','GJ01',10000),('2024-05-01','GJ02',6500),('2024-05-01','KA01',2500),('2024-05-01','KL01',9000),('2024-05-01','MP01',7500),('2024-05-01','RJ01',9500),('2024-05-01','TN01',3500),('2024-05-01','UP01',11000),('2024-06-01','AP01',5000),('2024-06-01','CH01',6000),('2024-06-01','GJ01',10000),('2024-06-01','GJ02',6500),('2024-06-01','KA01',2500),('2024-06-01','KL01',9000),('2024-06-01','MP01',7500),('2024-06-01','RJ01',9500),('2024-06-01','TN01',3500),('2024-06-01','UP01',11000);
/*!40000 ALTER TABLE `monthly_target_trips` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-08  9:43:46
