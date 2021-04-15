
CREATE SCHEMA IF NOT EXISTS `formula2` DEFAULT CHARACTER SET utf8;
USE `formula2` ;

-- -----------------------------------------------------
-- Table `formula2`.`circuito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `formula2`.`circuito` (
  `nombre` VARCHAR(30) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `longitud` FLOAT(5,3) NULL DEFAULT NULL,
  `curvas` INT NULL DEFAULT NULL,
  `velocidad_max` FLOAT(5,2) NULL DEFAULT NULL,
  `pais` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`nombre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `formula2`.`carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `formula2`.`carrera` (
  `circuito` VARCHAR(30) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`circuito`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `formula2`.`escuderia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `formula2`.`escuderia` (
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `director` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `color` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `formula2`.`piloto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `formula2`.`piloto` (
  `dorsal` INT NOT NULL,
  `nombre` VARCHAR(25) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `pais` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `escuderia` INT NOT NULL,
  PRIMARY KEY (`dorsal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `formula2`.`participa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `formula2`.`participa` (
  `dorsal` INT NOT NULL,
  `circuito` VARCHAR(30) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `pos_ini` TINYINT NULL DEFAULT NULL,
  `pos_fin` TINYINT NULL DEFAULT NULL,
  `tiempo` FLOAT(5,2) NULL DEFAULT NULL,
  PRIMARY KEY (`dorsal`, `circuito`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `formula2`.`sponsor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `formula2`.`sponsor` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `formula2`.`sponsoriza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `formula2`.`sponsoriza` (
  `num_piloto` INT NOT NULL,
  `cod_sponsor` INT NOT NULL,
  `cantidad` INT NULL DEFAULT NULL,
  PRIMARY KEY (`num_piloto`, `cod_sponsor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

--
-- Dumping data for table `carrera`
--

LOCK TABLES `carrera` WRITE;
/*!40000 ALTER TABLE `carrera` DISABLE KEYS */;
INSERT INTO `carrera` VALUES ('Imola','2018-09-06'),('Jarama','2018-04-12'),('Silverstone','2018-06-24'),('Suzuka','2018-07-09');
/*!40000 ALTER TABLE `carrera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `circuito`
--

LOCK TABLES `circuito` WRITE;
/*!40000 ALTER TABLE `circuito` DISABLE KEYS */;
INSERT INTO `circuito` VALUES ('Imola',4.525,12,340.50,'Italia'),('Jarama',4.100,15,305.60,'España'),('Silverstone',5.215,17,322.70,'Inglaterra'),('Suzuka',4.920,22,295.40,'Japón');
/*!40000 ALTER TABLE `circuito` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `escuderia`
--

LOCK TABLES `escuderia` WRITE;
/*!40000 ALTER TABLE `escuderia` DISABLE KEYS */;
INSERT INTO `escuderia` VALUES (1,'Ferrari','Domenicalli','Rojo'),(2,'Mclaren','Dennis','Naranja'),(3,'RedBull','Horner','Negro'),(4,'Renault','Prost','Amarillo'),(5,'Mercedes','Wolff','Plata');
/*!40000 ALTER TABLE `escuderia` ENABLE KEYS */;
UNLOCK TABLES;

--

--
-- Dumping data for table `participa`
--

LOCK TABLES `participa` WRITE;
/*!40000 ALTER TABLE `participa` DISABLE KEYS */;
INSERT INTO `participa` VALUES (5,'Imola',6,4,1.40),(5,'Jarama',4,5,1.30),(5,'Silverstone',4,5,1.30),(5,'Suzuka',4,5,1.44),(7,'Imola',1,1,1.20),(7,'Jarama',5,6,1.35),(7,'Silverstone',5,6,1.37),(7,'Suzuka',2,1,1.30),(14,'Imola',7,7,1.40),(14,'Jarama',3,4,1.12),(14,'Silverstone',1,1,1.15),(14,'Suzuka',1,2,1.35),(33,'Imola',2,3,1.25),(33,'Jarama',6,3,1.11),(33,'Silverstone',6,4,1.25),(33,'Suzuka',3,3,1.40),(44,'Imola',4,5,1.30),(44,'Jarama',1,1,1.09),(44,'Silverstone',3,3,1.20),(44,'Suzuka',5,6,1.47),(55,'Imola',5,6,1.35),(55,'Jarama',2,2,1.10),(55,'Silverstone',2,2,1.17),(55,'Suzuka',6,4,1.42),(77,'Imola',3,2,1.22),(77,'Jarama',7,7,1.44),(77,'Silverstone',7,7,1.60),(77,'Suzuka',7,7,1.55);
/*!40000 ALTER TABLE `participa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `piloto`
--

LOCK TABLES `piloto` WRITE;
/*!40000 ALTER TABLE `piloto` DISABLE KEYS */;
INSERT INTO `piloto` VALUES (5,'Vettel','Alemania',1),(7,'Raikkonen','Finlandia',1),(14,'Alonso','España',2),(33,'Verstappen','Holnada',3),(44,'Hamilton','Inglaterra',5),(55,'Sainz','España',4),(77,'Bottas','Finlandia',5);
/*!40000 ALTER TABLE `piloto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sponsor`
--

LOCK TABLES `sponsor` WRITE;
/*!40000 ALTER TABLE `sponsor` DISABLE KEYS */;
INSERT INTO `sponsor` VALUES (1,'Coca-Cola'),(2,'Shell'),(3,'Oracle'),(4,'Movistar'),(5,'RedBull'),(6,'IBM');
/*!40000 ALTER TABLE `sponsor` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `sponsoriza` WRITE;
/*!40000 ALTER TABLE `sponsoriza` DISABLE KEYS */;
INSERT INTO `sponsoriza` VALUES (5,1,5000),(5,2,3000),(7,2,2500),(14,4,5000),(14,5,11000),(44,1,7000),(44,4,5000);
/*!40000 ALTER TABLE `sponsoriza` ENABLE KEYS */;
UNLOCK TABLES;
