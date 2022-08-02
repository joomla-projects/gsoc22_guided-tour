--
-- Table structure for table `#__guidedtours`
--

CREATE TABLE IF NOT EXISTS "#__guidedtours"
(
  "id" int NOT NULL AUTO_INCREMENT,
  "asset_id" int DEFAULT 0,
  "title" varchar(255) NOT NULL,
  "description" text NOT NULL,
  "ordering" int NOT NULL DEFAULT 0,
  "extensions" text NOT NULL,
  "url" varchar(255) NOT NULL,
  "overlay" tinyint NOT NULL  DEFAULT 0,
  "created" datetime NOT NULL,
  "created_by" int NOT NULL DEFAULT 0,
  "modified" datetime NOT NULL,
  "modified_by" int NOT NULL DEFAULT 0,
  "checked_out_time" datetime NOT NULL,
  "checked_out" int NOT NULL DEFAULT 0,
  "published" tinyint NOT NULL DEFAULT 0,
  "state" tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY ("id")
);

CREATE INDEX "#__guidedtours_idx_asset_id" ON "#__guidedtours" ("asset_id");
CREATE INDEX "#__guidedtours_idx_title" ON "#__guidedtours" ("title"(191));
CREATE INDEX "#__guidedtours_idx_created" ON "#__guidedtours" ("created");
CREATE INDEX "#__guidedtours_idx_created_by" ON "#__guidedtours" ("created_by");
CREATE INDEX "#__guidedtours_idx_modified" ON "#__guidedtours" ("modified");
CREATE INDEX "#__guidedtours_idx_modified_by" ON "#__guidedtours" ("modified_by");
CREATE INDEX "#__guidedtours_idx_checked_out" ON "#__guidedtours" ("checked_out");

--
-- Dumping data for table `#__guidedtours`
--

INSERT INTO "#__guidedtours" ("id", "asset_id", "title", "description", "ordering", "extensions", "url", "overlay", "created", "created_by", "modified", "modified_by", "checked_out_time", "checked_out", "published") VALUES
(1, 91, 'How to create a Guided Tour in Joomla Backend?', '<p>This Tour will show you that how you can create Guided Tour in Joomla Backend!</p>', 0, '[\"com_guidedtours\"]', 'administrator/index.php?option=com_guidedtours&view=tours', 1, '', 0, '', 0, '', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `#__guidedtour_steps`
--

CREATE TABLE IF NOT EXISTS "#__guidedtour_steps"
(
  "id" int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  "tour_id" int NOT NULL DEFAULT 0,
  "title" varchar(255) NOT NULL,
  "published" tinyint NOT NULL DEFAULT 0,
  "description" text NOT NULL,
  "ordering" int NOT NULL DEFAULT 0,
  "step-no" int NOT NULL DEFAULT 0,
  "position" varchar(255) NOT NULL,
  "target" varchar(255) NOT NULL,
  "url" varchar(255) NOT NULL,
  "created" datetime NOT NULL,
  "created_by" int unsigned NOT NULL DEFAULT 0,
  "modified" datetime NOT NULL,
  "modified_by" int unsigned NOT NULL DEFAULT 0,
  "state" tinyint NOT NULL DEFAULT '1'
);
CREATE INDEX "#__guidedtours_idx_tour_id" ON "#__guidedtour_steps" ("tour_id");

--
-- Dumping data for table `#__guidedtour_steps`
--

INSERT INTO "#__guidedtour_steps" ("id", "tour_id", "title", "published", "description", "ordering", "step-no", "position", "target", "url", "created", "created_by", "modified", "modified_by") VALUES
(1, 1, 'Click here!', 1, '<p>This Tour will show you how you can create a Guided Tour in the Joomla! Backend</p>', 0, 1, 'bottom', '.button-new','administrator/index.php?option=com_guidedtours&view=tours' ,'', 430, '', 430),
(2, 1, 'Add title for your Tour', 1, '<p>Here you have to add the title of your Tour Step. </p>', 0, 1, 'bottom', '#jform_title', 'administrator/index.php?option=com_guidedtours&view=tour&layout=edit','', 430, '', 430),
(3, 1, 'Add Content', 1, '<p>Add the content of your Tour here!</p>', 0, 1, 'bottom', '#details','administrator/index.php?option=com_guidedtours&view=tour&layout=edit' ,'', 430, '', 430),
(4, 1, 'Plugin selector', 1, '<p>Select the extensions where you want to show your Tour. e.g If you are creating a tour which is only in \'Users\' extensions then select Users here.</p>', 0, 1, 'bottom', '.choices__inner', 'administrator/index.php?option=com_guidedtours&view=tour&layout=edit','', 430, '', 430),
(5, 1, 'URL', 1, '<p>Add Relative URL of the page from where you want to start your Tour. </p>', 0, 1, 'bottom', '#jform_url', 'administrator/index.php?option=com_guidedtours&view=tour&layout=edit','', 430, '', 430),
(6, 1, 'Overlay', 1, '<p>Select if you want an overlay effect or not.</p>', 0, 1, 'bottom', '#jform_overlay1','administrator/index.php?option=com_guidedtours&view=tour&layout=edit' ,'', 430, '', 430),
(7, 1, 'Save and Close', 1, '<p>Save and close the tour</p>', 0, 1, 'bottom', '#save-group-children-save','administrator/index.php?option=com_guidedtours&view=tour&layout=edit' ,'', 430, '', 430),
(8, 1, 'Create steps for your Tour', 1, '<p>Click on steps icon in the right</p>', 0, 1, 'right', '.btn-info','administrator/index.php?option=com_guidedtours&view=tours' ,'', 430, '', 430),
(9, 1, 'Click here!', 1, '<p>Click here to create a new Step for your Tour</p>', 0, 1, 'bottom', '.button-new', 'administrator/index.php?option=com_guidedtours&view=steps&tour_id=1','', 430, '', 430),
(10, 1, 'Add title for your Tour.', 1, '<p>Here you have to add the title of your Tour Step. </p>', 0, 1, 'bottom', '#jform_title','administrator/index.php?option=com_guidedtours&view=step&layout=edit' ,'', 430, '', 430),
(11, 1, 'Add Content', 1, '<p>Add the content of your Tour here!</p>', 0, 1, 'bottom', '#details', 'administrator/index.php?option=com_guidedtours&view=step&layout=edit','', 430, '', 430),
(12, 1, 'Position ', 1, '<p>Add the position of the Step you want. e.g. Right, Left, Top, Bottom.</p>', 0, 1, 'bottom', '#jform_position','administrator/index.php?option=com_guidedtours&view=step&layout=edit' ,'', 430, '', 430),
(13, 1, 'Target', 1, '<p>Add the ID name or Class name of the element where you want to attach your Tour.</p>', 0, 1, 'bottom', '#jform_target', 'administrator/index.php?option=com_guidedtours&view=step&layout=edit','', 430, '', 430),
(14, 1, 'Multi-page URL', 1, '<p>Add Relative URL of the page from where next step starts</p>', 0, 1, 'bottom', '#jform_url','administrator/index.php?option=com_guidedtours&view=step&layout=edit' ,'', 430, '', 430),
(15, 1, 'Save and Close', 1, '<p>Save and close the step</p>', 0, 1, 'bottom', '#save-group-children-save', 'administrator/index.php?option=com_guidedtours&view=step&layout=edit','', 430, '', 430),
(16, 1, 'Congratulations!!!', 1, '<p>You successfully created your first Guided Tour!</p>', 0, 1, 'bottom', '', 'administrator/index.php?option=com_guidedtours&view=step&layout=edit','', 430, '', 430);

-- Add `com_guidedtours` to `#__extensions`
INSERT INTO "#__extensions" ("package_
id", "name", "type", "element", "folder", "client_id", "enabled", "access", "protected", "locked", "manifest_cache", "params", "custom_data") VALUES
(0, 'com_guidedtours', 'component', 'com_guidedtours', '', 1, 1, 1, 0, 1, '', '', '');

-- Add `plg_system_tour` to `#__extensions`
INSERT INTO "#__extensions" ("package_id", "name", "type", "element", "folder", "client_id", "enabled", "access", "protected", "locked", "manifest_cache", "params", "custom_data", "ordering", "state") VALUES
(0, 'plg_system_tour', 'plugin', 'Guided Tours Plugin', 'system', 0, 1, 1, 0, 0, '', '{}', '', 15, 0);
