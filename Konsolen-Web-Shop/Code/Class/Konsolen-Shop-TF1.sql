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
  `Name` varchar(64) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,  -- Name der Kategorie
  `ParentID` int(11) DEFAULT NULL,  -- Referenz auf die Elternkategorie (NULL bedeutet Hauptkategorie)
  `ConsoleTypID` int(11) DEFAULT NULL,  -- Referenz auf die Elternkategorie (NULL bedeutet Hauptkategorie)
  PRIMARY KEY (`ID`),
  FOREIGN KEY (`ParentID`) REFERENCES `Category`(`ID`) ON DELETE CASCADE,
  FOREIGN KEY (`ConsoleTypID`) REFERENCES `Category`(`ID`) ON DELETE CASCADE
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
INSERT INTO `Category` (`Name`, `ParentID`, `ConsoleTypID`) VALUES
-- Firmenkategorien (Nintendo, PlayStation, Xbox)
('Nintendo', NULL, NULL),
('PlayStation', NULL, NULL),
('Xbox', NULL, NULL),

-- Konsolenarten (Handheld, Home Console, Hybrid)
('Handheld', NULL, NULL),
('Home Console', NULL, NULL),
('Hybrid', NULL, NULL),

-- Varianten unter den Nintendo Heimkonsole
('Nintendo Entertainment System (NES)', 1, 5), -- Heimkonsole
('Super Nintendo Entertainment System (SNES)', 1, 5), 
('Nintendo 64', 1, 5), 
('Nintendo GameCube', 1, 5), 
('Nintendo Wii', 1, 5), 
('Nintendo Wii U', 1, 5),

-- Varianten unter den Nintendo Handhelds
('GameBoy', 1, 4), -- 'GameBoy' unter 'Nintendo' und als Handheld
('GameBoy Advance', 1, 4),
('Nintendo DS', 1, 4),
('Nintendo 3DS', 1, 4),

-- Varianten unter den Nintendo Hybrid
('Nintendo Switch', 1, 6),

-- Konsolen und Varianten unter PlayStation
('Playstation 1', 2, 5), -- 'Playstation 1' unter 'PlayStation' und als Home Console
('Playstation 2', 2, 5),
('Playstation 3', 2, 5),
('Playstation 4', 2, 5),
('Playstation 5', 2, 5),
('PSP', 2, 4),  -- 'PSP' als Handheld
('PS Vita', 2, 4),  -- 'PS Vita' als Handheld

-- Varianten unter den PlayStation Konsolen
('Playstation 1 First', 18, 5),
('Playstation 1 One', 18, 5),
('Playstation 2 First', 19, 5),
('Playstation 2 Slim', 19, 5),
('Playstation 3 First', 20, 5),
('Playstation 3 Slim', 20, 5),
('Playstation 3 Super Slim', 20, 5),
('Playstation 4 First', 21, 5),
('Playstation 4 Pro', 21, 5),
('Playstation 4 Slim', 21, 5),
('Playstation 5 Pro', 22, 5),
('PSP 1000', 23, 4),
('PS Vita OLED', 24, 4),
('PS Vita Slim', 24, 4);
