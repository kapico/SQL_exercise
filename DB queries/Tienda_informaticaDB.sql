SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Tienda_informatica
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Tienda_informatica` ;

-- -----------------------------------------------------
-- Schema Tienda_informatica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Tienda_informatica` DEFAULT CHARACTER SET utf8 ;
USE `Tienda_informatica` ;

-- -----------------------------------------------------
-- Table `Tienda_informatica`.`fabricante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda_informatica`.`fabricante` (
  `Codigo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NULL,
  PRIMARY KEY (`Codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tienda_informatica`.`articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda_informatica`.`articulo` (
  `Codigo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NULL,
  `precio` FLOAT NULL,
  `fabricante` INT NULL,
  PRIMARY KEY (`Codigo`),
   CONSTRAINT `fk_fabricante_has_fabricante`
    FOREIGN KEY (`fabricante`)
    REFERENCES `Tienda_informatica`.`fabricante` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Tienda_informatica`.`fabricante`
-- -----------------------------------------------------
START TRANSACTION;
USE `Tienda_informatica`;
INSERT INTO `Tienda_informatica`.`fabricante` (`Codigo`, `nombre`) VALUES (default, 'Hp');
INSERT INTO `Tienda_informatica`.`fabricante` (`Codigo`, `nombre`) VALUES (default, 'Lenovo');
INSERT INTO `Tienda_informatica`.`fabricante` (`Codigo`, `nombre`) VALUES (default, 'Msi');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Tienda_informatica`.`articulo`
-- -----------------------------------------------------
START TRANSACTION;
USE `Tienda_informatica`;
INSERT INTO `Tienda_informatica`.`articulo` (`codigo`, `nombre`, `precio`, `fabricante`) VALUES (default, 'Mouse', 5.00, 1);
INSERT INTO `Tienda_informatica`.`articulo` (`codigo`, `nombre`, `precio`, `fabricante`) VALUES (default, 'Pantalla DLC', 150.00, 2);
INSERT INTO `Tienda_informatica`.`articulo` (`codigo`, `nombre`, `precio`, `fabricante`) VALUES (default, 'Memoria RAM', 400.00, 3);
INSERT INTO `Tienda_informatica`.`articulo` (`codigo`, `nombre`, `precio`, `fabricante`) VALUES (default, 'Disco Duro 250GB', 120.00, 1);
INSERT INTO `Tienda_informatica`.`articulo` (`codigo`, `nombre`, `precio`, `fabricante`) VALUES (default, 'Teclado', 50.00, 2);
INSERT INTO `Tienda_informatica`.`articulo` (`codigo`, `nombre`, `precio`, `fabricante`) VALUES (default, 'Laptop', 1200.00, 3);
INSERT INTO `Tienda_informatica`.`articulo` (`codigo`, `nombre`, `precio`, `fabricante`) VALUES (default, 'Laptop', 950.00, 1);
INSERT INTO `Tienda_informatica`.`articulo` (`codigo`, `nombre`, `precio`, `fabricante`) VALUES (default, 'Placa Base', 350.00, 2);

COMMIT;

-- -------------------------------------------------------
-- CONSULTAS PARA `Tienda_informatica`
-- -------------------------------------------------------

USE `Tienda_informatica`;
Select * from fabricante;
Select * from articulo;

-- --------------------------------------------------------------------------------------
-- 1.1  Obtener los nombres de los productos de la tienda.
-- --------------------------------------------------------------------------------------
Select nombre from articulo;
-- --------------------------------------------------------------------------------------
-- 1.2  Obtener los nombres y los precios de los productos de la tienda.
-- -------------------------------------------------------------------------------------- 
Select nombre, precio from articulo;
-- --------------------------------------------------------------------------------------
-- 1.3  Obtener el nombre de los productos cuyo precio sea menor o igual a 200.
-- --------------------------------------------------------------------------------------
Select nombre from articulo where precio <= 200;
-- --------------------------------------------------------------------------------------
-- 1.4  Obtener todos los datos de los artículos cuyo precio esté entre
-- 		los 60 y los 120€ (ambas cantidades incluidas).
-- --------------------------------------------------------------------------------------
 Select * from articulo where precio between 60 and 120;
-- --------------------------------------------------------------------------------------
-- 1.5  Obtener el nombre y el precio en pesetas (es decir, el precio en euros 
-- 		multiplicado por 166’386).
-- --------------------------------------------------------------------------------------
Select nombre, precio as precio_euro, round(precio*166.386) as precio_peseta from articulo; 
-- --------------------------------------------------------------------------------------
-- 1.6  Seleccionar el precio medio de todos los productos.
-- --------------------------------------------------------------------------------------
Select avg(precio) from articulo as precio_medio;
-- -------------------------------------------------------------------------------------- 
-- 1.7  Obtener el precio medio de los artículos cuyo código de fabricante sea 2.
-- --------------------------------------------------------------------------------------
Select avg(precio) from articulo where fabricante = 2;
-- --------------------------------------------------------------------------------------
-- 1.8  Obtener el número de artículos cuyo precio sea mayor o igual a 180€.
-- --------------------------------------------------------------------------------------
Select count(codigo) from articulo where precio >= 180;
-- -------------------------------------------------------------------------------------- 
-- 1.9  Obtener el nombre y precio de los artículos cuyo precio sea mayor o igual a 180€ 
-- 		y ordenarlos descendentemente por precio, y luego ascendentemente por nombre.
-- --------------------------------------------------------------------------------------
Select nombre, precio from articulo where precio >= 180 
	order by precio desc, nombre asc;
-- --------------------------------------------------------------------------------------
-- 1.10  Obtener un listado completo de artículos, incluyendo por cada artículo los datos 
-- 		 del artículo y de su fabricante.
-- --------------------------------------------------------------------------------------
Select * from ARTICULO, FABRICANTE where FABRICANTE.Codigo = ARTICULO.Fabricante;
-- -------------------------------------------------------------------------------------- 
-- 1.11  Obtener un listado de artículos, incluyendo el nombre del artículo, su precio, 
-- 		 y el nombre de su fabricante.
-- --------------------------------------------------------------------------------------
Select articulo.nombre, articulo.precio, fabricante.nombre 
	from ARTICULO, FABRICANTE 
		where FABRICANTE.Codigo = ARTICULO.Fabricante;
-- --------------------------------------------------------------------------------------
-- 1.12  Obtener el precio medio de los productos de cada fabricante, mostrando solo los 
-- 		 códigos de fabricante.
-- ---------------------------------------------------------------------------------------
Select fabricante, avg(precio) from articulo
		group by fabricante;
-- ---------------------------------------------------------------------------------------
-- 1.13  Obtener el precio medio de los productos de cada fabricante, mostrando el nombre 
-- 		 del fabricante.
-- ---------------------------------------------------------------------------------------
Select avg(articulo.precio), fabricante.nombre 
	from ARTICULO, FABRICANTE 
		where FABRICANTE.Codigo = ARTICULO.Fabricante
			group by fabricante.nombre;
-- --------------------------------------------------------------------------------------- 
-- 1.14  Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio medio 
-- 		 sea mayor o igual a 150 €.
-- ---------------------------------------------------------------------------------------
Select articulo.precio, fabricante.nombre 
	from ARTICULO, FABRICANTE 
		where articulo.precio >= 150 and FABRICANTE.Codigo = ARTICULO.Fabricante;
-- ---------------------------------------------------------------------------------------
-- 1.15  Obtener el nombre y precio del artículo más barato.
-- ---------------------------------------------------------------------------------------
Select nombre, precio from articulo order by precio asc limit 1;
-- --------------------------------------------------------------------------------------- 
-- 1.16  Obtener una lista con el nombre y precio de los artículos más caros de cada 
-- 		 proveedor (incluyendo el nombre del proveedor).
-- ---------------------------------------------------------------------------------------
-- Mi solución: incorrecta porque pasa lo mismo y no selecciona nombre fabricante
Select nombre, max(precio) from articulo
		group by fabricante;
        
-- No selecciona el nombre del articulo correspondiente al precio mas grande        
Select A.nombre, max(Precio), F.nombre from ARTICULO A, FABRICANTE F 
where F.Codigo = A.Fabricante group by F.nombre;

-- ********************** SOLUCIÓN CLASE CORRECTA ****************************
select A.nombre, A.Precio, F.nombre from ARTICULO A, FABRICANTE F 
where F.Codigo = A.Fabricante
and A.Precio = (select max(A.precio) from ARTICULO A where A.Fabricante = F.Codigo);
-- ---------------------------------------------------------------------------------------
-- 1.17  Añadir un nuevo producto: Altavoces de 70 € (del fabricante 2).
-- ---------------------------------------------------------------------------------------
USE `Tienda_informatica`;
INSERT INTO `Tienda_informatica`.`articulo` (`codigo`, `nombre`, `precio`, `fabricante`) VALUES (default, 'Altavoces', 70.00, 2);
select * from articulo;
-- ---------------------------------------------------------------------------------------
-- 1.18  Cambiar el nombre del producto 8 a ’Impresora Láser’
-- ---------------------------------------------------------------------------------------
UPDATE articulo
	SET nombre = 'impresora Laser'
		WHERE codigo = 8;
Select * from articulo;
-- ---------------------------------------------------------------------------------------
-- 1.19  Aplicar un descuento del 10% a todos los productos.
-- ---------------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES = 0;
	UPDATE articulo
		SET precio = precio * 0.90;
Select precio from articulo;
-- ---------------------------------------------------------------------------------------
-- 1.20  Aplicar un descuento de 10€ mayor o igual a 120€.
-- ---------------------------------------------------------------------------------------
UPDATE articulo
		SET precio = precio - 10.00
			where precio >= 120;
Select precio from articulo;