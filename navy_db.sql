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
  CONSTRAINT `commissioned_officer_ibfk_1` FOREIGN KEY (`Officer_ID`) REFERENCES `OFFICER` (`Officer_ID`),
  CONSTRAINT `commissioned_officer_ibfk_2` FOREIGN KEY (`Ship`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMMISSIONED_OFFICER`
--

LOCK TABLES `COMMISSIONED_OFFICER` WRITE;
/*!40000 ALTER TABLE `COMMISSIONED_OFFICER` DISABLE KEYS */;
INSERT INTO `COMMISSIONED_OFFICER` VALUES (2,2,2,'Lieutenant'),(3,3,3,'Captain'),(4,0,1,'Second Lieutenant');
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
  CONSTRAINT `crew_ibfk_1` FOREIGN KEY (`Ship_ID`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CREW`
--

LOCK TABLES `CREW` WRITE;
/*!40000 ALTER TABLE `CREW` DISABLE KEYS */;
INSERT INTO `CREW` VALUES (1,'James Blackwell',32,'Captain'),(1,'John Harris',28,'First Mate'),(1,'Samuel Green',35,'Gunner'),(2,'Edward Walker',27,'First Mate'),(2,'Richard Reynolds',30,'Captain'),(2,'William Thomas',33,'Navigator'),(3,'Joseph Clarke',34,'Gunner'),(3,'Thomas Hudson',29,'Captain'),(4,'George Adams',31,'Captain'),(4,'Henry Morgan',29,'First Mate');
/*!40000 ALTER TABLE `CREW` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DISPATCH`
--

DROP TABLE IF EXISTS `DISPATCH`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DISPATCH` (
  `Dispatch_ID` int NOT NULL AUTO_INCREMENT,
  `Date_Issued` date DEFAULT NULL,
  `Issuing_Officer` int DEFAULT NULL,
  `Orders` text,
  `Dispatch_Vessel` int DEFAULT NULL,
  PRIMARY KEY (`Dispatch_ID`),
  KEY `Issuing_Officer` (`Issuing_Officer`),
  KEY `Dispatch_Vessel` (`Dispatch_Vessel`),
  CONSTRAINT `dispatch_ibfk_1` FOREIGN KEY (`Issuing_Officer`) REFERENCES `OFFICER` (`Officer_ID`),
  CONSTRAINT `dispatch_ibfk_2` FOREIGN KEY (`Dispatch_Vessel`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DISPATCH`
--

LOCK TABLES `DISPATCH` WRITE;
/*!40000 ALTER TABLE `DISPATCH` DISABLE KEYS */;
INSERT INTO `DISPATCH` VALUES (1,'1805-06-15',1,'Proceed to the Channel to intercept enemy fleets.',2),(2,'1805-07-20',2,'Patrol the western coast and report any hostile movements.',3),(3,'1805-08-10',3,'Escort convoy to the Mediterranean and ensure safe passage.',4),(4,'1805-09-25',4,'Prepare for a rendezvous with the fleet off the coast of Spain.',5),(5,'1805-10-05',5,'Monitor the French fleet in the Bay of Biscay and provide regular reports.',6);
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
  CONSTRAINT `enemies_engaged_ibfk_1` FOREIGN KEY (`Engagement_ID`) REFERENCES `ENGAGEMENT` (`Engagement_ID`),
  CONSTRAINT `enemies_engaged_ibfk_2` FOREIGN KEY (`Enemy_ID`) REFERENCES `ENEMY_SHIP` (`Enemy_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ENEMIES_ENGAGED`
--

LOCK TABLES `ENEMIES_ENGAGED` WRITE;
/*!40000 ALTER TABLE `ENEMIES_ENGAGED` DISABLE KEYS */;
INSERT INTO `ENEMIES_ENGAGED` VALUES (3,1),(1,2),(2,4);
/*!40000 ALTER TABLE `ENEMIES_ENGAGED` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ENEMY_SHIP`
--

DROP TABLE IF EXISTS `ENEMY_SHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ENEMY_SHIP` (
  `Enemy_ID` int NOT NULL AUTO_INCREMENT,
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
  CONSTRAINT `enemy_ship_ibfk_1` FOREIGN KEY (`Last_Reported_By`) REFERENCES `SHIP` (`Ship_ID`),
  CONSTRAINT `enemy_ship_ibfk_2` FOREIGN KEY (`Last_Sighted_At`) REFERENCES `LOCATION` (`Coordinates`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ENEMY_SHIP`
--

LOCK TABLES `ENEMY_SHIP` WRITE;
/*!40000 ALTER TABLE `ENEMY_SHIP` DISABLE KEYS */;
INSERT INTO `ENEMY_SHIP` VALUES (1,'Santísima Trinidad','Spanish',5,2,'50.8225N, 0.3234W','1805-07-05','Active'),(2,'Princesa','Spanish',4,3,'50.8292N, 0.9517W','1805-08-14','Retreating'),(3,'Alcazar','Spanish',3,4,'51.3810N, 2.3580W','1805-09-01','Active'),(4,'El Rayo','Spanish',4,5,'51.3875N, 0.1345W','1805-10-03','Damaged'),(5,'Neptuno','Spanish',2,6,'51.4545N, 3.5986W','1805-10-12','On Patrol');
/*!40000 ALTER TABLE `ENEMY_SHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ENGAGEMENT`
--

DROP TABLE IF EXISTS `ENGAGEMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ENGAGEMENT` (
  `Engagement_ID` int NOT NULL AUTO_INCREMENT,
  `Coordinates` varchar(50) DEFAULT NULL,
  `Time` datetime DEFAULT NULL,
  `Casualties` int DEFAULT NULL,
  `Outcome` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Engagement_ID`),
  KEY `Coordinates` (`Coordinates`),
  CONSTRAINT `engagement_ibfk_1` FOREIGN KEY (`Coordinates`) REFERENCES `LOCATION` (`Coordinates`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ENGAGEMENT`
--

LOCK TABLES `ENGAGEMENT` WRITE;
/*!40000 ALTER TABLE `ENGAGEMENT` DISABLE KEYS */;
INSERT INTO `ENGAGEMENT` VALUES (1,'50.3755N, 4.1426W','1805-10-12 14:30:00',35,'Victory'),(2,'51.5074N, 0.1278W','1805-10-15 09:00:00',50,'Defeat'),(3,'50.8225N, 0.3234W','1805-10-20 16:45:00',12,'Draw');
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
  `Colour` varchar(10) DEFAULT NULL,
  `Squadron` int DEFAULT NULL,
  `Flagship` int DEFAULT NULL,
  `Predecessor_ID` int DEFAULT NULL,
  PRIMARY KEY (`Officer_ID`),
  KEY `Flagship` (`Flagship`),
  KEY `Predecessor_ID` (`Predecessor_ID`),
  KEY `Squadron` (`Squadron`),
  CONSTRAINT `flag_officer_ibfk_1` FOREIGN KEY (`Officer_ID`) REFERENCES `OFFICER` (`Officer_ID`),
  CONSTRAINT `flag_officer_ibfk_2` FOREIGN KEY (`Flagship`) REFERENCES `SHIP` (`Ship_ID`),
  CONSTRAINT `flag_officer_ibfk_3` FOREIGN KEY (`Predecessor_ID`) REFERENCES `OFFICER` (`Officer_ID`),
  CONSTRAINT `flag_officer_ibfk_4` FOREIGN KEY (`Squadron`) REFERENCES `SQUADRON` (`Squadron_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FLAG_OFFICER`
--

LOCK TABLES `FLAG_OFFICER` WRITE;
/*!40000 ALTER TABLE `FLAG_OFFICER` DISABLE KEYS */;
INSERT INTO `FLAG_OFFICER` VALUES (1,'Rear Admiral','Blue',1,1,NULL),(15,'Admiral','Red',1,1,16),(16,'Vice-Admiral','Red',2,2,15),(17,'Rear-Admiral','White',3,3,16);
/*!40000 ALTER TABLE `FLAG_OFFICER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FLEET`
--

DROP TABLE IF EXISTS `FLEET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FLEET` (
  `Fleet_ID` int NOT NULL AUTO_INCREMENT,
  `Station` int DEFAULT NULL,
  `Commander_in_Chief` int DEFAULT NULL,
  PRIMARY KEY (`Fleet_ID`),
  KEY `Station` (`Station`),
  KEY `Commander_in_Chief` (`Commander_in_Chief`),
  CONSTRAINT `fleet_ibfk_1` FOREIGN KEY (`Station`) REFERENCES `STATION` (`Station_ID`),
  CONSTRAINT `fleet_ibfk_2` FOREIGN KEY (`Commander_in_Chief`) REFERENCES `OFFICER` (`Officer_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FLEET`
--

LOCK TABLES `FLEET` WRITE;
/*!40000 ALTER TABLE `FLEET` DISABLE KEYS */;
INSERT INTO `FLEET` VALUES (1,1,2),(2,2,4),(3,3,6),(4,4,8),(5,5,10),(6,6,12),(7,7,14),(8,8,16),(9,9,18),(10,10,20),(11,1,3),(12,2,5),(13,3,7),(14,4,9),(15,5,11);
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
INSERT INTO `LOCATION` VALUES ('43.1202N, 5.9315E','Port de Toulon'),('43N, 5E','Port of Brest'),('50.3755N, 4.1426W','Plymouth Harbour'),('50.8225N, 0.3234W','Portsmouth Dockyard'),('50.8292N, 0.9517W','Deal Beach'),('51.3810N, 2.3580W','Bristol Dockyard'),('51.3875N, 0.1345W','Chatham Dockyard'),('51.4545N, 3.5986W','Port of Bristol'),('51.5074N, 0.1278W','Port of London'),('52.2053N, 0.1218E','Port of Hull'),('52.2425N, 1.6113W','Port of Leith'),('54.9784N, 1.6174W','Port of Newcastle');
/*!40000 ALTER TABLE `LOCATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OFFICER`
--

DROP TABLE IF EXISTS `OFFICER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OFFICER` (
  `Officer_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `Rank_Index` int DEFAULT NULL,
  `Birthplace` varchar(100) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Officer_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OFFICER`
--

LOCK TABLES `OFFICER` WRITE;
/*!40000 ALTER TABLE `OFFICER` DISABLE KEYS */;
INSERT INTO `OFFICER` VALUES (1,'Horatio Nelson',47,1,'Norfolk, England','Deceased'),(2,'Cuthbert Collingwood',58,2,'Newcastle, England','Deceased'),(3,'Thomas Hardy',45,3,'Portsmouth, England','Deceased'),(4,'Edward Pellew',52,4,'Exmouth, England','Retired'),(5,'Frances Austen',44,5,'Portsmouth, England','Retired'),(6,'John Jervis',61,6,'Meaford, England','Deceased'),(7,'William Hoste',30,7,'Norfolk, England','Deceased'),(8,'Charles Cornwallis',56,8,'London, England','Deceased'),(9,'Richard Howe',68,9,'Londonderry, Ireland','Deceased'),(10,'George Seymour',55,10,'Portsmouth, England','Deceased'),(11,'James Saumarez',50,11,'Guernsey, Channel Islands','Retired'),(12,'Henry Blackwood',44,12,'County Down, Ireland','Deceased'),(13,'James Kempthorne',49,13,'Truro, England','Deceased'),(14,'Robert Calder',58,14,'East Lothian, Scotland','Deceased'),(15,'John Warren',53,15,'Bristol, England','Deceased'),(16,'William Barnett',46,16,'Portsmouth, England','Deceased'),(17,'Sir Edward Codrington',61,17,'Kent, England','Retired'),(18,'George Murray',54,18,'Edinburgh, Scotland','Deceased'),(19,'William Robert Broughton',62,19,'England','Deceased'),(20,'Alexander Cochrane',58,20,'Scotland','Retired');
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
  CONSTRAINT `petty_officer_ibfk_1` FOREIGN KEY (`Officer_ID`) REFERENCES `OFFICER` (`Officer_ID`),
  CONSTRAINT `petty_officer_ibfk_2` FOREIGN KEY (`Ship`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PETTY_OFFICER`
--

LOCK TABLES `PETTY_OFFICER` WRITE;
/*!40000 ALTER TABLE `PETTY_OFFICER` DISABLE KEYS */;
INSERT INTO `PETTY_OFFICER` VALUES (7,1,'Quartermaster'),(8,2,'Signalman'),(9,3,'Coxswain');
/*!40000 ALTER TABLE `PETTY_OFFICER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PORT`
--

DROP TABLE IF EXISTS `PORT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PORT` (
  `Port_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Coordinates` varchar(50) DEFAULT NULL,
  `Alignment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Port_ID`),
  KEY `Coordinates` (`Coordinates`),
  CONSTRAINT `port_ibfk_1` FOREIGN KEY (`Coordinates`) REFERENCES `LOCATION` (`Coordinates`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PORT`
--

LOCK TABLES `PORT` WRITE;
/*!40000 ALTER TABLE `PORT` DISABLE KEYS */;
INSERT INTO `PORT` VALUES (1,'Plymouth','50.3755N, 4.1426W','British Royal Navy'),(2,'Portsmouth','50.8225N, 0.3234W','British Royal Navy'),(3,'Deal','50.8292N, 0.9517W','British Royal Navy'),(4,'Bristol','51.3810N, 2.3580W','British Royal Navy'),(5,'Chatham','51.3875N, 0.1345W','British Royal Navy'),(6,'Bristol','51.4545N, 3.5986W','British Royal Navy'),(7,'London','51.5074N, 0.1278W','British Royal Navy'),(8,'Hull','52.2053N, 0.1218E','British Royal Navy'),(9,'Leith','52.2425N, 1.6113W','British Royal Navy'),(10,'Newcastle','54.9784N, 1.6174W','British Royal Navy');
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
  CONSTRAINT `report_ibfk_1` FOREIGN KEY (`Dispatch_ID`) REFERENCES `DISPATCH` (`Dispatch_ID`),
  CONSTRAINT `report_ibfk_2` FOREIGN KEY (`Reporting_Officer`) REFERENCES `OFFICER` (`Officer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REPORT`
--

LOCK TABLES `REPORT` WRITE;
/*!40000 ALTER TABLE `REPORT` DISABLE KEYS */;
INSERT INTO `REPORT` VALUES (1,1,'Completed','The ship has successfully navigated through enemy waters and is now docked at its assigned station.'),(2,3,'In Progress','The ship is currently on a reconnaissance mission. Awaiting further orders.'),(3,5,'Delayed','The vessel encountered adverse weather conditions, causing a delay in its journey to the designated port.'),(4,7,'Completed','The mission was a success. Enemy ships were repelled, and the convoy arrived at the port without further incident.'),(5,9,'In Progress','The ship is awaiting orders to proceed with its scheduled patrol in the southern waters.');
/*!40000 ALTER TABLE `REPORT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SHIP`
--

DROP TABLE IF EXISTS `SHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHIP` (
  `Ship_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Ship_Type` varchar(50) DEFAULT NULL,
  `Tonnage` int DEFAULT NULL,
  `Origin_Year` int DEFAULT NULL,
  `Origin_Shipyard` varchar(100) DEFAULT NULL,
  `Gun_Count` int DEFAULT NULL,
  `Coordinates` varchar(50) DEFAULT NULL,
  `Last_Port_Of_Call` varchar(100) DEFAULT NULL,
  `Last_Date_Of_Call` date DEFAULT NULL,
  PRIMARY KEY (`Ship_ID`),
  KEY `Coordinates` (`Coordinates`),
  CONSTRAINT `ship_ibfk_1` FOREIGN KEY (`Coordinates`) REFERENCES `LOCATION` (`Coordinates`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHIP`
--

LOCK TABLES `SHIP` WRITE;
/*!40000 ALTER TABLE `SHIP` DISABLE KEYS */;
INSERT INTO `SHIP` VALUES (1,'HMS Victory','First-Rate Ship of the Line',2200,1765,'Portsmouth Dockyard',104,'51.3810N, 2.3580W','Port of London','1805-10-21'),(2,'HMS Royal Sovereign','First-Rate Ship of the Line',1800,1786,'Chatham Dockyard',100,'51.3875N, 0.1345W','Plymouth Harbour','1797-06-14'),(3,'HMS Britannia','First-Rate Ship of the Line',2000,1774,'Portsmouth Dockyard',98,'50.8225N, 0.3234W','Port of Hull','1780-09-30'),(4,'HMS Temeraire','Second-Rate Ship of the Line',1600,1798,'Plymouth Harbour',98,'50.3755N, 4.1426W','Portsmouth Dockyard','1805-10-21'),(5,'HMS Implacable','Ship of the Line',1600,1795,'Portsmouth Dockyard',74,'50.8225N, 0.3234W','Port of Leith','1805-11-03'),(6,'HMS Defiance','First-Rate Ship of the Line',2050,1774,'Chatham Dockyard',98,'51.3875N, 0.1345W','Portsmouth Dockyard','1780-12-10'),(7,'HMS Agamemnon','Third-Rate Ship of the Line',1300,1781,'Plymouth Harbour',64,'51.4545N, 3.5986W','Port of Hull','1793-05-29'),(8,'HMS Audacious','Third-Rate Ship of the Line',1200,1797,'Portsmouth Dockyard',74,'51.5074N, 0.1278W','Bristol Dockyard','1807-07-12'),(9,'HMS Neptune','Second-Rate Ship of the Line',1700,1797,'Chatham Dockyard',98,'54.9784N, 1.6174W','Portsmouth Dockyard','1797-03-20'),(10,'HMS Mars','Ship of the Line',1400,1794,'Portsmouth Dockyard',74,'52.2053N, 0.1218E','Port of Leith','1803-11-04');
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
  CONSTRAINT `ships_engaged_ibfk_1` FOREIGN KEY (`Engagement_ID`) REFERENCES `ENGAGEMENT` (`Engagement_ID`),
  CONSTRAINT `ships_engaged_ibfk_2` FOREIGN KEY (`Ship_ID`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHIPS_ENGAGED`
--

LOCK TABLES `SHIPS_ENGAGED` WRITE;
/*!40000 ALTER TABLE `SHIPS_ENGAGED` DISABLE KEYS */;
INSERT INTO `SHIPS_ENGAGED` VALUES (3,1),(1,2),(1,4),(2,5);
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
  CONSTRAINT `ships_in_squadron_ibfk_1` FOREIGN KEY (`Squadron_ID`) REFERENCES `SQUADRON` (`Squadron_ID`),
  CONSTRAINT `ships_in_squadron_ibfk_2` FOREIGN KEY (`Ship_ID`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHIPS_IN_SQUADRON`
--

LOCK TABLES `SHIPS_IN_SQUADRON` WRITE;
/*!40000 ALTER TABLE `SHIPS_IN_SQUADRON` DISABLE KEYS */;
INSERT INTO `SHIPS_IN_SQUADRON` VALUES (3,1),(1,2),(1,3),(2,4),(4,5);
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
  CONSTRAINT `ships_received_ibfk_1` FOREIGN KEY (`Dispatch_ID`) REFERENCES `DISPATCH` (`Dispatch_ID`),
  CONSTRAINT `ships_received_ibfk_2` FOREIGN KEY (`Ship_ID`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHIPS_RECEIVED`
--

LOCK TABLES `SHIPS_RECEIVED` WRITE;
/*!40000 ALTER TABLE `SHIPS_RECEIVED` DISABLE KEYS */;
INSERT INTO `SHIPS_RECEIVED` VALUES (3,1),(1,2),(1,3),(2,4),(4,5);
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
INSERT INTO `SHIPYARD_LOCATION` VALUES ('Bristol Dockyard','Bristol'),('Chatham Dockyard','Chatham'),('Plymouth Dockyard','Plymouth'),('Portsmouth Dockyard','Portsmouth'),('Sheerness Dockyard','Sheerness');
/*!40000 ALTER TABLE `SHIPYARD_LOCATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SQUADRON`
--

DROP TABLE IF EXISTS `SQUADRON`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SQUADRON` (
  `Squadron_ID` int NOT NULL AUTO_INCREMENT,
  `Fleet` int DEFAULT NULL,
  `Commander` int DEFAULT NULL,
  `Station` int DEFAULT NULL,
  `S_Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Squadron_ID`),
  KEY `Fleet` (`Fleet`),
  KEY `Commander` (`Commander`),
  KEY `Station` (`Station`),
  CONSTRAINT `squadron_ibfk_1` FOREIGN KEY (`Fleet`) REFERENCES `FLEET` (`Fleet_ID`),
  CONSTRAINT `squadron_ibfk_2` FOREIGN KEY (`Commander`) REFERENCES `OFFICER` (`Officer_ID`),
  CONSTRAINT `squadron_ibfk_3` FOREIGN KEY (`Station`) REFERENCES `STATION` (`Station_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SQUADRON`
--

LOCK TABLES `SQUADRON` WRITE;
/*!40000 ALTER TABLE `SQUADRON` DISABLE KEYS */;
INSERT INTO `SQUADRON` VALUES (1,1,2,6,'Active'),(2,1,3,7,'Ready'),(3,2,4,8,'On Patrol'),(4,3,5,9,'Active'),(5,4,6,10,'Deployed'),(6,1,2,1,'Active'),(7,2,4,2,'Deployed'),(8,3,6,3,'Ready'),(9,4,8,4,'In Port'),(10,5,10,5,'On Mission');
/*!40000 ALTER TABLE `SQUADRON` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STATION`
--

DROP TABLE IF EXISTS `STATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STATION` (
  `Station_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Coordinates` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Station_ID`),
  KEY `Coordinates` (`Coordinates`),
  CONSTRAINT `station_ibfk_1` FOREIGN KEY (`Coordinates`) REFERENCES `LOCATION` (`Coordinates`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STATION`
--

LOCK TABLES `STATION` WRITE;
/*!40000 ALTER TABLE `STATION` DISABLE KEYS */;
INSERT INTO `STATION` VALUES (1,'Portsmouth Naval Base','50.8225N, 0.3234W'),(2,'Plymouth Dockyard','50.3755N, 4.1426W'),(3,'Chatham Naval Yard','51.3875N, 0.1345W'),(4,'Bristol Shipyard','51.3810N, 2.3580W'),(5,'Port of London Hub','51.5074N, 0.1278W'),(6,'Portsmouth Naval Base','50.8225N, 0.3234W'),(7,'Plymouth Dockyard','50.3755N, 4.1426W'),(8,'Chatham Dockyard','51.3875N, 0.1345W'),(9,'Bristol Dockyard','51.3810N, 2.3580W'),(10,'Port of London','51.5074N, 0.1278W'),(11,'Plymouth Harbour','50.3755N, 4.1426W'),(12,'Portsmouth Dockyard','50.8225N, 0.3234W'),(13,'Deal Beach','50.8292N, 0.9517W'),(14,'Bristol Dockyard','51.3810N, 2.3580W'),(15,'Chatham Dockyard','51.3875N, 0.1345W');
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
  CONSTRAINT `supplies_at_port_ibfk_1` FOREIGN KEY (`Port_ID`) REFERENCES `PORT` (`Port_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SUPPLIES_AT_PORT`
--

LOCK TABLES `SUPPLIES_AT_PORT` WRITE;
/*!40000 ALTER TABLE `SUPPLIES_AT_PORT` DISABLE KEYS */;
INSERT INTO `SUPPLIES_AT_PORT` VALUES (1,'Food rations'),(2,'Medical supplies'),(3,'Ammunition'),(4,'Freshwater'),(5,'Cannon balls'),(6,'Sails and ropes'),(7,'Naval uniforms'),(8,'Coal for engines'),(9,'Timber for repairs'),(10,'Navigational charts');
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
  CONSTRAINT `warrant_officer_ibfk_1` FOREIGN KEY (`Officer_ID`) REFERENCES `OFFICER` (`Officer_ID`),
  CONSTRAINT `warrant_officer_ibfk_2` FOREIGN KEY (`Ship`) REFERENCES `SHIP` (`Ship_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WARRANT_OFFICER`
--

LOCK TABLES `WARRANT_OFFICER` WRITE;
/*!40000 ALTER TABLE `WARRANT_OFFICER` DISABLE KEYS */;
INSERT INTO `WARRANT_OFFICER` VALUES (5,2,'Purser','Royal Navy'),(6,3,'Gunner','Royal Navy');
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

-- Dump completed on 2024-11-29 20:48:37
