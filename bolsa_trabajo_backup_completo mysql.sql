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
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `auth_permission` VALUES
(1,'Can add categoria',1,'add_categoria'),
(2,'Can change categoria',1,'change_categoria'),
(3,'Can delete categoria',1,'delete_categoria'),
(4,'Can view categoria',1,'view_categoria'),
(5,'Can add empresa',2,'add_empresa'),
(6,'Can change empresa',2,'change_empresa'),
(7,'Can delete empresa',2,'delete_empresa'),
(8,'Can view empresa',2,'view_empresa'),
(9,'Can add candidato',3,'add_candidato'),
(10,'Can change candidato',3,'change_candidato'),
(11,'Can delete candidato',3,'delete_candidato'),
(12,'Can view candidato',3,'view_candidato'),
(13,'Can add perfil',4,'add_perfil'),
(14,'Can change perfil',4,'change_perfil'),
(15,'Can delete perfil',4,'delete_perfil'),
(16,'Can view perfil',4,'view_perfil'),
(17,'Can add vacante',5,'add_vacante'),
(18,'Can change vacante',5,'change_vacante'),
(19,'Can delete vacante',5,'delete_vacante'),
(20,'Can view vacante',5,'view_vacante'),
(21,'Can add postulacion',6,'add_postulacion'),
(22,'Can change postulacion',6,'change_postulacion'),
(23,'Can delete postulacion',6,'delete_postulacion'),
(24,'Can view postulacion',6,'view_postulacion'),
(25,'Can add log entry',7,'add_logentry'),
(26,'Can change log entry',7,'change_logentry'),
(27,'Can delete log entry',7,'delete_logentry'),
(28,'Can view log entry',7,'view_logentry'),
(29,'Can add permission',8,'add_permission'),
(30,'Can change permission',8,'change_permission'),
(31,'Can delete permission',8,'delete_permission'),
(32,'Can view permission',8,'view_permission'),
(33,'Can add group',9,'add_group'),
(34,'Can change group',9,'change_group'),
(35,'Can delete group',9,'delete_group'),
(36,'Can view group',9,'view_group'),
(37,'Can add user',10,'add_user'),
(38,'Can change user',10,'change_user'),
(39,'Can delete user',10,'delete_user'),
(40,'Can view user',10,'view_user'),
(41,'Can add content type',11,'add_contenttype'),
(42,'Can change content type',11,'change_contenttype'),
(43,'Can delete content type',11,'delete_contenttype'),
(44,'Can view content type',11,'view_contenttype'),
(45,'Can add session',12,'add_session'),
(46,'Can change session',12,'change_session'),
(47,'Can delete session',12,'delete_session'),
(48,'Can view session',12,'view_session'),
(49,'Can add notificacion',13,'add_notificacion'),
(50,'Can change notificacion',13,'change_notificacion'),
(51,'Can delete notificacion',13,'delete_notificacion'),
(52,'Can view notificacion',13,'view_notificacion');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `auth_user` VALUES
(1,'pbkdf2_sha256$720000$XaP8tLQIS5sxWrmgqORKWE$R0SvcebBsss1qBobGvcpp2wmykWdZgAoAEOtiu4eXUE=','2026-06-04 18:42:24.611370',1,'admin','','','admin@example.com',1,1,'2026-06-02 21:10:06.174440','system','2026-06-02 15:11:31','django_user@localhost','2026-06-04 12:42:24'),
(2,'pbkdf2_sha256$720000$LC6vp4TVm1c3xOuSimGVUv$jpB94lAUew+nhRRgoXgt9Jx1C55trrnb5hBXUsu/NV8=','2026-06-02 21:55:39.361425',0,'Juanito','Juan Alberto Perez Ortiz','','Juanperez@gmail.com',0,1,'2026-06-02 21:27:11.244596','django_user@localhost','2026-06-02 15:27:11','django_user@localhost','2026-06-02 15:55:39'),
(3,'pbkdf2_sha256$720000$wQrBRL3kLCDguRO8DCrOqG$gUpHSdYy72aQ96/HcPjAloDzN+JYtmT4x65jyR0HLIQ=','2026-06-04 17:47:51.965308',0,'TECNASA','TECNASA','','tecnasa.rrhh@gmail.com',0,1,'2026-06-03 02:15:56.556383','django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-04 11:47:51'),
(4,'pbkdf2_sha256$720000$Pwqeyt3sQhkbIfbh4pOopb$wMEUqKfLHV8xyXpI8yTOettWLPc/48ENC19vLj2ITZ8=','2026-06-04 17:43:35.513537',0,'Kevin','Kevin Durazno','','kevin@gmail.com',0,1,'2026-06-03 19:25:56.412898','django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-04 11:43:35');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidato`
--

LOCK TABLES `candidato` WRITE;
/*!40000 ALTER TABLE `candidato` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `candidato` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidato_certificacion`
--

LOCK TABLES `candidato_certificacion` WRITE;
/*!40000 ALTER TABLE `candidato_certificacion` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `candidato_certificacion` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidato_habilidad`
--

LOCK TABLES `candidato_habilidad` WRITE;
/*!40000 ALTER TABLE `candidato_habilidad` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `candidato_habilidad` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificacion`
--

LOCK TABLES `certificacion` WRITE;
/*!40000 ALTER TABLE `certificacion` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `certificacion` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `django_content_type` VALUES
(7,'admin','logentry'),
(9,'auth','group'),
(8,'auth','permission'),
(10,'auth','user'),
(11,'contenttypes','contenttype'),
(3,'empleos','candidato'),
(1,'empleos','categoria'),
(2,'empleos','empresa'),
(13,'empleos','notificacion'),
(4,'empleos','perfil'),
(6,'empleos','postulacion'),
(5,'empleos','vacante'),
(12,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `django_migrations` VALUES
(21,'contenttypes','0001_initial','2026-06-02 21:09:35.804804'),
(22,'auth','0001_initial','2026-06-02 21:09:37.379046'),
(23,'admin','0001_initial','2026-06-02 21:09:37.658838'),
(24,'admin','0002_logentry_remove_auto_add','2026-06-02 21:09:37.682109'),
(25,'admin','0003_logentry_add_action_flag_choices','2026-06-02 21:09:37.701324'),
(26,'contenttypes','0002_remove_content_type_name','2026-06-02 21:09:37.903518'),
(27,'auth','0002_alter_permission_name_max_length','2026-06-02 21:09:38.028722'),
(28,'auth','0003_alter_user_email_max_length','2026-06-02 21:09:38.118549'),
(29,'auth','0004_alter_user_username_opts','2026-06-02 21:09:38.148542'),
(30,'auth','0005_alter_user_last_login_null','2026-06-02 21:09:38.288869'),
(31,'auth','0006_require_contenttypes_0002','2026-06-02 21:09:38.295295'),
(32,'auth','0007_alter_validators_add_error_messages','2026-06-02 21:09:38.313218'),
(33,'auth','0008_alter_user_username_max_length','2026-06-02 21:09:38.398818'),
(34,'auth','0009_alter_user_last_name_max_length','2026-06-02 21:09:38.490442'),
(35,'auth','0010_alter_group_name_max_length','2026-06-02 21:09:38.579879'),
(36,'auth','0011_update_proxy_permissions','2026-06-02 21:09:38.594935'),
(37,'auth','0012_alter_user_first_name_max_length','2026-06-02 21:09:38.689415'),
(38,'empleos','0001_initial','2026-06-02 21:09:39.689112'),
(39,'sessions','0001_initial','2026-06-02 21:09:39.855647'),
(40,'empleos','0002_candidato_area_interes_candidato_dui_and_more','2026-06-03 02:11:31.964078'),
(41,'empleos','0003_vacante_experiencia_vacante_numero_vacantes_and_more','2026-06-03 17:06:14.531649'),
(42,'empleos','0004_vacante_creado_por_usuario','2026-06-03 17:34:35.626089'),
(43,'empleos','0005_vacante_nivel_experiencia','2026-06-03 19:12:06.968842'),
(44,'empleos','0006_alter_postulacion_estado','2026-06-03 20:55:06.324361'),
(45,'empleos','0007_candidato_categorias_interes_notificacion','2026-06-04 16:34:32.165228'),
(46,'empleos','0008_alter_postulacion_estado','2026-06-04 17:17:57.647766');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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

--
-- Dumping data for table `empleos_candidato`
--

LOCK TABLES `empleos_candidato` WRITE;
/*!40000 ALTER TABLE `empleos_candidato` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `empleos_candidato` VALUES
(1,'76534231','','','Mi primera chamba',4,NULL,NULL,NULL,NULL,'Educacion','088972131','Universidad','Aprendo rapido');
/*!40000 ALTER TABLE `empleos_candidato` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `empleos_candidato_categorias_interes`
--

LOCK TABLES `empleos_candidato_categorias_interes` WRITE;
/*!40000 ALTER TABLE `empleos_candidato_categorias_interes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `empleos_candidato_categorias_interes` VALUES
(1,1,11);
/*!40000 ALTER TABLE `empleos_candidato_categorias_interes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `empleos_categoria`
--

LOCK TABLES `empleos_categoria` WRITE;
/*!40000 ALTER TABLE `empleos_categoria` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `empleos_categoria` VALUES
(1,'Desarrollo Web'),
(2,'Data Science'),
(3,'Diseño UX/UI'),
(4,'Marketing Digital'),
(5,'Recursos Humanos'),
(6,'Tecnología y Software'),
(7,'Contabilidad y Finanzas'),
(8,'Ingeniería'),
(9,'Salud'),
(10,'Educación'),
(11,'Ventas'),
(12,'Diseño Gráfico'),
(13,'Atención al Cliente'),
(14,'Logística y Transporte'),
(15,'Legal'),
(16,'Construcción'),
(17,'Alimentación y Gastronomía'),
(18,'Turismo y Hotelería'),
(19,'Medio Ambiente'),
(20,'Comunicación y Medios'),
(21,'Investigación'),
(22,'Administración'),
(23,'Artes y Cultura');
/*!40000 ALTER TABLE `empleos_categoria` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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

--
-- Dumping data for table `empleos_empresa`
--

LOCK TABLES `empleos_empresa` WRITE;
/*!40000 ALTER TABLE `empleos_empresa` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `empleos_empresa` VALUES
(1,'Tech Solutions SV','Empresa líder en soluciones tecnológicas en El Salvador','San Salvador, El Salvador','2222-3333','info@techsolutions.com.sv',NULL,'system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:11:31','',''),
(2,'TECNASA','','San Salvador Centro','23421332','tecnasa.rrhh@gmail.com',NULL,'django_user@localhost','2026-06-02 20:15:56',NULL,NULL,'Ing Quintana','Tecnologia');
/*!40000 ALTER TABLE `empleos_empresa` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `empleos_notificacion`
--

LOCK TABLES `empleos_notificacion` WRITE;
/*!40000 ALTER TABLE `empleos_notificacion` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `empleos_notificacion` VALUES
(1,'Nueva oferta en Ventas','Se publicó una nueva oferta: \"PRUEBAAA\" en Santa Ana. ¡Echa un vistazo!','NUEVO_EMPLEO',1,'2026-06-04 17:39:06.940636','/empleo/10/',4),
(2,'Cambio de estado en tu postulación','Tu postulación para \"PRUEBAAA\" está siendo revisada.','CAMBIO_ESTADO',0,'2026-06-04 17:43:26.728310','/mis-postulaciones/',4);
/*!40000 ALTER TABLE `empleos_notificacion` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `empleos_perfil`
--

LOCK TABLES `empleos_perfil` WRITE;
/*!40000 ALTER TABLE `empleos_perfil` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `empleos_perfil` VALUES
(1,'empresa',1),
(2,'candidato',2),
(3,'empresa',3),
(4,'candidato',4);
/*!40000 ALTER TABLE `empleos_perfil` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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

--
-- Dumping data for table `empleos_postulacion`
--

LOCK TABLES `empleos_postulacion` WRITE;
/*!40000 ALTER TABLE `empleos_postulacion` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `empleos_postulacion` VALUES
(1,'2026-06-03 19:45:14.846821','PENDIENTE','',1,1,NULL,NULL,NULL,NULL),
(2,'2026-06-03 19:48:58.623336','RECHAZADO','',1,9,NULL,NULL,NULL,NULL),
(3,'2026-06-04 16:32:35.211481','PENDIENTE','',1,2,NULL,NULL,NULL,NULL),
(4,'2026-06-04 17:42:43.833271','EN_REVISION','',1,10,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `empleos_postulacion` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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

--
-- Dumping data for table `empleos_vacante`
--

LOCK TABLES `empleos_vacante` WRITE;
/*!40000 ALTER TABLE `empleos_vacante` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `empleos_vacante` VALUES
(1,'Desarrollador Frontend React','Buscamos desarrollador frontend con experiencia en React y Tailwind CSS.','Experiencia comprobable',2500.00,'San Salvador','ACTIVA','2026-06-02 21:10:06.454966','2026-07-01',1,1,'system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:43:21','',1,'TIEMPO_COMPLETO',NULL,'SIN_EXPERIENCIA'),
(2,'Analista de Datos','Analista de datos con experiencia en Python y SQL.','Experiencia comprobable',2000.00,'Remoto','ACTIVA','2026-06-02 21:10:06.464945','2026-07-15',2,1,'system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:11:31','',1,'TIEMPO_COMPLETO',NULL,'SIN_EXPERIENCIA'),
(3,'Diseñador UX/UI','Diseñador UX/UI con experiencia en Figma.','Experiencia comprobable',1800.00,'Santa Tecla','ACTIVA','2026-06-02 21:10:06.472925','2026-06-30',3,1,'system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:11:31','',1,'TIEMPO_COMPLETO',NULL,'SIN_EXPERIENCIA'),
(4,'Developer Jr.','Conocimientos basicos ','',650.00,'San Miguel','ACTIVA','2026-06-02 21:25:50.854068','2026-06-10',1,1,'django_user@localhost','2026-06-02 15:25:50',NULL,NULL,'',1,'TIEMPO_COMPLETO',NULL,'SIN_EXPERIENCIA'),
(5,'Nueva vacante para test INSERT trigger','Test INSERT trigger','Test',5000.00,'San Miguel','ACTIVA','2026-06-02 21:44:19.953202','2026-08-01',1,1,'django_user@localhost','2026-06-02 15:44:19',NULL,NULL,'',1,'TIEMPO_COMPLETO',NULL,'SIN_EXPERIENCIA'),
(6,'Prueba 2','Prueba','',1000.00,'San Jose','ACTIVA','2026-06-02 21:47:52.430563','2026-06-11',2,1,'django_user@localhost','2026-06-02 15:47:52',NULL,NULL,'',1,'TIEMPO_COMPLETO',NULL,'SIN_EXPERIENCIA'),
(9,'Recepcionista','Recepcion de documentos','Dos años de experiencia, servicial, buena disposicion, buena presentacion personal.',600.00,'Morazan','ACTIVA','2026-06-03 19:48:34.089568','2026-06-10',5,2,'TECNASA','2026-06-03 13:48:34',NULL,NULL,'',1,'TEMPORAL',3,'JUNIOR'),
(10,'PRUEBAAA','PRUEBA','Prueba',300.00,'Santa Ana','ACTIVA','2026-06-04 17:39:06.879257','2026-06-17',11,2,'TECNASA','2026-06-04 11:39:06',NULL,NULL,'',1,'PRACTICAS',3,'SIN_EXPERIENCIA');
/*!40000 ALTER TABLE `empleos_vacante` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_postulacion`
--

LOCK TABLES `estado_postulacion` WRITE;
/*!40000 ALTER TABLE `estado_postulacion` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `estado_postulacion` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiencia`
--

LOCK TABLES `experiencia` WRITE;
/*!40000 ALTER TABLE `experiencia` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `experiencia` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formacion_academica`
--

LOCK TABLES `formacion_academica` WRITE;
/*!40000 ALTER TABLE `formacion_academica` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formacion_academica` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habilidad`
--

LOCK TABLES `habilidad` WRITE;
/*!40000 ALTER TABLE `habilidad` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `habilidad` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hist_auth_user`
--

LOCK TABLES `hist_auth_user` WRITE;
/*!40000 ALTER TABLE `hist_auth_user` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `hist_auth_user` VALUES
(1,'UPDATE','2026-06-02 15:11:31','django_user@localhost',1,'admin','admin@example.com',1,1,NULL,NULL,NULL,NULL),
(2,'UPDATE','2026-06-02 15:16:56','django_user@localhost',1,'admin','admin@example.com',1,1,'system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:11:31'),
(3,'UPDATE','2026-06-02 15:47:22','django_user@localhost',1,'admin','admin@example.com',1,1,'system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:16:56'),
(4,'UPDATE','2026-06-02 15:55:39','django_user@localhost',2,'Juanito','Juanperez@gmail.com',1,0,'django_user@localhost','2026-06-02 15:27:11',NULL,NULL),
(5,'INSERT','2026-06-02 20:15:56','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56',NULL,NULL),
(6,'UPDATE','2026-06-02 20:16:09','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56',NULL,NULL),
(7,'UPDATE','2026-06-03 11:18:22','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-02 20:16:09'),
(8,'INSERT','2026-06-03 13:25:56','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56',NULL,NULL),
(9,'UPDATE','2026-06-03 13:26:03','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56',NULL,NULL),
(10,'UPDATE','2026-06-03 13:45:29','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-03 11:18:22'),
(11,'UPDATE','2026-06-03 13:48:49','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-03 13:26:03'),
(12,'UPDATE','2026-06-03 13:49:09','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-03 13:45:29'),
(13,'UPDATE','2026-06-03 14:14:05','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-03 13:48:49'),
(14,'UPDATE','2026-06-03 14:37:56','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-03 13:49:09'),
(15,'UPDATE','2026-06-03 14:40:16','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-03 14:14:05'),
(16,'UPDATE','2026-06-03 15:16:53','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-03 14:37:56'),
(17,'UPDATE','2026-06-04 10:28:43','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-03 15:16:53'),
(18,'UPDATE','2026-06-04 10:31:24','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-03 14:40:16'),
(19,'UPDATE','2026-06-04 11:08:39','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-04 10:31:24'),
(20,'UPDATE','2026-06-04 11:31:06','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-04 10:28:43'),
(21,'UPDATE','2026-06-04 11:32:05','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-04 11:08:39'),
(22,'UPDATE','2026-06-04 11:32:23','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-04 11:31:06'),
(23,'UPDATE','2026-06-04 11:39:17','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-04 11:32:05'),
(24,'UPDATE','2026-06-04 11:42:55','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-04 11:32:23'),
(25,'UPDATE','2026-06-04 11:43:35','django_user@localhost',4,'Kevin','kevin@gmail.com',1,0,'django_user@localhost','2026-06-03 13:25:56','django_user@localhost','2026-06-04 11:39:17'),
(26,'UPDATE','2026-06-04 11:47:51','django_user@localhost',3,'TECNASA','tecnasa.rrhh@gmail.com',1,0,'django_user@localhost','2026-06-02 20:15:56','django_user@localhost','2026-06-04 11:42:55'),
(27,'UPDATE','2026-06-04 12:42:24','django_user@localhost',1,'admin','admin@example.com',1,1,'system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:47:22');
/*!40000 ALTER TABLE `hist_auth_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `hist_empleos_candidato`
--

LOCK TABLES `hist_empleos_candidato` WRITE;
/*!40000 ALTER TABLE `hist_empleos_candidato` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `hist_empleos_candidato` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hist_empleos_empresa`
--

LOCK TABLES `hist_empleos_empresa` WRITE;
/*!40000 ALTER TABLE `hist_empleos_empresa` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `hist_empleos_empresa` VALUES
(1,'UPDATE','2026-06-02 15:11:31','django_user@localhost',1,'Tech Solutions SV','info@techsolutions.com.sv','2222-3333','San Salvador, El Salvador',NULL,NULL,NULL,NULL),
(2,'INSERT','2026-06-02 20:15:56','django_user@localhost',2,'TECNASA','tecnasa.rrhh@gmail.com','23421332','San Salvador Centro','django_user@localhost','2026-06-02 20:15:56',NULL,NULL);
/*!40000 ALTER TABLE `hist_empleos_empresa` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
-- Dumping data for table `hist_empleos_postulacion`
--

LOCK TABLES `hist_empleos_postulacion` WRITE;
/*!40000 ALTER TABLE `hist_empleos_postulacion` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `hist_empleos_postulacion` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hist_empleos_vacante`
--

LOCK TABLES `hist_empleos_vacante` WRITE;
/*!40000 ALTER TABLE `hist_empleos_vacante` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `hist_empleos_vacante` VALUES
(1,'UPDATE','2026-06-02 15:11:31','django_user@localhost',1,'Desarrollador Frontend React','Buscamos desarrollador frontend con experiencia en React y Tailwind CSS.',NULL,NULL,NULL,NULL,NULL,NULL,1500.00,'San Salvador','ACTIVA','2026-07-01',NULL,NULL,NULL,NULL),
(2,'UPDATE','2026-06-02 15:11:31','django_user@localhost',2,'Analista de Datos','Analista de datos con experiencia en Python y SQL.',NULL,NULL,NULL,NULL,NULL,NULL,2000.00,'Remoto','ACTIVA','2026-07-15',NULL,NULL,NULL,NULL),
(3,'UPDATE','2026-06-02 15:11:31','django_user@localhost',3,'Diseñador UX/UI','Diseñador UX/UI con experiencia en Figma.',NULL,NULL,NULL,NULL,NULL,NULL,1800.00,'Santa Tecla','ACTIVA','2026-06-30',NULL,NULL,NULL,NULL),
(4,'UPDATE','2026-06-02 15:43:21','django_user@localhost',1,'Desarrollador Frontend React','Buscamos desarrollador frontend con experiencia en React y Tailwind CSS.',NULL,NULL,NULL,NULL,NULL,NULL,1500.00,'San Salvador','ACTIVA','2026-07-01','system','2026-06-02 15:11:31','django_user@localhost','2026-06-02 15:11:31'),
(5,'INSERT','2026-06-02 15:44:19','django_user@localhost',5,'Nueva vacante para test INSERT trigger','Test INSERT trigger',NULL,NULL,NULL,NULL,NULL,NULL,5000.00,'San Miguel','ACTIVA','2026-08-01','django_user@localhost','2026-06-02 15:44:19',NULL,NULL),
(6,'INSERT','2026-06-02 15:47:52','django_user@localhost',6,'Prueba 2','Prueba',NULL,NULL,NULL,NULL,NULL,NULL,1000.00,'San Jose','ACTIVA','2026-06-11','django_user@localhost','2026-06-02 15:47:52',NULL,NULL),
(7,'INSERT','2026-06-03 11:20:18','django_user@localhost',7,'Asistente Ejecutivo','Prueba de insercion y borrado',NULL,NULL,NULL,NULL,NULL,NULL,650.00,'San Miguel','ACTIVA','2026-06-09','django_user@localhost','2026-06-03 11:20:18',NULL,NULL),
(8,'UPDATE','2026-06-03 11:20:41','django_user@localhost',7,'Asistente Ejecutivo','Prueba de insercion y borrado',NULL,NULL,NULL,NULL,NULL,NULL,650.00,'San Miguel','ACTIVA','2026-06-09','django_user@localhost','2026-06-03 11:20:18',NULL,NULL),
(9,'UPDATE','2026-06-03 11:43:44','django_user@localhost',7,'Asistente Ejecutivo','Prueba de insercion y borrado',NULL,NULL,NULL,NULL,NULL,NULL,675.00,'San Miguel','ACTIVA','2026-06-09','django_user@localhost','2026-06-03 11:20:18','django_user@localhost','2026-06-03 11:20:41'),
(10,'INSERT','2026-06-03 11:46:12','django_user@localhost',8,'TEST','Prueba',NULL,NULL,NULL,NULL,NULL,NULL,666.00,'TEST','ACTIVA','2026-06-30','django_user@localhost','2026-06-03 11:46:12',NULL,NULL),
(11,'UPDATE','2026-06-03 11:47:17','django_user@localhost',8,'TEST','Prueba',NULL,NULL,NULL,NULL,NULL,NULL,666.00,'TEST','ACTIVA','2026-06-30','django_user@localhost','2026-06-03 11:46:12',NULL,NULL),
(12,'UPDATE','2026-06-03 11:54:18','3',8,'TEST TRES','Prueba','Prueba','Prueba','MEDIO_TIEMPO',1,1,2,766.00,'TEST','ACTIVA','2026-06-30','django_user@localhost','2026-06-03 11:46:12','TECNASA','2026-06-03 11:54:18'),
(13,'DELETE','2026-06-03 12:09:18','django_user@localhost',7,'Asistente Ejecutivo','Prueba de insercion y borrado','Estudios tecnicos','Dos años en puestos similares','PROYECTO',2,5,2,675.00,'San Miguel','ACTIVA','2026-06-09','django_user@localhost','2026-06-03 11:20:18','django_user@localhost','2026-06-03 11:43:44'),
(14,'DELETE','2026-06-03 12:11:36','3',8,'TEST TRES','Prueba','Prueba','Prueba','MEDIO_TIEMPO',1,1,2,766.00,'TEST','ACTIVA','2026-06-30','django_user@localhost','2026-06-03 11:46:12','TECNASA','2026-06-03 11:54:18'),
(15,'INSERT','2026-06-03 13:48:34','3',9,'Recepcionista','Recepcion de documentos','Dos años de experiencia, servicial, buena disposicion, buena presentacion personal.','','TEMPORAL',1,5,2,600.00,'Morazan','ACTIVA','2026-06-10','TECNASA','2026-06-03 13:48:34',NULL,NULL),
(16,'INSERT','2026-06-04 11:39:06','3',10,'PRUEBAAA','PRUEBA','Prueba','','PRACTICAS',1,11,2,300.00,'Santa Ana','ACTIVA','2026-06-17','TECNASA','2026-06-04 11:39:06',NULL,NULL);
/*!40000 ALTER TABLE `hist_empleos_vacante` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificacion`
--

LOCK TABLES `notificacion` WRITE;
/*!40000 ALTER TABLE `notificacion` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `notificacion` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oferta`
--

LOCK TABLES `oferta` WRITE;
/*!40000 ALTER TABLE `oferta` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `oferta` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postulacion`
--

LOCK TABLES `postulacion` WRITE;
/*!40000 ALTER TABLE `postulacion` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `postulacion` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sector`
--

LOCK TABLES `sector` WRITE;
/*!40000 ALTER TABLE `sector` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sector` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_usuario`
--

LOCK TABLES `tipo_usuario` WRITE;
/*!40000 ALTER TABLE `tipo_usuario` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `tipo_usuario` VALUES
(1,'Admin');
/*!40000 ALTER TABLE `tipo_usuario` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_kill_sleeping_connections` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
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

-- Dump completed on 2026-06-04 22:31:09
