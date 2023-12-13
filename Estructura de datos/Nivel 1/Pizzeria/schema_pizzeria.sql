-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8mb3 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tienda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(100) NOT NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `id_clientes` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_clientes_idx` (`id_clientes` ASC) VISIBLE,
  CONSTRAINT `id_clientes`
    FOREIGN KEY (`id_clientes`)
    REFERENCES `pizzeria`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`trabajador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`trabajador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_tienda` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `puesto` ENUM('cocinero', 'repartidor') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_tienda_idx` (`id_tienda` ASC) VISIBLE,
  CONSTRAINT `id_tienda`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `pizzeria`.`tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`reparto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`reparto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora` DATETIME NOT NULL,
  `trabajador_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reparto_trabajador1_idx` (`trabajador_id` ASC) VISIBLE,
  CONSTRAINT `fk_reparto_trabajador1`
    FOREIGN KEY (`trabajador_id`)
    REFERENCES `pizzeria`.`trabajador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_tienda` INT NOT NULL,
  `reparto_id` INT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `entrega` ENUM('local', 'domicilio') NOT NULL,
  `precio_total` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_tienda_idx` (`id_tienda` ASC) VISIBLE,
  INDEX `fk_pedidos_reparto1_idx` (`reparto_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_tienda` 
    FOREIGN KEY (`id_tienda`)
    REFERENCES `pizzeria`.`tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_reparto1`
    FOREIGN KEY (`reparto_id`)
    REFERENCES `pizzeria`.`reparto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_categoria` INT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `imagen` BLOB NOT NULL,
  `precio_producto` FLOAT(6,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_categoria_idx` (`id_categoria` ASC) VISIBLE,
  CONSTRAINT `id_categoria`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `pizzeria`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`productos_has_pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`productos_has_pedidos` (
  `productos_id` INT NOT NULL,
  `pedidos_id` INT NOT NULL,
  `cantidad` INT(10) NOT NULL,
  PRIMARY KEY (`productos_id`, `pedidos_id`),
  INDEX `fk_productos_has_pedidos_pedidos1_idx` (`pedidos_id` ASC) VISIBLE,
  INDEX `fk_productos_has_pedidos_productos1_idx` (`productos_id` ASC) VISIBLE,
  CONSTRAINT `fk_productos_has_pedidos_productos1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `pizzeria`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_has_pedidos_pedidos1`
    FOREIGN KEY (`pedidos_id`)
    REFERENCES `pizzeria`.`pedidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

-- Insertamos datos de ejemplo para poder hacer consultas

INSERT INTO pizzeria.categoria (nombre)
VALUES
	('Masa fina'), -- 1
    ('Masa guresa'), -- 2
    ('Masa normal'); -- 3

INSERT INTO pizzeria.productos (id_categoria, nombre, descripcion, imagen, precio_producto)
VALUES
  (NULL, 'bebida', 'agua', '/ruta/imagenes/agua.jpg', 1.50),
  (NULL, 'bebida', 'cerveza', '/ruta/imagenes/cerveza.jpg', 2.50),
  (NULL, 'Hamburguesa', 'Bacon y queso', '/ruta/imagenes/hamburguesa.jpg', 6.50),
  (1, 'Pizza', 'Pizza Hawaiana', '/ruta/imagenes/pizza_hawaiana.jpg', 10.50),
  (2, 'Pizza', 'Pizza Pepperoni', '/ruta/imagenes/pizza_pepperoni.jpg', 11.00);

    
INSERT INTO pizzeria.trabajador (id_tienda, nombre, apellido1, apellido2, nif, telefono, puesto)
VALUES
    (1, 'Juan', 'González', 'López', '12345678A', '123-456-789', 'cocinero'), -- 1
    (1, 'Ana', 'Martínez', 'Fernández', '98765432B', '987-654-321', 'repartidor'), -- 2
    (2, 'Carlos', 'Díaz', 'Sánchez', '87654321C', '111-222-333', 'cocinero'), -- 3
    (2, 'María', 'Rodríguez', 'Pérez', '23456789D', '444-555-666', 'repartidor'); -- 4

INSERT INTO pizzeria.tienda (id_clientes, direccion, codigo_postal, localidad, provincia)
VALUES
    (1, 'Calle Principal 123', '28001', 'Madrid', 'Madrid'), -- 1
    (2, 'Avenida Central 456', '08001', 'Barcelona', 'Barcelona'); -- 2
    
INSERT INTO pizzeria.clientes (nombre, apellido1, apellido2, direccion, codigo_postal, localidad, provincia, telefono)
VALUES
    ('Ana', 'Gómez', 'López', 'Calle Principal 456', '28002', 'Madrid', 'Madrid', '555-123-456'), -- 1
    ('Pedro', 'Fernández', 'García', 'Avenida Secundaria 789', '08002', 'Barcelona', 'Barcelona', '555-789-012'); -- 2

INSERT INTO pizzeria.pedidos (id_tienda, reparto_id, fecha_hora, entrega, precio_total)
VALUES
    (1, 1, '2023-12-01 18:30:00', 'domicilio', 5.50), -- 1
    (2, NULL, '2023-12-02 20:00:00', 'local', 19.50), -- 2
    (1, 2, '2023-12-03 19:15:00', 'domicilio', 21.50); -- 3

INSERT INTO pizzeria.productos_has_pedidos (productos_id, pedidos_id, cantidad)
VALUES
  (1, 1, 2),  -- Dos unidades del producto con id 1 (agua) en el pedido con id 1
  (2, 1, 1),  -- Una unidad del producto con id 2 (cerveza) en el pedido con id 1
  (3, 2, 3),  -- Tres unidades del producto con id 3 (hamburguesas) en el pedido con id 2
  (4, 3, 1), -- Una unidad del producto con id 4 (pizza hawaiana) en el pedido con id 3
  (5, 3, 2); -- Dos unidades del producto con id 5 (pizza pepperoni) en el pedido con id 3

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
