-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: employee
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `AttendanceID` int NOT NULL AUTO_INCREMENT,
  `EmployeeID` int DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `CheckInTime` time DEFAULT NULL,
  `CheckOutTime` time DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`AttendanceID`),
  KEY `EmployeeID` (`EmployeeID`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (2,4,'2024-05-30','12:18:20','15:24:56',NULL),(5,5,'2024-05-30','12:48:52',NULL,NULL),(6,3,'2024-05-30','12:51:15','16:38:45',NULL),(7,4,'2024-05-30','12:51:56','15:24:56',NULL),(8,6,'2024-05-30','13:10:24','13:18:30',NULL),(9,4,'2024-05-30','15:18:20','15:24:56',NULL),(10,3,'2024-05-30','15:42:21','16:38:45',NULL),(11,3,'2024-05-30','16:57:46',NULL,NULL),(12,8,'2024-05-31','13:30:40','14:31:34',NULL),(13,7,'2024-04-20','14:23:51','14:29:53',NULL),(14,7,'2024-05-31','16:22:51','16:22:56',NULL),(15,3,'2024-06-03','15:34:56','15:36:26',NULL),(16,7,'2024-06-03','17:08:38','17:08:40',NULL),(17,3,'2024-06-05','10:58:01','11:16:59',NULL),(18,4,'2024-06-06','11:56:48',NULL,NULL),(19,3,'2024-06-06','14:34:16','14:34:23',NULL),(20,7,'2024-06-07','10:28:22','10:28:34',NULL),(22,4,'2024-06-10','16:58:26','16:59:27',NULL),(24,12,'2024-06-11','12:44:27',NULL,NULL),(26,2,'2024-06-19','12:22:28',NULL,NULL),(27,2,'2024-06-25','16:16:04','16:17:09',NULL),(28,4,'2024-06-25','16:24:09',NULL,NULL),(29,1,'2024-06-25',NULL,NULL,'Not Logged In'),(30,3,'2024-06-25',NULL,NULL,'Not Logged In'),(31,5,'2024-06-25',NULL,NULL,'Not Logged In'),(32,6,'2024-06-25',NULL,NULL,'Not Logged In'),(33,7,'2024-06-25',NULL,NULL,'Not Logged In'),(34,8,'2024-06-25',NULL,NULL,'Not Logged In'),(35,12,'2024-06-25',NULL,NULL,'Leave'),(36,13,'2024-06-25',NULL,NULL,'Not Logged In');
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `EmployeeID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `RoleID` int DEFAULT NULL,
  `tempAddres` varchar(100) DEFAULT NULL,
  `maritalstatus` varchar(20) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `emergencyPhoneNo` varchar(10) DEFAULT NULL,
  `emergencyContactpersonName` varchar(20) DEFAULT NULL,
  `bloodGroup` varchar(15) DEFAULT NULL,
  `IsActive` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`EmployeeID`),
  UNIQUE KEY `Email` (`Email`),
  KEY `RoleID` (`RoleID`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Kamlesh','yadav','2024-05-08','kananth494@gmail.com','07892869519','Kannappanahalli village, shidlaghatta Tq, Chikkaballapur dist','2024-05-31',2,'null','Married','Male','null','null','O Positive',1),(2,'Ananth','kumar','2024-05-10','ananthtd234@gmail.com','7892869519','Kannappanahalli village, Pallicherlu post, Chikkaballapur dist , shidlaghatta Tq','2024-05-25',2,'HSR Layout','Single','Male','8550006974','abcd','B Positive',1),(3,'navin','reddy','2024-05-01','navin@gmail.com','7685948619','Bangalore','2024-05-25',1,'AndhraPradesh','','','null','null','',1),(4,'rushal','kumar','2024-05-05','mrrookie1221@gmail.com','6597869438','Chennai','2024-05-30',2,'null','','','null','null','',1),(5,'Jay','M','2024-05-07','jay@gmail.com','07892869519','Kannappanahalli village, shidlaghatta Tq, Chikkaballapur dist','2024-05-09',3,'Pune','Single','Male','null','abcd','AB Positive',1),(6,'suresh','prasad','2024-05-29','suri@gmail.com','76859486549','ABCD','2024-05-30',2,'null','Married','Male','null','null','O Negative',1),(7,'abc','def','2024-05-30','abc@gmail.com','8695969529','Bangalore','2024-05-18',2,'HSR','married','male','9980912619','Apaathbandhav',NULL,1),(8,'Amlesh','yadav','2024-05-10','ananth@12gmail.com','7892869519','Kannappanahalli village, Pallicherlu post, Chikkaballapur dist , shidlaghatta Tq','2024-05-25',2,'null','Married','Male','null','null','B Negative',1),(12,'Sagar','hejaji','1996-12-25','hejajisagar@gmail.com','8879574828','Banashankari','2024-06-05',2,'Bangalore','Single','Male','8879574828','Sandeep','AB Negative',1),(13,'Alien','Telisko','2024-06-01','telusko@gmail.com','2345678517','Space','2024-06-20',3,'Bhoomi','Married','Male','7766558844','Known','AB Negative',1);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `holidays`
--

DROP TABLE IF EXISTS `holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `holidays` (
  `holidayid` int NOT NULL AUTO_INCREMENT,
  `holidayDate` date DEFAULT NULL,
  `holidayName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`holidayid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holidays`
--

LOCK TABLES `holidays` WRITE;
/*!40000 ALTER TABLE `holidays` DISABLE KEYS */;
INSERT INTO `holidays` VALUES (1,'2024-01-01','New Year'),(2,'2024-01-15','Sankranthi'),(4,'2024-01-26','Republic Day'),(5,'2024-04-11','Ramzan'),(6,'2024-05-01','May Day'),(7,'2024-08-15','IndependenceDay'),(8,'2024-10-02','Gandhi Jayanthi'),(9,'2024-10-31','Deepavali'),(12,'2024-11-01','Kannada Rajyothsava'),(13,'2024-12-25','Christmas Day');
/*!40000 ALTER TABLE `holidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leaves`
--

DROP TABLE IF EXISTS `leaves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leaves` (
  `LeaveID` int NOT NULL AUTO_INCREMENT,
  `EmployeeID` int DEFAULT NULL,
  `LeaveType` varchar(50) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `LeaveStatus` varchar(20) DEFAULT NULL,
  `AppliedDate` date DEFAULT NULL,
  `ApprovedDate` date DEFAULT NULL,
  `ApprovedBy` int DEFAULT NULL,
  `reason` varchar(500) DEFAULT NULL,
  `rejectReason` varchar(500) DEFAULT NULL,
  `TotalDays` int DEFAULT NULL,
  PRIMARY KEY (`LeaveID`),
  KEY `EmployeeID` (`EmployeeID`),
  KEY `ApprovedBy` (`ApprovedBy`),
  CONSTRAINT `leaves_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`),
  CONSTRAINT `leaves_ibfk_2` FOREIGN KEY (`ApprovedBy`) REFERENCES `employees` (`EmployeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaves`
--

LOCK TABLES `leaves` WRITE;
/*!40000 ALTER TABLE `leaves` DISABLE KEYS */;
INSERT INTO `leaves` VALUES (2,4,'Sick Leave','2024-06-11','2024-06-11','approved','2024-06-06','2024-06-10',3,'Feeling Sick','Due to emergency client meeting',NULL),(3,7,'Casual Leave','2024-06-07','2024-06-11','Rejected','2024-06-07','2024-06-10',3,'Testing','Sumne',NULL),(7,12,'Sick Leave','2024-08-14','2024-08-20','Rejected','2024-06-10','2024-06-10',3,'Personal','Not confirm',4),(9,2,'Sick Leave','2024-06-12','2024-06-13','Approved','2024-06-11','2024-06-11',3,'High fever','',2),(12,2,'Casual Leave','2024-06-13','2024-06-14','Approved','2024-06-11','2024-06-11',3,'Will be having meeting on monday and tuesday regarding project so kindly re-consider your leave request',NULL,2),(13,2,'Casual Leave','2024-06-14','2024-06-14','Rejected','2024-06-11','2024-06-19',3,'Vacation','Took more leaves..',1),(14,12,'Annual Leave','2024-06-22','2024-06-25','Approved','2024-06-20','2024-06-20',3,'Simply',NULL,2),(15,12,'Casual Leave','2024-06-21','2024-06-21','Approved','2024-06-21','2024-06-21',3,'NO REASON',NULL,1),(16,12,'Casual Leave','2024-06-21','2024-06-21','Approved','2024-06-21','2024-06-21',5,'aas',NULL,1),(17,2,'Casual Leave','2024-06-21','2024-06-21','Rejected','2024-06-21','2024-06-21',13,'Y should I!','Simply',1),(18,4,'Sick Leave','2024-06-26','2024-06-28','Approved','2024-06-21','2024-06-21',13,'Boring',NULL,3),(20,2,'Sick Leave','2024-06-28','2024-06-28','pending','2024-06-25',NULL,NULL,'High fever',NULL,1);
/*!40000 ALTER TABLE `leaves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leavesstock`
--

DROP TABLE IF EXISTS `leavesstock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leavesstock` (
  `employeeid` int NOT NULL,
  `consumedLeaves` int DEFAULT '0',
  `AvailableLeaves` int DEFAULT '0',
  PRIMARY KEY (`employeeid`),
  CONSTRAINT `leavesstock_ibfk_1` FOREIGN KEY (`employeeid`) REFERENCES `employees` (`EmployeeID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leavesstock`
--

LOCK TABLES `leavesstock` WRITE;
/*!40000 ALTER TABLE `leavesstock` DISABLE KEYS */;
INSERT INTO `leavesstock` VALUES (2,2,7),(4,3,10),(12,4,6),(13,0,4);
/*!40000 ALTER TABLE `leavesstock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `mgrId` int NOT NULL AUTO_INCREMENT,
  `manager` int DEFAULT NULL,
  `employee` int DEFAULT NULL,
  PRIMARY KEY (`mgrId`),
  KEY `manager` (`manager`),
  KEY `employee` (`employee`),
  CONSTRAINT `manager_ibfk_1` FOREIGN KEY (`manager`) REFERENCES `employees` (`EmployeeID`),
  CONSTRAINT `manager_ibfk_2` FOREIGN KEY (`employee`) REFERENCES `employees` (`EmployeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES (1,5,6),(2,5,8),(3,5,12),(4,13,2),(5,13,4);
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `RoleID` int NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(50) NOT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'HR'),(2,'Trainee'),(3,'Manager');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_credentials`
--

DROP TABLE IF EXISTS `user_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_credentials` (
  `EmployeeID` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  CONSTRAINT `user_credentials_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_credentials`
--

LOCK TABLES `user_credentials` WRITE;
/*!40000 ALTER TABLE `user_credentials` DISABLE KEYS */;
INSERT INTO `user_credentials` VALUES (2,'ananth','$2a$10$pnbbRERa11M8iXVEtK8HfOLB1MxkBNIydvOkiDGOERra5SW/rGBZ.'),(3,'navin','$2a$10$uUMVQpGiRXuXP0xZ6iDl7eKORAddtICqfbdjnTsu17zDoMF3fN1Eu'),(4,'rushal','$2a$10$QWx6T6MkvsRzrh3lflutreQl3OaO2ABjzBwIvg99g0ul2AQ58NBiC'),(5,'jay','$2a$10$ovuzslHxt8wuoJMLnUy9leKaFwHIxNwh2HuqFVfheHmSHcnOVlvCW'),(6,'suresh','$2a$10$e2ypF5/JSTCdLJgwuP9M6ebiPz2U.V15B1XJsEl8LtxS.Ey7eNiau'),(7,'abc','$2a$10$V2Qyk/D22cyHGHvaSyIKduls2sBpmAB3xSL6rgYq4csnHqh8a/B8y'),(8,'bheem','$2a$10$p6Mms.uucveU43nXImYY2uc6/agQvaSobsZAAYenObQR5.yFbcGdu'),(12,'sagar','$2a$10$JwoYRTc5sOXl5mWDbnNk7e5F/JTACv1bEtkDoqOiemw2jr3EqaZR.'),(13,'alien','$2a$10$tBQnMv67O.0sN4DCNCbbsui/.3Ev4digJ3cFuqzCUbA/2AftNetaG');
/*!40000 ALTER TABLE `user_credentials` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-26 14:21:40
