-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Model_Bicing
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Model_Bicing` ;

-- -----------------------------------------------------
-- Schema Model_Bicing
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Model_Bicing` DEFAULT CHARACTER SET utf8 ;
USE `Model_Bicing` ;

-- -----------------------------------------------------
-- Table `Model_Bicing`.`USUARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Model_Bicing`.`USUARIO` (
  `DNI` CHAR(9) NOT NULL,
  `Nombre` VARCHAR(255) NOT NULL,
  `Direccion` VARCHAR(255) NOT NULL,
  `Telefono` INT NOT NULL,
  `Fecha_nacimiento` DATE NOT NULL,
  PRIMARY KEY (`DNI`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Model_Bicing`.`REPOSICION_bicis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Model_Bicing`.`REPOSICION_bicis` (
  `placa_camion` CHAR(7) NOT NULL,
  `capacidad` INT NOT NULL,
  `zona_actividad` VARCHAR(255) NOT NULL,
  `dni_conductor` CHAR(9) NOT NULL,
  PRIMARY KEY (`placa_camion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Model_Bicing`.`ESTACION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Model_Bicing`.`ESTACION` (
  `ID_Estacion` INT NOT NULL AUTO_INCREMENT,
  `Localizacion` VARCHAR(255) NOT NULL,
  `Capacidad` INT NOT NULL,
  `Espacios_vacios` INT NOT NULL,
  `Disponibles` INT NOT NULL,
  `Reposicion` CHAR(7) NOT NULL,
  PRIMARY KEY (`ID_Estacion`),
  CONSTRAINT `fk_ESTACION_Reposicion_bicis1`
    FOREIGN KEY (`Reposicion`)
    REFERENCES `Model_Bicing`.`REPOSICION_bicis` (`placa_camion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Model_Bicing`.`BICICLETA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Model_Bicing`.`BICICLETA` (
  `ID_Bici` INT NOT NULL AUTO_INCREMENT,
  `Tipo` TINYINT NOT NULL,
  `Estado` TINYINT NOT NULL DEFAULT 0,
  `ESTACION_ID_Estacion` INT NOT NULL,
  PRIMARY KEY (`ID_Bici`),
  CONSTRAINT `fk_BICICLETA_ESTACION1`
    FOREIGN KEY (`ESTACION_ID_Estacion`)
    REFERENCES `Model_Bicing`.`ESTACION` (`ID_Estacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Model_Bicing`.`FACTURACION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Model_Bicing`.`FACTURACION` (
  `idFACTURACION` INT NOT NULL AUTO_INCREMENT,
  `Fecha` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `Total` DOUBLE NOT NULL,
  PRIMARY KEY (`idFACTURACION`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Model_Bicing`.`TARIFAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Model_Bicing`.`TARIFAS` (
  `ID_Tarifa` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Precio` DOUBLE NOT NULL,
  PRIMARY KEY (`ID_Tarifa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Model_Bicing`.`TARJETAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Model_Bicing`.`TARJETAS` (
  `ID_Tarjeta` INT NOT NULL AUTO_INCREMENT,
  `Fecha_alta` DATE NOT NULL,
  `Alta_tarifa` DATE NULL,
  `Expiracion_tarifa` DATE NULL,
  `USUARIO_DNI` CHAR(9) NOT NULL,
  `TARIFAS_ID_Tarifa` INT NULL,
  PRIMARY KEY (`ID_Tarjeta`),
  CONSTRAINT `fk_TARJETAS_USUARIO1`
    FOREIGN KEY (`USUARIO_DNI`)
    REFERENCES `Model_Bicing`.`USUARIO` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TARJETAS_TARIFAS1`
    FOREIGN KEY (`TARIFAS_ID_Tarifa`)
    REFERENCES `Model_Bicing`.`TARIFAS` (`ID_Tarifa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Model_Bicing`.`MANTENIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Model_Bicing`.`MANTENIMIENTO` (
  `idMANTENIMIENTO` INT NOT NULL AUTO_INCREMENT,
  `Defecto` VARCHAR(555) NULL,
  `Fecha_baja` DATE NULL,
  `Fecha_alta` DATE NULL,
  `BICICLETA_ID_Bici` INT NOT NULL,
  PRIMARY KEY (`idMANTENIMIENTO`),
  CONSTRAINT `fk_MANTENIMIENTO_BICICLETA1`
    FOREIGN KEY (`BICICLETA_ID_Bici`)
    REFERENCES `Model_Bicing`.`BICICLETA` (`ID_Bici`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Model_Bicing`.`CUENTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Model_Bicing`.`CUENTA` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `USUARIO_DNI` CHAR(9) NOT NULL,
  CONSTRAINT `fk_CUENTA_USUARIO`
    FOREIGN KEY (`USUARIO_DNI`)
    REFERENCES `Model_Bicing`.`USUARIO` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Model_Bicing`.`PLUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Model_Bicing`.`PLUS` (
  `min30` DOUBLE NOT NULL,
  `min30_2h` DOUBLE NOT NULL,
  `mas_de_2h` DOUBLE NOT NULL,
  `tipo_bici` TINYINT NOT NULL,
  `TARIFAS_ID_Tarifa` INT NOT NULL,
  CONSTRAINT `fk_PLUS_TARIFAS1`
    FOREIGN KEY (`TARIFAS_ID_Tarifa`)
    REFERENCES `Model_Bicing`.`TARIFAS` (`ID_Tarifa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Model_Bicing`.`ALQUILER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Model_Bicing`.`ALQUILER` (
  `ID_alquiler` INT NOT NULL AUTO_INCREMENT,
  `USUARIO_DNI` CHAR(9) NOT NULL,
  `BICICLETA_ID_Bici` INT NOT NULL,
  `Fecha_recogida` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_devolucion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Total_viaje` TIME NULL,
  `FACTURACION_idFACTURACION` INT NOT NULL,
  PRIMARY KEY (`ID_alquiler`),
  CONSTRAINT `fk_USUARIO_has_BICICLETA_USUARIO1`
    FOREIGN KEY (`USUARIO_DNI`)
    REFERENCES `Model_Bicing`.`USUARIO` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USUARIO_has_BICICLETA_BICICLETA1`
    FOREIGN KEY (`BICICLETA_ID_Bici`)
    REFERENCES `Model_Bicing`.`BICICLETA` (`ID_Bici`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ALQUILER_FACTURACION1`
    FOREIGN KEY (`FACTURACION_idFACTURACION`)
    REFERENCES `Model_Bicing`.`FACTURACION` (`idFACTURACION`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Model_Bicing`.`AUTORIZACIONES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Model_Bicing`.`AUTORIZACIONES` (
  `N_AUTORIZACION` INT NOT NULL AUTO_INCREMENT,
  `nombre_tutor` VARCHAR(255) NULL,
  `dni_tutor` CHAR(9) NOT NULL,
  `fecha_autorizacion` DATE NULL,
  `USUARIO_DNI` CHAR(9) NOT NULL,
  PRIMARY KEY (`N_AUTORIZACION`),
  CONSTRAINT `fk_AUTORIZACIONES_USUARIO1`
    FOREIGN KEY (`USUARIO_DNI`)
    REFERENCES `Model_Bicing`.`USUARIO` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Model_Bicing`.`USUARIO`
-- -----------------------------------------------------
START TRANSACTION;
USE `Model_Bicing`;
INSERT INTO `Model_Bicing`.`USUARIO` (`DNI`, `Nombre`, `Direccion`, `Telefono`, `Fecha_nacimiento`) VALUES ('26543194K', 'Jean Carlo', 'Santiago Apostol 67', 662078291, '1998-08-04');
INSERT INTO `Model_Bicing`.`USUARIO` (`DNI`, `Nombre`, `Direccion`, `Telefono`, `Fecha_nacimiento`) VALUES ('18263728D', 'Antonio Machado', 'Calle Sants 128', 637182732, '1993-03-19');
INSERT INTO `Model_Bicing`.`USUARIO` (`DNI`, `Nombre`, `Direccion`, `Telefono`, `Fecha_nacimiento`) VALUES ('62718293M', 'Sara Martinez', 'Av. Ramon Cajal 73', 625192737, '2000-10-24');
INSERT INTO `Model_Bicing`.`USUARIO` (`DNI`, `Nombre`, `Direccion`, `Telefono`, `Fecha_nacimiento`) VALUES ('81928337T', 'Carlos Martinez', 'Av. Meridiana', 651427182, '2005-03-27');
INSERT INTO `Model_Bicing`.`USUARIO` (`DNI`, `Nombre`, `Direccion`, `Telefono`, `Fecha_nacimiento`) VALUES ('65271827P', 'David Renata', 'Calle Digimon', 641829361, '2006-11-13');
INSERT INTO `Model_Bicing`.`USUARIO` (`DNI`, `Nombre`, `Direccion`, `Telefono`, `Fecha_nacimiento`) VALUES ('71829371T', 'Pepe Manuela', 'Rambla badal', 961527382, '2005-12-24');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Model_Bicing`.`REPOSICION_bicis`
-- -----------------------------------------------------
START TRANSACTION;
USE `Model_Bicing`;
INSERT INTO `Model_Bicing`.`REPOSICION_bicis` (`placa_camion`, `capacidad`, `zona_actividad`, `dni_conductor`) VALUES ('2475JPK', 50, 'Barceloneta', '27182739Y');
INSERT INTO `Model_Bicing`.`REPOSICION_bicis` (`placa_camion`, `capacidad`, `zona_actividad`, `dni_conductor`) VALUES ('6286YUS', 20, 'Gracia', '26718273D');
INSERT INTO `Model_Bicing`.`REPOSICION_bicis` (`placa_camion`, `capacidad`, `zona_actividad`, `dni_conductor`) VALUES ('6273HJP', 60, 'Horta', '61728361T');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Model_Bicing`.`ESTACION`
-- -----------------------------------------------------
START TRANSACTION;
USE `Model_Bicing`;
INSERT INTO `Model_Bicing`.`ESTACION` (`ID_Estacion`, `Localizacion`, `Capacidad`, `Espacios_vacios`, `Disponibles`, `Reposicion`) VALUES (DEFAULT, 'Rambla', 10, 3, 7, '2475JPK');
INSERT INTO `Model_Bicing`.`ESTACION` (`ID_Estacion`, `Localizacion`, `Capacidad`, `Espacios_vacios`, `Disponibles`, `Reposicion`) VALUES (DEFAULT, 'Maragall', 15, 1, 14, '6286YUS');
INSERT INTO `Model_Bicing`.`ESTACION` (`ID_Estacion`, `Localizacion`, `Capacidad`, `Espacios_vacios`, `Disponibles`, `Reposicion`) VALUES (DEFAULT, 'Sants', 20, 10, 10, '6273HJP');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Model_Bicing`.`BICICLETA`
-- -----------------------------------------------------
START TRANSACTION;
USE `Model_Bicing`;
INSERT INTO `Model_Bicing`.`BICICLETA` (`ID_Bici`, `Tipo`, `Estado`, `ESTACION_ID_Estacion`) VALUES (DEFAULT, 1, 0, 1);
INSERT INTO `Model_Bicing`.`BICICLETA` (`ID_Bici`, `Tipo`, `Estado`, `ESTACION_ID_Estacion`) VALUES (DEFAULT, 1, 1, 2);
INSERT INTO `Model_Bicing`.`BICICLETA` (`ID_Bici`, `Tipo`, `Estado`, `ESTACION_ID_Estacion`) VALUES (DEFAULT, 1, 1, 3);
INSERT INTO `Model_Bicing`.`BICICLETA` (`ID_Bici`, `Tipo`, `Estado`, `ESTACION_ID_Estacion`) VALUES (DEFAULT, 0, 0, 3);
INSERT INTO `Model_Bicing`.`BICICLETA` (`ID_Bici`, `Tipo`, `Estado`, `ESTACION_ID_Estacion`) VALUES (DEFAULT, 1, 0, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Model_Bicing`.`FACTURACION`
-- -----------------------------------------------------
START TRANSACTION;
USE `Model_Bicing`;
INSERT INTO `Model_Bicing`.`FACTURACION` (`idFACTURACION`, `Fecha`, `Total`) VALUES (DEFAULT, '2022-05-04', 120.00);
INSERT INTO `Model_Bicing`.`FACTURACION` (`idFACTURACION`, `Fecha`, `Total`) VALUES (DEFAULT, '2022-06-02', 150.00);
INSERT INTO `Model_Bicing`.`FACTURACION` (`idFACTURACION`, `Fecha`, `Total`) VALUES (DEFAULT, '2022-06-15', 50.00);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Model_Bicing`.`TARIFAS`
-- -----------------------------------------------------
START TRANSACTION;
USE `Model_Bicing`;
INSERT INTO `Model_Bicing`.`TARIFAS` (`ID_Tarifa`, `Nombre`, `Precio`) VALUES (1, 'Plana', 50);
INSERT INTO `Model_Bicing`.`TARIFAS` (`ID_Tarifa`, `Nombre`, `Precio`) VALUES (2, 'Ocasional', 35);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Model_Bicing`.`TARJETAS`
-- -----------------------------------------------------
START TRANSACTION;
USE `Model_Bicing`;
INSERT INTO `Model_Bicing`.`TARJETAS` (`ID_Tarjeta`, `Fecha_alta`, `Alta_tarifa`, `Expiracion_tarifa`, `USUARIO_DNI`, `TARIFAS_ID_Tarifa`) VALUES (DEFAULT, '2005-10-17', '2022-10-15', '2023-10-15', '26543194K', 1);
INSERT INTO `Model_Bicing`.`TARJETAS` (`ID_Tarjeta`, `Fecha_alta`, `Alta_tarifa`, `Expiracion_tarifa`, `USUARIO_DNI`, `TARIFAS_ID_Tarifa`) VALUES (DEFAULT, '2018-05-28', '2022-08-30', '2023-08-30', '18263728D', 2);
INSERT INTO `Model_Bicing`.`TARJETAS` (`ID_Tarjeta`, `Fecha_alta`, `Alta_tarifa`, `Expiracion_tarifa`, `USUARIO_DNI`, `TARIFAS_ID_Tarifa`) VALUES (DEFAULT, '2021-03-16', NULL, NULL, '62718293M', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Model_Bicing`.`MANTENIMIENTO`
-- -----------------------------------------------------
START TRANSACTION;
USE `Model_Bicing`;
INSERT INTO `Model_Bicing`.`MANTENIMIENTO` (`idMANTENIMIENTO`, `Defecto`, `Fecha_baja`, `Fecha_alta`, `BICICLETA_ID_Bici`) VALUES (DEFAULT, 'Rueda pinchada', '2021-10-12', '2021-10-15', 1);
INSERT INTO `Model_Bicing`.`MANTENIMIENTO` (`idMANTENIMIENTO`, `Defecto`, `Fecha_baja`, `Fecha_alta`, `BICICLETA_ID_Bici`) VALUES (DEFAULT, 'Fallo mecanico en frenos', '2022-01-01', '2022-03-05', 2);
INSERT INTO `Model_Bicing`.`MANTENIMIENTO` (`idMANTENIMIENTO`, `Defecto`, `Fecha_baja`, `Fecha_alta`, `BICICLETA_ID_Bici`) VALUES (DEFAULT, 'Fallo electrico en motor', '2022-06-01', '2022-07-01', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Model_Bicing`.`CUENTA`
-- -----------------------------------------------------
START TRANSACTION;
USE `Model_Bicing`;
INSERT INTO `Model_Bicing`.`CUENTA` (`username`, `email`, `password`, `create_time`, `USUARIO_DNI`) VALUES ('jeanc98', 'jcarlo@gmail.com', 'contraseña1', NULL, '26543194K');
INSERT INTO `Model_Bicing`.`CUENTA` (`username`, `email`, `password`, `create_time`, `USUARIO_DNI`) VALUES ('antonito127', 'correo1@gmail.com', 'contraseña2', NULL, '18263728D');
INSERT INTO `Model_Bicing`.`CUENTA` (`username`, `email`, `password`, `create_time`, `USUARIO_DNI`) VALUES ('saritagatita', 'correo2@gmail.com', 'contraseña3', NULL, '62718293M');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Model_Bicing`.`PLUS`
-- -----------------------------------------------------
START TRANSACTION;
USE `Model_Bicing`;
INSERT INTO `Model_Bicing`.`PLUS` (`min30`, `min30_2h`, `mas_de_2h`, `tipo_bici`, `TARIFAS_ID_Tarifa`) VALUES (0, 0.70, 5.00, 0, 1);
INSERT INTO `Model_Bicing`.`PLUS` (`min30`, `min30_2h`, `mas_de_2h`, `tipo_bici`, `TARIFAS_ID_Tarifa`) VALUES (0.35, 0.90, 5.00, 1, 1);
INSERT INTO `Model_Bicing`.`PLUS` (`min30`, `min30_2h`, `mas_de_2h`, `tipo_bici`, `TARIFAS_ID_Tarifa`) VALUES (0.35, 0.70, 5.00, 0, 2);
INSERT INTO `Model_Bicing`.`PLUS` (`min30`, `min30_2h`, `mas_de_2h`, `tipo_bici`, `TARIFAS_ID_Tarifa`) VALUES (0.55, 0.90, 5.00, 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Model_Bicing`.`ALQUILER`
-- -----------------------------------------------------
START TRANSACTION;
USE `Model_Bicing`;
INSERT INTO `Model_Bicing`.`ALQUILER` (`ID_alquiler`, `USUARIO_DNI`, `BICICLETA_ID_Bici`, `Fecha_recogida`, `Fecha_devolucion`, `Total_viaje`, `FACTURACION_idFACTURACION`) VALUES (DEFAULT, '26543194K', 1, '2022-05-03 15:00:00', '2022-05-03 15:45:05', '00:45:00', 1);
INSERT INTO `Model_Bicing`.`ALQUILER` (`ID_alquiler`, `USUARIO_DNI`, `BICICLETA_ID_Bici`, `Fecha_recogida`, `Fecha_devolucion`, `Total_viaje`, `FACTURACION_idFACTURACION`) VALUES (DEFAULT, '18263728D', 2, '2022-05-02 16:35:45', '2022-05-02 17:00:00', '00:25:15', 2);
INSERT INTO `Model_Bicing`.`ALQUILER` (`ID_alquiler`, `USUARIO_DNI`, `BICICLETA_ID_Bici`, `Fecha_recogida`, `Fecha_devolucion`, `Total_viaje`, `FACTURACION_idFACTURACION`) VALUES (DEFAULT, '62718293M', 3, '2022-05-01 06:00:00', '2022-05-01 06:50:00', '00:50:00', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Model_Bicing`.`AUTORIZACIONES`
-- -----------------------------------------------------
START TRANSACTION;
USE `Model_Bicing`;
INSERT INTO `Model_Bicing`.`AUTORIZACIONES` (`N_AUTORIZACION`, `nombre_tutor`, `dni_tutor`, `fecha_autorizacion`, `USUARIO_DNI`) VALUES (DEFAULT, 'Karen', '11111111P', '2019-04-24', '81928337T');
INSERT INTO `Model_Bicing`.`AUTORIZACIONES` (`N_AUTORIZACION`, `nombre_tutor`, `dni_tutor`, `fecha_autorizacion`, `USUARIO_DNI`) VALUES (DEFAULT, 'Marcela', '22222222X', '2021-10-15', '65271827P');
INSERT INTO `Model_Bicing`.`AUTORIZACIONES` (`N_AUTORIZACION`, `nombre_tutor`, `dni_tutor`, `fecha_autorizacion`, `USUARIO_DNI`) VALUES (DEFAULT, 'Paco', '66666666R', '2020-04-08', '71829371T');

COMMIT;

