-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: navy
-- ------------------------------------------------------
-- Server version	8.0.40-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `COMMISSIONED_OFFICER`
--

DROP TABLE IF EXISTS `COMMISSIONED_OFFICER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COMMISSIONED_OFFICER` (
  `Officer_ID` int NOT NULL,
  `Seniority` int DEFAULT NULL,
  `Ship` int DEFAULT NULL,
  `Position` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Officer_ID`),
  KEY `Ship` (`Ship`),
  CONSTRAINT `COMMISSIONED_OFFICER_ibfk_1` FOREIGN KEY (`Officer_ID`) REFERENCES `OFFICER` (`Officer_ID`),
  CONSTRAINT `COMMISSIONED_OFFICER_ibfk_2` FOREIGN KEY (`Ship`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMMISSIONED_OFFICER`
--

LOCK TABLES `COMMISSIONED_OFFICER` WRITE;
/*!40000 ALTER TABLE `COMMISSIONED_OFFICER` DISABLE KEYS */;
/*!40000 ALTER TABLE `COMMISSIONED_OFFICER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CREW`
--

DROP TABLE IF EXISTS `CREW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CREW` (
  `Ship_ID` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Age` int DEFAULT NULL,
  `Role` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Ship_ID`,`Name`),
  CONSTRAINT `CREW_ibfk_1` FOREIGN KEY (`Ship_ID`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CREW`
--

LOCK TABLES `CREW` WRITE;
/*!40000 ALTER TABLE `CREW` DISABLE KEYS */;
/*!40000 ALTER TABLE `CREW` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DISPATCH`
--

DROP TABLE IF EXISTS `DISPATCH`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DISPATCH` (
  `Dispatch_ID` int NOT NULL,
  `Date_Issued` date DEFAULT NULL,
  `Issuing_Officer` int DEFAULT NULL,
  `Orders` text,
  `Dispatch_Vessel` int DEFAULT NULL,
  PRIMARY KEY (`Dispatch_ID`),
  KEY `Issuing_Officer` (`Issuing_Officer`),
  KEY `Dispatch_Vessel` (`Dispatch_Vessel`),
  CONSTRAINT `DISPATCH_ibfk_1` FOREIGN KEY (`Issuing_Officer`) REFERENCES `OFFICER` (`Officer_ID`),
  CONSTRAINT `DISPATCH_ibfk_2` FOREIGN KEY (`Dispatch_Vessel`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DISPATCH`
--

LOCK TABLES `DISPATCH` WRITE;
/*!40000 ALTER TABLE `DISPATCH` DISABLE KEYS */;
/*!40000 ALTER TABLE `DISPATCH` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ENEMIES_ENGAGED`
--

DROP TABLE IF EXISTS `ENEMIES_ENGAGED`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ENEMIES_ENGAGED` (
  `Engagement_ID` int NOT NULL,
  `Enemy_ID` int NOT NULL,
  PRIMARY KEY (`Engagement_ID`,`Enemy_ID`),
  KEY `Enemy_ID` (`Enemy_ID`),
  CONSTRAINT `ENEMIES_ENGAGED_ibfk_1` FOREIGN KEY (`Engagement_ID`) REFERENCES `ENGAGEMENT` (`Engagement_ID`),
  CONSTRAINT `ENEMIES_ENGAGED_ibfk_2` FOREIGN KEY (`Enemy_ID`) REFERENCES `ENEMY_SHIP` (`Enemy_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ENEMIES_ENGAGED`
--

LOCK TABLES `ENEMIES_ENGAGED` WRITE;
/*!40000 ALTER TABLE `ENEMIES_ENGAGED` DISABLE KEYS */;
/*!40000 ALTER TABLE `ENEMIES_ENGAGED` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ENEMY_SHIP`
--

DROP TABLE IF EXISTS `ENEMY_SHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ENEMY_SHIP` (
  `Enemy_ID` int NOT NULL,
  `Nationality` varchar(50) DEFAULT NULL,
  `Threat_Level` int DEFAULT NULL,
  `Last_Reported_By` int DEFAULT NULL,
  `Last_Sighted_At` varchar(50) DEFAULT NULL,
  `Last_Sighting` date DEFAULT NULL,
  `Current_Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Enemy_ID`),
  KEY `Last_Reported_By` (`Last_Reported_By`),
  KEY `Last_Sighted_At` (`Last_Sighted_At`),
  CONSTRAINT `ENEMY_SHIP_ibfk_1` FOREIGN KEY (`Last_Reported_By`) REFERENCES `OFFICER` (`Officer_ID`),
  CONSTRAINT `ENEMY_SHIP_ibfk_2` FOREIGN KEY (`Last_Sighted_At`) REFERENCES `LOCATION` (`Coordinates`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ENEMY_SHIP`
--

LOCK TABLES `ENEMY_SHIP` WRITE;
/*!40000 ALTER TABLE `ENEMY_SHIP` DISABLE KEYS */;
/*!40000 ALTER TABLE `ENEMY_SHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ENGAGEMENT`
--

DROP TABLE IF EXISTS `ENGAGEMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ENGAGEMENT` (
  `Engagement_ID` int NOT NULL,
  `Coordinates` varchar(50) DEFAULT NULL,
  `Time` timestamp NULL DEFAULT NULL,
  `Casualties` int DEFAULT NULL,
  `Outcome` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Engagement_ID`),
  KEY `Coordinates` (`Coordinates`),
  CONSTRAINT `ENGAGEMENT_ibfk_1` FOREIGN KEY (`Coordinates`) REFERENCES `LOCATION` (`Coordinates`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ENGAGEMENT`
--

LOCK TABLES `ENGAGEMENT` WRITE;
/*!40000 ALTER TABLE `ENGAGEMENT` DISABLE KEYS */;
/*!40000 ALTER TABLE `ENGAGEMENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FLAG_OFFICER`
--

DROP TABLE IF EXISTS `FLAG_OFFICER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FLAG_OFFICER` (
  `Officer_ID` int NOT NULL,
  `Title` varchar(50) DEFAULT NULL,
  `Squadron` varchar(50) DEFAULT NULL,
  `Flagship` int DEFAULT NULL,
  `Predecessor_ID` int DEFAULT NULL,
  PRIMARY KEY (`Officer_ID`),
  KEY `Flagship` (`Flagship`),
  KEY `Predecessor_ID` (`Predecessor_ID`),
  CONSTRAINT `FLAG_OFFICER_ibfk_1` FOREIGN KEY (`Officer_ID`) REFERENCES `OFFICER` (`Officer_ID`),
  CONSTRAINT `FLAG_OFFICER_ibfk_2` FOREIGN KEY (`Flagship`) REFERENCES `SHIP` (`Ship_ID`),
  CONSTRAINT `FLAG_OFFICER_ibfk_3` FOREIGN KEY (`Predecessor_ID`) REFERENCES `OFFICER` (`Officer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FLAG_OFFICER`
--

LOCK TABLES `FLAG_OFFICER` WRITE;
/*!40000 ALTER TABLE `FLAG_OFFICER` DISABLE KEYS */;
/*!40000 ALTER TABLE `FLAG_OFFICER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FLEET`
--

DROP TABLE IF EXISTS `FLEET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FLEET` (
  `Fleet_ID` int NOT NULL,
  `Station` int DEFAULT NULL,
  `Commander_in_Chief` int DEFAULT NULL,
  PRIMARY KEY (`Fleet_ID`),
  KEY `Station` (`Station`),
  KEY `Commander_in_Chief` (`Commander_in_Chief`),
  CONSTRAINT `FLEET_ibfk_1` FOREIGN KEY (`Station`) REFERENCES `STATION` (`Station_ID`),
  CONSTRAINT `FLEET_ibfk_2` FOREIGN KEY (`Commander_in_Chief`) REFERENCES `OFFICER` (`Officer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FLEET`
--

LOCK TABLES `FLEET` WRITE;
/*!40000 ALTER TABLE `FLEET` DISABLE KEYS */;
/*!40000 ALTER TABLE `FLEET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LOCATION`
--

DROP TABLE IF EXISTS `LOCATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LOCATION` (
  `Coordinates` varchar(50) NOT NULL,
  `Location_Name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Coordinates`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LOCATION`
--

LOCK TABLES `LOCATION` WRITE;
/*!40000 ALTER TABLE `LOCATION` DISABLE KEYS */;
/*!40000 ALTER TABLE `LOCATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OFFICER`
--

DROP TABLE IF EXISTS `OFFICER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OFFICER` (
  `Officer_ID` int NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `Rank_Index` int DEFAULT NULL,
  `Birthplace` varchar(100) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Officer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OFFICER`
--

LOCK TABLES `OFFICER` WRITE;
/*!40000 ALTER TABLE `OFFICER` DISABLE KEYS */;
/*!40000 ALTER TABLE `OFFICER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PETTY_OFFICER`
--

DROP TABLE IF EXISTS `PETTY_OFFICER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PETTY_OFFICER` (
  `Officer_ID` int NOT NULL,
  `Ship` int DEFAULT NULL,
  `Rating` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Officer_ID`),
  KEY `Ship` (`Ship`),
  CONSTRAINT `PETTY_OFFICER_ibfk_1` FOREIGN KEY (`Officer_ID`) REFERENCES `OFFICER` (`Officer_ID`),
  CONSTRAINT `PETTY_OFFICER_ibfk_2` FOREIGN KEY (`Ship`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PETTY_OFFICER`
--

LOCK TABLES `PETTY_OFFICER` WRITE;
/*!40000 ALTER TABLE `PETTY_OFFICER` DISABLE KEYS */;
/*!40000 ALTER TABLE `PETTY_OFFICER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PORT`
--

DROP TABLE IF EXISTS `PORT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PORT` (
  `Port_ID` int NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Coordinates` varchar(50) DEFAULT NULL,
  `Alignment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Port_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PORT`
--

LOCK TABLES `PORT` WRITE;
/*!40000 ALTER TABLE `PORT` DISABLE KEYS */;
/*!40000 ALTER TABLE `PORT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REPORT`
--

DROP TABLE IF EXISTS `REPORT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REPORT` (
  `Dispatch_ID` int NOT NULL,
  `Reporting_Officer` int DEFAULT NULL,
  `R_Status` varchar(50) DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`Dispatch_ID`),
  KEY `Reporting_Officer` (`Reporting_Officer`),
  CONSTRAINT `REPORT_ibfk_1` FOREIGN KEY (`Dispatch_ID`) REFERENCES `DISPATCH` (`Dispatch_ID`),
  CONSTRAINT `REPORT_ibfk_2` FOREIGN KEY (`Reporting_Officer`) REFERENCES `OFFICER` (`Officer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REPORT`
--

LOCK TABLES `REPORT` WRITE;
/*!40000 ALTER TABLE `REPORT` DISABLE KEYS */;
/*!40000 ALTER TABLE `REPORT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SHIP`
--

DROP TABLE IF EXISTS `SHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHIP` (
  `Ship_ID` int NOT NULL,
  `Ship_Type` varchar(50) DEFAULT NULL,
  `Origin_Year` int DEFAULT NULL,
  `Origin_Shipyard` varchar(100) DEFAULT NULL,
  `Gun_Count` int DEFAULT NULL,
  `Coordinates` varchar(50) DEFAULT NULL,
  `Last_Port_Of_Call` varchar(100) DEFAULT NULL,
  `Last_Date_Of_Call` date DEFAULT NULL,
  PRIMARY KEY (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHIP`
--

LOCK TABLES `SHIP` WRITE;
/*!40000 ALTER TABLE `SHIP` DISABLE KEYS */;
/*!40000 ALTER TABLE `SHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SHIPS_ENGAGED`
--

DROP TABLE IF EXISTS `SHIPS_ENGAGED`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHIPS_ENGAGED` (
  `Engagement_ID` int NOT NULL,
  `Ship_ID` int NOT NULL,
  PRIMARY KEY (`Engagement_ID`,`Ship_ID`),
  KEY `Ship_ID` (`Ship_ID`),
  CONSTRAINT `SHIPS_ENGAGED_ibfk_1` FOREIGN KEY (`Engagement_ID`) REFERENCES `ENGAGEMENT` (`Engagement_ID`),
  CONSTRAINT `SHIPS_ENGAGED_ibfk_2` FOREIGN KEY (`Ship_ID`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHIPS_ENGAGED`
--

LOCK TABLES `SHIPS_ENGAGED` WRITE;
/*!40000 ALTER TABLE `SHIPS_ENGAGED` DISABLE KEYS */;
/*!40000 ALTER TABLE `SHIPS_ENGAGED` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SHIPS_IN_SQUADRON`
--

DROP TABLE IF EXISTS `SHIPS_IN_SQUADRON`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHIPS_IN_SQUADRON` (
  `Squadron_ID` int NOT NULL,
  `Ship_ID` int NOT NULL,
  PRIMARY KEY (`Squadron_ID`,`Ship_ID`),
  KEY `Ship_ID` (`Ship_ID`),
  CONSTRAINT `SHIPS_IN_SQUADRON_ibfk_1` FOREIGN KEY (`Squadron_ID`) REFERENCES `SQUADRON` (`Squadron_ID`),
  CONSTRAINT `SHIPS_IN_SQUADRON_ibfk_2` FOREIGN KEY (`Ship_ID`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHIPS_IN_SQUADRON`
--

LOCK TABLES `SHIPS_IN_SQUADRON` WRITE;
/*!40000 ALTER TABLE `SHIPS_IN_SQUADRON` DISABLE KEYS */;
/*!40000 ALTER TABLE `SHIPS_IN_SQUADRON` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SHIPS_RECEIVED`
--

DROP TABLE IF EXISTS `SHIPS_RECEIVED`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHIPS_RECEIVED` (
  `Dispatch_ID` int NOT NULL,
  `Ship_ID` int NOT NULL,
  PRIMARY KEY (`Dispatch_ID`,`Ship_ID`),
  KEY `Ship_ID` (`Ship_ID`),
  CONSTRAINT `SHIPS_RECEIVED_ibfk_1` FOREIGN KEY (`Dispatch_ID`) REFERENCES `DISPATCH` (`Dispatch_ID`),
  CONSTRAINT `SHIPS_RECEIVED_ibfk_2` FOREIGN KEY (`Ship_ID`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHIPS_RECEIVED`
--

LOCK TABLES `SHIPS_RECEIVED` WRITE;
/*!40000 ALTER TABLE `SHIPS_RECEIVED` DISABLE KEYS */;
/*!40000 ALTER TABLE `SHIPS_RECEIVED` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SQUADRON`
--

DROP TABLE IF EXISTS `SQUADRON`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SQUADRON` (
  `Squadron_ID` int NOT NULL,
  `Fleet` int DEFAULT NULL,
  `Commander` int DEFAULT NULL,
  `Station` int DEFAULT NULL,
  `S_Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Squadron_ID`),
  KEY `Fleet` (`Fleet`),
  KEY `Commander` (`Commander`),
  KEY `Station` (`Station`),
  CONSTRAINT `SQUADRON_ibfk_1` FOREIGN KEY (`Fleet`) REFERENCES `FLEET` (`Fleet_ID`),
  CONSTRAINT `SQUADRON_ibfk_2` FOREIGN KEY (`Commander`) REFERENCES `OFFICER` (`Officer_ID`),
  CONSTRAINT `SQUADRON_ibfk_3` FOREIGN KEY (`Station`) REFERENCES `STATION` (`Station_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SQUADRON`
--

LOCK TABLES `SQUADRON` WRITE;
/*!40000 ALTER TABLE `SQUADRON` DISABLE KEYS */;
/*!40000 ALTER TABLE `SQUADRON` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STATION`
--

DROP TABLE IF EXISTS `STATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STATION` (
  `Station_ID` int NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Coordinates` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Station_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STATION`
--

LOCK TABLES `STATION` WRITE;
/*!40000 ALTER TABLE `STATION` DISABLE KEYS */;
/*!40000 ALTER TABLE `STATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SUPPLIES_AT_PORT`
--

DROP TABLE IF EXISTS `SUPPLIES_AT_PORT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SUPPLIES_AT_PORT` (
  `Port_ID` int NOT NULL,
  `Supply` varchar(100) NOT NULL,
  PRIMARY KEY (`Port_ID`,`Supply`),
  CONSTRAINT `SUPPLIES_AT_PORT_ibfk_1` FOREIGN KEY (`Port_ID`) REFERENCES `PORT` (`Port_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SUPPLIES_AT_PORT`
--

LOCK TABLES `SUPPLIES_AT_PORT` WRITE;
/*!40000 ALTER TABLE `SUPPLIES_AT_PORT` DISABLE KEYS */;
/*!40000 ALTER TABLE `SUPPLIES_AT_PORT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WARRANT_OFFICER`
--

DROP TABLE IF EXISTS `WARRANT_OFFICER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WARRANT_OFFICER` (
  `Officer_ID` int NOT NULL,
  `Ship` int DEFAULT NULL,
  `Role` varchar(50) DEFAULT NULL,
  `Appointing_Agency` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Officer_ID`),
  KEY `Ship` (`Ship`),
  CONSTRAINT `WARRANT_OFFICER_ibfk_1` FOREIGN KEY (`Officer_ID`) REFERENCES `OFFICER` (`Officer_ID`),
  CONSTRAINT `WARRANT_OFFICER_ibfk_2` FOREIGN KEY (`Ship`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WARRANT_OFFICER`
--

LOCK TABLES `WARRANT_OFFICER` WRITE;
/*!40000 ALTER TABLE `WARRANT_OFFICER` DISABLE KEYS */;
/*!40000 ALTER TABLE `WARRANT_OFFICER` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-26 22:38:41
