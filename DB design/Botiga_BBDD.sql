-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Botiga
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Botiga` ;

-- -----------------------------------------------------
-- Schema Botiga
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Botiga` DEFAULT CHARACTER SET utf8 ;
USE `Botiga` ;

-- -----------------------------------------------------
-- Table `Botiga`.`FABRICANTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Botiga`.`FABRICANTS` (
  `id_fabricant` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(30) NULL,
  PRIMARY KEY (`id_fabricant`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Botiga`.`ARTICLES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Botiga`.`ARTICLES` (
  `id_articles` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(30) NULL,
  `Preu` INT NULL,
  `id_fabricant` INT NOT NULL,
  PRIMARY KEY (`id_articles`),
  CONSTRAINT `fk_ARTICLES_FABRICANTS`
    FOREIGN KEY (`id_fabricant`)
    REFERENCES `Botiga`.`FABRICANTS` (`id_fabricant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Botiga`.`FABRICANTS`
-- -----------------------------------------------------
START TRANSACTION;
USE `Botiga`;
INSERT INTO `Botiga`.`FABRICANTS` (`id_fabricant`, `Nom`) VALUES (DEFAULT, 'Kingston');
INSERT INTO `Botiga`.`FABRICANTS` (`id_fabricant`, `Nom`) VALUES (DEFAULT, 'HP');
INSERT INTO `Botiga`.`FABRICANTS` (`id_fabricant`, `Nom`) VALUES (DEFAULT, 'Logitech');
INSERT INTO `Botiga`.`FABRICANTS` (`id_fabricant`, `Nom`) VALUES (DEFAULT, 'Nvidia');
INSERT INTO `Botiga`.`FABRICANTS` (`id_fabricant`, `Nom`) VALUES (DEFAULT, 'Seagate');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Botiga`.`ARTICLES`
-- -----------------------------------------------------
START TRANSACTION;
USE `Botiga`;
INSERT INTO `Botiga`.`ARTICLES` (`id_articles`, `Nom`, `Preu`, `id_fabricant`) VALUES (DEFAULT, 'Teclat', 20, 3);
INSERT INTO `Botiga`.`ARTICLES` (`id_articles`, `Nom`, `Preu`, `id_fabricant`) VALUES (DEFAULT, 'Disc dur 3TB', 200, 5);
INSERT INTO `Botiga`.`ARTICLES` (`id_articles`, `Nom`, `Preu`, `id_fabricant`) VALUES (DEFAULT, 'Mouse', 15, 3);
INSERT INTO `Botiga`.`ARTICLES` (`id_articles`, `Nom`, `Preu`, `id_fabricant`) VALUES (DEFAULT, 'Altaveu', 50, 3);
INSERT INTO `Botiga`.`ARTICLES` (`id_articles`, `Nom`, `Preu`, `id_fabricant`) VALUES (DEFAULT, 'Memoria Ram', 180, 1);
INSERT INTO `Botiga`.`ARTICLES` (`id_articles`, `Nom`, `Preu`, `id_fabricant`) VALUES (DEFAULT, 'Disc extern 2TB', 150, 2);
INSERT INTO `Botiga`.`ARTICLES` (`id_articles`, `Nom`, `Preu`, `id_fabricant`) VALUES (DEFAULT, 'Pendrive', 35, 1);
INSERT INTO `Botiga`.`ARTICLES` (`id_articles`, `Nom`, `Preu`, `id_fabricant`) VALUES (DEFAULT, 'Tarjeta de xarxa', 40, 5);
INSERT INTO `Botiga`.`ARTICLES` (`id_articles`, `Nom`, `Preu`, `id_fabricant`) VALUES (DEFAULT, 'Tarjeta de Video', 180, 4);
INSERT INTO `Botiga`.`ARTICLES` (`id_articles`, `Nom`, `Preu`, `id_fabricant`) VALUES (DEFAULT, 'Pantalla 21\'\'', 230, 2);

COMMIT;
