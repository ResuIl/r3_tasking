
CREATE TABLE IF NOT EXISTS `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `finished` varchar(50) DEFAULT 'false',
  `reward` varchar(50) DEFAULT NULL,
  `taskname` varchar(50) DEFAULT NULL,
  KEY `Column 1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
