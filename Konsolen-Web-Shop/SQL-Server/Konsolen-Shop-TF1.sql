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

-- Tabelle für Kategorien (Category) mit Eltern-Kind-Beziehung
CREATE TABLE `Category` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ParentID` int(11) DEFAULT NULL,  -- Referenz auf die Elternkategorie (NULL bedeutet Hauptkategorie)
  `Name` varchar(64) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,  -- Name der Kategorie
  PRIMARY KEY (`ID`),
  FOREIGN KEY (`ParentID`) REFERENCES `Category`(`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Zwischentabelle für die m:n Beziehung zwischen Produkt und Kategorie
CREATE TABLE `ProductCategory` (
  `ProductID` int(11) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  PRIMARY KEY (`ProductID`, `CategoryID`),
  FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ID`) ON DELETE CASCADE,
  FOREIGN KEY (`CategoryID`) REFERENCES `Category`(`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabelle für Bestellpositionen, Warenkorb und Wunschliste (UserProductItem)
CREATE TABLE `UserProductItem` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `Status` enum('in_warenkorb', 'bestellt', 'auf_wunschliste') NOT NULL DEFAULT 'in_warenkorb',  -- Status der Position (im Warenkorb, bestellt oder auf Wunschliste)
  `CreatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  FOREIGN KEY (`UserID`) REFERENCES `User`(`ID`),
  FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Einfügen der vorgefertigten Kategorien mit Hierarchie (Hersteller, Konsolen, Varianten)
INSERT INTO `Category` (`Name`, `ParentID`) VALUES
-- Firmenkategorien (Nintendo, PlayStation, Xbox)
('Nintendo', NULL),
('PlayStation', NULL),
('Xbox', NULL),

-- Konsolenarten (Handheld, Home Console, Hybrid)
('Handheld', NULL),
('Home Console', NULL),
('Hybrid', NULL),

-- Konsolen und Varianten unter Nintendo
('GameBoy', 1),
('GameBoy Color', 1),
('GameBoy Advance', 1),
('Nintendo DS', 1),
('Nintendo 3DS', 1),
('Nintendo Switch Lite', 1),

-- Varianten unter den Nintendo Handhelds
('GameBoy Original', 2),
('GameBoy Color', 3),
('GameBoy Advance SP', 4),
('Nintendo DS', 5),
('Nintendo 3DS XL', 6),
('New Nintendo 3DS', 7),
('Nintendo Switch Lite', 8),

-- Konsolen und Varianten unter PlayStation
('Playstation 1', 2),
('Playstation 2', 2),
('Playstation 3', 2),
('Playstation 4', 2),
('Playstation 5', 2),
('PS Vita', 2),

-- Varianten unter den PlayStation Konsolen
('Playstation 1 Slim', 10),
('Playstation 2 Slim', 11),
('Playstation 3 Super Slim', 12),
('Playstation 4 Pro', 13),
('Playstation 4 Slim', 14),
('PS Vita Slim', 16),

-- Konsolen und Varianten unter Xbox
('Xbox 360', 3),
('Xbox One', 3),
('Xbox Series X', 3),

-- Varianten unter den Xbox Konsolen
('Xbox One S', 17),
('Xbox One X', 18),

-- Konsolen unter Hybrid
('Nintendo Switch', 4),

-- Varianten unter Hybrid Konsolen
('Nintendo Switch OLED', 19);
