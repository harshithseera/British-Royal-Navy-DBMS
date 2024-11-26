-- MySQL dump 10.13  Distrib 9.0.1, for macos14.7 (arm64)
--
-- Host: localhost    Database: navy
-- ------------------------------------------------------
-- Server version	9.1.0

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
INSERT INTO `COMMISSIONED_OFFICER` VALUES (1,10,2,'Captain'),(4,8,3,'Lieutenant');
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
INSERT INTO `CREW` VALUES (1,'Edward Davis',40,'Quartermaster'),(1,'John Smith',34,'Captain'),(1,'Richard Thompson',28,'First Mate'),(2,'George Brown',32,'Gunner'),(2,'James Harris',30,'First Mate'),(2,'Thomas Williams',36,'Captain'),(3,'Henry Wilson',38,'Navigator'),(3,'William Jones',45,'Captain'),(4,'Charles Lewis',29,'Midshipman'),(4,'Samuel Clark',33,'Captain');
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
INSERT INTO `DISPATCH` VALUES (1,'1805-10-15',1,'Proceed to Trafalgar and engage enemy fleet.',1),(2,'1805-10-14',2,'Reinforce the blockade at Cadiz.',2),(3,'1805-10-13',3,'Patrol the English Channel for enemy ships.',3),(4,'1805-10-12',4,'Escort merchant convoy to Gibraltar.',4),(5,'1805-10-11',5,'Deliver supplies to allied forces in Malta.',5);
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
INSERT INTO `ENEMIES_ENGAGED` VALUES (1,1),(3,1),(4,1),(1,2),(2,2),(4,2),(5,2),(1,3),(3,3),(5,3),(2,4),(3,4),(5,4),(2,5),(4,5);
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
  `Name` varchar(100) DEFAULT NULL,
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
INSERT INTO `ENEMY_SHIP` VALUES (1,'Le Redoutable','French',5,1,'50.8202N, 0.1373W','1805-10-20','Engaged'),(2,'Santísima Trinidad','Spanish',4,2,'50.8278N, 0.9728W','1805-10-18','Sunk'),(3,'Le Bucentaure','French',4,3,'49.4654N, 2.5313W','1805-10-19','Damaged'),(4,'L’Orient','French',5,4,'51.5074N, 0.1278W','1805-10-17','Destroyed'),(5,'Nuestra Señora de la Santísima Concepción','Spanish',3,5,'50.8978N, 1.4044W','1805-10-15','Retreated');
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
  `Time` datetime DEFAULT NULL,
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
INSERT INTO `ENGAGEMENT` VALUES (1,'49.4654N, 2.5313W','1805-10-21 14:30:00',120,'Victory'),(2,'50.8202N, 0.1373W','1805-10-22 10:45:00',150,'Defeat'),(3,'50.8278N, 0.9728W','1805-10-23 16:00:00',80,'Draw'),(4,'50.8978N, 1.4044W','1805-10-24 09:30:00',100,'Victory'),(5,'51.5074N, 0.1278W','1805-10-25 11:15:00',60,'Victory');
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
INSERT INTO `FLAG_OFFICER` VALUES (1,'Admiral','2',5,NULL),(2,'Vice Admiral','3',4,1),(3,'Rear Admiral','1',2,2),(4,'Commodore','2',6,3),(5,'Admiral','4',7,4);
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
INSERT INTO `FLEET` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5);
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
INSERT INTO `LOCATION` VALUES ('49.4654N, 2.5313W','Channel Islands Station'),('50.8202N, 0.1373W','Portsmouth Dockyard'),('50.8278N, 0.9728W','Spithead Anchorage'),('50.8978N, 1.4044W','Royal Clarence Yard'),('51.5074N, 0.1278W','Admiralty House, London');
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
INSERT INTO `OFFICER` VALUES (1,'John Nelson',35,5,'London','Active'),(2,'James Cook',40,4,'Yorkshire','Retired'),(3,'Horatio Hornblower',28,3,'Kent','Active'),(4,'Francis Drake',45,6,'Plymouth','Retired'),(5,'Edward Pellew',50,4,'Exeter','Active'),(6,'William Bligh',42,5,'Bristol','Active'),(7,'Thomas Cochrane',30,3,'Edinburgh','Active'),(8,'John Jervis',55,6,'London','Retired'),(9,'Richard Howe',60,7,'London','Retired'),(10,'Nelson Hardy',38,5,'Portsmouth','Active'),(11,'George Vancouver',36,4,'Kingston upon Thames','Active'),(12,'David Farragut',45,6,'New York','Retired'),(13,'William Howe',50,7,'London','Active'),(14,'Alexander Beatty',40,4,'Belfast','Active'),(15,'John Byron',50,5,'London','Retired');
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
INSERT INTO `PETTY_OFFICER` VALUES (3,4,'Quartermaster'),(8,7,'Cook');
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
INSERT INTO `PORT` VALUES (1,'Portsmouth','50.8202N, 0.1373W','Royal Navy'),(2,'Falmouth','50.1554N, -5.0700W','Royal Navy'),(3,'Plymouth','50.3755N, -4.1427W','Royal Navy'),(4,'London Docks','51.5074N, 0.1278W','Royal Navy'),(5,'Port of Dover','51.1290N, 1.3250E','Royal Navy');
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
INSERT INTO `REPORT` VALUES (1,1,'Completed','Report on the successful engagement of the enemy ship Le Redoutable.'),(2,2,'Ongoing','Patrol activity near Spithead Anchorage. No unusual sightings.'),(3,3,'Delayed','Delayed response due to adverse weather near the Channel Islands Station.'),(4,4,'Completed','Routine inspection of HMS Victory docked at Portsmouth Dockyard.'),(5,5,'Pending','Awaiting further orders from Admiralty House for deployment.');
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
  `Name` varchar(100) DEFAULT NULL,
  `Ship_Type` varchar(50) DEFAULT NULL,
  `Tonnage` int DEFAULT NULL,
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
INSERT INTO `SHIP` VALUES (1,'HMS Victory','Ship of the Line',3500,1765,'Chatham Dockyard',104,'51.4423,-0.3454','Portsmouth','1805-10-21'),(2,'HMS Temeraire','Second Rate',2100,1798,'Chatham Dockyard',98,'51.4833,-0.2311','Portsmouth','1805-10-20'),(3,'HMS Agamemnon','Third Rate',1600,1781,'Bucklers Hard',64,'50.7989,-1.1123','Plymouth','1805-10-19'),(4,'HMS Defiance','Fourth Rate',1450,1783,'Deptford Dockyard',74,'51.4791,-0.0226','Falmouth','1805-10-18'),(5,'HMS Dreadnought','First Rate',3000,1801,'Portsmouth Dockyard',98,'50.8198,-1.0916','London','1805-10-17'),(6,'HMS Renown','Battlecruiser',25000,1916,'Portsmouth Dockyard',8,'50.8242,-1.2658','Gibraltar','1941-08-15'),(7,'HMS Revenge','Battleship',29000,1915,'Plymouth Dockyard',12,'51.1673,-0.4184','Portsmouth','1942-03-10'),(8,'HMS Vanguard','Battleship',42000,1944,'Clydebank Shipyards',10,'55.8754,-4.3912','Belfast','1944-06-14'),(9,'HMS Exeter','Light Cruiser',8600,1929,'Chatham Dockyard',6,'50.7192,-1.6120','Hong Kong','1939-12-10'),(10,'HMS Ark Royal','Aircraft Carrier',22000,1955,'Plymouth Dockyard',20,'50.3851,-4.2230','Malta','1956-04-23');
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
INSERT INTO `SHIPS_ENGAGED` VALUES (1,1),(2,1),(4,1),(5,1),(1,2),(3,2),(5,2),(1,3),(3,3),(4,3),(2,4),(3,4),(5,4),(2,5),(4,5);
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
INSERT INTO `SHIPS_IN_SQUADRON` VALUES (1,1),(1,2),(1,3),(2,4),(2,5),(2,6),(3,7),(3,8),(3,9),(4,10);
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
INSERT INTO `SHIPS_RECEIVED` VALUES (1,1),(3,1),(1,2),(4,2),(1,3),(1,4),(4,4),(1,5),(3,5),(2,6),(3,6),(2,7),(2,8),(2,9),(2,10);
/*!40000 ALTER TABLE `SHIPS_RECEIVED` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SHIPYARD_LOCATION`
--

DROP TABLE IF EXISTS `SHIPYARD_LOCATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHIPYARD_LOCATION` (
  `ORIGIN_SHIPYARD` varchar(100) NOT NULL,
  `ORIGIN_CITY` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ORIGIN_SHIPYARD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHIPYARD_LOCATION`
--

LOCK TABLES `SHIPYARD_LOCATION` WRITE;
/*!40000 ALTER TABLE `SHIPYARD_LOCATION` DISABLE KEYS */;
INSERT INTO `SHIPYARD_LOCATION` VALUES ('Birkenhead Dockyard','Birkenhead'),('Bucklers Hard','New Forest'),('Chatham Dockyard','Chatham'),('Deptford Dockyard','London'),('Devonport Dockyard','Plymouth'),('Gosport Dockyard','Gosport'),('Plymouth Dockyard','Plymouth'),('Portsmouth Dockyard','Portsmouth'),('Royal Clarence Yard','Portsmouth'),('Sheerness Dockyard','Sheerness');
/*!40000 ALTER TABLE `SHIPYARD_LOCATION` ENABLE KEYS */;
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
INSERT INTO `SQUADRON` VALUES (1,1,1,1,'Active'),(2,1,2,2,'Active'),(3,2,3,3,'Inactive'),(4,2,4,4,'Active');
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
INSERT INTO `STATION` VALUES (1,'Portsmouth Naval Base','50.7957,-1.1066'),(2,'Chatham Dockyard','51.3800,-0.5280'),(3,'Devonport Dockyard','50.3714,-4.1453'),(4,'Faslane Naval Base','56.0013,-4.8192'),(5,'Rosyth Dockyard','56.0213,-3.4532');
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
INSERT INTO `SUPPLIES_AT_PORT` VALUES (1,'Ammunition'),(1,'Food'),(1,'Freshwater'),(1,'Fuel'),(1,'Medical Supplies'),(2,'Ammunition'),(2,'Food'),(2,'Freshwater'),(2,'Fuel'),(2,'Medical Supplies'),(3,'Ammunition'),(3,'Food'),(3,'Freshwater'),(3,'Fuel'),(3,'Medical Supplies');
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
INSERT INTO `WARRANT_OFFICER` VALUES (2,5,'Boatswain','Admiralty'),(7,7,'Gunner','Royal Navy');
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

-- Dump completed on 2024-11-27  0:55:13
