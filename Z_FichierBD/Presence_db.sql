-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  ven. 02 août 2019 à 05:42
-- Version du serveur :  10.3.16-MariaDB
-- Version de PHP :  7.3.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `presence_db`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AdmimDeleteByID` (`_AdminID` INT)  BEGIN
	delete from administrateur 
    where idADMINISTRATEUR=_AdminID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AdminAddOrEdit` (`_AdminID` INT, `_AdminNom` VARCHAR(24), `_AdminPremon` VARCHAR(24), `_AdminLogin` VARCHAR(45), `_AdminPwd` VARCHAR(45))  BEGIN
	if _AdminID = 0 then
		INSERT INTO administrateur (Nom,Prenom,Login,Password)
		VALUES (_AdminNom,_AdminPremon,_AdminLogin,_AdminPwd);
	else
		UPDATE administrateur
        SET
			Nom=_AdminNom,
			Prenom = _AdminPremon,
            Login = _AdminLogin,
            Password = _AdminPwd
		where idADMINISTRATEUR = _AdminID;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AdminSearchByValue` (`_SearchValue` VARCHAR(45))  BEGIN
	SELECT * 
	FROM Administrateur
    WHERE Nom like concat('%'+_SearchValue+'%') || Prenom like concat('%'+_SearchValue+'%') ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AdminViewAll` ()  BEGIN
	select *
    From administrateur;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `adminViewByID` (`_AdminID` INT)  BEGIN
	select * 
    From Administrateur
    where idADMINISTRATEUR = _AdminID;    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ClasseAddOrEdit` (`_ClasseID` INT, `_ClasseCode` VARCHAR(24), `_ClasseDescription` VARCHAR(24))  BEGIN
	if _ClasseID = 0 then
		INSERT INTO classe (Code,Description)
		VALUES (_ClasseCode,_ClasseDescription);
	else
		UPDATE classe
        SET
			Code=_ClasseCode,
			Description = _ClasseDescription
            
		where idCLASSE = _ClasseID;
	END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `administrateur`
--

CREATE TABLE `administrateur` (
  `idADMINISTRATEUR` int(11) NOT NULL,
  `Nom` varchar(24) DEFAULT NULL,
  `Prenom` varchar(24) DEFAULT NULL,
  `Login` varchar(45) DEFAULT NULL,
  `PassWord` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `administrateur`
--

INSERT INTO `administrateur` (`idADMINISTRATEUR`, `Nom`, `Prenom`, `Login`, `PassWord`) VALUES
(1, 'raoul', 'buguem', 'raoul', 'raoul'),
(2, 'boris1', 'boris', 'boris', 'boris'),
(3, 'admin', 'admin', 'admin', 'admin'),
(4, 'hgkjhygj', 'hnjkh', 'hguyg', 'jikhg'),
(5, 'nvnhgfhgf54675', 'mnm', 'vbmnb', 'vmnhv'),
(6, 'jhkujh', 'hkj', 'mkh', 'hklhujlju');

-- --------------------------------------------------------

--
-- Structure de la table `classe`
--

CREATE TABLE `classe` (
  `idCLASSE` int(11) NOT NULL,
  `Code` varchar(45) DEFAULT NULL,
  `Description` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `cycle`
--

CREATE TABLE `cycle` (
  `idCyle` int(11) NOT NULL,
  `NumeroCycle` varchar(2) DEFAULT NULL,
  `Description` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `matiere`
--

CREATE TABLE `matiere` (
  `idMATIERE` int(11) NOT NULL,
  `Code` varchar(10) NOT NULL,
  `Nom` varchar(20) NOT NULL,
  `Cyle_idCyle` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `presence`
--

CREATE TABLE `presence` (
  `idPRESENCE` int(11) NOT NULL,
  `HeureDebut` time DEFAULT NULL,
  `HeureFin` time DEFAULT NULL,
  `PROGRAMMES_idPROGRAMMES` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `professeur`
--

CREATE TABLE `professeur` (
  `idPROFESSEUR` int(11) NOT NULL,
  `Nom` varchar(20) DEFAULT NULL,
  `Prenom` varchar(20) DEFAULT NULL,
  `Telephone` varchar(10) DEFAULT NULL,
  `Telephone_2` varchar(10) DEFAULT NULL,
  `Empreinte_1` varchar(45) DEFAULT NULL,
  `Empreinte_2` varchar(45) DEFAULT NULL,
  `Emprinte_3` varchar(45) DEFAULT NULL,
  `TypeProfesseur` varchar(45) DEFAULT NULL,
  `FaceID_1` varchar(45) DEFAULT NULL,
  `FaceID_2` varchar(45) DEFAULT NULL,
  `Photo_profil` varchar(45) DEFAULT NULL,
  `Description` varchar(254) DEFAULT NULL,
  `Taux_horaire_1` decimal(2,0) DEFAULT NULL,
  `Taux_horaire_2` decimal(2,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `professeur_matiere`
--

CREATE TABLE `professeur_matiere` (
  `idPROFESSEUR` int(11) NOT NULL,
  `idMATIERE` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `programmes`
--

CREATE TABLE `programmes` (
  `idPROGRAMMES` int(11) NOT NULL,
  `Date` date DEFAULT NULL,
  `Heure_Debut` time DEFAULT NULL,
  `Heure_Fin` time DEFAULT NULL,
  `CLASSE_idCLASSE` int(11) NOT NULL,
  `idADMINISTRATEUR` int(11) NOT NULL,
  `idPROFESSEUR` int(11) NOT NULL,
  `idMATIERE` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `administrateur`
--
ALTER TABLE `administrateur`
  ADD PRIMARY KEY (`idADMINISTRATEUR`);

--
-- Index pour la table `classe`
--
ALTER TABLE `classe`
  ADD PRIMARY KEY (`idCLASSE`);

--
-- Index pour la table `cycle`
--
ALTER TABLE `cycle`
  ADD PRIMARY KEY (`idCyle`);

--
-- Index pour la table `matiere`
--
ALTER TABLE `matiere`
  ADD PRIMARY KEY (`idMATIERE`),
  ADD KEY `fk_MATIERE_Cyle_idx` (`Cyle_idCyle`);

--
-- Index pour la table `presence`
--
ALTER TABLE `presence`
  ADD PRIMARY KEY (`idPRESENCE`),
  ADD KEY `fk_PRESENCE_PROGRAMMES1_idx` (`PROGRAMMES_idPROGRAMMES`);

--
-- Index pour la table `professeur`
--
ALTER TABLE `professeur`
  ADD PRIMARY KEY (`idPROFESSEUR`);

--
-- Index pour la table `professeur_matiere`
--
ALTER TABLE `professeur_matiere`
  ADD PRIMARY KEY (`idPROFESSEUR`,`idMATIERE`),
  ADD KEY `fk_PROFESSEUR_has_MATIERE_MATIERE1_idx` (`idMATIERE`),
  ADD KEY `fk_PROFESSEUR_has_MATIERE_PROFESSEUR1_idx` (`idPROFESSEUR`);

--
-- Index pour la table `programmes`
--
ALTER TABLE `programmes`
  ADD PRIMARY KEY (`idPROGRAMMES`),
  ADD KEY `fk_PROGRAMMES_CLASSE1_idx` (`CLASSE_idCLASSE`),
  ADD KEY `fk_PROGRAMMES_ADMINISTRATEUR1_idx` (`idADMINISTRATEUR`),
  ADD KEY `fk_PROGRAMMES_PROFESSEUR_has_MATIERE1_idx` (`idPROFESSEUR`,`idMATIERE`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `administrateur`
--
ALTER TABLE `administrateur`
  MODIFY `idADMINISTRATEUR` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `classe`
--
ALTER TABLE `classe`
  MODIFY `idCLASSE` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `cycle`
--
ALTER TABLE `cycle`
  MODIFY `idCyle` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `matiere`
--
ALTER TABLE `matiere`
  MODIFY `idMATIERE` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `presence`
--
ALTER TABLE `presence`
  MODIFY `idPRESENCE` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `professeur`
--
ALTER TABLE `professeur`
  MODIFY `idPROFESSEUR` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `programmes`
--
ALTER TABLE `programmes`
  MODIFY `idPROGRAMMES` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `matiere`
--
ALTER TABLE `matiere`
  ADD CONSTRAINT `fk_MATIERE_Cyle` FOREIGN KEY (`Cyle_idCyle`) REFERENCES `cycle` (`idCyle`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `presence`
--
ALTER TABLE `presence`
  ADD CONSTRAINT `fk_PRESENCE_PROGRAMMES1` FOREIGN KEY (`PROGRAMMES_idPROGRAMMES`) REFERENCES `programmes` (`idPROGRAMMES`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `professeur_matiere`
--
ALTER TABLE `professeur_matiere`
  ADD CONSTRAINT `fk_PROFESSEUR_has_MATIERE_MATIERE1` FOREIGN KEY (`idMATIERE`) REFERENCES `matiere` (`idMATIERE`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_PROFESSEUR_has_MATIERE_PROFESSEUR1` FOREIGN KEY (`idPROFESSEUR`) REFERENCES `professeur` (`idPROFESSEUR`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `programmes`
--
ALTER TABLE `programmes`
  ADD CONSTRAINT `fk_PROGRAMMES_ADMINISTRATEUR1` FOREIGN KEY (`idADMINISTRATEUR`) REFERENCES `administrateur` (`idADMINISTRATEUR`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_PROGRAMMES_CLASSE1` FOREIGN KEY (`CLASSE_idCLASSE`) REFERENCES `classe` (`idCLASSE`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_PROGRAMMES_PROFESSEUR_has_MATIERE1` FOREIGN KEY (`idPROFESSEUR`,`idMATIERE`) REFERENCES `professeur_matiere` (`idPROFESSEUR`, `idMATIERE`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
