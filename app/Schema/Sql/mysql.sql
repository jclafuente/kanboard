
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `action_has_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_has_params` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `action_id` (`action_id`),
  CONSTRAINT `action_has_params_ibfk_1` FOREIGN KEY (`action_id`) REFERENCES `actions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `event_name` varchar(50) NOT NULL,
  `action_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `actions_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `columns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `columns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `position` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `task_limit` int(11) DEFAULT '0',
  `description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_title_project` (`title`,`project_id`),
  KEY `columns_project_idx` (`project_id`),
  CONSTRAINT `columns_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT '0',
  `date_creation` bigint(20) DEFAULT NULL,
  `comment` text,
  `reference` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `comments_reference_idx` (`reference`),
  KEY `comments_task_idx` (`task_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencies` (
  `currency` char(3) NOT NULL,
  `rate` float DEFAULT '0',
  UNIQUE KEY `currency` (`currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `custom_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_filters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filter` varchar(100) NOT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `is_shared` tinyint(1) DEFAULT '0',
  `append` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `custom_filters_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `custom_filters_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `is_image` tinyint(1) DEFAULT '0',
  `task_id` int(11) NOT NULL,
  `date` bigint(20) DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `size` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `files_task_idx` (`task_id`),
  CONSTRAINT `files_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `group_has_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_has_users` (
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  UNIQUE KEY `group_id` (`group_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `group_has_users_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `group_has_users_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `external_id` varchar(255) DEFAULT '',
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `last_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `last_logins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auth_type` varchar(25) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `date_creation` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `last_logins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `opposite_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `label` (`label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `password_reset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset` (
  `token` varchar(80) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_expiration` int(11) NOT NULL,
  `date_creation` int(11) NOT NULL,
  `ip` varchar(45) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`token`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `password_reset_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `plugin_schema_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_schema_versions` (
  `plugin` varchar(80) NOT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`plugin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `project_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_activities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_creation` bigint(20) DEFAULT NULL,
  `event_name` varchar(50) NOT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `task_id` int(11) DEFAULT NULL,
  `data` text,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `project_id` (`project_id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `project_activities_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_activities_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_activities_ibfk_3` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `project_daily_column_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_daily_column_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` char(10) NOT NULL,
  `project_id` int(11) NOT NULL,
  `column_id` int(11) NOT NULL,
  `total` int(11) NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_daily_column_stats_idx` (`day`,`project_id`,`column_id`),
  KEY `column_id` (`column_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_daily_column_stats_ibfk_1` FOREIGN KEY (`column_id`) REFERENCES `columns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_daily_column_stats_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `project_daily_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_daily_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` char(10) NOT NULL,
  `project_id` int(11) NOT NULL,
  `avg_lead_time` int(11) NOT NULL DEFAULT '0',
  `avg_cycle_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_daily_stats_idx` (`day`,`project_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_daily_stats_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `project_has_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_has_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `project_id` int(11) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_project_category` (`project_id`,`name`),
  KEY `categories_project_idx` (`project_id`),
  CONSTRAINT `project_has_categories_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `project_has_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_has_groups` (
  `group_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `role` varchar(25) NOT NULL,
  UNIQUE KEY `group_id` (`group_id`,`project_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_has_groups_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_has_groups_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `project_has_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_has_metadata` (
  `project_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `value` varchar(255) DEFAULT '',
  UNIQUE KEY `project_id` (`project_id`,`name`),
  CONSTRAINT `project_has_metadata_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `project_has_notification_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_has_notification_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `notification_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`,`notification_type`),
  CONSTRAINT `project_has_notification_types_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `project_has_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_has_users` (
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` varchar(25) NOT NULL DEFAULT 'project-viewer',
  UNIQUE KEY `idx_project_user` (`project_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `project_has_users_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_has_users_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `token` varchar(255) DEFAULT NULL,
  `last_modified` bigint(20) DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT '0',
  `is_private` tinyint(1) DEFAULT '0',
  `is_everybody_allowed` tinyint(1) DEFAULT '0',
  `default_swimlane` varchar(200) DEFAULT 'Default swimlane',
  `show_default_swimlane` int(11) DEFAULT '1',
  `description` text,
  `identifier` varchar(50) DEFAULT '',
  `start_date` varchar(10) DEFAULT '',
  `end_date` varchar(10) DEFAULT '',
  `owner_id` int(11) DEFAULT '0',
  `priority_default` int(11) DEFAULT '0',
  `priority_start` int(11) DEFAULT '0',
  `priority_end` int(11) DEFAULT '3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `remember_me`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remember_me` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `sequence` varchar(255) DEFAULT NULL,
  `expiration` int(11) DEFAULT NULL,
  `date_creation` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `remember_me_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `schema_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_version` (
  `version` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `option` varchar(100) NOT NULL,
  `value` varchar(255) DEFAULT '',
  PRIMARY KEY (`option`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `subtask_time_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subtask_time_tracking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `subtask_id` int(11) NOT NULL,
  `start` bigint(20) DEFAULT NULL,
  `end` bigint(20) DEFAULT NULL,
  `time_spent` float DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `subtask_id` (`subtask_id`),
  CONSTRAINT `subtask_time_tracking_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subtask_time_tracking_ibfk_2` FOREIGN KEY (`subtask_id`) REFERENCES `subtasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `subtasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subtasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `status` int(11) DEFAULT '0',
  `time_estimated` float DEFAULT NULL,
  `time_spent` float DEFAULT NULL,
  `task_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `subtasks_task_idx` (`task_id`),
  CONSTRAINT `subtasks_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `swimlanes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `swimlanes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `position` int(11) DEFAULT '1',
  `is_active` int(11) DEFAULT '1',
  `project_id` int(11) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`project_id`),
  KEY `swimlanes_project_idx` (`project_id`),
  CONSTRAINT `swimlanes_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `task_has_external_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_has_external_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link_type` varchar(100) NOT NULL,
  `dependency` varchar(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `date_creation` int(11) NOT NULL,
  `date_modification` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `creator_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `task_has_external_links_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `task_has_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_has_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `opposite_task_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_has_links_unique` (`link_id`,`task_id`,`opposite_task_id`),
  KEY `opposite_task_id` (`opposite_task_id`),
  KEY `task_has_links_task_index` (`task_id`),
  CONSTRAINT `task_has_links_ibfk_1` FOREIGN KEY (`link_id`) REFERENCES `links` (`id`) ON DELETE CASCADE,
  CONSTRAINT `task_has_links_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `task_has_links_ibfk_3` FOREIGN KEY (`opposite_task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `task_has_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_has_metadata` (
  `task_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `value` varchar(255) DEFAULT '',
  UNIQUE KEY `task_id` (`task_id`,`name`),
  CONSTRAINT `task_has_metadata_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `date_creation` bigint(20) DEFAULT NULL,
  `date_completed` bigint(20) DEFAULT NULL,
  `date_due` bigint(20) DEFAULT NULL,
  `color_id` varchar(50) DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `column_id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT '0',
  `position` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `category_id` int(11) DEFAULT '0',
  `creator_id` int(11) DEFAULT '0',
  `date_modification` int(11) DEFAULT '0',
  `reference` varchar(50) DEFAULT '',
  `date_started` bigint(20) DEFAULT NULL,
  `time_spent` float DEFAULT '0',
  `time_estimated` float DEFAULT '0',
  `swimlane_id` int(11) DEFAULT '0',
  `date_moved` bigint(20) DEFAULT NULL,
  `recurrence_status` int(11) NOT NULL DEFAULT '0',
  `recurrence_trigger` int(11) NOT NULL DEFAULT '0',
  `recurrence_factor` int(11) NOT NULL DEFAULT '0',
  `recurrence_timeframe` int(11) NOT NULL DEFAULT '0',
  `recurrence_basedate` int(11) NOT NULL DEFAULT '0',
  `recurrence_parent` int(11) DEFAULT NULL,
  `recurrence_child` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_task_active` (`is_active`),
  KEY `column_id` (`column_id`),
  KEY `tasks_reference_idx` (`reference`),
  KEY `tasks_project_idx` (`project_id`),
  CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`column_id`) REFERENCES `columns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `transitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `src_column_id` int(11) NOT NULL,
  `dst_column_id` int(11) NOT NULL,
  `date` bigint(20) DEFAULT NULL,
  `time_spent` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `src_column_id` (`src_column_id`),
  KEY `dst_column_id` (`dst_column_id`),
  KEY `transitions_task_index` (`task_id`),
  KEY `transitions_project_index` (`project_id`),
  KEY `transitions_user_index` (`user_id`),
  CONSTRAINT `transitions_ibfk_1` FOREIGN KEY (`src_column_id`) REFERENCES `columns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transitions_ibfk_2` FOREIGN KEY (`dst_column_id`) REFERENCES `columns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transitions_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transitions_ibfk_4` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transitions_ibfk_5` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_has_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_metadata` (
  `user_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `value` varchar(255) DEFAULT '',
  UNIQUE KEY `user_id` (`user_id`,`name`),
  CONSTRAINT `user_has_metadata_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_has_notification_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_notification_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `notification_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_has_notification_types_user_idx` (`user_id`,`notification_type`),
  CONSTRAINT `user_has_notification_types_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_has_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_notifications` (
  `user_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  UNIQUE KEY `project_id` (`project_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_has_notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_has_notifications_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_has_unread_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_unread_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `date_creation` bigint(20) NOT NULL,
  `event_name` varchar(50) NOT NULL,
  `event_data` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_has_unread_notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `is_ldap_user` tinyint(1) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `google_id` varchar(30) DEFAULT NULL,
  `github_id` varchar(30) DEFAULT NULL,
  `notifications_enabled` tinyint(1) DEFAULT '0',
  `timezone` varchar(50) DEFAULT NULL,
  `language` varchar(5) DEFAULT NULL,
  `disable_login_form` tinyint(1) DEFAULT '0',
  `twofactor_activated` tinyint(1) DEFAULT '0',
  `twofactor_secret` char(16) DEFAULT NULL,
  `token` varchar(255) DEFAULT '',
  `notifications_filter` int(11) DEFAULT '4',
  `nb_failed_login` int(11) DEFAULT '0',
  `lock_expiration_date` bigint(20) DEFAULT NULL,
  `gitlab_id` int(11) DEFAULT NULL,
  `role` varchar(25) NOT NULL DEFAULT 'app-user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_idx` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES ('api_token','dcae89653bfd780f56a5c2ffabc54174bcdd877940e97eaa5d800b35df0c'),('application_currency','USD'),('application_date_format','m/d/Y'),('application_language','en_US'),('application_stylesheet',''),('application_timezone','UTC'),('application_url',''),('board_columns',''),('board_highlight_period','172800'),('board_private_refresh_interval','10'),('board_public_refresh_interval','60'),('calendar_project_tasks','date_started'),('calendar_user_subtasks_time_tracking','0'),('calendar_user_tasks','date_started'),('cfd_include_closed_tasks','1'),('default_color','yellow'),('integration_gravatar','0'),('password_reset','1'),('project_categories',''),('subtask_restriction','0'),('subtask_time_tracking','1'),('webhook_token','6c0a16d06e31add3ca1ca8713a69c6b410f72c80fd49cdfe27c4a62eef13'),('webhook_url','');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

LOCK TABLES `links` WRITE;
/*!40000 ALTER TABLE `links` DISABLE KEYS */;
INSERT INTO `links` VALUES (1,'relates to',0),(2,'blocks',3),(3,'is blocked by',2),(4,'duplicates',5),(5,'is duplicated by',4),(6,'is a child of',7),(7,'is a parent of',6),(8,'targets milestone',9),(9,'is a milestone of',8),(10,'fixes',11),(11,'is fixed by',10);
/*!40000 ALTER TABLE `links` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

INSERT INTO users (username, password, role) VALUES ('admin', '$2y$10$f6brAPgJ6iTtOWUMJANDuuRG.VWDH61.aCb5v3MJnSrZodhDaCcmy', 'app-admin');INSERT INTO schema_version VALUES ('104');
