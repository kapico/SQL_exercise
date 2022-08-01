-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Gestion_bancaria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Gestion_bancaria` ;

-- -----------------------------------------------------
-- Schema Gestion_bancaria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Gestion_bancaria` DEFAULT CHARACTER SET utf8 ;
USE `Gestion_bancaria` ;

-- -----------------------------------------------------
-- Table `Gestion_bancaria`.`USUARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gestion_bancaria`.`USUARIO` (
  `dni_usuario` CHAR(9) NOT NULL,
  `nom` VARCHAR(255) NULL,
  `telefono` INT NULL,
  `direccion` VARCHAR(255) NULL,
  `correo` VARCHAR(255) NULL,
  PRIMARY KEY (`dni_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gestion_bancaria`.`BANCO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gestion_bancaria`.`BANCO` (
  `idBANCO` INT NOT NULL AUTO_INCREMENT,
  `LEI` CHAR(21) NULL,
  `Nom` VARCHAR(255) NULL,
  `direccion` VARCHAR(255) NULL,
  `oficina` INT NULL,
  `Entidad` INT NULL,
  PRIMARY KEY (`idBANCO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gestion_bancaria`.`DATOS_CUENTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gestion_bancaria`.`DATOS_CUENTA` (
  `Numero_cuenta` INT NOT NULL,
  `estado` TINYINT NULL DEFAULT 1,
  `saldo` FLOAT NULL,
  PRIMARY KEY (`Numero_cuenta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gestion_bancaria`.`TIPO_TRANSACCION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gestion_bancaria`.`TIPO_TRANSACCION` (
  `tipo_transaccion` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(60) NULL,
  PRIMARY KEY (`tipo_transaccion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gestion_bancaria`.`MOVIMIENTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gestion_bancaria`.`MOVIMIENTOS` (
  `Numero_cuenta` INT NOT NULL,
  `idBANCO` INT NOT NULL,
  `id_transaccion` VARCHAR(45) NOT NULL,
  `fecha_transaccion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `cantidad_transaccion` FLOAT NULL,
  `tipo_transaccion` INT NOT NULL,
  PRIMARY KEY (`id_transaccion`),
  CONSTRAINT `fk_DATOS_CUENTA_has_BANCO_DATOS_CUENTA1`
    FOREIGN KEY (`Numero_cuenta`)
    REFERENCES `Gestion_bancaria`.`DATOS_CUENTA` (`Numero_cuenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DATOS_CUENTA_has_BANCO_BANCO1`
    FOREIGN KEY (`idBANCO`)
    REFERENCES `Gestion_bancaria`.`BANCO` (`idBANCO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MOVIMIENTOS_TIPO_TRANSACCION1`
    FOREIGN KEY (`tipo_transaccion`)
    REFERENCES `Gestion_bancaria`.`TIPO_TRANSACCION` (`tipo_transaccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gestion_bancaria`.`tipo_cuenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gestion_bancaria`.`tipo_cuenta` (
  `tipo_cuenta` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) NULL,
  PRIMARY KEY (`tipo_cuenta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gestion_bancaria`.`Apertura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gestion_bancaria`.`Apertura` (
  `dni_usuario` CHAR(9) NOT NULL,
  `Numero_cuenta` INT NOT NULL,
  `tipo_cuenta` INT NOT NULL,
  CONSTRAINT `fk_USUARIO_has_DATOS_CUENTA_USUARIO1`
    FOREIGN KEY (`dni_usuario`)
    REFERENCES `Gestion_bancaria`.`USUARIO` (`dni_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USUARIO_has_DATOS_CUENTA_DATOS_CUENTA1`
    FOREIGN KEY (`Numero_cuenta`)
    REFERENCES `Gestion_bancaria`.`DATOS_CUENTA` (`Numero_cuenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Apertura_tipo_cuenta1`
    FOREIGN KEY (`tipo_cuenta`)
    REFERENCES `Gestion_bancaria`.`tipo_cuenta` (`tipo_cuenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Gestion_bancaria`.`USUARIO`
-- -----------------------------------------------------
START TRANSACTION;
USE `Gestion_bancaria`;
INSERT INTO `Gestion_bancaria`.`USUARIO` (`dni_usuario`, `nom`, `telefono`, `direccion`, `correo`) VALUES ('11111111A', 'Usuario 1', 123456789, 'Calle 1 Barcelona', 'usuario1@gmail.com');
INSERT INTO `Gestion_bancaria`.`USUARIO` (`dni_usuario`, `nom`, `telefono`, `direccion`, `correo`) VALUES ('22222222B', 'Usuario 2', 123987456, 'Calle 2 Madrid', 'usuario2@gmail.com');
INSERT INTO `Gestion_bancaria`.`USUARIO` (`dni_usuario`, `nom`, `telefono`, `direccion`, `correo`) VALUES ('33333333C', 'Usuario 3', 903457892, 'Calle 3 Zaragoza', 'usuario3@gmail.com');
INSERT INTO `Gestion_bancaria`.`USUARIO` (`dni_usuario`, `nom`, `telefono`, `direccion`, `correo`) VALUES ('44444444D', 'Usuario 4', 456709823, 'Calle 4 Barcelona', 'usuario4@gmail.com');
INSERT INTO `Gestion_bancaria`.`USUARIO` (`dni_usuario`, `nom`, `telefono`, `direccion`, `correo`) VALUES ('55555555E', 'Usuario 5', 098762457, 'Calle 5 Barcelona', 'usuario5@gmail.com');
INSERT INTO `Gestion_bancaria`.`USUARIO` (`dni_usuario`, `nom`, `telefono`, `direccion`, `correo`) VALUES ('66666666R', 'Usuario 6', 123123123, 'calle 5 Barcelona', 'usuario6@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Gestion_bancaria`.`BANCO`
-- -----------------------------------------------------
START TRANSACTION;
USE `Gestion_bancaria`;
INSERT INTO `Gestion_bancaria`.`BANCO` (`idBANCO`, `LEI`, `Nom`, `direccion`, `oficina`, `Entidad`) VALUES (DEFAULT, 'SI5RG2M0WQQLZCXKRM20', 'Sabadell', 'Alicante', 101, 1464);
INSERT INTO `Gestion_bancaria`.`BANCO` (`idBANCO`, `LEI`, `Nom`, `direccion`, `oficina`, `Entidad`) VALUES (DEFAULT, '95980020140005970915', 'Caixa bank', 'Paseig San joan Barcelona', 102, 1234);
INSERT INTO `Gestion_bancaria`.`BANCO` (`idBANCO`, `LEI`, `Nom`, `direccion`, `oficina`, `Entidad`) VALUES (DEFAULT, 'VWMYAEQAARTNV0SUGU82', 'Santander', 'Rubi centro', 345, 2342);
INSERT INTO `Gestion_bancaria`.`BANCO` (`idBANCO`, `LEI`, `Nom`, `direccion`, `oficina`, `Entidad`) VALUES (DEFAULT, 'VWMYAEQSTOPNV0SUGU82', 'Bankinter', 'Madrid paseo de castellana', 123, 4567);
INSERT INTO `Gestion_bancaria`.`BANCO` (`idBANCO`, `LEI`, `Nom`, `direccion`, `oficina`, `Entidad`) VALUES (DEFAULT, '95980020140005952097', 'Banco Pichincha', 'Barcelona Diagonal', 345, 0192);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Gestion_bancaria`.`DATOS_CUENTA`
-- -----------------------------------------------------
START TRANSACTION;
USE `Gestion_bancaria`;
INSERT INTO `Gestion_bancaria`.`DATOS_CUENTA` (`Numero_cuenta`, `estado`, `saldo`) VALUES (50308762, NULL, 1200.00);
INSERT INTO `Gestion_bancaria`.`DATOS_CUENTA` (`Numero_cuenta`, `estado`, `saldo`) VALUES (25308762, NULL, 22000.00);
INSERT INTO `Gestion_bancaria`.`DATOS_CUENTA` (`Numero_cuenta`, `estado`, `saldo`) VALUES (80308762, NULL, 1000.00);
INSERT INTO `Gestion_bancaria`.`DATOS_CUENTA` (`Numero_cuenta`, `estado`, `saldo`) VALUES (90308762, NULL, 500.00);
INSERT INTO `Gestion_bancaria`.`DATOS_CUENTA` (`Numero_cuenta`, `estado`, `saldo`) VALUES (20308762, NULL, 40000.00);
INSERT INTO `Gestion_bancaria`.`DATOS_CUENTA` (`Numero_cuenta`, `estado`, `saldo`) VALUES (12348762, NULL, 2500.00);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Gestion_bancaria`.`TIPO_TRANSACCION`
-- -----------------------------------------------------
START TRANSACTION;
USE `Gestion_bancaria`;
INSERT INTO `Gestion_bancaria`.`TIPO_TRANSACCION` (`tipo_transaccion`, `descripcion`) VALUES (DEFAULT, 'Retiro ventanilla');
INSERT INTO `Gestion_bancaria`.`TIPO_TRANSACCION` (`tipo_transaccion`, `descripcion`) VALUES (DEFAULT, 'Retiro cajero automatico');
INSERT INTO `Gestion_bancaria`.`TIPO_TRANSACCION` (`tipo_transaccion`, `descripcion`) VALUES (DEFAULT, 'Transferencia electronica');
INSERT INTO `Gestion_bancaria`.`TIPO_TRANSACCION` (`tipo_transaccion`, `descripcion`) VALUES (DEFAULT, 'Transferencia ventanilla');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Gestion_bancaria`.`MOVIMIENTOS`
-- -----------------------------------------------------
START TRANSACTION;
USE `Gestion_bancaria`;
INSERT INTO `Gestion_bancaria`.`MOVIMIENTOS` (`Numero_cuenta`, `idBANCO`, `id_transaccion`, `fecha_transaccion`, `cantidad_transaccion`, `tipo_transaccion`) VALUES (50308762, 1, '1', NULL, 200.00, 1);
INSERT INTO `Gestion_bancaria`.`MOVIMIENTOS` (`Numero_cuenta`, `idBANCO`, `id_transaccion`, `fecha_transaccion`, `cantidad_transaccion`, `tipo_transaccion`) VALUES (12348762, 2, '2', NULL, 100.00, 1);
INSERT INTO `Gestion_bancaria`.`MOVIMIENTOS` (`Numero_cuenta`, `idBANCO`, `id_transaccion`, `fecha_transaccion`, `cantidad_transaccion`, `tipo_transaccion`) VALUES (12348762, 3, '3', NULL, 50.00, 2);
INSERT INTO `Gestion_bancaria`.`MOVIMIENTOS` (`Numero_cuenta`, `idBANCO`, `id_transaccion`, `fecha_transaccion`, `cantidad_transaccion`, `tipo_transaccion`) VALUES (90308762, 4, '4', NULL, 20.00, 2);
INSERT INTO `Gestion_bancaria`.`MOVIMIENTOS` (`Numero_cuenta`, `idBANCO`, `id_transaccion`, `fecha_transaccion`, `cantidad_transaccion`, `tipo_transaccion`) VALUES (80308762, 5, '5', NULL, 30.00, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Gestion_bancaria`.`tipo_cuenta`
-- -----------------------------------------------------
START TRANSACTION;
USE `Gestion_bancaria`;
INSERT INTO `Gestion_bancaria`.`tipo_cuenta` (`tipo_cuenta`, `descripcion`) VALUES (DEFAULT, 'Corriente');
INSERT INTO `Gestion_bancaria`.`tipo_cuenta` (`tipo_cuenta`, `descripcion`) VALUES (DEFAULT, 'Ahorros');
INSERT INTO `Gestion_bancaria`.`tipo_cuenta` (`tipo_cuenta`, `descripcion`) VALUES (DEFAULT, 'Conjunta');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Gestion_bancaria`.`Apertura`
-- -----------------------------------------------------
START TRANSACTION;
USE `Gestion_bancaria`;
INSERT INTO `Gestion_bancaria`.`Apertura` (`dni_usuario`, `Numero_cuenta`, `tipo_cuenta`) VALUES ('11111111A', 50308762, 1);
INSERT INTO `Gestion_bancaria`.`Apertura` (`dni_usuario`, `Numero_cuenta`, `tipo_cuenta`) VALUES ('22222222B', 25308762, 2);
INSERT INTO `Gestion_bancaria`.`Apertura` (`dni_usuario`, `Numero_cuenta`, `tipo_cuenta`) VALUES ('33333333C', 80308762, 1);
INSERT INTO `Gestion_bancaria`.`Apertura` (`dni_usuario`, `Numero_cuenta`, `tipo_cuenta`) VALUES ('44444444D', 90308762, 2);
INSERT INTO `Gestion_bancaria`.`Apertura` (`dni_usuario`, `Numero_cuenta`, `tipo_cuenta`) VALUES ('55555555E', 20308762, 1);
INSERT INTO `Gestion_bancaria`.`Apertura` (`dni_usuario`, `Numero_cuenta`, `tipo_cuenta`) VALUES ('66666666R', 20308762, 3);
INSERT INTO `Gestion_bancaria`.`Apertura` (`dni_usuario`, `Numero_cuenta`, `tipo_cuenta`) VALUES ('44444444D', 12348762, 3);

COMMIT;

