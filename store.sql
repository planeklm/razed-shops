CREATE TABLE IF NOT EXISTS `playerstores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `owned` varchar(20) NOT NULL DEFAULT 'false',
  `balance` double NOT NULL,
  `stock` double NOT NULL,
  `capacity` double NOT NULL,
  `totaldeliveries` double NOT NULL,
  `rating` double NOT NULL,
  `location` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
)