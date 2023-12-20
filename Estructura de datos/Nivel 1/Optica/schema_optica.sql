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
-- -----------------------------------------------------
-- Schema universidad
-- -----------------------------------------------------
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(200) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `fax` VARCHAR(45) NULL,
  `nif` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`marca` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `proveedor_id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_marca_proveedor1_idx` (`proveedor_id` ASC) VISIBLE,
  CONSTRAINT `fk_marca_proveedor1`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `optica`.`proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `marca_id` INT NOT NULL,
  `graduacion_dch` DECIMAL(5,2) NOT NULL,
  `graduacion_izq` DECIMAL(5,2) NOT NULL,
  `montura` ENUM('flotante', 'pasta', 'metalica') NOT NULL,
  `color_montura` VARCHAR(45) NOT NULL,
  `color_cristal_dch` VARCHAR(45) NOT NULL,
  `color_cristal_izq` VARCHAR(45) NOT NULL,
  `precio` FLOAT(6,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_gafas_marca1_idx` (`marca_id` ASC) VISIBLE,
  CONSTRAINT `fk_gafas_marca1`
    FOREIGN KEY (`marca_id`)
    REFERENCES `optica`.`marca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `clientes_recomen_id` INT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(200) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `fecha_alta` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clientes_clientes1_idx` (`clientes_recomen_id` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_clientes1`
    FOREIGN KEY (`clientes_recomen_id`)
    REFERENCES `optica`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`empleado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`ventas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `empleado_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  `gafas_id` INT NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `empleados_id_idx` (`empleado_id` ASC) VISIBLE,
  INDEX `clientes_id_idx` (`cliente_id` ASC) VISIBLE,
  INDEX `fk_ventas_gafas1_idx` (`gafas_id` ASC) VISIBLE,
  CONSTRAINT `empleado_id`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `optica`.`empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cliente_id`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `optica`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_gafas1`
    FOREIGN KEY (`gafas_id`)
    REFERENCES `optica`.`gafas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO optica.proveedor (nombre, direccion, telefono, fax, nif)
VALUES 
	('Cristal', 'Calle Principal Nº 1, bajos, 08015 Barcelona España', '934550986', '934550986', '43948598E'),
    ('Visión', 'Calle Crucero Nº 22, Nave3, 31001 Pamplona España', '9482325466', NULL, '25948548A');
    
INSERT INTO optica.marca (proveedor_id, nombre)
VALUES
    (1, 'Rayan'),
    (2, 'Toñi');
    
INSERT INTO optica.gafas (marca_id, graduacion_dch, graduacion_izq, montura, color_montura, color_cristal_dch, color_cristal_izq, precio)
VALUES
    (1, 12.25, 10.50, 'flotante', 'Negro', 'Azul', 'Verde', 150.00),
    (2, 5.15, 7.75, 'pasta', 'Rojo', 'Amarillo', 'Azul', 200.00);
    
    
INSERT INTO optica.empleado (nombre, apellido1, apellido2)
VALUES
	('Celia', 'Monzón', 'Gutierrez'),
    ('Marcos', 'Martorell', 'Montes');
    
INSERT INTO optica.clientes (clientes_recomen_id, nombre, direccion, telefono, email, fecha_alta)
VALUES 
	(NULL, 'Pedro', 'Calle Fontanals 45 1º 5ª 08012 Barcelona', '934566543', 'pedro@emali.com', '2023-01-01'), 
    (1, 'Asunción', 'Calle Rentas 33 Atico 3ª 08222 Terrassa', '934464544', 'asuncion@emali.com', '2023-01-01');
    
INSERT INTO optica.ventas (empleado_id, cliente_id, gafas_id, fecha)
VALUES
    (1, 1, 1, '2023-01-03'),
    (1, 1, 2, '2023-01-03'),
    (2, 2, 2, '2023-01-04');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
