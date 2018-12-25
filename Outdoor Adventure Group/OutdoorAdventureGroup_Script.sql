#By (names anonymized)
#Developing Business Intelligence Project 1
#Outdoor Adventure Group Database
#Queries begin on line 480

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema AssignmentOAG
-- -----------------------------------------------------
-- This is a database intended for the use of the Outdoor Adventure Group, which is a business that offers outdoor activities for the students, faculty, alumni, and guests of the College of William & Mary in Virginia.  This database can handle the rental of equipment, scheduling of trip, and the organization of employees and customers.
DROP SCHEMA IF EXISTS `name_AssignmentOAG` ;

-- -----------------------------------------------------
-- Schema AssignmentOAG
--
-- This is a database intended for the use of the Outdoor Adventure Group, which is a business that offers outdoor activities for the students, faculty, alumni, and guests of the College of William & Mary in Virginia.  This database can handle the rental of equipment, scheduling of trip, and the organization of employees and customers.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `name_AssignmentOAG` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `name_AssignmentOAG` ;

-- -----------------------------------------------------
-- Table `Trip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Trip` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Trip` (
  `tripCode` INT NOT NULL AUTO_INCREMENT,
  `tripName` VARCHAR(45) NULL,
  `difficultyLevel` VARCHAR(45) NULL,
  `tripFee` INT NULL,
  `tripLength` INT NULL,
  PRIMARY KEY (`tripCode`))
ENGINE = InnoDB
COMMENT = 'Trip table hold information about general trips offered by OAG.\nTrip id is unique integer to describe each trip offered (PK)(NN).\nTripName is the natural language description of the trip.\nDifficultyLevel describes how challenging the trip is.\nTripFee is what guests are required to pay.\nTripLength is number of days for the trip.';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Customer` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Customer` (
  `customerId` INT NOT NULL,
  `customerType` VARCHAR(45) NOT NULL DEFAULT 'Guest',
  `customerName` VARCHAR(45) NULL,
  `customerAddress` VARCHAR(45) NULL,
  `customerHomePhone` BIGINT(15) NULL,
  `customerWorkPhone` BIGINT(15) NULL,
  `customerDateofBirth` DATE NULL,
  `sponsorCustomerId` INT NULL,
  PRIMARY KEY (`customerId`),
  INDEX `fk_Customer_Customer1_idx` (`sponsorCustomerId` ASC),
  CONSTRAINT `fk_Customer_Customer1`
    FOREIGN KEY (`sponsorCustomerId`)
    REFERENCES `Customer` (`customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Customer table organizes all individual customers that are organized by the different type of customer that they are, their name, address, home phone, work phone, and date of birth. \ncustomerId holds the PK id for the customer\ncustomerType holds the information of whether a customer is a student, faculty, alumni, or guest\ncustomerName holds the name of the customer\ncustomerAddress holds the address of the customer\ncustomerHomePhone holds the home telephone number of the customer\ncustomerWorkPhone holds the work telephone number of the customer\ncustomerDateofBirth holds the birthday of the customer\nsponsorCustomerID is a FK that holds the information of the sponsor of the customer if the customer is a guest';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Equipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Equipment` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Equipment` (
  `equiptmentId` INT NOT NULL AUTO_INCREMENT,
  `equipmentType` VARCHAR(45) NULL,
  `manufacturer` VARCHAR(45) NULL,
  `supplier` VARCHAR(45) NULL,
  `supplierPhone` BIGINT(15) NULL,
  `studentFee` BIGINT(15) NULL,
  `facultyFee` INT NULL,
  `alumniFee` INT NULL,
  `guestFee` INT NULL,
  PRIMARY KEY (`equiptmentId`))
ENGINE = InnoDB
COMMENT = 'Equipment table holds the offered type of equipment for rentals.\nEquipementId is the unique code for the different equipment types.(PK)(NN)\nequipmentType is the name for the equipment.\nManufacturer is the company that makes the equipment.\nsupplier is the company that provides the equipment.\nsupplierPhone is the contact information for the supplier so that more can be ordered if needed.\nfacultyFee is the fee charged for faculty customers.\nstudentFee is the fee for student customers.\nalumniFee is the fee charged to rent for alumni.\nguestFee is the fee charged to rent for guests.\n';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Inventory` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Inventory` (
  `equiptmentId` INT NOT NULL,
  `inventoryId` INT NOT NULL AUTO_INCREMENT,
  `condition` VARCHAR(45) NULL,
  `available` TINYINT NULL,
  INDEX `fk_table1_Equipment1_idx` (`equiptmentId` ASC),
  PRIMARY KEY (`inventoryId`),
  CONSTRAINT `fk_table1_Equipment1`
    FOREIGN KEY (`equiptmentId`)
    REFERENCES `Equipment` (`equiptmentId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Inventory table organizes all individual pieces of equipment available for rent.\nequipmentId holds the FK id for the type of equipment that the rental is.\ninventoryId is the unique code for the piece of equipment.\ncondition is the quality of the equipment.\navailable is a boolean value to denote if the piece is rented.';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Employee` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Employee` (
  `employeeId` INT NOT NULL AUTO_INCREMENT,
  `employeeName` VARCHAR(45) NULL,
  `employeePhone` BIGINT(15) NULL,
  `employeeDOB` DATE NULL,
  PRIMARY KEY (`employeeId`))
ENGINE = InnoDB
COMMENT = 'Employee table holds all employees currently employed by OAG and their corresponding information.\nemployeeId is the unique identifier for each person.(PK)(NN)\nemployeeName is their name.\nemployeePhone is their current phone number.\nemployeeDOB is the date of birth, held as a date.';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `RentalAgreement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RentalAgreement` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `RentalAgreement` (
  `rentalAgreementId` INT NOT NULL,
  `customerId` INT NOT NULL,
  `employeeId` INT NOT NULL,
  `rentalDate` DATE NULL,
  PRIMARY KEY (`rentalAgreementId`),
  INDEX `fk_RentalAgreement_Customer1_idx` (`customerId` ASC),
  INDEX `fk_RentalAgreement_Employee1_idx` (`employeeId` ASC),
  CONSTRAINT `fk_RentalAgreement_Customer1`
    FOREIGN KEY (`customerId`)
    REFERENCES `Customer` (`customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RentalAgreement_Employee1`
    FOREIGN KEY (`employeeId`)
    REFERENCES `Employee` (`employeeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'the rentalAgreement table hold the customer and employee and dates associated with any given rental that happens for OAG.\nThe rentalAgreementId holds the unique identifier for the agreement. (PK)\ncustomerId associated with the customer the agreement is made. (FK)\nemployeeId is the employee that witnessed and signed the rental agreement. (FK)\nThe rentalDate is the day the agreement was signed.';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `RentalDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RentalDetails` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `RentalDetails` (
  `rentalAgreementId` INT NOT NULL,
  `inventoryId` INT NOT NULL,
  `RealReturnDate` DATE NULL,
  `ExpectedReturnDate` DATE NULL,
  `StartDate` DATE NULL,
  PRIMARY KEY (`rentalAgreementId`, `inventoryId`),
  INDEX `fk_RentalAgreement_has_Inventory_Inventory1_idx` (`inventoryId` ASC),
  INDEX `fk_RentalAgreement_has_Inventory_RentalAgreement1_idx` (`rentalAgreementId` ASC),
  CONSTRAINT `fk_RentalAgreement_has_Inventory_RentalAgreement1`
    FOREIGN KEY (`rentalAgreementId`)
    REFERENCES `RentalAgreement` (`rentalAgreementId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RentalAgreement_has_Inventory_Inventory1`
    FOREIGN KEY (`inventoryId`)
    REFERENCES `Inventory` (`inventoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'rentalDetails table associates the different pieces of equipment rented with the rental agreement signed by the customer and employee.\nthe rentalAgreementId is the rentalAgreement signed (FK)(NN).\ninventoryId is the individual piece of equipment rented;\'s unique id. (FK)(NN)\nrealReturnDate is the date the customer returned the equipment.\nexpectedReturnDate is the date the customer is assigned to return the equipment.\nStartDate is the date the customer rents the equipment.';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ScheduledTrip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ScheduledTrip` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ScheduledTrip` (
  `scheduledTripId` INT NOT NULL,
  `tripCode` INT NOT NULL,
  `tripLeaderEmployeeId` INT NOT NULL,
  `assistandLeaderEmployeeId` INT NULL,
  `startDate` DATE NULL,
  `endDate` DATE NULL,
  PRIMARY KEY (`scheduledTripId`),
  INDEX `fk_ScheduledTrip_Trip1_idx` (`tripCode` ASC),
  INDEX `fk_ScheduledTrip_Employee1_idx` (`tripLeaderEmployeeId` ASC),
  INDEX `fk_ScheduledTrip_Employee2_idx` (`assistandLeaderEmployeeId` ASC),
  CONSTRAINT `fk_ScheduledTrip_Trip1`
    FOREIGN KEY (`tripCode`)
    REFERENCES `Trip` (`tripCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ScheduledTrip_Employee1`
    FOREIGN KEY (`tripLeaderEmployeeId`)
    REFERENCES `Employee` (`employeeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ScheduledTrip_Employee2`
    FOREIGN KEY (`assistandLeaderEmployeeId`)
    REFERENCES `Employee` (`employeeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'A ScheduledTrip is an instance of a trip that has assigned team leaders and customers attending.\nscheduledTripId is a unique code given to the trip planned.(PK)(NN)\ntripCode corresponds with the type of trip that this is.(FK)(NN)\ntripLeaderEmployeeId is the employee id that is leading the trip. (FK)(NN)\nassistantLeaderEmployeeId is the employee assisting the trip leader.(FK)\nStartDate and EndDate are the times that the trip is scheduled for.';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `TripParticipants`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TripParticipants` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `TripParticipants` (
  `customerId` INT NOT NULL,
  `scheduledTripId` INT NOT NULL,
  `insurance` TINYINT NULL,
  PRIMARY KEY (`customerId`, `scheduledTripId`),
  INDEX `fk_Customer_has_ScheduledTrip_ScheduledTrip1_idx` (`scheduledTripId` ASC),
  INDEX `fk_Customer_has_ScheduledTrip_Customer1_idx` (`customerId` ASC),
  CONSTRAINT `fk_Customer_has_ScheduledTrip_Customer1`
    FOREIGN KEY (`customerId`)
    REFERENCES `Customer` (`customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_has_ScheduledTrip_ScheduledTrip1`
    FOREIGN KEY (`scheduledTripId`)
    REFERENCES `ScheduledTrip` (`scheduledTripId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'TripParticpiants holds all customers associated with any given trip.\ncustomerId is the customer Id of the customer attending the trip.(FK)\nscheduledTripId is the id of the trip and its time for the customer. (FK)\ninsurance is a boolean that signifies is the customer has signed up for insurance for the trip.';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Position`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Position` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `Position` (
  `positionId` INT NOT NULL,
  `positionDesc` VARCHAR(45) NULL,
  `positionSalary` INT NULL,
  PRIMARY KEY (`positionId`))
ENGINE = InnoDB
COMMENT = 'The position table illustrates the position of the employee in the company.\npositionID is the unique code for the position type and is a PK\npositionDesc holds the description of the position\npositionSalary holds the salary paid to employees hourly with that position ';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `PositionHeld`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PositionHeld` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `PositionHeld` (
  `positionId` INT NOT NULL,
  `employeeId` INT NOT NULL,
  `StartDate` DATE NULL,
  `EndDate` DATE NULL,
  PRIMARY KEY (`positionId`, `employeeId`),
  INDEX `fk_Position_has_Employee_Employee1_idx` (`employeeId` ASC),
  INDEX `fk_Position_has_Employee_Position1_idx` (`positionId` ASC),
  CONSTRAINT `fk_Position_has_Employee_Position1`
    FOREIGN KEY (`positionId`)
    REFERENCES `Position` (`positionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Position_has_Employee_Employee1`
    FOREIGN KEY (`employeeId`)
    REFERENCES `Employee` (`employeeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Holds all positions that were associated with an employee.\npositionId is the id corresponding to the positions held. (FK)\nemployeeId is the employee id held. (FK).\nStartDate is the day the employee began this position.\nEndDate is the day they ended having this specific position with the company.  Employees currently holding a position will have this be NULL.\n';

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Trip`
-- -----------------------------------------------------
START TRANSACTION;
USE `name_AssignmentOAG`;
INSERT INTO `Trip` (`tripCode`, `tripName`, `difficultyLevel`, `tripFee`, `tripLength`) VALUES (1, 'Backpacking', 'Beginner', 20, 3);
INSERT INTO `Trip` (`tripCode`, `tripName`, `difficultyLevel`, `tripFee`, `tripLength`) VALUES (2, 'Kayaking', 'Advanced', 45, 1);
INSERT INTO `Trip` (`tripCode`, `tripName`, `difficultyLevel`, `tripFee`, `tripLength`) VALUES (3, 'Rock Climbing', 'Intermediate', 30, 1);
INSERT INTO `Trip` (`tripCode`, `tripName`, `difficultyLevel`, `tripFee`, `tripLength`) VALUES (4, 'Camping', 'Intermediate', 60, 3);
INSERT INTO `Trip` (`tripCode`, `tripName`, `difficultyLevel`, `tripFee`, `tripLength`) VALUES (5, 'Archery', 'Beginner', 15, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `name_AssignmentOAG`;
INSERT INTO `Customer` (`customerId`, `customerType`, `customerName`, `customerAddress`, `customerHomePhone`, `customerWorkPhone`, `customerDateofBirth`, `sponsorCustomerId`) VALUES (1, 'Student', 'Salma Elsayed', '110 Sadler Center', 7035612035, 5714563215, '1997-05-02', NULL);
INSERT INTO `Customer` (`customerId`, `customerType`, `customerName`, `customerAddress`, `customerHomePhone`, `customerWorkPhone`, `customerDateofBirth`, `sponsorCustomerId`) VALUES (2, 'Alumni', 'Claudia Estes', '108 Brooks Street', 5692453621, 5856541230, '1997-05-01', NULL);
INSERT INTO `Customer` (`customerId`, `customerType`, `customerName`, `customerAddress`, `customerHomePhone`, `customerWorkPhone`, `customerDateofBirth`, `sponsorCustomerId`) VALUES (3, 'Guest', 'Sabrina Nasir', '462 Days Inn', 4563210256, 8541236521, '1997-04-15', 2);
INSERT INTO `Customer` (`customerId`, `customerType`, `customerName`, `customerAddress`, `customerHomePhone`, `customerWorkPhone`, `customerDateofBirth`, `sponsorCustomerId`) VALUES (4, 'Faculty', 'Chon Abraham', '872 Williamsburg Street', 8542365123, 5699652103, '1987-01-22', NULL);
INSERT INTO `Customer` (`customerId`, `customerType`, `customerName`, `customerAddress`, `customerHomePhone`, `customerWorkPhone`, `customerDateofBirth`, `sponsorCustomerId`) VALUES (5, 'Student', 'Nick Kush', '123 Windston Drive', 4563210256, 7895412032, '1995-10-20', NULL);
INSERT INTO `Customer` (`customerId`, `customerType`, `customerName`, `customerAddress`, `customerHomePhone`, `customerWorkPhone`, `customerDateofBirth`, `sponsorCustomerId`) VALUES (6, 'Guest', 'Taylor Brown', '108 Brooks Street', 2672181802, 5651512326, '2018-04-22', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Equipment`
-- -----------------------------------------------------
START TRANSACTION;
USE `name_AssignmentOAG`;
INSERT INTO `Equipment` (`equiptmentId`, `equipmentType`, `manufacturer`, `supplier`, `supplierPhone`, `studentFee`, `facultyFee`, `alumniFee`, `guestFee`) VALUES (1, 'Backpack', 'North Face', 'Dick\'s', 8047879898, .5, 1.00, 1.00, 1.50);
INSERT INTO `Equipment` (`equiptmentId`, `equipmentType`, `manufacturer`, `supplier`, `supplierPhone`, `studentFee`, `facultyFee`, `alumniFee`, `guestFee`) VALUES (2, 'Tent', 'Ozark', 'Walmart', 7578289696, 10, 20, 20, 25);
INSERT INTO `Equipment` (`equiptmentId`, `equipmentType`, `manufacturer`, `supplier`, `supplierPhone`, `studentFee`, `facultyFee`, `alumniFee`, `guestFee`) VALUES (3, 'Sleeping Bag', 'LL Bean', 'LL Bean', 18002526315, 5, 10, 10, 15);
INSERT INTO `Equipment` (`equiptmentId`, `equipmentType`, `manufacturer`, `supplier`, `supplierPhone`, `studentFee`, `facultyFee`, `alumniFee`, `guestFee`) VALUES (4, 'Lantern', 'Ozark', 'Walmart', 7578289696, 1, 2, 2, 2.5);
INSERT INTO `Equipment` (`equiptmentId`, `equipmentType`, `manufacturer`, `supplier`, `supplierPhone`, `studentFee`, `facultyFee`, `alumniFee`, `guestFee`) VALUES (5, 'Harness', 'Protecta', 'Global Industrial', 1573432782, 2, 3, 3, 4);
INSERT INTO `Equipment` (`equiptmentId`, `equipmentType`, `manufacturer`, `supplier`, `supplierPhone`, `studentFee`, `facultyFee`, `alumniFee`, `guestFee`) VALUES (6, 'Carabiner', 'Protecta', 'Global Industrial', 1573432782, 1, 2, 2, 3);
INSERT INTO `Equipment` (`equiptmentId`, `equipmentType`, `manufacturer`, `supplier`, `supplierPhone`, `studentFee`, `facultyFee`, `alumniFee`, `guestFee`) VALUES (7, 'Helmet', 'WRSI', 'REI', 8042563215, 2, 3, 3, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Inventory`
-- -----------------------------------------------------
START TRANSACTION;
USE `name_AssignmentOAG`;
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (1, 1, 'Good', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (1, 2, 'New', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (2, 3, 'Fair', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (2, 4, 'Good', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (3, 5, 'Good', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (3, 6, 'New', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (3, 7, 'Fair', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (4, 8, 'New', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (4, 9, 'Fair', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (5, 10, 'New', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (5, 11, 'Good', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (6, 12, 'Fair', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (6, 13, 'New', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (7, 14, 'New', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (7, 15, 'Fair', True);
INSERT INTO `Inventory` (`equiptmentId`, `inventoryId`, `condition`, `available`) VALUES (7, 16, 'Good', True);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `name_AssignmentOAG`;
INSERT INTO `Employee` (`employeeId`, `employeeName`, `employeePhone`, `employeeDOB`) VALUES (1, 'Tina Fey', 5256329565, '1968-04-25');
INSERT INTO `Employee` (`employeeId`, `employeeName`, `employeePhone`, `employeeDOB`) VALUES (2, 'Amy Poehler', 5853211478, '1968-04-26');
INSERT INTO `Employee` (`employeeId`, `employeeName`, `employeePhone`, `employeeDOB`) VALUES (3, 'Beyonce Knowles', 6563231212, '1980-01-01');
INSERT INTO `Employee` (`employeeId`, `employeeName`, `employeePhone`, `employeeDOB`) VALUES (4, 'Cardi B', 6361211478, '1990-02-14');
INSERT INTO `Employee` (`employeeId`, `employeeName`, `employeePhone`, `employeeDOB`) VALUES (5, 'Jay Z', 4002003000, '1970-05-26');

COMMIT;


-- -----------------------------------------------------
-- Data for table `RentalAgreement`
-- -----------------------------------------------------
START TRANSACTION;
USE `name_AssignmentOAG`;
INSERT INTO `RentalAgreement` (`rentalAgreementId`, `customerId`, `employeeId`, `rentalDate`) VALUES (1, 1, 1, '2017-01-21');
INSERT INTO `RentalAgreement` (`rentalAgreementId`, `customerId`, `employeeId`, `rentalDate`) VALUES (2, 2, 2, '2017-01-21');
INSERT INTO `RentalAgreement` (`rentalAgreementId`, `customerId`, `employeeId`, `rentalDate`) VALUES (3, 3, 3, '2017-01-21');
INSERT INTO `RentalAgreement` (`rentalAgreementId`, `customerId`, `employeeId`, `rentalDate`) VALUES (4, 4, 4, '2017-01-21');
INSERT INTO `RentalAgreement` (`rentalAgreementId`, `customerId`, `employeeId`, `rentalDate`) VALUES (5, 5, 1, '2017-01-21');

COMMIT;


-- -----------------------------------------------------
-- Data for table `RentalDetails`
-- -----------------------------------------------------
START TRANSACTION;
USE `name_AssignmentOAG`;
INSERT INTO `RentalDetails` (`rentalAgreementId`, `inventoryId`, `RealReturnDate`, `ExpectedReturnDate`, `StartDate`) VALUES (1, 1, NULL, '2017-12-03', '2017-12-01');
INSERT INTO `RentalDetails` (`rentalAgreementId`, `inventoryId`, `RealReturnDate`, `ExpectedReturnDate`, `StartDate`) VALUES (2, 2, '2017-12-05', '2017-12-03', '2017-12-01');
INSERT INTO `RentalDetails` (`rentalAgreementId`, `inventoryId`, `RealReturnDate`, `ExpectedReturnDate`, `StartDate`) VALUES (2, 3, '2017-12-25', '2017-12-03', '2017-12-01');
INSERT INTO `RentalDetails` (`rentalAgreementId`, `inventoryId`, `RealReturnDate`, `ExpectedReturnDate`, `StartDate`) VALUES (3, 5, '2017-12-03', '2017-12-03', '2017-12-01');
INSERT INTO `RentalDetails` (`rentalAgreementId`, `inventoryId`, `RealReturnDate`, `ExpectedReturnDate`, `StartDate`) VALUES (4, 7, '2018-02-17', '2018-02-17', '2018-02-14');
INSERT INTO `RentalDetails` (`rentalAgreementId`, `inventoryId`, `RealReturnDate`, `ExpectedReturnDate`, `StartDate`) VALUES (4, 8, '2018-02-17', '2018-02-17', '2018-02-14');
INSERT INTO `RentalDetails` (`rentalAgreementId`, `inventoryId`, `RealReturnDate`, `ExpectedReturnDate`, `StartDate`) VALUES (5, 9, '2018-02-16', '2018-02-17', '2018-02-14');
INSERT INTO `RentalDetails` (`rentalAgreementId`, `inventoryId`, `RealReturnDate`, `ExpectedReturnDate`, `StartDate`) VALUES (5, 7, '2017-12-17', '2017-12-03', '2017-12-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ScheduledTrip`
-- -----------------------------------------------------
START TRANSACTION;
USE `name_AssignmentOAG`;
INSERT INTO `ScheduledTrip` (`scheduledTripId`, `tripCode`, `tripLeaderEmployeeId`, `assistandLeaderEmployeeId`, `startDate`, `endDate`) VALUES (1, 1, 1, 3, '2017-01-01', '2017-01-04');
INSERT INTO `ScheduledTrip` (`scheduledTripId`, `tripCode`, `tripLeaderEmployeeId`, `assistandLeaderEmployeeId`, `startDate`, `endDate`) VALUES (2, 2, 1, 3, '2017-01-05', '2017-01-05');
INSERT INTO `ScheduledTrip` (`scheduledTripId`, `tripCode`, `tripLeaderEmployeeId`, `assistandLeaderEmployeeId`, `startDate`, `endDate`) VALUES (3, 3, 1, 3, '2017-01-10', '2017-01-10');
INSERT INTO `ScheduledTrip` (`scheduledTripId`, `tripCode`, `tripLeaderEmployeeId`, `assistandLeaderEmployeeId`, `startDate`, `endDate`) VALUES (4, 3, 3, 1, '2018-02-10', '2018-02-10');
INSERT INTO `ScheduledTrip` (`scheduledTripId`, `tripCode`, `tripLeaderEmployeeId`, `assistandLeaderEmployeeId`, `startDate`, `endDate`) VALUES (5, 4, 3, 1, '2018-02-15', '2018-02-18');
INSERT INTO `ScheduledTrip` (`scheduledTripId`, `tripCode`, `tripLeaderEmployeeId`, `assistandLeaderEmployeeId`, `startDate`, `endDate`) VALUES (6, 5, 3, 1, '2018-03-17', '2018-03-17');

COMMIT;


-- -----------------------------------------------------
-- Data for table `TripParticipants`
-- -----------------------------------------------------
START TRANSACTION;
USE `name_AssignmentOAG`;
INSERT INTO `TripParticipants` (`customerId`, `scheduledTripId`, `insurance`) VALUES (1, 1, True);
INSERT INTO `TripParticipants` (`customerId`, `scheduledTripId`, `insurance`) VALUES (1, 2, True);
INSERT INTO `TripParticipants` (`customerId`, `scheduledTripId`, `insurance`) VALUES (2, 1, True);
INSERT INTO `TripParticipants` (`customerId`, `scheduledTripId`, `insurance`) VALUES (3, 3, True);
INSERT INTO `TripParticipants` (`customerId`, `scheduledTripId`, `insurance`) VALUES (4, 4, True);
INSERT INTO `TripParticipants` (`customerId`, `scheduledTripId`, `insurance`) VALUES (5, 5, True);
INSERT INTO `TripParticipants` (`customerId`, `scheduledTripId`, `insurance`) VALUES (5, 6, True);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Position`
-- -----------------------------------------------------
START TRANSACTION;
USE `name_AssignmentOAG`;
INSERT INTO `Position` (`positionId`, `positionDesc`, `positionSalary`) VALUES (1, 'Clerk', 9);
INSERT INTO `Position` (`positionId`, `positionDesc`, `positionSalary`) VALUES (2, 'Manager', 14);
INSERT INTO `Position` (`positionId`, `positionDesc`, `positionSalary`) VALUES (3, 'Project Coordinator', 11);
INSERT INTO `Position` (`positionId`, `positionDesc`, `positionSalary`) VALUES (4, 'Accountant', 50);
INSERT INTO `Position` (`positionId`, `positionDesc`, `positionSalary`) VALUES (5, 'Janitor', 8);
INSERT INTO `Position` (`positionId`, `positionDesc`, `positionSalary`) VALUES (6, 'Trainer', 12);

COMMIT;


-- -----------------------------------------------------
-- Data for table `PositionHeld`
-- -----------------------------------------------------
START TRANSACTION;
USE `name_AssignmentOAG`;
INSERT INTO `PositionHeld` (`positionId`, `employeeId`, `StartDate`, `EndDate`) VALUES (1, 1, '2010-01-01', '2012-02-19');
INSERT INTO `PositionHeld` (`positionId`, `employeeId`, `StartDate`, `EndDate`) VALUES (2, 2, '2010-03-25', NULL);
INSERT INTO `PositionHeld` (`positionId`, `employeeId`, `StartDate`, `EndDate`) VALUES (3, 3, '2011-05-01', NULL);
INSERT INTO `PositionHeld` (`positionId`, `employeeId`, `StartDate`, `EndDate`) VALUES (4, 4, '2010-05-10', NULL);
INSERT INTO `PositionHeld` (`positionId`, `employeeId`, `StartDate`, `EndDate`) VALUES (5, 5, '2011-02-20', NULL);
INSERT INTO `PositionHeld` (`positionId`, `employeeId`, `StartDate`, `EndDate`) VALUES (3, 1, '2012-02-20', NULL);
INSERT INTO `PositionHeld` (`positionId`, `employeeId`, `StartDate`, `EndDate`) VALUES (6, 3, '2010-07-04', '2011-04-30');

COMMIT;

USE name_AssignmentOAG;
#question 1
SELECT S.customerId, S.customerName, S.customerAddress, S.customerHomePhone, S.customerType, 
	count(G.sponsorCustomerId) as 'Sponsorships'
	FROM customer AS S JOIN customer AS G
	ON S.customerId = G.sponsorCustomerId 
    GROUP BY S.customerId HAVING count(G.sponsorCustomerId) > 1;
#Question 2    
SELECT customer.customerId, customer.customerHomePhone, equipment.equipmentType 
	FROM rentalagreement JOIN customer
		ON customer.customerID = rentalagreement.customerId
	JOIN rentaldetails
		ON rentaldetails.rentalAgreementId = rentalagreement.rentalAgreementId
	JOIN inventory
		ON inventory.inventoryId = rentaldetails.inventoryId
	JOIN equipment
		ON equipment.equiptmentId = inventory.equiptmentId
	WHERE rentaldetails.RealReturnDate IS NULL AND (rentaldetails.expectedReturnDate <= Now() - 2);

#query 4
#List equipment that needs to be replaced.
#Justification: OAG needs to be aware of equipment that are in poor condition, so they can reorder
#	if necessary.
SELECT equiptmentId
	FROM Inventory
		WHERE Inventory.condition NOT IN ('New','Good');

#query 5
#Choose the highest priced equipment based on the student fee. Display the equipment name and associated 
#	student fee. 
#Justification: OAG can look at historical data to forecast future demands of trips and inventory. 
SELECT customerName, customerAddress, COUNT(tripparticipants.customerId) AS 'Number of Trips' 
	FROM customer JOIN tripparticipants ON customer.customerId = tripparticipants.customerId 
    GROUP BY customer.customerId;

#query 6
#Give a count of customers for each classification or customer type. 
#Justification: We can look to historical data to forecast future the demand based on the number 
#	of customers that we have and the different types of customers.
SELECT equipment.equiptmentId, equipment.equipmentType, COUNT(equipment.equiptmentId) AS 'Number of Rentals'
	FROM rentaldetails
	JOIN inventory ON inventory.inventoryId = rentaldetails.inventoryId
    JOIN equipment ON inventory.equiptmentId = equipment.equiptmentId
    GROUP BY equiptmentId;

#query 7
#Generate a list of equipment that is already being rented out and is in good condition. 
#Justification: We can see the average amount of good equipment that can be rented out and work 
#	to give customers less poor equipment. 
SELECT customerName, customerHomePhone, customerAddress FROM customer
	WHERE customer.customerId NOT IN (SELECT customerId FROM tripparticipants);

#query 8
#Find customers that went on the most trips.
#Justification: As a marketing technique, The OAG can send holiday cards, thank you notes, 
#	or coupons in order to keep their customer base.
SELECT employee.employeeName, customer.customerName, customer.customerHomePhone FROM customer
	JOIN tripparticipants ON tripparticipants.customerId  = customer.customerId
    JOIN scheduledtrip ON scheduledtrip.scheduledTripId = tripparticipants.scheduledTripId
    JOIN employee ON employee.employeeId = scheduledtrip.tripLeaderEmployeeId
    WHERE insurance = False;

#query 9
#Which types of equipment are rented the most or the least?
#Justification: OAG can lower inventory on or sell underperforming equipment, or stock more 
#equipment that is frequently rented out or gone from inventory.
SELECT equipment.equiptmentId, equipment.equipmentType, COUNT(equipment.equiptmentId) AS 'Number of Rentals'
	FROM rentaldetails
	JOIN inventory ON inventory.inventoryId = rentaldetails.inventoryId
    JOIN equipment ON inventory.equiptmentId = equipment.equiptmentId
    GROUP BY equiptmentId;

#query 10
#Find if any customers have visited, but not signed up for trips.
#Justification: OAG can see if they need to increase marketing measures to secure clients.
SELECT customerName, customerHomePhone, customerAddress FROM customer
	WHERE customer.customerId NOT IN (SELECT customerId FROM tripparticipants);

#query 11
#Find out which customers have not signed off on their insurance before they go on a trip, 
#	and the employee leading the trip.
#Justification: OAG team leaders can reach out to customers that haven’t signed up for or paid 
#	for their insurance yet before heading out on their trip.
SELECT employee.employeeName, customer.customerName, customer.customerHomePhone FROM customer
	JOIN tripparticipants ON tripparticipants.customerId  = customer.customerId
	JOIN scheduledtrip ON scheduledtrip.scheduledTripId = tripparticipants.scheduledTripId
	JOIN employee ON employee.employeeId = scheduledtrip.tripLeaderEmployeeId
    	WHERE insurance = False;

#query 12
#Find the employee who has signed off on at least two rental agreements. 
#Justification: It is important to keep track of which employees are responsible for 
#	which rental agreements, especially Rental Agreements with multiple customers. 
SELECT Employee.employeeName, COUNT(RentalAgreement.employeeId) AS 'Number of Agreements Signed' 
	FROM RentalAgreement JOIN Employee ON Employee.employeeId = RentalAgreement.employeeId
		GROUP BY RentalAgreement.employeeId HAVING COUNT(RentalAgreement.employeeId) >= 2; 

#query 13
#Find the equipment that is currently being used for a trip. 
#Justification: This is to determine which items in inventory are currently being used and 
#	need to be returned. 
SELECT DISTINCT Inventory.inventoryId AS 'Inventory being used' FROM Inventory
	RIGHT JOIN RentalDetails ON RentalDetails.inventoryId = Inventory.inventoryId;

#query 14
#Determine the customers who have either turned in their equipment late or have not turned it in at all. 
#Justification: This is to help determine which customers OAG should not rent out equipment to 
#	again or to charge a late fee or replacement fee. 
SELECT RentalAgreement.customerId AS 'Customers who have equipment overdue or not returned' 
	FROM RentalAgreement JOIN RentalDetails 
    on RentalDetails.rentalAgreementId = RentalAgreement.rentalAgreementId
		WHERE RealReturnDate IS NULL OR RealReturnDate > ExpectedReturnDate;

#query 15
#Determine the employees who have never been trip leaders.
#Justification: This is determine which employees should be given a chance or encouraged to be trip leaders.
SELECT employeeid AS 'Employees who have never been trip leaders or assistants' from PositionHeld
	LEFT JOIN ScheduledTrip ON ScheduledTrip.tripLeaderEmployeeId = PositionHeld.employeeId
		WHERE NOT EXISTS(SELECT tripLeaderEmployeeId FROM ScheduledTrip 
			WHERE ScheduledTrip.tripLeaderEmployeeId = PositionHeld.employeeId);
