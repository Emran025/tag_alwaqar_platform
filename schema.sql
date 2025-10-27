-- Al-Waqar Educational Platform Database Schema
-- Version 1.0
-- Author: Jules, Senior System Architect
-- Target DBMS: MySQL 8.0+

-- This script is designed to be idempotent. It first drops tables if they exist
-- to ensure a clean slate before creating them.

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =================================================================
-- 1. CORE USER AND INSTITUTIONAL TABLES
-- =================================================================

-- Table: users
-- Purpose: Stores login credentials and basic information for all users.
-- Role determines user type and permissions.
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `full_name` VARCHAR(150) NOT NULL COMMENT 'Full name of the user',
  `email` VARCHAR(100) NOT NULL UNIQUE COMMENT 'Unique email for login',
  `password_hash` VARCHAR(255) NOT NULL COMMENT 'Hashed password for security',
  `phone_number` VARCHAR(20) NOT NULL UNIQUE COMMENT 'Unique phone number for contact and verification',
  `role` ENUM('admin', 'school_manager', 'teacher', 'guardian') NOT NULL COMMENT 'User role in the system',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_email` (`email`),
  INDEX `idx_phone_number` (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Central table for all system users';

-- Table: schools
-- Purpose: Stores information about registered educational institutions.
DROP TABLE IF EXISTS `schools`;
CREATE TABLE `schools` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(200) NOT NULL COMMENT 'Official name of the school',
  `governorate` VARCHAR(100) NOT NULL COMMENT 'Region or governorate',
  `district` VARCHAR(100) NOT NULL COMMENT 'District or sector',
  `street_address` VARCHAR(255) NOT NULL COMMENT 'Street name and building number',
  `postal_code` VARCHAR(10) DEFAULT NULL COMMENT 'Optional postal code',
  `status` ENUM('pending_approval', 'active', 'inactive', 'rejected') NOT NULL DEFAULT 'pending_approval',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_name` (`name`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Represents educational institutions';

-- Table: school_managers
-- Purpose: Links users to the schools they manage.
DROP TABLE IF EXISTS `school_managers`;
CREATE TABLE `school_managers` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT UNSIGNED NOT NULL UNIQUE COMMENT 'Foreign key to the users table',
  `school_id` INT UNSIGNED NOT NULL UNIQUE COMMENT 'Foreign key to the schools table',
  `national_id` VARCHAR(20) NOT NULL UNIQUE COMMENT 'National ID or residence number',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Represents the official managers of schools';

-- Table: teachers
-- Purpose: Stores detailed information about the teachers.
DROP TABLE IF EXISTS `teachers`;
CREATE TABLE `teachers` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT UNSIGNED NOT NULL UNIQUE COMMENT 'Foreign key to the users table',
  `national_id` VARCHAR(20) NOT NULL UNIQUE COMMENT 'National ID or residence number',
  `date_of_birth` DATE NOT NULL COMMENT 'Teacher''s date of birth',
  `nationality` VARCHAR(100) NOT NULL,
  `highest_qualification` VARCHAR(150) NOT NULL COMMENT 'Highest academic degree or certificate',
  `specialization` VARCHAR(150) NOT NULL COMMENT 'Main field of study or expertise',
  `years_of_experience` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `previous_schools` TEXT DEFAULT NULL COMMENT 'A brief history of previous employment',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores professional and personal data for teachers';

-- Table: guardians
-- Purpose: Stores information about the parents or legal guardians of students.
DROP TABLE IF EXISTS `guardians`;
CREATE TABLE `guardians` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT UNSIGNED NOT NULL UNIQUE COMMENT 'Foreign key to the users table',
  `relationship_to_student` VARCHAR(50) NOT NULL COMMENT 'e.g., Father, Mother, Guardian',
  `address` VARCHAR(255) NOT NULL COMMENT 'Current residence address',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Represents parents or legal guardians of students';

-- Table: students
-- Purpose: Stores information about the students.
DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `full_name` VARCHAR(150) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `nationality` VARCHAR(100) NOT NULL,
  `gender` ENUM('male', 'female') NOT NULL,
  `grade` VARCHAR(50) NOT NULL COMMENT 'Current or desired grade level',
  `school_id` INT UNSIGNED DEFAULT NULL COMMENT 'Foreign key to schools, can be null until assigned',
  `guardian_id` INT UNSIGNED NOT NULL COMMENT 'Foreign key to guardians',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (`guardian_id`) REFERENCES `guardians` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Represents students enrolled in the platform';

-- =================================================================
-- 2. CONTENT-RELATED TABLES
-- =================================================================

-- Table: categories
-- Purpose: Stores blog post categories for organization.
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL UNIQUE,
  `slug` VARCHAR(120) NOT NULL UNIQUE COMMENT 'URL-friendly version of the name',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Categories for blog posts';

-- Table: posts
-- Purpose: Stores blog articles and content.
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(275) NOT NULL UNIQUE COMMENT 'URL-friendly version of the title',
  `content` TEXT NOT NULL,
  `author_id` INT UNSIGNED NOT NULL COMMENT 'Foreign key to the users table',
  `published_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Timestamp when the post is made public',
  `status` ENUM('draft', 'published', 'archived') NOT NULL DEFAULT 'draft',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  INDEX `idx_status` (`status`),
  INDEX `idx_published_at` (`published_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Blog posts and articles';

-- =================================================================
-- 3. JUNCTION (PIVOT) AND SUPPORTING TABLES
-- =================================================================

-- Table: post_categories
-- Purpose: Junction table for the many-to-many relationship between posts and categories.
DROP TABLE IF EXISTS `post_categories`;
CREATE TABLE `post_categories` (
  `post_id` INT UNSIGNED NOT NULL,
  `category_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`post_id`, `category_id`),
  FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Links posts to their categories';

-- Table: school_teachers
-- Purpose: Junction table for the many-to-many relationship between schools and teachers.
DROP TABLE IF EXISTS `school_teachers`;
CREATE TABLE `school_teachers` (
  `school_id` INT UNSIGNED NOT NULL,
  `teacher_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`school_id`, `teacher_id`),
  FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Links teachers to the schools they work at';

-- Table: documents
-- Purpose: Polymorphic table to store information about uploaded files.
DROP TABLE IF EXISTS `documents`;
CREATE TABLE `documents` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `documentable_id` INT UNSIGNED NOT NULL COMMENT 'The ID of the owner model',
  `documentable_type` VARCHAR(50) NOT NULL COMMENT 'The class name of the owner model (e.g., School, Student)',
  `document_type` VARCHAR(100) NOT NULL COMMENT 'Type of the document (e.g., license, cv)',
  `file_path` VARCHAR(255) NOT NULL COMMENT 'Path to the file on the storage system',
  `file_name` VARCHAR(200) NOT NULL COMMENT 'Original name of the file',
  `file_size` INT UNSIGNED NOT NULL COMMENT 'File size in bytes',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_documentable` (`documentable_id`, `documentable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores metadata for all uploaded documents';

-- Table: contact_submissions
-- Purpose: Stores messages submitted via the contact-us form.
DROP TABLE IF EXISTS `contact_submissions`;
CREATE TABLE `contact_submissions` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `full_name` VARCHAR(150) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `subject` VARCHAR(200) NOT NULL,
  `message` TEXT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Submissions from the contact-us form';

-- Table: contributions
-- Purpose: Tracks donations and financial support.
DROP TABLE IF EXISTS `contributions`;
CREATE TABLE `contributions` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `full_name` VARCHAR(150) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `amount` DECIMAL(10, 2) NOT NULL,
  `transaction_id` VARCHAR(100) UNIQUE DEFAULT NULL COMMENT 'ID from payment gateway',
  `status` ENUM('pending', 'completed', 'failed') NOT NULL DEFAULT 'pending',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tracks financial contributions to the platform';

-- Table: achievements
-- Purpose: Stores platform or school achievements.
DROP TABLE IF EXISTS `achievements`;
CREATE TABLE `achievements` (
  `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `date` DATE NOT NULL,
  `image_url` VARCHAR(255) DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Records platform or school achievements';


SET FOREIGN_KEY_CHECKS = 1;
