-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema CheckPoint1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CheckPoint1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CheckPoint1` DEFAULT CHARACTER SET utf8 ;
USE `CheckPoint1` ;

-- -----------------------------------------------------
-- Table `CheckPoint1`.`forma_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CheckPoint1`.`forma_pago` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(15) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `CheckPoint1`.`clase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CheckPoint1`.`clase` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `costo` FLOAT(6,2) NOT NULL,
  `nombre` CHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `CheckPoint1`.`decoracion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CheckPoint1`.`decoracion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `CheckPoint1`.`habitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CheckPoint1`.`habitacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `clase_id` INT NOT NULL,
  `decoracion_id` INT NOT NULL,
  `capacidad_max` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_habitacion_clase_idx` (`clase_id` ASC) VISIBLE,
  INDEX `fk_habitacion_decoracion1_idx` (`decoracion_id` ASC) VISIBLE,
  CONSTRAINT `fk_habitacion_clase`
    FOREIGN KEY (`clase_id`)
    REFERENCES `CheckPoint1`.`clase` (`id`),
  CONSTRAINT `fk_habitacion_decoracion1`
    FOREIGN KEY (`decoracion_id`)
    REFERENCES `CheckPoint1`.`decoracion` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `CheckPoint1`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CheckPoint1`.`pais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `CheckPoint1`.`huesped`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CheckPoint1`.`huesped` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `habitacion_id` INT NOT NULL,
  `paises_id` INT NOT NULL,
  `apellido` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(20) NOT NULL,
  `pasaporte` CHAR(20) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `domicilio` VARCHAR(50) NOT NULL,
  `telefono_movil` CHAR(15) NOT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `pasaporte_UNIQUE` (`pasaporte` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_huespedes_paises1_idx` (`paises_id` ASC) VISIBLE,
  INDEX `fk_huesped_habitacion1_idx` (`habitacion_id` ASC) VISIBLE,
  CONSTRAINT `fk_huesped_habitacion1`
    FOREIGN KEY (`habitacion_id`)
    REFERENCES `CheckPoint1`.`habitacion` (`id`),
  CONSTRAINT `fk_huespedes_paises1`
    FOREIGN KEY (`paises_id`)
    REFERENCES `CheckPoint1`.`pais` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `CheckPoint1`.`check_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CheckPoint1`.`check_in` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `forma_pago_id` INT NOT NULL,
  `huesped_id` INT NOT NULL,
  `fecha_entrada` DATETIME NOT NULL,
  `fecha_salida` DATETIME NOT NULL,
  `importe` FLOAT(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_check_in_huesped1_idx` (`huesped_id` ASC) VISIBLE,
  INDEX `fk_check_in_forma_pago1_idx` (`forma_pago_id` ASC) VISIBLE,
  CONSTRAINT `fk_check_in_forma_pago1`
    FOREIGN KEY (`forma_pago_id`)
    REFERENCES `CheckPoint1`.`forma_pago` (`id`),
  CONSTRAINT `fk_check_in_huesped1`
    FOREIGN KEY (`huesped_id`)
    REFERENCES `CheckPoint1`.`huesped` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `CheckPoint1`.`sector_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CheckPoint1`.`sector_laboral` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(15) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `CheckPoint1`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CheckPoint1`.`empleado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sector_laboral_id` INT NOT NULL,
  `paises_id` INT NOT NULL,
  `numero_legajo` INT NOT NULL,
  `apellido` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(20) NOT NULL,
  `numero_documento` CHAR(10) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `domicilio` VARCHAR(50) NOT NULL,
  `telefono_movil` CHAR(15) NOT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `estado` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `numero_documento_UNIQUE` (`numero_documento` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_empleado_paises1_idx` (`paises_id` ASC) VISIBLE,
  INDEX `fk_empleado_sector_laboral1_idx` (`sector_laboral_id` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_paises1`
    FOREIGN KEY (`paises_id`)
    REFERENCES `CheckPoint1`.`pais` (`id`),
  CONSTRAINT `fk_empleado_sector_laboral1`
    FOREIGN KEY (`sector_laboral_id`)
    REFERENCES `CheckPoint1`.`sector_laboral` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `CheckPoint1`.`servicios_basico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CheckPoint1`.`servicios_basico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `CheckPoint1`.`habitacion_x_servicios_basico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CheckPoint1`.`habitacion_x_servicios_basico` (
  `habitacion_id` INT NOT NULL,
  `servicios_basico_id` INT NOT NULL,
  PRIMARY KEY (`habitacion_id`, `servicios_basico_id`),
  INDEX `fk_habitacion_has_servicios_basico_servicios_basico1_idx` (`servicios_basico_id` ASC) VISIBLE,
  INDEX `fk_habitacion_has_servicios_basico_habitacion1_idx` (`habitacion_id` ASC) VISIBLE,
  CONSTRAINT `fk_habitacion_has_servicios_basico_habitacion1`
    FOREIGN KEY (`habitacion_id`)
    REFERENCES `CheckPoint1`.`habitacion` (`id`),
  CONSTRAINT `fk_habitacion_has_servicios_basico_servicios_basico1`
    FOREIGN KEY (`servicios_basico_id`)
    REFERENCES `CheckPoint1`.`servicios_basico` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `CheckPoint1`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CheckPoint1`.`reserva` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `forma_pago_id` INT NOT NULL,
  `huesped_id` INT NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `horas_reservadas` TINYINT NOT NULL,
  `importe` FLOAT(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reserva_huesped1_idx` (`huesped_id` ASC) VISIBLE,
  INDEX `fk_reserva_forma_pago1_idx` (`forma_pago_id` ASC) VISIBLE,
  CONSTRAINT `fk_reserva_forma_pago1`
    FOREIGN KEY (`forma_pago_id`)
    REFERENCES `CheckPoint1`.`forma_pago` (`id`),
  CONSTRAINT `fk_reserva_huesped1`
    FOREIGN KEY (`huesped_id`)
    REFERENCES `CheckPoint1`.`huesped` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `CheckPoint1`.`servicios_extra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CheckPoint1`.`servicios_extra` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `forma_pago_id` INT NOT NULL,
  `nombre` VARCHAR(20) NOT NULL,
  `costo` FLOAT(6,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_servicios_extra_forma_pago1_idx` (`forma_pago_id` ASC) VISIBLE,
  CONSTRAINT `fk_servicios_extra_forma_pago1`
    FOREIGN KEY (`forma_pago_id`)
    REFERENCES `CheckPoint1`.`forma_pago` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `CheckPoint1`.`servicios_extra_x_reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CheckPoint1`.`servicios_extra_x_reserva` (
  `servicios_extra_id` INT NOT NULL,
  `reserva_id` INT NOT NULL,
  PRIMARY KEY (`servicios_extra_id`, `reserva_id`),
  INDEX `fk_servicios_extra_has_reserva_reserva1_idx` (`reserva_id` ASC) VISIBLE,
  INDEX `fk_servicios_extra_has_reserva_servicios_extra1_idx` (`servicios_extra_id` ASC) VISIBLE,
  CONSTRAINT `fk_servicios_extra_has_reserva_reserva1`
    FOREIGN KEY (`reserva_id`)
    REFERENCES `CheckPoint1`.`reserva` (`id`),
  CONSTRAINT `fk_servicios_extra_has_reserva_servicios_extra1`
    FOREIGN KEY (`servicios_extra_id`)
    REFERENCES `CheckPoint1`.`servicios_extra` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
