/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.0.2-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: bolsa_trabajo
-- ------------------------------------------------------
-- Server version	12.0.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_audit_auth_user_insert
BEFORE INSERT ON auth_user
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_auth_user_insert
AFTER INSERT ON auth_user
FOR EACH ROW
INSERT INTO hist_auth_user (accion, fecha_accion, usuario_accion, user_id, username, email, is_active, is_superuser, creado_por, fecha_creacion)
VALUES ('INSERT', NOW(), USER(), NEW.id, NEW.username, NEW.email, NEW.is_active, NEW.is_superuser, NEW.creado_por, NEW.fecha_creacion) */;;
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_audit_auth_user_update
BEFORE UPDATE ON auth_user
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_auth_user_update
AFTER UPDATE ON auth_user
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_auth_user_delete
BEFORE DELETE ON auth_user
FOR EACH ROW
BEGIN
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `candidato`
--

DROP TABLE IF EXISTS `candidato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidato` (
  `candidato_id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `candidato_certificacion`
--

DROP TABLE IF EXISTS `candidato_certificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidato_certificacion` (
  `candidato_id` int(11) NOT NULL,
  `certificacion_id` int(11) NOT NULL,
  `institucion` varchar(100) DEFAULT NULL,
  `fecha_obtencion` date DEFAULT NULL,
  PRIMARY KEY (`candidato_id`,`certificacion_id`),
  KEY `certificacion_id` (`certificacion_id`),
  CONSTRAINT `candidato_certificacion_ibfk_1` FOREIGN KEY (`candidato_id`) REFERENCES `candidato` (`candidato_id`),
  CONSTRAINT `candidato_certificacion_ibfk_2` FOREIGN KEY (`certificacion_id`) REFERENCES `certificacion` (`certificacion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `candidato_habilidad`
--

DROP TABLE IF EXISTS `candidato_habilidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidato_habilidad` (
  `candidato_id` int(11) NOT NULL,
  `habilidad_id` int(11) NOT NULL,
  PRIMARY KEY (`candidato_id`,`habilidad_id`),
  KEY `habilidad_id` (`habilidad_id`),
  CONSTRAINT `candidato_habilidad_ibfk_1` FOREIGN KEY (`candidato_id`) REFERENCES `candidato` (`candidato_id`),
  CONSTRAINT `candidato_habilidad_ibfk_2` FOREIGN KEY (`habilidad_id`) REFERENCES `habilidad` (`habilidad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `certificacion`
--

DROP TABLE IF EXISTS `certificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `certificacion` (
  `certificacion_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`certificacion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleos_candidato`
--

DROP TABLE IF EXISTS `empleos_candidato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_candidato` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `telefono` varchar(20) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `curriculum` varchar(100) DEFAULT NULL,
  `experiencia` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `area_interes` varchar(100) NOT NULL,
  `dui` varchar(20) NOT NULL,
  `estudios` longtext NOT NULL,
  `habilidades` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `empleos_candidato_user_id_8723dcc4_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_audit_candidato_django_insert
BEFORE INSERT ON empleos_candidato
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_candidato_django_insert
AFTER INSERT ON empleos_candidato
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_audit_candidato_django_update
BEFORE UPDATE ON empleos_candidato
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_candidato_django_update
AFTER UPDATE ON empleos_candidato
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_candidato_django_delete
BEFORE DELETE ON empleos_candidato
FOR EACH ROW
BEGIN
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_candidato_categorias_interes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `candidato_id` bigint(20) NOT NULL,
  `categoria_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `empleos_candidato_catego_candidato_id_categoria_i_5b8dbe3b_uniq` (`candidato_id`,`categoria_id`),
  KEY `empleos_candidato_ca_categoria_id_6aa6e2e9_fk_empleos_c` (`categoria_id`),
  CONSTRAINT `empleos_candidato_ca_candidato_id_15936366_fk_empleos_c` FOREIGN KEY (`candidato_id`) REFERENCES `empleos_candidato` (`id`),
  CONSTRAINT `empleos_candidato_ca_categoria_id_6aa6e2e9_fk_empleos_c` FOREIGN KEY (`categoria_id`) REFERENCES `empleos_categoria` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleos_categoria`
--

DROP TABLE IF EXISTS `empleos_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_categoria` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleos_empresa`
--

DROP TABLE IF EXISTS `empleos_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_empresa` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `descripcion` longtext NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(254) NOT NULL,
  `sitio_web` varchar(200) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `persona_contacto` varchar(100) NOT NULL,
  `sector` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_audit_empresa_django_insert
BEFORE INSERT ON empleos_empresa
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_empresa_django_insert
AFTER INSERT ON empleos_empresa
FOR EACH ROW
INSERT INTO hist_empleos_empresa (accion, fecha_accion, usuario_accion, empresa_id, nombre, correo, telefono, direccion, creado_por, fecha_creacion)
VALUES ('INSERT', NOW(), USER(), NEW.id, NEW.nombre, NEW.correo, NEW.telefono, NEW.direccion, NEW.creado_por, NEW.fecha_creacion) */;;
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_audit_empresa_django_update
BEFORE UPDATE ON empleos_empresa
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_empresa_django_update
AFTER UPDATE ON empleos_empresa
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_empresa_django_delete
BEFORE DELETE ON empleos_empresa
FOR EACH ROW
BEGIN
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_notificacion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) NOT NULL,
  `mensaje` longtext NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `leida` tinyint(1) NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  `url` varchar(500) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `empleos_notificacion_usuario_id_25b4d707_fk_auth_user_id` (`usuario_id`),
  CONSTRAINT `empleos_notificacion_usuario_id_25b4d707_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleos_perfil`
--

DROP TABLE IF EXISTS `empleos_perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_perfil` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo_usuario` varchar(20) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `empleos_perfil_usuario_id_b6d218c9_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleos_postulacion`
--

DROP TABLE IF EXISTS `empleos_postulacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_postulacion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fecha_postulacion` datetime(6) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `mensaje` longtext DEFAULT NULL,
  `candidato_id` bigint(20) NOT NULL,
  `vacante_id` bigint(20) NOT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `empleos_postulacion_candidato_id_cf1d1c6b_fk_empleos_c` (`candidato_id`),
  KEY `empleos_postulacion_vacante_id_7435057a_fk_empleos_vacante_id` (`vacante_id`),
  CONSTRAINT `empleos_postulacion_candidato_id_cf1d1c6b_fk_empleos_c` FOREIGN KEY (`candidato_id`) REFERENCES `empleos_candidato` (`id`),
  CONSTRAINT `empleos_postulacion_vacante_id_7435057a_fk_empleos_vacante_id` FOREIGN KEY (`vacante_id`) REFERENCES `empleos_vacante` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_audit_postulacion_django_insert
BEFORE INSERT ON empleos_postulacion
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_postulacion_django_insert
AFTER INSERT ON empleos_postulacion
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_audit_postulacion_django_update
BEFORE UPDATE ON empleos_postulacion
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_postulacion_django_update
AFTER UPDATE ON empleos_postulacion
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_postulacion_django_delete
BEFORE DELETE ON empleos_postulacion
FOR EACH ROW
BEGIN
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleos_vacante` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) NOT NULL,
  `descripcion` longtext NOT NULL,
  `requisitos` longtext NOT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `ubicacion` varchar(150) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `fecha_publicacion` datetime(6) NOT NULL,
  `fecha_limite` date NOT NULL,
  `categoria_id` bigint(20) DEFAULT NULL,
  `empresa_id` bigint(20) NOT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `experiencia` longtext NOT NULL,
  `numero_vacantes` int(10) unsigned NOT NULL CHECK (`numero_vacantes` >= 0),
  `tipo_contrato` varchar(20) NOT NULL,
  `creado_por_usuario_id` int(11) DEFAULT NULL,
  `nivel_experiencia` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `empleos_vacante_categoria_id_c8fb8377_fk_empleos_categoria_id` (`categoria_id`),
  KEY `empleos_vacante_empresa_id_1d7a0103_fk_empleos_empresa_id` (`empresa_id`),
  KEY `empleos_vacante_creado_por_usuario_id_fb50df63_fk_auth_user_id` (`creado_por_usuario_id`),
  CONSTRAINT `empleos_vacante_categoria_id_c8fb8377_fk_empleos_categoria_id` FOREIGN KEY (`categoria_id`) REFERENCES `empleos_categoria` (`id`),
  CONSTRAINT `empleos_vacante_creado_por_usuario_id_fb50df63_fk_auth_user_id` FOREIGN KEY (`creado_por_usuario_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `empleos_vacante_empresa_id_1d7a0103_fk_empleos_empresa_id` FOREIGN KEY (`empresa_id`) REFERENCES `empleos_empresa` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_audit_vacante_django_insert
BEFORE INSERT ON empleos_vacante
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_vacante_django_insert
AFTER INSERT ON empleos_vacante
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_audit_vacante_django_update
BEFORE UPDATE ON empleos_vacante
FOR EACH ROW
BEGIN
  
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_vacante_django_update
AFTER UPDATE ON empleos_vacante
FOR EACH ROW
BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`django_user`@`localhost`*/ /*!50003 TRIGGER trg_hist_vacante_django_delete
BEFORE DELETE ON empleos_vacante
FOR EACH ROW
BEGIN
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresa` (
  `empresa_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `persona_contacto` varchar(100) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `sector_id` int(11) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`empresa_id`),
  KEY `sector_id` (`sector_id`),
  CONSTRAINT `empresa_ibfk_1` FOREIGN KEY (`sector_id`) REFERENCES `sector` (`sector_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estado_postulacion`
--

DROP TABLE IF EXISTS `estado_postulacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_postulacion` (
  `estado_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`estado_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `experiencia`
--

DROP TABLE IF EXISTS `experiencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `experiencia` (
  `experiencia_id` int(11) NOT NULL AUTO_INCREMENT,
  `candidato_id` int(11) DEFAULT NULL,
  `empresa` varchar(100) DEFAULT NULL,
  `puesto` varchar(50) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  PRIMARY KEY (`experiencia_id`),
  KEY `candidato_id` (`candidato_id`),
  CONSTRAINT `experiencia_ibfk_1` FOREIGN KEY (`candidato_id`) REFERENCES `candidato` (`candidato_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formacion_academica`
--

DROP TABLE IF EXISTS `formacion_academica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `formacion_academica` (
  `formacion_id` int(11) NOT NULL AUTO_INCREMENT,
  `candidato_id` int(11) DEFAULT NULL,
  `institucion` varchar(100) DEFAULT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  PRIMARY KEY (`formacion_id`),
  KEY `candidato_id` (`candidato_id`),
  CONSTRAINT `formacion_academica_ibfk_1` FOREIGN KEY (`candidato_id`) REFERENCES `candidato` (`candidato_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `habilidad`
--

DROP TABLE IF EXISTS `habilidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `habilidad` (
  `habilidad_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`habilidad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hist_auth_user`
--

DROP TABLE IF EXISTS `hist_auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hist_auth_user` (
  `hist_id` int(11) NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) NOT NULL COMMENT 'UPDATE o DELETE',
  `fecha_accion` datetime NOT NULL DEFAULT current_timestamp(),
  `usuario_accion` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_superuser` tinyint(1) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hist_empleos_candidato`
--

DROP TABLE IF EXISTS `hist_empleos_candidato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hist_empleos_candidato` (
  `hist_id` int(11) NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) NOT NULL,
  `fecha_accion` datetime NOT NULL DEFAULT current_timestamp(),
  `usuario_accion` varchar(100) DEFAULT NULL,
  `candidato_id` bigint(20) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `experiencia` text DEFAULT NULL,
  `dui` varchar(20) DEFAULT NULL,
  `area_interes` varchar(100) DEFAULT NULL,
  `estudios` text DEFAULT NULL,
  `habilidades` text DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hist_empleos_empresa`
--

DROP TABLE IF EXISTS `hist_empleos_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hist_empleos_empresa` (
  `hist_id` int(11) NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) NOT NULL,
  `fecha_accion` datetime NOT NULL DEFAULT current_timestamp(),
  `usuario_accion` varchar(100) DEFAULT NULL,
  `empresa_id` bigint(20) DEFAULT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `correo` varchar(254) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hist_empleos_postulacion`
--

DROP TABLE IF EXISTS `hist_empleos_postulacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hist_empleos_postulacion` (
  `hist_id` int(11) NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) NOT NULL,
  `fecha_accion` datetime NOT NULL DEFAULT current_timestamp(),
  `usuario_accion` varchar(100) DEFAULT NULL,
  `postulacion_id` bigint(20) DEFAULT NULL,
  `candidato_id` bigint(20) DEFAULT NULL,
  `vacante_id` bigint(20) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  `fecha_postulacion` datetime(6) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hist_empleos_vacante`
--

DROP TABLE IF EXISTS `hist_empleos_vacante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hist_empleos_vacante` (
  `hist_id` int(11) NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) NOT NULL,
  `fecha_accion` datetime NOT NULL DEFAULT current_timestamp(),
  `usuario_accion` varchar(100) DEFAULT NULL,
  `vacante_id` bigint(20) DEFAULT NULL,
  `titulo` varchar(200) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `requisitos` longtext DEFAULT NULL,
  `experiencia` longtext DEFAULT NULL,
  `tipo_contrato` varchar(20) DEFAULT NULL,
  `numero_vacantes` int(11) DEFAULT NULL,
  `categoria_id` bigint(20) DEFAULT NULL,
  `empresa_id` bigint(20) DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `ubicacion` varchar(150) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `fecha_limite` date DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notificacion`
--

DROP TABLE IF EXISTS `notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificacion` (
  `notificacion_id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) DEFAULT NULL,
  `mensaje` varchar(255) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `leido` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`notificacion_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `notificacion_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oferta`
--

DROP TABLE IF EXISTS `oferta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oferta` (
  `oferta_id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) DEFAULT NULL,
  `puesto` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `requisitos` text DEFAULT NULL,
  `experiencia_requerida` varchar(100) DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `tipo_contrato` varchar(50) DEFAULT NULL,
  `vacantes` int(11) DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `fecha_limite` date DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`oferta_id`),
  KEY `empresa_id` (`empresa_id`),
  CONSTRAINT `oferta_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresa` (`empresa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `postulacion`
--

DROP TABLE IF EXISTS `postulacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `postulacion` (
  `postulacion_id` int(11) NOT NULL AUTO_INCREMENT,
  `candidato_id` int(11) DEFAULT NULL,
  `oferta_id` int(11) DEFAULT NULL,
  `estado_id` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sector`
--

DROP TABLE IF EXISTS `sector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sector` (
  `sector_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`sector_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_usuario`
--

DROP TABLE IF EXISTS `tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_usuario` (
  `tipo_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`tipo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `usuario_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasenia` varchar(255) NOT NULL,
  `tipo_id` int(11) NOT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`usuario_id`),
  UNIQUE KEY `correo` (`correo`),
  KEY `tipo_id` (`tipo_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_usuario` (`tipo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'bolsa_trabajo'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `job_actualizar_estadisticas` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `job_actualizar_estadisticas` ON SCHEDULE EVERY 1 DAY STARTS '2026-06-03 04:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  ANALYZE TABLE usuarios;
  ANALYZE TABLE candidato;
  ANALYZE TABLE oferta;
  ANALYZE TABLE postulacion;
  ANALYZE TABLE empresa;
  ANALYZE TABLE notificacion;
  ANALYZE TABLE hist_auth_user;
  ANALYZE TABLE hist_empleos_empresa;
  ANALYZE TABLE hist_empleos_vacante;
  ANALYZE TABLE hist_empleos_candidato;
  ANALYZE TABLE hist_empleos_postulacion;
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `job_matar_conexiones_dormidas` ON SCHEDULE EVERY 30 MINUTE STARTS '2026-06-02 14:02:04' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `job_optimizar_tablas` ON SCHEDULE EVERY 1 WEEK STARTS '2026-06-07 03:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  OPTIMIZE TABLE notificacion;
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `job_purgar_historicos` ON SCHEDULE EVERY 1 MONTH STARTS '2026-07-01 02:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  DELETE FROM hist_auth_user            WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_empleos_empresa      WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_empleos_vacante      WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_empleos_candidato    WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_empleos_postulacion  WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `job_purgar_notificaciones` ON SCHEDULE EVERY 1 DAY STARTS '2026-06-03 01:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  DELETE FROM notificacion
  WHERE leido = 1
    AND fecha < (CURDATE() - INTERVAL 60 DAY);
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
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_kill_sleeping_connections` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-06-04 19:38:58
