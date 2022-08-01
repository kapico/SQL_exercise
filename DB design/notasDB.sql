-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Notas
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Notas` ;

-- -----------------------------------------------------
-- Schema Notas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Notas` DEFAULT CHARACTER SET utf8 ;
USE `Notas` ;

-- -----------------------------------------------------
-- Table `Notas`.`Modulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Notas`.`Modulos` (
  `idModulos` INT NOT NULL,
  `Nombre_modulo` VARCHAR(100) NOT NULL,
  `horas` INT(5) NOT NULL,
  `Profesor` VARCHAR(45) NULL,
  PRIMARY KEY (`idModulos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Notas`.`UFs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Notas`.`UFs` (
  `idUFs` VARCHAR(6) NOT NULL,
  `nombre_uf` VARCHAR(100) NOT NULL,
  `horas` INT(5) NOT NULL,
  `Modulos_idModulos` INT NOT NULL,
  PRIMARY KEY (`idUFs`),
  INDEX `fk_UFs_Modulos_idx` (`Modulos_idModulos` ASC) VISIBLE,
  CONSTRAINT `fk_UFs_Modulos`
    FOREIGN KEY (`Modulos_idModulos`)
    REFERENCES `Notas`.`Modulos` (`idModulos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Notas`.`Alumnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Notas`.`Alumnos` (
  `idAlumnos` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `DNI` VARCHAR(10) NOT NULL,
  `Direccion` VARCHAR(45) NULL,
  `Telefono` VARCHAR(9) NULL,
  PRIMARY KEY (`idAlumnos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Notas`.`Notas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Notas`.`Notas` (
  `Alumnos_idAlumnos` INT NOT NULL,
  `UFs_idUFs` VARCHAR(6) NOT NULL,
  `Nota` FLOAT NOT NULL,
  PRIMARY KEY (`Alumnos_idAlumnos`, `UFs_idUFs`),
  INDEX `fk_Alumnos_has_UFs_UFs1_idx` (`UFs_idUFs` ASC) VISIBLE,
  INDEX `fk_Alumnos_has_UFs_Alumnos1_idx` (`Alumnos_idAlumnos` ASC) VISIBLE,
  CONSTRAINT `fk_Alumnos_has_UFs_Alumnos1`
    FOREIGN KEY (`Alumnos_idAlumnos`)
    REFERENCES `Notas`.`Alumnos` (`idAlumnos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alumnos_has_UFs_UFs1`
    FOREIGN KEY (`UFs_idUFs`)
    REFERENCES `Notas`.`UFs` (`idUFs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Notas`.`Modulos`
-- -----------------------------------------------------
START TRANSACTION;
USE `Notas`;
INSERT INTO `Notas`.`Modulos` (`idModulos`, `Nombre_modulo`, `horas`, `Profesor`) VALUES (MF0226_3, 'Programacion de base de datos relacionales', 210, 'Armando Laplana');
INSERT INTO `Notas`.`Modulos` (`idModulos`, `Nombre_modulo`, `horas`, `Profesor`) VALUES (MF0223_3, 'Sistemas operativos y aplicaciones informaticas', 170, 'Cristian Cevallos');
INSERT INTO `Notas`.`Modulos` (`idModulos`, `Nombre_modulo`, `horas`, `Profesor`) VALUES (MF0227_3, 'Programación orientada a objetos', 250, 'Cristian Granados');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Notas`.`UFs`
-- -----------------------------------------------------
START TRANSACTION;
USE `Notas`;
INSERT INTO `Notas`.`UFs` (`idUFs`, `nombre_uf`, `horas`, `Modulos_idModulos`) VALUES (' UF2175', 'Diseno de bases de datos relacionales', 50, MF0226_3);
INSERT INTO `Notas`.`UFs` (`idUFs`, `nombre_uf`, `horas`, `Modulos_idModulos`) VALUES ('UF2176', 'Definicion y manipulacion de datos', 80, MF0226_3);
INSERT INTO `Notas`.`UFs` (`idUFs`, `nombre_uf`, `horas`, `Modulos_idModulos`) VALUES ('UF2404', 'Principios de la programacion orientada a objetos', 90, MF0227_3);
INSERT INTO `Notas`.`UFs` (`idUFs`, `nombre_uf`, `horas`, `Modulos_idModulos`) VALUES ('UF1467', 'Aplicaciones microinformaticas e internet para consulta y generacion de documentacion', 40, MF0223_3);
INSERT INTO `Notas`.`UFs` (`idUFs`, `nombre_uf`, `horas`, `Modulos_idModulos`) VALUES ('UF2177', 'Desarrollo de programas en el entorno de la base de datos', 80, MF0226_3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Notas`.`Alumnos`
-- -----------------------------------------------------
START TRANSACTION;
USE `Notas`;
INSERT INTO `Notas`.`Alumnos` (`idAlumnos`, `Nombre`, `DNI`, `Direccion`, `Telefono`) VALUES (1, 'Karen', '32442341G', 'BCN', '642353453');
INSERT INTO `Notas`.`Alumnos` (`idAlumnos`, `Nombre`, `DNI`, `Direccion`, `Telefono`) VALUES (2, 'Glennys', '34546623D', 'BCN', '645534535');
INSERT INTO `Notas`.`Alumnos` (`idAlumnos`, `Nombre`, `DNI`, `Direccion`, `Telefono`) VALUES (3, 'Jan', '43847829H', 'Hospitalet', '633211345');
INSERT INTO `Notas`.`Alumnos` (`idAlumnos`, `Nombre`, `DNI`, `Direccion`, `Telefono`) VALUES (4, 'Beatriz', '45324455D', 'Rubi', '622443231');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Notas`.`Notas`
-- -----------------------------------------------------
START TRANSACTION;
USE `Notas`;
INSERT INTO `Notas`.`Notas` (`Alumnos_idAlumnos`, `UFs_idUFs`, `Nota`) VALUES (1, 'UF2175', 8);
INSERT INTO `Notas`.`Notas` (`Alumnos_idAlumnos`, `UFs_idUFs`, `Nota`) VALUES (1, 'UF2176', 9);
INSERT INTO `Notas`.`Notas` (`Alumnos_idAlumnos`, `UFs_idUFs`, `Nota`) VALUES (1, 'UF2177', 6);
INSERT INTO `Notas`.`Notas` (`Alumnos_idAlumnos`, `UFs_idUFs`, `Nota`) VALUES (2, 'UF2175', 7);
INSERT INTO `Notas`.`Notas` (`Alumnos_idAlumnos`, `UFs_idUFs`, `Nota`) VALUES (2, 'UF2176', 10);
INSERT INTO `Notas`.`Notas` (`Alumnos_idAlumnos`, `UFs_idUFs`, `Nota`) VALUES (2, 'UF2177', 7.5);
INSERT INTO `Notas`.`Notas` (`Alumnos_idAlumnos`, `UFs_idUFs`, `Nota`) VALUES (3, 'UF2175', 10);
INSERT INTO `Notas`.`Notas` (`Alumnos_idAlumnos`, `UFs_idUFs`, `Nota`) VALUES (3, 'UF2176', 8.5);
INSERT INTO `Notas`.`Notas` (`Alumnos_idAlumnos`, `UFs_idUFs`, `Nota`) VALUES (3, 'UF2177', 9.5);

COMMIT;

