DROP TABLE IF EXISTS `Programs`;

CREATE TABLE `Programs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `pfm` text,
  `rec-timestamp` datetime NOT NULL,
  `station` varchar(30) DEFAULT '',
  `uri` text NOT NULL,
  `info` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8;