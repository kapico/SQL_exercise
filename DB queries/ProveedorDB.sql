-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Proveedores
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Proveedores` ;

-- -----------------------------------------------------
-- Schema Proveedores
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Proveedores` DEFAULT CHARACTER SET utf8 ;
USE `Proveedores` ;

-- -----------------------------------------------------
-- Table `Proveedores`.`Pieza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proveedores`.`Pieza` (
  `Codigo` INT NOT NULL,
  `nombre` VARCHAR(255) NULL,
  PRIMARY KEY (`Codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proveedores`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proveedores`.`Proveedor` (
  `identificador` VARCHAR(255) NOT NULL,
  `nombre` VARCHAR(255) NULL,
  PRIMARY KEY (`identificador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proveedores`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proveedores`.`compra` (
  `Pieza_Codigo` INT NOT NULL,
  `Proveedor_identificador` VARCHAR(255) NOT NULL,
  `precio` FLOAT NULL,
  CONSTRAINT `fk_Pieza_has_Proveedor_Pieza`
    FOREIGN KEY (`Pieza_Codigo`)
    REFERENCES `Proveedores`.`Pieza` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pieza_has_Proveedor_Proveedor1`
    FOREIGN KEY (`Proveedor_identificador`)
    REFERENCES `Proveedores`.`Proveedor` (`identificador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Proveedores`.`Pieza`
-- -----------------------------------------------------
START TRANSACTION;
USE `Proveedores`;
INSERT INTO `Proveedores`.`Pieza` (`Codigo`, `nombre`) VALUES (10, 'Tornillo TRL');
INSERT INTO `Proveedores`.`Pieza` (`Codigo`, `nombre`) VALUES (11, 'Motor MLT');
INSERT INTO `Proveedores`.`Pieza` (`Codigo`, `nombre`) VALUES (12, 'Rueda IZQ');
INSERT INTO `Proveedores`.`Pieza` (`Codigo`, `nombre`) VALUES (13, 'Tuerca TRC');
INSERT INTO `Proveedores`.`Pieza` (`Codigo`, `nombre`) VALUES (14, 'Rueda DRC');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Proveedores`.`Proveedor`
-- -----------------------------------------------------
START TRANSACTION;
USE `Proveedores`;
INSERT INTO `Proveedores`.`Proveedor` (`identificador`, `nombre`) VALUES ('A2TH', 'Tus piezas al momento, S.L');
INSERT INTO `Proveedores`.`Proveedor` (`identificador`, `nombre`) VALUES ('SHG4', 'Recambios y piezas, S.L');
INSERT INTO `Proveedores`.`Proveedor` (`identificador`, `nombre`) VALUES ('KFI3', 'Gran proveedor de piezas, S.A');
INSERT INTO `Proveedores`.`Proveedor` (`identificador`, `nombre`) VALUES ('DG34', ' Las piezas de la calle 34, S.L');
INSERT INTO `Proveedores`.`Proveedor` (`identificador`, `nombre`) VALUES ('TGLR', 'Super piezas, SCP');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Proveedores`.`compra`
-- -----------------------------------------------------
START TRANSACTION;
USE `Proveedores`;
INSERT INTO `Proveedores`.`compra` (`Pieza_Codigo`, `Proveedor_identificador`, `precio`) VALUES (10, 'A2TH', 1.25);
INSERT INTO `Proveedores`.`compra` (`Pieza_Codigo`, `Proveedor_identificador`, `precio`) VALUES (11, 'KFI3', 124.50);
INSERT INTO `Proveedores`.`compra` (`Pieza_Codigo`, `Proveedor_identificador`, `precio`) VALUES (12, 'SHG4', 46.78);
INSERT INTO `Proveedores`.`compra` (`Pieza_Codigo`, `Proveedor_identificador`, `precio`) VALUES (13, 'TGLR', 2.34);
INSERT INTO `Proveedores`.`compra` (`Pieza_Codigo`, `Proveedor_identificador`, `precio`) VALUES (14, 'KFI3', 44.34);
INSERT INTO `Proveedores`.`compra` (`Pieza_Codigo`, `Proveedor_identificador`, `precio`) VALUES (10, 'SHG4', 1.09);
INSERT INTO `Proveedores`.`compra` (`Pieza_Codigo`, `Proveedor_identificador`, `precio`) VALUES (11, 'SHG4', 129.69);
INSERT INTO `Proveedores`.`compra` (`Pieza_Codigo`, `Proveedor_identificador`, `precio`) VALUES (13, 'DG34', 2.28);
INSERT INTO `Proveedores`.`compra` (`Pieza_Codigo`, `Proveedor_identificador`, `precio`) VALUES (10, 'DG34', 1.19);
INSERT INTO `Proveedores`.`compra` (`Pieza_Codigo`, `Proveedor_identificador`, `precio`) VALUES (12, 'KFI3', 46.80);
INSERT INTO `Proveedores`.`compra` (`Pieza_Codigo`, `Proveedor_identificador`, `precio`) VALUES (14, 'TGLR', 45.95);
INSERT INTO `Proveedores`.`compra` (`Pieza_Codigo`, `Proveedor_identificador`, `precio`) VALUES (11, 'A2TH', 131.50);
INSERT INTO `Proveedores`.`compra` (`Pieza_Codigo`, `Proveedor_identificador`, `precio`) VALUES (12, 'TGLR', 49.90);

COMMIT;

-- -----------------------------------------------------
-- CONSULTAS PARA `Proveedores`.`compra`
-- -----------------------------------------------------

-- --------------------------------------------------------------------------------------------------------------------------
-- 1. Obtener el nombre de todas las piezas.
-- --------------------------------------------------------------------------------------------------------------------------

Select nombre from pieza;

-- --------------------------------------------------------------------------------------------------------------------------
-- 2. Obtener todos los datos de todos los proveedores.
-- --------------------------------------------------------------------------------------------------------------------------

Select * from Proveedor;

-- --------------------------------------------------------------------------------------------------------------------------
-- 3. Obtener el precio medio al que se nos suministran las piezas.
-- --------------------------------------------------------------------------------------------------------------------------
use proveedores;
Select truncate(avg(precio),2) from compra;

-- --------------------------------------------------------------------------------------------------------------------------
-- 4. Obtener los identificadores de los proveedores que suministran la pieza 10.
-- --------------------------------------------------------------------------------------------------------------------------

Select Proveedor_identificador from compra where Pieza_codigo =10;

-- --------------------------------------------------------------------------------------------------------------------------
-- 5. Obtener los nombres de los proveedores que suministran las piezas más caras, indicando el precio al que la suministran.
-- --------------------------------------------------------------------------------------------------------------------------

Select nombre, max(precio) from proveedor, compra
	where PROVEEDOR.identificador = COMPRA.Proveedor_identificador 
		group by proveedor_identificador;
        
-- ---------------------------------------------------------------------------------------------------------------------------
-- 6. Hacer constar en la base de datos que la empresa “Tus piezas al momento, S.L.” va a empezar a suministrarnos Tuerca TRC 
-- a 2,19 cada una.
-- ---------------------------------------------------------------------------------------------------------------------------

UPDATE compra
	SET precio = 2.19
		WHERE pieza_codigo = 13;
Select * from compra;

INSERT INTO `Proveedores`.`compra` (`Pieza_Codigo`, `Proveedor_identificador`, `precio`) VALUES (13, 'A2TH', 2.19);

-- ---------------------------------------------------------------------------------------------------------------------------
-- 7. Aumentar los precios en diez céntimos.
-- ---------------------------------------------------------------------------------------------------------------------------

SET SQL_SAFE_UPDATES = 0;
	UPDATE compra
		SET precio = precio + 0.10;
Select precio from compra;

-- ---------------------------------------------------------------------------------------------------------------------------
-- 8. Hacer constar en la base de datos que la empresa “Las piezas de la calle 34, S.L.” no va a suministrarnos ninguna pieza 
-- (aunque la empresa sí va a seguir constando en nuestra base de datos).
-- ---------------------------------------------------------------------------------------------------------------------------

-- El estado indica: 1 que el proveedor está suministrando y 0 que el proveedor ha dejado de suministrar

ALTER TABLE proveedor
	ADD COLUMN estado TINYINT NOT NULL DEFAULT 1 ;
UPDATE proveedor
		SET estado = 0
			where nombre = ' Las piezas de la calle 34, S.L';
select nombre, estado from proveedor;

delete from compra where identificador = 'DG34';