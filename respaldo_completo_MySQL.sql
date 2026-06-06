-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: bolsa_trabajo
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Current Database: `bolsa_trabajo`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `bolsa_trabajo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `bolsa_trabajo`;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add categoria',1,'add_categoria'),(2,'Can change categoria',1,'change_categoria'),(3,'Can delete categoria',1,'delete_categoria'),(4,'Can view categoria',1,'view_categoria'),(5,'Can add empresa',2,'add_empresa'),(6,'Can change empresa',2,'change_empresa'),(7,'Can delete empresa',2,'delete_empresa'),(8,'Can view empresa',2,'view_empresa'),(9,'Can add candidato',3,'add_candidato'),(10,'Can change candidato',3,'change_candidato'),(11,'Can delete candidato',3,'delete_candidato'),(12,'Can view candidato',3,'view_candidato'),(13,'Can add perfil',4,'add_perfil'),(14,'Can change perfil',4,'change_perfil'),(15,'Can delete perfil',4,'delete_perfil'),(16,'Can view perfil',4,'view_perfil'),(17,'Can add vacante',5,'add_vacante'),(18,'Can change vacante',5,'change_vacante'),(19,'Can delete vacante',5,'delete_vacante'),(20,'Can view vacante',5,'view_vacante'),(21,'Can add postulacion',6,'add_postulacion'),(22,'Can change postulacion',6,'change_postulacion'),(23,'Can delete postulacion',6,'delete_postulacion'),(24,'Can view postulacion',6,'view_postulacion'),(25,'Can add log entry',7,'add_logentry'),(26,'Can change log entry',7,'change_logentry'),(27,'Can delete log entry',7,'delete_logentry'),(28,'Can view log entry',7,'view_logentry'),(29,'Can add permission',8,'add_permission'),(30,'Can change permission',8,'change_permission'),(31,'Can delete permission',8,'delete_permission'),(32,'Can view permission',8,'view_permission'),(33,'Can add group',9,'add_group'),(34,'Can change group',9,'change_group'),(35,'Can delete group',9,'delete_group'),(36,'Can view group',9,'view_group'),(37,'Can add user',10,'add_user'),(38,'Can change user',10,'change_user'),(39,'Can delete user',10,'delete_user'),(40,'Can view user',10,'view_user'),(41,'Can add content type',11,'add_contenttype'),(42,'Can change content type',11,'change_contenttype'),(43,'Can delete content type',11,'delete_contenttype'),(44,'Can view content type',11,'view_contenttype'),(45,'Can add session',12,'add_session'),(46,'Can change session',12,'change_session'),(47,'Can delete session',12,'delete_session'),(48,'Can view session',12,'view_session'),(49,'Can add notificacion',13,'add_notificacion'),(50,'Can change notificacion',13,'change_notificacion'),(51,'Can delete notificacion',13,'delete_notificacion'),(52,'Can view notificacion',13,'view_notificacion');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `creado_por` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$720000$XaP8tLQIS5sxWrmgqORKWE$R0SvcebBsss1qBobGvcpp2wmykWdZgAoAEOtiu4eXUE=','2026-06-04 18:42:24.611370',1,'admin','','','admin@example.com',1,1,'2026-06-02 21:10:06.174440','system','2026-06-02 15:11:31','django_user@localhost','2026-06-04 12:42:24'),(2,'pbkdf2_sha256$720000$LC6vp4TVm1c3xOuSimGVUv$jpB94lAUew+nhRRgoXgt9Jx1C55trrnb5hBXUsu/NV8=','2026-06-02 21:55:39.361425',0,'Juanito','Juan Alberto Perez Ortiz','','Juanperez@gmail.com',0,1,'2026-06-02 21:27:11.244596','django_user@localhost','2026-06-02 15:27:11','django_user@localhost','2026-06-02 15:55:39'),(3,'pbkdf2_sha256$720000$wQrBRL3kLCDguRO8DCrOqG$gUpHSdYy72aQ96/HcPjAloDzN+JYtmT4x65jyR0HLIQ=','2026-06-04 17:47:51.965308',0,'TECNASA','TECNASA','','tecnasa.rrhh@gmail.com',0,1,'2026-06-03 02:15:56.556383','django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-04 11:47:51'),(4,'pbkdf2_sha256$720000$Pwqeyt3sQhkbIfbh4pOopb$wMEUqKfLHV8xyXpI8yTOettWLPc/48ENC19vLj2ITZ8=','2026-06-04 17:43:35.513537',0,'Kevin','Kevin Durazno','','kevin@gmail.com',0,1,'2026-06-03 19:25:56.412898','django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-04 11:43:35');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_audit_auth_user_insert` BEFORE INSERT ON `auth_user` FOR EACH ROW BEGIN
  SET NEW.creado_por = USER();
  SET NEW.fecha_creacion = NOW();
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_auth_user_insert` AFTER INSERT ON `auth_user` FOR EACH ROW BEGIN
  INSERT INTO hist_auth_user (accion, fecha_accion, usuario_accion, user_id, username, email, is_active, is_superuser, creado_por, fecha_creacion)
  VALUES ('INSERT', NOW(), USER(), NEW.id, NEW.username, NEW.email, NEW.is_active, NEW.is_superuser, NEW.creado_por, NEW.fecha_creacion);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_audit_auth_user_update` BEFORE UPDATE ON `auth_user` FOR EACH ROW BEGIN
  SET NEW.modificado_por = USER();
  SET NEW.fecha_modificacion = NOW();
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_auth_user_update` AFTER UPDATE ON `auth_user` FOR EACH ROW BEGIN
  INSERT INTO hist_auth_user (accion, fecha_accion, usuario_accion, user_id, username, email, is_active, is_superuser, creado_por, fecha_creacion, modificado_por, fecha_modificacion)
  VALUES ('UPDATE', NOW(), USER(), OLD.id, OLD.username, OLD.email, OLD.is_active, OLD.is_superuser, OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_auth_user_delete` BEFORE DELETE ON `auth_user` FOR EACH ROW BEGIN
  INSERT INTO hist_auth_user (accion, fecha_accion, usuario_accion, user_id, username, email, is_active, is_superuser, creado_por, fecha_creacion, modificado_por, fecha_modificacion)
  VALUES ('DELETE', NOW(), USER(), OLD.id, OLD.username, OLD.email, OLD.is_active, OLD.is_superuser, OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidato`
--

DROP TABLE IF EXISTS `candidato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidato` (
  `candidato_id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int DEFAULT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `dui` varchar(20) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `area_interes` varchar(100) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`candidato_id`),
  UNIQUE KEY `usuario_id` (`usuario_id`),
  UNIQUE KEY `dui` (`dui`),
  CONSTRAINT `candidato_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidato`
--

LOCK TABLES `candidato` WRITE;
/*!40000 ALTER TABLE `candidato` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidato_certificacion`
--

DROP TABLE IF EXISTS `candidato_certificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidato_certificacion` (
  `candidato_id` int NOT NULL,
  `certificacion_id` int NOT NULL,
  `institucion` varchar(100) DEFAULT NULL,
  `fecha_obtencion` date DEFAULT NULL,
  PRIMARY KEY (`candidato_id`,`certificacion_id`),
  KEY `certificacion_id` (`certificacion_id`),
  CONSTRAINT `candidato_certificacion_ibfk_1` FOREIGN KEY (`candidato_id`) REFERENCES `candidato` (`candidato_id`),
  CONSTRAINT `candidato_certificacion_ibfk_2` FOREIGN KEY (`certificacion_id`) REFERENCES `certificacion` (`certificacion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidato_certificacion`
--

LOCK TABLES `candidato_certificacion` WRITE;
/*!40000 ALTER TABLE `candidato_certificacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidato_certificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidato_habilidad`
--

DROP TABLE IF EXISTS `candidato_habilidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidato_habilidad` (
  `candidato_id` int NOT NULL,
  `habilidad_id` int NOT NULL,
  PRIMARY KEY (`candidato_id`,`habilidad_id`),
  KEY `habilidad_id` (`habilidad_id`),
  CONSTRAINT `candidato_habilidad_ibfk_1` FOREIGN KEY (`candidato_id`) REFERENCES `candidato` (`candidato_id`),
  CONSTRAINT `candidato_habilidad_ibfk_2` FOREIGN KEY (`habilidad_id`) REFERENCES `habilidad` (`habilidad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidato_habilidad`
--

LOCK TABLES `candidato_habilidad` WRITE;
/*!40000 ALTER TABLE `candidato_habilidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidato_habilidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificacion`
--

DROP TABLE IF EXISTS `certificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `certificacion` (
  `certificacion_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`certificacion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificacion`
--

LOCK TABLES `certificacion` WRITE;
/*!40000 ALTER TABLE `certificacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dba_alertas`
--

DROP TABLE IF EXISTS `dba_alertas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dba_alertas` (
  `alerta_id` int NOT NULL AUTO_INCREMENT,
  `tipo_alerta` varchar(50) NOT NULL COMMENT 'CategorÃ­a: ESPACIO, BLOQUEO, ACCESO, SESIONES, TABLA_GRANDE',
  `nivel` varchar(10) NOT NULL COMMENT 'INFO | WARNING | CRITICO',
  `mensaje` text NOT NULL COMMENT 'DescripciÃ³n legible del problema',
  `detalle` text COMMENT 'JSON o texto extra con mÃ©tricas',
  `fecha_alerta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `atendida` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=pendiente, 1=atendida',
  `atendida_por` varchar(100) DEFAULT NULL,
  `fecha_atencion` datetime DEFAULT NULL,
  PRIMARY KEY (`alerta_id`),
  KEY `idx_nivel` (`nivel`),
  KEY `idx_tipo` (`tipo_alerta`),
  KEY `idx_fecha` (`fecha_alerta`),
  KEY `idx_atendida` (`atendida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Registro centralizado de alertas DBA - bolsa_trabajo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dba_alertas`
--

LOCK TABLES `dba_alertas` WRITE;
/*!40000 ALTER TABLE `dba_alertas` DISABLE KEYS */;
/*!40000 ALTER TABLE `dba_alertas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (7,'admin','logentry'),(9,'auth','group'),(8,'auth','permission'),(10,'auth','user'),(11,'contenttypes','contenttype'),(3,'empleos','candidato'),(1,'empleos','categoria'),(2,'empleos','empresa'),(13,'empleos','notificacion'),(4,'empleos','perfil'),(6,'empleos','postulacion'),(5,'empleos','vacante'),(12,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (21,'contenttypes','0001_initial','2026-06-02 21:09:35.804804'),(22,'auth','0001_initial','2026-06-02 21:09:37.379046'),(23,'admin','0001_initial','2026-06-02 21:09:37.658838'),(24,'admin','0002_logentry_remove_auto_add','2026-06-02 21:09:37.682109'),(25,'admin','0003_logentry_add_action_flag_choices','2026-06-02 21:09:37.701324'),(26,'contenttypes','0002_remove_content_type_name','2026-06-02 21:09:37.903518'),(27,'auth','0002_alter_permission_name_max_length','2026-06-02 21:09:38.028722'),(28,'auth','0003_alter_user_email_max_length','2026-06-02 21:09:38.118549'),(29,'auth','0004_alter_user_username_opts','2026-06-02 21:09:38.148542'),(30,'auth','0005_alter_user_last_login_null','2026-06-02 21:09:38.288869'),(31,'auth','0006_require_contenttypes_0002','2026-06-02 21:09:38.295295'),(32,'auth','0007_alter_validators_add_error_messages','2026-06-02 21:09:38.313218'),(33,'auth','0008_alter_user_username_max_length','2026-06-02 21:09:38.398818'),(34,'auth','0009_alter_user_last_name_max_length','2026-06-02 21:09:38.490442'),(35,'auth','0010_alter_group_name_max_length','2026-06-02 21:09:38.579879'),(36,'auth','0011_update_proxy_permissions','2026-06-02 21:09:38.594935'),(37,'auth','0012_alter_user_first_name_max_length','2026-06-02 21:09:38.689415'),(38,'empleos','0001_initial','2026-06-02 21:09:39.689112'),(39,'sessions','0001_initial','2026-06-02 21:09:39.855647'),(40,'empleos','0002_candidato_area_interes_candidato_dui_and_more','2026-06-03 02:11:31.964078'),(41,'empleos','0003_vacante_experiencia_vacante_numero_vacantes_and_more','2026-06-03 17:06:14.531649'),(42,'empleos','0004_vacante_creado_por_usuario','2026-06-03 17:34:35.626089'),(43,'empleos','0005_vacante_nivel_experiencia','2026-06-03 19:12:06.968842'),(44,'empleos','0006_alter_postulacion_estado','2026-06-03 20:55:06.324361'),(45,'empleos','0007_candidato_categorias_interes_notificacion','2026-06-04 16:34:32.165228'),(46,'empleos','0008_alter_postulacion_estado','2026-06-04 17:17:57.647766');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleos_candidato`
--

DROP TABLE IF EXISTS `empleos_candidato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_candidato` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `curriculum` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `experiencia` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `creado_por` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `area_interes` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dui` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estudios` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `habilidades` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `empleos_candidato_user_id_8723dcc4_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleos_candidato`
--

LOCK TABLES `empleos_candidato` WRITE;
/*!40000 ALTER TABLE `empleos_candidato` DISABLE KEYS */;
INSERT INTO `empleos_candidato` VALUES (1,'76534231','','','Mi primera chamba',4,NULL,NULL,NULL,NULL,'Educacion','088972131','Universidad','Aprendo rapido');
/*!40000 ALTER TABLE `empleos_candidato` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_audit_candidato_django_insert` BEFORE INSERT ON `empleos_candidato` FOR EACH ROW BEGIN
  SET NEW.creado_por = COALESCE(
    (SELECT username FROM auth_user WHERE id = NEW.user_id),
    USER()
  );
  SET NEW.fecha_creacion = NOW();
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_candidato_django_insert` AFTER INSERT ON `empleos_candidato` FOR EACH ROW BEGIN
  INSERT INTO hist_empleos_candidato (
    accion, fecha_accion, usuario_accion,
    candidato_id, user_id, telefono, direccion, experiencia,
    dui, area_interes, estudios, habilidades,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'INSERT', NOW(),
    COALESCE((SELECT username FROM auth_user WHERE id = NEW.user_id), USER()),
    NEW.id, NEW.user_id, NEW.telefono, NEW.direccion, NEW.experiencia,
    NEW.dui, NEW.area_interes, NEW.estudios, NEW.habilidades,
    NEW.creado_por, NEW.fecha_creacion, NEW.modificado_por, NEW.fecha_modificacion
  );
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_audit_candidato_django_update` BEFORE UPDATE ON `empleos_candidato` FOR EACH ROW BEGIN
  SET NEW.modificado_por = COALESCE(
    (SELECT username FROM auth_user WHERE id = NEW.user_id),
    USER()
  );
  SET NEW.fecha_modificacion = NOW();
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_candidato_django_update` AFTER UPDATE ON `empleos_candidato` FOR EACH ROW BEGIN
  INSERT INTO hist_empleos_candidato (
    accion, fecha_accion, usuario_accion,
    candidato_id, user_id, telefono, direccion, experiencia,
    dui, area_interes, estudios, habilidades,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'UPDATE', NOW(),
    COALESCE((SELECT username FROM auth_user WHERE id = OLD.user_id), USER()),
    OLD.id, OLD.user_id, OLD.telefono, OLD.direccion, OLD.experiencia,
    OLD.dui, OLD.area_interes, OLD.estudios, OLD.habilidades,
    OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_candidato_django_delete` BEFORE DELETE ON `empleos_candidato` FOR EACH ROW BEGIN
  INSERT INTO hist_empleos_candidato (
    accion, fecha_accion, usuario_accion,
    candidato_id, user_id, telefono, direccion, experiencia,
    dui, area_interes, estudios, habilidades,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'DELETE', NOW(),
    COALESCE((SELECT username FROM auth_user WHERE id = OLD.user_id), USER()),
    OLD.id, OLD.user_id, OLD.telefono, OLD.direccion, OLD.experiencia,
    OLD.dui, OLD.area_interes, OLD.estudios, OLD.habilidades,
    OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `empleos_candidato_categorias_interes`
--

DROP TABLE IF EXISTS `empleos_candidato_categorias_interes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_candidato_categorias_interes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `candidato_id` bigint NOT NULL,
  `categoria_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `empleos_candidato_catego_candidato_id_categoria_i_5b8dbe3b_uniq` (`candidato_id`,`categoria_id`),
  KEY `empleos_candidato_ca_categoria_id_6aa6e2e9_fk_empleos_c` (`categoria_id`),
  CONSTRAINT `empleos_candidato_ca_candidato_id_15936366_fk_empleos_c` FOREIGN KEY (`candidato_id`) REFERENCES `empleos_candidato` (`id`),
  CONSTRAINT `empleos_candidato_ca_categoria_id_6aa6e2e9_fk_empleos_c` FOREIGN KEY (`categoria_id`) REFERENCES `empleos_categoria` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleos_candidato_categorias_interes`
--

LOCK TABLES `empleos_candidato_categorias_interes` WRITE;
/*!40000 ALTER TABLE `empleos_candidato_categorias_interes` DISABLE KEYS */;
INSERT INTO `empleos_candidato_categorias_interes` VALUES (1,1,11);
/*!40000 ALTER TABLE `empleos_candidato_categorias_interes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleos_categoria`
--

DROP TABLE IF EXISTS `empleos_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_categoria` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleos_categoria`
--

LOCK TABLES `empleos_categoria` WRITE;
/*!40000 ALTER TABLE `empleos_categoria` DISABLE KEYS */;
INSERT INTO `empleos_categoria` VALUES (1,'Desarrollo Web'),(2,'Data Science'),(3,'Diseño UX/UI'),(4,'Marketing Digital'),(5,'Recursos Humanos'),(6,'Tecnología y Software'),(7,'Contabilidad y Finanzas'),(8,'Ingeniería'),(9,'Salud'),(10,'Educación'),(11,'Ventas'),(12,'Diseño Gráfico'),(13,'Atención al Cliente'),(14,'Logística y Transporte'),(15,'Legal'),(16,'Construcción'),(17,'Alimentación y Gastronomía'),(18,'Turismo y Hotelería'),(19,'Medio Ambiente'),(20,'Comunicación y Medios'),(21,'Investigación'),(22,'Administración'),(23,'Artes y Cultura');
/*!40000 ALTER TABLE `empleos_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleos_empresa`
--

DROP TABLE IF EXISTS `empleos_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_empresa` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sitio_web` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creado_por` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `persona_contacto` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sector` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleos_empresa`
--

LOCK TABLES `empleos_empresa` WRITE;
/*!40000 ALTER TABLE `empleos_empresa` DISABLE KEYS */;
INSERT INTO `empleos_empresa` VALUES (1,'Tech Solutions SV','Empresa líder en soluciones tecnológicas en El Salvador','San Salvador, El Salvador','2222-3333','info@techsolutions.com.sv',NULL,'system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:11:31','',''),(2,'TECNASA','','San Salvador Centro','23421332','tecnasa.rrhh@gmail.com',NULL,'django_user@localhost','2026-06-02 20:15:56',NULL,NULL,'Ing Quintana','Tecnologia');
/*!40000 ALTER TABLE `empleos_empresa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_audit_empresa_django_insert` BEFORE INSERT ON `empleos_empresa` FOR EACH ROW BEGIN
  SET NEW.creado_por = USER();
  SET NEW.fecha_creacion = NOW();
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_empresa_django_insert` AFTER INSERT ON `empleos_empresa` FOR EACH ROW BEGIN
  INSERT INTO hist_empleos_empresa (accion, fecha_accion, usuario_accion, empresa_id, nombre, correo, telefono, direccion, creado_por, fecha_creacion)
  VALUES ('INSERT', NOW(), USER(), NEW.id, NEW.nombre, NEW.correo, NEW.telefono, NEW.direccion, NEW.creado_por, NEW.fecha_creacion);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_audit_empresa_django_update` BEFORE UPDATE ON `empleos_empresa` FOR EACH ROW BEGIN
  SET NEW.modificado_por = USER();
  SET NEW.fecha_modificacion = NOW();
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_empresa_django_update` AFTER UPDATE ON `empleos_empresa` FOR EACH ROW BEGIN
  INSERT INTO hist_empleos_empresa (accion, fecha_accion, usuario_accion, empresa_id, nombre, correo, telefono, direccion, creado_por, fecha_creacion, modificado_por, fecha_modificacion)
  VALUES ('UPDATE', NOW(), USER(), OLD.id, OLD.nombre, OLD.correo, OLD.telefono, OLD.direccion, OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_empresa_django_delete` BEFORE DELETE ON `empleos_empresa` FOR EACH ROW BEGIN
  INSERT INTO hist_empleos_empresa (accion, fecha_accion, usuario_accion, empresa_id, nombre, correo, telefono, direccion, creado_por, fecha_creacion, modificado_por, fecha_modificacion)
  VALUES ('DELETE', NOW(), USER(), OLD.id, OLD.nombre, OLD.correo, OLD.telefono, OLD.direccion, OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `empleos_notificacion`
--

DROP TABLE IF EXISTS `empleos_notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_notificacion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mensaje` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `leida` tinyint(1) NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  `url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `empleos_notificacion_usuario_id_25b4d707_fk_auth_user_id` (`usuario_id`),
  CONSTRAINT `empleos_notificacion_usuario_id_25b4d707_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleos_notificacion`
--

LOCK TABLES `empleos_notificacion` WRITE;
/*!40000 ALTER TABLE `empleos_notificacion` DISABLE KEYS */;
INSERT INTO `empleos_notificacion` VALUES (1,'Nueva oferta en Ventas','Se publicó una nueva oferta: \"PRUEBAAA\" en Santa Ana. ¡Echa un vistazo!','NUEVO_EMPLEO',1,'2026-06-04 17:39:06.940636','/empleo/10/',4),(2,'Cambio de estado en tu postulación','Tu postulación para \"PRUEBAAA\" está siendo revisada.','CAMBIO_ESTADO',0,'2026-06-04 17:43:26.728310','/mis-postulaciones/',4);
/*!40000 ALTER TABLE `empleos_notificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleos_perfil`
--

DROP TABLE IF EXISTS `empleos_perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_perfil` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tipo_usuario` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `empleos_perfil_usuario_id_b6d218c9_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleos_perfil`
--

LOCK TABLES `empleos_perfil` WRITE;
/*!40000 ALTER TABLE `empleos_perfil` DISABLE KEYS */;
INSERT INTO `empleos_perfil` VALUES (1,'empresa',1),(2,'candidato',2),(3,'empresa',3),(4,'candidato',4);
/*!40000 ALTER TABLE `empleos_perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleos_postulacion`
--

DROP TABLE IF EXISTS `empleos_postulacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_postulacion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha_postulacion` datetime(6) NOT NULL,
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mensaje` longtext COLLATE utf8mb4_unicode_ci,
  `candidato_id` bigint NOT NULL,
  `vacante_id` bigint NOT NULL,
  `creado_por` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `empleos_postulacion_candidato_id_cf1d1c6b_fk_empleos_c` (`candidato_id`),
  KEY `empleos_postulacion_vacante_id_7435057a_fk_empleos_vacante_id` (`vacante_id`),
  CONSTRAINT `empleos_postulacion_candidato_id_cf1d1c6b_fk_empleos_c` FOREIGN KEY (`candidato_id`) REFERENCES `empleos_candidato` (`id`),
  CONSTRAINT `empleos_postulacion_vacante_id_7435057a_fk_empleos_vacante_id` FOREIGN KEY (`vacante_id`) REFERENCES `empleos_vacante` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleos_postulacion`
--

LOCK TABLES `empleos_postulacion` WRITE;
/*!40000 ALTER TABLE `empleos_postulacion` DISABLE KEYS */;
INSERT INTO `empleos_postulacion` VALUES (1,'2026-06-03 19:45:14.846821','PENDIENTE','',1,1,NULL,NULL,NULL,NULL),(2,'2026-06-03 19:48:58.623336','RECHAZADO','',1,9,NULL,NULL,NULL,NULL),(3,'2026-06-04 16:32:35.211481','PENDIENTE','',1,2,NULL,NULL,NULL,NULL),(4,'2026-06-04 17:42:43.833271','EN_REVISION','',1,10,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `empleos_postulacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_audit_postulacion_django_insert` BEFORE INSERT ON `empleos_postulacion` FOR EACH ROW BEGIN
  SET NEW.creado_por = USER();
  SET NEW.fecha_creacion = NOW();
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_postulacion_django_insert` AFTER INSERT ON `empleos_postulacion` FOR EACH ROW BEGIN
  INSERT INTO hist_empleos_postulacion (
    accion, fecha_accion, usuario_accion,
    postulacion_id, candidato_id, vacante_id, estado, mensaje,
    fecha_postulacion, creado_por, fecha_creacion
  ) VALUES (
    'INSERT', NOW(), USER(),
    NEW.id, NEW.candidato_id, NEW.vacante_id, NEW.estado, NEW.mensaje,
    NEW.fecha_postulacion, NEW.creado_por, NEW.fecha_creacion
  );
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_audit_postulacion_django_update` BEFORE UPDATE ON `empleos_postulacion` FOR EACH ROW BEGIN
  SET NEW.modificado_por = USER();
  SET NEW.fecha_modificacion = NOW();
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_postulacion_django_update` AFTER UPDATE ON `empleos_postulacion` FOR EACH ROW BEGIN
  INSERT INTO hist_empleos_postulacion (
    accion, fecha_accion, usuario_accion,
    postulacion_id, candidato_id, vacante_id, estado, mensaje,
    fecha_postulacion, creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'UPDATE', NOW(), USER(),
    OLD.id, OLD.candidato_id, OLD.vacante_id, OLD.estado, OLD.mensaje,
    OLD.fecha_postulacion, OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_postulacion_django_delete` BEFORE DELETE ON `empleos_postulacion` FOR EACH ROW BEGIN
  INSERT INTO hist_empleos_postulacion (
    accion, fecha_accion, usuario_accion,
    postulacion_id, candidato_id, vacante_id, estado, mensaje,
    fecha_postulacion, creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'DELETE', NOW(), USER(),
    OLD.id, OLD.candidato_id, OLD.vacante_id, OLD.estado, OLD.mensaje,
    OLD.fecha_postulacion, OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `empleos_vacante`
--

DROP TABLE IF EXISTS `empleos_vacante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_vacante` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `requisitos` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `ubicacion` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_publicacion` datetime(6) NOT NULL,
  `fecha_limite` date NOT NULL,
  `categoria_id` bigint DEFAULT NULL,
  `empresa_id` bigint NOT NULL,
  `creado_por` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `experiencia` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_vacantes` int unsigned NOT NULL,
  `tipo_contrato` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creado_por_usuario_id` int DEFAULT NULL,
  `nivel_experiencia` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `empleos_vacante_categoria_id_c8fb8377_fk_empleos_categoria_id` (`categoria_id`),
  KEY `empleos_vacante_empresa_id_1d7a0103_fk_empleos_empresa_id` (`empresa_id`),
  KEY `empleos_vacante_creado_por_usuario_id_fb50df63_fk_auth_user_id` (`creado_por_usuario_id`),
  CONSTRAINT `empleos_vacante_categoria_id_c8fb8377_fk_empleos_categoria_id` FOREIGN KEY (`categoria_id`) REFERENCES `empleos_categoria` (`id`),
  CONSTRAINT `empleos_vacante_creado_por_usuario_id_fb50df63_fk_auth_user_id` FOREIGN KEY (`creado_por_usuario_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `empleos_vacante_empresa_id_1d7a0103_fk_empleos_empresa_id` FOREIGN KEY (`empresa_id`) REFERENCES `empleos_empresa` (`id`),
  CONSTRAINT `empleos_vacante_chk_1` CHECK ((`numero_vacantes` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleos_vacante`
--

LOCK TABLES `empleos_vacante` WRITE;
/*!40000 ALTER TABLE `empleos_vacante` DISABLE KEYS */;
INSERT INTO `empleos_vacante` VALUES (1,'Desarrollador Frontend React','Buscamos desarrollador frontend con experiencia en React y Tailwind CSS.','Experiencia comprobable',2500.00,'San Salvador','ACTIVA','2026-06-02 21:10:06.454966','2026-07-01',1,1,'system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:43:21','',1,'TIEMPO_COMPLETO',NULL,'SIN_EXPERIENCIA'),(2,'Analista de Datos','Analista de datos con experiencia en Python y SQL.','Experiencia comprobable',2000.00,'Remoto','ACTIVA','2026-06-02 21:10:06.464945','2026-07-15',2,1,'system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:11:31','',1,'TIEMPO_COMPLETO',NULL,'SIN_EXPERIENCIA'),(3,'Diseñador UX/UI','Diseñador UX/UI con experiencia en Figma.','Experiencia comprobable',1800.00,'Santa Tecla','ACTIVA','2026-06-02 21:10:06.472925','2026-06-30',3,1,'system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:11:31','',1,'TIEMPO_COMPLETO',NULL,'SIN_EXPERIENCIA'),(4,'Developer Jr.','Conocimientos basicos ','',650.00,'San Miguel','ACTIVA','2026-06-02 21:25:50.854068','2026-06-10',1,1,'django_user@localhost','2026-06-02 15:25:50',NULL,NULL,'',1,'TIEMPO_COMPLETO',NULL,'SIN_EXPERIENCIA'),(5,'Nueva vacante para test INSERT trigger','Test INSERT trigger','Test',5000.00,'San Miguel','ACTIVA','2026-06-02 21:44:19.953202','2026-08-01',1,1,'django_user@localhost','2026-06-02 15:44:19',NULL,NULL,'',1,'TIEMPO_COMPLETO',NULL,'SIN_EXPERIENCIA'),(6,'Prueba 2','Prueba','',1000.00,'San Jose','ACTIVA','2026-06-02 21:47:52.430563','2026-06-11',2,1,'django_user@localhost','2026-06-02 15:47:52',NULL,NULL,'',1,'TIEMPO_COMPLETO',NULL,'SIN_EXPERIENCIA'),(9,'Recepcionista','Recepcion de documentos','Dos años de experiencia, servicial, buena disposicion, buena presentacion personal.',600.00,'Morazan','ACTIVA','2026-06-03 19:48:34.089568','2026-06-10',5,2,'TECNASA','2026-06-03 13:48:34',NULL,NULL,'',1,'TEMPORAL',3,'JUNIOR'),(10,'PRUEBAAA','PRUEBA','Prueba',300.00,'Santa Ana','ACTIVA','2026-06-04 17:39:06.879257','2026-06-17',11,2,'TECNASA','2026-06-04 11:39:06',NULL,NULL,'',1,'PRACTICAS',3,'SIN_EXPERIENCIA');
/*!40000 ALTER TABLE `empleos_vacante` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_audit_vacante_django_insert` BEFORE INSERT ON `empleos_vacante` FOR EACH ROW BEGIN
  IF NEW.creado_por IS NULL OR NEW.creado_por = '' THEN
    SET NEW.creado_por = COALESCE(
      (SELECT username FROM auth_user WHERE id = NEW.creado_por_usuario_id),
      USER()
    );
  END IF;
  IF NEW.fecha_creacion IS NULL THEN
    SET NEW.fecha_creacion = NOW();
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_vacante_django_insert` AFTER INSERT ON `empleos_vacante` FOR EACH ROW BEGIN
  INSERT INTO hist_empleos_vacante (
    accion, fecha_accion, usuario_accion, vacante_id,
    titulo, descripcion, requisitos, experiencia,
    ubicacion, tipo_contrato, numero_vacantes,
    salario, estado, fecha_limite,
    categoria_id, empresa_id,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  )
  VALUES (
    'INSERT', NOW(),
    COALESCE(
      NEW.creado_por_usuario_id,
      NEW.creado_por,
      USER()
    ),
    NEW.id,
    COALESCE(NEW.titulo, ''),
    COALESCE(NEW.descripcion, ''),
    COALESCE(NEW.requisitos, ''),
    COALESCE(NEW.experiencia, ''),
    COALESCE(NEW.ubicacion, ''),
    COALESCE(NEW.tipo_contrato, 'TIEMPO_COMPLETO'),
    COALESCE(NEW.numero_vacantes, 1),
    NEW.salario,
    COALESCE(NEW.estado, 'ACTIVA'),
    NEW.fecha_limite,
    NEW.categoria_id,
    NEW.empresa_id,
    NEW.creado_por,
    NEW.fecha_creacion,
    NULL, NULL
  );
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_audit_vacante_django_update` BEFORE UPDATE ON `empleos_vacante` FOR EACH ROW BEGIN
  SET NEW.modificado_por = COALESCE(
    (SELECT username FROM auth_user WHERE id = NEW.creado_por_usuario_id),
    USER()
  );
  SET NEW.fecha_modificacion = NOW();
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_vacante_django_update` AFTER UPDATE ON `empleos_vacante` FOR EACH ROW BEGIN
  INSERT INTO hist_empleos_vacante (
    accion, fecha_accion, usuario_accion, vacante_id,
    titulo, descripcion, requisitos, experiencia,
    ubicacion, tipo_contrato, numero_vacantes,
    salario, estado, fecha_limite,
    categoria_id, empresa_id,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  )
  VALUES (
    'UPDATE', NOW(),
    COALESCE(
      NEW.creado_por_usuario_id,
      OLD.creado_por,
      USER()
    ),
    OLD.id,
    COALESCE(NEW.titulo, ''),
    COALESCE(NEW.descripcion, ''),
    COALESCE(NEW.requisitos, ''),
    COALESCE(NEW.experiencia, ''),
    COALESCE(NEW.ubicacion, ''),
    COALESCE(NEW.tipo_contrato, 'TIEMPO_COMPLETO'),
    COALESCE(NEW.numero_vacantes, 1),
    NEW.salario,
    COALESCE(NEW.estado, 'ACTIVA'),
    NEW.fecha_limite,
    NEW.categoria_id,
    NEW.empresa_id,
    OLD.creado_por,
    OLD.fecha_creacion,
    NEW.modificado_por,
    NEW.fecha_modificacion
  );
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_hist_vacante_django_delete` BEFORE DELETE ON `empleos_vacante` FOR EACH ROW BEGIN
  INSERT INTO hist_empleos_vacante (
    accion, fecha_accion, usuario_accion, vacante_id,
    titulo, descripcion, requisitos, experiencia,
    ubicacion, tipo_contrato, numero_vacantes,
    salario, estado, fecha_limite,
    categoria_id, empresa_id,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  )
  VALUES (
    'DELETE', NOW(),
    COALESCE(
      OLD.creado_por_usuario_id,
      OLD.creado_por,
      USER()
    ),
    OLD.id,
    COALESCE(OLD.titulo, ''),
    COALESCE(OLD.descripcion, ''),
    COALESCE(OLD.requisitos, ''),
    COALESCE(OLD.experiencia, ''),
    COALESCE(OLD.ubicacion, ''),
    COALESCE(OLD.tipo_contrato, 'TIEMPO_COMPLETO'),
    COALESCE(OLD.numero_vacantes, 1),
    OLD.salario,
    COALESCE(OLD.estado, 'ACTIVA'),
    OLD.fecha_limite,
    OLD.categoria_id,
    OLD.empresa_id,
    OLD.creado_por,
    OLD.fecha_creacion,
    OLD.modificado_por,
    OLD.fecha_modificacion
  );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresa` (
  `empresa_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `persona_contacto` varchar(100) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `sector_id` int DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`empresa_id`),
  KEY `sector_id` (`sector_id`),
  CONSTRAINT `empresa_ibfk_1` FOREIGN KEY (`sector_id`) REFERENCES `sector` (`sector_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_postulacion`
--

DROP TABLE IF EXISTS `estado_postulacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_postulacion` (
  `estado_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`estado_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_postulacion`
--

LOCK TABLES `estado_postulacion` WRITE;
/*!40000 ALTER TABLE `estado_postulacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `estado_postulacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experiencia`
--

DROP TABLE IF EXISTS `experiencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `experiencia` (
  `experiencia_id` int NOT NULL AUTO_INCREMENT,
  `candidato_id` int DEFAULT NULL,
  `empresa` varchar(100) DEFAULT NULL,
  `puesto` varchar(50) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`experiencia_id`),
  KEY `candidato_id` (`candidato_id`),
  CONSTRAINT `experiencia_ibfk_1` FOREIGN KEY (`candidato_id`) REFERENCES `candidato` (`candidato_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiencia`
--

LOCK TABLES `experiencia` WRITE;
/*!40000 ALTER TABLE `experiencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `experiencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formacion_academica`
--

DROP TABLE IF EXISTS `formacion_academica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formacion_academica` (
  `formacion_id` int NOT NULL AUTO_INCREMENT,
  `candidato_id` int DEFAULT NULL,
  `institucion` varchar(100) DEFAULT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  PRIMARY KEY (`formacion_id`),
  KEY `candidato_id` (`candidato_id`),
  CONSTRAINT `formacion_academica_ibfk_1` FOREIGN KEY (`candidato_id`) REFERENCES `candidato` (`candidato_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formacion_academica`
--

LOCK TABLES `formacion_academica` WRITE;
/*!40000 ALTER TABLE `formacion_academica` DISABLE KEYS */;
/*!40000 ALTER TABLE `formacion_academica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habilidad`
--

DROP TABLE IF EXISTS `habilidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `habilidad` (
  `habilidad_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`habilidad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habilidad`
--

LOCK TABLES `habilidad` WRITE;
/*!40000 ALTER TABLE `habilidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `habilidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hist_auth_user`
--

DROP TABLE IF EXISTS `hist_auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hist_auth_user` (
  `hist_id` int NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) NOT NULL COMMENT 'UPDATE o DELETE',
  `fecha_accion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion` varchar(100) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_superuser` tinyint(1) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hist_auth_user`
--

LOCK TABLES `hist_auth_user` WRITE;
/*!40000 ALTER TABLE `hist_auth_user` DISABLE KEYS */;
INSERT INTO `hist_auth_user` VALUES (1,'UPDATE','2026-06-02 15:11:31','django_user@localhost',1,'admin','admin@example.com',1,1,NULL,NULL,NULL,NULL),(2,'UPDATE','2026-06-02 15:16:56','django_user@localhost',1,'admin','admin@example.com',1,1,'system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:11:31'),(3,'UPDATE','2026-06-02 15:47:22','django_user@localhost',1,'admin','admin@example.com',1,1,'system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:16:56'),(4,'UPDATE','2026-06-02 15:55:39','django_user@localhost',2,'Juanito','Juanperez@gmail.com',1,0,'django_user@localhost','2026-06-02 15:27:11',NULL,NULL),(5,'INSERT','2026-06-02 20:15:56','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56',NULL,NULL),(6,'UPDATE','2026-06-02 20:16:09','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56',NULL,NULL),(7,'UPDATE','2026-06-03 11:18:22','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-02 20:16:09'),(8,'INSERT','2026-06-03 13:25:56','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56',NULL,NULL),(9,'UPDATE','2026-06-03 13:26:03','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56',NULL,NULL),(10,'UPDATE','2026-06-03 13:45:29','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-03 11:18:22'),(11,'UPDATE','2026-06-03 13:48:49','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-03 13:26:03'),(12,'UPDATE','2026-06-03 13:49:09','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-03 13:45:29'),(13,'UPDATE','2026-06-03 14:14:05','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-03 13:48:49'),(14,'UPDATE','2026-06-03 14:37:56','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-03 13:49:09'),(15,'UPDATE','2026-06-03 14:40:16','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-03 14:14:05'),(16,'UPDATE','2026-06-03 15:16:53','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-03 14:37:56'),(17,'UPDATE','2026-06-04 10:28:43','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-03 15:16:53'),(18,'UPDATE','2026-06-04 10:31:24','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-03 14:40:16'),(19,'UPDATE','2026-06-04 11:08:39','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-04 10:31:24'),(20,'UPDATE','2026-06-04 11:31:06','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-04 10:28:43'),(21,'UPDATE','2026-06-04 11:32:05','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-04 11:08:39'),(22,'UPDATE','2026-06-04 11:32:23','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-04 11:31:06'),(23,'UPDATE','2026-06-04 11:39:17','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-04 11:32:05'),(24,'UPDATE','2026-06-04 11:42:55','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-04 11:32:23'),(25,'UPDATE','2026-06-04 11:43:35','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-04 11:39:17'),(26,'UPDATE','2026-06-04 11:47:51','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-04 11:42:55'),(27,'UPDATE','2026-06-04 12:42:24','django_user@localhost',1,'admin','admin@example.com',1,1,'system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:47:22');
/*!40000 ALTER TABLE `hist_auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hist_empleos_candidato`
--

DROP TABLE IF EXISTS `hist_empleos_candidato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hist_empleos_candidato` (
  `hist_id` int NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_accion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `candidato_id` bigint DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `experiencia` text COLLATE utf8mb4_unicode_ci,
  `dui` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `area_interes` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estudios` text COLLATE utf8mb4_unicode_ci,
  `habilidades` text COLLATE utf8mb4_unicode_ci,
  `creado_por` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hist_empleos_candidato`
--

LOCK TABLES `hist_empleos_candidato` WRITE;
/*!40000 ALTER TABLE `hist_empleos_candidato` DISABLE KEYS */;
/*!40000 ALTER TABLE `hist_empleos_candidato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hist_empleos_empresa`
--

DROP TABLE IF EXISTS `hist_empleos_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hist_empleos_empresa` (
  `hist_id` int NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) NOT NULL,
  `fecha_accion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion` varchar(100) DEFAULT NULL,
  `empresa_id` bigint DEFAULT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `correo` varchar(254) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hist_empleos_empresa`
--

LOCK TABLES `hist_empleos_empresa` WRITE;
/*!40000 ALTER TABLE `hist_empleos_empresa` DISABLE KEYS */;
INSERT INTO `hist_empleos_empresa` VALUES (1,'UPDATE','2026-06-02 15:11:31','django_user@localhost',1,'Tech Solutions SV','info@techsolutions.com.sv','2222-3333','San Salvador, El Salvador',NULL,NULL,NULL,NULL),(2,'INSERT','2026-06-02 20:15:56','django_user@localhost',2,'TECNASA','tecnasa.rrhh@gmail.com','23421332','San Salvador Centro','django_user@localhost','2026-06-02 20:15:56',NULL,NULL);
/*!40000 ALTER TABLE `hist_empleos_empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hist_empleos_postulacion`
--

DROP TABLE IF EXISTS `hist_empleos_postulacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hist_empleos_postulacion` (
  `hist_id` int NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_accion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postulacion_id` bigint DEFAULT NULL,
  `candidato_id` bigint DEFAULT NULL,
  `vacante_id` bigint DEFAULT NULL,
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mensaje` text COLLATE utf8mb4_unicode_ci,
  `fecha_postulacion` datetime(6) DEFAULT NULL,
  `creado_por` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hist_empleos_postulacion`
--

LOCK TABLES `hist_empleos_postulacion` WRITE;
/*!40000 ALTER TABLE `hist_empleos_postulacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `hist_empleos_postulacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hist_empleos_vacante`
--

DROP TABLE IF EXISTS `hist_empleos_vacante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hist_empleos_vacante` (
  `hist_id` int NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) NOT NULL,
  `fecha_accion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion` varchar(100) DEFAULT NULL,
  `vacante_id` bigint DEFAULT NULL,
  `titulo` varchar(200) DEFAULT NULL,
  `descripcion` text,
  `requisitos` longtext,
  `experiencia` longtext,
  `tipo_contrato` varchar(20) DEFAULT NULL,
  `numero_vacantes` int DEFAULT NULL,
  `categoria_id` bigint DEFAULT NULL,
  `empresa_id` bigint DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `ubicacion` varchar(150) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `fecha_limite` date DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hist_empleos_vacante`
--

LOCK TABLES `hist_empleos_vacante` WRITE;
/*!40000 ALTER TABLE `hist_empleos_vacante` DISABLE KEYS */;
INSERT INTO `hist_empleos_vacante` VALUES (1,'UPDATE','2026-06-02 15:11:31','django_user@localhost',1,'Desarrollador Frontend React','Buscamos desarrollador frontend con experiencia en React y Tailwind CSS.',NULL,NULL,NULL,NULL,NULL,NULL,1500.00,'San Salvador','ACTIVA','2026-07-01',NULL,NULL,NULL,NULL),(2,'UPDATE','2026-06-02 15:11:31','django_user@localhost',2,'Analista de Datos','Analista de datos con experiencia en Python y SQL.',NULL,NULL,NULL,NULL,NULL,NULL,2000.00,'Remoto','ACTIVA','2026-07-15',NULL,NULL,NULL,NULL),(3,'UPDATE','2026-06-02 15:11:31','django_user@localhost',3,'Diseñador UX/UI','Diseñador UX/UI con experiencia en Figma.',NULL,NULL,NULL,NULL,NULL,NULL,1800.00,'Santa Tecla','ACTIVA','2026-06-30',NULL,NULL,NULL,NULL),(4,'UPDATE','2026-06-02 15:43:21','django_user@localhost',1,'Desarrollador Frontend React','Buscamos desarrollador frontend con experiencia en React y Tailwind CSS.',NULL,NULL,NULL,NULL,NULL,NULL,1500.00,'San Salvador','ACTIVA','2026-07-01','system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:11:31'),(5,'INSERT','2026-06-02 15:44:19','django_user@localhost',5,'Nueva vacante para test INSERT trigger','Test INSERT trigger',NULL,NULL,NULL,NULL,NULL,NULL,5000.00,'San Miguel','ACTIVA','2026-08-01','django_user@localhost','2026-06-02 15:44:19',NULL,NULL),(6,'INSERT','2026-06-02 15:47:52','django_user@localhost',6,'Prueba 2','Prueba',NULL,NULL,NULL,NULL,NULL,NULL,1000.00,'San Jose','ACTIVA','2026-06-11','django_user@localhost','2026-06-02 15:47:52',NULL,NULL),(7,'INSERT','2026-06-03 11:20:18','django_user@localhost',7,'Asistente Ejecutivo','Prueba de insercion y borrado',NULL,NULL,NULL,NULL,NULL,NULL,650.00,'San Miguel','ACTIVA','2026-06-09','django_user@localhost','2026-06-03 11:20:18',NULL,NULL),(8,'UPDATE','2026-06-03 11:20:41','django_user@localhost',7,'Asistente Ejecutivo','Prueba de insercion y borrado',NULL,NULL,NULL,NULL,NULL,NULL,650.00,'San Miguel','ACTIVA','2026-06-09','django_user@localhost','2026-06-03 11:20:18',NULL,NULL),(9,'UPDATE','2026-06-03 11:43:44','django_user@localhost',7,'Asistente Ejecutivo','Prueba de insercion y borrado',NULL,NULL,NULL,NULL,NULL,NULL,675.00,'San Miguel','ACTIVA','2026-06-09','django_user@localhost','2026-06-03 11:20:18','django_user@localhost','2026-06-03 11:20:41'),(10,'INSERT','2026-06-03 11:46:12','django_user@localhost',8,'TEST','Prueba',NULL,NULL,NULL,NULL,NULL,NULL,666.00,'TEST','ACTIVA','2026-06-30','django_user@localhost','2026-06-03 11:46:12',NULL,NULL),(11,'UPDATE','2026-06-03 11:47:17','django_user@localhost',8,'TEST','Prueba',NULL,NULL,NULL,NULL,NULL,NULL,666.00,'TEST','ACTIVA','2026-06-30','django_user@localhost','2026-06-03 11:46:12',NULL,NULL),(12,'UPDATE','2026-06-03 11:54:18','3',8,'TEST TRES','Prueba','Prueba','Prueba','MEDIO_TIEMPO',1,1,2,766.00,'TEST','ACTIVA','2026-06-30','django_user@localhost','2026-06-03 11:46:12','TECNASA','2026-06-03 11:54:18'),(13,'DELETE','2026-06-03 12:09:18','django_user@localhost',7,'Asistente Ejecutivo','Prueba de insercion y borrado','Estudios tecnicos','Dos años en puestos similares','PROYECTO',2,5,2,675.00,'San Miguel','ACTIVA','2026-06-09','django_user@localhost','2026-06-03 11:20:18','django_user@localhost','2026-06-03 11:43:44'),(14,'DELETE','2026-06-03 12:11:36','3',8,'TEST TRES','Prueba','Prueba','Prueba','MEDIO_TIEMPO',1,1,2,766.00,'TEST','ACTIVA','2026-06-30','django_user@localhost','2026-06-03 11:46:12','TECNASA','2026-06-03 11:54:18'),(15,'INSERT','2026-06-03 13:48:34','3',9,'Recepcionista','Recepcion de documentos','Dos años de experiencia, servicial, buena disposicion, buena presentacion personal.','','TEMPORAL',1,5,2,600.00,'Morazan','ACTIVA','2026-06-10','TECNASA','2026-06-03 13:48:34',NULL,NULL),(16,'INSERT','2026-06-04 11:39:06','3',10,'PRUEBAAA','PRUEBA','Prueba','','PRACTICAS',1,11,2,300.00,'Santa Ana','ACTIVA','2026-06-17','TECNASA','2026-06-04 11:39:06',NULL,NULL);
/*!40000 ALTER TABLE `hist_empleos_vacante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificacion`
--

DROP TABLE IF EXISTS `notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificacion` (
  `notificacion_id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int DEFAULT NULL,
  `mensaje` varchar(255) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `leido` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`notificacion_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `notificacion_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificacion`
--

LOCK TABLES `notificacion` WRITE;
/*!40000 ALTER TABLE `notificacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oferta`
--

DROP TABLE IF EXISTS `oferta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oferta` (
  `oferta_id` int NOT NULL AUTO_INCREMENT,
  `empresa_id` int DEFAULT NULL,
  `puesto` varchar(100) DEFAULT NULL,
  `descripcion` text,
  `requisitos` text,
  `experiencia_requerida` varchar(100) DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `tipo_contrato` varchar(50) DEFAULT NULL,
  `vacantes` int DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `fecha_limite` date DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`oferta_id`),
  KEY `empresa_id` (`empresa_id`),
  CONSTRAINT `oferta_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresa` (`empresa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oferta`
--

LOCK TABLES `oferta` WRITE;
/*!40000 ALTER TABLE `oferta` DISABLE KEYS */;
/*!40000 ALTER TABLE `oferta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pkg_registro`
--

DROP TABLE IF EXISTS `pkg_registro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pkg_registro` (
  `pkg_id` int NOT NULL AUTO_INCREMENT,
  `paquete` varchar(50) NOT NULL COMMENT 'Nombre lÃ³gico del paquete',
  `procedimiento` varchar(100) NOT NULL COMMENT 'Nombre completo del SP',
  `descripcion` varchar(255) DEFAULT NULL,
  `version` varchar(10) DEFAULT '1.0',
  `fecha_deploy` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pkg_id`),
  UNIQUE KEY `uq_proc` (`procedimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Registro de paquetes simulados';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pkg_registro`
--

LOCK TABLES `pkg_registro` WRITE;
/*!40000 ALTER TABLE `pkg_registro` DISABLE KEYS */;
INSERT INTO `pkg_registro` VALUES (1,'pkg_candidatos','pkg_candidatos__registrar','Registra un nuevo candidato validando duplicados','1.0','2026-06-06 15:45:53'),(2,'pkg_candidatos','pkg_candidatos__obtener_perfil_completo','Devuelve 5 result-sets con el perfil completo','1.0','2026-06-06 15:45:53'),(3,'pkg_candidatos','pkg_candidatos__estadisticas','EstadÃ­sticas de postulaciones de un candidato','1.0','2026-06-06 15:45:53'),(4,'pkg_ofertas','pkg_ofertas__publicar','Publica una vacante con validaciones de negocio','1.0','2026-06-06 15:45:53'),(5,'pkg_ofertas','pkg_ofertas__buscar','BÃºsqueda filtrada de vacantes activas','1.0','2026-06-06 15:45:53'),(6,'pkg_ofertas','pkg_ofertas__dashboard_empresa','Dashboard de vacantes y postulaciones por empresa','1.0','2026-06-06 15:45:53'),(7,'pkg_reportes','pkg_reportes__kpis_generales','KPIs generales de la plataforma','1.0','2026-06-06 15:45:53'),(8,'pkg_reportes','pkg_reportes__top_candidatos','Top N candidatos por actividad','1.0','2026-06-06 15:45:53'),(9,'pkg_reportes','pkg_reportes__actividad_mensual','MÃ©tricas de actividad de un mes especÃ­fico','1.0','2026-06-06 15:45:53');
/*!40000 ALTER TABLE `pkg_registro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postulacion`
--

DROP TABLE IF EXISTS `postulacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `postulacion` (
  `postulacion_id` int NOT NULL AUTO_INCREMENT,
  `candidato_id` int DEFAULT NULL,
  `oferta_id` int DEFAULT NULL,
  `estado_id` int DEFAULT NULL,
  `fecha_postulacion` date DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`postulacion_id`),
  UNIQUE KEY `candidato_id` (`candidato_id`,`oferta_id`),
  KEY `oferta_id` (`oferta_id`),
  KEY `estado_id` (`estado_id`),
  CONSTRAINT `postulacion_ibfk_1` FOREIGN KEY (`candidato_id`) REFERENCES `candidato` (`candidato_id`),
  CONSTRAINT `postulacion_ibfk_2` FOREIGN KEY (`oferta_id`) REFERENCES `oferta` (`oferta_id`),
  CONSTRAINT `postulacion_ibfk_3` FOREIGN KEY (`estado_id`) REFERENCES `estado_postulacion` (`estado_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postulacion`
--

LOCK TABLES `postulacion` WRITE;
/*!40000 ALTER TABLE `postulacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `postulacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sector`
--

DROP TABLE IF EXISTS `sector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sector` (
  `sector_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`sector_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sector`
--

LOCK TABLES `sector` WRITE;
/*!40000 ALTER TABLE `sector` DISABLE KEYS */;
/*!40000 ALTER TABLE `sector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_usuario`
--

DROP TABLE IF EXISTS `tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_usuario` (
  `tipo_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`tipo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_usuario`
--

LOCK TABLES `tipo_usuario` WRITE;
/*!40000 ALTER TABLE `tipo_usuario` DISABLE KEYS */;
INSERT INTO `tipo_usuario` VALUES (1,'Admin');
/*!40000 ALTER TABLE `tipo_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `usuario_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasenia` varchar(255) NOT NULL,
  `tipo_id` int NOT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`usuario_id`),
  UNIQUE KEY `correo` (`correo`),
  KEY `tipo_id` (`tipo_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_usuario` (`tipo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_estado_postulaciones_vacante`
--

DROP TABLE IF EXISTS `vw_estado_postulaciones_vacante`;
/*!50001 DROP VIEW IF EXISTS `vw_estado_postulaciones_vacante`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_estado_postulaciones_vacante` AS SELECT 
 1 AS `vacante_id`,
 1 AS `titulo_vacante`,
 1 AS `empresa`,
 1 AS `estado_vacante`,
 1 AS `fecha_limite`,
 1 AS `total_postulaciones`,
 1 AS `pendientes`,
 1 AS `revisadas`,
 1 AS `en_entrevista`,
 1 AS `aceptadas`,
 1 AS `rechazadas`,
 1 AS `ultima_postulacion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_salud_tablas`
--

DROP TABLE IF EXISTS `vw_salud_tablas`;
/*!50001 DROP VIEW IF EXISTS `vw_salud_tablas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_salud_tablas` AS SELECT 
 1 AS `tabla`,
 1 AS `filas_estimadas`,
 1 AS `datos_kb`,
 1 AS `indices_kb`,
 1 AS `total_kb`,
 1 AS `libre_kb`,
 1 AS `pct_fragmentacion`,
 1 AS `estado`,
 1 AS `motor`,
 1 AS `creada`,
 1 AS `ultima_modificacion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_top10_queries_costosos`
--

DROP TABLE IF EXISTS `vw_top10_queries_costosos`;
/*!50001 DROP VIEW IF EXISTS `vw_top10_queries_costosos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_top10_queries_costosos` AS SELECT 
 1 AS `ejecuciones`,
 1 AS `filas_examinadas_prom`,
 1 AS `filas_enviadas_prom`,
 1 AS `pct_desperdicio`,
 1 AS `tiempo_total_seg`,
 1 AS `query_resumen`,
 1 AS `ultima_ejecucion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_top10_queries_lentos`
--

DROP TABLE IF EXISTS `vw_top10_queries_lentos`;
/*!50001 DROP VIEW IF EXISTS `vw_top10_queries_lentos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_top10_queries_lentos` AS SELECT 
 1 AS `avg_seg`,
 1 AS `max_seg`,
 1 AS `ejecuciones`,
 1 AS `filas_examinadas_prom`,
 1 AS `filas_enviadas_prom`,
 1 AS `query_resumen`,
 1 AS `base_datos`,
 1 AS `ultima_ejecucion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_top10_usuarios_sesiones`
--

DROP TABLE IF EXISTS `vw_top10_usuarios_sesiones`;
/*!50001 DROP VIEW IF EXISTS `vw_top10_usuarios_sesiones`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_top10_usuarios_sesiones` AS SELECT 
 1 AS `usuario`,
 1 AS `host_cliente`,
 1 AS `sesiones_totales`,
 1 AS `sesiones_dormidas`,
 1 AS `sesiones_activas`,
 1 AS `tiempo_max_seg`,
 1 AS `tiempo_prom_seg`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'bolsa_trabajo'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `evt_evaluar_alertas` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = latin1 */ ;;
/*!50003 SET character_set_results = latin1 */ ;;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `evt_evaluar_alertas` ON SCHEDULE EVERY 15 MINUTE STARTS '2026-06-06 15:01:17' ON COMPLETION PRESERVE ENABLE COMMENT 'EvalÃºa todas las alertas DBA cada 15 minutos' DO BEGIN
    CALL sp_evaluar_todas_alertas();
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `job_actualizar_estadisticas` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `job_actualizar_estadisticas` ON SCHEDULE EVERY 1 DAY STARTS '2026-06-06 04:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  ANALYZE TABLE auth_user;
  ANALYZE TABLE empleos_candidato;
  ANALYZE TABLE empleos_vacante;
  ANALYZE TABLE empleos_postulacion;
  ANALYZE TABLE empleos_empresa;
  ANALYZE TABLE empleos_notificacion;
  ANALYZE TABLE hist_auth_user;
  ANALYZE TABLE hist_empleos_candidato;
  ANALYZE TABLE hist_empleos_vacante;
  ANALYZE TABLE hist_empleos_postulacion;
  ANALYZE TABLE hist_empleos_empresa;
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `job_matar_conexiones_dormidas` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `job_matar_conexiones_dormidas` ON SCHEDULE EVERY 30 MINUTE STARTS '2026-06-05 20:19:24' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  CALL sp_kill_sleeping_connections();
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `job_optimizar_tablas` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `job_optimizar_tablas` ON SCHEDULE EVERY 1 WEEK STARTS '2026-06-06 03:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  OPTIMIZE TABLE empleos_notificacion;
  OPTIMIZE TABLE empleos_postulacion;
  OPTIMIZE TABLE hist_empleos_postulacion;
  OPTIMIZE TABLE hist_empleos_vacante;
  OPTIMIZE TABLE hist_auth_user;
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `job_purgar_historicos` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `job_purgar_historicos` ON SCHEDULE EVERY 1 MONTH STARTS '2026-07-05 02:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  DELETE FROM hist_auth_user           WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_empleos_candidato   WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_empleos_vacante     WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_empleos_postulacion WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_empleos_empresa     WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `job_purgar_notificaciones` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `job_purgar_notificaciones` ON SCHEDULE EVERY 1 DAY STARTS '2026-06-06 01:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  DELETE FROM empleos_notificacion
  WHERE leida = 1
    AND fecha_creacion < (CURDATE() - INTERVAL 60 DAY);
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'bolsa_trabajo'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_dias_restantes_vacante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_dias_restantes_vacante`(p_vacante_id BIGINT) RETURNS int
    READS SQL DATA
BEGIN
    DECLARE v_fecha_limite DATE;
    DECLARE v_dias         INT;

    SELECT fecha_limite INTO v_fecha_limite
    FROM   empleos_vacante
    WHERE  id = p_vacante_id;

    IF v_fecha_limite IS NULL THEN
        RETURN NULL;
    END IF;

    SET v_dias = DATEDIFF(v_fecha_limite, CURDATE());
    RETURN GREATEST(v_dias, 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_edad_laboral` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_edad_laboral`(p_anios INT) RETURNS varchar(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    RETURN CASE
        WHEN p_anios IS NULL OR p_anios < 0 THEN 'Sin experiencia'
        WHEN p_anios = 0                    THEN 'Sin experiencia'
        WHEN p_anios BETWEEN 1 AND 2        THEN 'Junior'
        WHEN p_anios BETWEEN 3 AND 5        THEN 'Semi-Senior'
        ELSE                                     'Senior'
    END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_estado_vacante_label` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_estado_vacante_label`(p_estado VARCHAR(20)) RETURNS varchar(40) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    RETURN CASE LOWER(TRIM(p_estado))
        WHEN 'activo'    THEN '🟢 Activa'
        WHEN 'cerrado'   THEN '🔴 Cerrada'
        WHEN 'borrador'  THEN '🟡 Borrador'
        WHEN 'pausado'   THEN '🟠 Pausada'
        ELSE                  '⚪ Desconocido'
    END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_porcentaje_ocupacion_vacante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_porcentaje_ocupacion_vacante`(p_vacante_id BIGINT) RETURNS decimal(5,2)
    READS SQL DATA
BEGIN
    DECLARE v_plazas   INT     DEFAULT 0;
    DECLARE v_acept    INT     DEFAULT 0;
    DECLARE v_pct      DECIMAL(5,2) DEFAULT 0.00;

    SELECT numero_vacantes INTO v_plazas
    FROM   empleos_vacante
    WHERE  id = p_vacante_id;

    SELECT COUNT(*) INTO v_acept
    FROM   empleos_postulacion
    WHERE  vacante_id = p_vacante_id
      AND  estado     = 'aceptado';

    IF v_plazas > 0 THEN
        SET v_pct = LEAST(ROUND((v_acept / v_plazas) * 100, 2), 100.00);
    END IF;

    RETURN v_pct;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_total_postulaciones_candidato` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_total_postulaciones_candidato`(p_candidato_id INT) RETURNS int
    READS SQL DATA
BEGIN
    DECLARE v_total INT DEFAULT 0;
    DECLARE v_django INT DEFAULT 0;

    
    SELECT COUNT(*) INTO v_total
    FROM   postulacion
    WHERE  candidato_id = p_candidato_id;

    
    
    SELECT COUNT(*) INTO v_django
    FROM   empleos_postulacion ep
    JOIN   empleos_candidato   ec ON ec.id = ep.candidato_id
    JOIN   candidato            c  ON c.usuario_id = ec.user_id
    WHERE  c.candidato_id = p_candidato_id;

    RETURN v_total + v_django;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pkg_candidatos__estadisticas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pkg_candidatos__estadisticas`(
    IN p_candidato_id INT
)
BEGIN
    SELECT
        fn_total_postulaciones_candidato(p_candidato_id)   AS total_postulaciones,
        SUM(p.estado_id = 2)                               AS aceptadas,   
        SUM(p.estado_id = 3)                               AS rechazadas,
        SUM(p.estado_id = 1)                               AS pendientes,
        MIN(p.fecha_postulacion)                           AS primera_postulacion,
        MAX(p.fecha_postulacion)                           AS ultima_postulacion
    FROM   postulacion p
    WHERE  p.candidato_id = p_candidato_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pkg_candidatos__obtener_perfil_completo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pkg_candidatos__obtener_perfil_completo`(
    IN p_candidato_id INT
)
BEGIN
    
    SELECT c.candidato_id,
           c.nombre_completo,
           c.dui,
           c.telefono,
           c.area_interes,
           u.correo,
           tu.nombre AS tipo_usuario
    FROM   candidato    c
    JOIN   usuarios     u  ON u.usuario_id = c.usuario_id
    JOIN   tipo_usuario tu ON tu.tipo_id   = u.tipo_id
    WHERE  c.candidato_id = p_candidato_id;

    
    SELECT titulo, institucion, fecha_inicio, fecha_fin
    FROM   formacion_academica
    WHERE  candidato_id = p_candidato_id
    ORDER  BY fecha_fin DESC;

    
    SELECT empresa, puesto, fecha_inicio, fecha_fin, descripcion
    FROM   experiencia
    WHERE  candidato_id = p_candidato_id
    ORDER  BY fecha_fin DESC;

    
    SELECT h.nombre
    FROM   candidato_habilidad ch
    JOIN   habilidad h ON h.habilidad_id = ch.habilidad_id
    WHERE  ch.candidato_id = p_candidato_id;

    
    SELECT cert.nombre, cc.institucion, cc.fecha_obtencion
    FROM   candidato_certificacion cc
    JOIN   certificacion cert ON cert.certificacion_id = cc.certificacion_id
    WHERE  cc.candidato_id = p_candidato_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pkg_candidatos__registrar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pkg_candidatos__registrar`(
    IN  p_usuario_id        INT,
    IN  p_nombre_completo   VARCHAR(100),
    IN  p_dui               VARCHAR(20),
    IN  p_telefono          VARCHAR(20),
    IN  p_area_interes      VARCHAR(100),
    IN  p_creado_por        VARCHAR(100),
    OUT p_candidato_id      INT,
    OUT p_mensaje           VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 p_mensaje = MESSAGE_TEXT;
        SET p_candidato_id = -1;
        ROLLBACK;
    END;

    START TRANSACTION;

    
    IF EXISTS (SELECT 1 FROM candidato WHERE usuario_id = p_usuario_id) THEN
        SET p_candidato_id = 0;
        SET p_mensaje = 'El usuario ya tiene un perfil de candidato registrado.';
        ROLLBACK;
    ELSE
        INSERT INTO candidato (
            usuario_id, nombre_completo, dui, telefono,
            area_interes, creado_por, fecha_creacion
        )
        VALUES (
            p_usuario_id, p_nombre_completo, p_dui, p_telefono,
            p_area_interes, p_creado_por, NOW()
        );

        SET p_candidato_id = LAST_INSERT_ID();
        SET p_mensaje = CONCAT('Candidato registrado con ID ', p_candidato_id);
        COMMIT;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pkg_ofertas__buscar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pkg_ofertas__buscar`(
    IN p_keyword        VARCHAR(100),
    IN p_categoria_id   BIGINT,
    IN p_ubicacion      VARCHAR(100),
    IN p_salario_min    DECIMAL(10,2),
    IN p_tipo_contrato  VARCHAR(20)
)
BEGIN
    SELECT
        ev.id,
        ev.titulo,
        ev.descripcion,
        ev.salario,
        ev.ubicacion,
        ev.tipo_contrato,
        ev.nivel_experiencia,
        ev.fecha_limite,
        fn_dias_restantes_vacante(ev.id)      AS dias_restantes,
        fn_estado_vacante_label(ev.estado)    AS estado_label,
        fn_porcentaje_ocupacion_vacante(ev.id) AS pct_ocupacion,
        ee.nombre                             AS empresa,
        ec.nombre                             AS categoria
    FROM   empleos_vacante   ev
    JOIN   empleos_empresa   ee ON ee.id = ev.empresa_id
    LEFT   JOIN empleos_categoria ec ON ec.id = ev.categoria_id
    WHERE  ev.estado = 'activo'
      AND  ev.fecha_limite >= CURDATE()
      AND  (p_keyword       IS NULL OR ev.titulo    LIKE CONCAT('%', p_keyword, '%')
                                    OR ev.descripcion LIKE CONCAT('%', p_keyword, '%'))
      AND  (p_categoria_id  IS NULL OR ev.categoria_id = p_categoria_id)
      AND  (p_ubicacion     IS NULL OR ev.ubicacion LIKE CONCAT('%', p_ubicacion, '%'))
      AND  (p_salario_min   IS NULL OR ev.salario >= p_salario_min)
      AND  (p_tipo_contrato IS NULL OR ev.tipo_contrato = p_tipo_contrato)
    ORDER  BY ev.fecha_publicacion DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pkg_ofertas__dashboard_empresa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pkg_ofertas__dashboard_empresa`(
    IN p_empresa_id BIGINT
)
BEGIN
    SELECT
        ev.id                                          AS vacante_id,
        ev.titulo,
        fn_estado_vacante_label(ev.estado)             AS estado,
        ev.numero_vacantes                             AS plazas,
        fn_porcentaje_ocupacion_vacante(ev.id)         AS pct_ocupacion,
        fn_dias_restantes_vacante(ev.id)               AS dias_restantes,
        COUNT(ep.id)                                   AS total_postulaciones,
        SUM(ep.estado = 'pendiente')                   AS pendientes,
        SUM(ep.estado = 'aceptado')                    AS aceptadas,
        SUM(ep.estado = 'rechazado')                   AS rechazadas
    FROM   empleos_vacante     ev
    LEFT   JOIN empleos_postulacion ep ON ep.vacante_id = ev.id
    WHERE  ev.empresa_id = p_empresa_id
    GROUP  BY ev.id, ev.titulo, ev.estado, ev.numero_vacantes, ev.fecha_limite
    ORDER  BY ev.fecha_publicacion DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pkg_ofertas__publicar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pkg_ofertas__publicar`(
    IN  p_empresa_id        BIGINT,
    IN  p_titulo            VARCHAR(200),
    IN  p_descripcion       LONGTEXT,
    IN  p_requisitos        LONGTEXT,
    IN  p_salario           DECIMAL(10,2),
    IN  p_ubicacion         VARCHAR(150),
    IN  p_fecha_limite      DATE,
    IN  p_categoria_id      BIGINT,
    IN  p_num_vacantes      INT UNSIGNED,
    IN  p_tipo_contrato     VARCHAR(20),
    IN  p_nivel_experiencia VARCHAR(20),
    IN  p_experiencia_desc  LONGTEXT,
    IN  p_creado_por        VARCHAR(100),
    IN  p_usuario_id        INT,
    OUT p_vacante_id        BIGINT,
    OUT p_mensaje           VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 p_mensaje = MESSAGE_TEXT;
        SET p_vacante_id = -1;
        ROLLBACK;
    END;

    sp_publicar: BEGIN

    
    IF p_fecha_limite <= CURDATE() THEN
        SET p_vacante_id = 0;
        SET p_mensaje = 'La fecha límite debe ser posterior a hoy.';
        LEAVE sp_publicar;
    END IF;

    START TRANSACTION;

    INSERT INTO empleos_vacante (
        titulo, descripcion, requisitos, salario, ubicacion,
        estado, fecha_publicacion, fecha_limite,
        categoria_id, empresa_id,
        numero_vacantes, tipo_contrato, nivel_experiencia, experiencia,
        creado_por, fecha_creacion, creado_por_usuario_id
    )
    VALUES (
        p_titulo, p_descripcion, p_requisitos, p_salario, p_ubicacion,
        'activo', NOW(), p_fecha_limite,
        p_categoria_id, p_empresa_id,
        p_num_vacantes, p_tipo_contrato, p_nivel_experiencia, p_experiencia_desc,
        p_creado_por, NOW(), p_usuario_id
    );

    SET p_vacante_id = LAST_INSERT_ID();
    SET p_mensaje    = CONCAT('Vacante publicada con ID ', p_vacante_id);
    COMMIT;

    END sp_publicar;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pkg_reportes__actividad_mensual` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pkg_reportes__actividad_mensual`(
    IN p_anio  INT,
    IN p_mes   INT
)
BEGIN
    SET p_anio = IFNULL(p_anio, YEAR(CURDATE()));
    SET p_mes  = IFNULL(p_mes,  MONTH(CURDATE()));

    
    SELECT 'vacantes_publicadas' AS metrica,
           COUNT(*)              AS valor
    FROM   empleos_vacante
    WHERE  YEAR(fecha_publicacion) = p_anio
      AND  MONTH(fecha_publicacion) = p_mes

    UNION ALL

    
    SELECT 'postulaciones_recibidas',
           COUNT(*)
    FROM   empleos_postulacion
    WHERE  YEAR(fecha_postulacion) = p_anio
      AND  MONTH(fecha_postulacion) = p_mes

    UNION ALL

    
    SELECT 'candidatos_nuevos',
           COUNT(*)
    FROM   candidato
    WHERE  YEAR(fecha_creacion) = p_anio
      AND  MONTH(fecha_creacion) = p_mes

    UNION ALL

    
    SELECT 'empresas_nuevas',
           COUNT(*)
    FROM   empresa
    WHERE  YEAR(fecha_creacion) = p_anio
      AND  MONTH(fecha_creacion) = p_mes;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pkg_reportes__kpis_generales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pkg_reportes__kpis_generales`()
BEGIN
    SELECT
        (SELECT COUNT(*) FROM candidato)                         AS total_candidatos,
        (SELECT COUNT(*) FROM empresa)                           AS total_empresas,
        (SELECT COUNT(*) FROM empleos_vacante WHERE estado='activo') AS vacantes_activas,
        (SELECT COUNT(*) FROM empleos_vacante WHERE estado='cerrado') AS vacantes_cerradas,
        (SELECT COUNT(*) FROM empleos_postulacion)               AS total_postulaciones,
        (SELECT COUNT(*) FROM empleos_postulacion WHERE estado='aceptado') AS postulaciones_aceptadas,
        (SELECT ROUND(AVG(salario),2) FROM empleos_vacante
         WHERE salario IS NOT NULL AND estado='activo')          AS salario_promedio_activo,
        (SELECT COUNT(*) FROM notificacion WHERE leido=0)        AS notificaciones_pendientes;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pkg_reportes__top_candidatos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pkg_reportes__top_candidatos`(
    IN p_limite INT
)
BEGIN
    SET p_limite = IFNULL(p_limite, 10);

    SELECT
        c.candidato_id,
        c.nombre_completo,
        c.area_interes,
        fn_total_postulaciones_candidato(c.candidato_id) AS total_postulaciones,
        (SELECT COUNT(*) FROM candidato_habilidad
         WHERE candidato_id = c.candidato_id)            AS num_habilidades,
        (SELECT COUNT(*) FROM candidato_certificacion
         WHERE candidato_id = c.candidato_id)            AS num_certificaciones,
        (SELECT COUNT(*) FROM experiencia
         WHERE candidato_id = c.candidato_id)            AS num_experiencias
    FROM candidato c
    ORDER BY total_postulaciones DESC, num_habilidades DESC
    LIMIT p_limite;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_alerta_accesos_denegados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_alerta_accesos_denegados`()
BEGIN
    DECLARE v_sesiones_expiradas INT;
    DECLARE v_logs_recientes     INT;

    
    SELECT COUNT(*)
      INTO v_sesiones_expiradas
      FROM django_session
     WHERE expire_date < NOW();

    IF v_sesiones_expiradas >= 500 THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'ACCESO',
            IF(v_sesiones_expiradas >= 2000, 'CRITICO', 'WARNING'),
            CONCAT('Acumulación de sesiones expiradas: ', v_sesiones_expiradas,
                   ' registros en django_session. ',
                   'Riesgo de escalada de tamaño y vectores de ataque por sesión.'),
            JSON_OBJECT('sesiones_expiradas', v_sesiones_expiradas)
        );
    END IF;

    
    SELECT COUNT(*)
      INTO v_logs_recientes
      FROM django_admin_log
     WHERE action_time >= NOW() - INTERVAL 2 HOUR;

    IF v_logs_recientes > 200 THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'ACCESO',
            'WARNING',
            CONCAT('Actividad administrativa inusual: ', v_logs_recientes,
                   ' acciones registradas en django_admin_log en las últimas 2 horas. ',
                   'Verificar posible acceso no autorizado.'),
            JSON_OBJECT('logs_2h', v_logs_recientes)
        );
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_alerta_bloqueos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_alerta_bloqueos`()
BEGIN
    DECLARE v_count      INT;
    DECLARE v_detalle    TEXT;

    
    SELECT COUNT(*),
           GROUP_CONCAT(
               CONCAT('ID:', id, ' User:', user, ' Host:', host,
                      ' DB:', IFNULL(db,'?'), ' Time:', time, 's ',
                      ' State:', IFNULL(state,''), ' Info:', LEFT(IFNULL(info,''),80))
               ORDER BY time DESC
               SEPARATOR ' || '
           )
      INTO v_count, v_detalle
      FROM information_schema.PROCESSLIST
     WHERE command != 'Sleep'
       AND time    >= 60
       AND id      != CONNECTION_ID();

    IF v_count > 0 THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'BLOQUEO',
            IF(v_count >= 5, 'CRITICO', 'WARNING'),
            CONCAT(v_count, ' sesión(es) con queries lentos/bloqueantes (>= 60 s). ',
                   'Revisar y considerar KILL de procesos afectados.'),
            JSON_OBJECT('total_bloqueantes', v_count, 'procesos', v_detalle)
        );
    END IF;

    
    SELECT COUNT(*) INTO v_count
      FROM information_schema.INNODB_TRX
     WHERE trx_wait_started IS NOT NULL
       AND TIMESTAMPDIFF(SECOND, trx_wait_started, NOW()) >= 30;

    IF v_count > 0 THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'BLOQUEO',
            IF(v_count >= 3, 'CRITICO', 'WARNING'),
            CONCAT(v_count, ' transacción(es) InnoDB en espera de lock >= 30 s. ',
                   'Posible deadlock en curso.'),
            JSON_OBJECT('trx_en_espera', v_count)
        );
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_alerta_conexiones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_alerta_conexiones`()
BEGIN
    DECLARE v_max_conn    INT;
    DECLARE v_activas     INT;
    DECLARE v_pct         DECIMAL(5,2);
    DECLARE v_dormidas    INT;

    
    SELECT VARIABLE_VALUE INTO v_max_conn
      FROM performance_schema.global_variables
     WHERE VARIABLE_NAME = 'max_connections';

    
    SELECT COUNT(*) INTO v_activas
      FROM information_schema.PROCESSLIST;

    
    SELECT COUNT(*) INTO v_dormidas
      FROM information_schema.PROCESSLIST
     WHERE command = 'Sleep';

    SET v_pct = ROUND((v_activas / v_max_conn) * 100, 2);

    IF v_pct >= 95 THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'CONEXIONES',
            'CRITICO',
            CONCAT('Conexiones críticas: ', v_activas, ' de ', v_max_conn,
                   ' (', v_pct, '%). Riesgo de rechazo de nuevas conexiones.'),
            JSON_OBJECT('activas', v_activas, 'max', v_max_conn,
                        'porcentaje', v_pct, 'dormidas', v_dormidas)
        );
    ELSEIF v_pct >= 85 THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'CONEXIONES',
            'WARNING',
            CONCAT('Conexiones en advertencia: ', v_activas, ' de ', v_max_conn,
                   ' (', v_pct, '%). Revisar conexiones dormidas: ', v_dormidas, '.'),
            JSON_OBJECT('activas', v_activas, 'max', v_max_conn,
                        'porcentaje', v_pct, 'dormidas', v_dormidas)
        );
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_alerta_espacio_bd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_alerta_espacio_bd`()
BEGIN
    
    DECLARE v_limite_warning_mb  DECIMAL(10,2) DEFAULT 500.00;  
    DECLARE v_limite_critico_mb  DECIMAL(10,2) DEFAULT 800.00;  

    DECLARE v_total_mb  DECIMAL(10,2);
    DECLARE v_pct       DECIMAL(5,2);
    DECLARE v_nivel     VARCHAR(10);
    DECLARE v_msg       TEXT;

    
    SELECT ROUND(SUM(data_length + index_length) / 1024 / 1024, 2)
      INTO v_total_mb
      FROM information_schema.TABLES
     WHERE table_schema = 'bolsa_trabajo';

    SET v_pct = ROUND((v_total_mb / v_limite_critico_mb) * 100, 2);

    IF v_total_mb >= v_limite_critico_mb THEN
        SET v_nivel = 'CRITICO';
        SET v_msg   = CONCAT('Espacio BD crítico: ', v_total_mb, ' MB utilizados (',
                             v_pct, '% del límite de ', v_limite_critico_mb, ' MB).');
    ELSEIF v_total_mb >= v_limite_warning_mb THEN
        SET v_nivel = 'WARNING';
        SET v_pct   = ROUND((v_total_mb / v_limite_warning_mb) * 100, 2);
        SET v_msg   = CONCAT('Espacio BD en advertencia: ', v_total_mb, ' MB utilizados (',
                             v_pct, '% del límite de ', v_limite_warning_mb, ' MB).');
    ELSE
        SET v_nivel = 'INFO';
        SET v_msg   = CONCAT('Espacio BD normal: ', v_total_mb, ' MB utilizados.');
    END IF;

    
    IF v_nivel IN ('WARNING', 'CRITICO') THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'ESPACIO',
            v_nivel,
            v_msg,
            JSON_OBJECT(
                'total_mb',      v_total_mb,
                'limite_mb',     v_limite_critico_mb,
                'porcentaje',    v_pct,
                'base_datos',    'bolsa_trabajo'
            )
        );
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_alerta_fragmentacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_alerta_fragmentacion`()
BEGIN
    DECLARE v_tabla   VARCHAR(100);
    DECLARE v_pct     DECIMAL(5,2);
    DECLARE v_libre   BIGINT;
    DECLARE v_datos   BIGINT;
    DECLARE v_done    INT DEFAULT 0;

    DECLARE cur_frags CURSOR FOR
        SELECT table_name,
               data_free,
               data_length + index_length AS total_size,
               ROUND(data_free / NULLIF(data_length + index_length, 0) * 100, 2) AS pct_libre
          FROM information_schema.TABLES
         WHERE table_schema = 'bolsa_trabajo'
           AND engine       = 'InnoDB'
           AND (data_length + index_length) > 0
           AND ROUND(data_free / NULLIF(data_length + index_length, 0) * 100, 2) >= 85
         ORDER BY pct_libre DESC;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

    OPEN cur_frags;
    loop_frags: LOOP
        FETCH cur_frags INTO v_tabla, v_libre, v_datos, v_pct;
        IF v_done = 1 THEN LEAVE loop_frags; END IF;

        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'FRAGMENTACION',
            IF(v_pct >= 95, 'CRITICO', 'WARNING'),
            CONCAT('Tabla `', v_tabla, '` fragmentada al ', v_pct,
                   '%. Ejecutar: OPTIMIZE TABLE bolsa_trabajo.', v_tabla),
            JSON_OBJECT(
                'tabla',       v_tabla,
                'data_free_kb', ROUND(v_libre/1024, 1),
                'total_kb',     ROUND(v_datos/1024, 1),
                'pct_libre',    v_pct
            )
        );
    END LOOP;
    CLOSE cur_frags;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cerrar_vacantes_vencidas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cerrar_vacantes_vencidas`()
BEGIN
    DECLARE done          INT DEFAULT FALSE;
    DECLARE v_vac_id      BIGINT;
    DECLARE v_titulo      VARCHAR(200);
    DECLARE v_empresa_id  BIGINT;
    DECLARE v_total       INT DEFAULT 0;

    DECLARE cur_vacantes_vencidas CURSOR FOR
        SELECT id, titulo, empresa_id
        FROM   empleos_vacante
        WHERE  estado       = 'activo'
          AND  fecha_limite < CURDATE();

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_vacantes_vencidas;

    leer_vacantes: LOOP
        FETCH cur_vacantes_vencidas INTO v_vac_id, v_titulo, v_empresa_id;
        IF done THEN
            LEAVE leer_vacantes;
        END IF;

        UPDATE empleos_vacante
        SET    estado            = 'cerrado',
               modificado_por   = 'sp_cerrar_vacantes_vencidas',
               fecha_modificacion = NOW()
        WHERE  id = v_vac_id;

        SET v_total = v_total + 1;

    END LOOP leer_vacantes;

    CLOSE cur_vacantes_vencidas;

    
    IF v_total > 0 THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle, fecha_alerta, atendida)
        VALUES ('MANTENIMIENTO', 'INFO',
                CONCAT('Vacantes vencidas cerradas automáticamente: ', v_total),
                JSON_OBJECT('total_cerradas', v_total, 'ejecutado_por', 'sp_cerrar_vacantes_vencidas'),
                NOW(), 0);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_evaluar_todas_alertas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_evaluar_todas_alertas`()
BEGIN
    CALL sp_alerta_espacio_bd();
    CALL sp_alerta_fragmentacion();
    CALL sp_alerta_bloqueos();
    CALL sp_alerta_accesos_denegados();
    CALL sp_alerta_conexiones();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_kill_sleeping_connections` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_kill_sleeping_connections`()
BEGIN
  DECLARE done   INT DEFAULT FALSE;
  DECLARE v_id   BIGINT;

  DECLARE cur CURSOR FOR
    SELECT ID
    FROM information_schema.PROCESSLIST
    WHERE COMMAND = 'Sleep'
      AND TIME    > 600
      AND USER   <> 'event_scheduler'
      AND USER   <> 'system user';

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur;
  loop_kill: LOOP
    FETCH cur INTO v_id;
    IF done THEN LEAVE loop_kill; END IF;
    KILL CONNECTION v_id;
  END LOOP;
  CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_notificar_candidatos_inactivos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_notificar_candidatos_inactivos`()
BEGIN
    DECLARE done        INT DEFAULT FALSE;
    DECLARE v_cand_id   INT;
    DECLARE v_usr_id    INT;
    DECLARE v_nombre    VARCHAR(100);

    
    DECLARE cur_candidatos_sin_postulacion CURSOR FOR
        SELECT c.candidato_id, c.usuario_id, c.nombre_completo
        FROM   candidato c
        WHERE  c.candidato_id NOT IN (
                   SELECT DISTINCT candidato_id
                   FROM   postulacion
                   WHERE  candidato_id IS NOT NULL
               )
          AND  c.usuario_id IS NOT NULL;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_candidatos_sin_postulacion;

    leer_candidatos: LOOP
        FETCH cur_candidatos_sin_postulacion INTO v_cand_id, v_usr_id, v_nombre;
        IF done THEN
            LEAVE leer_candidatos;
        END IF;

        
        INSERT INTO notificacion (usuario_id, mensaje, fecha, leido)
        SELECT v_usr_id,
               CONCAT('Hola ', v_nombre, ', ¡hay nuevas ofertas disponibles para ti!'),
               CURDATE(),
               0
        WHERE NOT EXISTS (
            SELECT 1
            FROM   notificacion
            WHERE  usuario_id = v_usr_id
              AND  fecha      = CURDATE()
              AND  mensaje LIKE '%nuevas ofertas disponibles%'
        );

    END LOOP leer_candidatos;

    CLOSE cur_candidatos_sin_postulacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_resumen_postulaciones_empresa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_resumen_postulaciones_empresa`()
BEGIN
    DECLARE done             INT DEFAULT FALSE;
    DECLARE v_empresa        VARCHAR(100);
    DECLARE v_total_post     INT;
    DECLARE v_pendientes     INT;
    DECLARE v_aceptadas      INT;
    DECLARE v_rechazadas     INT;

    DECLARE cur_postulaciones_por_empresa CURSOR FOR
        SELECT ee.nombre                                          AS empresa,
               COUNT(ep.id)                                       AS total,
               SUM(ep.estado = 'pendiente')                       AS pendientes,
               SUM(ep.estado = 'aceptado')                        AS aceptadas,
               SUM(ep.estado = 'rechazado')                       AS rechazadas
        FROM   empleos_postulacion ep
        JOIN   empleos_vacante     ev ON ev.id        = ep.vacante_id
        JOIN   empleos_empresa     ee ON ee.id        = ev.empresa_id
        GROUP  BY ee.nombre
        ORDER  BY total DESC;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    
    DROP TEMPORARY TABLE IF EXISTS tmp_resumen_empresas;
    CREATE TEMPORARY TABLE tmp_resumen_empresas (
        empresa     VARCHAR(100),
        total       INT,
        pendientes  INT,
        aceptadas   INT,
        rechazadas  INT
    );

    OPEN cur_postulaciones_por_empresa;

    leer_empresas: LOOP
        FETCH cur_postulaciones_por_empresa
          INTO v_empresa, v_total_post, v_pendientes, v_aceptadas, v_rechazadas;
        IF done THEN
            LEAVE leer_empresas;
        END IF;

        INSERT INTO tmp_resumen_empresas
        VALUES (v_empresa, v_total_post, v_pendientes, v_aceptadas, v_rechazadas);

    END LOOP leer_empresas;

    CLOSE cur_postulaciones_por_empresa;

    SELECT * FROM tmp_resumen_empresas;
    DROP TEMPORARY TABLE IF EXISTS tmp_resumen_empresas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `bolsa_trabajo`
--

USE `bolsa_trabajo`;

--
-- Final view structure for view `vw_estado_postulaciones_vacante`
--

/*!50001 DROP VIEW IF EXISTS `vw_estado_postulaciones_vacante`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_estado_postulaciones_vacante` AS select `v`.`id` AS `vacante_id`,`v`.`titulo` AS `titulo_vacante`,`e`.`nombre` AS `empresa`,`v`.`estado` AS `estado_vacante`,`v`.`fecha_limite` AS `fecha_limite`,count(`p`.`id`) AS `total_postulaciones`,sum((`p`.`estado` = 'PENDIENTE')) AS `pendientes`,sum((`p`.`estado` = 'REVISADO')) AS `revisadas`,sum((`p`.`estado` = 'ENTREVISTA')) AS `en_entrevista`,sum((`p`.`estado` = 'ACEPTADO')) AS `aceptadas`,sum((`p`.`estado` = 'RECHAZADO')) AS `rechazadas`,max(`p`.`fecha_postulacion`) AS `ultima_postulacion` from ((`empleos_vacante` `v` join `empleos_empresa` `e` on((`e`.`id` = `v`.`empresa_id`))) left join `empleos_postulacion` `p` on((`p`.`vacante_id` = `v`.`id`))) group by `v`.`id`,`v`.`titulo`,`e`.`nombre`,`v`.`estado`,`v`.`fecha_limite` order by `total_postulaciones` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_salud_tablas`
--

/*!50001 DROP VIEW IF EXISTS `vw_salud_tablas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_salud_tablas` AS select `information_schema`.`TABLES`.`TABLE_NAME` AS `tabla`,`information_schema`.`TABLES`.`TABLE_ROWS` AS `filas_estimadas`,round((`information_schema`.`TABLES`.`DATA_LENGTH` / 1024),1) AS `datos_kb`,round((`information_schema`.`TABLES`.`INDEX_LENGTH` / 1024),1) AS `indices_kb`,round(((`information_schema`.`TABLES`.`DATA_LENGTH` + `information_schema`.`TABLES`.`INDEX_LENGTH`) / 1024),1) AS `total_kb`,round((`information_schema`.`TABLES`.`DATA_FREE` / 1024),1) AS `libre_kb`,round(((`information_schema`.`TABLES`.`DATA_FREE` / nullif((`information_schema`.`TABLES`.`DATA_LENGTH` + `information_schema`.`TABLES`.`INDEX_LENGTH`),0)) * 100),1) AS `pct_fragmentacion`,(case when (round(((`information_schema`.`TABLES`.`DATA_FREE` / nullif((`information_schema`.`TABLES`.`DATA_LENGTH` + `information_schema`.`TABLES`.`INDEX_LENGTH`),0)) * 100),1) >= 95) then '🔴 CRÍTICO' when (round(((`information_schema`.`TABLES`.`DATA_FREE` / nullif((`information_schema`.`TABLES`.`DATA_LENGTH` + `information_schema`.`TABLES`.`INDEX_LENGTH`),0)) * 100),1) >= 85) then '🟡 WARNING' else '🟢 OK' end) AS `estado`,`information_schema`.`TABLES`.`ENGINE` AS `motor`,`information_schema`.`TABLES`.`CREATE_TIME` AS `creada`,`information_schema`.`TABLES`.`UPDATE_TIME` AS `ultima_modificacion` from `information_schema`.`TABLES` where (`information_schema`.`TABLES`.`TABLE_SCHEMA` = 'bolsa_trabajo') order by round(((`information_schema`.`TABLES`.`DATA_FREE` / nullif((`information_schema`.`TABLES`.`DATA_LENGTH` + `information_schema`.`TABLES`.`INDEX_LENGTH`),0)) * 100),1) desc,round(((`information_schema`.`TABLES`.`DATA_LENGTH` + `information_schema`.`TABLES`.`INDEX_LENGTH`) / 1024),1) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_top10_queries_costosos`
--

/*!50001 DROP VIEW IF EXISTS `vw_top10_queries_costosos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_top10_queries_costosos` AS select `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR` AS `ejecuciones`,round((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_EXAMINED` / `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`),0) AS `filas_examinadas_prom`,round((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_SENT` / `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`),0) AS `filas_enviadas_prom`,round((((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_EXAMINED` - `performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_SENT`) / nullif(`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_EXAMINED`,0)) * 100),1) AS `pct_desperdicio`,round((`performance_schema`.`events_statements_summary_by_digest`.`SUM_TIMER_WAIT` / 1e12),4) AS `tiempo_total_seg`,left(`performance_schema`.`events_statements_summary_by_digest`.`DIGEST_TEXT`,200) AS `query_resumen`,`performance_schema`.`events_statements_summary_by_digest`.`LAST_SEEN` AS `ultima_ejecucion` from `performance_schema`.`events_statements_summary_by_digest` where ((`performance_schema`.`events_statements_summary_by_digest`.`SCHEMA_NAME` = 'bolsa_trabajo') and (`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR` > 0) and (`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_EXAMINED` > 0)) order by `filas_examinadas_prom` desc limit 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_top10_queries_lentos`
--

/*!50001 DROP VIEW IF EXISTS `vw_top10_queries_lentos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_top10_queries_lentos` AS select round((`performance_schema`.`events_statements_summary_by_digest`.`AVG_TIMER_WAIT` / 1e12),4) AS `avg_seg`,round((`performance_schema`.`events_statements_summary_by_digest`.`MAX_TIMER_WAIT` / 1e12),4) AS `max_seg`,`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR` AS `ejecuciones`,round((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_EXAMINED` / `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`),0) AS `filas_examinadas_prom`,round((`performance_schema`.`events_statements_summary_by_digest`.`SUM_ROWS_SENT` / `performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR`),0) AS `filas_enviadas_prom`,left(`performance_schema`.`events_statements_summary_by_digest`.`DIGEST_TEXT`,200) AS `query_resumen`,`performance_schema`.`events_statements_summary_by_digest`.`SCHEMA_NAME` AS `base_datos`,`performance_schema`.`events_statements_summary_by_digest`.`LAST_SEEN` AS `ultima_ejecucion` from `performance_schema`.`events_statements_summary_by_digest` where ((`performance_schema`.`events_statements_summary_by_digest`.`SCHEMA_NAME` = 'bolsa_trabajo') and (`performance_schema`.`events_statements_summary_by_digest`.`COUNT_STAR` > 0)) order by `performance_schema`.`events_statements_summary_by_digest`.`AVG_TIMER_WAIT` desc limit 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_top10_usuarios_sesiones`
--

/*!50001 DROP VIEW IF EXISTS `vw_top10_usuarios_sesiones`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_top10_usuarios_sesiones` AS select `p`.`USER` AS `usuario`,`p`.`HOST` AS `host_cliente`,count(0) AS `sesiones_totales`,sum((`p`.`COMMAND` = 'Sleep')) AS `sesiones_dormidas`,sum((`p`.`COMMAND` <> 'Sleep')) AS `sesiones_activas`,max(`p`.`TIME`) AS `tiempo_max_seg`,round(avg(`p`.`TIME`),1) AS `tiempo_prom_seg` from `information_schema`.`PROCESSLIST` `p` where (`p`.`USER` is not null) group by `p`.`USER`,`p`.`HOST` order by `sesiones_totales` desc limit 10 */;
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

-- Dump completed on 2026-06-06 15:47:48
