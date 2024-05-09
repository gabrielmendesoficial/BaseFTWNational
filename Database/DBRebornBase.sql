-- Copiando estrutura do banco de dados para rbn_base
CREATE DATABASE IF NOT EXISTS `rbn_base` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `rbn_base`;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela rbn_base.vrp_infos
CREATE TABLE `vrp_infos` (
	`id` INT(12) NOT NULL AUTO_INCREMENT,
	`steam` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`whitelist` TINYINT(1) NULL DEFAULT '0',
	`banned` TINYINT(1) NULL DEFAULT '0',
	`gems` INT(11) NOT NULL DEFAULT '0',
	`premium` INT(12) NOT NULL DEFAULT '0',
	`predays` INT(2) NOT NULL DEFAULT '0',
	`priority` INT(3) NOT NULL DEFAULT '0',
	`chars` INT(1) NOT NULL DEFAULT '1',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `steam` (`steam`) USING BTREE
)COLLATE='latin1_swedish_ci' ENGINE=InnoDB;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela rbn_base.vrp_invoice
CREATE TABLE IF NOT EXISTS `vrp_invoice` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `date` varchar(25) NOT NULL DEFAULT '0.0.0',
  `price` int(11) NOT NULL DEFAULT 0,
  `text` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nuser_id` (`nuser_id`),
  KEY `user_id` (`user_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela rbn_base.vrp_permissions
CREATE TABLE IF NOT EXISTS `vrp_permissions` (
  `id` int(11) unsigned NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `permiss` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela rbn_base.vrp_srv_data
CREATE TABLE IF NOT EXISTS `vrp_srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`dkey`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela rbn_base.vrp_users
CREATE TABLE IF NOT EXISTS `vrp_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(100) DEFAULT NULL,
  `registration` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT 'Individuo',
  `name2` varchar(50) DEFAULT 'Indigente',
  `bank` int(12) NOT NULL DEFAULT 20000,
  `chavePix` varchar(255) DEFAULT NULL,
  `garage` int(3) NOT NULL DEFAULT 2,
  `prison` int(6) NOT NULL DEFAULT 0,
  `locate` int(1) NOT NULL DEFAULT 1,
  `deleted` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela rbn_base.vrp_user_data
CREATE TABLE IF NOT EXISTS `vrp_user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dkey`),
  KEY `user_id` (`user_id`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela rbn_base.vrp_user_ids
CREATE TABLE IF NOT EXISTS `vrp_user_ids` (
  `identifier` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela rbn_base.vrp_vehicles
CREATE TABLE IF NOT EXISTS `vrp_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `plate` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `arrest` int(1) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `premiumtime` int(11) NOT NULL DEFAULT 0,
  `rentaltime` int(11) NOT NULL DEFAULT 0,
  `engine` int(4) NOT NULL DEFAULT 1000,
  `body` int(4) NOT NULL DEFAULT 1000,
  `fuel` int(3) NOT NULL DEFAULT 100,
  `work` varchar(10) NOT NULL DEFAULT 'false',
  `doors` varchar(254) NOT NULL,
  `windows` varchar(254) NOT NULL,
  `tyres` varchar(254) NOT NULL,
  `alugado` tinyint(4) NOT NULL DEFAULT 0,
  `data_alugado` text DEFAULT NULL,
  `stoled_by` text DEFAULT NULL,
  `stoled_at` text DEFAULT NULL,
  `garage` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`vehicle`),
  KEY `user_id` (`user_id`),
  KEY `vehicle` (`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela rbn_base.will_sprays
CREATE TABLE IF NOT EXISTS `will_sprays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` float(8,4) NOT NULL,
  `y` float(8,4) NOT NULL,
  `z` float(8,4) NOT NULL,
  `rx` float(8,4) NOT NULL,
  `ry` float(8,4) NOT NULL,
  `rz` float(8,4) NOT NULL,
  `scale` float(8,4) NOT NULL,
  `text` varchar(32) NOT NULL,
  `font` varchar(32) NOT NULL,
  `color` varchar(50) NOT NULL DEFAULT '',
  `interior` int(3) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `will_ficha` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`user_id` INT(50) NULL DEFAULT NULL,
	`status` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`image` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`data` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`infos` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`id`) USING BTREE
) COLLATE='utf8mb4_general_ci' ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `smartbank_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `smartbank_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `holder` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `pin` varchar(50) DEFAULT NULL,
  `hold` int(11) DEFAULT 0,
  `data` text DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `smartbank_fines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pix` varchar(50) NOT NULL DEFAULT '0',
  `from` varchar(50) NOT NULL DEFAULT '0',
  `source` varchar(50) NOT NULL DEFAULT '0',
  `author` varchar(50) NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT 0,
  `reason` varchar(50) NOT NULL DEFAULT '0',
  `time` int(255) NOT NULL,
  `active` int(1) NOT NULL DEFAULT 1,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `smartbank_statements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pix` varchar(50) NOT NULL DEFAULT '0',
  `from` varchar(50) NOT NULL DEFAULT '0',
  `source` varchar(50) NOT NULL DEFAULT '0',
  `type` varchar(50) NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT 0,
  `reason` varchar(50) NOT NULL DEFAULT '0',
  `time` int(255) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `user_bans` (
	`name` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`license` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`discord` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`ip` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`reason` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`expire` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`bannedby` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci'
) COLLATE='utf8mb4_general_ci' ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `will_battlepass` (
  `user_id` varchar(255) NULL DEFAULT '',
  `level` int(3) NOT NULL DEFAULT '0',
  `xp` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `ld_orgs` (
  `org` text NOT NULL DEFAULT '0',
  `bank` int(11) DEFAULT 0,
  `description` text DEFAULT NULL,
  `historico` text DEFAULT '{}',
  `permissions` longtext DEFAULT '{}',
  PRIMARY KEY (`org`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `ld_orgs_daily` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `org` varchar(50) DEFAULT '0',
  `itens` longtext DEFAULT NULL,
  `dia` int(11) DEFAULT NULL,
  `reward` text DEFAULT '{}',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `ld_orgs_monthly` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `org` text DEFAULT NULL,
  `itens` text DEFAULT NULL,
  `mes` int(11) DEFAULT NULL,
  `payment` text DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `ld_orgs_farm` (
  `org` varchar(50) NOT NULL DEFAULT '',
  `type` text DEFAULT NULL,
  `daily` int(11) DEFAULT NULL,
  `monthly` int(11) DEFAULT NULL,
  `payment` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `will_homes` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`house_id` INT(11) NOT NULL DEFAULT '0',
	`owner` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`name` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`friends` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`theme` TEXT NOT NULL DEFAULT 'modern' COLLATE 'utf8mb4_general_ci',
	`vault` INT(11) NOT NULL DEFAULT '100',
	`extends` TEXT NOT NULL DEFAULT '[]' COLLATE 'utf8mb4_general_ci',
	`tax` INT(11) NOT NULL DEFAULT '1572029150',
	PRIMARY KEY (`id`) USING BTREE
) COLLATE='utf8mb4_general_ci' ENGINE=InnoDB AUTO_INCREMENT=1;
