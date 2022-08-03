-- MySQL GESTION DE VENTAS DB

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema GestionVentas
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `GestionVentas` ;

-- -----------------------------------------------------
-- Schema GestionVentas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `GestionVentas` DEFAULT CHARACTER SET utf8mb4;
USE `GestionVentas` ;

-- -----------------------------------------------------
-- Table `GestionVentas`.`Comercial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GestionVentas`.`Comercial` ;

CREATE TABLE IF NOT EXISTS `GestionVentas`.`Comercial` (
  `idComercial` INT NOT NULL,
  `Nombre` VARCHAR(100) NULL,
  `Apellido1` VARCHAR(100) NULL,
  `Apellido2` VARCHAR(100) NULL,
  `Ciudad` VARCHAR(100) NULL,
  `Comision` FLOAT NULL,
  PRIMARY KEY (`idComercial`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GestionVentas`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GestionVentas`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `GestionVentas`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Nombre` VARCHAR(100) NULL,
  `Apellido1` VARCHAR(100) NULL,
  `Apellido2` VARCHAR(100) NULL,
  `Ciudad` VARCHAR(100) NULL,
  `Categoria` INT(10) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GestionVentas`.`Pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GestionVentas`.`Pedido` ;

CREATE TABLE IF NOT EXISTS `GestionVentas`.`Pedido` (
  `idPedido` INT NOT NULL,
  `cantidad` DOUBLE NULL,
  `fecha` DATE NULL,
  `id_Comercial` INT NOT NULL,
  `id_Cliente` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  CONSTRAINT `fk_Pedido_Comercial`
    FOREIGN KEY (`id_Comercial`)
    REFERENCES `GestionVentas`.`Comercial` (`idComercial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`id_Cliente`)
    REFERENCES `GestionVentas`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- INSERTS
-- -----------------------------------------------------

USE GestionVentas;

INSERT INTO Cliente VALUES(1, 'Aarón', 'Rivero', 'Gómez', 'Almería', 100); 
INSERT INTO Cliente VALUES(2, 'Adela', 'Salas', 'Díaz', 'Granada', 200); 
INSERT INTO Cliente VALUES(3, 'Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL); 
INSERT INTO Cliente VALUES(4, 'Adrián', 'Suárez', NULL, 'Jaén', 300);
INSERT INTO Cliente VALUES(5, 'Marcos', 'Loyola', 'Méndez', 'Almería', 200); 
INSERT INTO Cliente VALUES(6, 'María', 'Santana', 'Moreno', 'Cádiz', 100); 
INSERT INTO Cliente VALUES(7, 'Pilar', 'Ruiz', NULL, 'Sevilla', 300);
INSERT INTO Cliente VALUES(8, 'Pepe', 'Ruiz', 'Santana', 'Huelva', 200); 
INSERT INTO Cliente VALUES(9, 'Guillermo', 'López', 'Gómez', 'Granada', 225); 
INSERT INTO Cliente VALUES(10, 'Daniel', 'Santana', 'Loyola', 'Sevilla',125);
INSERT INTO Comercial VALUES(1, 'Daniel', 'Sáez','Vega','Barcelona', 0.15); 
INSERT INTO Comercial VALUES(2, 'Juan', 'Gómez', 'López','Madrid', 0.13); 
INSERT INTO Comercial VALUES(3, 'Diego','Flores', 'Salas','Alicante',0.11); 
INSERT INTO Comercial VALUES(4, 'Marta','Herrera', 'Gil','Zaragoza', 0.14);
INSERT INTO Comercial VALUES(5, 'Antonio','Carretero', 'Ortega','Ciudad Real', 0.12); 
INSERT INTO Comercial VALUES(6, 'Manuel','Domínguez', 'Hernández','Sevilla', 0.13); 
INSERT INTO Comercial VALUES(7, 'Antonio','Vega', 'Hernández', 'Gijón', 0.11); 
INSERT INTO Comercial VALUES(8, 'Alfredo','Ruiz', 'Flores','Lleida', 0.05);
 
INSERT INTO Pedido VALUES(1, 150.5, '2017-10-05', 5, 2);
INSERT INTO Pedido VALUES(2, 270.65, '2016-09-10', 1, 5);
INSERT INTO Pedido VALUES(3, 65.26, '2017-10-05', 2, 1);
INSERT INTO Pedido VALUES(4, 110.5, '2016-08-17', 8, 3);
INSERT INTO Pedido VALUES(5, 948.5, '2017-09-10', 5, 2);
INSERT INTO Pedido VALUES(6, 2400.6, '2016-07-27', 7, 1);
INSERT INTO Pedido VALUES(7, 5760, '2015-09-10', 2, 1);
INSERT INTO Pedido VALUES(8, 1983.43, '2017-10-10', 4, 6);
INSERT INTO Pedido VALUES(9, 2480.4, '2016-10-10', 8, 3);
INSERT INTO Pedido VALUES(10, 250.45, '2015-06-27', 8, 2);
INSERT INTO Pedido VALUES(11, 75.29, '2016-08-17', 3, 7);
INSERT INTO Pedido VALUES(12, 3045.6, '2017-04-25', 2, 1);
INSERT INTO Pedido VALUES(13, 545.75, '2019-01-25', 6, 1);
INSERT INTO Pedido VALUES(14, 145.82, '2017-02-02', 6, 1);
INSERT INTO Pedido VALUES(15, 370.85, '2019-03-11', 1, 5);
INSERT INTO Pedido VALUES(16, 2389.23, '2019-03-11', 1, 5);
