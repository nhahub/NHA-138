-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table lms.ai_conversations
CREATE TABLE IF NOT EXISTS `ai_conversations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `conversation_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'general',
  `user_message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ai_response` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `context` json DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ai_conversations_user_id_created_at_index` (`user_id`,`created_at`),
  KEY `ai_conversations_conversation_type_index` (`conversation_type`),
  CONSTRAINT `ai_conversations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.ai_conversations: ~0 rows (approximately)

-- Dumping structure for table lms.cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.cache: ~1 rows (approximately)

-- Dumping structure for table lms.cache_locks
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.cache_locks: ~0 rows (approximately)

-- Dumping structure for table lms.chat_messages
CREATE TABLE IF NOT EXISTS `chat_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `session_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_announcement` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chat_messages_session_id_foreign` (`session_id`),
  KEY `chat_messages_user_id_foreign` (`user_id`),
  CONSTRAINT `chat_messages_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `live_sessions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chat_messages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.chat_messages: ~0 rows (approximately)

-- Dumping structure for table lms.companies
CREATE TABLE IF NOT EXISTS `companies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `industry` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_size` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `logo_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_picture` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `founded_year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `benefits` json DEFAULT NULL,
  `linkedin_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registration_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companies_user_id_foreign` (`user_id`),
  KEY `companies_is_verified_index` (`is_verified`),
  KEY `companies_industry_index` (`industry`),
  CONSTRAINT `companies_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.companies: ~8 rows (approximately)
INSERT INTO `companies` (`id`, `user_id`, `company_name`, `industry`, `company_size`, `website`, `description`, `logo_path`, `profile_picture`, `location`, `founded_year`, `benefits`, `linkedin_url`, `registration_number`, `is_verified`, `created_at`, `updated_at`) VALUES
	(1, 1, 'شركة التقنية المتقدمة', 'تكنولوجيا المعلومات', '51-200', 'https://tech-advanced.com', 'شركة رائدة في مجال تطوير البرمجيات والحلول التقنية المبتكرة. نعمل على مشاريع في الذكاء الاصطناعي، تطوير التطبيقات، والحلول السحابية.', NULL, NULL, 'القاهرة، مصر', NULL, NULL, NULL, NULL, 1, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(2, 2, 'مجموعة النيل للاستثمار', 'الخدمات المالية', '201-500', 'https://nile-investment.com', 'مجموعة استثمارية رائدة في مجال الخدمات المالية والاستثمار. نقدم خدمات إدارة الأصول، الاستشارات المالية، والتحليل الاقتصادي.', NULL, NULL, 'الجيزة، مصر', NULL, NULL, NULL, NULL, 1, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(3, 3, 'إبداع للتسويق الرقمي', 'التسويق والإعلان', '11-50', 'https://ebdaa-marketing.com', 'وكالة تسويق رقمي متخصصة في إدارة حملات السوشيال ميديا، تحسين محركات البحث، والتسويق بالمحتوى.', NULL, NULL, 'القاهرة الجديدة، مصر', NULL, NULL, NULL, NULL, 1, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(4, 4, 'فاركو للصناعات الدوائية', 'الصناعات الدوائية', '500+', 'https://pharco.com', 'شركة رائدة في صناعة وتوزيع الأدوية والمستحضرات الطبية. نعمل على البحث والتطوير في مجال الصناعات الدوائية.', NULL, NULL, 'الإسكندرية، مصر', NULL, NULL, NULL, NULL, 1, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(5, 5, 'تصاميم الحداثة للاستشارات الهندسية', 'الهندسة والاستشارات', '51-200', 'https://modern-designs.com', 'مكتب استشارات هندسية متخصص في التصميم المعماري، الإنشائي، والميكانيكي للمشاريع السكنية والتجارية.', NULL, NULL, 'القاهرة، مصر', NULL, NULL, NULL, NULL, 1, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(6, 6, 'الأهرام للإعلام والنشر', 'الإعلام والنشر', '201-500', 'https://ahram.com', 'مؤسسة إعلامية رائدة في مجال الصحافة والنشر الرقمي. نبحث عن كتاب ومحررين موهوبين للانضمام لفريقنا.', NULL, NULL, 'القاهرة، مصر', NULL, NULL, NULL, NULL, 1, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(7, 7, 'إيجيبت تورز للسياحة', 'السياحة والضيافة', '11-50', 'https://egypt-tours.com', 'شركة سياحة متخصصة في تنظيم الرحلات السياحية والبرامج الثقافية. نبحث عن مرشدين سياحيين محترفين.', NULL, NULL, 'الأقصر، مصر', NULL, NULL, NULL, NULL, 0, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(8, 8, 'القانونية للاستشارات والمحاماة', 'الخدمات القانونية', '11-50', 'https://legal-consultants.com', 'مكتب محاماة واستشارات قانونية متخصص في قانون الشركات، الملكية الفكرية، والقضايا التجارية.', NULL, NULL, 'القاهرة، مصر', NULL, NULL, NULL, NULL, 1, '2025-11-29 13:39:47', '2025-11-29 13:39:47');

-- Dumping structure for table lms.courses
CREATE TABLE IF NOT EXISTS `courses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `teacher_id` bigint unsigned NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `original_price` decimal(8,2) DEFAULT NULL,
  `duration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lessons_count` int NOT NULL DEFAULT '0',
  `students_count` int NOT NULL DEFAULT '0',
  `rating` decimal(2,1) NOT NULL DEFAULT '0.0',
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `grade` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `course_type` enum('recorded','live') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'recorded',
  `max_seats` int DEFAULT NULL,
  `enrolled_seats` int NOT NULL DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `sessions_per_week` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `status` enum('published','draft','archived') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'published',
  `stream_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stream_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stream_provider` enum('agora','jitsi','daily','custom') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'agora',
  `recording_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_teacher_id_foreign` (`teacher_id`),
  CONSTRAINT `courses_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.courses: ~38 rows (approximately)
INSERT INTO `courses` (`id`, `title`, `description`, `teacher_id`, `price`, `original_price`, `duration`, `lessons_count`, `students_count`, `rating`, `thumbnail`, `category`, `grade`, `course_type`, `max_seats`, `enrolled_seats`, `start_date`, `end_date`, `sessions_per_week`, `is_active`, `status`, `stream_url`, `stream_key`, `stream_provider`, `recording_enabled`, `created_at`, `updated_at`) VALUES
	(1, 'الرياضيات - الصف الأول الإعدادي', 'كورس شامل في الرياضيات يغطي جميع دروس المنهج بشرح مبسط وتدريبات متنوعة', 9, 216.00, 319.00, '24 ساعة', 52, 158, 4.7, NULL, 'math', 'prep_1', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(2, 'العلوم - الصف الأول الإعدادي', 'شرح مفصل لمنهج العلوم مع التجارب العملية والأنشطة التفاعلية', 10, 168.00, 397.00, '22 ساعة', 59, 202, 4.9, NULL, 'science', 'prep_1', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(3, 'اللغة العربية - الصف الأول الإعدادي', 'دروس شاملة في النحو والصرف والبلاغة والنصوص والقراءة', 11, 174.00, 326.00, '16 ساعة', 33, 240, 4.6, NULL, 'arabic', 'prep_1', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(4, 'اللغة الإنجليزية - الصف الأول الإعدادي', 'تطوير مهارات اللغة الإنجليزية في القراءة والكتابة والمحادثة والاستماع', 9, 206.00, 384.00, '30 ساعة', 46, 234, 4.2, NULL, 'english', 'prep_1', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(5, 'الدراسات الاجتماعية - الصف الأول الإعدادي', 'رحلة شيقة في التاريخ والجغرافيا مع الخرائط والوسائل التوضيحية', 10, 147.00, 388.00, '27 ساعة', 54, 193, 4.7, NULL, 'social', 'prep_1', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(6, 'الرياضيات - الصف الثاني الإعدادي', 'كورس شامل في الرياضيات يغطي جميع دروس المنهج بشرح مبسط وتدريبات متنوعة', 9, 208.00, 282.00, '18 ساعة', 50, 74, 4.9, NULL, 'math', 'prep_2', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(7, 'العلوم - الصف الثاني الإعدادي', 'شرح مفصل لمنهج العلوم مع التجارب العملية والأنشطة التفاعلية', 10, 115.00, 349.00, '24 ساعة', 47, 98, 4.0, NULL, 'science', 'prep_2', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(8, 'اللغة العربية - الصف الثاني الإعدادي', 'دروس شاملة في النحو والصرف والبلاغة والنصوص والقراءة', 11, 176.00, 253.00, '27 ساعة', 45, 164, 4.1, NULL, 'arabic', 'prep_2', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(9, 'اللغة الإنجليزية - الصف الثاني الإعدادي', 'تطوير مهارات اللغة الإنجليزية في القراءة والكتابة والمحادثة والاستماع', 9, 187.00, 264.00, '19 ساعة', 48, 134, 4.0, NULL, 'english', 'prep_2', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(10, 'الدراسات الاجتماعية - الصف الثاني الإعدادي', 'رحلة شيقة في التاريخ والجغرافيا مع الخرائط والوسائل التوضيحية', 10, 245.00, 346.00, '20 ساعة', 46, 128, 4.4, NULL, 'social', 'prep_2', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(11, 'الرياضيات - الصف الثالث الإعدادي', 'كورس شامل في الرياضيات يغطي جميع دروس المنهج بشرح مبسط وتدريبات متنوعة', 9, 214.00, 278.00, '27 ساعة', 38, 236, 4.2, NULL, 'math', 'prep_3', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(12, 'العلوم - الصف الثالث الإعدادي', 'شرح مفصل لمنهج العلوم مع التجارب العملية والأنشطة التفاعلية', 10, 115.00, 361.00, '15 ساعة', 31, 50, 4.2, NULL, 'science', 'prep_3', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(13, 'اللغة العربية - الصف الثالث الإعدادي', 'دروس شاملة في النحو والصرف والبلاغة والنصوص والقراءة', 11, 143.00, 301.00, '16 ساعة', 59, 288, 5.0, NULL, 'arabic', 'prep_3', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(14, 'اللغة الإنجليزية - الصف الثالث الإعدادي', 'تطوير مهارات اللغة الإنجليزية في القراءة والكتابة والمحادثة والاستماع', 9, 227.00, 348.00, '16 ساعة', 55, 106, 4.3, NULL, 'english', 'prep_3', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(15, 'الدراسات الاجتماعية - الصف الثالث الإعدادي', 'رحلة شيقة في التاريخ والجغرافيا مع الخرائط والوسائل التوضيحية', 10, 120.00, 282.00, '29 ساعة', 60, 279, 4.7, NULL, 'social', 'prep_3', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(16, 'الرياضيات - الصف الأول الثانوي', 'كورس شامل في الرياضيات يغطي جميع دروس المنهج بشرح مبسط وتدريبات متنوعة', 9, 224.00, 283.00, '28 ساعة', 46, 208, 4.5, NULL, 'math', 'secondary_1', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(17, 'العلوم - الصف الأول الثانوي', 'شرح مفصل لمنهج العلوم مع التجارب العملية والأنشطة التفاعلية', 10, 200.00, 321.00, '23 ساعة', 32, 288, 4.4, NULL, 'science', 'secondary_1', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(18, 'اللغة العربية - الصف الأول الثانوي', 'دروس شاملة في النحو والصرف والبلاغة والنصوص والقراءة', 11, 199.00, 352.00, '27 ساعة', 42, 206, 4.6, NULL, 'arabic', 'secondary_1', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(19, 'اللغة الإنجليزية - الصف الأول الثانوي', 'تطوير مهارات اللغة الإنجليزية في القراءة والكتابة والمحادثة والاستماع', 9, 247.00, 359.00, '26 ساعة', 49, 185, 5.0, NULL, 'english', 'secondary_1', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(20, 'الدراسات الاجتماعية - الصف الأول الثانوي', 'رحلة شيقة في التاريخ والجغرافيا مع الخرائط والوسائل التوضيحية', 10, 133.00, 303.00, '25 ساعة', 36, 144, 4.1, NULL, 'social', 'secondary_1', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(21, 'الرياضيات - الصف الثاني الثانوي', 'كورس شامل في الرياضيات يغطي جميع دروس المنهج بشرح مبسط وتدريبات متنوعة', 9, 187.00, 359.00, '27 ساعة', 32, 214, 4.4, NULL, 'math', 'secondary_2', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(22, 'العلوم - الصف الثاني الثانوي', 'شرح مفصل لمنهج العلوم مع التجارب العملية والأنشطة التفاعلية', 10, 139.00, 326.00, '16 ساعة', 33, 126, 4.6, NULL, 'science', 'secondary_2', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(23, 'اللغة العربية - الصف الثاني الثانوي', 'دروس شاملة في النحو والصرف والبلاغة والنصوص والقراءة', 11, 119.00, 270.00, '28 ساعة', 34, 221, 4.2, NULL, 'arabic', 'secondary_2', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(24, 'اللغة الإنجليزية - الصف الثاني الثانوي', 'تطوير مهارات اللغة الإنجليزية في القراءة والكتابة والمحادثة والاستماع', 9, 191.00, 358.00, '26 ساعة', 43, 151, 4.1, NULL, 'english', 'secondary_2', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(25, 'الدراسات الاجتماعية - الصف الثاني الثانوي', 'رحلة شيقة في التاريخ والجغرافيا مع الخرائط والوسائل التوضيحية', 10, 102.00, 273.00, '29 ساعة', 42, 159, 4.5, NULL, 'social', 'secondary_2', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(26, 'الرياضيات - الصف الثالث الثانوي', 'كورس شامل في الرياضيات يغطي جميع دروس المنهج بشرح مبسط وتدريبات متنوعة', 9, 176.00, 297.00, '25 ساعة', 46, 84, 4.4, NULL, 'math', 'secondary_3', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(27, 'العلوم - الصف الثالث الثانوي', 'شرح مفصل لمنهج العلوم مع التجارب العملية والأنشطة التفاعلية', 10, 107.00, 252.00, '26 ساعة', 43, 237, 5.0, NULL, 'science', 'secondary_3', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(28, 'اللغة العربية - الصف الثالث الثانوي', 'دروس شاملة في النحو والصرف والبلاغة والنصوص والقراءة', 11, 218.00, 339.00, '15 ساعة', 37, 230, 4.0, NULL, 'arabic', 'secondary_3', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(29, 'اللغة الإنجليزية - الصف الثالث الثانوي', 'تطوير مهارات اللغة الإنجليزية في القراءة والكتابة والمحادثة والاستماع', 9, 197.00, 334.00, '15 ساعة', 44, 179, 4.9, NULL, 'english', 'secondary_3', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(30, 'الدراسات الاجتماعية - الصف الثالث الثانوي', 'رحلة شيقة في التاريخ والجغرافيا مع الخرائط والوسائل التوضيحية', 10, 222.00, 345.00, '25 ساعة', 42, 261, 4.7, NULL, 'social', 'secondary_3', 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(31, 'أساسيات البرمجة بلغة Python', 'تعلم البرمجة من الصفر باستخدام لغة Python مع تطبيقات عملية', 18, 199.00, 299.00, '12 ساعة', 38, 176, 4.6, NULL, 'programming', NULL, 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(32, 'تطوير تطبيقات الويب باستخدام React', 'احترف بناء واجهات المستخدم التفاعلية باستخدام React.js', 18, 249.00, 349.00, '17 ساعة', 25, 185, 4.6, NULL, 'programming', NULL, 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(33, 'التسويق الرقمي المتقدم', 'استراتيجيات التسويق الرقمي وإدارة الحملات الإعلانية', 9, 179.00, 279.00, '10 ساعة', 39, 339, 4.4, NULL, 'marketing', NULL, 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(34, 'تحليل البيانات باستخدام Excel و PowerBI', 'احترف تحليل البيانات وإنشاء التقارير التفاعلية', 10, 199.00, 299.00, '14 ساعة', 30, 238, 4.6, NULL, 'data', NULL, 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(35, 'أساسيات تصميم UI/UX', 'تعلم مبادئ تصميم واجهات المستخدم وتجربة المستخدم', 18, 229.00, 329.00, '17 ساعة', 25, 103, 4.7, NULL, 'design', NULL, 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(36, 'مهارات التواصل الفعال والعرض التقديمي', 'طور مهاراتك في التواصل والعرض التقديمي للنجاح المهني', 11, 149.00, 199.00, '11 ساعة', 34, 288, 4.6, NULL, 'soft_skills', NULL, 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(37, 'إدارة المشاريع Agile و Scrum', 'احترف إدارة المشاريع بمنهجيات Agile و Scrum', 9, 189.00, 289.00, '17 ساعة', 28, 210, 4.8, NULL, 'business', NULL, 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(38, 'اللغة الإنجليزية للأعمال', 'طور مهاراتك في اللغة الإنجليزية للتواصل المهني', 10, 159.00, 259.00, '18 ساعة', 25, 466, 4.8, NULL, 'languages', NULL, 'recorded', NULL, 0, NULL, NULL, NULL, 1, 'published', NULL, NULL, 'agora', 1, '2025-11-29 13:39:58', '2025-11-29 13:39:58');

-- Dumping structure for table lms.course_enrollments
CREATE TABLE IF NOT EXISTS `course_enrollments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `student_id` bigint unsigned NOT NULL,
  `course_id` bigint unsigned NOT NULL,
  `price_paid` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` enum('active','completed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `enrolled_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `progress` decimal(5,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_enrollments_student_id_course_id_unique` (`student_id`,`course_id`),
  KEY `course_enrollments_course_id_status_index` (`course_id`,`status`),
  CONSTRAINT `course_enrollments_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_enrollments_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.course_enrollments: ~0 rows (approximately)

-- Dumping structure for table lms.course_lessons
CREATE TABLE IF NOT EXISTS `course_lessons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `video_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_type` enum('youtube','vimeo','upload','embed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'youtube',
  `video_file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_index` int NOT NULL DEFAULT '0',
  `is_preview` tinyint(1) NOT NULL DEFAULT '0',
  `attachments` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_lessons_course_id_order_index_index` (`course_id`,`order_index`),
  CONSTRAINT `course_lessons_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.course_lessons: ~0 rows (approximately)

-- Dumping structure for table lms.course_sessions
CREATE TABLE IF NOT EXISTS `course_sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint unsigned NOT NULL,
  `day_of_week` enum('saturday','sunday','monday','tuesday','wednesday','thursday','friday') COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `duration_minutes` int GENERATED ALWAYS AS (timestampdiff(MINUTE,`start_time`,`end_time`)) VIRTUAL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_sessions_course_id_day_of_week_unique` (`course_id`,`day_of_week`),
  CONSTRAINT `course_sessions_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.course_sessions: ~0 rows (approximately)

-- Dumping structure for table lms.didit_verifications
CREATE TABLE IF NOT EXISTS `didit_verifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `session_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_number` int NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vendor_data` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `personal_info` json DEFAULT NULL,
  `checks` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `didit_verifications_session_id_unique` (`session_id`),
  KEY `didit_verifications_session_id_index` (`session_id`),
  KEY `didit_verifications_user_id_index` (`user_id`),
  CONSTRAINT `didit_verifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.didit_verifications: ~0 rows (approximately)

-- Dumping structure for table lms.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table lms.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.jobs: ~0 rows (approximately)

-- Dumping structure for table lms.job_applications
CREATE TABLE IF NOT EXISTS `job_applications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `job_posting_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `cover_letter` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `status_history` json DEFAULT NULL,
  `company_notes` text COLLATE utf8mb4_unicode_ci,
  `viewed_at` datetime DEFAULT NULL,
  `interview_date` datetime DEFAULT NULL,
  `interview_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interview_notes` text COLLATE utf8mb4_unicode_ci,
  `is_favorite` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_applications_job_posting_id_student_id_unique` (`job_posting_id`,`student_id`),
  KEY `job_applications_student_id_status_index` (`student_id`,`status`),
  KEY `job_applications_job_posting_id_status_index` (`job_posting_id`,`status`),
  CONSTRAINT `job_applications_job_posting_id_foreign` FOREIGN KEY (`job_posting_id`) REFERENCES `job_postings` (`id`) ON DELETE CASCADE,
  CONSTRAINT `job_applications_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.job_applications: ~18 rows (approximately)
INSERT INTO `job_applications` (`id`, `job_posting_id`, `student_id`, `cover_letter`, `status`, `status_history`, `company_notes`, `viewed_at`, `interview_date`, `interview_location`, `interview_notes`, `is_favorite`, `created_at`, `updated_at`) VALUES
	(1, 1, 36, 'أنا مهتمة جداً بفرصة التدريب في تطوير تطبيقات الموبايل. لدي خبرة في React وأعمل على تطوير مشاريع شخصية باستخدام React Native. معرض أعمالي يتضمن مشروع تجارة إلكترونية وتطبيق دردشة ذكي باستخدام الذكاء الاصطناعي.', 'pending', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-27 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"}]"', NULL, NULL, NULL, NULL, NULL, 0, '2025-11-27 13:39:56', '2025-11-27 13:39:56'),
	(2, 4, 36, 'على الرغم من تخصصي في هندسة الحاسبات، أمتلك مهارات قوية في تحليل البيانات وأتقن Excel وPython. أرغب في تطبيق مهاراتي التقنية في مجال التحليل المالي.', 'reviewing', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-24 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"},{\\"status\\":\\"reviewing\\",\\"changed_at\\":\\"2025-11-26 15:39:56\\",\\"note\\":\\"\\\\u0628\\\\u062f\\\\u0623\\\\u062a \\\\u0627\\\\u0644\\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0631\\\\u0627\\\\u062c\\\\u0639\\\\u0629 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628\\"}]"', 'خلفية تقنية قوية، سنراجع مدى ملاءمتها للدور المالي.', '2025-11-26 15:39:56', NULL, NULL, NULL, 0, '2025-11-24 13:39:56', '2025-11-26 13:39:56'),
	(3, 2, 36, 'أنا طالبة هندسة حاسبات متحمسة للعمل كمطور Full Stack. أتقن React و Node.js ولدي خبرة عملية في بناء تطبيقات ويب متكاملة. عملت كفريلانسر لمدة 6 أشهر وطورت عدة مشاريع.', 'shortlisted', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-19 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"},{\\"status\\":\\"reviewing\\",\\"changed_at\\":\\"2025-11-21 15:39:56\\",\\"note\\":\\"\\\\u0628\\\\u062f\\\\u0623\\\\u062a \\\\u0627\\\\u0644\\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0631\\\\u0627\\\\u062c\\\\u0639\\\\u0629 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628\\"},{\\"status\\":\\"shortlisted\\",\\"changed_at\\":\\"2025-11-22 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u0627\\\\u062e\\\\u062a\\\\u064a\\\\u0627\\\\u0631\\\\u0643 \\\\u0636\\\\u0645\\\\u0646 \\\\u0627\\\\u0644\\\\u0642\\\\u0627\\\\u0626\\\\u0645\\\\u0629 \\\\u0627\\\\u0644\\\\u0645\\\\u062e\\\\u062a\\\\u0635\\\\u0631\\\\u0629 \\\\u0644\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629\\"}]"', 'مرشحة قوية! خلفية ممتازة في React و Node.js. تم ترشيحها للمقابلة الفنية.', '2025-11-21 15:39:56', NULL, NULL, NULL, 1, '2025-11-19 13:39:56', '2025-11-22 13:39:56'),
	(4, 6, 36, 'أمتلك مهارات تواصل قوية وخبرة في إدارة المحتوى الرقمي. على الرغم من خلفيتي التقنية، أرغب في دمج مهاراتي البرمجية مع التسويق الرقمي.', 'interviewed', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-14 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"},{\\"status\\":\\"reviewing\\",\\"changed_at\\":\\"2025-11-17 15:39:56\\",\\"note\\":\\"\\\\u0628\\\\u062f\\\\u0623\\\\u062a \\\\u0627\\\\u0644\\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0631\\\\u0627\\\\u062c\\\\u0639\\\\u0629 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628\\"},{\\"status\\":\\"shortlisted\\",\\"changed_at\\":\\"2025-11-21 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u0627\\\\u062e\\\\u062a\\\\u064a\\\\u0627\\\\u0631\\\\u0643 \\\\u0636\\\\u0645\\\\u0646 \\\\u0627\\\\u0644\\\\u0642\\\\u0627\\\\u0626\\\\u0645\\\\u0629 \\\\u0627\\\\u0644\\\\u0645\\\\u062e\\\\u062a\\\\u0635\\\\u0631\\\\u0629 \\\\u0644\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629\\"},{\\"status\\":\\"interviewed\\",\\"changed_at\\":\\"2025-11-26 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645\\\\u062a \\\\u0627\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d - \\\\u0641\\\\u064a \\\\u0627\\\\u0646\\\\u062a\\\\u0638\\\\u0627\\\\u0631 \\\\u0627\\\\u0644\\\\u0642\\\\u0631\\\\u0627\\\\u0631 \\\\u0627\\\\u0644\\\\u0646\\\\u0647\\\\u0627\\\\u0626\\\\u064a\\"}]"', 'أجرت المقابلة مع مدير التسويق. انطباع إيجابي ولكن نحتاج لمراجعة المرشحين الآخرين.', '2025-11-17 15:39:56', '2025-11-26 15:39:56', 'مكتب الشركة - القاهرة الجديدة', 'مقابلة جيدة. لديها رؤية مثيرة للاهتمام حول دمج التقنية مع التسويق. سنتخذ القرار خلال أسبوع.', 0, '2025-11-14 13:39:56', '2025-11-26 13:39:56'),
	(5, 5, 36, 'أتطلع للحصول على تدريب صيفي في التحليل الاستثماري. مهاراتي في البرمجة وتحليل البيانات ستساعدني في تحليل البيانات المالية بكفاءة. حاصلة على شهادة في Data Analysis.', 'accepted', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-10-30 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"},{\\"status\\":\\"reviewing\\",\\"changed_at\\":\\"2025-11-04 15:39:56\\",\\"note\\":\\"\\\\u0628\\\\u062f\\\\u0623\\\\u062a \\\\u0627\\\\u0644\\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0631\\\\u0627\\\\u062c\\\\u0639\\\\u0629 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628\\"},{\\"status\\":\\"shortlisted\\",\\"changed_at\\":\\"2025-11-11 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u0627\\\\u062e\\\\u062a\\\\u064a\\\\u0627\\\\u0631\\\\u0643 \\\\u0636\\\\u0645\\\\u0646 \\\\u0627\\\\u0644\\\\u0642\\\\u0627\\\\u0626\\\\u0645\\\\u0629 \\\\u0627\\\\u0644\\\\u0645\\\\u062e\\\\u062a\\\\u0635\\\\u0631\\\\u0629 \\\\u0644\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629\\"},{\\"status\\":\\"interviewed\\",\\"changed_at\\":\\"2025-11-19 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645\\\\u062a \\\\u0627\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d - \\\\u0641\\\\u064a \\\\u0627\\\\u0646\\\\u062a\\\\u0638\\\\u0627\\\\u0631 \\\\u0627\\\\u0644\\\\u0642\\\\u0631\\\\u0627\\\\u0631 \\\\u0627\\\\u0644\\\\u0646\\\\u0647\\\\u0627\\\\u0626\\\\u064a\\"},{\\"status\\":\\"accepted\\",\\"changed_at\\":\\"2025-11-21 15:39:56\\",\\"note\\":\\"\\\\u0645\\\\u0628\\\\u0631\\\\u0648\\\\u0643! \\\\u062a\\\\u0645 \\\\u0642\\\\u0628\\\\u0648\\\\u0644\\\\u0643 \\\\u0641\\\\u064a \\\\u0627\\\\u0644\\\\u0648\\\\u0638\\\\u064a\\\\u0641\\\\u0629\\"}]"', 'مقبولة! مرشحة استثنائية. مهاراتها التقنية ستضيف قيمة كبيرة لفريقنا. بدء التدريب في الصيف القادم.', '2025-11-04 15:39:56', '2025-11-19 15:39:56', 'مكتب الشركة - الجيزة', 'مقابلة ممتازة! مهارات تحليلية قوية جداً. نوصي بالقبول الفوري.', 0, '2025-10-30 12:39:56', '2025-11-21 13:39:56'),
	(6, 8, 36, 'على الرغم من أنني مهندسة حاسبات، لدي اهتمام كبير بالتصميم ودرست أساسيات Photoshop و Illustrator بنفسي. أحب الدمج بين التقنية والفن.', 'rejected', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-07 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"},{\\"status\\":\\"reviewing\\",\\"changed_at\\":\\"2025-11-09 15:39:56\\",\\"note\\":\\"\\\\u0628\\\\u062f\\\\u0623\\\\u062a \\\\u0627\\\\u0644\\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0631\\\\u0627\\\\u062c\\\\u0639\\\\u0629 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628\\"},{\\"status\\":\\"rejected\\",\\"changed_at\\":\\"2025-11-11 15:39:56\\",\\"note\\":\\"\\\\u0646\\\\u0639\\\\u062a\\\\u0630\\\\u0631\\\\u060c \\\\u062a\\\\u0645 \\\\u0627\\\\u062e\\\\u062a\\\\u064a\\\\u0627\\\\u0631 \\\\u0645\\\\u0631\\\\u0634\\\\u062d \\\\u0622\\\\u062e\\\\u0631 \\\\u0623\\\\u0643\\\\u062b\\\\u0631 \\\\u0645\\\\u0644\\\\u0627\\\\u0621\\\\u0645\\\\u0629 \\\\u0644\\\\u0644\\\\u0648\\\\u0638\\\\u064a\\\\u0641\\\\u0629\\"}]"', 'نقدر اهتمامها بالتصميم، لكن الوظيفة تتطلب خريج فنون تطبيقية مع معرض أعمال قوي. نحتاج لمزيد من الخبرة العملية في التصميم.', '2025-11-09 15:39:56', NULL, NULL, NULL, 0, '2025-11-07 13:39:56', '2025-11-11 13:39:56'),
	(7, 14, 36, 'أمتلك مهارات كتابة جيدة وأحب الصحافة التقنية. أرغب في الكتابة عن التكنولوجيا والابتكار.', 'withdrawn', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-09 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"},{\\"status\\":\\"reviewing\\",\\"changed_at\\":\\"2025-11-11 15:39:56\\",\\"note\\":\\"\\\\u0628\\\\u062f\\\\u0623\\\\u062a \\\\u0627\\\\u0644\\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0631\\\\u0627\\\\u062c\\\\u0639\\\\u0629 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628\\"},{\\"status\\":\\"withdrawn\\",\\"changed_at\\":\\"2025-11-13 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u0633\\\\u062d\\\\u0628 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0645\\\\u0646 \\\\u0642\\\\u0628\\\\u0644 \\\\u0627\\\\u0644\\\\u0637\\\\u0627\\\\u0644\\\\u0628\\"}]"', 'سحبت الطالبة طلبها. أخبرتنا أنها قبلت فرصة أخرى أكثر تماشياً مع تخصصها.', '2025-11-11 15:39:56', NULL, NULL, NULL, 0, '2025-11-09 13:39:56', '2025-11-13 13:39:56'),
	(8, 4, 37, 'كطالب متميز في قسم إدارة الأعمال بالجامعة الأمريكية، أمتلك خلفية قوية في التحليل المالي والتسويق الرقمي. حاصل على شهادات من Google و HubSpot ولدي خبرة في استخدام PowerBI و Excel.', 'accepted', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-09 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"},{\\"status\\":\\"reviewing\\",\\"changed_at\\":\\"2025-11-14 15:39:56\\",\\"note\\":\\"\\\\u0628\\\\u062f\\\\u0623\\\\u062a \\\\u0627\\\\u0644\\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0631\\\\u0627\\\\u062c\\\\u0639\\\\u0629 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628\\"},{\\"status\\":\\"shortlisted\\",\\"changed_at\\":\\"2025-11-17 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u0627\\\\u062e\\\\u062a\\\\u064a\\\\u0627\\\\u0631\\\\u0643 \\\\u0636\\\\u0645\\\\u0646 \\\\u0627\\\\u0644\\\\u0642\\\\u0627\\\\u0626\\\\u0645\\\\u0629 \\\\u0627\\\\u0644\\\\u0645\\\\u062e\\\\u062a\\\\u0635\\\\u0631\\\\u0629 \\\\u0644\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629\\"},{\\"status\\":\\"interviewed\\",\\"changed_at\\":\\"2025-11-22 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645\\\\u062a \\\\u0627\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d - \\\\u0641\\\\u064a \\\\u0627\\\\u0646\\\\u062a\\\\u0638\\\\u0627\\\\u0631 \\\\u0627\\\\u0644\\\\u0642\\\\u0631\\\\u0627\\\\u0631 \\\\u0627\\\\u0644\\\\u0646\\\\u0647\\\\u0627\\\\u0626\\\\u064a\\"},{\\"status\\":\\"accepted\\",\\"changed_at\\":\\"2025-11-24 15:39:56\\",\\"note\\":\\"\\\\u0645\\\\u0628\\\\u0631\\\\u0648\\\\u0643! \\\\u062a\\\\u0645 \\\\u0642\\\\u0628\\\\u0648\\\\u0644\\\\u0643 \\\\u0641\\\\u064a \\\\u0627\\\\u0644\\\\u0648\\\\u0638\\\\u064a\\\\u0641\\\\u0629\\"}]"', 'مقبول! خلفية أكاديمية ومهنية ممتازة. سيكون إضافة قيمة للفريق.', '2025-11-14 15:39:56', '2025-11-22 15:39:56', 'مكتب الشركة - الجيزة', 'مرشح ممتاز! معدل دراسي مرتفع وخبرة عملية قوية. يبدأ العمل الشهر القادم.', 1, '2025-11-09 13:39:56', '2025-11-24 13:39:56'),
	(9, 5, 37, 'أطمح للحصول على تدريب صيفي في التحليل الاستثماري. رئيس نادي ريادة الأعمال بالجامعة ولدي شغف كبير بالأسواق المالية.', 'shortlisted', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-17 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"},{\\"status\\":\\"reviewing\\",\\"changed_at\\":\\"2025-11-19 15:39:56\\",\\"note\\":\\"\\\\u0628\\\\u062f\\\\u0623\\\\u062a \\\\u0627\\\\u0644\\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0631\\\\u0627\\\\u062c\\\\u0639\\\\u0629 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628\\"},{\\"status\\":\\"shortlisted\\",\\"changed_at\\":\\"2025-11-20 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u0627\\\\u062e\\\\u062a\\\\u064a\\\\u0627\\\\u0631\\\\u0643 \\\\u0636\\\\u0645\\\\u0646 \\\\u0627\\\\u0644\\\\u0642\\\\u0627\\\\u0626\\\\u0645\\\\u0629 \\\\u0627\\\\u0644\\\\u0645\\\\u062e\\\\u062a\\\\u0635\\\\u0631\\\\u0629 \\\\u0644\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629\\"}]"', 'خلفية ممتازة. مرشح قوي للتدريب الصيفي.', '2025-11-19 15:39:56', NULL, NULL, NULL, 1, '2025-11-17 13:39:56', '2025-11-20 13:39:56'),
	(10, 6, 37, 'لدي خبرة قوية في التسويق الرقمي وإدارة السوشيال ميديا. حاصل على شهادة Google Digital Marketing وأدرت حملات إعلانية ناجحة.', 'reviewing', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-23 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"},{\\"status\\":\\"reviewing\\",\\"changed_at\\":\\"2025-11-25 15:39:56\\",\\"note\\":\\"\\\\u0628\\\\u062f\\\\u0623\\\\u062a \\\\u0627\\\\u0644\\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0631\\\\u0627\\\\u062c\\\\u0639\\\\u0629 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628\\"}]"', 'شهادات معتمدة وخبرة جيدة. سنراجع ونحدد موعد مقابلة.', '2025-11-25 15:39:56', NULL, NULL, NULL, 0, '2025-11-23 13:39:56', '2025-11-25 13:39:56'),
	(11, 1, 39, 'أنا مصمم UI/UX شغوف بتصميم تطبيقات الموبايل. لدي معرض أعمال على Behance يوضح مشاريعي في تصميم تطبيقات الموبايل. أعتقد أن مهاراتي في التصميم ستكون إضافة قيمة.', 'rejected', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-17 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"},{\\"status\\":\\"reviewing\\",\\"changed_at\\":\\"2025-11-19 15:39:56\\",\\"note\\":\\"\\\\u0628\\\\u062f\\\\u0623\\\\u062a \\\\u0627\\\\u0644\\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0631\\\\u0627\\\\u062c\\\\u0639\\\\u0629 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628\\"},{\\"status\\":\\"rejected\\",\\"changed_at\\":\\"2025-11-20 15:39:56\\",\\"note\\":\\"\\\\u0646\\\\u0639\\\\u062a\\\\u0630\\\\u0631\\\\u060c \\\\u062a\\\\u0645 \\\\u0627\\\\u062e\\\\u062a\\\\u064a\\\\u0627\\\\u0631 \\\\u0645\\\\u0631\\\\u0634\\\\u062d \\\\u0622\\\\u062e\\\\u0631 \\\\u0623\\\\u0643\\\\u062b\\\\u0631 \\\\u0645\\\\u0644\\\\u0627\\\\u0621\\\\u0645\\\\u0629 \\\\u0644\\\\u0644\\\\u0648\\\\u0638\\\\u064a\\\\u0641\\\\u0629\\"}]"', 'خلفية قوية في التصميم ولكن الوظيفة تتطلب خبرة برمجية أكثر. المهارات التقنية غير كافية للدور.', '2025-11-19 15:39:56', NULL, NULL, NULL, 0, '2025-11-17 13:39:56', '2025-11-20 13:39:56'),
	(12, 8, 39, 'أنا طالب تصميم جرافيكي متحمس بمهارات قوية في Photoshop و Illustrator و Figma. معرض أعمالي يتضمن مشاريع متنوعة في تصميم الهوية البصرية والسوشيال ميديا.', 'accepted', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-11 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"},{\\"status\\":\\"reviewing\\",\\"changed_at\\":\\"2025-11-14 15:39:56\\",\\"note\\":\\"\\\\u0628\\\\u062f\\\\u0623\\\\u062a \\\\u0627\\\\u0644\\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0631\\\\u0627\\\\u062c\\\\u0639\\\\u0629 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628\\"},{\\"status\\":\\"shortlisted\\",\\"changed_at\\":\\"2025-11-17 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u0627\\\\u062e\\\\u062a\\\\u064a\\\\u0627\\\\u0631\\\\u0643 \\\\u0636\\\\u0645\\\\u0646 \\\\u0627\\\\u0644\\\\u0642\\\\u0627\\\\u0626\\\\u0645\\\\u0629 \\\\u0627\\\\u0644\\\\u0645\\\\u062e\\\\u062a\\\\u0635\\\\u0631\\\\u0629 \\\\u0644\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629\\"},{\\"status\\":\\"interviewed\\",\\"changed_at\\":\\"2025-11-21 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645\\\\u062a \\\\u0627\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d - \\\\u0641\\\\u064a \\\\u0627\\\\u0646\\\\u062a\\\\u0638\\\\u0627\\\\u0631 \\\\u0627\\\\u0644\\\\u0642\\\\u0631\\\\u0627\\\\u0631 \\\\u0627\\\\u0644\\\\u0646\\\\u0647\\\\u0627\\\\u0626\\\\u064a\\"},{\\"status\\":\\"accepted\\",\\"changed_at\\":\\"2025-11-22 15:39:56\\",\\"note\\":\\"\\\\u0645\\\\u0628\\\\u0631\\\\u0648\\\\u0643! \\\\u062a\\\\u0645 \\\\u0642\\\\u0628\\\\u0648\\\\u0644\\\\u0643 \\\\u0641\\\\u064a \\\\u0627\\\\u0644\\\\u0648\\\\u0638\\\\u064a\\\\u0641\\\\u0629\\"}]"', 'مقبول! موهبة واعدة في التصميم.', '2025-11-14 15:39:56', '2025-11-21 15:39:56', 'مكتب الشركة - القاهرة الجديدة', 'معرض أعمال رائع! أسلوب تصميم عصري ومبتكر.', 1, '2025-11-11 13:39:56', '2025-11-22 13:39:56'),
	(13, 14, 40, 'أنا طالبة صحافة شغوفة بالصحافة الاستقصائية. أكتب في عدة منصات رقمية وحاصلة على جائزة أفضل تقرير صحفي. مهاراتي في البحث والكتابة وصحافة البيانات ستكون إضافة قيمة لفريقكم.', 'interviewed', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-14 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"},{\\"status\\":\\"reviewing\\",\\"changed_at\\":\\"2025-11-17 15:39:56\\",\\"note\\":\\"\\\\u0628\\\\u062f\\\\u0623\\\\u062a \\\\u0627\\\\u0644\\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0631\\\\u0627\\\\u062c\\\\u0639\\\\u0629 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628\\"},{\\"status\\":\\"shortlisted\\",\\"changed_at\\":\\"2025-11-21 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u0627\\\\u062e\\\\u062a\\\\u064a\\\\u0627\\\\u0631\\\\u0643 \\\\u0636\\\\u0645\\\\u0646 \\\\u0627\\\\u0644\\\\u0642\\\\u0627\\\\u0626\\\\u0645\\\\u0629 \\\\u0627\\\\u0644\\\\u0645\\\\u062e\\\\u062a\\\\u0635\\\\u0631\\\\u0629 \\\\u0644\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629\\"},{\\"status\\":\\"interviewed\\",\\"changed_at\\":\\"2025-11-25 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645\\\\u062a \\\\u0627\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d - \\\\u0641\\\\u064a \\\\u0627\\\\u0646\\\\u062a\\\\u0638\\\\u0627\\\\u0631 \\\\u0627\\\\u0644\\\\u0642\\\\u0631\\\\u0627\\\\u0631 \\\\u0627\\\\u0644\\\\u0646\\\\u0647\\\\u0627\\\\u0626\\\\u064a\\"}]"', 'مرشحة قوية. خلفية أكاديمية جيدة وجوائز مهمة.', '2025-11-17 15:39:56', '2025-11-25 15:39:56', 'مقر الأهرام - القاهرة', 'مقابلة جيدة جداً. موهبة واضحة في الكتابة وشغف بالصحافة. سنراجع ونرد خلال أسبوع.', 1, '2025-11-14 13:39:56', '2025-11-25 13:39:56'),
	(14, 7, 40, 'لدي خبرة واسعة في كتابة المحتوى التسويقي والصحفي. أتقن اللغتين العربية والإنجليزية وأمتلك أسلوب كتابة جذاب ومؤثر.', 'pending', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-26 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"}]"', NULL, NULL, NULL, NULL, NULL, 0, '2025-11-26 13:39:56', '2025-11-26 13:39:56'),
	(15, 17, 41, 'أنا طالب قانون متميز مع اهتمام خاص بقانون الشركات والملكية الفكرية. الفائز بمسابقة محاكاة المحاكم الوطنية وحاصل على شهادات متخصصة من WIPO.', 'shortlisted', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-19 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"},{\\"status\\":\\"reviewing\\",\\"changed_at\\":\\"2025-11-21 15:39:56\\",\\"note\\":\\"\\\\u0628\\\\u062f\\\\u0623\\\\u062a \\\\u0627\\\\u0644\\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0631\\\\u0627\\\\u062c\\\\u0639\\\\u0629 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628\\"},{\\"status\\":\\"shortlisted\\",\\"changed_at\\":\\"2025-11-22 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u0627\\\\u062e\\\\u062a\\\\u064a\\\\u0627\\\\u0631\\\\u0643 \\\\u0636\\\\u0645\\\\u0646 \\\\u0627\\\\u0644\\\\u0642\\\\u0627\\\\u0626\\\\u0645\\\\u0629 \\\\u0627\\\\u0644\\\\u0645\\\\u062e\\\\u062a\\\\u0635\\\\u0631\\\\u0629 \\\\u0644\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629\\"}]"', 'مرشح ممتاز! خلفية أكاديمية قوية وجوائز مهمة في مجال القانون.', '2025-11-21 15:39:56', NULL, NULL, NULL, 1, '2025-11-19 13:39:56', '2025-11-22 13:39:56'),
	(16, 3, 46, 'أنا طالبة علوم حاسب متخصصة في الذكاء الاصطناعي والتعلم العميق. نشرت ورقة بحثية في مؤتمر IEEE الدولي وفزت بمسابقة Kaggle. أمتلك خبرة عملية قوية في TensorFlow و PyTorch.', 'interviewed', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-14 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"},{\\"status\\":\\"reviewing\\",\\"changed_at\\":\\"2025-11-19 15:39:56\\",\\"note\\":\\"\\\\u0628\\\\u062f\\\\u0623\\\\u062a \\\\u0627\\\\u0644\\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0631\\\\u0627\\\\u062c\\\\u0639\\\\u0629 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628\\"},{\\"status\\":\\"shortlisted\\",\\"changed_at\\":\\"2025-11-22 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u0627\\\\u062e\\\\u062a\\\\u064a\\\\u0627\\\\u0631\\\\u0643 \\\\u0636\\\\u0645\\\\u0646 \\\\u0627\\\\u0644\\\\u0642\\\\u0627\\\\u0626\\\\u0645\\\\u0629 \\\\u0627\\\\u0644\\\\u0645\\\\u062e\\\\u062a\\\\u0635\\\\u0631\\\\u0629 \\\\u0644\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629\\"},{\\"status\\":\\"interviewed\\",\\"changed_at\\":\\"2025-11-26 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645\\\\u062a \\\\u0627\\\\u0644\\\\u0645\\\\u0642\\\\u0627\\\\u0628\\\\u0644\\\\u0629 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d - \\\\u0641\\\\u064a \\\\u0627\\\\u0646\\\\u062a\\\\u0638\\\\u0627\\\\u0631 \\\\u0627\\\\u0644\\\\u0642\\\\u0631\\\\u0627\\\\u0631 \\\\u0627\\\\u0644\\\\u0646\\\\u0647\\\\u0627\\\\u0626\\\\u064a\\"}]"', 'مرشحة استثنائية! خلفية بحثية قوية ومنشورات دولية. نوصي بالقبول.', '2025-11-19 15:39:56', '2025-11-26 15:39:56', 'مقابلة عن بعد - Zoom', 'مقابلة فنية ممتازة! أظهرت فهماً عميقاً للخوارزميات وحلت المشاكل البرمجية بكفاءة عالية.', 1, '2025-11-14 13:39:56', '2025-11-26 13:39:56'),
	(17, 2, 46, 'بالإضافة لتخصصي في الذكاء الاصطناعي، أمتلك مهارات قوية في تطوير الويب Full Stack. أتقن React و Node.js وطورت عدة تطبيقات ويب.', 'pending', '"[{\\"status\\":\\"pending\\",\\"changed_at\\":\\"2025-11-28 15:39:56\\",\\"note\\":\\"\\\\u062a\\\\u0645 \\\\u062a\\\\u0642\\\\u062f\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0637\\\\u0644\\\\u0628 \\\\u0628\\\\u0646\\\\u062c\\\\u0627\\\\u062d\\"}]"', NULL, NULL, NULL, NULL, NULL, 0, '2025-11-28 13:39:56', '2025-11-28 13:39:56');

-- Dumping structure for table lms.job_batches
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.job_batches: ~0 rows (approximately)

-- Dumping structure for table lms.job_postings
CREATE TABLE IF NOT EXISTS `job_postings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `requirements` json NOT NULL,
  `responsibilities` json NOT NULL,
  `skills_required` json NOT NULL,
  `skills_preferred` json DEFAULT NULL,
  `job_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `work_location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salary_range` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `experience_level` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `education_requirement` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `faculties_preferred` json DEFAULT NULL,
  `positions_available` int NOT NULL DEFAULT '1',
  `application_deadline` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `views_count` int NOT NULL DEFAULT '0',
  `applications_count` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `job_postings_company_id_foreign` (`company_id`),
  KEY `job_postings_is_active_index` (`is_active`),
  KEY `job_postings_job_type_index` (`job_type`),
  KEY `job_postings_experience_level_index` (`experience_level`),
  KEY `job_postings_created_at_index` (`created_at`),
  CONSTRAINT `job_postings_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.job_postings: ~17 rows (approximately)
INSERT INTO `job_postings` (`id`, `company_id`, `title`, `description`, `requirements`, `responsibilities`, `skills_required`, `skills_preferred`, `job_type`, `work_location`, `location`, `salary_range`, `experience_level`, `education_requirement`, `faculties_preferred`, `positions_available`, `application_deadline`, `is_active`, `views_count`, `applications_count`, `created_at`, `updated_at`) VALUES
	(1, 1, 'متدرب تطوير تطبيقات الموبايل', 'فرصة تدريب ممتازة في تطوير تطبيقات الموبايل باستخدام React Native. ستعمل مع فريق متمرس وتتعلم أفضل الممارسات في تطوير التطبيقات.', '["طالب في كلية حاسبات أو هندسة", "معرفة أساسية بـ JavaScript", "شغف بتطوير التطبيقات", "القدرة على العمل ضمن فريق"]', '["المساعدة في تطوير ميزات جديدة للتطبيقات", "التعلم من الفريق وحضور ورش العمل", "المشاركة في الاجتماعات اليومية", "كتابة تقارير عن التقدم"]', '["JavaScript", "React basics", "Problem Solving", "Git"]', '["React Native", "Mobile Development", "UI/UX", "TypeScript"]', 'internship', 'onsite', 'القاهرة الجديدة', '3,000 - 5,000 جنيه', 'entry', 'طالب جامعي في السنة الثالثة أو الرابعة', '["كلية الحاسبات والمعلومات", "كلية الهندسة - قسم حاسبات"]', 3, '2025-12-29', 1, 260, 21, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(2, 1, 'مطور Full Stack - عقد دائم', 'مطور Full Stack محترف للعمل على تطوير تطبيقات ويب معقدة باستخدام React و Node.js.', '["خبرة 2-3 سنوات في تطوير الويب", "إتقان React و Node.js", "خبرة في قواعد البيانات", "شهادة جامعية في علوم الحاسب أو ما يعادلها"]', '["تطوير وصيانة تطبيقات الويب", "التعاون مع فريق التصميم", "مراجعة الكود", "حل المشاكل التقنية"]', '["React", "Node.js", "MongoDB", "RESTful APIs", "Git"]', '["TypeScript", "Docker", "AWS", "Redis"]', 'full_time', 'hybrid', 'القاهرة', '15,000 - 25,000 جنيه', 'mid', 'بكالوريوس علوم حاسب أو هندسة', '["كلية الحاسبات والمعلومات", "كلية الهندسة"]', 2, '2026-01-13', 1, 179, 38, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(3, 1, 'مهندس ذكاء اصطناعي - Remote', 'مهندس ذكاء اصطناعي متخصص للعمل على مشاريع Machine Learning و Deep Learning مع إمكانية العمل عن بعد.', '["ماجستير أو بكالوريوس في علوم الحاسب مع خبرة قوية", "خبرة عملية في ML/DL", "منشورات بحثية تعتبر ميزة"]', '["تطوير نماذج الذكاء الاصطناعي", "تحسين الخوارزميات", "البحث والتطوير", "توثيق الكود والعمل"]', '["Python", "TensorFlow", "PyTorch", "Machine Learning", "Deep Learning"]', '["Computer Vision", "NLP", "MLOps", "Research Publications"]', 'full_time', 'remote', 'العمل عن بعد', '25,000 - 40,000 جنيه', 'senior', 'بكالوريوس علوم حاسب (ماجستير مفضل)', '["كلية الحاسبات والمعلومات", "كلية الهندسة - AI"]', 1, '2026-01-28', 1, 181, 32, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(4, 2, 'محلل مالي Junior', 'نبحث عن محلل مالي مبتدئ للانضمام لفريق التحليل المالي والاستثماري.', '["بكالوريوس تجارة أو اقتصاد", "إجادة Excel و PowerPoint", "مهارات تحليلية قوية", "إجادة اللغة الإنجليزية"]', '["إعداد التقارير المالية الدورية", "تحليل البيانات المالية", "دعم الفريق المالي", "متابعة الأسواق المالية"]', '["Excel", "Financial Analysis", "Data Analysis", "PowerPoint"]', '["PowerBI", "SQL", "Python", "Bloomberg Terminal"]', 'full_time', 'onsite', 'الجيزة', '8,000 - 12,000 جنيه', 'entry', 'بكالوريوس تجارة - قسم المحاسبة أو المالية', '["كلية التجارة", "كلية الاقتصاد والعلوم السياسية"]', 2, '2026-01-13', 1, 62, 42, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(5, 2, 'متدرب تحليل استثماري - صيفي', 'برنامج تدريب صيفي في مجال التحليل الاستثماري وإدارة المحافظ.', '["طالب في السنة الثالثة أو الرابعة", "معدل تراكمي جيد جداً", "شغف بالأسواق المالية"]', '["مساعدة فريق الاستثمار", "إعداد تقارير بحثية", "تحليل الشركات المدرجة", "حضور اجتماعات العملاء"]', '["Excel", "Financial Basics", "English", "Analytical Skills"]', '["Financial Modeling", "Valuation", "Bloomberg"]', 'internship', 'onsite', 'الجيزة', '4,000 - 6,000 جنيه', 'entry', 'طالب في كلية التجارة أو الاقتصاد', '["كلية التجارة", "كلية الاقتصاد"]', 5, '2025-12-19', 1, 220, 12, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(6, 3, 'متخصص تسويق على السوشيال ميديا', 'متخصص تسويق رقمي لإدارة حسابات السوشيال ميديا للعملاء وإنشاء محتوى إبداعي.', '["خبرة 1-2 سنة في التسويق الرقمي", "معرفة قوية بمنصات السوشيال ميديا", "مهارات كتابة محتوى ممتازة"]', '["إدارة حسابات السوشيال ميديا", "إنشاء محتوى إبداعي", "تحليل الأداء", "التفاعل مع المتابعين"]', '["Social Media Management", "Content Creation", "Copywriting", "Analytics"]', '["Photoshop", "Video Editing", "Facebook Ads", "Google Analytics"]', 'full_time', 'onsite', 'القاهرة الجديدة', '7,000 - 10,000 جنيه', 'junior', 'بكالوريوس إعلام أو تسويق', '["كلية الإعلام", "كلية التجارة", "كلية الآداب"]', 2, '2025-12-29', 1, 283, 22, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(7, 3, 'كاتب محتوى إبداعي', 'كاتب محتوى مبدع لإنشاء محتوى تسويقي باللغتين العربية والإنجليزية.', '["خبرة في كتابة المحتوى التسويقي", "إبداع في الكتابة", "إتقان العربية والإنجليزية"]', '["كتابة محتوى للمواقع والمدونات", "إنشاء نصوص إعلانية", "تحرير ومراجعة المحتوى"]', '["Content Writing", "Copywriting", "Arabic", "English"]', '["SEO", "WordPress", "Marketing Knowledge"]', 'part_time', 'remote', 'العمل عن بعد', '4,000 - 7,000 جنيه', 'entry', 'بكالوريوس إعلام أو لغات أو آداب', '["كلية الإعلام", "كلية الآداب", "كلية الألسن"]', 3, '2026-01-08', 1, 146, 37, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(8, 3, 'متدرب تصميم جرافيك', 'فرصة تدريب في التصميم الجرافيكي وتصميم المحتوى البصري للسوشيال ميديا.', '["طالب في كلية الفنون التطبيقية", "معرفة بأساسيات التصميم", "إتقان Photoshop و Illustrator"]', '["تصميم منشورات السوشيال ميديا", "المساعدة في الحملات الإعلانية", "تعديل الصور"]', '["Photoshop", "Illustrator", "Design Basics"]', '["After Effects", "Figma", "Typography"]', 'internship', 'onsite', 'القاهرة الجديدة', '2,500 - 4,000 جنيه', 'entry', 'طالب في كلية الفنون التطبيقية', '["كلية الفنون التطبيقية"]', 2, '2025-12-24', 1, 137, 33, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(9, 4, 'صيدلي في قسم مراقبة الجودة', 'صيدلي للعمل في قسم مراقبة الجودة والرقابة الدوائية.', '["بكالوريوس صيدلة", "خبرة 0-2 سنة", "معرفة بمعايير الجودة الدوائية"]', '["فحص جودة المنتجات", "إعداد تقارير الجودة", "متابعة معايير الأمان", "التفتيش على خطوط الإنتاج"]', '["Pharmaceutical Analysis", "Quality Control", "GMP", "Documentation"]', '["HPLC", "Spectroscopy", "Validation", "ISO Standards"]', 'full_time', 'onsite', 'الإسكندرية', '9,000 - 14,000 جنيه', 'entry', 'بكالوريوس صيدلة', '["كلية الصيدلة"]', 3, '2026-01-03', 1, 145, 9, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(10, 4, 'متدرب في قسم البحث والتطوير', 'برنامج تدريب في قسم البحث والتطوير للطلاب المتفوقين.', '["طالب صيدلة في السنة الرابعة أو الخامسة", "معدل ممتاز", "اهتمام بالبحث العلمي"]', '["المساعدة في الأبحاث", "إجراء التجارب المعملية", "توثيق النتائج", "حضور الاجتماعات العلمية"]', '["Pharmaceutical Research", "Lab Skills", "Documentation", "Analysis"]', '["HPLC", "Research Methods", "Scientific Writing"]', 'internship', 'onsite', 'الإسكندرية', '3,500 - 5,000 جنيه', 'entry', 'طالب صيدلة - السنة الرابعة أو الخامسة', '["كلية الصيدلة"]', 4, '2025-12-29', 1, 264, 21, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(11, 5, 'مهندس معماري مبتدئ', 'مهندس معماري للعمل على مشاريع التصميم المعماري للمباني السكنية والتجارية.', '["بكالوريوس هندسة معمارية", "خبرة 0-1 سنة", "إتقان برامج التصميم"]', '["المشاركة في التصميم المعماري", "إعداد الرسومات التنفيذية", "التنسيق مع الفرق الهندسية"]', '["AutoCAD", "Revit", "Architectural Design", "3D Modeling"]', '["3ds Max", "SketchUp", "Photoshop", "BIM"]', 'full_time', 'onsite', 'القاهرة', '8,000 - 12,000 جنيه', 'entry', 'بكالوريوس هندسة معمارية', '["كلية الهندسة - قسم العمارة"]', 2, '2026-01-08', 1, 181, 12, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(12, 5, 'مهندس ميكانيكا - أنظمة التكييف', 'مهندس ميكانيكا متخصص في تصميم أنظمة التكييف والتهوية.', '["بكالوريوس هندسة ميكانيكية", "خبرة 2-3 سنوات في HVAC", "معرفة بالمعايير الهندسية"]', '["تصميم أنظمة التكييف", "إعداد الحسابات الهندسية", "متابعة التنفيذ", "مراجعة المخططات"]', '["HVAC Design", "AutoCAD", "Load Calculations", "Technical Drawing"]', '["Revit MEP", "HAP", "Energy Simulation", "LEED"]', 'full_time', 'onsite', 'القاهرة', '12,000 - 18,000 جنيه', 'mid', 'بكالوريوس هندسة ميكانيكية', '["كلية الهندسة - قسم الميكانيكا"]', 1, '2026-01-18', 1, 68, 17, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(13, 6, 'صحفي محرر', 'صحفي للعمل في قسم التحرير وكتابة التقارير الصحفية.', '["بكالوريوس إعلام - صحافة", "خبرة 1-2 سنة", "مهارات كتابة ممتازة"]', '["كتابة التقارير والمقالات", "تحرير المحتوى", "تغطية الأحداث", "إجراء المقابلات"]', '["Journalism", "News Writing", "Editing", "Research"]', '["Investigative Journalism", "Photography", "Video Editing"]', 'full_time', 'onsite', 'القاهرة', '7,000 - 11,000 جنيه', 'junior', 'بكالوريوس إعلام - قسم الصحافة', '["كلية الإعلام"]', 2, '2025-12-29', 1, 68, 43, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(14, 6, 'محرر فيديو ومونتاج', 'محرر فيديو محترف للعمل على المحتوى المرئي والإخباري.', '["خبرة في المونتاج والإخراج", "إتقان برامج المونتاج", "القدرة على العمل تحت الضغط"]', '["مونتاج الفيديوهات الإخبارية", "إضافة المؤثرات", "تحرير المقاطع", "العمل مع الفريق الإعلامي"]', '["Video Editing", "Premiere Pro", "After Effects", "Color Grading"]', '["Motion Graphics", "Audio Editing", "Final Cut Pro"]', 'full_time', 'onsite', 'القاهرة', '8,000 - 13,000 جنيه', 'mid', 'دبلومة أو بكالوريوس في الإعلام أو ما يعادلها', '["كلية الإعلام", "كلية الفنون التطبيقية"]', 1, '2026-01-03', 1, 296, 23, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(15, 7, 'مرشد سياحي', 'مرشد سياحي لمرافقة المجموعات السياحية وتقديم المعلومات التاريخية والثقافية.', '["ترخيص إرشاد سياحي", "إجادة لغتين أجنبيتين على الأقل", "معرفة واسعة بالتاريخ المصري"]', '["مرافقة المجموعات السياحية", "شرح المعالم الأثرية", "الترجمة", "تنسيق البرامج السياحية"]', '["Tour Guiding", "History Knowledge", "English", "Communication"]', '["French", "German", "Italian", "First Aid"]', 'contract', 'onsite', 'الأقصر', '6,000 - 10,000 جنيه + عمولة', 'entry', 'بكالوريوس سياحة أو ترخيص إرشاد سياحي', '["كلية السياحة والفنادق"]', 5, '2025-12-19', 1, 228, 49, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(16, 7, 'منسق برامج سياحية', 'منسق لتخطيط وتنظيم البرامج السياحية والتنسيق مع الفنادق ووسائل النقل.', '["خبرة في تنسيق البرامج السياحية", "مهارات تنظيمية ممتازة", "إجادة اللغة الإنجليزية"]', '["تخطيط البرامج السياحية", "التنسيق مع الموردين", "متابعة الحجوزات", "حل المشاكل"]', '["Event Planning", "Coordination", "Customer Service", "English"]', '["Tourism Software", "Negotiation", "Multiple Languages"]', 'full_time', 'onsite', 'الأقصر', '7,000 - 11,000 جنيه', 'junior', 'بكالوريوس سياحة', '["كلية السياحة والفنادق"]', 2, '2025-12-29', 1, 258, 37, '2025-11-29 13:39:47', '2025-11-29 13:39:47'),
	(17, 8, 'محامي متدرب - قانون الشركات', 'محامي متدرب للعمل في قسم قانون الشركات والاستشارات القانونية.', '["بكالوريوس حقوق", "قيد نقابة المحامين", "مهارات بحث قانوني ممتازة", "إجادة اللغة الإنجليزية"]', '["البحث القانوني", "إعداد المذكرات", "مراجعة العقود", "حضور الجلسات"]', '["Legal Research", "Legal Writing", "Contract Analysis", "English"]', '["Corporate Law", "IP Law", "Legal Software", "Negotiation"]', 'full_time', 'onsite', 'القاهرة', '6,000 - 9,000 جنيه', 'entry', 'بكالوريوس حقوق مع قيد نقابة', '["كلية الحقوق"]', 2, '2026-01-08', 1, 146, 44, '2025-11-29 13:39:47', '2025-11-29 13:39:47');

-- Dumping structure for table lms.lesson_progress
CREATE TABLE IF NOT EXISTS `lesson_progress` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `lesson_id` bigint unsigned NOT NULL,
  `course_id` bigint unsigned NOT NULL,
  `watched_seconds` int NOT NULL DEFAULT '0',
  `progress_percentage` decimal(5,2) NOT NULL DEFAULT '0.00',
  `is_completed` tinyint(1) NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `last_watched_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lesson_progress_user_id_lesson_id_unique` (`user_id`,`lesson_id`),
  KEY `lesson_progress_lesson_id_foreign` (`lesson_id`),
  KEY `lesson_progress_course_id_foreign` (`course_id`),
  KEY `lesson_progress_user_id_course_id_index` (`user_id`,`course_id`),
  CONSTRAINT `lesson_progress_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lesson_progress_lesson_id_foreign` FOREIGN KEY (`lesson_id`) REFERENCES `course_lessons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lesson_progress_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.lesson_progress: ~0 rows (approximately)

-- Dumping structure for table lms.live_sessions
CREATE TABLE IF NOT EXISTS `live_sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint unsigned NOT NULL,
  `session_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time DEFAULT NULL,
  `status` enum('scheduled','live','ended','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'scheduled',
  `stream_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recording_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attendees_count` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_course_date` (`course_id`,`session_date`),
  CONSTRAINT `live_sessions_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.live_sessions: ~0 rows (approximately)

-- Dumping structure for table lms.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.migrations: ~0 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '0001_01_01_000000_create_users_table', 1),
	(2, '0001_01_01_000001_create_cache_table', 1),
	(3, '0001_01_01_000002_create_jobs_table', 1),
	(4, '2025_08_31_084336_create_personal_access_tokens_table', 1),
	(5, '2025_09_02_125718_create_student_profiles_table', 1),
	(6, '2025_09_02_125746_create_teacher_profiles_table', 1),
	(7, '2025_09_02_125808_create_parent_profiles_table', 1),
	(8, '2025_09_08_130825_create_parent_student_follow_requests_table', 1),
	(9, '2025_09_08_130851_create_didit_verifications_table', 1),
	(10, '2025_09_08_142139_create_notifications_table', 1),
	(11, '2025_09_14_114011_add_login_tracking_to_users_table', 1),
	(12, '2025_09_14_145924_create_university_student_profiles_table', 1),
	(13, '2025_09_14_165143_create_courses_table', 1),
	(14, '2025_09_15_131948_add_live_course_fields_to_courses_table', 1),
	(15, '2025_09_15_132017_create_course_sessions_table', 1),
	(16, '2025_09_22_100335_create_course_lessons_table', 1),
	(17, '2025_09_22_100358_create_lesson_progress_table', 1),
	(18, '2025_09_22_141007_create_course_enrollments_table', 1),
	(19, '2025_09_25_055442_create_payments_table', 1),
	(20, '2025_09_25_120301_create_live_sessions_table', 1),
	(21, '2025_09_25_120302_create_chat_messages_table', 1),
	(22, '2025_09_25_120302_create_session_attendance_table', 1),
	(23, '2025_10_07_072003_create_companies_table', 1),
	(24, '2025_10_07_072030_create_job_postings_table', 1),
	(25, '2025_10_07_072052_create_job_applications_table', 1),
	(26, '2025_10_23_120000_make_goal_nullable_in_university_student_profiles_table', 1),
	(27, '2025_11_01_213601_add_status_to_courses_table', 1),
	(28, '2025_11_08_000001_increase_cache_value_column_size', 1),
	(29, '2025_11_23_100000_create_ai_conversations_table', 1),
	(30, '2025_11_24_000001_add_profile_picture_to_user_tables', 1),
	(31, '2025_11_25_000001_create_password_reset_tokens_table', 1);

-- Dumping structure for table lms.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.notifications: ~2 rows (approximately)

-- Dumping structure for table lms.parent_profiles
CREATE TABLE IF NOT EXISTS `parent_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `profile_picture` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `children_count` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `didit_data` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_profiles_user_id_index` (`user_id`),
  CONSTRAINT `parent_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.parent_profiles: ~8 rows (approximately)
INSERT INTO `parent_profiles` (`id`, `user_id`, `profile_picture`, `children_count`, `didit_data`, `created_at`, `updated_at`) VALUES
	(1, 51, NULL, '2', '"{\\"verified\\":true,\\"verification_date\\":\\"2025-10-21\\"}"', '2025-11-29 13:39:56', '2025-11-29 13:39:56'),
	(2, 52, NULL, '1', '"{\\"verified\\":true,\\"verification_date\\":\\"2025-10-18\\"}"', '2025-11-29 13:39:57', '2025-11-29 13:39:57'),
	(3, 53, NULL, '2', '"{\\"verified\\":false,\\"verification_date\\":null}"', '2025-11-29 13:39:57', '2025-11-29 13:39:57'),
	(4, 54, NULL, '3', '"{\\"verified\\":true,\\"verification_date\\":\\"2025-11-14\\"}"', '2025-11-29 13:39:57', '2025-11-29 13:39:57'),
	(5, 55, NULL, '1', '"{\\"verified\\":true,\\"verification_date\\":\\"2025-10-10\\"}"', '2025-11-29 13:39:57', '2025-11-29 13:39:57'),
	(6, 56, NULL, '2', '"{\\"verified\\":false,\\"verification_date\\":null}"', '2025-11-29 13:39:57', '2025-11-29 13:39:57'),
	(7, 57, NULL, '2', '"{\\"verified\\":true,\\"verification_date\\":\\"2025-11-04\\"}"', '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(8, 58, NULL, '1', '"{\\"verified\\":true,\\"verification_date\\":\\"2025-10-03\\"}"', '2025-11-29 13:39:58', '2025-11-29 13:39:58');

-- Dumping structure for table lms.parent_student_follow_requests
CREATE TABLE IF NOT EXISTS `parent_student_follow_requests` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `approved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parent_student_follow_requests_parent_id_student_id_unique` (`parent_id`,`student_id`),
  KEY `parent_student_follow_requests_student_id_foreign` (`student_id`),
  KEY `parent_student_follow_requests_status_index` (`status`),
  CONSTRAINT `parent_student_follow_requests_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `parent_student_follow_requests_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.parent_student_follow_requests: ~14 rows (approximately)
INSERT INTO `parent_student_follow_requests` (`id`, `parent_id`, `student_id`, `status`, `approved_at`, `created_at`, `updated_at`) VALUES
	(1, 51, 21, 'approved', '2025-11-29 13:39:56', '2025-11-29 13:39:56', '2025-11-29 13:39:56'),
	(2, 51, 22, 'approved', '2025-11-29 13:39:56', '2025-11-29 13:39:56', '2025-11-29 13:39:56'),
	(3, 52, 23, 'approved', '2025-11-29 13:39:57', '2025-11-29 13:39:57', '2025-11-29 13:39:57'),
	(4, 53, 24, 'approved', '2025-11-29 13:39:57', '2025-11-29 13:39:57', '2025-11-29 13:39:57'),
	(5, 53, 27, 'approved', '2025-11-29 13:39:57', '2025-11-29 13:39:57', '2025-11-29 13:39:57'),
	(6, 54, 25, 'approved', '2025-11-29 13:39:57', '2025-11-29 13:39:57', '2025-11-29 13:39:57'),
	(7, 54, 28, 'approved', '2025-11-29 13:39:57', '2025-11-29 13:39:57', '2025-11-29 13:39:57'),
	(8, 54, 32, 'approved', '2025-11-29 13:39:57', '2025-11-29 13:39:57', '2025-11-29 13:39:57'),
	(9, 55, 26, 'approved', '2025-11-29 13:39:57', '2025-11-29 13:39:57', '2025-11-29 13:39:57'),
	(10, 56, 29, 'approved', '2025-11-29 13:39:57', '2025-11-29 13:39:57', '2025-11-29 13:39:57'),
	(11, 56, 31, 'approved', '2025-11-29 13:39:57', '2025-11-29 13:39:57', '2025-11-29 13:39:57'),
	(12, 57, 33, 'approved', '2025-11-29 13:39:58', '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(13, 57, 34, 'approved', '2025-11-29 13:39:58', '2025-11-29 13:39:58', '2025-11-29 13:39:58'),
	(14, 58, 35, 'approved', '2025-11-29 13:39:58', '2025-11-29 13:39:58', '2025-11-29 13:39:58');

-- Dumping structure for table lms.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.password_reset_tokens: ~0 rows (approximately)

-- Dumping structure for table lms.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `course_id` bigint unsigned NOT NULL,
  `enrollment_id` bigint unsigned DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EGP',
  `payment_method` enum('card','paypal','wallet') COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_provider` enum('stripe','paypal') COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_payment_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','processing','completed','failed','refunded','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `metadata` json DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `failed_at` timestamp NULL DEFAULT NULL,
  `refunded_at` timestamp NULL DEFAULT NULL,
  `refund_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payments_transaction_id_unique` (`transaction_id`),
  KEY `payments_enrollment_id_foreign` (`enrollment_id`),
  KEY `payments_user_id_status_index` (`user_id`,`status`),
  KEY `payments_course_id_status_index` (`course_id`,`status`),
  KEY `payments_transaction_id_index` (`transaction_id`),
  CONSTRAINT `payments_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payments_enrollment_id_foreign` FOREIGN KEY (`enrollment_id`) REFERENCES `course_enrollments` (`id`) ON DELETE SET NULL,
  CONSTRAINT `payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.payments: ~0 rows (approximately)

-- Dumping structure for table lms.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.personal_access_tokens: ~3 rows (approximately)

-- Dumping structure for table lms.session_attendance
CREATE TABLE IF NOT EXISTS `session_attendance` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `session_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `joined_at` timestamp NULL DEFAULT NULL,
  `left_at` timestamp NULL DEFAULT NULL,
  `duration_minutes` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_attendance` (`session_id`,`student_id`),
  KEY `session_attendance_student_id_foreign` (`student_id`),
  CONSTRAINT `session_attendance_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `live_sessions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `session_attendance_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.session_attendance: ~0 rows (approximately)

-- Dumping structure for table lms.student_profiles
CREATE TABLE IF NOT EXISTS `student_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `profile_picture` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grade` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birth_date` date NOT NULL,
  `preferred_subjects` json DEFAULT NULL,
  `goal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_profiles_user_id_index` (`user_id`),
  CONSTRAINT `student_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.student_profiles: ~15 rows (approximately)
INSERT INTO `student_profiles` (`id`, `user_id`, `profile_picture`, `grade`, `birth_date`, `preferred_subjects`, `goal`, `created_at`, `updated_at`) VALUES
	(1, 21, NULL, 'primary_1', '2018-11-29', NULL, NULL, '2025-11-29 13:39:50', '2025-11-29 13:39:50'),
	(2, 22, NULL, 'primary_2', '2017-11-29', NULL, NULL, '2025-11-29 13:39:50', '2025-11-29 13:39:50'),
	(3, 23, NULL, 'primary_3', '2016-11-29', NULL, NULL, '2025-11-29 13:39:50', '2025-11-29 13:39:50'),
	(4, 24, NULL, 'primary_4', '2015-11-29', NULL, NULL, '2025-11-29 13:39:51', '2025-11-29 13:39:51'),
	(5, 25, NULL, 'primary_5', '2014-11-29', NULL, NULL, '2025-11-29 13:39:51', '2025-11-29 13:39:51'),
	(6, 26, NULL, 'primary_6', '2013-11-29', NULL, NULL, '2025-11-29 13:39:51', '2025-11-29 13:39:51'),
	(7, 27, NULL, 'prep_1', '2012-11-29', NULL, NULL, '2025-11-29 13:39:51', '2025-11-29 13:39:51'),
	(8, 28, NULL, 'prep_1', '2012-11-29', NULL, NULL, '2025-11-29 13:39:51', '2025-11-29 13:39:51'),
	(9, 29, NULL, 'prep_2', '2011-11-29', NULL, NULL, '2025-11-29 13:39:52', '2025-11-29 13:39:52'),
	(10, 30, NULL, 'prep_2', '2011-11-29', NULL, NULL, '2025-11-29 13:39:52', '2025-11-29 13:39:52'),
	(11, 31, NULL, 'prep_3', '2010-11-29', NULL, NULL, '2025-11-29 13:39:52', '2025-11-29 13:39:52'),
	(12, 32, NULL, 'secondary_1', '2009-11-29', NULL, NULL, '2025-11-29 13:39:52', '2025-11-29 13:39:52'),
	(13, 33, NULL, 'secondary_1', '2009-11-29', NULL, NULL, '2025-11-29 13:39:52', '2025-11-29 13:39:52'),
	(14, 34, NULL, 'secondary_2', '2008-11-29', NULL, NULL, '2025-11-29 13:39:53', '2025-11-29 13:39:53'),
	(15, 35, NULL, 'secondary_3', '2007-11-29', NULL, NULL, '2025-11-29 13:39:53', '2025-11-29 13:39:53');

-- Dumping structure for table lms.teacher_profiles
CREATE TABLE IF NOT EXISTS `teacher_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `profile_picture` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `specialization` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `years_of_experience` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cv_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `didit_data` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `teacher_profiles_user_id_index` (`user_id`),
  CONSTRAINT `teacher_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.teacher_profiles: ~12 rows (approximately)
INSERT INTO `teacher_profiles` (`id`, `user_id`, `profile_picture`, `specialization`, `years_of_experience`, `cv_path`, `didit_data`, `created_at`, `updated_at`) VALUES
	(1, 9, NULL, 'math', '5-10', NULL, '"{\\"verified\\":true,\\"verification_date\\":\\"2025-09-27\\"}"', '2025-11-29 13:39:48', '2025-11-29 13:39:48'),
	(2, 10, NULL, 'science', '3-5', NULL, '"{\\"verified\\":true,\\"verification_date\\":\\"2025-08-31\\"}"', '2025-11-29 13:39:48', '2025-11-29 13:39:48'),
	(3, 11, NULL, 'arabic', '10+', NULL, '"{\\"verified\\":true,\\"verification_date\\":\\"2025-11-19\\"}"', '2025-11-29 13:39:48', '2025-11-29 13:39:48'),
	(4, 12, NULL, 'english', '5-10', NULL, '"{\\"verified\\":true,\\"verification_date\\":\\"2025-08-25\\"}"', '2025-11-29 13:39:48', '2025-11-29 13:39:48'),
	(5, 13, NULL, 'social', '3-5', NULL, '"{\\"verified\\":true,\\"verification_date\\":\\"2025-09-20\\"}"', '2025-11-29 13:39:48', '2025-11-29 13:39:48'),
	(6, 14, NULL, 'math', '1-3', NULL, '"{\\"verified\\":false,\\"verification_date\\":null}"', '2025-11-29 13:39:49', '2025-11-29 13:39:49'),
	(7, 15, NULL, 'science', '10+', NULL, '"{\\"verified\\":true,\\"verification_date\\":\\"2025-08-31\\"}"', '2025-11-29 13:39:49', '2025-11-29 13:39:49'),
	(8, 16, NULL, 'english', '3-5', NULL, '"{\\"verified\\":true,\\"verification_date\\":\\"2025-10-09\\"}"', '2025-11-29 13:39:49', '2025-11-29 13:39:49'),
	(9, 17, NULL, 'arabic', '5-10', NULL, '"{\\"verified\\":false,\\"verification_date\\":null}"', '2025-11-29 13:39:49', '2025-11-29 13:39:49'),
	(10, 18, NULL, 'programming', '5-10', NULL, '"{\\"verified\\":true,\\"verification_date\\":\\"2025-10-20\\"}"', '2025-11-29 13:39:49', '2025-11-29 13:39:49'),
	(11, 19, NULL, 'design', '3-5', NULL, '"{\\"verified\\":true,\\"verification_date\\":\\"2025-10-09\\"}"', '2025-11-29 13:39:50', '2025-11-29 13:39:50'),
	(12, 20, NULL, 'business', '10+', NULL, '"{\\"verified\\":true,\\"verification_date\\":\\"2025-09-02\\"}"', '2025-11-29 13:39:50', '2025-11-29 13:39:50');

-- Dumping structure for table lms.university_student_profiles
CREATE TABLE IF NOT EXISTS `university_student_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `profile_picture` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `faculty` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `goal` text COLLATE utf8mb4_unicode_ci,
  `university` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year_of_study` int DEFAULT NULL,
  `gpa` decimal(3,2) DEFAULT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `skills` json DEFAULT NULL,
  `achievements` json DEFAULT NULL,
  `languages` json DEFAULT NULL,
  `experience` json DEFAULT NULL,
  `projects` json DEFAULT NULL,
  `certifications` json DEFAULT NULL,
  `cv_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cv_filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linkedin_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `github_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `portfolio_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `looking_for_opportunities` tinyint(1) NOT NULL DEFAULT '0',
  `preferred_job_types` json DEFAULT NULL,
  `available_from` date DEFAULT NULL,
  `profile_views` int NOT NULL DEFAULT '0',
  `cv_downloads` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `university_student_profiles_user_id_foreign` (`user_id`),
  KEY `university_student_profiles_is_public_index` (`is_public`),
  KEY `university_student_profiles_looking_for_opportunities_index` (`looking_for_opportunities`),
  KEY `university_student_profiles_university_index` (`university`),
  KEY `university_student_profiles_gpa_index` (`gpa`),
  CONSTRAINT `university_student_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.university_student_profiles: ~15 rows (approximately)
INSERT INTO `university_student_profiles` (`id`, `user_id`, `profile_picture`, `faculty`, `goal`, `university`, `year_of_study`, `gpa`, `bio`, `skills`, `achievements`, `languages`, `experience`, `projects`, `certifications`, `cv_path`, `cv_filename`, `linkedin_url`, `github_url`, `portfolio_url`, `is_public`, `looking_for_opportunities`, `preferred_job_types`, `available_from`, `profile_views`, `cv_downloads`, `created_at`, `updated_at`) VALUES
	(1, 36, NULL, 'كلية الهندسة - قسم الحاسبات والمعلومات', 'أطمح للعمل كمطور برمجيات في شركة تقنية رائدة والمساهمة في تطوير حلول مبتكرة', 'جامعة القاهرة', 3, 3.40, 'طالبة هندسة حاسبات شغوفة بالذكاء الاصطناعي وتطوير الويب. أعمل على عدة مشاريع شخصية وأشارك في المسابقات البرمجية.', '"[\\"Python\\",\\"JavaScript\\",\\"React\\",\\"Node.js\\",\\"Machine Learning\\",\\"SQL\\",\\"Git\\"]"', '"[]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[{\\"title\\":\\"Freelance Web Developer\\",\\"company\\":\\"Self-Employed\\",\\"duration\\":\\"6 months\\"}]"', '"[{\\"name\\":\\"E-Commerce Platform\\",\\"description\\":\\"Built with React & Node.js\\"},{\\"name\\":\\"AI Chatbot\\",\\"description\\":\\"NLP-powered customer service bot\\"}]"', '"[{\\"name\\":\\"AWS Cloud Practitioner\\",\\"issuer\\":\\"Amazon Web Services\\",\\"date\\":\\"2024-03-15\\"},{\\"name\\":\\"Meta React Certification\\",\\"issuer\\":\\"Meta\\",\\"date\\":\\"2024-06-20\\"}]"', NULL, NULL, 'https://linkedin.com/in/yasmin-ahmed', 'https://github.com/yasmin-ahmed', NULL, 1, 1, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:53', '2025-11-29 13:39:53'),
	(2, 37, NULL, 'كلية التجارة - قسم إدارة الأعمال', 'أسعى للحصول على فرصة تدريب في مجال الاستشارات الإدارية أو التسويق الرقمي', 'الجامعة الأمريكية بالقاهرة', 4, 3.70, 'طالب إدارة أعمال متميز، حاصل على عدة شهادات في التسويق الرقمي وتحليل البيانات. رئيس نادي ريادة الأعمال بالجامعة.', '"[\\"Digital Marketing\\",\\"Data Analysis\\",\\"Excel\\",\\"PowerBI\\",\\"Project Management\\",\\"Business Strategy\\"]"', '"[\\"President of Entrepreneurship Club\\",\\"Dean\'s List 3 semesters\\"]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[]"', '"[]"', '"[{\\"name\\":\\"Google Digital Marketing\\",\\"issuer\\":\\"Google\\",\\"date\\":\\"2024-01-10\\"},{\\"name\\":\\"HubSpot Content Marketing\\",\\"issuer\\":\\"HubSpot Academy\\",\\"date\\":\\"2024-04-25\\"}]"', NULL, NULL, 'https://linkedin.com/in/ahmed-khaled', NULL, 'https://ahmed-khaled-portfolio.com', 1, 1, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:53', '2025-11-29 13:39:53'),
	(3, 38, NULL, 'كلية الطب البشري', 'أطمح لإكمال دراستي التخصصية في طب الأطفال والعمل في مستشفى متخصص', 'جامعة عين شمس', 5, 3.90, 'طالبة طب متفوقة، مهتمة بالبحث العلمي والعمل التطوعي. شاركت في عدة أبحاث منشورة وحملات توعية صحية.', '"[\\"Clinical Research\\",\\"Medical Writing\\",\\"SPSS\\",\\"Patient Care\\",\\"Emergency Medicine\\"]"', '"[\\"\\\\u0627\\\\u0644\\\\u0645\\\\u0631\\\\u0643\\\\u0632 \\\\u0627\\\\u0644\\\\u0623\\\\u0648\\\\u0644 \\\\u0639\\\\u0644\\\\u0649 \\\\u062f\\\\u0641\\\\u0639\\\\u062a\\\\u064a \\\\u0644\\\\u0644\\\\u0633\\\\u0646\\\\u0629 \\\\u0627\\\\u0644\\\\u0631\\\\u0627\\\\u0628\\\\u0639\\\\u0629\\",\\"\\\\u0646\\\\u0634\\\\u0631 \\\\u0628\\\\u062d\\\\u062b \\\\u0641\\\\u064a \\\\u0645\\\\u062c\\\\u0644\\\\u0629 \\\\u0637\\\\u0628\\\\u064a\\\\u0629 \\\\u0645\\\\u062d\\\\u0643\\\\u0645\\\\u0629\\",\\"\\\\u0645\\\\u062a\\\\u0637\\\\u0648\\\\u0639\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0633\\\\u062a\\\\u0634\\\\u0641\\\\u0649 57357\\"]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[]"', '"[]"', '"[]"', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:53', '2025-11-29 13:39:53'),
	(4, 39, NULL, 'كلية الفنون التطبيقية - قسم التصميم الجرافيكي', 'أريد أن أصبح مصمم UI/UX محترف وأعمل في شركات التقنية الناشئة', 'جامعة حلوان', 2, 3.20, 'مصمم جرافيك طموح، أعمل كفريلانسر بجانب دراستي. متخصص في تصميم الهوية البصرية وواجهات المستخدم.', '"[\\"Adobe Photoshop\\",\\"Illustrator\\",\\"Figma\\",\\"UI\\\\/UX Design\\",\\"Branding\\",\\"Typography\\"]"', '"[]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[]"', '"[{\\"name\\":\\"Mobile App Redesign\\",\\"description\\":\\"Complete UI\\\\/UX overhaul for e-commerce app\\"},{\\"name\\":\\"Brand Identity Project\\",\\"description\\":\\"Created complete brand identity for startup\\"}]"', '"[]"', NULL, NULL, 'https://linkedin.com/in/omar-salem', NULL, 'https://behance.net/omar-salem', 1, 1, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:54', '2025-11-29 13:39:54'),
	(5, 40, NULL, 'كلية الإعلام - قسم الصحافة', 'أطمح للعمل كصحفية استقصائية في مؤسسة إعلامية رائدة', 'جامعة القاهرة', 3, 3.50, 'صحفية طموحة، أكتب في عدة منصات رقمية وورقية. مهتمة بالصحافة الاستقصائية وصحافة البيانات.', '"[\\"Content Writing\\",\\"Investigative Journalism\\",\\"Social Media\\",\\"Video Editing\\",\\"Data Journalism\\"]"', '"[\\"\\\\u062c\\\\u0627\\\\u0626\\\\u0632\\\\u0629 \\\\u0623\\\\u0641\\\\u0636\\\\u0644 \\\\u062a\\\\u0642\\\\u0631\\\\u064a\\\\u0631 \\\\u0635\\\\u062d\\\\u0641\\\\u064a \\\\u0645\\\\u0646 \\\\u0646\\\\u0642\\\\u0627\\\\u0628\\\\u0629 \\\\u0627\\\\u0644\\\\u0635\\\\u062d\\\\u0641\\\\u064a\\\\u064a\\\\u0646\\",\\"\\\\u0645\\\\u0646\\\\u062d\\\\u0629 \\\\u0627\\\\u0644\\\\u062a\\\\u0645\\\\u064a\\\\u0632 \\\\u0627\\\\u0644\\\\u0635\\\\u062d\\\\u0641\\\\u064a \\\\u0645\\\\u0646 \\\\u0645\\\\u0624\\\\u0633\\\\u0633\\\\u0629 \\\\u0627\\\\u0644\\\\u0623\\\\u0647\\\\u0631\\\\u0627\\\\u0645\\"]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[]"', '"[]"', '"[]"', NULL, NULL, 'https://linkedin.com/in/nour-mahmoud', NULL, NULL, 1, 1, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:54', '2025-11-29 13:39:54'),
	(6, 41, NULL, 'كلية الحقوق', 'أطمح للعمل في مجال الاستشارات القانونية للشركات والعمل في مكتب محاماة دولي', 'جامعة القاهرة', 4, 3.80, 'طالب قانون متميز، شارك في عدة مسابقات محاكاة المحاكم وفزت بالمركز الأول. مهتم بقانون الشركات والملكية الفكرية.', '"[\\"Legal Research\\",\\"Contract Analysis\\",\\"Legal Writing\\",\\"Public Speaking\\",\\"Negotiation\\"]"', '"[\\"\\\\u0627\\\\u0644\\\\u0641\\\\u0627\\\\u0626\\\\u0632 \\\\u0628\\\\u0645\\\\u0633\\\\u0627\\\\u0628\\\\u0642\\\\u0629 \\\\u0645\\\\u062d\\\\u0627\\\\u0643\\\\u0627\\\\u0629 \\\\u0627\\\\u0644\\\\u0645\\\\u062d\\\\u0627\\\\u0643\\\\u0645 \\\\u0627\\\\u0644\\\\u0648\\\\u0637\\\\u0646\\\\u064a\\\\u0629\\",\\"\\\\u0639\\\\u0636\\\\u0648 \\\\u0641\\\\u0631\\\\u064a\\\\u0642 \\\\u0627\\\\u0644\\\\u0628\\\\u062d\\\\u062b \\\\u0627\\\\u0644\\\\u0642\\\\u0627\\\\u0646\\\\u0648\\\\u0646\\\\u064a \\\\u0628\\\\u0627\\\\u0644\\\\u0643\\\\u0644\\\\u064a\\\\u0629\\"]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[]"', '"[]"', '"[{\\"name\\":\\"Intellectual Property Law\\",\\"issuer\\":\\"WIPO\\",\\"date\\":\\"2024-02-18\\"},{\\"name\\":\\"Corporate Law Fundamentals\\",\\"issuer\\":\\"Legal Academy\\",\\"date\\":\\"2024-05-12\\"}]"', NULL, NULL, 'https://linkedin.com/in/karim-ibrahim', NULL, NULL, 1, 1, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:54', '2025-11-29 13:39:54'),
	(7, 42, NULL, 'كلية الهندسة - قسم الهندسة الميكانيكية', 'أرغب في العمل في مجال تصميم الأنظمة الميكانيكية والطاقة المتجددة', 'جامعة الإسكندرية', 3, 3.30, 'طالبة هندسة ميكانيكية، شغوفة بالطاقة المتجددة والتصميم باستخدام CAD. شاركت في مشروع تخرج حول الطاقة الشمسية.', '"[\\"AutoCAD\\",\\"SolidWorks\\",\\"MATLAB\\",\\"Thermodynamics\\",\\"Renewable Energy\\",\\"Project Management\\"]"', '"[]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[]"', '"[{\\"name\\":\\"Solar Panel Optimization System\\",\\"description\\":\\"Senior project on solar energy efficiency\\"}]"', '"[]"', NULL, NULL, 'https://linkedin.com/in/hend-abdelrahman', NULL, NULL, 1, 1, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:54', '2025-11-29 13:39:54'),
	(8, 43, NULL, 'كلية الاقتصاد والعلوم السياسية - قسم الاقتصاد', 'أطمح لتطوير مهاراتي في التحليل الاقتصادي والعمل في مجال البحث الاقتصادي', 'جامعة القاهرة', 2, 2.80, 'طالب اقتصاد مهتم بالاقتصاد التنموي والسياسات العامة. أسعى لتحسين مهاراتي الأكاديمية والعملية.', '"[\\"Economic Analysis\\",\\"Statistics\\",\\"Excel\\",\\"Research\\",\\"Report Writing\\"]"', '"[]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[]"', '"[]"', '"[]"', NULL, NULL, 'https://linkedin.com/in/mohamed-ali-econ', NULL, NULL, 1, 1, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:54', '2025-11-29 13:39:54'),
	(9, 44, NULL, 'كلية الصيدلة', 'أطمح للعمل في مجال الصناعات الدوائية والبحث والتطوير', 'جامعة عين شمس', 4, 3.60, 'طالبة صيدلة متميزة، مهتمة بصناعة الدواء والرقابة الدوائية. شاركت في عدة ورش عمل حول الجودة الدوائية.', '"[\\"Pharmaceutical Analysis\\",\\"Drug Development\\",\\"Quality Control\\",\\"Research\\",\\"Medical Terminology\\"]"', '"[\\"\\\\u0634\\\\u0647\\\\u0627\\\\u062f\\\\u0629 \\\\u062a\\\\u062f\\\\u0631\\\\u064a\\\\u0628 \\\\u0645\\\\u0646 \\\\u0634\\\\u0631\\\\u0643\\\\u0629 \\\\u0641\\\\u0627\\\\u0631\\\\u0643\\\\u0648 \\\\u0644\\\\u0644\\\\u0623\\\\u062f\\\\u0648\\\\u064a\\\\u0629\\",\\"\\\\u0648\\\\u0631\\\\u0634\\\\u0629 \\\\u0639\\\\u0645\\\\u0644 \\\\u062d\\\\u0648\\\\u0644 \\\\u0627\\\\u0644\\\\u062c\\\\u0648\\\\u062f\\\\u0629 \\\\u0627\\\\u0644\\\\u062f\\\\u0648\\\\u0627\\\\u0626\\\\u064a\\\\u0629 - \\\\u0645\\\\u0646\\\\u0638\\\\u0645\\\\u0629 \\\\u0627\\\\u0644\\\\u0635\\\\u062d\\\\u0629 \\\\u0627\\\\u0644\\\\u0639\\\\u0627\\\\u0644\\\\u0645\\\\u064a\\\\u0629\\"]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[]"', '"[]"', '"[]"', NULL, NULL, 'https://linkedin.com/in/salma-hassan', NULL, NULL, 1, 1, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:55', '2025-11-29 13:39:55'),
	(10, 45, NULL, 'كلية الزراعة - قسم الإنتاج النباتي', 'أطمح للعمل في مجال الزراعة المستدامة والأمن الغذائي', 'جامعة القاهرة', 3, 3.10, 'طالب زراعة مهتم بالزراعة المستدامة والتكنولوجيا الزراعية الحديثة. أعمل على مشروع تخرج حول الزراعة العضوية.', '"[\\"Sustainable Agriculture\\",\\"Crop Management\\",\\"Soil Science\\",\\"Agricultural Technology\\",\\"Research\\"]"', '"[]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[]"', '"[]"', '"[]"', NULL, NULL, 'https://linkedin.com/in/youssef-mostafa', NULL, NULL, 1, 1, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:55', '2025-11-29 13:39:55'),
	(11, 46, NULL, 'كلية الحاسبات والمعلومات - علوم الحاسب', 'أطمح للعمل في مجال الذكاء الاصطناعي والتعلم الآلي في شركة تقنية عالمية', 'جامعة عين شمس', 4, 3.90, 'طالبة علوم حاسب متفوقة، متخصصة في الذكاء الاصطناعي والتعلم العميق. نشرت ورقة بحثية في مؤتمر دولي.', '"[\\"Python\\",\\"TensorFlow\\",\\"PyTorch\\",\\"Deep Learning\\",\\"Computer Vision\\",\\"NLP\\",\\"Data Science\\"]"', '"[\\"\\\\u0646\\\\u0634\\\\u0631 \\\\u0648\\\\u0631\\\\u0642\\\\u0629 \\\\u0628\\\\u062d\\\\u062b\\\\u064a\\\\u0629 \\\\u0641\\\\u064a \\\\u0645\\\\u0624\\\\u062a\\\\u0645\\\\u0631 IEEE \\\\u0627\\\\u0644\\\\u062f\\\\u0648\\\\u0644\\\\u064a\\",\\"\\\\u0627\\\\u0644\\\\u0641\\\\u0627\\\\u0626\\\\u0632 \\\\u0628\\\\u0645\\\\u0633\\\\u0627\\\\u0628\\\\u0642\\\\u0629 Kaggle - Computer Vision Challenge\\",\\"\\\\u0645\\\\u0646\\\\u062d\\\\u0629 \\\\u0627\\\\u0644\\\\u062a\\\\u0645\\\\u064a\\\\u0632 \\\\u0627\\\\u0644\\\\u0623\\\\u0643\\\\u0627\\\\u062f\\\\u064a\\\\u0645\\\\u064a \\\\u0645\\\\u0646 \\\\u0627\\\\u0644\\\\u062c\\\\u0627\\\\u0645\\\\u0639\\\\u0629\\"]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[]"', '"[{\\"name\\":\\"Medical Image Classification\\",\\"description\\":\\"Deep learning model for disease detection\\"},{\\"name\\":\\"Arabic NLP System\\",\\"description\\":\\"Sentiment analysis for Arabic text\\"}]"', '"[{\\"name\\":\\"Deep Learning Specialization\\",\\"issuer\\":\\"Coursera\\",\\"date\\":\\"2024-07-30\\"},{\\"name\\":\\"TensorFlow Developer Certificate\\",\\"issuer\\":\\"Google\\",\\"date\\":\\"2024-09-15\\"}]"', NULL, NULL, 'https://linkedin.com/in/lina-saeed', 'https://github.com/lina-saeed', 'https://lina-ai-portfolio.com', 1, 1, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:55', '2025-11-29 13:39:55'),
	(12, 47, NULL, 'كلية الهندسة - قسم الهندسة المعمارية', 'أطمح للعمل في مكتب استشارات هندسية والمشاركة في مشاريع معمارية مبتكرة', 'جامعة القاهرة', 5, 3.50, 'طالب عمارة شغوف بالتصميم المستدام والعمارة الخضراء. شارك في عدة مسابقات معمارية دولية.', '"[\\"AutoCAD\\",\\"Revit\\",\\"3ds Max\\",\\"SketchUp\\",\\"Architectural Design\\",\\"Sustainable Design\\",\\"BIM\\"]"', '"[\\"\\\\u0627\\\\u0644\\\\u0641\\\\u0627\\\\u0626\\\\u0632 \\\\u0628\\\\u0627\\\\u0644\\\\u0645\\\\u0631\\\\u0643\\\\u0632 \\\\u0627\\\\u0644\\\\u062b\\\\u0627\\\\u0644\\\\u062b \\\\u0641\\\\u064a \\\\u0645\\\\u0633\\\\u0627\\\\u0628\\\\u0642\\\\u0629 \\\\u0627\\\\u0644\\\\u062a\\\\u0635\\\\u0645\\\\u064a\\\\u0645 \\\\u0627\\\\u0644\\\\u0645\\\\u0639\\\\u0645\\\\u0627\\\\u0631\\\\u064a \\\\u0627\\\\u0644\\\\u062f\\\\u0648\\\\u0644\\\\u064a\\\\u0629\\",\\"\\\\u0645\\\\u0634\\\\u0627\\\\u0631\\\\u0643 \\\\u0641\\\\u064a \\\\u0645\\\\u0639\\\\u0631\\\\u0636 \\\\u0627\\\\u0644\\\\u0639\\\\u0645\\\\u0627\\\\u0631\\\\u0629 \\\\u0627\\\\u0644\\\\u0645\\\\u0633\\\\u062a\\\\u062f\\\\u0627\\\\u0645\\\\u0629\\"]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[]"', '"[{\\"name\\":\\"Eco-Friendly Housing Complex\\",\\"description\\":\\"Sustainable residential design project\\"},{\\"name\\":\\"Cultural Center Design\\",\\"description\\":\\"Modern cultural space with traditional elements\\"}]"', '"[]"', NULL, NULL, 'https://linkedin.com/in/adam-ramadan', NULL, 'https://behance.net/adam-ramadan', 1, 1, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:55', '2025-11-29 13:39:55'),
	(13, 48, NULL, 'كلية الآداب - قسم اللغة الإنجليزية', 'أطمح للعمل في مجال الترجمة وتدريس اللغة الإنجليزية', 'جامعة الإسكندرية', 2, 3.40, 'طالبة لغة إنجليزية شغوفة بالأدب والترجمة. أعمل كمترجمة مستقلة وأدرس شهادة CELTA.', '"[\\"Translation\\",\\"English Teaching\\",\\"Content Writing\\",\\"Proofreading\\",\\"Interpretation\\",\\"Creative Writing\\"]"', '"[]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[{\\"title\\":\\"Freelance Translator\\",\\"company\\":\\"Upwork\\",\\"duration\\":\\"1 year\\"},{\\"title\\":\\"English Tutor\\",\\"company\\":\\"Private\\",\\"duration\\":\\"8 months\\"}]"', '"[]"', '"[{\\"name\\":\\"IELTS - Band 8\\",\\"issuer\\":\\"British Council\\",\\"date\\":\\"2024-05-20\\"},{\\"name\\":\\"CELTA (In Progress)\\",\\"issuer\\":\\"Cambridge Assessment English\\",\\"date\\":\\"2025-01-15\\"}]"', NULL, NULL, 'https://linkedin.com/in/dina-adel', NULL, NULL, 1, 1, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:56', '2025-11-29 13:39:56'),
	(14, 49, NULL, 'كلية السياحة والفنادق - قسم الإرشاد السياحي', 'أطمح للعمل كمرشد سياحي محترف وتطوير السياحة المستدامة في مصر', 'جامعة حلوان', 3, 3.00, 'طالب سياحة شغوف بالتاريخ المصري والثقافة. أعمل كمرشد سياحي بدوام جزئي وأتحدث 3 لغات.', '"[\\"Tour Guiding\\",\\"Customer Service\\",\\"History Knowledge\\",\\"Event Planning\\",\\"Hospitality Management\\"]"', '"[]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[]"', '"[]"', '"[{\\"name\\":\\"Licensed Tour Guide\\",\\"issuer\\":\\"Ministry of Tourism\\",\\"date\\":\\"2024-08-10\\"},{\\"name\\":\\"First Aid Certificate\\",\\"issuer\\":\\"Red Crescent\\",\\"date\\":\\"2024-10-05\\"}]"', NULL, NULL, 'https://linkedin.com/in/tamer-fawzy', NULL, NULL, 1, 1, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:56', '2025-11-29 13:39:56'),
	(15, 50, NULL, 'كلية الطب البيطري', 'أطمح للعمل في مجال الطب البيطري الإكلينيكي والجراحة البيطرية', 'جامعة القاهرة', 4, 3.70, 'طالبة طب بيطري متميزة، مهتمة برعاية الحيوانات الأليفة والطب البيطري الوقائي. تطوعت في عدة عيادات بيطرية.', '"[\\"Veterinary Medicine\\",\\"Animal Care\\",\\"Surgery Basics\\",\\"Clinical Diagnosis\\",\\"Emergency Care\\"]"', '"[\\"\\\\u0627\\\\u0644\\\\u062a\\\\u062f\\\\u0631\\\\u064a\\\\u0628 \\\\u0627\\\\u0644\\\\u0635\\\\u064a\\\\u0641\\\\u064a \\\\u0641\\\\u064a \\\\u0639\\\\u064a\\\\u0627\\\\u062f\\\\u0629 \\\\u0628\\\\u064a\\\\u0637\\\\u0631\\\\u064a\\\\u0629 \\\\u0645\\\\u062a\\\\u062e\\\\u0635\\\\u0635\\\\u0629\\",\\"\\\\u0639\\\\u0636\\\\u0648 \\\\u0641\\\\u0631\\\\u064a\\\\u0642 \\\\u0627\\\\u0644\\\\u0637\\\\u0648\\\\u0627\\\\u0631\\\\u0626 \\\\u0627\\\\u0644\\\\u0628\\\\u064a\\\\u0637\\\\u0631\\\\u064a\\\\u0629 \\\\u0628\\\\u0627\\\\u0644\\\\u062c\\\\u0627\\\\u0645\\\\u0639\\\\u0629\\"]"', '"[{\\"name\\":\\"\\\\u0627\\\\u0644\\\\u0639\\\\u0631\\\\u0628\\\\u064a\\\\u0629\\",\\"level\\":\\"Native\\"},{\\"name\\":\\"English\\",\\"level\\":\\"Fluent\\"}]"', '"[]"', '"[]"', '"[]"', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, '2026-03-01', 0, 0, '2025-11-29 13:39:56', '2025-11-29 13:39:56');

-- Dumping structure for table lms.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_picture` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_type` enum('university_student','student','teacher','parent','company','admin') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','active','suspended') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_approved` tinyint(1) NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `last_login_ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login_user_agent` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_email_index` (`email`),
  KEY `users_user_type_index` (`user_type`),
  KEY `users_status_index` (`status`),
  KEY `users_is_approved_index` (`is_approved`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table lms.users: ~59 rows (approximately)
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `profile_picture`, `phone`, `email_verified_at`, `password`, `user_type`, `status`, `is_approved`, `remember_token`, `created_at`, `updated_at`, `last_login_at`, `last_login_ip`, `last_login_user_agent`) VALUES
	(1, 'أحمد', 'السيد', 'company1@test.com', NULL, '+201234567890', NULL, '$2y$12$0yxu0pdVXWp9d5mijlfQV.GTnt/W3YAlnoGBdv0gnpVjjE2f7ZSPG', 'company', 'active', 1, NULL, '2025-11-29 13:39:47', '2025-11-29 13:39:47', NULL, NULL, NULL),
	(2, 'سارة', 'محمد', 'company2@test.com', NULL, '+201234567891', NULL, '$2y$12$VdKbAioLSrxxOrmSgLB5fudEKp30VPN6RhQhHVZqI19bXWich0Ua2', 'company', 'active', 1, NULL, '2025-11-29 13:39:47', '2025-11-29 13:39:47', NULL, NULL, NULL),
	(3, 'كريم', 'حسن', 'company3@test.com', NULL, '+201234567892', NULL, '$2y$12$xmqqeeKXqxTug6QDLVXFz.oXjXsakmpqXR5k.bQNhNXs7sB1EZI6.', 'company', 'active', 1, NULL, '2025-11-29 13:39:47', '2025-11-29 13:39:47', NULL, NULL, NULL),
	(4, 'منى', 'عبد العزيز', 'company4@test.com', NULL, '+201234567893', NULL, '$2y$12$F.73LJRC1gi.6OnVYQaVhO0DiBcBe/Hujt8J6/MLiMdHBlroDvipa', 'company', 'active', 1, NULL, '2025-11-29 13:39:47', '2025-11-29 13:39:47', NULL, NULL, NULL),
	(5, 'محمد', 'يوسف', 'company5@test.com', NULL, '+201234567894', NULL, '$2y$12$pM.93/U6.JQOVNBwYje75O77FGXybsGFVsSW.lIRqOM0fUHINEtju', 'company', 'active', 1, NULL, '2025-11-29 13:39:47', '2025-11-29 13:39:47', NULL, NULL, NULL),
	(6, 'ليلى', 'إبراهيم', 'company6@test.com', NULL, '+201234567895', NULL, '$2y$12$9GN8odcxwnrQeW62UAF5BuTh2h0C95VXnP3flfSyiCz6sYt6I6Mhq', 'company', 'active', 1, NULL, '2025-11-29 13:39:47', '2025-11-29 13:39:47', NULL, NULL, NULL),
	(7, 'طارق', 'فهمي', 'company7@test.com', NULL, '+201234567896', NULL, '$2y$12$ebDTj0cpKncXPu8xhyafXOQS8M9OntoLIeSKrlP6s40YM0qnLP6US', 'company', 'active', 1, NULL, '2025-11-29 13:39:47', '2025-11-29 13:39:47', NULL, NULL, NULL),
	(8, 'نادية', 'سامي', 'company8@test.com', NULL, '+201234567897', NULL, '$2y$12$MBjDltPWSrFfAfc2SGNgh.wTTV0XqBWyX9KirXJy19d6Bz/MPKN2y', 'company', 'active', 1, NULL, '2025-11-29 13:39:47', '2025-11-29 13:39:47', NULL, NULL, NULL),
	(9, 'أحمد', 'محمد', 'ahmed.mohamed@teacher.com', NULL, '+201001234567', '2025-11-29 13:39:48', '$2y$12$wmWJ7ZDl9BU4NFJDX.Clm.eLdyrmToS5bvCDIhW0wNKRt8X2LUUKa', 'teacher', 'active', 1, NULL, '2025-11-29 13:39:48', '2025-11-29 13:39:48', NULL, NULL, NULL),
	(10, 'فاطمة', 'علي', 'fatma.ali@teacher.com', NULL, '+201001234568', '2025-11-29 13:39:48', '$2y$12$5juyk2eDJBYE64xEjVsf..LT0t0BQhFrbG5U8UjWN38YnDOKIKBW.', 'teacher', 'active', 1, NULL, '2025-11-29 13:39:48', '2025-11-29 13:39:48', NULL, NULL, NULL),
	(11, 'محمود', 'حسن', 'mahmoud.hassan@teacher.com', NULL, '+201001234569', '2025-11-29 13:39:48', '$2y$12$LeXzI9nmORdAGJtAnDjno.nWcgnXuNtvMD2Js6lpZzrJmvSFlxAiu', 'teacher', 'active', 1, NULL, '2025-11-29 13:39:48', '2025-11-29 13:39:48', NULL, NULL, NULL),
	(12, 'سارة', 'إبراهيم', 'sara.ibrahim@teacher.com', NULL, '+201001234570', '2025-11-29 13:39:48', '$2y$12$nqhIJbaSNVDA3mqpzT9Ud.Ku0jJRkoGFK6ZyyBjdXD5LOpbp.ZaiS', 'teacher', 'active', 1, NULL, '2025-11-29 13:39:48', '2025-11-29 13:39:48', NULL, NULL, NULL),
	(13, 'خالد', 'يوسف', 'khaled.youssef@teacher.com', NULL, '+201001234571', '2025-11-29 13:39:48', '$2y$12$jkrxMWzVAz6zr4FJxDeGiue.N6bJu.VqTuB7DJs32nfd1l6LhFmW2', 'teacher', 'active', 1, NULL, '2025-11-29 13:39:48', '2025-11-29 13:39:48', NULL, NULL, NULL),
	(14, 'نور', 'عبد', 'nour.abdullah@teacher.com', NULL, '+201001234572', '2025-11-29 13:39:49', '$2y$12$9IndHzJg5yqE3gGa0T848OIGvwFeH57v2VQVy5ZxJmujrNHLukhXC', 'teacher', 'active', 1, NULL, '2025-11-29 13:39:49', '2025-11-29 13:39:49', NULL, NULL, NULL),
	(15, 'ياسر', 'طارق', 'yasser.tarek@teacher.com', NULL, '+201001234573', '2025-11-29 13:39:49', '$2y$12$qe5vTYpXM84Y2.9u/.6hPuu7EhoZO6V5SqRRXpOv1.G1SNzmHh5vm', 'teacher', 'active', 1, NULL, '2025-11-29 13:39:49', '2025-11-29 13:39:49', NULL, NULL, NULL),
	(16, 'هدى', 'سامي', 'hoda.samy@teacher.com', NULL, '+201001234574', '2025-11-29 13:39:49', '$2y$12$rBOPbnZhJtinhRgRIqK2pekRM2Juv9ASWCBZe5.d9LuhA7nQ5wPOO', 'teacher', 'active', 0, NULL, '2025-11-29 13:39:49', '2025-11-29 13:39:49', NULL, NULL, NULL),
	(17, 'عمرو', 'فهمي', 'amr.fahmy@teacher.com', NULL, '+201001234575', '2025-11-29 13:39:49', '$2y$12$3LBdWH.LMyX7aU11NdAWn.h93GwrE5ezuyGE8SqD4reZzC295kyoG', 'teacher', 'active', 1, NULL, '2025-11-29 13:39:49', '2025-11-29 13:39:49', NULL, NULL, NULL),
	(18, 'كريم', 'يوسف', 'karim.youssef@teacher.com', NULL, '+201001234576', '2025-11-29 13:39:49', '$2y$12$X7EJ5R.h3kRS/ZQePODT9OH83fwE8kqs7AAHS.FUBEImutlKNdDge', 'teacher', 'active', 1, NULL, '2025-11-29 13:39:49', '2025-11-29 13:39:49', NULL, NULL, NULL),
	(19, 'دينا', 'أحمد', 'dina.ahmed@teacher.com', NULL, '+201001234577', '2025-11-29 13:39:50', '$2y$12$z9ntSWQ.t4MfWU5QdrEE..SLQYESrHp6FngAN4Ns0rrBoqQnu4L1G', 'teacher', 'active', 1, NULL, '2025-11-29 13:39:50', '2025-11-29 13:39:50', NULL, NULL, NULL),
	(20, 'مصطفى', 'رمضان', 'mostafa.ramadan@teacher.com', NULL, '+201001234578', '2025-11-29 13:39:50', '$2y$12$5B/s5FEv7mTLPMeFaTVT6u5FyLFOCsXoDsjhsquyMnJOjoDVx5eZe', 'teacher', 'active', 1, NULL, '2025-11-29 13:39:50', '2025-11-29 13:39:50', NULL, NULL, NULL),
	(21, 'زياد', 'محمود', 'student1@test.com', NULL, '+201025470774', '2025-11-29 13:39:50', '$2y$12$WVBhh0fiYfXeNAFgIgBdBecceQZb5/goc8IkGHiiL1YLq06KzNYPq', 'student', 'active', 1, NULL, '2025-11-29 13:39:50', '2025-11-29 13:39:50', NULL, NULL, NULL),
	(22, 'ملك', 'أحمد', 'student2@test.com', NULL, '+201086411688', '2025-11-29 13:39:50', '$2y$12$ghbdg8s/mR3727h5jHV2h.XNqoI2CNQ87DZcANp.3NJhsww2txdhi', 'student', 'active', 1, NULL, '2025-11-29 13:39:50', '2025-11-29 13:39:50', NULL, NULL, NULL),
	(23, 'آدم', 'حسن', 'student3@test.com', NULL, '+201046293852', '2025-11-29 13:39:50', '$2y$12$sMq2gADauAWF0SY.hso.Du3GC3kZNrm7W.LwaM1Z/szOxukSwoZyi', 'student', 'active', 1, NULL, '2025-11-29 13:39:50', '2025-11-29 13:39:50', NULL, NULL, NULL),
	(24, 'جنى', 'عبد', 'student4@test.com', NULL, '+201066452181', '2025-11-29 13:39:51', '$2y$12$T/SG0uSipdIcume.hN3jhOzNjY8gX8HevfZuc7Sti0sbTBJ4Rw5PC', 'student', 'active', 1, NULL, '2025-11-29 13:39:51', '2025-11-29 13:39:51', NULL, NULL, NULL),
	(25, 'عمر', 'سعيد', 'student5@test.com', NULL, '+201079117296', '2025-11-29 13:39:51', '$2y$12$eCqOIA1KM8l2T0cC9sshyO5ZMmDq2lHzrtupTIzJ5g3njWkbhx8.e', 'student', 'active', 1, NULL, '2025-11-29 13:39:51', '2025-11-29 13:39:51', NULL, NULL, NULL),
	(26, 'ريم', 'طارق', 'student6@test.com', NULL, '+201051083608', '2025-11-29 13:39:51', '$2y$12$gZcCFJ12R0oRsMyWCNdBnOgLLSzfCxNMtLQSRAW0eMcoz9zYBvRLK', 'student', 'active', 1, NULL, '2025-11-29 13:39:51', '2025-11-29 13:39:51', NULL, NULL, NULL),
	(27, 'محمد', 'علي', 'student7@test.com', NULL, '+201086750641', '2025-11-29 13:39:51', '$2y$12$/zFK8HgT5ZnkB6YQKidf8.asH39fxGhmvxoo8iIpwaiQIZpji.Vka', 'student', 'active', 1, NULL, '2025-11-29 13:39:51', '2025-11-29 13:39:51', NULL, NULL, NULL),
	(28, 'سارة', 'أحمد', 'student8@test.com', NULL, '+201093746336', '2025-11-29 13:39:51', '$2y$12$79P/teok7QXF0GoY/YABn.LwhZvR1AgfhEX5yG.JDkvHQZkoupIy2', 'student', 'active', 1, NULL, '2025-11-29 13:39:51', '2025-11-29 13:39:51', NULL, NULL, NULL),
	(29, 'كريم', 'يوسف', 'student9@test.com', NULL, '+201011212628', '2025-11-29 13:39:52', '$2y$12$PpOWJxoFKzaC59qKajfpkOs2MzxJmmR3C1jtbdbz4vQvUGc53XR66', 'student', 'active', 1, NULL, '2025-11-29 13:39:52', '2025-11-29 13:39:52', NULL, NULL, NULL),
	(30, 'نور', 'محمود', 'student10@test.com', NULL, '+201079175285', '2025-11-29 13:39:52', '$2y$12$gSdhJxSW50QIsFgx/Fb8ouFTjDz7HZpcYc2LBjXSi8HYE9HJDQLu.', 'student', 'active', 1, NULL, '2025-11-29 13:39:52', '2025-11-29 13:39:52', NULL, NULL, NULL),
	(31, 'حسن', 'إبراهيم', 'student11@test.com', NULL, '+201068332666', '2025-11-29 13:39:52', '$2y$12$/lP6DhpiAFn9LVCs92v65e9nksTseTBtfjXOTK2E2yCPaVHlL3Fsm', 'student', 'active', 1, NULL, '2025-11-29 13:39:52', '2025-11-29 13:39:52', NULL, NULL, NULL),
	(32, 'عمر', 'حسن', 'student12@test.com', NULL, '+201020036551', '2025-11-29 13:39:52', '$2y$12$PF/pEEKgDOOS2Ii6FrI1h.pJsNwKe8S68NCetch/6YxN7h3sEokdm', 'student', 'active', 1, NULL, '2025-11-29 13:39:52', '2025-11-29 13:39:52', NULL, NULL, NULL),
	(33, 'فاطمة', 'علي', 'student13@test.com', NULL, '+201060318467', '2025-11-29 13:39:52', '$2y$12$uuAX56tn7x.sGOF9jd8lzexRNBylxOFjjPre08cSsChS/UkqRvTAm', 'student', 'active', 1, NULL, '2025-11-29 13:39:52', '2025-11-29 13:39:52', NULL, NULL, NULL),
	(34, 'أحمد', 'خالد', 'student14@test.com', NULL, '+201028026456', '2025-11-29 13:39:53', '$2y$12$yppNHEhVybCws3jHsOMuA.R/u.KecdNKQPib7YY3U8IhHoChdmN1W', 'student', 'active', 1, NULL, '2025-11-29 13:39:53', '2025-11-29 13:39:53', NULL, NULL, NULL),
	(35, 'ياسمين', 'صلاح', 'student15@test.com', NULL, '+201029916415', '2025-11-29 13:39:53', '$2y$12$stySipVBCIWyRfsSyhqpNeaSyiUi7kF.wLsnEeugW.xFfdGiQl6su', 'student', 'active', 1, NULL, '2025-11-29 13:39:53', '2025-11-29 13:39:53', NULL, NULL, NULL),
	(36, 'ياسمين', 'أحمد', 'yasmin.ahmed@university.com', NULL, '+201198212102', '2025-11-29 13:39:53', '$2y$12$Cj4tQ9mpiT7AvOh4H2qYqekOzP6GHEkgJFk.2nUQARSJsfe3/HofO', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:53', '2025-11-29 13:39:53', NULL, NULL, NULL),
	(37, 'أحمد', 'خالد', 'ahmed.khaled@university.com', NULL, '+201177124104', '2025-11-29 13:39:53', '$2y$12$q/n38vkIhequNLoqzjpma.vbNM2RNdIJWuq.YPrRXs0Dd/VJrkjly', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:53', '2025-11-29 13:39:53', NULL, NULL, NULL),
	(38, 'مريم', 'حسين', 'mariam.hussein@university.com', NULL, '+201114767591', '2025-11-29 13:39:53', '$2y$12$o9vu7M/sarwpO68o8XX/Be4C0E30KhvFUpaso0/l5MyQNyLP3nvk2', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:53', '2025-11-29 13:39:53', NULL, NULL, NULL),
	(39, 'عمر', 'سالم', 'omar.salem@university.com', NULL, '+201140999720', '2025-11-29 13:39:54', '$2y$12$kMGOc11xeq1/mRzOdomQxuS5rwEeHBeqmEI5jHQh9Gr.FXuIb5c66', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:54', '2025-11-29 13:39:54', NULL, NULL, NULL),
	(40, 'نور', 'محمود', 'nour.mahmoud@university.com', NULL, '+201183128661', '2025-11-29 13:39:54', '$2y$12$xtTxhkhZUl7LQkJECm5TK.VIItqQj1beH766HX2XE4yz7KBc2dqqu', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:54', '2025-11-29 13:39:54', NULL, NULL, NULL),
	(41, 'كريم', 'إبراهيم', 'karim.ibrahim@university.com', NULL, '+201113445258', '2025-11-29 13:39:54', '$2y$12$yODRqhWH690HySom5K1.7.x7GY3briH49qysQrYRDPAj8zhBCfbr6', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:54', '2025-11-29 13:39:54', NULL, NULL, NULL),
	(42, 'هند', 'عبد الرحمن', 'hend.abdelrahman@university.com', NULL, '+201173606688', '2025-11-29 13:39:54', '$2y$12$izyQsZNa0/igDjs8fNeB2OeIUaXyjE0S1EbcdB6sstqRQUlYxBa52', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:54', '2025-11-29 13:39:54', NULL, NULL, NULL),
	(43, 'محمد', 'علي', 'mohamed.ali@university.com', NULL, '+201193218892', '2025-11-29 13:39:54', '$2y$12$MN3bWHPe9e0WDxb0gGaiFONuw3hdGsZTfhX0hqTuGsjrwMNcAAyli', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:54', '2025-11-29 13:39:54', NULL, NULL, NULL),
	(44, 'سلمى', 'حسن', 'salma.hassan@university.com', NULL, '+201189553167', '2025-11-29 13:39:55', '$2y$12$8EQcvZfAgXipkMDl/j9Nk.ZBzWjEo1kL0KFfiLD7zjYvuX1VqwRqW', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:55', '2025-11-29 13:39:55', NULL, NULL, NULL),
	(45, 'يوسف', 'مصطفى', 'youssef.mostafa@university.com', NULL, '+201145886488', '2025-11-29 13:39:55', '$2y$12$r123LiLCupu2ezSDlnZgLuqPa3c0yF5AwjFlWnMwxHnJY9LvVoc02', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:55', '2025-11-29 13:39:55', NULL, NULL, NULL),
	(46, 'لينا', 'سعيد', 'lina.saeed@university.com', NULL, '+201184776729', '2025-11-29 13:39:55', '$2y$12$0cc/gqtIO4vGC0yMDFLBvuogAoSp/yYbT.mCQYFBYN3ejpgK8dr0C', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:55', '2025-11-29 13:39:55', NULL, NULL, NULL),
	(47, 'آدم', 'رمضان', 'adam.ramadan@university.com', NULL, '+201151992344', '2025-11-29 13:39:55', '$2y$12$oGgSM1qp18EB9x8fDwJvG.4nhEIngPajvp8vPYd5eV8N6clM9e0.e', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:55', '2025-11-29 13:39:55', NULL, NULL, NULL),
	(48, 'دينا', 'عادل', 'dina.adel@university.com', NULL, '+201162574670', '2025-11-29 13:39:56', '$2y$12$/pmR7L/oTZqNM60X2CSBEeK7I6zu0BI/Slpn5LWttTaTdu5qLFOKG', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:56', '2025-11-29 13:39:56', NULL, NULL, NULL),
	(49, 'تامر', 'فوزي', 'tamer.fawzy@university.com', NULL, '+201136785363', '2025-11-29 13:39:56', '$2y$12$FAVtuvTB1Mnq/T2Ro8lRFu2HhSPk8gAf4WOVPjabyaczo1Mf0elg.', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:56', '2025-11-29 13:39:56', NULL, NULL, NULL),
	(50, 'ريم', 'طارق', 'reem.tarek@university.com', NULL, '+201177702146', '2025-11-29 13:39:56', '$2y$12$jaVpQQfOMmr5DwSu35QsW.h87FS97r5JPUBnBBsoCr7lHbL4aTqR.', 'university_student', 'active', 1, NULL, '2025-11-29 13:39:56', '2025-11-29 13:39:56', NULL, NULL, NULL),
	(51, 'عبد', 'الله', 'parent1@test.com', NULL, '+201098673047', '2025-11-29 13:39:56', '$2y$12$vTlPn3HEFD/EBIYO0CLk3uRLkAkgkXYx.UfZm/GqxjsCDnrYkoeqa', 'parent', 'active', 1, NULL, '2025-11-29 13:39:56', '2025-11-29 13:39:56', NULL, NULL, NULL),
	(52, 'منى', 'حسن', 'parent2@test.com', NULL, '+201097595471', '2025-11-29 13:39:57', '$2y$12$zLnOu3bXYOi/hBK8mNsG.eOiP4P2/Vbi4vE4k7kOg8flUosKq6Xp6', 'parent', 'active', 1, NULL, '2025-11-29 13:39:57', '2025-11-29 13:39:57', NULL, NULL, NULL),
	(53, 'محمود', 'عبد', 'parent3@test.com', NULL, '+201091760671', '2025-11-29 13:39:57', '$2y$12$Tc55FRYBM8UeQFH4EOIeA.IAafT8UTG/ZG9nGCaF/AAjWBN0Fc4XK', 'parent', 'active', 1, NULL, '2025-11-29 13:39:57', '2025-11-29 13:39:57', NULL, NULL, NULL),
	(54, 'سارة', 'سعيد', 'parent4@test.com', NULL, '+201093981050', '2025-11-29 13:39:57', '$2y$12$V29IIeVcKipFjGbRoDXjDOezEwV2wmlpSKRxSmSU46QJAeH1AXt5m', 'parent', 'active', 1, NULL, '2025-11-29 13:39:57', '2025-11-29 13:39:57', NULL, NULL, NULL),
	(55, 'أحمد', 'طارق', 'parent5@test.com', NULL, '+201094316734', '2025-11-29 13:39:57', '$2y$12$a5LcdMS1nGVuY.QdG1MNvu8PaILWwNlxIuVEnCc6o.ignOBvj23Mi', 'parent', 'active', 1, NULL, '2025-11-29 13:39:57', '2025-11-29 13:39:57', NULL, NULL, NULL),
	(56, 'فاطمة', 'يوسف', 'parent6@test.com', NULL, '+201091025120', '2025-11-29 13:39:57', '$2y$12$BaNEfNXKpuCKbKpxBVb9iOtlk5rEpmz6WUDNIUYXd0FtP7tSGI9vW', 'parent', 'active', 1, NULL, '2025-11-29 13:39:57', '2025-11-29 13:39:57', NULL, NULL, NULL),
	(57, 'خالد', 'علي', 'parent7@test.com', NULL, '+201098677797', '2025-11-29 13:39:58', '$2y$12$fcfmqT.qLUg6wev8Z106/eFJnX4yPdX3QHQvgcYFEkymxFKmQdz8G', 'parent', 'active', 1, NULL, '2025-11-29 13:39:58', '2025-11-29 13:39:58', NULL, NULL, NULL),
	(58, 'هدى', 'صلاح', 'parent8@test.com', NULL, '+201096085837', '2025-11-29 13:39:58', '$2y$12$f1ovhJ2Eb1kEuNdPcmh1vOk.A2MX3.zGtoqvuXD1/YaRt2Tr31jp2', 'parent', 'active', 1, NULL, '2025-11-29 13:39:58', '2025-11-29 13:39:58', NULL, NULL, NULL),
	(59, 'Admin', 'Edvance', 'admin@Edvance.com', NULL, '+201234567890', '2025-11-29 13:40:12', '$2y$12$4NMITWZnfyTiqshYozCjoegDpaC4Q/x3Fww9c8cXiuGgpL382jQQS', 'admin', 'active', 1, NULL, '2025-11-29 13:40:12', '2025-11-29 13:40:12', NULL, NULL, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
