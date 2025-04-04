-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema MedicalAppointmentSystem
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema MedicalAppointmentSystem
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MedicalAppointmentSystem` ;
USE `MedicalAppointmentSystem` ;

-- -----------------------------------------------------
-- Table `MedicalAppointmentSystem`.`patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MedicalAppointmentSystem`.`patients` (
  `patient_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`patient_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MedicalAppointmentSystem`.`doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MedicalAppointmentSystem`.`doctors` (
  `doctor_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(250) NOT NULL,
  `specialization` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`doctor_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MedicalAppointmentSystem`.`appointments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MedicalAppointmentSystem`.`appointments` (
  `appointment_id` INT NOT NULL AUTO_INCREMENT,
  `patient_id` INT NOT NULL,
  `doctor_id` INT NOT NULL,
  `appointment_date` DATE NOT NULL,
  `appointment_time` TIME NOT NULL,
  `appointment_status` ENUM('scheduled', 'cancelled', 'completed') NOT NULL DEFAULT 'scheduled',
  PRIMARY KEY (`appointment_id`),
  INDEX `patient_ID_idx` (`patient_id` ASC),
  INDEX `doctor_id_idx` (`doctor_id` ASC),
  CONSTRAINT `patient_id`
    FOREIGN KEY (`patient_id`)
    REFERENCES `MedicalAppointmentSystem`.`patients` (`patient_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `doctor_id`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `MedicalAppointmentSystem`.`doctors` (`doctor_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
   UNIQUE KEY `unique_appointment` (`doctor_id`, `appointment_date`, `appointment_time`) 
    )
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
