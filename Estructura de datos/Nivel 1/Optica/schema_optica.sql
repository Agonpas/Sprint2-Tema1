-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;

USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `fax` VARCHAR(45) NULL,
  `nif` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`empleados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`recomendacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`recomendacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `clientes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recomendacion_clientes1_idx` (`clientes_id` ASC) VISIBLE,
  CONSTRAINT `fk_recomendacion_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `optica`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `recomendacion_id` INT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `fecha_alta` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clientes_recomendacion1_idx` (`recomendacion_id` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_recomendacion1`
    FOREIGN KEY (`recomendacion_id`)
    REFERENCES `optica`.`recomendacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`ventas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `gafas_id` INT NOT NULL,
  `empleados_id` INT NOT NULL,
  `clientes_id` INT NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `gafas_id_idx` (`gafas_id` ASC) VISIBLE,
  INDEX `empleados_id_idx` (`empleados_id` ASC) VISIBLE,
  INDEX `clientes_id_idx` (`clientes_id` ASC) VISIBLE,
  CONSTRAINT `gafas_id`
    FOREIGN KEY (`gafas_id`)
    REFERENCES `optica`.`gafas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `empleados_id`
    FOREIGN KEY (`empleados_id`)
    REFERENCES `optica`.`empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `clientes_id`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `optica`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `proveedor_id` INT NOT NULL,
  `ventas_id` INT NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `graduacion_dch` INT(5) NOT NULL,
  `graduacion_izq` INT(5) NOT NULL,
  `montura` ENUM('flotante', 'pasta', 'metalica') NOT NULL,
  `color_montura` VARCHAR(45) NOT NULL,
  `color_cristal_dch` VARCHAR(45) NOT NULL,
  `color_cristal_izq` VARCHAR(45) NOT NULL,
  `precio` FLOAT(6,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `proveedor_id_idx` (`proveedor_id` ASC) VISIBLE,
  INDEX `ventas_id_idx` (`ventas_id` ASC) VISIBLE,
  CONSTRAINT `proveedor_id`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `optica`.`proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ventas_id`
    FOREIGN KEY (`ventas_id`)
    REFERENCES `optica`.`ventas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insertamos datos de ejemplo para poder hacer consultas

INSERT INTO optica.proveedor (nombre, direccion, telefono, fax, nif)
VALUES 
	('Cristal', 'Calle Principal Nº 1, bajos, 08015 Barcelona España', '934550986', '934550986', '43948598E'),
    ('Visión', 'Calle Crucero Nº 22, Nave3, 31001 Pamplona España', '9482325466', NULL, '25948548A');

INSERT INTO optica.empleados (nombre, apellido1, apellido2)
VALUES
	('Celia', 'Monzón', 'Gutierrez'),
    ('Marcos', 'Martorell', 'Montes');
    
INSERT INTO optica.clientes (recomendacion_id, nombre, direccion, telefono, email, fecha_alta)
VALUES 
	(NULL, 'Pedro', 'Calle Fontanals 45 1º 5ª 08012 Barcelona', '934566543', 'pedro@emali.com', '2023-01-01'), 
    (1, 'Asunción', 'Calle Rentas 33 Atico 3ª 08222 Terrassa', '934464544', 'asuncion@emali.com', '2023-01-01');
    
INSERT INTO optica.gafas (proveedor_id, ventas_id, marca, graduacion_dch, graduacion_izq, montura, color_montura, color_cristal_dch, color_cristal_izq, precio)
VALUES
    (1, 1, 'Rayan', 12, 10, 'flotante', 'Negro', 'Azul', 'Verde', 150.00),
    (2, 2, 'Toñi', 5, 7, 'pasta', 'Rojo', 'Amarillo', 'Azul', 200.00);
    
INSERT INTO optica.recomendacion (clientes_id)
VALUES
    (1),
    (2);
    
INSERT INTO optica.ventas (gafas_id, empleados_id, clientes_id, fecha)
VALUES
    (1, 1, 1, '2023-01-03'),
    (2, 2, 2, '2023-01-04');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

