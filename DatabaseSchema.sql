CREATE DATABASE  IF NOT EXISTS `school` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `school`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: school
-- ------------------------------------------------------
-- Server version	8.0.38

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
-- Table structure for table `advisors`
--

DROP TABLE IF EXISTS `advisors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advisors` (
  `advisor_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`advisor_id`),
  KEY `fk_department` (`department_id`),
  CONSTRAINT `fk_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_advisors_insert` AFTER INSERT ON `advisors` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'INSERT', CONCAT('New Data: ', NEW.advisor_id, ', ', NEW.first_name, ',', NEW.last_name, ',', NEW.department_id));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_advisors_update` AFTER UPDATE ON `advisors` FOR EACH ROW BEGIN
    DECLARE changes TEXT;
    SET changes = '';

    IF OLD.advisor_id != NEW.advisor_id THEN
        SET changes = CONCAT(changes, 'column1: ', OLD.advisor_id, ' -> ', NEW.advisor_id, '; ');
    END IF;
    IF OLD.first_name != NEW.first_name THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.first_name, ' -> ', NEW.first_name, '; ');
    END IF;
    IF OLD.last_name != NEW.last_name THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.last_name, ' -> ', NEW.last_name, '; ');
    END IF;
    IF OLD.department_id != NEW.department_id THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.department_id, ' -> ', NEW.department_id, '; ');
    END IF;
    -- Repeat for other columns as needed

    IF changes != '' THEN
        INSERT INTO LOGS (username, action_performed, data_affected)
        VALUES (USER(), 'UPDATE', changes);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_advisors_delete` AFTER DELETE ON `advisors` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'DELETE', CONCAT('Deleted Data: ', OLD.advisor_id, ', ', OLD.first_name, ',', OLD.last_name, ',', OLD.department_id));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `classinfo`
--

DROP TABLE IF EXISTS `classinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classinfo` (
  `instructor_id` int NOT NULL,
  `course_id` int NOT NULL,
  `semester` char(1) NOT NULL,
  PRIMARY KEY (`instructor_id`,`course_id`,`semester`),
  UNIQUE KEY `unique_classinfo` (`instructor_id`,`course_id`,`semester`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `classinfo_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`instructor_id`),
  CONSTRAINT `classinfo_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  CONSTRAINT `chk_semester` CHECK ((`semester` in (_utf8mb4'S',_utf8mb4'F',_utf8mb4'U'))),
  CONSTRAINT `classinfo_chk_1` CHECK ((`semester` in (_utf8mb4'S',_utf8mb4'F',_utf8mb4'U')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_credits_before_insert` BEFORE INSERT ON `classinfo` FOR EACH ROW BEGIN
    DECLARE total_credits INT;

    -- Calculate the total credits for the instructor in the same semester
    SELECT SUM(c.credits)
    INTO total_credits
    FROM classinfo ci
    JOIN courses c ON ci.course_id = c.course_id
    WHERE ci.instructor_id = NEW.instructor_id
      AND ci.semester = NEW.semester;

    -- Add the credits of the new course
    SET total_credits = total_credits + (SELECT credits FROM courses WHERE course_id = NEW.course_id);

    -- Check if the total credits exceed 12
    IF total_credits > 12 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Instructor cannot be associated with more than 12 credits in the same semester';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_semester_in_courses_before_insert` BEFORE INSERT ON `classinfo` FOR EACH ROW BEGIN
    DECLARE semesters VARCHAR(3);

    -- Get the semesters value from the courses table for the given course_id
    SELECT semesters INTO semesters
    FROM courses
    WHERE course_id = NEW.course_id;

    -- Check if the semester in classinfo is in the semesters value from courses
    IF FIND_IN_SET(NEW.semester, semesters) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Semester value in classinfo is not found in the semesters value for the associated course_id in courses';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_insert_classinfo` BEFORE INSERT ON `classinfo` FOR EACH ROW BEGIN
    DECLARE course_dept_id INT;
    DECLARE staff_dept_id INT;

    -- Get the department_id of the course
    SELECT department_id INTO course_dept_id
    FROM courses
    WHERE course_id = NEW.course_id;

    -- Get the department_id of the staff based on the current user
    SELECT department_id INTO staff_dept_id
    FROM staffs
    WHERE staff_id = CURRENT_USER();

    -- Check if the department_id matches
    IF course_dept_id != staff_dept_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff can only add classinfo records for courses in their own department';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_classinfo__insert` AFTER INSERT ON `classinfo` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'INSERT', CONCAT('New Data: ', NEW.instructor_id, ', ', NEW.course_id, ', ', NEW.semester));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_credits_before_update` BEFORE UPDATE ON `classinfo` FOR EACH ROW BEGIN
    DECLARE total_credits INT;

    -- Calculate the total credits for the instructor in the same semester
    SELECT SUM(c.credits)
    INTO total_credits
    FROM classinfo ci
    JOIN courses c ON ci.course_id = c.course_id
    WHERE ci.instructor_id = NEW.instructor_id
      AND ci.semester = NEW.semester
      AND ci.course_id != OLD.course_id;

    -- Add the credits of the new course
    SET total_credits = total_credits + (SELECT credits FROM courses WHERE course_id = NEW.course_id);

    -- Check if the total credits exceed 12
    IF total_credits > 12 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Instructor cannot be associated with more than 12 credits in the same semester';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_semester_in_courses_before_update` BEFORE UPDATE ON `classinfo` FOR EACH ROW BEGIN
    DECLARE semesters VARCHAR(3);

    -- Get the semesters value from the courses table for the given course_id
    SELECT semesters INTO semesters
    FROM courses
    WHERE course_id = NEW.course_id;

    -- Check if the semester in classinfo is in the semesters value from courses
    IF FIND_IN_SET(NEW.semester, semesters) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Semester value in classinfo is not found in the semesters value for the associated course_id in courses';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_classinfo_update` AFTER UPDATE ON `classinfo` FOR EACH ROW BEGIN
    DECLARE changes TEXT;
    SET changes = '';

    IF OLD.instructor_id != NEW.instructor_id THEN
        SET changes = CONCAT(changes, 'column1: ', OLD.instructor_id, ' -> ', NEW.instructor_id, '; ');
    END IF;
    IF OLD.course_id != NEW.course_id THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.course_id, ' -> ', NEW.course_id, '; ');
    END IF;
IF OLD.semester != NEW.semester THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.semester, ' -> ', NEW.semester, '; ');
    END IF;
    -- Repeat for other columns as needed

    IF changes != '' THEN
        INSERT INTO LOGS (username, action_performed, data_affected)
        VALUES (USER(), 'UPDATE', changes);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_enrollments_before_delete` BEFORE DELETE ON `classinfo` FOR EACH ROW BEGIN
    DECLARE enrollment_count INT;

    -- Check if the combination of course_id and semester exists in the enrollments table
    SELECT COUNT(*) INTO enrollment_count
    FROM enrollments
    WHERE course_id = OLD.course_id
      AND semester = OLD.semester;

    -- If the combination exists in enrollments, raise an error
    IF enrollment_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete from classinfo as the combination of course_id and semester is referenced in the enrollments table';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_delete_classinfo` BEFORE DELETE ON `classinfo` FOR EACH ROW BEGIN
    DECLARE course_dept_id INT;
    DECLARE staff_dept_id INT;

    -- Get the department_id of the course
    SELECT department_id INTO course_dept_id
    FROM courses
    WHERE course_id = OLD.course_id;

    -- Get the department_id of the staff based on the current user
    SELECT department_id INTO staff_dept_id
    FROM staffs
    WHERE staff_id = CURRENT_USER();

    -- Check if the department_id matches
    IF course_dept_id != staff_dept_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff can only delete classinfo records for courses in their own department';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_classinfo_delete` AFTER DELETE ON `classinfo` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'DELETE', CONCAT('Deleted Data: ', OLD.instructor_id, ', ', OLD.course_id, ', ', OLD.semester));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `course_id` int NOT NULL AUTO_INCREMENT,
  `course_prefix` varchar(5) DEFAULT NULL,
  `course_number` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `credits` int DEFAULT NULL,
  `semesters` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE KEY `course_prefix` (`course_prefix`,`course_number`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `chk_credits` CHECK ((`credits` between 1 and 4)),
  CONSTRAINT `courses_chk_1` CHECK ((`credits` between 1 and 4))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_semesters_before_insert` BEFORE INSERT ON `courses` FOR EACH ROW BEGIN
    DECLARE s_count INT DEFAULT 0;
    DECLARE f_count INT DEFAULT 0;
    DECLARE u_count INT DEFAULT 0;

    SET s_count = LENGTH(NEW.semesters) - LENGTH(REPLACE(NEW.semesters, 'S', ''));
    SET f_count = LENGTH(NEW.semesters) - LENGTH(REPLACE(NEW.semesters, 'F', ''));
    SET u_count = LENGTH(NEW.semesters) - LENGTH(REPLACE(NEW.semesters, 'U', ''));

    IF (s_count + f_count + u_count) > 2 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Semesters can only contain up to two of S, F, or U';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_insert` BEFORE INSERT ON `courses` FOR EACH ROW BEGIN
    DECLARE dept_id INT;

    -- Check if the course_id exists in the departments table
    SELECT department_id INTO dept_id
    FROM departments
    WHERE course_id = NEW.course_id;

    -- If course_id exists but department_id does not match, raise an error
    IF dept_id IS NOT NULL AND dept_id != NEW.department_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'course_id is found in departments table but associated with a non-matching department_id';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_insert_course` BEFORE INSERT ON `courses` FOR EACH ROW BEGIN
    DECLARE staff_dept_id INT;

    -- Get the department_id of the staff based on the current user
    SELECT department_id INTO staff_dept_id
    FROM staffs
    WHERE staff_id = CURRENT_USER();

    -- Check if the department_id matches
    IF NEW.department_id != staff_dept_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff can only add courses in their own department';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_courses__insert` AFTER INSERT ON `courses` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'INSERT', CONCAT('New Data: ', NEW.course_id, ', ', NEW.course_prefix, ', ', NEW.course_number, ', ',NEW.department_id, ', ',NEW.credits));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_semesters_before_update` BEFORE UPDATE ON `courses` FOR EACH ROW BEGIN
    DECLARE s_count INT DEFAULT 0;
    DECLARE f_count INT DEFAULT 0;
    DECLARE u_count INT DEFAULT 0;

    SET s_count = LENGTH(NEW.semesters) - LENGTH(REPLACE(NEW.semesters, 'S', ''));
    SET f_count = LENGTH(NEW.semesters) - LENGTH(REPLACE(NEW.semesters, 'F', ''));
    SET u_count = LENGTH(NEW.semesters) - LENGTH(REPLACE(NEW.semesters, 'U', ''));

    IF (s_count + f_count + u_count) > 2 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Semesters can only contain up to two of S, F, or U';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_update` BEFORE UPDATE ON `courses` FOR EACH ROW BEGIN
    DECLARE dept_id INT;

    -- Check if the course_id exists in the departments table
    SELECT department_id INTO dept_id
    FROM departments
    WHERE course_id = NEW.course_id;

    -- If course_id exists but department_id does not match, raise an error
    IF dept_id IS NOT NULL AND dept_id != NEW.department_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'course_id is found in departments table but associated with a non-matching department_id';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_update_course` BEFORE UPDATE ON `courses` FOR EACH ROW BEGIN
    DECLARE staff_dept_id INT;

    -- Get the department_id of the staff based on the current user
    SELECT department_id INTO staff_dept_id
    FROM staffs
    WHERE staff_id = CURRENT_USER();

    -- Check if the department_id matches
    IF NEW.department_id != staff_dept_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff can only update courses in their own department';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_courses_update` AFTER UPDATE ON `courses` FOR EACH ROW BEGIN
    DECLARE changes TEXT;
    SET changes = '';

    IF OLD.course_id != NEW.course_id THEN
        SET changes = CONCAT(changes, 'column1: ', OLD.course_id, ' -> ', NEW.course_id, '; ');
    END IF;
    IF OLD.course_prefix != NEW.course_prefix THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.course_prefix, ' -> ', NEW.course_prefix, '; ');
    END IF;
IF OLD.course_number != NEW.course_number THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.course_number, ' -> ', NEW.course_number, '; ');
    END IF;
    IF OLD.department_id != NEW.department_id THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.department_id, ' -> ', NEW.department_id, '; ');
    END IF;
    IF OLD.credits != NEW.credits THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.credits, ' -> ', NEW.credits, '; ');
    END IF;
    -- Repeat for other columns as needed

    IF changes != '' THEN
        INSERT INTO LOGS (username, action_performed, data_affected)
        VALUES (USER(), 'UPDATE', changes);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_classinfo_before_delete` BEFORE DELETE ON `courses` FOR EACH ROW BEGIN
    DECLARE course_count INT;

    -- Check if the course_id exists in the classinfo table
    SELECT COUNT(*) INTO course_count
    FROM classinfo
    WHERE course_id = OLD.course_id;

    -- If course_id exists in classinfo, raise an error
    IF course_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete course_id as it is referenced in the classinfo table';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_delete_course` BEFORE DELETE ON `courses` FOR EACH ROW BEGIN
    DECLARE staff_dept_id INT;

    -- Get the department_id of the staff based on the current user
    SELECT department_id INTO staff_dept_id
    FROM staffs
    WHERE staff_id = CURRENT_USER();

    -- Check if the department_id matches
    IF OLD.department_id != staff_dept_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff can only delete courses in their own department';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_courses_delete` AFTER DELETE ON `courses` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'DELETE', CONCAT('Deleted Data: ', OLD.course_id, ', ', OLD.course_prefix, ', ', OLD.course_number, ', ',OLD.department_id, ', ',OLD.credits));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `courses` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `department_name` (`department_name`),
  UNIQUE KEY `unique_location` (`location`),
  UNIQUE KEY `unique_courses` (`courses`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_departments__insert` AFTER INSERT ON `departments` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'INSERT', CONCAT('New Data: ', NEW.department_id, ', ', NEW.department_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_departments_update` AFTER UPDATE ON `departments` FOR EACH ROW BEGIN
    DECLARE changes TEXT;
    SET changes = '';

    IF OLD.department_id != NEW.department_id THEN
        SET changes = CONCAT(changes, 'column1: ', OLD.department_id, ' -> ', NEW.department_id, '; ');
    END IF;
    IF OLD.department_name != NEW.department_name THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.department_name, ' -> ', NEW.department_name, '; ');
    END IF;

    -- Repeat for other columns as needed

    IF changes != '' THEN
        INSERT INTO LOGS (username, action_performed, data_affected)
        VALUES (USER(), 'UPDATE', changes);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_departments_delete` AFTER DELETE ON `departments` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'DELETE', CONCAT('Deleted Data: ', OLD.department_id, ', ', OLD.department_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `enrollments`
--

DROP TABLE IF EXISTS `enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollments` (
  `student_id` varchar(10) NOT NULL,
  `course_id` int NOT NULL,
  `semester` char(1) NOT NULL,
  `grade` char(1) DEFAULT NULL,
  `year_taken` int NOT NULL,
  PRIMARY KEY (`student_id`,`course_id`,`semester`,`year_taken`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  CONSTRAINT `chk_grade` CHECK ((`grade` in (_utf8mb4'A',_utf8mb4'B',_utf8mb4'C',_utf8mb4'D',_utf8mb4'F',_utf8mb4''))),
  CONSTRAINT `enrollments_chk_1` CHECK ((`semester` in (_utf8mb4'S',_utf8mb4'F',_utf8mb4'U'))),
  CONSTRAINT `enrollments_chk_2` CHECK ((`grade` in (_utf8mb4'A',_utf8mb4'B',_utf8mb4'C',_utf8mb4'D',_utf8mb4'F',_utf8mb4'I',_utf8mb4'S',_utf8mb4'U')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_insert_enrollment` BEFORE INSERT ON `enrollments` FOR EACH ROW BEGIN
    DECLARE student_dept_id INT;
    DECLARE advisor_dept_id INT;

    -- Get the department_id of the student
    SELECT department_id INTO student_dept_id
    FROM students
    WHERE student_id = NEW.student_id;

    -- Get the department_id of the advisor based on the current user
    SELECT department_id INTO advisor_dept_id
    FROM advisors
    WHERE id = CURRENT_USER();

    -- Check if the department_id matches
    IF student_dept_id != advisor_dept_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Advisor and student must belong to the same department';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_gpa_after_insert` AFTER INSERT ON `enrollments` FOR EACH ROW BEGIN
    -- Update the GPA in the students table by calculating the average of all enrollments for the given student
    UPDATE students
    SET GPA = (
        SELECT AVG(
            CASE 
                WHEN grade = 'A' THEN 4
                WHEN grade = 'B' THEN 3
                WHEN grade = 'C' THEN 2
                WHEN grade = 'D' THEN 1
                WHEN grade = 'F' THEN 0
            END
        ) 
        FROM enrollments
        WHERE student_id = NEW.student_id
    )
    WHERE student_id = NEW.student_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_total_credits_after_insert` AFTER INSERT ON `enrollments` FOR EACH ROW BEGIN
    -- Update total_credits calculation in the students table
    UPDATE students
    SET total_credits = (
        SELECT IFNULL(SUM(c.credits), 0)
        FROM enrollments e
        JOIN courses c ON e.course_id = c.course_id
        WHERE e.student_id = NEW.student_id
    )
    WHERE student_id = NEW.student_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_enrollments__insert` AFTER INSERT ON `enrollments` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'INSERT', CONCAT('New Data: ', NEW.student_id, ', ', NEW.course_id, ', ',NEW.semester, ', ',NEW.grade, ', ',NEW.year_taken));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_total_credits` BEFORE UPDATE ON `enrollments` FOR EACH ROW BEGIN
    -- Subtract credits if the old grade was a valid, completed grade
    IF OLD.grade IN ('A', 'B', 'C', 'D', 'S') THEN
        UPDATE Students
        SET total_credits = total_credits - (SELECT credits FROM Courses WHERE course_id = OLD.course_id)
        WHERE student_id = OLD.student_id;
    END IF;

    -- Add credits if the new grade is a valid, completed grade
    IF NEW.grade IN ('A', 'B', 'C', 'D', 'S') THEN
        UPDATE Students
        SET total_credits = total_credits + (SELECT credits FROM Courses WHERE course_id = NEW.course_id)
        WHERE student_id = NEW.student_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_gpa` AFTER UPDATE ON `enrollments` FOR EACH ROW BEGIN
    -- Update the GPA in the students table by calculating the average of all enrollments for the given student
    UPDATE students
    SET GPA = (
        SELECT AVG(
            CASE 
                WHEN grade = 'A' THEN 4
                WHEN grade = 'B' THEN 3
                WHEN grade = 'C' THEN 2
                WHEN grade = 'D' THEN 1
                WHEN grade = 'F' THEN 0
            END
        ) 
        FROM enrollments
        WHERE student_id = NEW.student_id
    )
    WHERE student_id = NEW.student_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_total_credits_after_update` AFTER UPDATE ON `enrollments` FOR EACH ROW BEGIN
    -- Update total_credits calculation in the students table
    UPDATE students
    SET total_credits = (
        SELECT IFNULL(SUM(c.credits), 0)
        FROM enrollments e
        JOIN courses c ON e.course_id = c.course_id
        WHERE e.student_id = NEW.student_id
    )
    WHERE student_id = NEW.student_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_enrollments_update` AFTER UPDATE ON `enrollments` FOR EACH ROW BEGIN
    DECLARE changes TEXT;
    SET changes = '';

    IF OLD.student_id != NEW.student_id THEN
        SET changes = CONCAT(changes, 'column1: ', OLD.student_id, ' -> ', NEW.student_id, '; ');
    END IF;
    IF OLD.course_id != NEW.course_id THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.course_id, ' -> ', NEW.course_id, '; ');
    END IF;
    IF OLD.semester != NEW.semester THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.semester, ' -> ', NEW.semester, '; ');
    END IF;
    IF OLD.grade != NEW.grade THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.grade, ' -> ', NEW.grade, '; ');
    END IF;
    IF OLD.year_taken != NEW.year_taken THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.year_taken, ' -> ', year_taken, '; ');
    END IF;

    -- Repeat for other columns as needed

    IF changes != '' THEN
        INSERT INTO LOGS (username, action_performed, data_affected)
        VALUES (USER(), 'UPDATE', changes);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_delete_enrollment` BEFORE DELETE ON `enrollments` FOR EACH ROW BEGIN
    DECLARE student_dept_id INT;
    DECLARE advisor_dept_id INT;

    -- Get the department_id of the student
    SELECT department_id INTO student_dept_id
    FROM students
    WHERE student_id = OLD.student_id;

    -- Get the department_id of the advisor based on the current user
    SELECT department_id INTO advisor_dept_id
    FROM advisors
    WHERE id = CURRENT_USER();

    -- Check if the department_id matches
    IF student_dept_id != advisor_dept_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Advisor and student must belong to the same department';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_gpa_after_delete` AFTER DELETE ON `enrollments` FOR EACH ROW BEGIN
    -- Update the GPA in the students table by calculating the average of all enrollments for the given student
    UPDATE students
    SET GPA = (
        SELECT IFNULL(AVG(
            CASE 
                WHEN grade = 'A' THEN 4
                WHEN grade = 'B' THEN 3
                WHEN grade = 'C' THEN 2
                WHEN grade = 'D' THEN 1
                WHEN grade = 'F' THEN 0
            END
        ), 0)  -- If no enrollments remain, set GPA to 0
        FROM enrollments
        WHERE student_id = OLD.student_id
    )
    WHERE student_id = OLD.student_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_total_credits_after_delete` AFTER DELETE ON `enrollments` FOR EACH ROW BEGIN
    -- Update total_credits calculation in the students table
    UPDATE students
    SET total_credits = (
        SELECT IFNULL(SUM(c.credits), 0)
        FROM enrollments e
        JOIN courses c ON e.course_id = c.course_id
        WHERE e.student_id = OLD.student_id
    )
    WHERE student_id = OLD.student_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_enrollments_delete` AFTER DELETE ON `enrollments` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'DELETE', CONCAT('Deleted Data: ', OLD.student_id, ', ', OLD.course_id, ', ',OLD.semester, ', ',OLD.grade, ', ',OLD.year_taken));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `instructor_classinfo`
--

DROP TABLE IF EXISTS `instructor_classinfo`;
/*!50001 DROP VIEW IF EXISTS `instructor_classinfo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `instructor_classinfo` AS SELECT 
 1 AS `instructor_id`,
 1 AS `course_id`,
 1 AS `semester`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `instructor_info`
--

DROP TABLE IF EXISTS `instructor_info`;
/*!50001 DROP VIEW IF EXISTS `instructor_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `instructor_info` AS SELECT 
 1 AS `instructor_id`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `department_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `instructors`
--

DROP TABLE IF EXISTS `instructors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructors` (
  `instructor_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`instructor_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `instructors_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `instructors_chk_1` CHECK ((`department_id` is not null))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_insert_instructor` BEFORE INSERT ON `instructors` FOR EACH ROW BEGIN
    DECLARE staff_dept_id INT;

    -- Get the department_id of the staff based on the current user
    SELECT department_id INTO staff_dept_id
    FROM staffs
    WHERE staff_id = CURRENT_USER();

    -- Check if the department_id matches
    IF NEW.department_id != staff_dept_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff can only add instructors in their own department';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_instructors__insert` AFTER INSERT ON `instructors` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'INSERT', CONCAT('New Data: ', NEW.instructor_id, ', ', NEW.first_name, ', ',NEW.last_name, ', ',NEW.department_id));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_update_instructor` BEFORE UPDATE ON `instructors` FOR EACH ROW BEGIN
    DECLARE staff_dept_id INT;

    -- Get the department_id of the staff based on the current user
    SELECT department_id INTO staff_dept_id
    FROM staffs
    WHERE staff_id = CURRENT_USER();

    -- Check if the department_id matches
    IF NEW.department_id != staff_dept_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff can only update instructors in their own department';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_instructors_update` AFTER UPDATE ON `instructors` FOR EACH ROW BEGIN
    DECLARE changes TEXT;
    SET changes = '';

    IF OLD.instructor_id != NEW.instructor_id THEN
        SET changes = CONCAT(changes, 'column1: ', OLD.instructor_id, ' -> ', NEW.instructor_id, '; ');
    END IF;
    IF OLD.first_name != NEW.first_name THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.first_name, ' -> ', NEW.first_name, '; ');
    END IF;
    IF OLD.last_name != NEW.last_name THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.last_name, ' -> ', NEW.last_name, '; ');
    END IF;
    IF OLD.department_id != NEW.department_id THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.department_id, ' -> ', NEW.department_id, '; ');
    END IF;


    -- Repeat for other columns as needed

    IF changes != '' THEN
        INSERT INTO LOGS (username, action_performed, data_affected)
        VALUES (USER(), 'UPDATE', changes);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_delete_instructor` BEFORE DELETE ON `instructors` FOR EACH ROW BEGIN
    DECLARE staff_dept_id INT;

    -- Get the department_id of the staff based on the current user
    SELECT department_id INTO staff_dept_id
    FROM staffs
    WHERE staff_id = CURRENT_USER();

    -- Check if the department_id matches
    IF OLD.department_id != staff_dept_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff can only delete instructors in their own department';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_instructors_delete` AFTER DELETE ON `instructors` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'DELETE', CONCAT('Deleted Data: ', OLD.instructor_id, ', ', OLD.first_name, ', ',OLD.last_name, ', ',OLD.department_id));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `username` varchar(50) DEFAULT NULL,
  `action_performed` varchar(100) DEFAULT NULL,
  `data_affected` text,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staffs`
--

DROP TABLE IF EXISTS `staffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staffs` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `staffs_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_staffs__insert` AFTER INSERT ON `staffs` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'INSERT', CONCAT('New Data: ', NEW.staff_id, ', ', NEW.first_name, ', ',NEW.last_name, ', ',NEW.department_id));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_staffs_update` AFTER UPDATE ON `staffs` FOR EACH ROW BEGIN
    DECLARE changes TEXT;
    SET changes = '';

    IF OLD.staff_id != NEW.staff_id THEN
        SET changes = CONCAT(changes, 'column1: ', OLD.staff_id, ' -> ', NEW.staff_id, '; ');
    END IF;
    IF OLD.first_name != NEW.first_name THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.first_name, ' -> ', NEW.first_name, '; ');
    END IF;
    IF OLD.last_name != NEW.last_name THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.last_name, ' -> ', NEW.last_name, '; ');
    END IF;
    IF OLD.department_id != NEW.department_id THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.department_id, ' -> ', NEW.department_id, '; ');
    END IF;


    -- Repeat for other columns as needed

    IF changes != '' THEN
        INSERT INTO LOGS (username, action_performed, data_affected)
        VALUES (USER(), 'UPDATE', changes);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_staffs_delete` AFTER DELETE ON `staffs` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'DELETE', CONCAT('Deleted Data: ', OLD.staff_id, ', ', OLD.first_name, ', ',OLD.last_name, ', ',OLD.department_id));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `student_enrollments`
--

DROP TABLE IF EXISTS `student_enrollments`;
/*!50001 DROP VIEW IF EXISTS `student_enrollments`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `student_enrollments` AS SELECT 
 1 AS `student_id`,
 1 AS `course_id`,
 1 AS `semester`,
 1 AS `grade`,
 1 AS `year_taken`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `student_info`
--

DROP TABLE IF EXISTS `student_info`;
/*!50001 DROP VIEW IF EXISTS `student_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `student_info` AS SELECT 
 1 AS `student_id`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `department_id`,
 1 AS `gpa`,
 1 AS `total_credits`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `student_id` varchar(10) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `gpa` decimal(3,2) DEFAULT NULL,
  `total_credits` int DEFAULT '0',
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `student_id` (`student_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `check_student_id` CHECK ((`student_id` like _utf8mb4'U%')),
  CONSTRAINT `students_chk_1` CHECK (((`gpa` >= 0) and (`gpa` <= 4)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_student_id_before_insert` BEFORE INSERT ON `students` FOR EACH ROW BEGIN
    IF LEFT(NEW.student_id, 1) != 'U' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'student_id must start with a U';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_insert_student` BEFORE INSERT ON `students` FOR EACH ROW BEGIN
    DECLARE staff_dept_id INT;

    -- Get the department_id of the staff based on the current user
    SELECT department_id INTO staff_dept_id
    FROM staffs
    WHERE staff_id = CURRENT_USER();

    -- Check if the department_id matches
    IF NEW.department_id != staff_dept_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff can only add students in their own department';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_students__insert` AFTER INSERT ON `students` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'INSERT', CONCAT('New Data: ', NEW.student_id, ', ', NEW.first_name, ', ',NEW.last_name, ', ',NEW.department_id, ', ',NEW.gpa, ', ',NEW.total_credits));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_student_id_before_update` BEFORE UPDATE ON `students` FOR EACH ROW BEGIN
    IF LEFT(NEW.student_id, 1) != 'U' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'student_id must start with a U';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_update_student` BEFORE UPDATE ON `students` FOR EACH ROW BEGIN
    DECLARE staff_dept_id INT;

    -- Get the department_id of the staff based on the current user
    SELECT department_id INTO staff_dept_id
    FROM staffs
    WHERE staff_id = CURRENT_USER();

    -- Check if the department_id matches
    IF NEW.department_id != staff_dept_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff can only update students in their own department';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_students_update` AFTER UPDATE ON `students` FOR EACH ROW BEGIN
    DECLARE changes TEXT;
    SET changes = '';

    IF OLD.student_id != NEW.student_id THEN
        SET changes = CONCAT(changes, 'column1: ', OLD.student_id, ' -> ', NEW.student_id, '; ');
    END IF;
    IF OLD.first_name != NEW.first_name THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.first_name, ' -> ', NEW.first_name, '; ');
    END IF;
    IF OLD.last_name != NEW.last_name THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.last_name, ' -> ', NEW.last_name, '; ');
    END IF;
    IF OLD.department_id != NEW.department_id THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.department_id, ' -> ', NEW.department_id, '; ');
    END IF;
    IF OLD.gpa != NEW.gpa THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.gpa, ' -> ', NEW.gpa, '; ');
    END IF;
    IF OLD.total_credits != NEW.total_credits THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.total_credits, ' -> ', NEW.total_credits, '; ');
    END IF;


    -- Repeat for other columns as needed

    IF changes != '' THEN
        INSERT INTO LOGS (username, action_performed, data_affected)
        VALUES (USER(), 'UPDATE', changes);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_gpa_before_delete` BEFORE DELETE ON `students` FOR EACH ROW BEGIN
    -- Check if the GPA value exists (is not null)
    IF OLD.GPA IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete student as their GPA value exists';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_department_before_delete_student` BEFORE DELETE ON `students` FOR EACH ROW BEGIN
    DECLARE staff_dept_id INT;

    -- Get the department_id of the staff based on the current user
    SELECT department_id INTO staff_dept_id
    FROM staffs
    WHERE staff_id = CURRENT_USER();

    -- Check if the department_id matches
    IF OLD.department_id != staff_dept_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff can only delete students in their own department';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_students_delete` AFTER DELETE ON `students` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'DELETE', CONCAT('Deleted Data: ', OLD.student_id, ', ', OLD.first_name, ', ',OLD.last_name, ', ',OLD.department_id, ', ',OLD.gpa, ', ',OLD.total_credits));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` varchar(10) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Student','Instructor','Advisor','Staff') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `users_chk_1` CHECK ((`id` like _utf8mb4'U%'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_users_insert` AFTER INSERT ON `users` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'INSERT', CONCAT('New Data: ', NEW.id, ', ', NEW.username, ', ',NEW.password, ', ',NEW.role));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_users_update` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
    DECLARE changes TEXT;
    SET changes = '';

    IF OLD.id != NEW.id THEN
        SET changes = CONCAT(changes, 'column1: ', OLD.id, ' -> ', NEW.id, '; ');
    END IF;
    IF OLD.username != NEW.username THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.username, ' -> ', NEW.username, '; ');
    END IF;
    IF OLD.password != NEW.password THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.password, ' -> ', NEW.password, '; ');
    END IF;
    IF OLD.role != NEW.role THEN
        SET changes = CONCAT(changes, 'column2: ', OLD.role, ' -> ', NEW.role, '; ');
    END IF;



    -- Repeat for other columns as needed

    IF changes != '' THEN
        INSERT INTO LOGS (username, action_performed, data_affected)
        VALUES (USER(), 'UPDATE', changes);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_users_delete` AFTER DELETE ON `users` FOR EACH ROW BEGIN
    INSERT INTO LOGS (username, action_performed, data_affected)
    VALUES (USER(), 'DELETE', CONCAT('Deleted Data: ', OLD.id, ', ', OLD.username, ', ',OLD.password, ', ',OLD.role));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'school'
--
/*!50003 DROP PROCEDURE IF EXISTS `DropCourse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DropCourse`(
    IN course_id INT
)
BEGIN
    DECLARE staff_id INT;
    DECLARE staff_department_id INT;
    DECLARE course_department_id INT;

    -- Get the staff_id based on the current user
    SELECT staff_id INTO staff_id
    FROM staff
    WHERE username = CURRENT_USER();  -- Assuming you have a username field

    -- Get the department_id of the staff member
    SELECT department_id INTO staff_department_id
    FROM staff
    WHERE staff_id = staff_id;

    -- Get the department_id of the course
    SELECT department_id INTO course_department_id
    FROM courses
    WHERE course_id = course_id;

    -- Check if the staff member and course belong to the same department
    IF staff_department_id = course_department_id THEN
        DELETE FROM courses WHERE course_id = course_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff and course must be in the same department.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DropInstructor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DropInstructor`(
    IN instructor_id INT
)
BEGIN
    DECLARE staff_id INT;
    DECLARE staff_department_id INT;
    DECLARE instructor_department_id INT;

    -- Get the staff_id based on the current user
    SELECT staff_id INTO staff_id
    FROM staff
    WHERE username = CURRENT_USER();  -- Assuming you have a username field

    -- Get the department_id of the staff member
    SELECT department_id INTO staff_department_id
    FROM staff
    WHERE staff_id = staff_id;

    -- Get the department_id of the instructor
    SELECT department_id INTO instructor_department_id
    FROM instructors
    WHERE instructor_id = instructor_id;

    -- Check if the staff member and instructor belong to the same department
    IF staff_department_id = instructor_department_id THEN
        DELETE FROM instructors WHERE instructor_id = instructor_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff and instructor must be in the same department.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DropStudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DropStudent`(
    IN staff_id INT,
    IN student_id INT
)
BEGIN
    DECLARE staff_department_id INT;
    DECLARE student_department_id INT;

    -- Get the department_id of the staff member
    SELECT department_id INTO staff_department_id
    FROM staff  -- Assuming you have a staff table
    WHERE staff_id = staff_id;

    -- Get the department_id of the student
    SELECT department_id INTO student_department_id
    FROM students
    WHERE student_id = student_id;

    -- Check if the staff and student belong to the same department
    IF staff_department_id = student_department_id THEN
        DELETE FROM students WHERE student_id = student_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff and student must be in the same department.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ManageCourse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ManageCourse`(
    IN course_id INT,
    IN course_name VARCHAR(255),
    IN department_id INT,
    IN action VARCHAR(10)  -- 'add' or 'update'
)
BEGIN
    DECLARE staff_id INT;
    DECLARE staff_department_id INT;

    -- Get the staff_id based on the current user
    SELECT staff_id INTO staff_id
    FROM staff
    WHERE username = CURRENT_USER();  -- Assuming you have a username field

    -- Get the department_id of the staff member
    SELECT department_id INTO staff_department_id
    FROM staff
    WHERE staff_id = staff_id;

    -- Check if the staff member belongs to the same department as the course
    IF staff_department_id = department_id THEN
        IF action = 'add' THEN
            INSERT INTO courses (course_id, course_name, department_id) VALUES (course_id, course_name, department_id);
        ELSEIF action = 'update' THEN
            UPDATE courses SET course_name = course_name, department_id = department_id WHERE course_id = course_id;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid action. Use "add" or "update".';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff and course must be in the same department.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ManageEnrollment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ManageEnrollment`(
    IN advisor_id INT,
    IN student_id INT,
    IN course_id INT,
    IN action VARCHAR(10)  -- 'enroll' or 'drop'
)
BEGIN
    DECLARE advisor_department_id INT;
    DECLARE student_department_id INT;

    -- Get the department_id of the advisor
    SELECT department_id INTO advisor_department_id
    FROM advisors  -- Assuming you have an advisors table
    WHERE advisor_id = advisor_id;

    -- Get the department_id of the student
    SELECT department_id INTO student_department_id
    FROM students
    WHERE student_id = student_id;

    -- Check if the advisor and student belong to the same department
    IF advisor_department_id = student_department_id THEN
        IF action = 'enroll' THEN
            -- Insert enrollment record
            INSERT INTO enrollments (student_id, course_id)
            VALUES (student_id, course_id);
        ELSEIF action = 'drop' THEN
            -- Delete enrollment record
            DELETE FROM enrollments
            WHERE student_id = student_id AND course_id = course_id;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid action. Use "enroll" or "drop".';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Advisor and student must be in the same department.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ManageInstructor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ManageInstructor`(
    IN instructor_id INT,
    IN instructor_name VARCHAR(255),
    IN department_id INT,
    IN action VARCHAR(10)  -- 'add' or 'update'
)
BEGIN
    DECLARE staff_id INT;
    DECLARE staff_department_id INT;

    -- Get the staff_id based on the current user
    SELECT staff_id INTO staff_id
    FROM staff
    WHERE username = CURRENT_USER();  -- Assuming you have a username field

    -- Get the department_id of the staff member
    SELECT department_id INTO staff_department_id
    FROM staff
    WHERE staff_id = staff_id;

    -- Check if the staff member belongs to the same department as the instructor
    IF staff_department_id = department_id THEN
        IF action = 'add' THEN
            INSERT INTO instructors (instructor_id, instructor_name, department_id) VALUES (instructor_id, instructor_name, department_id);
        ELSEIF action = 'update' THEN
            UPDATE instructors SET instructor_name = instructor_name, department_id = department_id WHERE instructor_id = instructor_id;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid action. Use "add" or "update".';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff and instructor must be in the same department.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ManageStudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ManageStudent`(
    IN staff_id INT,
    IN student_id INT,
    IN name VARCHAR(255),
    IN department_id INT,
    IN action VARCHAR(10)  -- 'add' or 'update'
)
BEGIN
    DECLARE staff_department_id INT;

    -- Get the department_id of the staff member
    SELECT department_id INTO staff_department_id
    FROM staff  -- Assuming you have a staff table
    WHERE staff_id = staff_id;

    -- Check if the staff and student belong to the same department
    IF staff_department_id = department_id THEN
        IF action = 'add' THEN
            INSERT INTO students (student_id, name, department_id) VALUES (student_id, name, department_id);
        ELSEIF action = 'update' THEN
            UPDATE students SET name = name, department_id = department_id WHERE student_id = student_id;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid action. Use "add" or "update".';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Staff and student must be in the same department.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `instructor_classinfo`
--

/*!50001 DROP VIEW IF EXISTS `instructor_classinfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `instructor_classinfo` AS select `classinfo`.`instructor_id` AS `instructor_id`,`classinfo`.`course_id` AS `course_id`,`classinfo`.`semester` AS `semester` from `classinfo` where (`classinfo`.`instructor_id` = current_user()) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `instructor_info`
--

/*!50001 DROP VIEW IF EXISTS `instructor_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `instructor_info` AS select `instructors`.`instructor_id` AS `instructor_id`,`instructors`.`first_name` AS `first_name`,`instructors`.`last_name` AS `last_name`,`instructors`.`department_id` AS `department_id` from `instructors` where (`instructors`.`instructor_id` = current_user()) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `student_enrollments`
--

/*!50001 DROP VIEW IF EXISTS `student_enrollments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `student_enrollments` AS select `enrollments`.`student_id` AS `student_id`,`enrollments`.`course_id` AS `course_id`,`enrollments`.`semester` AS `semester`,`enrollments`.`grade` AS `grade`,`enrollments`.`year_taken` AS `year_taken` from `enrollments` where (`enrollments`.`student_id` = current_user()) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `student_info`
--

/*!50001 DROP VIEW IF EXISTS `student_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `student_info` AS select `students`.`student_id` AS `student_id`,`students`.`first_name` AS `first_name`,`students`.`last_name` AS `last_name`,`students`.`department_id` AS `department_id`,`students`.`gpa` AS `gpa`,`students`.`total_credits` AS `total_credits` from `students` where (`students`.`student_id` = current_user()) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-22 11:18:12
