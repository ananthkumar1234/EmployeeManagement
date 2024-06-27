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
  `Remarks` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`AttendanceID`),
  KEY `EmployeeID` (`EmployeeID`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (52,16,'2024-06-26','13:24:12',NULL,NULL),(53,16,'2024-06-25','10:00:00','18:00:00',NULL),(54,17,'2024-06-26','17:07:45','17:07:53',NULL),(55,17,'2024-06-25',NULL,NULL,NULL),(56,17,'2024-06-25','10:00:00','18:00:00',NULL),(57,17,'2024-06-27','10:35:39',NULL,NULL),(58,18,'2024-06-26',NULL,NULL,'Not Logged In'),(59,19,'2024-06-26',NULL,NULL,'Not Logged In'),(60,20,'2024-06-26',NULL,NULL,'Not Logged In'),(61,21,'2024-06-26',NULL,NULL,'Not Logged In'),(62,22,'2024-06-26',NULL,NULL,'Not Logged In'),(63,23,'2024-06-26',NULL,NULL,'Not Logged In');
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendanceupdate`
--

DROP TABLE IF EXISTS `attendanceupdate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendanceupdate` (
  `AttendanceId` int NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Date` date NOT NULL,
  `CheckInTime` time DEFAULT NULL,
  `CheckOutTime` time DEFAULT NULL,
  `EmployeeId` int DEFAULT NULL,
  PRIMARY KEY (`AttendanceId`),
  CONSTRAINT `attendanceupdate_ibfk_1` FOREIGN KEY (`AttendanceId`) REFERENCES `attendance` (`AttendanceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendanceupdate`
--

LOCK TABLES `attendanceupdate` WRITE;
/*!40000 ALTER TABLE `attendanceupdate` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendanceupdate` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (16,'Suresh','Babbu','1980-01-01','suresh@gmail.com','9080706050','Chennai','2017-05-26',1,'Chennai','Married','Male','9988776655','Mother','A Positive',1),(17,'Rushal','Premanand','2001-02-12','rushal1218prem@gmail.com','9176009764','12/120, ABC Street, XYZ, Chennai-099','2023-10-11',2,'Electronic City, Bengaluru-060;','Single','Male','9012543789','Premanand','B Positive',1),(18,'Ananth ','Kumar ','2000-06-04','ananthtd234@gmail.com','7892869519','Shidlagatta-562105','2023-10-11',2,'Electronic City, Bengaluru-060;','Single','Male','1234567890','Ananth Jr','B Negative',1),(19,'Sagar','H','1996-12-11','hejajisagar@gmail.com','7349101964','Bengaluru','2023-10-11',5,'Bengaluru','Single','Male','1928374650','Ragas','O Positive',1),(20,'Jayasree','C','2000-01-07','cjayasree01@gmail.com','77999374544','Andhra Pradesh','2023-10-11',4,'Bengaluru','Single','Female','8877991122','SreeJaya','O Positive',1),(21,'Prabhu','Sundaram','1980-01-01','prabhu@gmail.com','9080706050','Chennai','2008-06-27',3,'Bengaluru','Married','Male','7080905867','Sundar','AB Positive',1),(22,'Employee1','Emp','2024-06-26','employee1@gmail.com','2233445566','Unknown','2024-06-26',5,'Unknown','Single','Male','9977886633','Employer','A Positive',1),(23,'Manager','MGR','2024-06-01','manager@gmail.com','9192939495','Unknown','2024-06-06',3,'Unknown','Single','Others','9911882277','CEO','O Negative',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holidays`
--

LOCK TABLES `holidays` WRITE;
/*!40000 ALTER TABLE `holidays` DISABLE KEYS */;
INSERT INTO `holidays` VALUES (15,'2024-01-01','New Years Day'),(16,'2024-01-15','Pongal/Sankranthi'),(17,'2024-01-26','Republic Day'),(18,'2024-04-11','Ramzan/Eid'),(19,'2024-05-01','May Day'),(20,'2024-08-15','Independence Day'),(21,'2024-10-02','Gandhi Jayanthi'),(22,'2024-10-31','Diwali'),(23,'2024-11-01','Kannada Rajyotsava'),(24,'2024-12-25','Christmas'),(25,'2024-12-25','Christmas');
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaves`
--

LOCK TABLES `leaves` WRITE;
/*!40000 ALTER TABLE `leaves` DISABLE KEYS */;
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
INSERT INTO `leavesstock` VALUES (16,0,2),(17,0,2),(18,0,2),(19,0,2),(20,0,2),(21,0,2),(22,0,2),(23,0,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'HR'),(2,'Developer'),(3,'Manager'),(4,'Tester'),(5,'Clound Engineer');
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
INSERT INTO `user_credentials` VALUES (16,'Suresh','$2a$10$.CLSxcStEwMw6F2YnBgAJeGLm14rlzimSAObYytXWOESqqO.BogTa'),(17,'Rushal','$2a$10$Xcnp1N0S1HqXwRh12VMSReC6LzSFyUUn7qzDdC9C83q4Z0t5XtQmy'),(18,'Ananth','$2a$10$Z.bxM7p483fpoVMI9KSX3.wfC7uuSubhEKLjG8wvuIj0P7NqH.L3e'),(19,'Sagar','$2a$10$Bn7NH/w1RMZIMN6dsGS3pegxQiaefnzZBoqDh7CR9cxkMAO/vEpQy'),(20,'Jayasree','$2a$10$xoqYno5gMvAXAF52SBqTzeAHPuM3Gc1yRCclmixq8MV6nEOZEccbC'),(21,'Prabhu','$2a$10$lUVxbCZpODiirLKt4.hqhePfL/EuGB3zHS1Kw1n.Mg6J16eGdFake'),(22,'Emp1','$2a$10$h9aD6QPS3IggKJq3OM4N1.HzCiC1KfIPU3Bv5Z78ul8OniMs1iswO'),(23,'Manager','$2a$10$PAkOdhe.5tcSQHMD8kYBSe.44jH3mO3E22BCzqgWhOEk2XyVMwZPi');
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

-- Dump completed on 2024-06-27 14:41:31
