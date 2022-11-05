SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Table structure for table `#__banners`
--

CREATE TABLE IF NOT EXISTS `#__banners` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cid` int NOT NULL DEFAULT 0,
  `type` int NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `imptotal` int NOT NULL DEFAULT 0,
  `impmade` int NOT NULL DEFAULT 0,
  `clicks` int NOT NULL DEFAULT 0,
  `clickurl` varchar(200) NOT NULL DEFAULT '',
  `state` tinyint NOT NULL DEFAULT 0,
  `catid` int unsigned NOT NULL DEFAULT 0,
  `description` text NOT NULL,
  `custombannercode` varchar(2048) NOT NULL,
  `sticky` tinyint unsigned NOT NULL DEFAULT 0,
  `ordering` int NOT NULL DEFAULT 0,
  `metakey` text,
  `params` text NOT NULL,
  `own_prefix` tinyint NOT NULL DEFAULT 0,
  `metakey_prefix` varchar(400) NOT NULL DEFAULT '',
  `purchase_type` tinyint NOT NULL DEFAULT -1,
  `track_clicks` tinyint NOT NULL DEFAULT -1,
  `track_impressions` tinyint NOT NULL DEFAULT -1,
  `checked_out` int unsigned,
  `checked_out_time` datetime,
  `publish_up` datetime,
  `publish_down` datetime,
  `reset` datetime,
  `created` datetime NOT NULL,
  `language` char(7) NOT NULL DEFAULT '',
  `created_by` int unsigned NOT NULL DEFAULT 0,
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL,
  `modified_by` int unsigned NOT NULL DEFAULT 0,
  `version` int unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `idx_state` (`state`),
  KEY `idx_own_prefix` (`own_prefix`),
  KEY `idx_metakey_prefix` (`metakey_prefix`(100)),
  KEY `idx_banner_catid` (`catid`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__banner_clients`
--

CREATE TABLE IF NOT EXISTS `#__banner_clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `contact` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `extrainfo` text NOT NULL,
  `state` tinyint NOT NULL DEFAULT 0,
  `checked_out` int unsigned,
  `checked_out_time` datetime,
  `metakey` text,
  `own_prefix` tinyint NOT NULL DEFAULT 0,
  `metakey_prefix` varchar(400) NOT NULL DEFAULT '',
  `purchase_type` tinyint NOT NULL DEFAULT -1,
  `track_clicks` tinyint NOT NULL DEFAULT -1,
  `track_impressions` tinyint NOT NULL DEFAULT -1,
  PRIMARY KEY (`id`),
  KEY `idx_own_prefix` (`own_prefix`),
  KEY `idx_metakey_prefix` (`metakey_prefix`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__banner_tracks`
--

CREATE TABLE IF NOT EXISTS `#__banner_tracks` (
  `track_date` datetime NOT NULL,
  `track_type` int unsigned NOT NULL,
  `banner_id` int unsigned NOT NULL,
  `count` int unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`track_date`,`track_type`,`banner_id`),
  KEY `idx_track_date` (`track_date`),
  KEY `idx_track_type` (`track_type`),
  KEY `idx_banner_id` (`banner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__contact_details`
--

CREATE TABLE IF NOT EXISTS `#__contact_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `alias` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `con_position` varchar(255),
  `address` text,
  `suburb` varchar(100),
  `state` varchar(100),
  `country` varchar(100),
  `postcode` varchar(100),
  `telephone` varchar(255),
  `fax` varchar(255),
  `misc` mediumtext,
  `image` varchar(255),
  `email_to` varchar(255),
  `default_con` tinyint unsigned NOT NULL DEFAULT 0,
  `published` tinyint NOT NULL DEFAULT 0,
  `checked_out` int unsigned,
  `checked_out_time` datetime,
  `ordering` int NOT NULL DEFAULT 0,
  `params` text NOT NULL,
  `user_id` int NOT NULL DEFAULT 0,
  `catid` int NOT NULL DEFAULT 0,
  `access` int unsigned NOT NULL DEFAULT 0,
  `mobile` varchar(255) NOT NULL DEFAULT '',
  `webpage` varchar(255) NOT NULL DEFAULT '',
  `sortname1` varchar(255) NOT NULL DEFAULT '',
  `sortname2` varchar(255) NOT NULL DEFAULT '',
  `sortname3` varchar(255) NOT NULL DEFAULT '',
  `language` varchar(7) NOT NULL,
  `created` datetime NOT NULL,
  `created_by` int unsigned NOT NULL DEFAULT 0,
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL,
  `modified_by` int unsigned NOT NULL DEFAULT 0,
  `metakey` text,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `featured` tinyint unsigned NOT NULL DEFAULT 0 COMMENT 'Set if contact is featured.',
  `publish_up` datetime,
  `publish_down` datetime,
  `version` int unsigned NOT NULL DEFAULT 1,
  `hits` int unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`published`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__content`
--

CREATE TABLE IF NOT EXISTS `#__content` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int unsigned NOT NULL DEFAULT 0 COMMENT 'FK to the #__assets table.',
  `title` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `introtext` mediumtext NOT NULL,
  `fulltext` mediumtext NOT NULL,
  `state` tinyint NOT NULL DEFAULT 0,
  `catid` int unsigned NOT NULL DEFAULT 0,
  `created` datetime NOT NULL,
  `created_by` int unsigned NOT NULL DEFAULT 0,
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL,
  `modified_by` int unsigned NOT NULL DEFAULT 0,
  `checked_out` int unsigned,
  `checked_out_time` datetime NULL DEFAULT NULL,
  `publish_up` datetime NULL DEFAULT NULL,
  `publish_down` datetime NULL DEFAULT NULL,
  `images` text NOT NULL,
  `urls` text NOT NULL,
  `attribs` varchar(5120) NOT NULL,
  `version` int unsigned NOT NULL DEFAULT 1,
  `ordering` int NOT NULL DEFAULT 0,
  `metakey` text,
  `metadesc` text NOT NULL,
  `access` int unsigned NOT NULL DEFAULT 0,
  `hits` int unsigned NOT NULL DEFAULT 0,
  `metadata` text NOT NULL,
  `featured` tinyint unsigned NOT NULL DEFAULT 0 COMMENT 'Set if article is featured.',
  `language` char(7) NOT NULL COMMENT 'The language code for the article.',
  `note` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_alias` (`alias`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__content_frontpage`
--

CREATE TABLE IF NOT EXISTS `#__content_frontpage` (
  `content_id` int NOT NULL DEFAULT 0,
  `ordering` int NOT NULL DEFAULT 0,
  `featured_up` datetime,
  `featured_down` datetime,
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__content_rating`
--

CREATE TABLE IF NOT EXISTS `#__content_rating` (
  `content_id` int NOT NULL DEFAULT 0,
  `rating_sum` int unsigned NOT NULL DEFAULT 0,
  `rating_count` int unsigned NOT NULL DEFAULT 0,
  `lastip` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__finder_filters`
--

CREATE TABLE IF NOT EXISTS `#__finder_filters` (
  `filter_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `state` tinyint NOT NULL DEFAULT 1,
  `created` datetime NOT NULL,
  `created_by` int unsigned NOT NULL DEFAULT 0,
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL,
  `modified_by` int unsigned NOT NULL DEFAULT 0,
  `checked_out` int unsigned,
  `checked_out_time` datetime,
  `map_count` int unsigned NOT NULL DEFAULT 0,
  `data` text,
  `params` mediumtext,
  PRIMARY KEY (`filter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__finder_links`
--

CREATE TABLE IF NOT EXISTS `#__finder_links` (
  `link_id` int unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `route` varchar(400) NOT NULL,
  `title` varchar(400) DEFAULT NULL,
  `description` text,
  `indexdate` datetime NOT NULL,
  `md5sum` varchar(32) DEFAULT NULL,
  `published` tinyint NOT NULL DEFAULT 1,
  `state` int NOT NULL DEFAULT 1,
  `access` int NOT NULL DEFAULT 0,
  `language` char(7) NOT NULL DEFAULT '',
  `publish_start_date` datetime,
  `publish_end_date` datetime,
  `start_date` datetime,
  `end_date` datetime,
  `list_price` double unsigned NOT NULL DEFAULT 0,
  `sale_price` double unsigned NOT NULL DEFAULT 0,
  `type_id` int NOT NULL,
  `object` mediumblob,
  PRIMARY KEY (`link_id`),
  KEY `idx_type` (`type_id`),
  KEY `idx_title` (`title`(100)),
  KEY `idx_md5` (`md5sum`),
  KEY `idx_url` (`url`(75)),
  KEY `idx_language` (`language`),
  KEY `idx_published_list` (`published`,`state`,`access`,`publish_start_date`,`publish_end_date`,`list_price`),
  KEY `idx_published_sale` (`published`,`state`,`access`,`publish_start_date`,`publish_end_date`,`sale_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__finder_links_terms`
--

CREATE TABLE IF NOT EXISTS `#__finder_links_terms` (
  `link_id` int unsigned NOT NULL,
  `term_id` int unsigned NOT NULL,
  `weight` float unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__finder_logging`
--

CREATE TABLE IF NOT EXISTS `#__finder_logging` (
  `searchterm` VARCHAR(255) NOT NULL DEFAULT '',
  `md5sum` VARCHAR(32) NOT NULL DEFAULT '',
  `query` BLOB NOT NULL,
  `hits` int NOT NULL DEFAULT 1,
  `results` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`md5sum`),
  INDEX `searchterm` (`searchterm`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__finder_taxonomy`
--

CREATE TABLE IF NOT EXISTS `#__finder_taxonomy` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` int UNSIGNED NOT NULL DEFAULT '0',
  `lft` int NOT NULL DEFAULT '0',
  `rgt` int NOT NULL DEFAULT '0',
  `level` int UNSIGNED NOT NULL DEFAULT '0',
  `path` VARCHAR(400) NOT NULL DEFAULT '',
  `title` VARCHAR(255) NOT NULL DEFAULT '',
  `alias` VARCHAR(400) NOT NULL DEFAULT '',
  `state` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `access` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `language` CHAR(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  INDEX `idx_state` (`state`),
  INDEX `idx_access` (`access`),
  INDEX `idx_path` (`path`(100)),
  INDEX `idx_level` (`level`),
  INDEX `idx_left_right` (`lft`, `rgt`),
  INDEX `idx_alias` (`alias`(100)),
  INDEX `idx_language` (`language`),
  INDEX `idx_parent_published` (`parent_id`, `state`, `access`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `#__finder_taxonomy`
--

INSERT INTO `#__finder_taxonomy` (`id`, `parent_id`, `lft`, `rgt`, `level`, `path`, `title`, `alias`, `state`, `access`, `language`) VALUES
(1, 0, 0, 1, 0, '', 'ROOT', 'root', 1, 1, '*');

-- --------------------------------------------------------

--
-- Table structure for table `#__finder_taxonomy_map`
--

CREATE TABLE IF NOT EXISTS `#__finder_taxonomy_map` (
  `link_id` int unsigned NOT NULL,
  `node_id` int unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`node_id`),
  KEY `link_id` (`link_id`),
  KEY `node_id` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__finder_terms`
--

CREATE TABLE IF NOT EXISTS `#__finder_terms` (
  `term_id` int unsigned NOT NULL AUTO_INCREMENT,
  `term` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `stem` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `common` tinyint unsigned NOT NULL DEFAULT 0,
  `phrase` tinyint unsigned NOT NULL DEFAULT 0,
  `weight` float unsigned NOT NULL DEFAULT 0,
  `soundex` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `links` int NOT NULL DEFAULT 0,
  `language` char(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`term_id`),
  UNIQUE KEY `idx_term_language` (`term`,`language`),
  KEY `idx_stem` (`stem`),
  KEY `idx_term_phrase` (`term`,`phrase`),
  KEY `idx_stem_phrase` (`stem`,`phrase`),
  KEY `idx_soundex_phrase` (`soundex`,`phrase`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__finder_terms_common`
--

CREATE TABLE IF NOT EXISTS `#__finder_terms_common` (
  `term` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `language` char(7) NOT NULL DEFAULT '',
  `custom` int NOT NULL DEFAULT '0',
  UNIQUE KEY `idx_term_language` (`term`,`language`),
  KEY `idx_lang` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `#__finder_terms_common`
--

INSERT INTO `#__finder_terms_common` (`term`, `language`, `custom`) VALUES
('i', 'en', 0),
('me', 'en', 0),
('my', 'en', 0),
('myself', 'en', 0),
('we', 'en', 0),
('our', 'en', 0),
('ours', 'en', 0),
('ourselves', 'en', 0),
('you', 'en', 0),
('your', 'en', 0),
('yours', 'en', 0),
('yourself', 'en', 0),
('yourselves', 'en', 0),
('he', 'en', 0),
('him', 'en', 0),
('his', 'en', 0),
('himself', 'en', 0),
('she', 'en', 0),
('her', 'en', 0),
('hers', 'en', 0),
('herself', 'en', 0),
('it', 'en', 0),
('its', 'en', 0),
('itself', 'en', 0),
('they', 'en', 0),
('them', 'en', 0),
('their', 'en', 0),
('theirs', 'en', 0),
('themselves', 'en', 0),
('what', 'en', 0),
('which', 'en', 0),
('who', 'en', 0),
('whom', 'en', 0),
('this', 'en', 0),
('that', 'en', 0),
('these', 'en', 0),
('those', 'en', 0),
('am', 'en', 0),
('is', 'en', 0),
('are', 'en', 0),
('was', 'en', 0),
('were', 'en', 0),
('be', 'en', 0),
('been', 'en', 0),
('being', 'en', 0),
('have', 'en', 0),
('has', 'en', 0),
('had', 'en', 0),
('having', 'en', 0),
('do', 'en', 0),
('does', 'en', 0),
('did', 'en', 0),
('doing', 'en', 0),
('would', 'en', 0),
('should', 'en', 0),
('could', 'en', 0),
('ought', 'en', 0),
('i\'m', 'en', 0),
('you\'re', 'en', 0),
('he\'s', 'en', 0),
('she\'s', 'en', 0),
('it\'s', 'en', 0),
('we\'re', 'en', 0),
('they\'re', 'en', 0),
('i\'ve', 'en', 0),
('you\'ve', 'en', 0),
('we\'ve', 'en', 0),
('they\'ve', 'en', 0),
('i\'d', 'en', 0),
('you\'d', 'en', 0),
('he\'d', 'en', 0),
('she\'d', 'en', 0),
('we\'d', 'en', 0),
('they\'d', 'en', 0),
('i\'ll', 'en', 0),
('you\'ll', 'en', 0),
('he\'ll', 'en', 0),
('she\'ll', 'en', 0),
('we\'ll', 'en', 0),
('they\'ll', 'en', 0),
('isn\'t', 'en', 0),
('aren\'t', 'en', 0),
('wasn\'t', 'en', 0),
('weren\'t', 'en', 0),
('hasn\'t', 'en', 0),
('haven\'t', 'en', 0),
('hadn\'t', 'en', 0),
('doesn\'t', 'en', 0),
('don\'t', 'en', 0),
('didn\'t', 'en', 0),
('won\'t', 'en', 0),
('wouldn\'t', 'en', 0),
('shan\'t', 'en', 0),
('shouldn\'t', 'en', 0),
('can\'t', 'en', 0),
('cannot', 'en', 0),
('couldn\'t', 'en', 0),
('mustn\'t', 'en', 0),
('let\'s', 'en', 0),
('that\'s', 'en', 0),
('who\'s', 'en', 0),
('what\'s', 'en', 0),
('here\'s', 'en', 0),
('there\'s', 'en', 0),
('when\'s', 'en', 0),
('where\'s', 'en', 0),
('why\'s', 'en', 0),
('how\'s', 'en', 0),
('a', 'en', 0),
('an', 'en', 0),
('the', 'en', 0),
('and', 'en', 0),
('but', 'en', 0),
('if', 'en', 0),
('or', 'en', 0),
('because', 'en', 0),
('as', 'en', 0),
('until', 'en', 0),
('while', 'en', 0),
('of', 'en', 0),
('at', 'en', 0),
('by', 'en', 0),
('for', 'en', 0),
('with', 'en', 0),
('about', 'en', 0),
('against', 'en', 0),
('between', 'en', 0),
('into', 'en', 0),
('through', 'en', 0),
('during', 'en', 0),
('before', 'en', 0),
('after', 'en', 0),
('above', 'en', 0),
('below', 'en', 0),
('to', 'en', 0),
('from', 'en', 0),
('up', 'en', 0),
('down', 'en', 0),
('in', 'en', 0),
('out', 'en', 0),
('on', 'en', 0),
('off', 'en', 0),
('over', 'en', 0),
('under', 'en', 0),
('again', 'en', 0),
('further', 'en', 0),
('then', 'en', 0),
('once', 'en', 0),
('here', 'en', 0),
('there', 'en', 0),
('when', 'en', 0),
('where', 'en', 0),
('why', 'en', 0),
('how', 'en', 0),
('all', 'en', 0),
('any', 'en', 0),
('both', 'en', 0),
('each', 'en', 0),
('few', 'en', 0),
('more', 'en', 0),
('most', 'en', 0),
('other', 'en', 0),
('some', 'en', 0),
('such', 'en', 0),
('no', 'en', 0),
('nor', 'en', 0),
('not', 'en', 0),
('only', 'en', 0),
('own', 'en', 0),
('same', 'en', 0),
('so', 'en', 0),
('than', 'en', 0),
('too', 'en', 0),
('very', 'en', 0);

-- --------------------------------------------------------

--
-- Table structure for table `#__finder_tokens`
--

CREATE TABLE IF NOT EXISTS `#__finder_tokens` (
  `term` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `stem` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `common` tinyint unsigned NOT NULL DEFAULT 0,
  `phrase` tinyint unsigned NOT NULL DEFAULT 0,
  `weight` float unsigned NOT NULL DEFAULT 1,
  `context` tinyint unsigned NOT NULL DEFAULT 2,
  `language` char(7) NOT NULL DEFAULT '',
  KEY `idx_word` (`term`),
  KEY `idx_stem` (`stem`),
  KEY `idx_context` (`context`),
  KEY `idx_language` (`language`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__finder_tokens_aggregate`
--

CREATE TABLE IF NOT EXISTS `#__finder_tokens_aggregate` (
  `term_id` int unsigned NOT NULL,
  `term` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `stem` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `common` tinyint unsigned NOT NULL DEFAULT 0,
  `phrase` tinyint unsigned NOT NULL DEFAULT 0,
  `term_weight` float unsigned NOT NULL DEFAULT 0,
  `context` tinyint unsigned NOT NULL DEFAULT 2,
  `context_weight` float unsigned NOT NULL DEFAULT 0,
  `total_weight` float unsigned NOT NULL DEFAULT 0,
  `language` char(7) NOT NULL DEFAULT '',
  KEY `token` (`term`),
  KEY `keyword_id` (`term_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__finder_types`
--

CREATE TABLE IF NOT EXISTS `#__finder_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `mime` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__messages`
--

CREATE TABLE IF NOT EXISTS `#__messages` (
  `message_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id_from` int unsigned NOT NULL DEFAULT 0,
  `user_id_to` int unsigned NOT NULL DEFAULT 0,
  `folder_id` tinyint unsigned NOT NULL DEFAULT 0,
  `date_time` datetime NOT NULL,
  `state` tinyint NOT NULL DEFAULT 0,
  `priority` tinyint unsigned NOT NULL DEFAULT 0,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `useridto_state` (`user_id_to`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__messages_cfg`
--

CREATE TABLE IF NOT EXISTS `#__messages_cfg` (
  `user_id` int unsigned NOT NULL DEFAULT 0,
  `cfg_name` varchar(100) NOT NULL DEFAULT '',
  `cfg_value` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `idx_user_var_name` (`user_id`,`cfg_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__newsfeeds`
--

CREATE TABLE IF NOT EXISTS `#__newsfeeds` (
  `catid` int NOT NULL DEFAULT 0,
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `alias` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `link` varchar(2048) NOT NULL DEFAULT '',
  `published` tinyint NOT NULL DEFAULT 0,
  `numarticles` int unsigned NOT NULL DEFAULT 1,
  `cache_time` int unsigned NOT NULL DEFAULT 3600,
  `checked_out` int unsigned,
  `checked_out_time` datetime,
  `ordering` int NOT NULL DEFAULT 0,
  `rtl` tinyint NOT NULL DEFAULT 0,
  `access` int unsigned NOT NULL DEFAULT 0,
  `language` char(7) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `created` datetime NOT NULL,
  `created_by` int unsigned NOT NULL DEFAULT 0,
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL,
  `modified_by` int unsigned NOT NULL DEFAULT 0,
  `metakey` text,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `publish_up` datetime,
  `publish_down` datetime,
  `description` text NOT NULL,
  `version` int unsigned NOT NULL DEFAULT 1,
  `hits` int unsigned NOT NULL DEFAULT 0,
  `images` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`published`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__privacy_requests`
--

CREATE TABLE IF NOT EXISTS `#__privacy_requests` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL DEFAULT '',
  `requested_at` datetime NOT NULL,
  `status` tinyint NOT NULL DEFAULT 0,
  `request_type` varchar(25) NOT NULL DEFAULT '',
  `confirm_token` varchar(100) NOT NULL DEFAULT '',
  `confirm_token_created_at` datetime,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__privacy_consents`
--

CREATE TABLE IF NOT EXISTS `#__privacy_consents` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT 0,
  `state` int NOT NULL DEFAULT 1,
  `created` datetime NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `remind` tinyint NOT NULL DEFAULT 0,
  `token` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__redirect_links`
--

CREATE TABLE IF NOT EXISTS `#__redirect_links` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `old_url` varchar(2048) NOT NULL,
  `new_url` varchar(2048),
  `referer` varchar(2048) NOT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  `hits` int unsigned NOT NULL DEFAULT 0,
  `published` tinyint NOT NULL,
  `created_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `header` smallint NOT NULL DEFAULT 301,
  PRIMARY KEY (`id`),
  KEY `idx_old_url` (`old_url`(100)),
  KEY `idx_link_modified` (`modified_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__action_logs`
--

CREATE TABLE IF NOT EXISTS `#__action_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `message_language_key` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `log_date` datetime NOT NULL,
  `extension` varchar(50) NOT NULL DEFAULT '',
  `user_id` int NOT NULL DEFAULT 0,
  `item_id` int NOT NULL DEFAULT 0,
  `ip_address` VARCHAR(40) NOT NULL DEFAULT '0.0.0.0',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_user_id_logdate` (`user_id`, `log_date`),
  KEY `idx_user_id_extension` (`user_id`, `extension`),
  KEY `idx_extension_item_id` (`extension`, `item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__action_logs_extensions`
--

CREATE TABLE IF NOT EXISTS `#__action_logs_extensions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `extension` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

INSERT INTO `#__action_logs_extensions` (`id`, `extension`) VALUES
(1, 'com_banners'),
(2, 'com_cache'),
(3, 'com_categories'),
(4, 'com_config'),
(5, 'com_contact'),
(6, 'com_content'),
(7, 'com_installer'),
(8, 'com_media'),
(9, 'com_menus'),
(10, 'com_messages'),
(11, 'com_modules'),
(12, 'com_newsfeeds'),
(13, 'com_plugins'),
(14, 'com_redirect'),
(15, 'com_tags'),
(16, 'com_templates'),
(17, 'com_users'),
(18, 'com_checkin'),
(19, 'com_scheduler');

-- --------------------------------------------------------

--
-- Table structure for table `#__action_log_config`
--

CREATE TABLE IF NOT EXISTS `#__action_log_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type_title` varchar(255) NOT NULL DEFAULT '',
  `type_alias` varchar(255) NOT NULL DEFAULT '',
  `id_holder` varchar(255),
  `title_holder` varchar(255),
  `table_name` varchar(255),
  `text_prefix` varchar(255),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

INSERT INTO `#__action_log_config` (`id`, `type_title`, `type_alias`, `id_holder`, `title_holder`, `table_name`, `text_prefix`) VALUES
(1, 'article', 'com_content.article', 'id' ,'title' , '#__content', 'PLG_ACTIONLOG_JOOMLA'),
(2, 'article', 'com_content.form', 'id', 'title' , '#__content', 'PLG_ACTIONLOG_JOOMLA'),
(3, 'banner', 'com_banners.banner', 'id' ,'name' , '#__banners', 'PLG_ACTIONLOG_JOOMLA'),
(4, 'user_note', 'com_users.note', 'id', 'subject' ,'#__user_notes', 'PLG_ACTIONLOG_JOOMLA'),
(5, 'media', 'com_media.file', '' , 'name' , '',  'PLG_ACTIONLOG_JOOMLA'),
(6, 'category', 'com_categories.category', 'id' , 'title' , '#__categories', 'PLG_ACTIONLOG_JOOMLA'),
(7, 'menu', 'com_menus.menu', 'id' ,'title' , '#__menu_types', 'PLG_ACTIONLOG_JOOMLA'),
(8, 'menu_item', 'com_menus.item', 'id' , 'title' , '#__menu', 'PLG_ACTIONLOG_JOOMLA'),
(9, 'newsfeed', 'com_newsfeeds.newsfeed', 'id' ,'name' , '#__newsfeeds', 'PLG_ACTIONLOG_JOOMLA'),
(10, 'link', 'com_redirect.link', 'id', 'old_url' , '#__redirect_links', 'PLG_ACTIONLOG_JOOMLA'),
(11, 'tag', 'com_tags.tag', 'id', 'title' , '#__tags', 'PLG_ACTIONLOG_JOOMLA'),
(12, 'style', 'com_templates.style', 'id' , 'title' , '#__template_styles', 'PLG_ACTIONLOG_JOOMLA'),
(13, 'plugin', 'com_plugins.plugin', 'extension_id' , 'name' , '#__extensions', 'PLG_ACTIONLOG_JOOMLA'),
(14, 'component_config', 'com_config.component', 'extension_id' , 'name', '', 'PLG_ACTIONLOG_JOOMLA'),
(15, 'contact', 'com_contact.contact', 'id', 'name', '#__contact_details', 'PLG_ACTIONLOG_JOOMLA'),
(16, 'module', 'com_modules.module', 'id' ,'title', '#__modules', 'PLG_ACTIONLOG_JOOMLA'),
(17, 'access_level', 'com_users.level', 'id' , 'title', '#__viewlevels', 'PLG_ACTIONLOG_JOOMLA'),
(18, 'banner_client', 'com_banners.client', 'id', 'name', '#__banner_clients', 'PLG_ACTIONLOG_JOOMLA'),
(19, 'application_config', 'com_config.application', '', 'name', '', 'PLG_ACTIONLOG_JOOMLA'),
(20, 'task', 'com_scheduler.task', 'id', 'title', '#__scheduler_tasks', 'PLG_ACTIONLOG_JOOMLA');

-- --------------------------------------------------------

--
-- Table structure for table `#__action_logs_users`
--

CREATE TABLE IF NOT EXISTS `#__action_logs_users` (
  `user_id` int UNSIGNED NOT NULL,
  `notify` tinyint UNSIGNED NOT NULL,
  `extensions` text NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `idx_notify` (`notify`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__scheduler_tasks`
--

CREATE TABLE IF NOT EXISTS `#__scheduler_tasks` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int unsigned NOT NULL DEFAULT 0 COMMENT 'FK to the #__assets table.',
  `title` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(128) NOT NULL COMMENT 'unique identifier for job defined by plugin',
  `execution_rules` text COMMENT 'Execution Rules, Unprocessed',
  `cron_rules` text COMMENT 'Processed execution rules, crontab-like JSON form',
  `state` tinyint NOT NULL DEFAULT FALSE,
  `last_exit_code` int NOT NULL DEFAULT 0 COMMENT 'Exit code when job was last run',
  `last_execution` datetime COMMENT 'Timestamp of last run',
  `next_execution` datetime COMMENT 'Timestamp of next (planned) run, referred for execution on trigger',
  `times_executed` int DEFAULT 0 COMMENT 'Count of successful triggers',
  `times_failed` int DEFAULT 0 COMMENT 'Count of failures',
  `locked` datetime,
  `priority` smallint NOT NULL DEFAULT 0,
  `ordering` int NOT NULL DEFAULT 0 COMMENT 'Configurable list ordering',
  `cli_exclusive` smallint NOT NULL DEFAULT 0 COMMENT 'If 1, the task is only accessible via CLI',
  `params` text NOT NULL,
  `note` text,
  `created` datetime NOT NULL,
  `created_by` int UNSIGNED NOT NULL DEFAULT 0,
  `checked_out` int unsigned,
  `checked_out_time` datetime,
  PRIMARY KEY (id),
  KEY `idx_type` (`type`),
  KEY `idx_state` (`state`),
  KEY `idx_last_exit` (`last_exit_code`),
  KEY `idx_next_exec` (`next_execution`),
  KEY `idx_locked` (`locked`),
  KEY `idx_priority` (`priority`),
  KEY `idx_cli_exclusive` (`cli_exclusive`),
  KEY `idx_checked_out` (`checked_out`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 DEFAULT COLLATE = utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `#__guidedtours`
--

CREATE TABLE IF NOT EXISTS `#__guidedtours` (
  `id` int NOT NULL AUTO_INCREMENT,
  `asset_id` int DEFAULT 0,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `ordering` int NOT NULL DEFAULT 0,
  `extensions` text NOT NULL,
  `url` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `created_by` int NOT NULL DEFAULT 0,
  `modified` datetime NOT NULL,
  `modified_by` int NOT NULL DEFAULT 0,
  `checked_out_time` datetime,
  `checked_out` int unsigned,
  `published` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `#__guidedtours`
--

INSERT INTO `#__guidedtours` (`id`, `asset_id`, `title`, `description`, `ordering`, `extensions`, `url`, `created`, `created_by`, `modified`, `modified_by`, `checked_out_time`, `checked_out`, `published`) VALUES
(1, 91, 'How to create a Guided Tour in Joomla Backend?', '<p>This Tour will show you how you can create a Guided Tour in the Joomla Backend!</p>', 0, '[\"com_guidedtours\"]', 'administrator/index.php?option=com_guidedtours&view=tours', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1),
(2, 92, 'How to create Articles?', '<p>This Tour will show you how you can create Articles in Joomla!</p>', 0, '[\"*\"]', 'administrator/index.php?option=com_content&view=articles', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1),
(3, 93, 'How to create Categories?', '<p>This Tour will show you how you can create Categories in Joomla!</p>', 0, '[\"*\"]', 'administrator/index.php?option=com_categories&view=categories&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1),
(4, 94, 'How to create Menus?', '<p>This Tour will show you how you can create Menus in Joomla!</p>', 0, '[\"*\"]', 'administrator/index.php?option=com_menus&view=menus', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1),
(5, 95, 'How to create Tags?', '<p>This Tour will show you how you can create Tags in Joomla!</p>', 0, '[\"*\"]', 'administrator/index.php?option=com_tags&view=tags', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1),
(6, 96, 'How to create Banners?', '<p>This Tour will show you how you can create Banners in Joomla!</p>', 0, '[\"*\"]', 'administrator/index.php?option=com_banners&view=banners', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1),
(7, 97, 'How to create Contacts?', '<p>This Tour will show you how you can create Contacts in Joomla!</p>', 0, '[\"*\"]', 'administrator/index.php?option=com_contact&view=contacts', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1),
(8, 97, 'How to create News Feeds?', '<p>This Tour will show you how you can create News Feeds in Joomla!</p>', 0, '[\"*\"]', 'administrator/index.php?option=com_newsfeeds&view=newsfeeds', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1),
(9, 102, 'How to create Smart Search?', '<p>This Tour will show you how you can create Smart Search in Joomla!</p>', 0, '[\"*\"]', 'administrator/index.php?option=com_finder&view=filters', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1),
(10, 103, 'How to create Users?', '<p>This will show youhow you can create Users in Joomla!</p>', 0, '[\"*\"]', 'administrator/index.php?option=com_users&view=users', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `#__guidedtour_steps`
--

CREATE TABLE IF NOT EXISTS `#__guidedtour_steps` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tour_id` int NOT NULL DEFAULT 0,
  `title` varchar(255) NOT NULL,
  `published` tinyint NOT NULL DEFAULT 0,
  `description` text NOT NULL,
  `ordering` int NOT NULL DEFAULT 0,
  `step-no` int NOT NULL DEFAULT 0,
  `position` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `type` int NOT NULL,
  `interactivetour` int NOT NULL DEFAULT 1,
  `url` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `created_by` int unsigned NOT NULL DEFAULT 0,
  `modified` datetime NOT NULL,
  `modified_by` int unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime,
  `checked_out` int unsigned,
  PRIMARY KEY (`id`),
  KEY `idx_tour` (`tour_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `#__guidedtour_steps`
--

INSERT INTO `#__guidedtour_steps` (`id`, `tour_id`, `title`, `published`, `description`, `ordering`, `step-no`, `position`, `target`, `type`, `interactivetour`, `url`, `created`, `created_by`, `modified`, `modified_by`) VALUES
(1, 1, 'Click here!', 1, '<p>This Tour will show you how you can create a Guided Tour in the Joomla Backend!</p>', 0, 1, 'bottom', '.button-new', 2, 1, 'administrator/index.php?option=com_guidedtours&view=tours', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(2, 1, 'Add title for your Tour', 1, '<p>Here you have to add the title of your Tour Step.</p>', 0, 1, 'bottom', '#jform_title', 2, 2, 'administrator/index.php?option=com_guidedtours&view=tour&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(3, 1, 'Add Content', 1, '<p>Add the content of your Tour here!</p>', 0, 1, 'bottom', '#details', 2, 2, 'administrator/index.php?option=com_guidedtours&view=tour&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(4, 1, 'Plugin selector', 1, '<p>Select the extensions where you want to show your Tour. e.g If you are creating a tour which is only in "Users" extensions then select Users here.</p>', 0, 1, 'bottom', '.choices__inner', 1, 1, 'administrator/index.php?option=com_guidedtours&view=tour&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(5, 1, 'URL', 1, '<p>Add Relative URL of the page from where you want to start your Tour.</p>', 0, 1, 'bottom', '#jform_url', 1, 1, 'administrator/index.php?option=com_guidedtours&view=tour&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(6, 1, 'Save and Close', 1, '<p>Save and close the tour.</p>', 0, 1, 'bottom', '#save-group-children-save', 2, 1, 'administrator/index.php?option=com_guidedtours&view=tour&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(7, 1, 'Create steps for your Tour', 1, '<p>Click on steps icon in the right.</p>', 0, 1, 'right', '.btn-info', 2, 1, 'administrator/index.php?option=com_guidedtours&view=tours', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(8, 1, 'Click here!', 1, '<p>Click here to create a new Step for your Tour.</p>', 0, 1, 'bottom', '.button-new', 2, 1, 'administrator/index.php?option=com_guidedtours&view=steps&tour_id=1', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(9, 1, 'Add title for your Tour.', 1, '<p>Here you have to add the title of your Tour Step. </p>', 0, 1, 'bottom', '#jform_title', 2, 2, 'administrator/index.php?option=com_guidedtours&view=step&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(10, 1, 'Add Content', 1, '<p>Add the content of your Tour here!</p>', 0, 1, 'bottom', '#details', 2, 2, 'administrator/index.php?option=com_guidedtours&view=step&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(11, 1, 'Position ', 1, '<p>Add the position of the Step you want. e.g. Right, Left, Top, Bottom.</p>', 0, 1, 'bottom', '#jform_position', 1, 1, 'administrator/index.php?option=com_guidedtours&view=step&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(12, 1, 'Target', 1, '<p>Add the ID name or Class name of the element where you want to attach your Tour.</p>', 0, 1, 'bottom', '#jform_target', 1, 1, 'administrator/index.php?option=com_guidedtours&view=step&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(13, 1, 'Type', 1, '<p>Select the Type you want for your tour steps.</p>', 0, 1, 'bottom', '#jform_type', 1, 1, 'administrator/index.php?option=com_guidedtours&view=step&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(14, 1, 'Save and Close', 1, '<p>Save and close the step.</p>', 0, 1, 'bottom', '#save-group-children-save', 2, 1, 'administrator/index.php?option=com_guidedtours&view=step&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(15, 1, 'Congratulations!!!', 1, '<p>You successfully created your first Guided Tour!</p>', 0, 1, 'bottom', '', 1, 1, 'administrator/index.php?option=com_guidedtours&view=step&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),

(16, 2, 'Click here!', 1, '<p>This Tour will show you how you can create Articles in Joomla!</p>', 0, 1, 'bottom', '.button-new', 1, 1, 'administrator/index.php?option=com_content&view=articles', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(17, 2, 'Add title for your Article', 1, '<p>Here you have to add the title of your Article.</p>', 0, 1, 'bottom', '#jform_title', 1, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(18, 2, 'Alias', 1, '<p>You can write the internal name of this article. You can leave this blank and Joomla will fill a default value in lower case with dashes instead of spaces.</p>', 0, 1, 'bottom', '#jform_alias', 1, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(19, 2, 'Add Content', 1, '<p>Add the content of your Article here!</p>', 0, 1, 'bottom', '#general', 1, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(20, 2, 'Status', 1, '<p>Here you can select Status for your article.</p>', 0, 1, 'bottom', '#jform_state', 1, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(21, 2, 'Category', 1, '<p>Select the Category for this article.</p>', 0, 1, 'bottom', '.choices__inner', 1, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(22, 2, 'Featured Article', 1, '<p>Click on the Featured tab to feature your article.</p>', 0, 1, 'bottom', '#jform_featured0', 1, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(23, 2, 'Access Level', 1, '<p>Here you can select Access level from Public, Guest, Registered, Special and Super Users.</p>', 0, 1, 'bottom', '#jform_access', 1, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(24, 2, 'Tags', 1, '<p>Select Tags for your article. You can also enter a new tag by typing the name in the field and pressing enter.</p>', 0, 1, 'bottom', '.advancedSelect', 1, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(25, 2, 'Note', 1, '<p>This is normally for the administrator use and does not show in the Frontend.</p>', 0, 1, 'bottom', '#jform_note', 1, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(26, 2, 'Version Note', 1, '<p>This is an optional field to identify the version of this article.</p>', 0, 1, 'bottom', '#jform_version_note', 1, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(27, 2, 'Save and Close ', 1, '<p>Save and close the Article.</p>', 0, 1, 'bottom', '#save-group-children-save', 1, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(28, 2, 'Congratulations!!!', 1, '<p>You successfully created your Article in Joomla!</p>', 0, 1, 'bottom', '', 1, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),

(29, 3, 'Click here!', 1, '<p>This Tour will show you how you can create Categories in Joomla!</p>', 0, 1, 'bottom', '.button-new', 1, 1, 'administrator/index.php?option=com_categories&view=categories&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(30, 3, 'Add title for your Categories', 1, '<p>Here you have to add the title of your Categories.</p>', 0, 1, 'bottom', '#jform_title', 1, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(31, 3, 'Alias', 1, '<p>You can write the internal name of this item. You can leave this blank and Joomla will fill a default value in lower case with dashes instead of spaces.</p>', 0, 1, 'bottom', '#jform_alias', 1, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(32, 3, 'Add Content', 1, '<p>Add the content of your Category here!</p>', 0, 1, 'bottom', '#general', 1, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(33, 3, 'Parent', 1, '<p>The item (category, menu item, and so on) is the parent of the item being edited.</p>', 0, 1, 'bottom', '.choices', 1, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(34, 3, 'Status', 1, '<p>Here you can select Status for your category.</p>', 0, 1, 'bottom', '#jform_published', 1, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(35, 3, 'Access Level', 1, '<p>Here you can select Access level from Public, Guest, Registered, Special and Super Users.</p>', 0, 1, 'bottom', '#jform_access', 1, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(36, 3, 'Tags', 1, '<p>Select Tags for your Category. You can also enter a new tag by typing the name in the field and pressing enter.</p>', 0, 1, 'bottom', 'advancedSelect', 1, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(37, 3, 'Note', 1, '<p>This is normally for the administrator use and does not show in the Frontend.</p>', 0, 1, 'bottom', '#jform_note', 1, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(38, 3, 'Version Note', 1, '<p>This is an optional field to identify the version of this item.</p>', 0, 1, 'bottom', '#jform_version_note', 1, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(39, 3, 'Save and Close ', 1, '<p>Save and close the Category.</p>', 0, 1, 'bottom', '#save-group-children-save', 1, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(40, 3, 'Congratulations!!!', 1, '<p>You successfully created your Category in Joomla!</p>', 0, 1, 'bottom', '', 1, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),

(41, 4, 'Click here!', 1, '<p>This Tour will show you how you can create Menus in Joomla!</p>', 0, 1, 'bottom', '.button-new', 1, 1, 'administrator/index.php?option=com_menus&view=menus', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(42, 4, 'Add title for your Menu', 1, '<p>Here you have to add the title of your Menu.</p>', 0, 1, 'bottom', '#jform_title', 1, 1, 'administrator/index.php?option=com_menus&view=menu&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(43, 4, 'Unique Name', 1, '<p>Here you have to write the system name of the menu.</p>', 0, 1, 'bottom', '#jform_menutype', 1, 1, 'administrator/index.php?option=com_menus&view=menu&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(44, 4, 'Description', 1, '<p>Add description about the purpose of the menu.</p>', 0, 1, 'bottom', '#jform_menudescription', 1, 1, 'administrator/index.php?option=com_menus&view=menu&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(45, 4, 'Save and Close ', 1, '<p>Save and close the menu.</p>', 0, 1, 'bottom', '#save-group-children-save', 1, 1, 'administrator/index.php?option=com_menus&view=menu&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(46, 4, 'Congratulations!!!', 1, '<p>You successfully created your Menu in Joomla!</p>', 0, 1, 'bottom', '', 1, 1, 'administrator/index.php?option=com_menus&view=menu&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),

(47, 5, 'Click here!', 1, '<p>This Tour will show you how you can create Tags in Joomla!</p>', 0, 1, 'bottom', '.button-new', 1, 1, 'administrator/index.php?option=com_tags&view=tags', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(48, 5, 'Add title for your Tags', 1, '<p>Here you have to add the title of your Tag.</p>', 0, 1, 'bottom', '#jform_title', 1, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(49, 5, 'Alias', 1, '<p>You can write the internal name of this item. You can leave this blank and Joomla will fill a default value in lower case with dashes instead of spaces.</p>', 0, 1, 'bottom', '#jform_alias', 1, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(50, 5, 'Add Content', 1, '<p>Add the content of your Tags here!</p>', 0, 1, 'bottom', '#details', 1, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(51, 5, 'Parent', 1, '<p>The item (category, menu item, and so on) is the parent of the item being edited.</p>', 0, 1, 'bottom', '.choices', 1, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(52, 5, 'Status', 1, '<p>Here you can select Status for your tag.</p>', 0, 1, 'bottom', '#jform_published', 1, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(53, 5, 'Access Level', 1, '<p>Here you can select Access level from Public, Guest, Registered, Special and Super Users.</p>', 0, 1, 'bottom', '#jform_access', 1, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(54, 5, 'Note', 1, '<p>This is normally for the administrator use and does not show in the Frontend.</p>', 0, 1, 'bottom', '#jform_note', 1, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(55, 5, 'Version Note', 1, '<p>This is an optional field to identify the version of this item.</p>', 0, 1, 'bottom', '#jform_version_note', 1, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(56, 5, 'Save and Close ', 1, '<p>Save and close the Tag.</p>', 0, 1, 'bottom', '#save-group-children-save', 1, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(57, 5, 'Congratulations!!!', 1, '<p>You successfully created your Tag in Joomla!</p>', 0, 1, 'bottom', '', 1, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),

(58, 6, 'Click here!', 1, '<p>This Tour will show you how you can create Banners in Joomla!</p>', 0, 1, 'bottom', '.button-new', 1, 1, 'administrator/index.php?option=com_banners&view=banners', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(59, 6, 'Add title for your Banner', 1, '<p>Here you have to add the title of your Banner.</p>', 0, 1, 'bottom', '#jform_name', 1, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(60, 6, 'Alias', 1, '<p>You can write the internal name of this banner. You can leave this blank and Joomla will fill a default value in lower case with dashes instead of spaces.</p>', 0, 1, 'bottom', '#jform_alias', 1, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(61, 6, 'Add Details', 1, '<p>Add the Details of your Banner here!</p>', 0, 1, 'bottom', '#details', 1, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(62, 6, 'Status', 1, '<p>Here you can select Status for your banner.</p>', 0, 1, 'bottom', '#jform_state', 1, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(63, 6, 'Category', 1, '<p>Select the Category for this banner.</p>', 0, 1, 'bottom', '.choices__inner', 1, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(64, 6, 'Pinned', 1, '<p>Click on the toggle to Pin your Banner.</p>', 0, 1, 'bottom', '##jform_sticky1', 1, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(65, 6, 'Version Note', 1, '<p>This is an optional field to identify the version of this banner.</p>', 0, 1, 'bottom', '#jform_version_note', 1, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(66, 6, 'Save and Close ', 1, '<p>Save and close the Banner.</p>', 0, 1, 'bottom', '#save-group-children-save', 1, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(67, 6, 'Congratulations!!!', 1, '<p>You successfully created your Banner in Joomla!</p>', 0, 1, 'bottom', '', 1, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),

(68, 7, 'Click here!', 1, '<p>This Tour will show you how you can create Contacts in Joomla!</p>', 0, 1, 'bottom', '.button-new', 1, 1, 'administrator/index.php?option=com_contact&view=contacts', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(69, 7, 'Add title for your Contact', 1, '<p>Here you have to add the title of your Contact.</p>', 0, 1, 'bottom', '#jform_name', 1, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(70, 7, 'Alias', 1, '<p>You can write the internal name of this contact. You can leave this blank and Joomla will fill a default value in lower case with dashes instead of spaces.</p>', 0, 1, 'bottom', '#jform_alias', 1, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(71, 7, 'Add Content', 1, '<p>Add the content of your Contacts here!</p>', 0, 1, 'bottom', '#details', 1, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(72, 7, 'Status', 1, '<p>Here you can select Status for your contact.</p>', 0, 1, 'bottom', '#jform_published', 1, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(73, 7, 'Category', 1, '<p>Select the Category for this contact.</p>', 0, 1, 'bottom', '.choices__inner', 1, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(74, 7, 'Featured Contact', 1, '<p>Click on the Featured tab to feature your contact.</p>', 0, 1, 'bottom', '#jform_featured0', 1, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(75, 7, 'Access Level', 1, '<p>Here you can select Access level from Public, Guest, Registered, Special and Super Users.</p>', 0, 1, 'bottom', '#jform_access', 1, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(76, 7, 'Tags', 1, '<p>Select Tags for your contact. You can also enter a new tag by typing the name in the field and pressing enter.</p>', 0, 1, 'bottom', '.advancedSelect', 1, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(77, 7, 'Version Note', 1, '<p>This is an optional field to identify the version of this contact.</p>', 0, 1, 'bottom', '#jform_version_note', 1, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(78, 7, 'Save and Close ', 1, '<p>Save and close the Contact.</p>', 0, 1, 'bottom', '#save-group-children-save', 1, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(79, 7, 'Congratulations!!!', 1, '<p>You successfully created your Contact in Joomla!</p>', 0, 1, 'bottom', '', 1, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),

(80, 8, 'Click here!', 1, '<p>This Tour will show you how you can create News Feeds in Joomla!</p>', 0, 1, 'bottom', '.button-new', 1, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeeds', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(81, 8, 'Add title for your News Feeds', 1, '<p>Here you have to add the title of your News Feeds.</p>', 0, 1, 'bottom', '#jform_title', 1, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(82, 8, 'Alias', 1, '<p>You can write the internal name of this news feed. You can leave this blank and Joomla will fill a default value in lower case with dashes instead of spaces.</p>', 0, 1, 'bottom', '#jform_alias', 1, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(83, 8, 'Add Link', 1, '<p>Add the Link of this News Feeds here!</p>', 0, 1, 'bottom', '#jform_link', 1, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(84, 8, 'Add Content', 1, '<p>Add the content of your News Feeds here!</p>', 0, 1, 'bottom', '#details', 1, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(85, 8, 'Status', 1, '<p>Here you can select Status for your news feeds.</p>', 0, 1, 'bottom', '#jform_state', 1, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(86, 8, 'Category', 1, '<p>Select the Category for this news feeds.</p>', 0, 1, 'bottom', '.choices__inner', 1, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(87, 8, 'Access Level', 1, '<p>Here you can select Access level from Public, Guest, Registered, Special and Super Users.</p>', 0, 1, 'bottom', '#jform_access', 1, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(88, 8, 'Tags', 1, '<p>Select Tags for your news feeds. You can also enter a new tag by typing the name in the field and pressing enter.</p>', 0, 1, 'bottom', '.choices__input choices__input--cloned', 1, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(89, 8, 'Version Note', 1, '<p>This is an optional field to identify the version of this news feeds.</p>', 0, 1, 'bottom', '#jform_version_note', 1, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(90, 8, 'Save and Close ', 1, '<p>Save and close the News Feeds.</p>', 0, 1, 'bottom', '#save-group-children-save', 1, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(91, 8, 'Congratulations!!!', 1, '<p>You successfully created your News Feeds in Joomla!</p>', 0, 1, 'bottom', '', 1, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),

(92, 9, 'Click here!', 1, '<p>This Tour will show you how you can create Smart Search in Joomla!</p>', 0, 1, 'bottom', '.button-new', 1, 1, 'administrator/index.php?option=com_finder&view=filters', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(93, 9, 'Add title for your Smart Search', 1, '<p>Here you have to add the title of your Smart Search.</p>', 0, 1, 'bottom', '#jform_title', 1, 1, 'administrator/index.php?option=com_finder&view=filter&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(94, 9, 'Alias', 1, '<p>You can write the internal name of this smart search. You can leave this blank and Joomla will fill a default value in lower case with dashes instead of spaces.</p>', 0, 1, 'bottom', '#jform_alias', 1, 1, 'administrator/index.php?option=com_finder&view=filter&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(95, 9, 'Add Content', 1, '<p>Add the content of your Smart Search here!</p>', 0, 1, 'bottom', '#details', 1, 1, 'administrator/index.php?option=com_finder&view=filter&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(96, 9, 'Status', 1, '<p>Here you can select Status for your smart search.</p>', 0, 1, 'bottom', '#jform_state', 1, 1, 'administrator/index.php?option=com_finder&view=filter&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(97, 9, 'Save and Close ', 1, '<p>Save and close the Smart Search.</p>', 0, 1, 'bottom', '#save-group-children-save', 1, 1, 'administrator/index.php?option=com_finder&view=filter&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(98, 9, 'Congratulations!!!', 1, '<p>You successfully created your Smart Search in Joomla!</p>', 0, 1, 'bottom', '', 1, 1, 'administrator/index.php?option=com_finder&view=filter&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),

(99, 10, 'Click here!', 1, '<p>This will show you how you can create Users in Joomla!</p>', 0, 1, 'bottom', '.button-new', 1, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(100, 10, 'Add Name of the User', 1, '<p>Here you have to add the name of the User.</p>', 0, 1, 'bottom', '#jform_name', 1, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(101, 10, 'Add Login Name', 1, '<p>Enter the login name (Username) for the user.</p>', 0, 1, 'bottom', '#jform_username', 1, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(102, 10, 'Password', 1, '<p>Fill in a (new) password. Although this field is not required, the user will not be able to log in when no password is set.</p>', 0, 1, 'bottom', '#jform_password', 1, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(103, 10, 'Confirm Password', 1, '<p>Fill in the password from the field above again, to verify it. This field is required when you filled in the New password field.</p>', 0, 1, 'bottom', '#jform_password2', 1, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(104, 10, 'Email', 1, '<p>Enter an email address for the user.</p>', 0, 1, 'bottom', '#jform_email', 1, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(105, 10, 'Receive System Emails', 1, '<p>Set to yes, if you want to receive system emails.</p>', 0, 1, 'bottom', '#jform_sendEmail', 1, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(106, 10, 'User Status', 1, '<p>Enable or block this user.</p>', 0, 1, 'bottom', '#jform_block0', 1, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(107, 10, 'Require Password Reset', 1, '<p>If set to yes, the user will have to reset their password the next time they log into the site.</p>', 0, 1, 'bottom', '#jform_requireReset0', 1, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(108, 10, 'Save and Close ', 1, '<p>Save and close the User.</p>', 0, 1, 'bottom', '#save-group-children-save', 1, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0),
(109, 10, 'Congratulations!!!', 1, '<p>You successfully created your User in Joomla!</p>', 0, 1, 'bottom', '', 1, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0);