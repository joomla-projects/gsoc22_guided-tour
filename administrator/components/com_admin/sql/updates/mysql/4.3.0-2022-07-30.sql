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
  `language` varchar(7) NOT NULL,
  `note` varchar(255) NOT NULL DEFAULT '',
  `access` int unsigned NOT NULL DEFAULT 0,
  `featured` tinyint unsigned NOT NULL DEFAULT 0 COMMENT 'Set if tour is featured.',
  `locked` tinyint NOT NULL DEFAULT 0 COMMENT 'Flag to indicate if the tour is locked. Locked tours cannot be edited on multi-lingual sites.',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_state` (`published`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `#__guidedtours`
--

INSERT IGNORE INTO `#__guidedtours` (`id`, `asset_id`, `title`, `description`, `ordering`, `extensions`, `url`, `created`, `created_by`, `modified`, `modified_by`, `checked_out_time`, `checked_out`, `published`, `language`, `locked`) VALUES
(1, 0, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_TITLE', 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_DESCRIPTION', 0, '[\"com_guidedtours\"]', 'administrator/index.php?option=com_guidedtours&view=tours', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1, '*', 1),
(2, 0, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_TITLE', 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_DESCRIPTION', 0, '[\"com_guidedtours\"]', 'administrator/index.php?option=com_guidedtours&view=tours', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1, '*', 1),
(3, 0, 'COM_GUIDEDTOURS_TOUR_ARTICLES_TITLE', 'COM_GUIDEDTOURS_TOUR_ARTICLES_DESCRIPTION', 0, '[\"*\"]', 'administrator/index.php?option=com_content&view=articles', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1, '*', 1),
(4, 0, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_TITLE', 'COM_GUIDEDTOURS_TOUR_CATEGORIES_DESCRIPTION', 0, '[\"*\"]', 'administrator/index.php?option=com_categories&view=categories&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1, '*', 1),
(5, 0, 'COM_GUIDEDTOURS_TOUR_MENUS_TITLE', 'COM_GUIDEDTOURS_TOUR_MENUS_DESCRIPTION', 0, '[\"*\"]', 'administrator/index.php?option=com_menus&view=menus', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1, '*', 1),
(6, 0, 'COM_GUIDEDTOURS_TOUR_TAGS_TITLE', 'COM_GUIDEDTOURS_TOUR_TAGS_DESCRIPTION', 0, '[\"*\"]', 'administrator/index.php?option=com_tags&view=tags', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1, '*', 1),
(7, 0, 'COM_GUIDEDTOURS_TOUR_BANNERS_TITLE', 'COM_GUIDEDTOURS_TOUR_BANNERS_DESCRIPTION', 0, '[\"*\"]', 'administrator/index.php?option=com_banners&view=banners', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1, '*', 1),
(8, 0, 'COM_GUIDEDTOURS_TOUR_CONTACTS_TITLE', 'COM_GUIDEDTOURS_TOUR_CONTACTS_DESCRIPTION', 0, '[\"*\"]', 'administrator/index.php?option=com_contact&view=contacts', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1, '*', 1),
(9, 0, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_TITLE', 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_DESCRIPTION', 0, '[\"*\"]', 'administrator/index.php?option=com_newsfeeds&view=newsfeeds', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1, '*', 1),
(10, 0, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_TITLE', 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_DESCRIPTION', 0, '[\"*\"]', 'administrator/index.php?option=com_finder&view=filters', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1, '*', 1),
(11, 0, 'COM_GUIDEDTOURS_TOUR_USERS_TITLE', 'COM_GUIDEDTOURS_TOUR_USERS_DESCRIPTION', 0, '[\"*\"]', 'administrator/index.php?option=com_users&view=users', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, NULL, 0, 1, '*', 1);

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
  `step_no` int NOT NULL DEFAULT 0,
  `position` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `type` int NOT NULL,
  `interactive_type` int NOT NULL DEFAULT 1,
  `url` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `created_by` int unsigned NOT NULL DEFAULT 0,
  `modified` datetime NOT NULL,
  `modified_by` int unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime,
  `checked_out` int unsigned,
  `language` varchar(7) NOT NULL,
  `note` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_tour` (`tour_id`),
  KEY `idx_state` (`published`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 DEFAULT COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `#__guidedtour_steps`
--

INSERT IGNORE INTO `#__guidedtour_steps` (`id`, `tour_id`, `title`, `published`, `description`, `ordering`, `step_no`, `position`, `target`, `type`, `interactive_type`, `url`, `created`, `created_by`, `modified`, `modified_by`, `language`) VALUES
(1, 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_STEP_NEW_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_STEP_NEW_DESCRIPTION', 0, 1, 'bottom', '.button-new', 2, 1, 'administrator/index.php?option=com_guidedtours&view=tours', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(2, 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_STEP_TITLE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_STEP_TITLE_DESCRIPTION', 0, 1, 'bottom', '#jform_title', 2, 2, 'administrator/index.php?option=com_guidedtours&view=tour&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(3, 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_STEP_CONTENT_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_STEP_CONTENT_DESCRIPTION', 0, 1, 'bottom', '.tox-edit-area__iframe', 2, 3, 'administrator/index.php?option=com_guidedtours&view=tour&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(4, 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_STEP_COMPONENT_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_STEP_COMPONENT_DESCRIPTION', 0, 1, 'top', 'joomla-field-fancy-select:has(#jform_extensions)', 0, 1, 'administrator/index.php?option=com_guidedtours&view=tour&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(5, 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_STEP_URL_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_STEP_URL_DESCRIPTION', 0, 1, 'top', '#jform_url', 0, 1, 'administrator/index.php?option=com_guidedtours&view=tour&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(6, 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_STEP_SAVECLOSE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_STEP_SAVECLOSE_DESCRIPTION', 0, 1, 'top', '#save-group-children-save .button-save', 2, 1, 'administrator/index.php?option=com_guidedtours&view=tour&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(7, 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_STEP_CONGRATULATIONS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURS_STEP_CONGRATULATIONS_DESCRIPTION', 0, 1, 'bottom', '', 0, 1, 'administrator/index.php?option=com_guidedtours&view=tour&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),

(8, 2, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_COUNTER_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_COUNTER_DESCRIPTION', 0, 1, 'top', '#categoryList tbody tr:nth-last-of-type(1) td:nth-last-of-type(2) .btn', 2, 1, '', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(9, 2, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_NEW_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_NEW_DESCRIPTION', 0, 1, 'bottom', '.button-new', 2, 1, '', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(10, 2, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_TITLE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_TITLE_DESCRIPTION', 0, 1, 'bottom', '#jform_title', 2, 2, '', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(11, 2, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_DESCRIPTION_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_DESCRIPTION_DESCRIPTION', 0, 1, 'bottom', '.tox-edit-area__iframe', 2, 3, '', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(12, 2, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_STATUS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_STATUS_DESCRIPTION', 0, 1, 'bottom', '#jform_published', 2, 3, '', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(13, 2, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_POSITION_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_POSITION_DESCRIPTION', 0, 1, 'top', '#jform_position', 2, 3, '', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(14, 2, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_TARGET_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_TARGET_DESCRIPTION', 0, 1, 'top', '#jform_target', 2, 3, '', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(15, 2, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_TYPE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_TYPE_DESCRIPTION', 0, 1, 'top', '#jform_type', 2, 3, '', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(16, 2, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_SAVECLOSE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_SAVECLOSE_DESCRIPTION', 0, 1, 'bottom', '#save-group-children-save .button-save', 2, 1, '', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(17, 2, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_CONGRATULATIONS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_GUIDEDTOURSTEPS_STEP_CONGRATULATIONS_DESCRIPTION', 0, 1, 'bottom', '', 0, 1, '', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),

(18, 3, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_NEW_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_NEW_DESCRIPTION', 0, 1, 'bottom', '.button-new', 2, 1, 'administrator/index.php?option=com_content&view=articles', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(19, 3, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_TITLE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_TITLE_DESCRIPTION', 0, 1, 'bottom', '#jform_title', 2, 2, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(20, 3, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_ALIAS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_ALIAS_DESCRIPTION', 0, 1, 'bottom', '#jform_alias', 0, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(21, 3, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_CONTENT_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_CONTENT_DESCRIPTION', 0, 1, 'bottom', '.tox-edit-area__iframe', 1, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(22, 3, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_STATUS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_STATUS_DESCRIPTION', 0, 1, 'bottom', '#jform_state', 0, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(23, 3, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_CATEGORY_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_CATEGORY_DESCRIPTION', 0, 1, 'bottom', 'joomla-field-fancy-select:has(#jform_catid)', 0, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(24, 3, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_FEATURED_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_FEATURED_DESCRIPTION', 0, 1, 'bottom', '#jform_featured0', 0, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(25, 3, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_ACCESS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_ACCESS_DESCRIPTION', 0, 1, 'bottom', '#jform_access', 0, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(26, 3, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_TAGS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_TAGS_DESCRIPTION', 0, 1, 'bottom', 'joomla-field-fancy-select:has(#jform_tags)', 0, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(27, 3, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_NOTE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_NOTE_DESCRIPTION', 0, 1, 'top', '#jform_note', 0, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(28, 3, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_VERSIONNOTE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_VERSIONNOTE_DESCRIPTION', 0, 1, 'top', '#jform_version_note', 0, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(29, 3, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_SAVECLOSE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_SAVECLOSE_DESCRIPTION', 0, 1, 'bottom', '#save-group-children-save .button-save', 2, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(30, 3, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_CONGRATULATIONS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_ARTICLES_STEP_CONGRATULATIONS_DESCRIPTION', 0, 1, 'bottom', '', 0, 1, 'administrator/index.php?option=com_content&view=article&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),

(31, 4, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_NEW_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_NEW_DESCRIPTION', 0, 1, 'bottom', '.button-new', 2, 1, 'administrator/index.php?option=com_categories&view=categories&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(32, 4, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_TITLE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_TITLE_DESCRIPTION', 0, 1, 'bottom', '#jform_title', 2, 2, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(33, 4, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_ALIAS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_ALIAS_DESCRIPTION', 0, 1, 'bottom', '#jform_alias', 0, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(34, 4, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_CONTENT_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_CONTENT_DESCRIPTION', 0, 1, 'bottom', '.tox-edit-area__iframe', 0, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(35, 4, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_PARENT_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_PARENT_DESCRIPTION', 0, 1, 'bottom', 'joomla-field-fancy-select:has(#jform_parent_id)', 0, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(36, 4, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_STATUS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_STATUS_DESCRIPTION', 0, 1, 'bottom', '#jform_published', 0, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(37, 4, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_ACCESS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_ACCESS_DESCRIPTION', 0, 1, 'bottom', '#jform_access', 0, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(38, 4, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_TAGS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_TAGS_DESCRIPTION', 0, 1, 'bottom', 'joomla-field-fancy-select:has(#jform_tags)', 0, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(39, 4, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_NOTE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_NOTE_DESCRIPTION', 0, 1, 'top', '#jform_note', 0, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(40, 4, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_VERSIONNOTE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_VERSIONNOTE_DESCRIPTION', 0, 1, 'top', '#jform_version_note', 0, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(41, 4, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_SAVECLOSE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_SAVECLOSE_DESCRIPTION', 0, 1, 'bottom', '#save-group-children-save .button-save', 2, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(42, 4, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_CONGRATULATIONS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CATEGORIES_STEP_CONGRATULATIONS_DESCRIPTION', 0, 1, 'bottom', '', 0, 1, 'administrator/index.php?option=com_categories&view=category&layout=edit&extension=com_content', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),

(43, 5, 'COM_GUIDEDTOURS_TOUR_MENUS_STEP_NEW_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_MENUS_STEP_NEW_DESCRIPTION', 0, 1, 'bottom', '.button-new', 2, 1, 'administrator/index.php?option=com_menus&view=menus', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(44, 5, 'COM_GUIDEDTOURS_TOUR_MENUS_STEP_TITLE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_MENUS_STEP_TITLE_DESCRIPTION', 0, 1, 'bottom', '#jform_title', 2, 2, 'administrator/index.php?option=com_menus&view=menu&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(45, 5, 'COM_GUIDEDTOURS_TOUR_MENUS_STEP_UNIQUENAME_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_MENUS_STEP_UNIQUENAME_DESCRIPTION', 0, 1, 'top', '#jform_menutype', 2, 2, 'administrator/index.php?option=com_menus&view=menu&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(46, 5, 'COM_GUIDEDTOURS_TOUR_MENUS_STEP_DESCRIPTION_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_MENUS_STEP_DESCRIPTION_DESCRIPTION', 0, 1, 'top', '#jform_menudescription', 0, 1, 'administrator/index.php?option=com_menus&view=menu&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(47, 5, 'COM_GUIDEDTOURS_TOUR_MENUS_STEP_SAVECLOSE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_MENUS_STEP_SAVECLOSE_DESCRIPTION', 0, 1, 'bottom', '#save-group-children-save .button-save', 2, 1, 'administrator/index.php?option=com_menus&view=menu&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(48, 5, 'COM_GUIDEDTOURS_TOUR_MENUS_STEP_CONGRATULATIONS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_MENUS_STEP_CONGRATULATIONS_DESCRIPTION', 0, 1, 'bottom', '', 0, 1, 'administrator/index.php?option=com_menus&view=menu&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),

(49, 6, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_NEW_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_NEW_DESCRIPTION', 0, 1, 'bottom', '.button-new', 2, 1, 'administrator/index.php?option=com_tags&view=tags', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(50, 6, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_TITLE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_TITLE_DESCRIPTION', 0, 1, 'bottom', '#jform_title', 2, 2, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(51, 6, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_ALIAS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_ALIAS_DESCRIPTION', 0, 1, 'bottom', '#jform_alias', 0, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(52, 6, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_CONTENT_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_CONTENT_DESCRIPTION', 0, 1, 'bottom', '.tox-edit-area__iframe', 1, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(53, 6, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_PARENT_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_PARENT_DESCRIPTION', 0, 1, 'bottom', 'joomla-field-fancy-select:has(#jform_parent_id)', 0, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(54, 6, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_STATUS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_STATUS_DESCRIPTION', 0, 1, 'bottom', '#jform_published', 0, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(55, 6, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_ACCESS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_ACCESS_DESCRIPTION', 0, 1, 'bottom', '#jform_access', 0, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(56, 6, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_NOTE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_NOTE_DESCRIPTION', 0, 1, 'top', '#jform_note', 0, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(57, 6, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_VERSIONNOTE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_VERSIONNOTE_DESCRIPTION', 0, 1, 'top', '#jform_version_note', 0, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(58, 6, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_SAVECLOSE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_SAVECLOSE_DESCRIPTION', 0, 1, 'bottom', '#save-group-children-save .button-save', 2, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(59, 6, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_CONGRATULATIONS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_TAGS_STEP_CONGRATULATIONS_DESCRIPTION', 0, 1, 'bottom', '', 0, 1, 'administrator/index.php?option=com_tags&view=tag&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),

(60, 7, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_NEW_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_NEW_DESCRIPTION', 0, 1, 'bottom', '.button-new', 2, 1, 'administrator/index.php?option=com_banners&view=banners', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(61, 7, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_TITLE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_TITLE_DESCRIPTION', 0, 1, 'bottom', '#jform_name', 2, 2, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(62, 7, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_ALIAS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_ALIAS_DESCRIPTION', 0, 1, 'bottom', '#jform_alias', 0, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(63, 7, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_DESCRIPTION_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_DESCRIPTION_DESCRIPTION', 0, 1, 'bottom', '.tox-edit-area__iframe', 0, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(64, 7, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_STATUS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_STATUS_DESCRIPTION', 0, 1, 'bottom', '#jform_state', 0, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(65, 7, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_CATEGORY_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_CATEGORY_DESCRIPTION', 0, 1, 'bottom', 'joomla-field-fancy-select:has(#jform_catid)', 0, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(66, 7, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_PINNED_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_PINNED_DESCRIPTION', 0, 1, 'bottom', '#jform_sticky1', 0, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(67, 7, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_VERSIONNOTE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_VERSIONNOTE_DESCRIPTION', 0, 1, 'top', '#jform_version_note', 0, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(68, 7, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_SAVECLOSE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_SAVECLOSE_DESCRIPTION', 0, 1, 'bottom', '#save-group-children-save .button-save', 2, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(69, 7, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_CONGRATULATIONS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_BANNERS_STEP_CONGRATULATIONS_DESCRIPTION', 0, 1, 'bottom', '', 0, 1, 'administrator/index.php?option=com_banners&view=banner&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),

(70, 8, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_NEW_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_NEW_DESCRIPTION', 0, 1, 'bottom', '.button-new', 2, 1, 'administrator/index.php?option=com_contact&view=contacts', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(71, 8, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_TITLE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_TITLE_DESCRIPTION', 0, 1, 'bottom', '#jform_name', 2, 2, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(72, 8, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_ALIAS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_ALIAS_DESCRIPTION', 0, 1, 'bottom', '#jform_alias', 0, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(73, 8, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_DETAILS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_DETAILS_DESCRIPTION', 0, 1, 'bottom', '.col-lg-9', 0, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(74, 8, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_STATUS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_STATUS_DESCRIPTION', 0, 1, 'bottom', '#jform_published', 0, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(75, 8, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_CATEGORY_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_CATEGORY_DESCRIPTION', 0, 1, 'bottom', 'joomla-field-fancy-select:has(#jform_catid)', 0, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(76, 8, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_FEATURED_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_FEATURED_DESCRIPTION', 0, 1, 'bottom', '#jform_featured0', 0, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(77, 8, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_ACCESS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_ACCESS_DESCRIPTION', 0, 1, 'bottom', '#jform_access', 0, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(78, 8, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_TAGS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_TAGS_DESCRIPTION', 0, 1, 'bottom', 'joomla-field-fancy-select:has(#jform_tags)', 0, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(79, 8, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_VERSIONNOTE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_VERSIONNOTE_DESCRIPTION', 0, 1, 'top', '#jform_version_note', 0, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(80, 8, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_SAVECLOSE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_SAVECLOSE_DESCRIPTION', 0, 1, 'bottom', '#save-group-children-save .button-save', 2, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(81, 8, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_CONGRATULATIONS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_CONTACTS_STEP_CONGRATULATIONS_DESCRIPTION', 0, 1, 'bottom', '', 0, 1, 'administrator/index.php?option=com_contact&view=contact&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),

(82, 9, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_NEW_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_NEW_DESCRIPTION', 0, 1, 'bottom', '.button-new', 2, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeeds', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(83, 9, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_TITLE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_TITLE_DESCRIPTION', 0, 1, 'bottom', '#jform_name', 2, 2, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(84, 9, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_ALIAS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_ALIAS_DESCRIPTION', 0, 1, 'bottom', '#jform_alias', 0, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(85, 9, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_LINK_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_LINK_DESCRIPTION', 0, 1, 'bottom', '#jform_link', 2, 2, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(86, 9, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_DESCRIPTION_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_DESCRIPTION_DESCRIPTION', 0, 1, 'bottom', '.tox-edit-area__iframe', 0, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(87, 9, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_STATUS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_STATUS_DESCRIPTION', 0, 1, 'bottom', '#jform_state', 0, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(88, 9, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_CATEGORY_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_CATEGORY_DESCRIPTION', 0, 1, 'bottom', 'joomla-field-fancy-select:has(#jform_catid)', 0, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(89, 9, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_ACCESS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_ACCESS_DESCRIPTION', 0, 1, 'bottom', '#jform_access', 0, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(90, 9, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_TAGS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_TAGS_DESCRIPTION', 0, 1, 'bottom', 'joomla-field-fancy-select:has(#jform_tags)', 0, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(91, 9, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_VERSIONNOTE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_VERSIONNOTE_DESCRIPTION', 0, 1, 'top', '#jform_version_note', 0, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(92, 9, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_SAVECLOSE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_SAVECLOSE_DESCRIPTION', 0, 1, 'bottom', '#save-group-children-save .button-save', 2, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(93, 9, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_CONGRATULATIONS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_NEWSFEEDS_STEP_CONGRATULATIONS_DESCRIPTION', 0, 1, 'bottom', '', 0, 1, 'administrator/index.php?option=com_newsfeeds&view=newsfeed&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),

(94, 10, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_STEP_NEW_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_STEP_NEW_DESCRIPTION', 0, 1, 'bottom', '.button-new', 2, 1, 'administrator/index.php?option=com_finder&view=filters', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(95, 10, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_STEP_TITLE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_STEP_TITLE_DESCRIPTION', 0, 1, 'bottom', '#jform_title', 2, 2, 'administrator/index.php?option=com_finder&view=filter&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(96, 10, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_STEP_ALIAS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_STEP_ALIAS_DESCRIPTION', 0, 1, 'bottom', '#jform_alias', 0, 1, 'administrator/index.php?option=com_finder&view=filter&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(97, 10, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_STEP_CONTENT_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_STEP_CONTENT_DESCRIPTION', 0, 1, 'bottom', '.col-lg-9', 0, 1, 'administrator/index.php?option=com_finder&view=filter&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(98, 10, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_STEP_STATUS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_STEP_STATUS_DESCRIPTION', 0, 1, 'bottom', '#jform_state', 0, 1, 'administrator/index.php?option=com_finder&view=filter&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(99, 10, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_STEP_SAVECLOSE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_STEP_SAVECLOSE_DESCRIPTION', 0, 1, 'bottom', '#save-group-children-save .button-save', 2, 1, 'administrator/index.php?option=com_finder&view=filter&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(100, 10, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_STEP_CONGRATULATIONS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_SMARTSEARCH_STEP_CONGRATULATIONS_DESCRIPTION', 0, 1, 'bottom', '', 0, 1, 'administrator/index.php?option=com_finder&view=filter&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),

(101, 11, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_NEW_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_NEW_DESCRIPTION', 0, 1, 'bottom', '.button-new', 2, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(102, 11, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_NAME_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_NAME_DESCRIPTION', 0, 1, 'bottom', '#jform_name', 2, 2, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(103, 11, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_LOGINNAME_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_LOGINNAME_DESCRIPTION', 0, 1, 'bottom', '#jform_username', 2, 2, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(104, 11, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_PASSWORD_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_PASSWORD_DESCRIPTION', 0, 1, 'bottom', '#jform_password', 2, 2, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(105, 11, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_PASSWORD2_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_PASSWORD2_DESCRIPTION', 0, 1, 'bottom', '#jform_password2', 2, 2, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(106, 11, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_EMAIL_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_EMAIL_DESCRIPTION', 0, 1, 'bottom', '#jform_email', 2, 2, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(107, 11, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_SYSTEMEMAIL_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_SYSTEMEMAIL_DESCRIPTION', 0, 1, 'top', '#jform_sendEmail', 0, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(108, 11, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_STATUS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_STATUS_DESCRIPTION', 0, 1, 'top', '#jform_block', 0, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(109, 11, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_PASSWORDRESET_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_PASSWORDRESET_DESCRIPTION', 0, 1, 'top', '#jform_requireReset', 0, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(110, 11, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_SAVECLOSE_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_SAVECLOSE_DESCRIPTION', 0, 1, 'bottom', '#save-group-children-save .button-save', 2, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*'),
(111, 11, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_CONGRATULATIONS_TITLE', 1, 'COM_GUIDEDTOURS_TOUR_USERS_STEP_CONGRATULATIONS_DESCRIPTION', 0, 1, 'bottom', '', 0, 1, 'administrator/index.php?option=com_users&view=user&layout=edit', CURRENT_TIMESTAMP(), 0, CURRENT_TIMESTAMP(), 0, '*');

-- Add new `#__extensions`
INSERT INTO `#__extensions` (`package_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `locked`, `manifest_cache`, `params`, `custom_data`, `ordering`, `state`) VALUES
(0, 'com_guidedtours', 'component', 'com_guidedtours', '', 1, 1, 0, 0, 1, '', '{}', '', 0, 0),
(0, 'mod_guidedtours', 'module', 'mod_guidedtours', '', 1, 1, 1, 0, 1, '', '{}', '', 0, 0),
(0, 'plg_system_tour', 'plugin', 'tour', 'system', 0, 1, 1, 0, 1, '', '{}', '', 0, 0);
