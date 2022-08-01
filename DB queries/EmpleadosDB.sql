SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Empresa
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Empresa` ;

-- -----------------------------------------------------
-- Schema Empresa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Empresa` DEFAULT CHARACTER SET utf8 ;
USE `Empresa` ;

-- -----------------------------------------------------
-- Table `Empresa`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empresa`.`departamento` (
  `Codigo` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NULL,
  `Presupuesto` DOUBLE,
  PRIMARY KEY (`Codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empresa`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empresa`.`Empleado` (
  `Codigo` INT NOT NULL AUTO_INCREMENT,
  `nif` VARCHAR(9) NULL,
  `nombre` VARCHAR(100) NULL,
  `apellido1` VARCHAR(100) NULL,
  `apellido2` VARCHAR(100) NULL,
  `Codigo_departamento` INT NULL,
  PRIMARY KEY (`Codigo`),
   CONSTRAINT `fk_Codigo_departamento_has_departamento`
    FOREIGN KEY (`Codigo_departamento`)
    REFERENCES `Empresa`.`departamento` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Empresa`.`departamento`
-- -----------------------------------------------------
START TRANSACTION;
USE `Empresa`;
INSERT INTO `Empresa`.`departamento` (`Codigo`, `nombre`, `presupuesto`) VALUES (default, 'Marquetin', 1000.00);
INSERT INTO `Empresa`.`departamento` (`Codigo`, `nombre`, `presupuesto`) VALUES (default, 'IT', 800.00);
INSERT INTO `Empresa`.`departamento` (`Codigo`, `nombre`, `presupuesto`) VALUES (default, 'Direccion', 750.00);
INSERT INTO `Empresa`.`departamento` (`Codigo`, `nombre`, `presupuesto`) VALUES (default, 'Ventas', 1200.00);
INSERT INTO `Empresa`.`departamento` (`Codigo`, `nombre`, `presupuesto`) VALUES (default, 'Contabilidad', 850.00);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Empresa`.`Empleado`
-- -----------------------------------------------------
START TRANSACTION;
USE `Tienda_informatica`;
INSERT INTO `Empresa`.`Empleado` (`Codigo`, `nif`, `nombre`, `apellido1`, `apellido2`, `Codigo_departamento`) VALUES (default, '12345678A', 'Maria', 'Sanchez', 'Campero', 1);
INSERT INTO `Empresa`.`Empleado` (`Codigo`, `nif`, `nombre`, `apellido1`, `apellido2`, `Codigo_departamento`) VALUES (default, '12345678B', 'Pedro', 'Rodriguez', 'Samir', 2);
INSERT INTO `Empresa`.`Empleado` (`Codigo`, `nif`, `nombre`, `apellido1`, `apellido2`, `Codigo_departamento`) VALUES (default, '12345678C', 'Montse', 'Perez', 'Patiño', 3);
INSERT INTO `Empresa`.`Empleado` (`Codigo`, `nif`, `nombre`, `apellido1`, `apellido2`, `Codigo_departamento`) VALUES (default, '12345678D', 'Fernando', 'Martinez', 'Loor', 4);
INSERT INTO `Empresa`.`Empleado` (`Codigo`, `nif`, `nombre`, `apellido1`, `apellido2`, `Codigo_departamento`) VALUES (default, '12345678E', 'Luis', 'Loor', 'Velez', 5);
INSERT INTO `Empresa`.`Empleado` (`Codigo`, `nif`, `nombre`, `apellido1`, `apellido2`, `Codigo_departamento`) VALUES (default, '12345678F', 'Luisa', 'Solorzano', 'Menendez', 1);
INSERT INTO `Empresa`.`Empleado` (`Codigo`, `nif`, `nombre`, `apellido1`, `apellido2`, `Codigo_departamento`) VALUES (default, '12345678G', 'Mariuxi', 'Quintero', 'Jerez', 2);
INSERT INTO `Empresa`.`Empleado` (`Codigo`, `nif`, `nombre`, `apellido1`, `apellido2`, `Codigo_departamento`) VALUES (default, '12345678H', 'Maryuri', 'Benitez', 'Benitez', 3);
INSERT INTO `Empresa`.`Empleado` (`Codigo`, `nif`, `nombre`, `apellido1`, `apellido2`, `Codigo_departamento`) VALUES (default, '12345678I', 'Matias', 'Alonso', 'Macias', 4);
INSERT INTO `Empresa`.`Empleado` (`Codigo`, `nif`, `nombre`, `apellido1`, `apellido2`, `Codigo_departamento`) VALUES (default, '12345678J', 'Ibeth', 'Torres', 'Lopez', 5);

COMMIT;

-- -------------------------------------------------------
-- CONSULTAS PARA `Empresa`
-- -------------------------------------------------------

USE `Empresa`;
Select * from departamento;
Select * from empleado;

-- 1. 	Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.

-- SQL1
SELECT *
	FROM empleado, departamento
		WHERE empleado.codigo_departamento = departamento.codigo;
        
-- SQL2
SELECT *
	FROM empleado INNER JOIN departamento
		ON empleado.codigo_departamento = departamento.codigo;

  
-- 2. 	Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. 
-- 		Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en 
-- 		segundo lugar por los apellidos y el nombre de los empleados.

-- SQL1
SELECT *
	FROM empleado, departamento
		WHERE empleado.codigo_departamento = departamento.codigo
			order by departamento.nombre, empleado.apellido1, empleado.apellido2, empleado.nombre asc;
        
-- SQL2
SELECT *
	FROM empleado INNER JOIN departamento
		ON empleado.codigo_departamento = departamento.codigo
			order by departamento.nombre, empleado.apellido1, empleado.apellido2, empleado.nombre asc;
        
-- 3. 	Devuelve un listado con el código y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.

        UPDATE Empleado
		SET nombre = null
        where Codigo=1;
-- SQL2

SELECT distinct D.codigo, D.nombre
	FROM Departamento D INNER JOIN Empleado E
		ON  D.codigo = E.codigo_departamento;

-- 4. 	Devuelve un listado con el código, el nombre del departamento y el valor del presupuesto actual del que dispone, 
-- 		solamente de aquellos departamentos que tienen empleados. El valor del presupuesto actual lo puede calcular restando 
-- 		al valor del presupuesto inicial (columna presupuesto) el valor de los gastos que ha generado (columna gastos).

-- SQL2

SELECT D.Codigo, D.nombre, D.presupuesto - D.gastos
	FROM empleado E INNER JOIN departamento D
		ON E.codigo_departamento = D.codigo group by D.codigo;
            
-- 5. 	Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.

-- SQL2

SELECT departamento.nombre
	FROM empleado INNER JOIN departamento
		ON empleado.codigo_departamento = departamento.codigo
			where empleado.nif = '38382980M';

-- 6. 	Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.

-- SQL2

SELECT departamento.nombre
	FROM empleado INNER JOIN departamento
		ON empleado.codigo_departamento = departamento.codigo
			where empleado.nombre = 'Pepe' and empleado.apellido1 = 'Ruiz' and empleado.apellido2 = 'Santana';
            -- concat_ws(' ', empleado.nombre,empleado.apellido1, empleado.apellido2) like "Pepe Ruiz Santana"
-- 7. 	Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. 
-- 		Ordena el resultado alfabéticamente.

-- SQL2

SELECT empleado.nif, concat_ws(' ', empleado.nombre, empleado.apellido1, empleado.apellido2)
	FROM empleado INNER JOIN departamento
		ON empleado.codigo_departamento = departamento.codigo
			where departamento.nombre = 'IT';

-- 8. 	Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, 
-- 		Contabilidad o I+D. Ordena el resultado alfabéticamente.

SELECT empleado.nif, concat_ws(' ', empleado.nombre, empleado.apellido1, empleado.apellido2)
	FROM empleado INNER JOIN departamento
		ON empleado.codigo_departamento = departamento.codigo
			and departamento.nombre in ('contabilidad', 'i+D', 'IT') 
				order by empleado.nombre, empleado.apellido1, empleado.apellido2 asc;

-- 9. 	Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un 
-- 		presupuesto entre 100000 y 200000 euros.

SELECT concat_ws(' ', empleado.nombre, empleado.apellido1, empleado.apellido2)
	FROM empleado INNER JOIN departamento
		ON empleado.codigo_departamento = departamento.codigo
			where departamento.presupuesto not between 100000 and 200000;

-- 10. Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL. 
-- 		Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.

UPDATE Empleado
		SET apellido2 = null
        where Codigo=1 or Codigo=6 or Codigo=4;
-- SQL2

SELECT distinct D.nombre
	FROM Departamento D INNER JOIN Empleado E
		ON  D.codigo = E.codigo_departamento
			where E.apellido2 is null;
select * from empleado;