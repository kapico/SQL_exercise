-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Ecommerce
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Ecommerce` ;

-- -----------------------------------------------------
-- Schema Ecommerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Ecommerce` DEFAULT CHARACTER SET utf8 ;
USE `Ecommerce` ;

-- -----------------------------------------------------
-- Table `Ecommerce`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Cliente` (
  `dni` VARCHAR(10) NOT NULL,
  `nombre_cliente` VARCHAR(100) NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` INT(9) NULL,
  PRIMARY KEY (`dni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Usuario` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `Cliente_dni` VARCHAR(10) NOT NULL,
  CONSTRAINT `fk_Usuario_Cliente1`
    FOREIGN KEY (`Cliente_dni`)
    REFERENCES `Ecommerce`.`Cliente` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Ecommerce`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Categoria` (
  `categoria_id` INT NOT NULL,
  `nombre` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`categoria_id`));


-- -----------------------------------------------------
-- Table `Ecommerce`.`timestamps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`timestamps` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NULL);


-- -----------------------------------------------------
-- Table `Ecommerce`.`infopago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`infopago` (
  `numero_tarjeta` INT(19) NOT NULL,
  `ccv` INT(3) NOT NULL,
  `nombre` VARCHAR(225) NOT NULL,
  `expira` YEAR(4) NOT NULL,
  `Cliente_dni` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`numero_tarjeta`),
  CONSTRAINT `fk_infopago_Cliente1`
    FOREIGN KEY (`Cliente_dni`)
    REFERENCES `Ecommerce`.`Cliente` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`producto` (
  `idproducto` INT NOT NULL AUTO_INCREMENT,
  `precio` DECIMAL(6,2) NULL,
  `nombre` VARCHAR(225) NULL,
  `Categoria_categoria_id` INT NOT NULL,
  PRIMARY KEY (`idproducto`),
  CONSTRAINT `fk_producto_Categoria1`
    FOREIGN KEY (`Categoria_categoria_id`)
    REFERENCES `Ecommerce`.`Categoria` (`categoria_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`compra` (
  `producto_idproducto` INT NOT NULL,
  `fecha_compra` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `Cliente_dni` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`producto_idproducto`, `Cliente_dni`),
  CONSTRAINT `fk_producto_has_Cliente_producto1`
    FOREIGN KEY (`producto_idproducto`)
    REFERENCES `Ecommerce`.`producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_Cliente1`
    FOREIGN KEY (`Cliente_dni`)
    REFERENCES `Ecommerce`.`Cliente` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Ecommerce`.`Cliente`
-- -----------------------------------------------------
START TRANSACTION;
USE `Ecommerce`;
INSERT INTO `Ecommerce`.`Cliente` (`dni`, `nombre_cliente`, `direccion`, `telefono`) VALUES ('12847239D', 'cliente1', 'calle sagrada familia', 345623123);
INSERT INTO `Ecommerce`.`Cliente` (`dni`, `nombre_cliente`, `direccion`, `telefono`) VALUES ('12345678G', 'cliente2', 'plaza machado', 123456789);
INSERT INTO `Ecommerce`.`Cliente` (`dni`, `nombre_cliente`, `direccion`, `telefono`) VALUES ('12345678R', 'cliente3', 'calle montgat', 84723928);
INSERT INTO `Ecommerce`.`Cliente` (`dni`, `nombre_cliente`, `direccion`, `telefono`) VALUES ('12345678L', 'cliente4', 'calle manresa', 23456732);
INSERT INTO `Ecommerce`.`Cliente` (`dni`, `nombre_cliente`, `direccion`, `telefono`) VALUES ('12345678F', 'cliente5', 'calle calella', 12345975);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Ecommerce`.`Usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `Ecommerce`;
INSERT INTO `Ecommerce`.`Usuario` (`username`, `email`, `password`, `create_time`, `Cliente_dni`) VALUES ('abcd1', '1@hotmail.com', '123456', NULL, '12847239D');
INSERT INTO `Ecommerce`.`Usuario` (`username`, `email`, `password`, `create_time`, `Cliente_dni`) VALUES ('defg1', '2@hotmail.com', '789910', NULL, '12345678G');
INSERT INTO `Ecommerce`.`Usuario` (`username`, `email`, `password`, `create_time`, `Cliente_dni`) VALUES ('abcd2', '3@hotmail.com', 'fwerd23', NULL, '12345678R');
INSERT INTO `Ecommerce`.`Usuario` (`username`, `email`, `password`, `create_time`, `Cliente_dni`) VALUES ('abcd3', '4@hotmail.com', '323das', NULL, '12345678L');
INSERT INTO `Ecommerce`.`Usuario` (`username`, `email`, `password`, `create_time`, `Cliente_dni`) VALUES ('abcd4', '5@hotmail.com', '23edd', NULL, '12345678F');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Ecommerce`.`Categoria`
-- -----------------------------------------------------
START TRANSACTION;
USE `Ecommerce`;
INSERT INTO `Ecommerce`.`Categoria` (`categoria_id`, `nombre`) VALUES (1, 'Vestidos');
INSERT INTO `Ecommerce`.`Categoria` (`categoria_id`, `nombre`) VALUES (2, 'Faldas');
INSERT INTO `Ecommerce`.`Categoria` (`categoria_id`, `nombre`) VALUES (3, 'Accesorios');
INSERT INTO `Ecommerce`.`Categoria` (`categoria_id`, `nombre`) VALUES (4, 'Pantalones');
INSERT INTO `Ecommerce`.`Categoria` (`categoria_id`, `nombre`) VALUES (5, 'Blusas');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Ecommerce`.`infopago`
-- -----------------------------------------------------
START TRANSACTION;
USE `Ecommerce`;
INSERT INTO `Ecommerce`.`infopago` (`numero_tarjeta`, `ccv`, `nombre`, `expira`, `Cliente_dni`) VALUES (9843256789444444444, 234, 'cliente1', 2025, '12847239D');
INSERT INTO `Ecommerce`.`infopago` (`numero_tarjeta`, `ccv`, `nombre`, `expira`, `Cliente_dni`) VALUES (3224231221555555555, 312, 'cliente2', 2030, '12345678G');
INSERT INTO `Ecommerce`.`infopago` (`numero_tarjeta`, `ccv`, `nombre`, `expira`, `Cliente_dni`) VALUES (2312424241666666666, 342, 'cliente3', 2027, '12345678R');
INSERT INTO `Ecommerce`.`infopago` (`numero_tarjeta`, `ccv`, `nombre`, `expira`, `Cliente_dni`) VALUES (3333344441999999999, 111, 'cliente5', 2024, '12345678F');
INSERT INTO `Ecommerce`.`infopago` (`numero_tarjeta`, `ccv`, `nombre`, `expira`, `Cliente_dni`) VALUES (235251243222222222, 453, 'otro cliente', 2023, '12345678F');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Ecommerce`.`producto`
-- -----------------------------------------------------
START TRANSACTION;
USE `Ecommerce`;
INSERT INTO `Ecommerce`.`producto` (`idproducto`, `precio`, `nombre`, `Categoria_categoria_id`) VALUES (DEFAULT, 2,00, 'top blanco mujer', 5);
INSERT INTO `Ecommerce`.`producto` (`idproducto`, `precio`, `nombre`, `Categoria_categoria_id`) VALUES (DEFAULT, 10,00, 'pantalon amarillo cuero hombre', 4);
INSERT INTO `Ecommerce`.`producto` (`idproducto`, `precio`, `nombre`, `Categoria_categoria_id`) VALUES (DEFAULT, 16,00, 'vestido corto rojo ', 1);
INSERT INTO `Ecommerce`.`producto` (`idproducto`, `precio`, `nombre`, `Categoria_categoria_id`) VALUES (DEFAULT, 45,00, 'vestido largo estampado', 1);
INSERT INTO `Ecommerce`.`producto` (`idproducto`, `precio`, `nombre`, `Categoria_categoria_id`) VALUES (DEFAULT, 65,00, 'reloj mujer', 3);
INSERT INTO `Ecommerce`.`producto` (`idproducto`, `precio`, `nombre`, `Categoria_categoria_id`) VALUES (DEFAULT, 25,00, 'pendientes de piedra swarosky', 3);

COMMIT;

