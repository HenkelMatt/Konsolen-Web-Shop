SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Erweiterte Benutzertabelle (User)
CREATE TABLE `User` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(32) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,
  `Password` varchar(128) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,
  `Firstname` varchar(32) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,
  `Familyname` varchar(32) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,
  `Email` varchar(64) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,
  `Role` enum('user', 'employee') NOT NULL DEFAULT 'user',  -- Unterscheidung zwischen Benutzer und Mitarbeiter
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabelle für Produkte (Product)
CREATE TABLE `Product` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,
  `Description` text CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Discount` decimal(5,2) DEFAULT NULL,  -- Rabatt in Prozent
  `Status` enum('verkauft', 'nicht_verkauft') NOT NULL DEFAULT 'nicht_verkauft', -- Status des Produkts
  `CreatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabelle für Bilder (ProductImages) für die 1:n Beziehung zwischen Produkt und Bild
CREATE TABLE `ProductImages` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductID` int(11) NOT NULL,
  `Image` longblob NOT NULL,  -- Bild des Produkts
  PRIMARY KEY (`ID`),
  FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabelle für Kategorien (Category)
CREATE TABLE `Category` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductID` int(11) NOT NULL,
  `Name` varchar(64) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,
  PRIMARY KEY (`ID`),
  FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabelle für Bestellpositionen, Warenkorb und Wunschliste (UserProductItem)
CREATE TABLE `UserProductItem` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `Status` enum('in_warenkorb', 'bestellt', 'auf_wunschliste') NOT NULL DEFAULT 'in_warenkorb',  -- Status der Position (im Warenkorb, bestellt oder auf Wunschliste)
  `Quantity` int(11) DEFAULT NULL,  -- Nur für den Warenkorb relevant (Menge der Produkte)
  `CreatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  FOREIGN KEY (`UserID`) REFERENCES `User`(`ID`),
  FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
