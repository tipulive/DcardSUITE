-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 25, 2023 at 08:28 PM
-- Server version: 11.1.2-MariaDB
-- PHP Version: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dcardstock`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `CompanyName` varchar(191) NOT NULL DEFAULT 'none',
  `photo_url` varchar(191) NOT NULL DEFAULT 'none',
  `name` varchar(191) NOT NULL DEFAULT 'none',
  `email` varchar(191) NOT NULL DEFAULT 'none',
  `password` varchar(191) NOT NULL DEFAULT 'none',
  `Ccode` varchar(20) NOT NULL DEFAULT 'none',
  `phone` varchar(20) NOT NULL DEFAULT 'none',
  `PhoneNumber` varchar(191) NOT NULL DEFAULT 'none',
  `initCountry` varchar(20) NOT NULL DEFAULT 'none',
  `platform` varchar(191) NOT NULL DEFAULT 'none',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `AdminRecord_Status` varchar(20) NOT NULL DEFAULT '0',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `country` varchar(191) NOT NULL DEFAULT 'none',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `uid`, `uidCreator`, `CompanyName`, `photo_url`, `name`, `email`, `password`, `Ccode`, `phone`, `PhoneNumber`, `initCountry`, `platform`, `status`, `AdminRecord_Status`, `subscriber`, `country`, `created_at`, `updated_at`) VALUES
(1, 'Kayiranga_1668876519', 'none', 'DMSMLTD', 'none', 'Kayiranga', 'admin@gmail.com', '$2y$10$WGVr6hTZIqw11Mo.RW.oT.f9zAnGY.jQgUi4WO3yHz1TrpFdJCXCm', 'none', 'Kayiranga_1668876519', '+23782389359', 'none', '1000', 'none', '0', 'DMSMLTD777', 'USA', '2022-11-19 16:48:39', NULL),
(2, 'kebineericMuna_1668935525', 'Kayiranga_1668876519', 'TEA LTD', 'none', 'keza', 'company@gmail.com', '$2y$10$EDkhUcP1goz86eT0eTGQxeS63ds6J/wi6VjhNB/W2uTUrF2BQnwme', 'none', '0782389359', '+250782389359', 'none', '3000', 'active1', '6', 'TEALTD', 'USA', '2022-11-20 09:12:05', '2023-06-19 17:25:16'),
(3, 'kebineericMuna_1681471130', 'Kayiranga_1668876519', 'TVA', 'none', 'company', 'company1@gmail.com', '$2y$10$PAQLtuLlQpvkGamK78oKaerqze4D/kCAn9Nr/fop6OR28V4xj7bs2', 'none', 'none', '0782389359', 'none', '3000', 'none', '0', 'TVA', 'USA', '2023-04-14 11:18:50', NULL),
(13, 'mn_1681494921', 'Kayiranga_1668876519', 'TEA LTD', 'none', 'guma', 'ceke@gmail.com', '$2y$10$QvfaGbOX679nxPxnI/vXJe8UcemEdP5JjkO2BG.t5QFglt.qTu9ky', 'none', 'none', '+243464646', 'none', '3000', 'none', '6', 'TEALTD', 'USA', '2023-04-14 17:55:21', NULL),
(14, 'vena_1685410606', 'kebineericMuna_1668935525', 'TEA LTD', 'none', 'vena', 'vena@gmail.com', '$2y$10$6qL3J/46cyXJla6bHfXtQ.0sgocP.qJrUbXHryJlbMtaTLGUq34j6', 'none', 'none', '+243999123589', 'none', '3000', 'inactive2', '0', 'TEALTD', 'USA', '2023-05-30 01:36:46', NULL),
(15, 'Soft_1685410666', 'Kayiranga_1668876519', 'PM', 'none', 'Soft', 'soft123@gmail.com', '$2y$10$xQheRTTJH6Jnf2bhFXCihuw6jWGOxbkcfcA6ofPPQ2olSn/0g3hMm', 'none', 'none', '+243999999999', 'none', '3000', 'none', '0', 'PM_1685410666', 'USA', '2023-05-30 01:37:46', NULL),
(16, 'veki_1687463785', 'kebineericMuna_1668935525', 'TEA LTD', 'none', 'veki', 'veki@gmail.com', '$2y$10$R22vlm3S4JQm57EgWZK6RucbCU5eDJm6EFCdseF7tJmj6jWlzCk6m', 'none', 'none', '+243993778778', 'none', '3000', 'active2', '0', 'TEALTD', 'USA', '2023-06-22 19:56:25', NULL),
(17, 'kopo_1687464172', 'Kayiranga_1668876519', 'kopo LTD Task', 'none', 'kopo', 'kopa@gmail.com', '$2y$10$f7lrgnvtien6grc/CLeJS.yWIkhAnv/7B21XCrjWOBOSvnpoYz3mu', 'none', 'none', '+243978787877', 'none', '3000', 'active1', '6', 'TEALTD', 'USA', '2023-06-22 20:02:52', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admnin_records`
--

CREATE TABLE `admnin_records` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `balance` varchar(191) NOT NULL DEFAULT '0',
  `bonus` varchar(191) NOT NULL DEFAULT '0',
  `dettes` varchar(191) NOT NULL DEFAULT '0',
  `safeBalance` varchar(21) NOT NULL DEFAULT '0',
  `borrowBalance` varchar(21) NOT NULL DEFAULT '0',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `systemUid` varchar(191) NOT NULL DEFAULT 'none',
  `addBalance` varchar(191) NOT NULL DEFAULT '0',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `currentAction` varchar(191) NOT NULL DEFAULT 'none',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `appname`
--

CREATE TABLE `appname` (
  `id` int(191) NOT NULL,
  `systemUid` varchar(191) NOT NULL DEFAULT 'none',
  `systemName` varchar(191) NOT NULL DEFAULT 'none',
  `SysVersion` varchar(50) NOT NULL,
  `systemData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`systemData`))
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE `cards` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `CardNumber` varchar(191) NOT NULL DEFAULT 'none',
  `uidCreator` varchar(191) NOT NULL,
  `uidUploader` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL,
  `filename` varchar(191) NOT NULL DEFAULT 'none',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `SyncAdd` varchar(191) NOT NULL DEFAULT 'new',
  `SyncUpdate` varchar(191) NOT NULL DEFAULT 'none',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`id`, `uid`, `CardNumber`, `uidCreator`, `uidUploader`, `subscriber`, `filename`, `status`, `SyncAdd`, `SyncUpdate`, `created_at`, `updated_at`) VALUES
(1, 'TEALTD_7hEnj_1672352175', '3056801672352175', 'kebineericMuna_1668935525', 'none', 'TEALTD', 'TEALTD_JD_1672352175', 'Assigned', 'new', 'none', NULL, NULL),
(2, 'TEALTD_lN7o8_1672352176', '8973621672352176', 'kebineericMuna_1668935525', 'none', 'TEALTD', 'TEALTD_Us_1672352176', 'Assigned', 'new', 'none', NULL, NULL),
(3, 'TEALTD_jTqR9_1672352176', '6544181672352176', 'kebineericMuna_1668935525', 'none', 'TEALTD', 'TEALTD_e5_1672352176', 'none', 'new', 'none', NULL, NULL),
(4, 'TEALTD_gc4Mm_1676837784', '1780281676837784', 'kebineericMuna_1668935525', 'none', 'TEALTD', 'TEALTD_fX_1676837784', 'none', 'new', 'none', NULL, NULL),
(5, 'TEALTD_dhseb_1676837794', '9543751676837794', 'kebineericMuna_1668935525', 'none', 'TEALTD', 'TEALTD_Dj_1676837794', 'none', 'new', 'none', NULL, NULL),
(6, 'TEALTD_v8rdP_1676837794', '3460401676837794', 'kebineericMuna_1668935525', 'none', 'TEALTD', 'TEALTD_BO_1676837794', 'none', 'new', 'none', NULL, NULL),
(7, 'TEALTD_RefV6_1676838705', '1595001676838705', 'kebineericMuna_1668935525', 'none', 'TEALTD', 'TEALTD_ZM_1676838705', 'none', 'new', 'none', NULL, NULL),
(8, 'TEALTD_6Nthw_1676838706', '5685201676838706', 'kebineericMuna_1668935525', 'none', 'TEALTD', 'TEALTD_ql_1676838706', 'none', 'new', 'none', NULL, NULL),
(9, 'TEALTD_osqz6_1676838736', '4477801676838736', 'kebineericMuna_1668935525', 'none', 'TEALTD', 'TEALTD_2x_1676838736', 'none', 'new', 'none', NULL, NULL),
(10, 'TEALTD_RcIRL_1676838736', '1669011676838736', 'kebineericMuna_1668935525', 'none', 'TEALTD', 'TEALTD_sp_1676838736', 'none', 'new', 'none', NULL, NULL),
(11, 'TEALTD_8ZT5o_1677887168', '3848191677887168', 'kebineericMuna_1668935525', 'none', 'TEALTD', 'TEALTD_3X_1677887168', 'none', 'new', 'none', NULL, NULL),
(12, 'TEALTD_RKW2B_1677887170', '8341261677887170', 'kebineericMuna_1668935525', 'none', 'TEALTD', 'TEALTD_uZ_1677887170', 'none', 'new', 'none', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cinterests`
--

CREATE TABLE `cinterests` (
  `id` int(191) NOT NULL,
  `safariId` varchar(191) NOT NULL DEFAULT 'none',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `interest` varchar(191) NOT NULL DEFAULT '0',
  `TSpendTemp` varchar(191) NOT NULL DEFAULT '0',
  `TSpendProTemp` varchar(191) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `depenses`
--

CREATE TABLE `depenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `uidUser` varchar(191) NOT NULL DEFAULT 'none',
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `amount` varchar(191) NOT NULL DEFAULT 'none',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `temporalData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`temporalData`)),
  `systemUid` varchar(191) NOT NULL DEFAULT 'none',
  `purpose` varchar(191) NOT NULL DEFAULT 'none',
  `commentData` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dettes`
--

CREATE TABLE `dettes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `uidUser` varchar(191) NOT NULL DEFAULT 'none',
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `amount` varchar(191) NOT NULL DEFAULT 'none',
  `paidAmount` varchar(191) NOT NULL DEFAULT 'none',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `temporalData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`temporalData`)),
  `systemUid` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `purpose` varchar(191) NOT NULL DEFAULT 'none',
  `commentData` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(191) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2022_11_16_163405_create_admins_table', 1),
(6, '2022_11_16_163611_create_promotions_table', 1),
(7, '2022_11_16_163713_create_participateds_table', 1),
(10, '2022_11_27_101737_create_cards_table', 3),
(11, '2022_11_28_163628_create_sync_ons_table', 3),
(12, '2022_11_28_165901_create_sync_offs_table', 3),
(13, '2022_12_10_151908_create_safaris_table', 4),
(14, '2022_12_10_153108_create_safari_products_table', 4),
(15, '2022_12_10_155314_create_spents_table', 4),
(16, '2023_01_26_120743_create_topup_histories_table', 5),
(18, '2022_11_16_163754_create_topups_table', 6),
(20, '2023_02_14_200721_create_redeemeds_table', 8),
(22, '2023_03_07_202448_create_quickbonushists_table', 9),
(24, '2023_03_07_202940_create_quickbosubmithists_table', 9),
(25, '2023_03_07_201538_create_quickbonuses_table', 10),
(26, '2023_03_22_181800_add_quick_uid', 11),
(27, '2023_03_07_202917_create_quickbosubmits_table', 12),
(33, '2022_11_16_180751_create_testdatas_table', 14),
(38, '2023_10_07_194308_create_worker_payments_table', 14),
(39, '2023_10_07_194509_create_workers_table', 14),
(40, '2023_04_12_205108_create_admnin_records_table', 15),
(41, '2023_01_29_132950_create_participated_hists_table', 16),
(42, '2023_10_13_150611_create_orders_table', 17),
(43, '2023_10_21_144006_create_temp_tables_table', 18),
(44, '2023_10_06_175815_create_depenses_table', 19),
(45, '2023_10_05_195024_create_repaid_users_table', 20),
(46, '2023_10_05_192349_create_paid_dettes_table', 21),
(47, '2023_09_11_191849_create_dettes_table', 22);

-- --------------------------------------------------------

--
-- Table structure for table `orderhistories`
--

CREATE TABLE `orderhistories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `SafariId` varchar(191) NOT NULL DEFAULT 'none',
  `productCode` varchar(191) NOT NULL,
  `userid` varchar(191) NOT NULL,
  `subscriber` varchar(21) NOT NULL DEFAULT 'none',
  `clientId` varchar(191) NOT NULL DEFAULT 'none',
  `ref` varchar(191) NOT NULL DEFAULT 'none',
  `order_creator` varchar(191) NOT NULL DEFAULT 'none',
  `price` varchar(191) NOT NULL,
  `qty` varchar(191) NOT NULL,
  `qty_count` varchar(191) NOT NULL DEFAULT '''0''',
  `total` varchar(191) NOT NULL,
  `OrderData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `all_total` varchar(191) NOT NULL DEFAULT 'none',
  `custom_price` varchar(191) NOT NULL DEFAULT 'none',
  `custom_total` varchar(191) NOT NULL DEFAULT 'none',
  `comment_count` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`comment_count`)),
  `status` varchar(191) NOT NULL DEFAULT 'Open',
  `paidStatus` varchar(20) NOT NULL DEFAULT 'none',
  `permission` varchar(191) NOT NULL DEFAULT 'false',
  `description` longtext DEFAULT NULL,
  `order_created` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `promotionUid` varchar(50) NOT NULL DEFAULT 'none',
  `bonusType` varchar(10) NOT NULL DEFAULT 'none',
  `bonusValue` varchar(50) NOT NULL DEFAULT 'none',
  `giftId` varchar(50) NOT NULL DEFAULT 'none',
  `giftQty` varchar(50) NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orderhistories_backup`
--

CREATE TABLE `orderhistories_backup` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `SafariId` varchar(191) NOT NULL DEFAULT 'none',
  `productCode` varchar(191) NOT NULL,
  `userid` varchar(191) NOT NULL,
  `subscriber` varchar(21) NOT NULL DEFAULT 'none',
  `clientId` varchar(191) NOT NULL DEFAULT 'none',
  `ref` varchar(191) NOT NULL DEFAULT 'none',
  `order_creator` varchar(191) NOT NULL DEFAULT 'none',
  `price` varchar(191) NOT NULL,
  `qty` varchar(191) NOT NULL,
  `qty_count` varchar(191) NOT NULL DEFAULT '''0''',
  `total` varchar(191) NOT NULL,
  `OrderData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `all_total` varchar(191) NOT NULL DEFAULT 'none',
  `custom_price` varchar(191) NOT NULL DEFAULT 'none',
  `custom_total` varchar(191) NOT NULL DEFAULT 'none',
  `comment_count` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`comment_count`)),
  `status` varchar(191) NOT NULL DEFAULT 'Open',
  `paidStatus` varchar(20) NOT NULL DEFAULT 'none',
  `permission` varchar(191) NOT NULL DEFAULT 'false',
  `description` longtext DEFAULT NULL,
  `order_created` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `promotionUid` varchar(50) NOT NULL DEFAULT 'none',
  `bonusType` varchar(10) NOT NULL DEFAULT 'none',
  `bonusValue` varchar(50) NOT NULL DEFAULT 'none',
  `giftId` varchar(50) NOT NULL DEFAULT 'none',
  `giftQty` varchar(50) NOT NULL DEFAULT 'none',
  `orderPromotionUid` varchar(50) NOT NULL DEFAULT 'none',
  `orderGain` varchar(50) NOT NULL DEFAULT 'none',
  `orderReach` varchar(50) NOT NULL DEFAULT 'none',
  `orderDebt` varchar(50) NOT NULL,
  `orderPaidStatus` varchar(50) NOT NULL,
  `orderAction` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `uidUser` varchar(191) NOT NULL DEFAULT 'none',
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `total` varchar(191) NOT NULL DEFAULT '0',
  `paid` varchar(191) NOT NULL DEFAULT '0',
  `debt` varchar(191) NOT NULL DEFAULT '0',
  `paidStatus` varchar(191) NOT NULL DEFAULT 'none',
  `Status` varchar(191) NOT NULL DEFAULT 'none',
  `temporalData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`temporalData`)),
  `systemUid` varchar(191) NOT NULL DEFAULT 'none',
  `commentData` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `promotionUid` varchar(50) NOT NULL DEFAULT 'none',
  `reach` varchar(50) NOT NULL DEFAULT 'none',
  `gain` varchar(50) NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ordertest`
--

CREATE TABLE `ordertest` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `SafariId` varchar(191) NOT NULL DEFAULT 'none',
  `productCode` varchar(191) NOT NULL,
  `userid` varchar(191) NOT NULL,
  `clientId` varchar(191) NOT NULL DEFAULT 'none',
  `ref` varchar(191) NOT NULL DEFAULT 'none',
  `order_creator` varchar(191) NOT NULL DEFAULT 'none',
  `price` varchar(191) NOT NULL,
  `qty` varchar(191) NOT NULL,
  `total` varchar(191) NOT NULL,
  `all_total` varchar(191) NOT NULL DEFAULT 'none',
  `custom_price` varchar(191) NOT NULL DEFAULT 'none',
  `custom_total` varchar(191) NOT NULL DEFAULT 'none',
  `qty_count` varchar(191) NOT NULL DEFAULT '0',
  `comment_count` longtext DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'Open',
  `permission` varchar(191) NOT NULL DEFAULT 'false',
  `description` longtext DEFAULT NULL,
  `order_created` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `paid_dettes`
--

CREATE TABLE `paid_dettes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `uidUser` varchar(191) NOT NULL DEFAULT 'none',
  `uidReceiver` varchar(191) NOT NULL DEFAULT 'none',
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `amount` varchar(191) NOT NULL DEFAULT 'none',
  `safeAmount` varchar(50) NOT NULL DEFAULT '0',
  `paidStatus` varchar(191) NOT NULL DEFAULT 'none',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `temporalData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`temporalData`)),
  `signature` varchar(191) NOT NULL DEFAULT 'none',
  `systemUid` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `purpose` varchar(191) NOT NULL DEFAULT 'none',
  `commentData` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `participateds`
--

CREATE TABLE `participateds` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `uidUser` varchar(191) NOT NULL,
  `carduid` varchar(191) NOT NULL DEFAULT 'none',
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `promotion_msg` varchar(191) NOT NULL DEFAULT 'none',
  `inputData` varchar(191) NOT NULL DEFAULT 'none',
  `token` varchar(191) NOT NULL DEFAULT 'none',
  `started_date` varchar(191) NOT NULL DEFAULT 'none',
  `ended_date` varchar(191) NOT NULL DEFAULT 'none',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `participateds`
--

INSERT INTO `participateds` (`id`, `uid`, `uidUser`, `carduid`, `uidCreator`, `subscriber`, `promotion_msg`, `inputData`, `token`, `started_date`, `ended_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Nyota_1672353378', 'kebineericMuna_1668935593', 'none', 'kebineericMuna_1668935525', 'TEALTD', 'none', '23', 'none', 'none', 'none', 'none', '2022-12-30 15:56:24', NULL),
(2, 'kivuBucket_1672353285', 'kebineericMuna_1668935593', 'none', 'kebineericMuna_1668935525', 'TEALTD', 'none', '1000', 'none', 'none', 'none', 'reached', '2023-01-29 18:50:33', NULL),
(9, 'kivuBucket_1672353285', 'kebineericMuna_1674160265', 'none', 'kebineericMuna_1668935525', 'TEALTD', 'none', '102', 'none', 'none', 'none', 'none', '2023-05-08 15:48:48', '2023-05-08 15:48:48'),
(11, 'Nyota_1672353378', 'kebineericMuna_1674160265', 'none', 'kebineericMuna_1668935525', 'TEALTD', 'none', '780', 'none', 'none', 'none', 'none', '2023-05-08 16:16:57', '2023-12-13 07:18:39');

-- --------------------------------------------------------

--
-- Table structure for table `participated_hists`
--

CREATE TABLE `participated_hists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `uidUser` varchar(191) NOT NULL DEFAULT 'none',
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `carduid` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `promotion_msg` varchar(191) NOT NULL DEFAULT 'none',
  `inputData` varchar(191) NOT NULL DEFAULT '0',
  `actionName` varchar(191) NOT NULL DEFAULT 'none',
  `token` varchar(191) NOT NULL DEFAULT 'none',
  `started_date` varchar(191) NOT NULL DEFAULT 'none',
  `ended_date` varchar(191) NOT NULL DEFAULT 'none',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'MyApp', '0ec5c6346ffa8ba02824823b912769bc268ca02193140f91811798aba9a5ac29', '[\"*\"]', NULL, '2022-11-19 18:44:53', '2022-11-19 18:44:53'),
(2, 'App\\Models\\Admin', 1, 'MyApp', '8a93b31049064ff49c871fc2c377960b978b135f6ddbd49af5538cd40b78dccf', '[\"*\"]', NULL, '2022-11-19 18:58:42', '2022-11-19 18:58:42'),
(3, 'App\\Models\\Admin', 1, 'MyApp', 'eb42a61185032eb267229e16e58e8b22aded8bee2945d6c3de830912227ead4e', '[\"*\"]', NULL, '2022-11-20 08:46:50', '2022-11-20 08:46:50'),
(4, 'App\\Models\\Admin', 1, 'MyApp', '458e5a861c60ce18361b5ed51ce07e6beaef6c31b2ee165efa88273e51bd98c8', '[\"*\"]', '2023-04-14 12:20:45', '2022-11-20 08:46:56', '2023-04-14 12:20:45'),
(5, 'App\\Models\\Admin', 2, 'MyApp', '77e8b05482a47dfc673a49fdf1087d3dd480656e5b00a66df4439e98d7249c18', '[\"*\"]', '2022-11-20 09:13:13', '2022-11-20 09:12:28', '2022-11-20 09:13:13'),
(6, 'App\\Models\\User', 2, 'MyApp', '5cfb74ede7e76636362e44760009e7dbbc9099fb7ce7602cee1c8f77c3d7b7d4', '[\"*\"]', NULL, '2022-11-20 09:15:30', '2022-11-20 09:15:30'),
(7, 'App\\Models\\Admin', 2, 'MyApp', '557317114a878faa2649934998dabe3d9279564dff5caf6b0136ec071f09ae26', '[\"*\"]', NULL, '2022-11-20 09:53:41', '2022-11-20 09:53:41'),
(8, 'App\\Models\\Admin', 2, 'MyApp', '4475f4205254c60c9e76c31a4de851169acdb01ae454eba3fcd8f0f70eb09b03', '[\"*\"]', NULL, '2022-11-20 16:26:15', '2022-11-20 16:26:15'),
(9, 'App\\Models\\Admin', 2, 'MyApp', 'db4406e4b0a5a18f0d87db6dd8c567432f65971ecf3f58a8a18d19f5d24da116', '[\"*\"]', NULL, '2022-11-20 20:05:16', '2022-11-20 20:05:16'),
(10, 'App\\Models\\Admin', 2, 'MyApp', '4cefdf6e2a4fb3f94dc0acba6b6dd82b852f0e03d1a6e53a7fc546aa34d184dd', '[\"*\"]', NULL, '2022-11-20 20:05:42', '2022-11-20 20:05:42'),
(11, 'App\\Models\\Admin', 2, 'MyApp', '8ce1af0a021a3952386cdb5cf706ba20ad315edac66aaa061df1521298122cf6', '[\"*\"]', NULL, '2022-11-20 20:06:05', '2022-11-20 20:06:05'),
(12, 'App\\Models\\Admin', 2, 'MyApp', '74e73ac9ec6c0d3b0329688ca1d98dc3fc0cb4b7bd0f15f231eaeaa7244ebeb6', '[\"*\"]', NULL, '2022-11-20 20:06:20', '2022-11-20 20:06:20'),
(13, 'App\\Models\\Admin', 2, 'MyApp', 'c1bf38bf4d21aa4be6172756c658258814287cffd46ba957dd3f754223a9bf6b', '[\"*\"]', NULL, '2022-11-20 20:06:34', '2022-11-20 20:06:34'),
(14, 'App\\Models\\Admin', 2, 'MyApp', 'a3f0f2b9b22fab3c4526c2d1e42e185bfdc61d64eb53a9ab6258fcfcb4065f8c', '[\"*\"]', NULL, '2022-11-20 20:07:41', '2022-11-20 20:07:41'),
(15, 'App\\Models\\Admin', 2, 'MyApp', '88321cb954b4a86cc599d4fbef5e6ec396e11cdafacd5bab630628267a266fc7', '[\"*\"]', NULL, '2022-11-20 21:31:33', '2022-11-20 21:31:33'),
(16, 'App\\Models\\Admin', 2, 'MyApp', 'a6d423ef909bc10bc453bf1300cf2dfa09cbe8f0cd91601ff88b6e49846fde43', '[\"*\"]', NULL, '2022-11-20 21:32:30', '2022-11-20 21:32:30'),
(17, 'App\\Models\\Admin', 2, 'MyApp', 'b4da837f07abe9a0ae6486a48d3cd9415261567ab3261d5f90a93d4ecbabb7c8', '[\"*\"]', NULL, '2022-11-20 22:04:47', '2022-11-20 22:04:47'),
(18, 'App\\Models\\Admin', 2, 'MyApp', '29d89c1a6c0151ce6d0589b008e566980a6aa365e86b6871d518d681977db130', '[\"*\"]', NULL, '2022-11-20 22:06:37', '2022-11-20 22:06:37'),
(19, 'App\\Models\\Admin', 2, 'MyApp', 'd9d71a2b23a648565ebede201bdc5e9d0ecd926fd2c781f64c87b2f6efd3a4e7', '[\"*\"]', NULL, '2022-11-20 22:10:32', '2022-11-20 22:10:32'),
(20, 'App\\Models\\Admin', 2, 'MyApp', '2ad862bf5233c7141d44da23a7356d36d7592d2c153644e9b4d3fd29b4d5b224', '[\"*\"]', NULL, '2022-11-20 22:14:52', '2022-11-20 22:14:52'),
(21, 'App\\Models\\Admin', 2, 'MyApp', '7b0218b11a3dc99f823dd1dd5ed059d1fb797a3ac05a1be21f2a994cac1fa986', '[\"*\"]', NULL, '2022-11-20 22:16:21', '2022-11-20 22:16:21'),
(22, 'App\\Models\\Admin', 2, 'MyApp', '5e956364f1b4c878bd8eefd3a6132e78464767cf99319bc282f41fe0f6410c79', '[\"*\"]', NULL, '2022-11-20 22:47:35', '2022-11-20 22:47:35'),
(23, 'App\\Models\\Admin', 2, 'MyApp', '5ad4b0da1eaf7ed89dbd18c2be89e2cf1afbb376380d2ea10d07df170c1cd65b', '[\"*\"]', NULL, '2022-11-21 19:03:18', '2022-11-21 19:03:18'),
(24, 'App\\Models\\Admin', 2, 'MyApp', 'b18bf4b906a819ce20c4b21e3a5be927addd5af6e330449f6e16f9044516f91e', '[\"*\"]', '2022-12-12 18:22:54', '2022-11-28 17:09:57', '2022-12-12 18:22:54'),
(25, 'App\\Models\\Admin', 2, 'MyApp', '2d01a6149a270f85612cddfd21cd02043c1b89f33010b59bc23a2782502cf797', '[\"*\"]', NULL, '2022-12-02 18:29:28', '2022-12-02 18:29:28'),
(26, 'App\\Models\\Admin', 2, 'MyApp', '82d9c49d65756fcaa7dba2c24a0e68eb329ab4e4f8a0918b7acae99b3b39d02a', '[\"*\"]', NULL, '2022-12-02 18:30:43', '2022-12-02 18:30:43'),
(27, 'App\\Models\\Admin', 2, 'MyApp', '175c20b07fc65d21698da3c4e5f87699a8b9ca84d14fb7c31382dde5293e6d87', '[\"*\"]', NULL, '2022-12-03 20:15:53', '2022-12-03 20:15:53'),
(28, 'App\\Models\\Admin', 2, 'MyApp', 'dd148dd65dd8d2bd05bbca84b94832fc5c83823826c9df82025718d9f15631d6', '[\"*\"]', NULL, '2022-12-03 21:15:25', '2022-12-03 21:15:25'),
(29, 'App\\Models\\Admin', 2, 'MyApp', '651941312743f1139cc82cac9c4d6535b76ec1017e82edd7094a6bccc09ce447', '[\"*\"]', NULL, '2022-12-03 21:18:11', '2022-12-03 21:18:11'),
(30, 'App\\Models\\Admin', 2, 'MyApp', 'a5fd954fb145b899467a897704325af1539098d87e3fa4795b84207197a9e8a6', '[\"*\"]', NULL, '2022-12-03 22:09:38', '2022-12-03 22:09:38'),
(31, 'App\\Models\\Admin', 2, 'MyApp', '51f2fd563d19391e81e11c0e3813f124d85dae7d2522c1bcb39f1598ab0e542c', '[\"*\"]', NULL, '2022-12-03 22:11:54', '2022-12-03 22:11:54'),
(32, 'App\\Models\\Admin', 2, 'MyApp', '71c3eae838b409587c30596ae429edb50023479010e373d46a272b010d0d8644', '[\"*\"]', NULL, '2022-12-03 22:15:14', '2022-12-03 22:15:14'),
(33, 'App\\Models\\Admin', 2, 'MyApp', '85bdc0626ed5dc7dce736a047acf75e9028b9fb700422b6568c4782794b89e34', '[\"*\"]', NULL, '2022-12-03 22:16:42', '2022-12-03 22:16:42'),
(34, 'App\\Models\\Admin', 2, 'MyApp', '25f4cb036934bf4956e61bcdc97defa1212549b4b3e46765b9c5a57965cece6b', '[\"*\"]', NULL, '2022-12-03 22:20:13', '2022-12-03 22:20:13'),
(35, 'App\\Models\\Admin', 2, 'MyApp', 'b55db6b9bc85b6a2224ae22db4f5cebea182acb31d455b0486dfa49e32511960', '[\"*\"]', NULL, '2022-12-03 22:21:53', '2022-12-03 22:21:53'),
(36, 'App\\Models\\Admin', 2, 'MyApp', '18cbe9026c21bbd4978d911b3b5d28bb881017898a29328ced78c63ee73f41e5', '[\"*\"]', NULL, '2022-12-03 22:22:31', '2022-12-03 22:22:31'),
(37, 'App\\Models\\Admin', 2, 'MyApp', 'be01f593c458e19e052fe605217deffb9232ca5e1c926195425f4e1343c4ee9d', '[\"*\"]', NULL, '2022-12-03 22:23:40', '2022-12-03 22:23:40'),
(38, 'App\\Models\\Admin', 2, 'MyApp', 'bc65a1c6acffa5ea8f40d43f76f0cd4f19d28759c89f0a6ad9591f9801ea63c8', '[\"*\"]', NULL, '2022-12-03 22:27:48', '2022-12-03 22:27:48'),
(39, 'App\\Models\\Admin', 2, 'MyApp', '12a5d96d124c8c6b6acc0815424b753f07235678c53ec7b4945f0e9453a8893c', '[\"*\"]', NULL, '2022-12-03 22:31:50', '2022-12-03 22:31:50'),
(40, 'App\\Models\\Admin', 2, 'MyApp', 'a84001d4284fc2481ffd627f4673f631490ac5562b10c857cc3973bbdaa2d64b', '[\"*\"]', NULL, '2022-12-03 22:34:16', '2022-12-03 22:34:16'),
(41, 'App\\Models\\Admin', 2, 'MyApp', 'a8ce69876394c46aee689cb346113e56d91f3441ce1debe3263c7fcfca833cdc', '[\"*\"]', NULL, '2022-12-03 22:36:19', '2022-12-03 22:36:19'),
(42, 'App\\Models\\Admin', 2, 'MyApp', 'cb3f0144ae005f9b853f03c6bb86af4ced5ef22288f23a4e09e6891f34dbab5b', '[\"*\"]', NULL, '2022-12-03 22:43:43', '2022-12-03 22:43:43'),
(43, 'App\\Models\\Admin', 2, 'MyApp', 'e2d15bd6cfb3bbc8cb8f7373b60824943ae763c2138ba2eca0f31e0068d62200', '[\"*\"]', NULL, '2022-12-03 22:50:39', '2022-12-03 22:50:39'),
(44, 'App\\Models\\Admin', 2, 'MyApp', 'b2f204bee903da67bf2146325ee19842deed27fefd49eb9f46f496ac573dfc1c', '[\"*\"]', NULL, '2022-12-03 22:51:51', '2022-12-03 22:51:51'),
(45, 'App\\Models\\Admin', 2, 'MyApp', 'd206058698673c1c9a2fcd0f69780b9c1f7827ab367125c30aa1f64f901f12b5', '[\"*\"]', NULL, '2022-12-03 22:59:24', '2022-12-03 22:59:24'),
(46, 'App\\Models\\Admin', 2, 'MyApp', 'c4f7a05ef3e7efceb821cf476175b1a12d46669e02244180c6ac14029e187780', '[\"*\"]', NULL, '2022-12-03 23:06:36', '2022-12-03 23:06:36'),
(47, 'App\\Models\\Admin', 2, 'MyApp', '9347c3389e1709833f09dc42ba2a5940366e5a5d956534e797fc5eb00dc9dfa5', '[\"*\"]', NULL, '2022-12-03 23:10:13', '2022-12-03 23:10:13'),
(48, 'App\\Models\\Admin', 2, 'MyApp', '5185885122dd89c3aa27e24891b908e50fb321dd06cb20b1a1a3f0e39317751f', '[\"*\"]', NULL, '2022-12-03 23:12:45', '2022-12-03 23:12:45'),
(49, 'App\\Models\\Admin', 2, 'MyApp', '11e83145526da84efc6b816a59742b271e1650753af53ddd517c8f1ad55f3df2', '[\"*\"]', '2022-12-03 23:54:54', '2022-12-03 23:16:27', '2022-12-03 23:54:54'),
(50, 'App\\Models\\Admin', 2, 'MyApp', '7c76b76f371d07fad8f41733eadd507efa883724793fc2600652f862f7f0a227', '[\"*\"]', NULL, '2022-12-03 23:17:51', '2022-12-03 23:17:51'),
(51, 'App\\Models\\Admin', 2, 'MyApp', '72670c9db38fe8a38cce8598adc12a188e7caa27b2c45c6c86100d87d613fb29', '[\"*\"]', NULL, '2022-12-03 23:20:14', '2022-12-03 23:20:14'),
(52, 'App\\Models\\Admin', 2, 'MyApp', '84eed0193405dd8412345f96e9885a2ecc8c5ebdbe7625cd67fb3bc4fcb7ad28', '[\"*\"]', NULL, '2022-12-03 23:26:31', '2022-12-03 23:26:31'),
(53, 'App\\Models\\Admin', 2, 'MyApp', '460d9409b38c7c50b086bc344abdc3c63df45117aa3eb95a431f98fdbcc3c3fc', '[\"*\"]', NULL, '2022-12-03 23:27:39', '2022-12-03 23:27:39'),
(54, 'App\\Models\\Admin', 2, 'MyApp', 'b708e4efb6ee36774082c9fdcd8cb4bfa711aa849f02aa6e6328f96f7575ce7d', '[\"*\"]', NULL, '2022-12-03 23:33:23', '2022-12-03 23:33:23'),
(55, 'App\\Models\\Admin', 2, 'MyApp', 'e95bf51378d37995085b7db1436924fa353e93dd82547f9aff4a5bc86d149e21', '[\"*\"]', NULL, '2022-12-03 23:34:17', '2022-12-03 23:34:17'),
(56, 'App\\Models\\Admin', 2, 'MyApp', '82aaa00de2e3b873bb3234c81ee75814510964c2d022b8cc75c16a30e147e9d2', '[\"*\"]', NULL, '2022-12-03 23:35:42', '2022-12-03 23:35:42'),
(57, 'App\\Models\\Admin', 2, 'MyApp', 'bd592a47926a917deb0fc31fea39816a36356d7249d462dbcd9a82f52e41864b', '[\"*\"]', NULL, '2022-12-03 23:36:27', '2022-12-03 23:36:27'),
(58, 'App\\Models\\Admin', 2, 'MyApp', '11a9a8c175c4339705da6054a6d04c8daebfc40887fd38076773be77523dd67b', '[\"*\"]', NULL, '2022-12-03 23:37:34', '2022-12-03 23:37:34'),
(59, 'App\\Models\\Admin', 2, 'MyApp', 'b2b9e61e9055d1e15368a718a38406d477793c00b65497057a7270c384cf9f88', '[\"*\"]', NULL, '2022-12-03 23:38:35', '2022-12-03 23:38:35'),
(60, 'App\\Models\\Admin', 2, 'MyApp', '2cce06caddb826da140476dbf997fe70c3309ff0dcd2ad0e84adbc491ff7d783', '[\"*\"]', NULL, '2022-12-03 23:39:27', '2022-12-03 23:39:27'),
(61, 'App\\Models\\Admin', 2, 'MyApp', '4a041134554a2e32008c75dd80c2d74d46812f97d4e4ae5d5ab5d0382880f1e1', '[\"*\"]', NULL, '2022-12-03 23:39:46', '2022-12-03 23:39:46'),
(62, 'App\\Models\\Admin', 2, 'MyApp', '30846bccf58b91e8441db58d15e379010bdfe31fb989b85c337e40b13d1383da', '[\"*\"]', NULL, '2022-12-03 23:41:05', '2022-12-03 23:41:05'),
(63, 'App\\Models\\Admin', 2, 'MyApp', '2d158e56be7466938c7787173e0fcc7ad01f61083899234405113b6a191c821f', '[\"*\"]', NULL, '2022-12-03 23:43:27', '2022-12-03 23:43:27'),
(64, 'App\\Models\\Admin', 2, 'MyApp', '045f328a0a6d3558d99f1513f7e78204ccd6bb7ad4ed64cd5bdf45f6d875bb82', '[\"*\"]', NULL, '2022-12-03 23:54:54', '2022-12-03 23:54:54'),
(65, 'App\\Models\\Admin', 1, 'MyApp', 'd9e8b9d62b9babe2627546722280b0e584479707f5d1f00c786d183b5b026128', '[\"*\"]', NULL, '2022-12-03 23:55:45', '2022-12-03 23:55:45'),
(66, 'App\\Models\\Admin', 2, 'MyApp', '5b03cc76a2e79dc604e3a052a2ae6f77327c6efe6d374f108c95295a553fab06', '[\"*\"]', NULL, '2022-12-03 23:57:19', '2022-12-03 23:57:19'),
(67, 'App\\Models\\Admin', 2, 'MyApp', 'c79ef7e3eb2b68647cd0882d92cd4816a282613303c96bc5721a63b39c71e5b0', '[\"*\"]', NULL, '2022-12-03 23:57:44', '2022-12-03 23:57:44'),
(68, 'App\\Models\\Admin', 2, 'MyApp', '04aa49bcf93116babdd0c1e73c50eec6b112e6c8da9d9ca8c590eb0c74c34fab', '[\"*\"]', NULL, '2022-12-03 23:59:17', '2022-12-03 23:59:17'),
(69, 'App\\Models\\Admin', 2, 'MyApp', '0b53eb40c7bebce251b9720d72c51425cb1e26822fbb4bdcfb322ccb96522b69', '[\"*\"]', NULL, '2022-12-03 23:59:47', '2022-12-03 23:59:47'),
(70, 'App\\Models\\Admin', 2, 'MyApp', '3f9996f49558299f73a9b14d6455d6de9e47794fe55573dafc49fb27ba611267', '[\"*\"]', NULL, '2022-12-04 00:03:38', '2022-12-04 00:03:38'),
(71, 'App\\Models\\Admin', 2, 'MyApp', '4f81474ac3edf0dec5acaf29c5a311f2d05160a8c198a09a962f6cec771b6bde', '[\"*\"]', NULL, '2022-12-04 00:08:28', '2022-12-04 00:08:28'),
(72, 'App\\Models\\Admin', 2, 'MyApp', 'e59981916155806dd30858951aa05e5a2ec49550c93f4be2ce2e59798cffb1fc', '[\"*\"]', NULL, '2022-12-04 00:10:38', '2022-12-04 00:10:38'),
(73, 'App\\Models\\Admin', 2, 'MyApp', '42a93d604795230bb86aad5bd5d040e65250a38ef48ff0760ac481108b5eb966', '[\"*\"]', NULL, '2022-12-04 00:18:18', '2022-12-04 00:18:18'),
(74, 'App\\Models\\Admin', 2, 'MyApp', '62ec802acb3ed12729a3a8a442a66cf6d3b1c1b8a8110e73c88c5e8629829608', '[\"*\"]', NULL, '2022-12-04 00:18:23', '2022-12-04 00:18:23'),
(75, 'App\\Models\\Admin', 2, 'MyApp', '46b64aa61802d4db012c7c3e41e752756743cb9cb0ecf25e55c94b2f0fdd86a5', '[\"*\"]', NULL, '2022-12-04 00:19:20', '2022-12-04 00:19:20'),
(76, 'App\\Models\\Admin', 2, 'MyApp', 'ffe160a3e65d89ec743eadbce1123848f60de018c23b32efffda48f957f1e7a3', '[\"*\"]', NULL, '2022-12-04 00:28:23', '2022-12-04 00:28:23'),
(77, 'App\\Models\\Admin', 2, 'MyApp', 'b6eda1149d7a8a324be852f5ed39351795cd6c94c5ea5e4192b72dcd6504517a', '[\"*\"]', NULL, '2022-12-04 00:29:22', '2022-12-04 00:29:22'),
(78, 'App\\Models\\Admin', 2, 'MyApp', 'a8ba138e2b44ec048277faa942d95a1c317c47c8412e53d1182b3fa64c182399', '[\"*\"]', NULL, '2022-12-04 00:30:56', '2022-12-04 00:30:56'),
(79, 'App\\Models\\Admin', 2, 'MyApp', 'de770ba86f74ee50f06732c7ab697febc15a5596d21014715c98ae1bd6924b72', '[\"*\"]', NULL, '2022-12-04 00:31:44', '2022-12-04 00:31:44'),
(80, 'App\\Models\\Admin', 2, 'MyApp', '754322a15017ae857b2e02c5713116e722f2f50b02139a0477e9881f6c4ff121', '[\"*\"]', NULL, '2022-12-04 00:33:16', '2022-12-04 00:33:16'),
(81, 'App\\Models\\Admin', 2, 'MyApp', '4efeb7787bdd9b7ad950069acaf37930b08687914330f37c5420f2977cf6d8cf', '[\"*\"]', NULL, '2022-12-04 00:33:50', '2022-12-04 00:33:50'),
(82, 'App\\Models\\Admin', 2, 'MyApp', '7913d070abdf6e95e32e48017de38865b1b517d66695e5764e8542c4f9c936d4', '[\"*\"]', NULL, '2022-12-04 00:34:43', '2022-12-04 00:34:43'),
(83, 'App\\Models\\Admin', 2, 'MyApp', 'd65698771fade48abe268d72d95508cd11140d307a20f040e28c9f5061cc0e23', '[\"*\"]', NULL, '2022-12-04 00:35:12', '2022-12-04 00:35:12'),
(84, 'App\\Models\\Admin', 2, 'MyApp', '84b67bd97b57e97297fded4c21fbe5ed66d469f648f1c4fcb5b338a8ed302886', '[\"*\"]', NULL, '2022-12-04 01:04:02', '2022-12-04 01:04:02'),
(85, 'App\\Models\\Admin', 2, 'MyApp', '1348e630d9abcd28a7d754374e103850aae1c38d2451ab252df8e163fafe4ab0', '[\"*\"]', NULL, '2022-12-04 01:04:59', '2022-12-04 01:04:59'),
(86, 'App\\Models\\Admin', 2, 'MyApp', 'c2e4eaa48639c34cc5c42e0eb64b267f16a91db1b199793dcda416172afab23b', '[\"*\"]', NULL, '2022-12-04 01:05:05', '2022-12-04 01:05:05'),
(87, 'App\\Models\\Admin', 2, 'MyApp', 'fb661634304b7dac3aac0f2bb0303959df19a88c8db0338459530c7b5242486f', '[\"*\"]', NULL, '2022-12-04 01:06:27', '2022-12-04 01:06:27'),
(88, 'App\\Models\\Admin', 2, 'MyApp', 'd6b2b72833e24080d799f1a8e026a23ee3c5bfa174696b62516a29bfa3f5979a', '[\"*\"]', NULL, '2022-12-04 13:10:46', '2022-12-04 13:10:46'),
(89, 'App\\Models\\Admin', 2, 'MyApp', '1b1b620701781707fc4e91206cea1a5a1c4fa542098cec64510db202dcc220cc', '[\"*\"]', '2022-12-04 13:15:10', '2022-12-04 13:11:55', '2022-12-04 13:15:10'),
(90, 'App\\Models\\Admin', 2, 'MyApp', '441fb090702db4b476369a94792c4ed3146ac7bd3c1603c8b5c4d627abb2f0a9', '[\"*\"]', NULL, '2022-12-04 13:24:49', '2022-12-04 13:24:49'),
(91, 'App\\Models\\Admin', 2, 'MyApp', '13fc6305b6b6d3ffe0dd96c2d7e90b3ae11e99ce835d3427e08e72478736b399', '[\"*\"]', NULL, '2022-12-04 15:13:35', '2022-12-04 15:13:35'),
(92, 'App\\Models\\Admin', 2, 'MyApp', 'f5e255480129c44dfcf9fc3ecc87e7367e8a581505c7521172d4112f32587ece', '[\"*\"]', NULL, '2022-12-04 15:14:36', '2022-12-04 15:14:36'),
(93, 'App\\Models\\Admin', 2, 'MyApp', '8cfe84ef39fdc4729fae8dae132c691e0eef5bee7267d6de7e00e36a935b50bb', '[\"*\"]', NULL, '2022-12-04 15:15:51', '2022-12-04 15:15:51'),
(94, 'App\\Models\\Admin', 2, 'MyApp', '7a68ceab617207df78b2a3d9d2c4b754825379ccccdd19e7761ff9aff6aba6c4', '[\"*\"]', NULL, '2022-12-06 19:06:57', '2022-12-06 19:06:57'),
(95, 'App\\Models\\Admin', 2, 'MyApp', '2ce63b8569ecb0aef0de239b6f858a07941f25479b3c18c7b36bae08e57b5151', '[\"*\"]', NULL, '2022-12-11 11:14:20', '2022-12-11 11:14:20'),
(96, 'App\\Models\\Admin', 2, 'MyApp', 'd991e8690e3474ce34d4ca56b94a55ea1b5d03391f9ac17062aee8dad7ec2cbc', '[\"*\"]', NULL, '2022-12-11 11:26:29', '2022-12-11 11:26:29'),
(97, 'App\\Models\\Admin', 2, 'MyApp', '17905920025eacf3eea50ef68d589e6386e63addf5934d347976447fd13592cc', '[\"*\"]', '2022-12-12 05:52:18', '2022-12-12 00:28:31', '2022-12-12 05:52:18'),
(98, 'App\\Models\\Admin', 2, 'MyApp', 'ef723d46fb07c57d14202074b3af74e7f72008659ddbf7d245e2ad31b564da82', '[\"*\"]', '2022-12-12 14:20:23', '2022-12-12 14:20:13', '2022-12-12 14:20:23'),
(99, 'App\\Models\\Admin', 2, 'MyApp', 'a9643d908ccf2d4ddd600052f1c156ca5a67a73d6fac67e519707154b5b70f74', '[\"*\"]', '2022-12-12 22:16:50', '2022-12-12 16:15:33', '2022-12-12 22:16:50'),
(100, 'App\\Models\\User', 2, 'MyApp', '32719c313b165ee222a5ba4ac8f2a543e68762cb2a270a34936111035e0f432a', '[\"*\"]', NULL, '2022-12-28 21:36:26', '2022-12-28 21:36:26'),
(101, 'App\\Models\\User', 2, 'MyApp', 'a87706b847299ccb30372178596bcf7786b65454f34fad4fbe958a03d09bb9f7', '[\"*\"]', NULL, '2022-12-28 21:40:31', '2022-12-28 21:40:31'),
(102, 'App\\Models\\User', 2, 'MyApp', 'ca961270eecb2869a3ab14e79129631c8502ade6730355efb75f4e58137902b2', '[\"*\"]', NULL, '2022-12-28 22:04:58', '2022-12-28 22:04:58'),
(104, 'App\\Models\\Admin', 2, 'MyApp', 'fc195bde357c3d9e7b86de454c9c48802255daa7ea0d61d31cd2fe7f96b1e003', '[\"*\"]', '2023-01-22 12:57:53', '2022-12-29 21:25:45', '2023-01-22 12:57:53'),
(105, 'App\\Models\\Admin', 2, 'MyApp', 'e692bf0741aa2426844437e1e3ab22550518e1cf4bcf8f1af9175540505f5adb', '[\"*\"]', '2023-01-03 09:40:14', '2023-01-01 09:17:22', '2023-01-03 09:40:14'),
(108, 'App\\Models\\Admin', 2, 'MyApp', '2fa75a3844dec4922d2ddd7546550eadf766e8fa59894dab9f623428bd0bd985', '[\"*\"]', '2023-01-03 10:14:51', '2023-01-03 08:42:08', '2023-01-03 10:14:51'),
(109, 'App\\Models\\Admin', 2, 'MyApp', 'a93ff1b24cfbc678b8f043f3292a05e6aafe1e6e19a2f2a30a64cac3a26a0812', '[\"*\"]', NULL, '2023-01-03 09:20:59', '2023-01-03 09:20:59'),
(110, 'App\\Models\\Admin', 2, 'MyApp', '350d1d41a2c302d00065c5232a0adb13616ca8a8bfa9f6695de66d3aa0c9bf89', '[\"*\"]', '2023-01-03 16:10:09', '2023-01-03 14:53:10', '2023-01-03 16:10:09'),
(111, 'App\\Models\\Admin', 2, 'MyApp', 'd2edc174236c0fd12e8a036e926f27b68898515791c5d3e23deff99e1b505ead', '[\"*\"]', NULL, '2023-01-03 15:58:17', '2023-01-03 15:58:17'),
(112, 'App\\Models\\Admin', 2, 'MyApp', '5003ee60d3cc81019170ab425cb4b1c6a36f41a0c7b92db2373e7422ebdacd4c', '[\"*\"]', NULL, '2023-01-03 15:58:19', '2023-01-03 15:58:19'),
(113, 'App\\Models\\Admin', 2, 'MyApp', '9e7b7b7f4425b4cde5e7ca3a0fbe700d4ac5626d62868981e5946fc787856709', '[\"*\"]', '2023-01-03 16:08:53', '2023-01-03 16:01:26', '2023-01-03 16:08:53'),
(114, 'App\\Models\\Admin', 2, 'MyApp', '232478fdc75976fc57a959a1c000834615f914688eb6076288dc752e99943191', '[\"*\"]', '2023-01-03 16:15:12', '2023-01-03 16:08:47', '2023-01-03 16:15:12'),
(115, 'App\\Models\\Admin', 2, 'MyApp', '28129e36540cfe281b6954e2a02fab3786445cbd4f3045120a1cfa0ed270b770', '[\"*\"]', NULL, '2023-01-03 16:15:05', '2023-01-03 16:15:05'),
(116, 'App\\Models\\Admin', 2, 'MyApp', '5ab5aaf972df75261162d3ae93e4355836960ddfbedba467da86e058236663e6', '[\"*\"]', NULL, '2023-01-03 22:23:05', '2023-01-03 22:23:05'),
(117, 'App\\Models\\Admin', 2, 'MyApp', '4f311db8e03cb28fdd39746e0cbb8aec3a69d14d4719e346b5e9291174dd2b0c', '[\"*\"]', NULL, '2023-01-03 22:30:58', '2023-01-03 22:30:58'),
(118, 'App\\Models\\Admin', 2, 'MyApp', '3f8ffa04fb70a6b91ac3c5792d85142f5cd3563e8db32e7c1abcc4367bf4f6db', '[\"*\"]', NULL, '2023-01-03 23:19:30', '2023-01-03 23:19:30'),
(119, 'App\\Models\\Admin', 2, 'MyApp', '6a711cfa57dbba24722ae8d8c72092e616068fcd86433abe5e09ff334b053ed0', '[\"*\"]', NULL, '2023-01-19 22:01:22', '2023-01-19 22:01:22'),
(120, 'App\\Models\\Admin', 2, 'MyApp', '9a3272ea0ee1bde8ca310d379afbcfd4918f10d032c34ccef0cf267dff040afc', '[\"*\"]', NULL, '2023-01-19 22:11:36', '2023-01-19 22:11:36'),
(121, 'App\\Models\\Admin', 2, 'MyApp', 'aa0c0c1ed7d81f826eba0ee87443c9aec63252f44f112d6a9b05e23a1a13d134', '[\"*\"]', NULL, '2023-01-20 21:02:00', '2023-01-20 21:02:00'),
(122, 'App\\Models\\Admin', 2, 'MyApp', '06728345c6c61c29cb41cec2dd4a50fe9027603bd2dbaa7c0801b775a35fc93e', '[\"*\"]', NULL, '2023-01-20 21:13:56', '2023-01-20 21:13:56'),
(123, 'App\\Models\\Admin', 2, 'MyApp', '8e60c87a6771f93e35ad755e2ef667b8b17b10fa0926ca5062667859f2c75b59', '[\"*\"]', NULL, '2023-01-21 17:02:22', '2023-01-21 17:02:22'),
(124, 'App\\Models\\Admin', 2, 'MyApp', '9d204b79ce3cb43bd19eeae1a1f57fbc9bf0659d7999bc3b18fd2c9f74b466a8', '[\"*\"]', NULL, '2023-01-21 17:28:36', '2023-01-21 17:28:36'),
(125, 'App\\Models\\Admin', 2, 'MyApp', 'da5af595868ceffcb7fe82a589ceb3f287bb88b0735e9d0223447358bd53073a', '[\"*\"]', '2023-01-21 18:48:09', '2023-01-21 17:29:31', '2023-01-21 18:48:09'),
(126, 'App\\Models\\Admin', 2, 'MyApp', 'a40c650df212b85290515b8a5718aaef2064cd269ba2baaea54066d384d9cf13', '[\"*\"]', '2023-01-21 18:55:07', '2023-01-21 17:40:38', '2023-01-21 18:55:07'),
(127, 'App\\Models\\Admin', 2, 'MyApp', '6b68e6ddcda70ddeeae002cef4e18ce1f90619a597bcc54dd20a336638c6fefa', '[\"*\"]', '2023-01-21 19:03:57', '2023-01-21 18:51:41', '2023-01-21 19:03:57'),
(128, 'App\\Models\\Admin', 2, 'MyApp', '3c63c4755fc731e56ed76ce9b99e11df2bfa30fddb90e2241dedb31de76f50bc', '[\"*\"]', NULL, '2023-01-21 18:56:03', '2023-01-21 18:56:03'),
(129, 'App\\Models\\Admin', 2, 'MyApp', '1b086c4dd0ca722057fa7cea2265ae451f937c2b7871f418ec10c28622595f46', '[\"*\"]', NULL, '2023-01-22 07:22:16', '2023-01-22 07:22:16'),
(130, 'App\\Models\\Admin', 2, 'MyApp', '193b32bcd9b8fcf2eb3348bca04ff2bf82df1cad95325ca95f2c6368174e0962', '[\"*\"]', NULL, '2023-01-22 16:29:02', '2023-01-22 16:29:02'),
(131, 'App\\Models\\Admin', 2, 'MyApp', 'a1496ca79fd2c74537a111ded00e9a1deaf53c043c0cf661362979f40406edb9', '[\"*\"]', NULL, '2023-01-22 18:12:17', '2023-01-22 18:12:17'),
(132, 'App\\Models\\Admin', 2, 'MyApp', '4b686c4b8b75d99a173010be5c9b29220ea8db1080b25be63cd6822fcb0c5451', '[\"*\"]', NULL, '2023-01-22 18:13:21', '2023-01-22 18:13:21'),
(133, 'App\\Models\\Admin', 2, 'MyApp', '2d7408e1db4ea01f0b268dc4a8a2a51d163e8eb5412ea77101f8798c22726ecd', '[\"*\"]', NULL, '2023-01-22 18:13:35', '2023-01-22 18:13:35'),
(134, 'App\\Models\\Admin', 2, 'MyApp', '73915326c51ef72a6d2e92720193f5f2358b280a342c7f6e2df81edc54403a17', '[\"*\"]', '2023-03-04 19:55:46', '2023-01-22 18:21:08', '2023-03-04 19:55:46'),
(135, 'App\\Models\\Admin', 2, 'MyApp', 'd3696b89c2aa2e83d9d116991de677e455b6697e29f96405ccb313162d803d48', '[\"*\"]', NULL, '2023-01-22 18:29:10', '2023-01-22 18:29:10'),
(136, 'App\\Models\\Admin', 2, 'MyApp', '991b276dcdce45cb8b4e66676d05d81469b260d65a080152a5816c96e5894cde', '[\"*\"]', NULL, '2023-01-23 19:58:58', '2023-01-23 19:58:58'),
(137, 'App\\Models\\Admin', 2, 'MyApp', 'f82f4c7dcdcd51b7fb20f857ce5c4b37328ed74bb5ea3f235caa260b8e5d9656', '[\"*\"]', NULL, '2023-01-23 19:59:00', '2023-01-23 19:59:00'),
(138, 'App\\Models\\Admin', 2, 'MyApp', 'ad8dab5532837267d2819aa5175e7967670646a8e58e60cbf065331812f346e6', '[\"*\"]', NULL, '2023-01-23 19:59:00', '2023-01-23 19:59:00'),
(139, 'App\\Models\\Admin', 2, 'MyApp', 'aa05e76a964dc415f9f296c8372acd5b85f00efe122d01ff2acf69ee220be5f4', '[\"*\"]', '2023-01-24 22:17:28', '2023-01-24 20:32:21', '2023-01-24 22:17:28'),
(140, 'App\\Models\\Admin', 2, 'MyApp', '1b847c9244ca1478e0c5c4ccdcfdc4a19fa70b8a624d474664fcaa7dee299dec', '[\"*\"]', NULL, '2023-01-24 20:34:38', '2023-01-24 20:34:38'),
(141, 'App\\Models\\Admin', 2, 'MyApp', '41499f980d31fe0c87cd055573c5760ebd82b90c3fb941f2650b0357608a9176', '[\"*\"]', '2023-01-24 22:18:38', '2023-01-24 22:10:43', '2023-01-24 22:18:38'),
(142, 'App\\Models\\Admin', 2, 'MyApp', '3dc7b669b0767c6106fdb9602fb569011275cef19b5ffc583b7eda1fa3a9d160', '[\"*\"]', '2023-01-24 22:21:53', '2023-01-24 22:18:19', '2023-01-24 22:21:53'),
(143, 'App\\Models\\Admin', 2, 'MyApp', 'c1aef9f4f8c9ab699952a718a60c8242d5b04e2909b0137f838b386ea9d495e8', '[\"*\"]', '2023-01-24 22:27:18', '2023-01-24 22:19:17', '2023-01-24 22:27:18'),
(144, 'App\\Models\\Admin', 2, 'MyApp', '065ad7a9a6692e6b4da5534f254f094b938bf25672f28ba377d281cec13d7a18', '[\"*\"]', '2023-01-24 22:29:05', '2023-01-24 22:22:16', '2023-01-24 22:29:05'),
(145, 'App\\Models\\Admin', 2, 'MyApp', '9f62f95f20c062cda44f951c452707befb1a4cdc0a7193ef0162c845e571a17e', '[\"*\"]', '2023-01-24 22:29:36', '2023-01-24 22:27:54', '2023-01-24 22:29:36'),
(146, 'App\\Models\\Admin', 2, 'MyApp', '29745732adada960255ae57a518d273ac84f6e354441f71ff13200a9b5e72c67', '[\"*\"]', '2023-01-25 17:01:20', '2023-01-24 22:29:35', '2023-01-25 17:01:20'),
(147, 'App\\Models\\Admin', 2, 'MyApp', '0061683fce8f27896a591c1c8baf977ce9571c85686d133a438e337d969561e8', '[\"*\"]', NULL, '2023-01-25 16:13:06', '2023-01-25 16:13:06'),
(148, 'App\\Models\\Admin', 2, 'MyApp', '1502a58548a748b9edc62c2d68266f300d6ff75ae2d2f33e39fc41a417047bb9', '[\"*\"]', NULL, '2023-01-25 17:11:42', '2023-01-25 17:11:42'),
(149, 'App\\Models\\Admin', 2, 'MyApp', '6ea4982690fb5e51216dc141ee6e43aed0d628e172f770dc5b0ee070efbf13c8', '[\"*\"]', NULL, '2023-01-25 17:23:30', '2023-01-25 17:23:30'),
(150, 'App\\Models\\Admin', 2, 'MyApp', '4a387176735f9fcbc96e311d6fb7e8ecf19b4f380612250fe8ab37bb30fa6c91', '[\"*\"]', NULL, '2023-01-25 17:35:22', '2023-01-25 17:35:22'),
(151, 'App\\Models\\Admin', 2, 'MyApp', '44677d3693e1b8d15506c247b4486f6c76378864ec5a9fa9af317e67eb05b4e5', '[\"*\"]', '2023-01-25 17:53:20', '2023-01-25 17:39:19', '2023-01-25 17:53:20'),
(152, 'App\\Models\\Admin', 2, 'MyApp', '6843252649b69e7a0c1a33f13dd701fc27ab4885ca78a11215d90c276ba45c76', '[\"*\"]', '2023-01-25 17:53:47', '2023-01-25 17:53:19', '2023-01-25 17:53:47'),
(153, 'App\\Models\\Admin', 2, 'MyApp', '70916b9e9fe3b6623844449ce73b0d6c2b59b4f5d3ff22ccd3e3c08326ec4d13', '[\"*\"]', '2023-01-25 19:33:09', '2023-01-25 17:53:46', '2023-01-25 19:33:09'),
(154, 'App\\Models\\Admin', 2, 'MyApp', 'afb58922a1376897fc06c452403457d89ed303f831708d24f1d90bca487ac065', '[\"*\"]', NULL, '2023-01-25 19:33:07', '2023-01-25 19:33:07'),
(155, 'App\\Models\\Admin', 2, 'MyApp', '11d91f0d0d38dc3752081bcd5b7183f9fa5545922b8a39a71d83ac40519a7d9e', '[\"*\"]', '2023-01-25 19:34:07', '2023-01-25 19:33:08', '2023-01-25 19:34:07'),
(156, 'App\\Models\\Admin', 2, 'MyApp', '4384f2729e034336bdfd8c70549ffa0f4a2d97dc80c987d45a9634e48d8f6539', '[\"*\"]', '2023-01-25 19:54:56', '2023-01-25 19:34:06', '2023-01-25 19:54:56'),
(157, 'App\\Models\\Admin', 2, 'MyApp', '11caf9987da2afe336998a4335e62ae11abc902688276cd1f524a62543d3abd5', '[\"*\"]', NULL, '2023-01-25 19:35:59', '2023-01-25 19:35:59'),
(158, 'App\\Models\\Admin', 2, 'MyApp', 'd1eb3a537bd89abc08caa0d42c09078f52e4cdf537c836ec5cc1d0c72bb297c4', '[\"*\"]', '2023-01-25 19:57:49', '2023-01-25 19:55:48', '2023-01-25 19:57:49'),
(159, 'App\\Models\\Admin', 2, 'MyApp', '963904d03ee9f9be9c8ab534a1a3869afa389cfe98560c24bd49d8dc5032bb13', '[\"*\"]', '2023-01-25 19:59:57', '2023-01-25 19:57:48', '2023-01-25 19:59:57'),
(160, 'App\\Models\\Admin', 2, 'MyApp', '4f526fef81015ce2957eeca36c51e9585e813ac48ffa36672b42963b947ddbbe', '[\"*\"]', '2023-01-25 20:07:18', '2023-01-25 19:59:55', '2023-01-25 20:07:18'),
(161, 'App\\Models\\Admin', 2, 'MyApp', 'df47ecbd824dec0451b098aa575a25df67c2318874fa921dad67cf97ad09bbfd', '[\"*\"]', '2023-01-25 20:11:11', '2023-01-25 20:07:17', '2023-01-25 20:11:11'),
(162, 'App\\Models\\Admin', 2, 'MyApp', 'b640fa46eeb0959934f36db0a5a326d9c308c7e1c718053263514ac3eefb1bd0', '[\"*\"]', '2023-01-25 20:12:18', '2023-01-25 20:11:10', '2023-01-25 20:12:18'),
(163, 'App\\Models\\Admin', 2, 'MyApp', '45a27afeb25c5632e1e9756913dd09e1ab918198db744349f852e24f14c1a508', '[\"*\"]', '2023-01-25 20:16:39', '2023-01-25 20:12:17', '2023-01-25 20:16:39'),
(164, 'App\\Models\\Admin', 2, 'MyApp', 'b8a11044069d493a34c4fa455df4beeba814e84cdbc8b40247d035cb54b1492e', '[\"*\"]', '2023-01-25 20:24:03', '2023-01-25 20:16:38', '2023-01-25 20:24:03'),
(165, 'App\\Models\\Admin', 2, 'MyApp', 'dd13d9d50c509c7a595aee28943f7aa5afceeda979f5bf79e2580dd169c6d979', '[\"*\"]', '2023-01-25 20:26:17', '2023-01-25 20:24:02', '2023-01-25 20:26:17'),
(166, 'App\\Models\\Admin', 2, 'MyApp', '7d4080b2badea2adc8616d9f2f3ea18709a4c6f073d1f7ef87247a2e5eb02500', '[\"*\"]', '2023-01-25 20:27:00', '2023-01-25 20:26:16', '2023-01-25 20:27:00'),
(167, 'App\\Models\\Admin', 2, 'MyApp', '581f0434e8bc7d607176c4f3c7b1450163c0590ebab0b55f1024cc410b39d31d', '[\"*\"]', '2023-01-25 20:32:18', '2023-01-25 20:27:00', '2023-01-25 20:32:18'),
(168, 'App\\Models\\Admin', 2, 'MyApp', '60a10397d573fec964714c687e356c7e68d271d94d3005cace0ba6b14e4915b4', '[\"*\"]', '2023-01-25 20:33:11', '2023-01-25 20:32:17', '2023-01-25 20:33:11'),
(169, 'App\\Models\\Admin', 2, 'MyApp', '012a053442b09bb0b4da5a546f07e3c05c39e14389ce1fd899b9acab65badc32', '[\"*\"]', '2023-01-25 20:43:37', '2023-01-25 20:33:10', '2023-01-25 20:43:37'),
(170, 'App\\Models\\Admin', 2, 'MyApp', 'ababd16948e172b9e7d6781982b97e7a190a9e8eb90cf5df018f7dd774f0c560', '[\"*\"]', '2023-01-25 20:44:02', '2023-01-25 20:42:58', '2023-01-25 20:44:02'),
(171, 'App\\Models\\Admin', 2, 'MyApp', '0b9761bd1ac4f82b5641734b0907215aa8cd0be9c71fde2817d39848fc23c8a7', '[\"*\"]', '2023-01-25 20:45:00', '2023-01-25 20:44:01', '2023-01-25 20:45:00'),
(172, 'App\\Models\\Admin', 2, 'MyApp', 'de67c9bb19873e4152ae5707a3c14e6e9eecbcce76517ab438b40f246650a02e', '[\"*\"]', '2023-01-25 20:45:21', '2023-01-25 20:44:46', '2023-01-25 20:45:21'),
(173, 'App\\Models\\Admin', 2, 'MyApp', '89ec6339d3a5de8e6f8657cfe04820914d0fd3bb86a3473a82758f7f1207eac3', '[\"*\"]', '2023-01-25 20:47:14', '2023-01-25 20:45:20', '2023-01-25 20:47:14'),
(174, 'App\\Models\\Admin', 2, 'MyApp', 'ba5a96344ed9e3de51707354aebbe22deffe2093c494ce010a95a1ea7237c408', '[\"*\"]', NULL, '2023-01-25 20:47:13', '2023-01-25 20:47:13'),
(175, 'App\\Models\\Admin', 2, 'MyApp', 'cebdbb0eb1448a4595b0d083f68622bfa352f15d4ad0f73d199ce753d8dc1d23', '[\"*\"]', '2023-01-25 20:54:15', '2023-01-25 20:52:44', '2023-01-25 20:54:15'),
(176, 'App\\Models\\Admin', 2, 'MyApp', 'ae15e7f3685318b52ae1bbb3b40967ce634f6ca569090f040d7dbfaf8aa36629', '[\"*\"]', '2023-01-25 21:00:03', '2023-01-25 20:54:14', '2023-01-25 21:00:03'),
(177, 'App\\Models\\Admin', 2, 'MyApp', '29745e716bb6cdb27db3f91764138b2c9cba139d4430b70baeb541c144bdc53e', '[\"*\"]', '2023-01-25 21:56:06', '2023-01-25 21:00:02', '2023-01-25 21:56:06'),
(178, 'App\\Models\\Admin', 2, 'MyApp', 'ed185777ab8ca9118222a95dcee4748c66f1292bb620c66cca65fbe6c57bf7a8', '[\"*\"]', '2023-01-25 22:11:31', '2023-01-25 21:02:11', '2023-01-25 22:11:31'),
(179, 'App\\Models\\Admin', 2, 'MyApp', '737ad8edcf3092e35b166ed4ef2c89e3d12673508ab1a71111927f33e3532e23', '[\"*\"]', '2023-01-26 07:04:23', '2023-01-25 22:11:30', '2023-01-26 07:04:23'),
(180, 'App\\Models\\Admin', 1, 'MyApp', 'c98306215b8fff262c399172a9c9813b4d18d53ac694f6680c14e6ffdee839fa', '[\"*\"]', NULL, '2023-01-25 22:44:11', '2023-01-25 22:44:11'),
(181, 'App\\Models\\Admin', 2, 'MyApp', '938adf14ba64cbf6ca85507a9da05de0ba26ec7165fd4a8125f4e8463814a609', '[\"*\"]', NULL, '2023-01-26 07:04:21', '2023-01-26 07:04:21'),
(182, 'App\\Models\\Admin', 2, 'MyApp', '591a3ce4b7fef68c841936075dde5782515420896c5d5e18fe0fe31a2654191f', '[\"*\"]', '2023-01-26 07:06:25', '2023-01-26 07:04:22', '2023-01-26 07:06:25'),
(183, 'App\\Models\\Admin', 2, 'MyApp', '6f107f0425b31eafe7a0b950a1938519c0582818fac9e6bc6a38b7ab83aa63ec', '[\"*\"]', '2023-01-26 07:07:32', '2023-01-26 07:06:23', '2023-01-26 07:07:32'),
(184, 'App\\Models\\Admin', 2, 'MyApp', '4fccc086b22f3aee57a4e85f49dbffbb2f37f6952b65436170218a28f0e81979', '[\"*\"]', '2023-01-26 07:08:54', '2023-01-26 07:07:31', '2023-01-26 07:08:54'),
(185, 'App\\Models\\Admin', 2, 'MyApp', 'c4ea7bc355cf6724bd783aaadf089669af9109d6c0c9cb19f88369def5a6ffff', '[\"*\"]', '2023-01-26 07:09:37', '2023-01-26 07:08:53', '2023-01-26 07:09:37'),
(186, 'App\\Models\\Admin', 2, 'MyApp', '7140bfbd98266d6b84d5499ba97290f92260b3ca7b987f49f80c556757e85cd8', '[\"*\"]', '2023-01-26 07:12:25', '2023-01-26 07:09:36', '2023-01-26 07:12:25'),
(187, 'App\\Models\\Admin', 2, 'MyApp', '973afa0973477ea93eb872bdb1244d0763551f8e9f0a6ef264a9267d149fee6e', '[\"*\"]', '2023-01-26 15:32:51', '2023-01-26 07:12:25', '2023-01-26 15:32:51'),
(188, 'App\\Models\\Admin', 2, 'MyApp', 'd42aa0936b3fe9543686feae091c73db44fc89f19ed4b0e7aae4adde213d7538', '[\"*\"]', NULL, '2023-01-26 08:40:05', '2023-01-26 08:40:05'),
(189, 'App\\Models\\Admin', 2, 'MyApp', '103bb86d4eae4e62e54422f237030f00e565959d144a5c6ae4713c0cb22c5c0a', '[\"*\"]', NULL, '2023-01-26 14:56:45', '2023-01-26 14:56:45'),
(190, 'App\\Models\\Admin', 2, 'MyApp', '3885d9a58e88e98da4493474109c9cbe4dce3427d8fa875e35f87ccdc1e16242', '[\"*\"]', NULL, '2023-01-26 15:25:17', '2023-01-26 15:25:17'),
(191, 'App\\Models\\Admin', 2, 'MyApp', '26b012c7cffc360ad9559767c0f9aa6a34fc85e187a43c3bcc6071b79b0cf08f', '[\"*\"]', '2023-01-29 22:24:33', '2023-01-26 15:32:50', '2023-01-29 22:24:33'),
(192, 'App\\Models\\Admin', 2, 'MyApp', '401327733d0c87fb615399e4ec32ed98968d9639277829d0235dd121747421ec', '[\"*\"]', NULL, '2023-01-29 22:24:31', '2023-01-29 22:24:31'),
(193, 'App\\Models\\Admin', 2, 'MyApp', 'c2f43e772fcc39e6f66ef93a85452ef80663e05da2191b76fee08be3281b16af', '[\"*\"]', NULL, '2023-01-29 22:24:32', '2023-01-29 22:24:32'),
(194, 'App\\Models\\Admin', 2, 'MyApp', '0fd030c99f90130c448eaf59c0cc2fc26aeb5ea1731bcf64f8baff40753e2a14', '[\"*\"]', '2023-01-30 21:05:17', '2023-01-29 22:24:32', '2023-01-30 21:05:17'),
(195, 'App\\Models\\Admin', 2, 'MyApp', '99af16fa469f351edd6e021258af4e04089af88847744ae6a049a2e56495bfff', '[\"*\"]', NULL, '2023-01-30 18:06:41', '2023-01-30 18:06:41'),
(196, 'App\\Models\\Admin', 2, 'MyApp', '65ab3389156031f50681ef598cac721499b5646f8f8cb935ce58342b832f458d', '[\"*\"]', '2023-01-30 21:12:54', '2023-01-30 18:06:42', '2023-01-30 21:12:54'),
(197, 'App\\Models\\Admin', 2, 'MyApp', '1a2008873b28aa95cfe68e4fe064c56230992e4bdfa3f5cb624b5637b3092005', '[\"*\"]', '2023-01-30 21:36:32', '2023-01-30 21:09:35', '2023-01-30 21:36:32'),
(198, 'App\\Models\\Admin', 2, 'MyApp', 'f98b302642589b1007b6a86662d4ea540db6d892a9e3384de5362a3fa5bd770c', '[\"*\"]', '2023-01-30 22:24:41', '2023-01-30 21:27:06', '2023-01-30 22:24:41'),
(199, 'App\\Models\\Admin', 2, 'MyApp', '44d66a272e47719767c8507b0baccc0039f100040e9f2ec3e8fabead5c997ecf', '[\"*\"]', NULL, '2023-01-30 21:52:59', '2023-01-30 21:52:59'),
(200, 'App\\Models\\Admin', 2, 'MyApp', '649f027079e7d822ed878d89c5863c1ba47c7f04312adf0acd323bb1bf20fea6', '[\"*\"]', '2023-01-30 22:26:24', '2023-01-30 22:24:41', '2023-01-30 22:26:24'),
(201, 'App\\Models\\Admin', 2, 'MyApp', '662fa4e51a8173a51f7f90aad40617ea9a928827116803b5e82d36e79935adc4', '[\"*\"]', '2023-01-31 15:17:26', '2023-01-30 22:25:34', '2023-01-31 15:17:26'),
(202, 'App\\Models\\Admin', 2, 'MyApp', '83a0c62e339a561816c3725d7b953537964f7d75bca6bcf71b8e02fb174056f7', '[\"*\"]', '2023-01-31 15:20:00', '2023-01-30 23:40:54', '2023-01-31 15:20:00'),
(203, 'App\\Models\\Admin', 2, 'MyApp', 'c4e255eb4a1d9dd3262365d8310ed3cb306148e9ff3c2b67a8da13b198666453', '[\"*\"]', '2023-01-31 15:39:18', '2023-01-31 15:19:49', '2023-01-31 15:39:18'),
(204, 'App\\Models\\Admin', 2, 'MyApp', 'e23027502e1d2fb149ec8084c7af6a86a720ce9fa25d82f501b297aa28d436a7', '[\"*\"]', '2023-01-31 16:09:33', '2023-01-31 15:23:42', '2023-01-31 16:09:33'),
(205, 'App\\Models\\Admin', 2, 'MyApp', '030fa6db44ca5fc3ba28aa543642bec09bc4de44f0f5d5ca35b7972f3c11cdb9', '[\"*\"]', NULL, '2023-01-31 16:09:31', '2023-01-31 16:09:31'),
(206, 'App\\Models\\Admin', 2, 'MyApp', 'ca02ec68357805a3db5ca2ab14e4e94e8baee7cd511ecab1c60f06efe798ef45', '[\"*\"]', '2023-01-31 23:11:14', '2023-01-31 21:59:12', '2023-01-31 23:11:14'),
(207, 'App\\Models\\Admin', 2, 'MyApp', 'c16d2380f11608e8d01832656d0220a4ef4e17fdaa1810ee5dc4dc27c5b71aef', '[\"*\"]', NULL, '2023-01-31 22:00:12', '2023-01-31 22:00:12'),
(208, 'App\\Models\\Admin', 2, 'MyApp', '06602f1617793f5de0e95fc53a0b97650ce494515d6f1c3457132124a6e82c1e', '[\"*\"]', '2023-02-01 17:18:12', '2023-01-31 23:11:13', '2023-02-01 17:18:12'),
(209, 'App\\Models\\Admin', 2, 'MyApp', '887bfc9b7f1b6d0a8b99cd922919150f896a3d738914d4ef26e51ddbf8ba5d17', '[\"*\"]', '2023-02-01 17:31:00', '2023-02-01 17:18:11', '2023-02-01 17:31:00'),
(210, 'App\\Models\\Admin', 2, 'MyApp', 'd039b0f7df7502e36f989be7fad22f483c5b74ef7c537db34dd17f8e3ccf2b46', '[\"*\"]', '2023-02-01 22:54:47', '2023-02-01 17:30:56', '2023-02-01 22:54:47'),
(211, 'App\\Models\\Admin', 2, 'MyApp', 'a17ceeb8160c0c14e75e2ae12b949ae22b84541b133515c53e4027a5a3f5fc43', '[\"*\"]', '2023-02-03 22:06:23', '2023-02-01 17:34:42', '2023-02-03 22:06:23'),
(212, 'App\\Models\\Admin', 2, 'MyApp', '4a04743c12f5e21ab718622c6d076036ce6956b94168ece623debf2f8f39e466', '[\"*\"]', NULL, '2023-02-02 17:57:16', '2023-02-02 17:57:16'),
(213, 'App\\Models\\Admin', 2, 'MyApp', '05fdeb8c92be9f8f972d968cf2079d779d5fed7b5e5b555cc05295f022a9dc18', '[\"*\"]', '2023-02-03 22:56:24', '2023-02-02 17:57:17', '2023-02-03 22:56:24'),
(214, 'App\\Models\\Admin', 2, 'MyApp', 'b4bc5e3d5a5967aea1b1d633d9fbc20c55ab3df41c33ffc57391f13a9d7807b1', '[\"*\"]', '2023-02-03 23:00:12', '2023-02-03 22:56:17', '2023-02-03 23:00:12'),
(215, 'App\\Models\\Admin', 2, 'MyApp', '0310248cd4e48c316e829bff21b8f966c0ab1ed4a5a12979b4ab63ae8a1972ce', '[\"*\"]', '2023-02-04 17:13:10', '2023-02-03 23:00:05', '2023-02-04 17:13:10'),
(216, 'App\\Models\\Admin', 2, 'MyApp', '6324a8260f937fc83883149872313aa34a6e7df3abc69ef96c716a6cdddcc2ea', '[\"*\"]', '2023-02-04 22:08:37', '2023-02-03 23:20:33', '2023-02-04 22:08:37'),
(217, 'App\\Models\\Admin', 2, 'MyApp', 'd114ab74d464f083dd1ba7d6135e6eb191de441875f209831be7f24e766cd4f6', '[\"*\"]', NULL, '2023-02-04 17:14:41', '2023-02-04 17:14:41'),
(218, 'App\\Models\\Admin', 2, 'MyApp', 'a3d73d1f7055073099c55cd97e3c450396874c6372fc329e43591e1cbff9f780', '[\"*\"]', NULL, '2023-02-04 21:27:24', '2023-02-04 21:27:24'),
(219, 'App\\Models\\Admin', 2, 'MyApp', 'd880493841c3695e734d0527b1d60c4ee9ccabc75f8ff215ca0717157394e5c1', '[\"*\"]', NULL, '2023-02-04 22:06:13', '2023-02-04 22:06:13'),
(220, 'App\\Models\\Admin', 2, 'MyApp', 'e41a6ac4010addb865406c59aa4597723043da2facc0b2916c576dff0b66d95f', '[\"*\"]', '2023-02-05 09:33:40', '2023-02-05 09:23:52', '2023-02-05 09:33:40'),
(221, 'App\\Models\\Admin', 2, 'MyApp', '811b1fcc6a3a7d0f2256c97a3923d573581ab11ca441f6c66702e3f3f2829594', '[\"*\"]', '2023-02-05 09:42:04', '2023-02-05 09:33:39', '2023-02-05 09:42:04'),
(222, 'App\\Models\\Admin', 2, 'MyApp', '8879f3b9c44ad01c0f82e1d84719db877fd4f6cef9600bc1869429e9a07d6bd6', '[\"*\"]', NULL, '2023-02-05 09:34:25', '2023-02-05 09:34:25'),
(223, 'App\\Models\\Admin', 2, 'MyApp', '3ec8f1e07e2722f3cba3cb35570f34c0dc39fa533cf9b7c6e6104558d6fd1427', '[\"*\"]', NULL, '2023-02-05 12:44:40', '2023-02-05 12:44:40'),
(224, 'App\\Models\\Admin', 2, 'MyApp', 'b3054dbd162ffbaaeee769a73dc109c533b212468ee92eda54b9b4979f59150b', '[\"*\"]', NULL, '2023-02-05 12:44:42', '2023-02-05 12:44:42'),
(225, 'App\\Models\\Admin', 2, 'MyApp', '617946b8e6c6d6cd13c8ce127780f516cfc848792ef50f598edce9a6edcf8d59', '[\"*\"]', NULL, '2023-02-05 12:44:42', '2023-02-05 12:44:42'),
(226, 'App\\Models\\Admin', 2, 'MyApp', '858e6d0fe4728f4fcc569cb77be24a7c294c783232af17e777a5876698b0ddb5', '[\"*\"]', NULL, '2023-02-28 20:05:40', '2023-02-28 20:05:40'),
(227, 'App\\Models\\Admin', 1, 'MyApp', '03d0ffe3508ab5dd2426a7b6d9ab95fce695b4511e8b324a01806d30db98de97', '[\"*\"]', NULL, '2023-03-01 08:44:42', '2023-03-01 08:44:42'),
(228, 'App\\Models\\Admin', 1, 'MyApp', '3017f1ed538b065693bfe7152e6646f3e5a71d45f4821cd7a7540aa579d27780', '[\"*\"]', NULL, '2023-03-01 10:08:27', '2023-03-01 10:08:27'),
(229, 'App\\Models\\Admin', 2, 'MyApp', '408b43d13905381886afa2215b38189daff5481c0f7e7ce3fe45c998f6d9ce0b', '[\"*\"]', NULL, '2023-03-03 21:30:25', '2023-03-03 21:30:25'),
(230, 'App\\Models\\Admin', 2, 'MyApp', '78cd88d00d4c283ef6dee8af55cb3fed57ace555e89a531db0c5a7e105f2d7cd', '[\"*\"]', '2023-03-03 23:46:08', '2023-03-03 21:43:42', '2023-03-03 23:46:08'),
(232, 'App\\Models\\Admin', 1, 'MyApp', '60c8ca93e3b1ee1130be91e5226fe8efb35fd7ae7cbc942a2c1fa7a5c25198ca', '[\"*\"]', NULL, '2023-03-04 17:51:06', '2023-03-04 17:51:06'),
(236, 'App\\Models\\Admin', 2, 'MyApp', '6acb0d9435de057132e59ad2572042a1ab4b588531fd2c8f58219ecb2b3fedd7', '[\"*\"]', '2023-03-04 18:54:38', '2023-03-04 18:54:33', '2023-03-04 18:54:38'),
(237, 'App\\Models\\Admin', 1, 'MyApp', '9f225ca812e08821c6a6b0ab00972b5a1543d58a29d3bc0354e9c454b82bfa8b', '[\"*\"]', NULL, '2023-03-04 19:10:02', '2023-03-04 19:10:02'),
(241, 'App\\Models\\Admin', 2, 'MyApp', 'd172a3fed709d189fe04d8c50e8742d1de8430f5a8392b890766e7d7c0803358', '[\"*\"]', NULL, '2023-03-04 20:57:12', '2023-03-04 20:57:12'),
(242, 'App\\Models\\Admin', 2, 'MyApp', 'f2764e04fcf3b0e5979ae5e154849fc44d08f8883b20861759a902b1c5aa6bd7', '[\"*\"]', '2023-03-05 10:58:17', '2023-03-04 21:39:50', '2023-03-05 10:58:17'),
(243, 'App\\Models\\Admin', 2, 'MyApp', 'c9e0f63c0ea64b23fce45366f18da4bcc32c75d80b134c0b7b33f66dbef9dc02', '[\"*\"]', NULL, '2023-03-04 22:03:16', '2023-03-04 22:03:16'),
(244, 'App\\Models\\Admin', 2, 'MyApp', '6aad0ee15ea7ba0eb1cd5001f30b68fae189af328938d2217ad47ba927de0ee1', '[\"*\"]', '2023-12-06 20:46:12', '2023-03-04 22:03:30', '2023-12-06 20:46:12'),
(245, 'App\\Models\\Admin', 2, 'MyApp', '1403f5a4d22fda4449b5b9cefdbee1cccd10b413075767021dba5d80b7b5c2f0', '[\"*\"]', '2023-03-08 21:37:19', '2023-03-08 17:01:22', '2023-03-08 21:37:19'),
(246, 'App\\Models\\Admin', 2, 'MyApp', 'afc7e7247e24b6935e9e400eedc46b365a2a462620aa2d7ed96592173c94fb7e', '[\"*\"]', '2023-03-09 21:28:02', '2023-03-09 21:27:59', '2023-03-09 21:28:02'),
(247, 'App\\Models\\Admin', 2, 'MyApp', '4b20c26831ac0a09c180741ac842593b9d7172edc21355d9be3b53dbf2b892ba', '[\"*\"]', '2023-03-09 22:10:16', '2023-03-09 22:10:15', '2023-03-09 22:10:16'),
(248, 'App\\Models\\Admin', 2, 'MyApp', '0ba14ff150f1c42b56dcb3e13deb66bdc79385913b7e23ba38327d199c8162b9', '[\"*\"]', '2023-03-09 22:27:47', '2023-03-09 22:27:46', '2023-03-09 22:27:47'),
(249, 'App\\Models\\Admin', 2, 'MyApp', '3476678d75a276234b0444755010067c45a0976f6a38af5b37fe8d11bf9c63ae', '[\"*\"]', '2023-03-09 22:32:03', '2023-03-09 22:32:03', '2023-03-09 22:32:03'),
(250, 'App\\Models\\Admin', 2, 'MyApp', 'e0d5eec74ad34fa10e58f574d47697f1543961a14fb279822b51bdcdbe4ce666', '[\"*\"]', '2023-03-09 22:33:55', '2023-03-09 22:33:54', '2023-03-09 22:33:55'),
(251, 'App\\Models\\Admin', 2, 'MyApp', 'd5650991d028a96e8ab31911e8c74b02a6d776415062cf37249ded694f14f98d', '[\"*\"]', '2023-03-11 15:35:58', '2023-03-11 15:35:57', '2023-03-11 15:35:58'),
(252, 'App\\Models\\Admin', 2, 'MyApp', '81f687b9616787bd6f9d0c454dd189eaf6a1878ca71d6b3efe823fb0b34f3fa2', '[\"*\"]', '2023-03-11 15:39:36', '2023-03-11 15:39:35', '2023-03-11 15:39:36'),
(253, 'App\\Models\\Admin', 2, 'MyApp', '7e1b7facc751970a2834e48a825c16ce6cdd14067849202d1ebaba183fd09076', '[\"*\"]', '2023-03-11 15:42:14', '2023-03-11 15:42:13', '2023-03-11 15:42:14'),
(254, 'App\\Models\\Admin', 2, 'MyApp', '35b0ce1a942c8f28b2c5e2fb07c61ca630cfbf04ca0aaaf3419d24c53fafcbe7', '[\"*\"]', '2023-03-11 16:04:08', '2023-03-11 16:04:07', '2023-03-11 16:04:08'),
(255, 'App\\Models\\Admin', 2, 'MyApp', '865d70bb67c174923bd38fa9f7bd40617a920c8c1d1b716ef9761ef8b8d8e3c7', '[\"*\"]', '2023-03-11 16:13:43', '2023-03-11 16:13:42', '2023-03-11 16:13:43'),
(256, 'App\\Models\\Admin', 2, 'MyApp', '089a0a060bfcd33e5b4a1e27c4feca5b57c79be0fb4a742c249c99fc85b8ff4a', '[\"*\"]', '2023-03-11 16:15:27', '2023-03-11 16:15:26', '2023-03-11 16:15:27'),
(257, 'App\\Models\\Admin', 2, 'MyApp', '79306af1bcced0d68e22e7b5b7298e53cefd2e976e7d398da14192a27e30d14f', '[\"*\"]', '2023-03-11 16:16:34', '2023-03-11 16:16:33', '2023-03-11 16:16:34'),
(258, 'App\\Models\\Admin', 2, 'MyApp', '6aa2cab63d11283f0c2a9bd3a79aff6d80cb8de0d90f085e086a24b8a804bc55', '[\"*\"]', '2023-03-11 16:17:55', '2023-03-11 16:17:54', '2023-03-11 16:17:55'),
(259, 'App\\Models\\Admin', 2, 'MyApp', '32e7a5a8218ed01863b3b5a9c6597dd1dccfa9421e89bc3238128580990cbb04', '[\"*\"]', '2023-03-11 17:45:08', '2023-03-11 17:45:07', '2023-03-11 17:45:08'),
(260, 'App\\Models\\Admin', 2, 'MyApp', '7409493bd72798bce26447cf522223b77b6927fadf97f3bf894a861b1809f0fc', '[\"*\"]', '2023-03-11 17:58:34', '2023-03-11 17:58:33', '2023-03-11 17:58:34'),
(261, 'App\\Models\\Admin', 2, 'MyApp', '2fa9d3164f187d429ff8fb11100f1c18d62a4fc8b21e8bb74ef43717b1d626b7', '[\"*\"]', '2023-03-11 18:13:10', '2023-03-11 18:13:09', '2023-03-11 18:13:10'),
(262, 'App\\Models\\Admin', 2, 'MyApp', '54a3947f06b6b17e83c5667b4b282660b72550b4f7b0f8f7948f9c0832cf29c5', '[\"*\"]', '2023-03-11 18:30:30', '2023-03-11 18:30:29', '2023-03-11 18:30:30'),
(263, 'App\\Models\\Admin', 2, 'MyApp', '419bcfbd511d04f16b28cb9b48b376a4e39ca04b2ebc5010e5f0f9d5c14ea08e', '[\"*\"]', '2023-03-11 18:35:37', '2023-03-11 18:35:36', '2023-03-11 18:35:37'),
(264, 'App\\Models\\Admin', 2, 'MyApp', 'a8a7e7e63e671651cd5456ace3fbdf8273b34ff8340449fb0b81a0beda16e6de', '[\"*\"]', '2023-03-11 18:43:37', '2023-03-11 18:43:36', '2023-03-11 18:43:37'),
(265, 'App\\Models\\Admin', 2, 'MyApp', 'f827dec3b95c78cbe263224b7935c7379be5ca0b40a7be2c88b82f4aab4f3c88', '[\"*\"]', '2023-03-11 19:22:11', '2023-03-11 19:22:10', '2023-03-11 19:22:11'),
(266, 'App\\Models\\Admin', 2, 'MyApp', 'db34f248cdac632f3b5731a40792f8d7c144cb8705f20abfe4d2f6f6dba9ddcd', '[\"*\"]', '2023-03-11 19:31:38', '2023-03-11 19:31:37', '2023-03-11 19:31:38'),
(267, 'App\\Models\\Admin', 2, 'MyApp', '26bcd0f07c343dd86bd5b68ad38e6dc4468339a2822205a4ad47c438f99599c3', '[\"*\"]', '2023-03-11 19:35:50', '2023-03-11 19:35:49', '2023-03-11 19:35:50'),
(268, 'App\\Models\\Admin', 2, 'MyApp', '5d90b7fa0e2cb71d6a44be589d9e599b948f4822d1b0e06bcbf832e391a4849c', '[\"*\"]', '2023-03-11 19:39:07', '2023-03-11 19:39:06', '2023-03-11 19:39:07'),
(269, 'App\\Models\\Admin', 2, 'MyApp', '5e420029804a505204042138c6b14989b1933c8e3460a89bb91b09835d900549', '[\"*\"]', '2023-03-11 19:40:09', '2023-03-11 19:40:08', '2023-03-11 19:40:09'),
(270, 'App\\Models\\Admin', 2, 'MyApp', '9dd9bc2d4045717be8174c25610081016ee526bcfd32e2c8cc04e8b0cdc38fdd', '[\"*\"]', '2023-03-11 19:44:02', '2023-03-11 19:44:01', '2023-03-11 19:44:02'),
(271, 'App\\Models\\Admin', 2, 'MyApp', '1d476d8d0959bccb18dd508403a78fb863b14dc8a55aa94c41bf2ab2f3295669', '[\"*\"]', '2023-03-11 23:08:51', '2023-03-11 23:08:50', '2023-03-11 23:08:51'),
(272, 'App\\Models\\Admin', 2, 'MyApp', 'c3dac6b3fef41ef76c28b8d3c854393aa4048778de26c3536a4288bf3088921f', '[\"*\"]', '2023-03-11 23:13:34', '2023-03-11 23:13:33', '2023-03-11 23:13:34'),
(273, 'App\\Models\\Admin', 2, 'MyApp', '1c9bed1bc3b1d76542ec871ce3487c592a8fe6b43d8044a3e58e991ff82fad2a', '[\"*\"]', '2023-03-11 23:29:04', '2023-03-11 23:29:03', '2023-03-11 23:29:04'),
(274, 'App\\Models\\Admin', 2, 'MyApp', '2f5102305def5e9d0087b451e3d3f5ef336cc138bc93e4f59af4811be56de9ad', '[\"*\"]', '2023-03-11 23:39:30', '2023-03-11 23:39:29', '2023-03-11 23:39:30'),
(275, 'App\\Models\\Admin', 2, 'MyApp', '5e2cb19999481c98ebd747cf8d0ad882b2abb256085c09123380df57c87bc3ac', '[\"*\"]', '2023-03-12 12:28:08', '2023-03-12 12:28:07', '2023-03-12 12:28:08'),
(276, 'App\\Models\\Admin', 2, 'MyApp', 'f31be90b772d2c8fabae43ce2101f2e96932076b1d619da62ccb8864296d0b84', '[\"*\"]', '2023-03-12 12:57:38', '2023-03-12 12:57:37', '2023-03-12 12:57:38'),
(277, 'App\\Models\\Admin', 2, 'MyApp', 'b503db864fe16bae893271d9a83e76f0ecd421b43df201ae42a4f07d1247a1ac', '[\"*\"]', '2023-03-12 13:00:08', '2023-03-12 13:00:07', '2023-03-12 13:00:08'),
(278, 'App\\Models\\Admin', 2, 'MyApp', '44e43884ceef1a1c6d37ca80b55a3727d125ecbb2fdc68dee0148394c53da7ca', '[\"*\"]', '2023-03-12 13:02:05', '2023-03-12 13:02:04', '2023-03-12 13:02:05'),
(279, 'App\\Models\\Admin', 2, 'MyApp', '39b1f9b2e7758952c3d872dd07c12c4683d5ffb70c11252ba2f7c3eb48749206', '[\"*\"]', '2023-03-12 13:03:57', '2023-03-12 13:03:56', '2023-03-12 13:03:57'),
(280, 'App\\Models\\Admin', 2, 'MyApp', '3b475a73624c51d023361a9145dffb7e8efc965a5288601c764685accb7b7e1a', '[\"*\"]', '2023-03-12 13:07:44', '2023-03-12 13:07:43', '2023-03-12 13:07:44'),
(281, 'App\\Models\\Admin', 2, 'MyApp', 'd6ecf36be68095c5d32e335041a7155c5708b311950b0a4ed8b5c846ec09a372', '[\"*\"]', '2023-03-12 13:11:18', '2023-03-12 13:11:17', '2023-03-12 13:11:18'),
(282, 'App\\Models\\Admin', 2, 'MyApp', 'f38629ac8dfcbd5ce39bd75b55d5d34e15c9a6dae2e46c0bc91e90f6b25dbf5e', '[\"*\"]', '2023-03-12 13:15:01', '2023-03-12 13:15:00', '2023-03-12 13:15:01'),
(283, 'App\\Models\\Admin', 2, 'MyApp', 'f2586f50fe1df17e5ddba93a45b0989de25894e237eeca8f62a6d587f2c8ecc3', '[\"*\"]', '2023-03-12 13:16:16', '2023-03-12 13:16:15', '2023-03-12 13:16:16'),
(284, 'App\\Models\\Admin', 2, 'MyApp', '33556aee1ec0188767b83c88ae4c80a96073940389769a7eae49afa45748ccf2', '[\"*\"]', '2023-03-12 13:17:52', '2023-03-12 13:17:51', '2023-03-12 13:17:52'),
(285, 'App\\Models\\Admin', 2, 'MyApp', '6e8826b0d1959513a31ba940a48e170640c3283191c33b4a03a03ce4ce3481e4', '[\"*\"]', '2023-03-12 13:19:41', '2023-03-12 13:19:40', '2023-03-12 13:19:41'),
(286, 'App\\Models\\Admin', 2, 'MyApp', 'a1e67be14ec890a9940d32ff7a393f5092263809f2a2a632728092cd6ce17ccf', '[\"*\"]', '2023-03-12 13:24:43', '2023-03-12 13:24:42', '2023-03-12 13:24:43'),
(287, 'App\\Models\\Admin', 2, 'MyApp', '8fc799ba17d4fe2cb11bfdf8411b63dfc9e75a2cb6819ca600f9371be7e985d6', '[\"*\"]', '2023-03-12 13:27:02', '2023-03-12 13:27:01', '2023-03-12 13:27:02'),
(288, 'App\\Models\\Admin', 2, 'MyApp', 'c8f8271e5fb611680171b4d34780f263057eea079be03231ca003502eb25f8d9', '[\"*\"]', '2023-03-12 13:37:34', '2023-03-12 13:37:33', '2023-03-12 13:37:34'),
(289, 'App\\Models\\Admin', 2, 'MyApp', 'fbdf57d5c21782c9beec4ede19a85d4b66370166a7299ffdc5a13874ee166fb3', '[\"*\"]', '2023-03-12 13:57:01', '2023-03-12 13:56:59', '2023-03-12 13:57:01'),
(290, 'App\\Models\\Admin', 2, 'MyApp', 'f0a9ebdb0bd0d8697c1c94fb6e663de186ae82d1e320c9faf9d131b5a2a2f022', '[\"*\"]', '2023-03-12 14:03:21', '2023-03-12 14:03:20', '2023-03-12 14:03:21');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES
(291, 'App\\Models\\Admin', 2, 'MyApp', 'd47018f6004ebe960cfa7720e7a4d52cc2159013deeb1033219ba5c14e67d67e', '[\"*\"]', '2023-03-12 14:11:17', '2023-03-12 14:11:16', '2023-03-12 14:11:17'),
(292, 'App\\Models\\Admin', 2, 'MyApp', 'e38ee925df3ee7068a9529e8c93fa472fdb61f1bfa3dd980bd658a4ba071b18a', '[\"*\"]', '2023-03-12 17:30:47', '2023-03-12 17:30:46', '2023-03-12 17:30:47'),
(293, 'App\\Models\\Admin', 2, 'MyApp', 'c2f829192f40c016f45094578f3b87346f393ab111af1e48570bc50a12f6fcda', '[\"*\"]', '2023-03-12 17:32:01', '2023-03-12 17:32:00', '2023-03-12 17:32:01'),
(294, 'App\\Models\\Admin', 2, 'MyApp', 'a2c5487732ad41ba88407d192214032188fb7c14a5810171cb21b7749568416e', '[\"*\"]', '2023-03-12 17:33:31', '2023-03-12 17:33:30', '2023-03-12 17:33:31'),
(295, 'App\\Models\\Admin', 2, 'MyApp', 'c2e8be79e11254ddcd2116b92be2258071ec1f2306e3c460fd26e01022d30c3d', '[\"*\"]', '2023-03-12 17:35:16', '2023-03-12 17:35:15', '2023-03-12 17:35:16'),
(296, 'App\\Models\\Admin', 2, 'MyApp', '5d244a5f4753bd62b0bd3dfb5e535606a5cca0bac047f96409ebe583c5c89eae', '[\"*\"]', '2023-03-12 17:37:13', '2023-03-12 17:37:12', '2023-03-12 17:37:13'),
(297, 'App\\Models\\Admin', 2, 'MyApp', '953bda5be3c27d1549f30d355bbd0b307652e5cd4c940f705c9a68482232f86e', '[\"*\"]', '2023-03-12 17:38:24', '2023-03-12 17:38:23', '2023-03-12 17:38:24'),
(298, 'App\\Models\\Admin', 2, 'MyApp', 'dc51caae327716e9f493a78979ad35e9d061afe955978e6983e638fd4073d8b3', '[\"*\"]', '2023-03-12 17:39:38', '2023-03-12 17:39:37', '2023-03-12 17:39:38'),
(299, 'App\\Models\\Admin', 2, 'MyApp', '595ee4f4ce11a932e27fb6b28ca586fdd55382154793b78716dd222a67410a7c', '[\"*\"]', '2023-03-12 17:48:11', '2023-03-12 17:48:10', '2023-03-12 17:48:11'),
(300, 'App\\Models\\Admin', 2, 'MyApp', 'aab4ef8c36fc87ec14411111a3ce70d364803f6c0598f9761323d1972ac32eaf', '[\"*\"]', '2023-03-12 18:04:22', '2023-03-12 18:04:21', '2023-03-12 18:04:22'),
(301, 'App\\Models\\Admin', 2, 'MyApp', '29521d9975cb1b875171429685120f07e6b7748591031d812fe59a6235be887e', '[\"*\"]', '2023-03-14 17:34:12', '2023-03-14 17:34:09', '2023-03-14 17:34:12'),
(302, 'App\\Models\\Admin', 2, 'MyApp', '447d8a6c1e77e60132541494d4041b070c0f5e7a2af8bbd23ca92020c06bcde6', '[\"*\"]', '2023-03-15 19:49:11', '2023-03-15 19:49:09', '2023-03-15 19:49:11'),
(303, 'App\\Models\\Admin', 2, 'MyApp', 'bd1aa336122a4f461eb5585d6fb6e889000a98ad0efdfcce5b315a1808b28c03', '[\"*\"]', '2023-03-16 04:13:07', '2023-03-16 04:13:05', '2023-03-16 04:13:07'),
(304, 'App\\Models\\Admin', 2, 'MyApp', '24ab9cac5378761d0d444895acc2b84273eb4280a53fb6571accc5e7a0e578be', '[\"*\"]', '2023-03-16 05:09:28', '2023-03-16 05:09:27', '2023-03-16 05:09:28'),
(305, 'App\\Models\\Admin', 2, 'MyApp', '43126e8d60a888f4cbc140d6f46db4919f3ef0bfa438ff0fee61dd9cdc980a9c', '[\"*\"]', '2023-03-16 17:12:56', '2023-03-16 17:12:56', '2023-03-16 17:12:56'),
(306, 'App\\Models\\Admin', 2, 'MyApp', '74f3316f7fbfa8fb7a78783bec3cf62d0ab733b456f5c81c0f875c71cc692a3e', '[\"*\"]', '2023-03-16 17:37:32', '2023-03-16 17:37:31', '2023-03-16 17:37:32'),
(307, 'App\\Models\\Admin', 2, 'MyApp', '015a364e9046e59e6c5a129ccc400d8e5101d62a9b74fb3014ee377f3b9f77f3', '[\"*\"]', '2023-03-16 18:30:43', '2023-03-16 18:30:42', '2023-03-16 18:30:43'),
(308, 'App\\Models\\Admin', 2, 'MyApp', 'b53019915a44308abdfaf5316f1d676ad6d3866b19d7a60988299c934bf951f4', '[\"*\"]', '2023-03-17 00:01:14', '2023-03-17 00:01:12', '2023-03-17 00:01:14'),
(309, 'App\\Models\\Admin', 2, 'MyApp', 'c0e92e53a66e1c0857601f9914b371aa0f95dc17e04712713a523c1079f2eae9', '[\"*\"]', '2023-03-18 06:36:14', '2023-03-18 06:36:13', '2023-03-18 06:36:14'),
(310, 'App\\Models\\Admin', 2, 'MyApp', 'b99ca93d5d4df6dd2e6f433523c09818d8468ffc6526f594ab424e4c69aadbcf', '[\"*\"]', '2023-03-18 06:38:40', '2023-03-18 06:38:39', '2023-03-18 06:38:40'),
(311, 'App\\Models\\Admin', 2, 'MyApp', '90c4756ec48afb1130d37334d7d19cd3faf651f7485c6aba56f2234288cb0bf6', '[\"*\"]', '2023-03-22 18:38:46', '2023-03-22 18:29:44', '2023-03-22 18:38:46'),
(312, 'App\\Models\\Admin', 2, 'MyApp', '0b4bf2dde1d484907a198e2a4c80d09d6110952c4c8f3d2ab110e04986583c6e', '[\"*\"]', '2023-03-22 18:41:04', '2023-03-22 18:41:03', '2023-03-22 18:41:04'),
(313, 'App\\Models\\Admin', 2, 'MyApp', 'f7062bc82b0ce07651331a70cfa93273f4db8ba39f3ae6f37797d8a6925d5938', '[\"*\"]', '2023-04-04 20:40:41', '2023-04-04 20:39:49', '2023-04-04 20:40:41'),
(314, 'App\\Models\\Admin', 2, 'MyApp', '1de1fdb41ecad10c1a170579df52b90b7935ba91a1da888551e0b1b12a4ebe84', '[\"*\"]', NULL, '2023-04-04 20:58:42', '2023-04-04 20:58:42'),
(315, 'App\\Models\\Admin', 2, 'MyApp', 'b2f5ba5df9525583b93da106f6e058e4aaae46a57bd944480443d7a452a4e00f', '[\"*\"]', NULL, '2023-04-09 21:07:51', '2023-04-09 21:07:51'),
(316, 'App\\Models\\Admin', 2, 'MyApp', 'b4b7b60a680f7291a35181e7ad19017ddd1b595accb21014c6e491551c712f9c', '[\"*\"]', NULL, '2023-04-09 22:21:55', '2023-04-09 22:21:55'),
(317, 'App\\Models\\Admin', 2, 'MyApp', 'dabca3eadca0f33f05690bccf715fcd8e7036170c44aa6d495cf4252b4398fb8', '[\"*\"]', '2023-04-12 13:53:28', '2023-04-11 18:59:41', '2023-04-12 13:53:28'),
(318, 'App\\Models\\Admin', 2, 'MyApp', 'd7444bbc5b93d1098145e24f785e4e6fa2be17dc5a484f4eba99772995fff79f', '[\"*\"]', NULL, '2023-04-11 23:18:39', '2023-04-11 23:18:39'),
(319, 'App\\Models\\Admin', 2, 'MyApp', 'b20c3447fddf23e7d702461d2d18b389c53f7f79234c5f86829879fde20fea6b', '[\"*\"]', NULL, '2023-04-11 23:19:43', '2023-04-11 23:19:43'),
(320, 'App\\Models\\Admin', 2, 'MyApp', '10819d4876f81553bd9af399ef02dc6e17e781512fc4d91274eaf6a5cc4a8ef0', '[\"*\"]', NULL, '2023-04-11 23:19:51', '2023-04-11 23:19:51'),
(321, 'App\\Models\\Admin', 2, 'MyApp', '28b3f4c3d0ced1d5b550fe24259fde59348a0a554734436aedf13606bafb577e', '[\"*\"]', NULL, '2023-04-11 23:21:10', '2023-04-11 23:21:10'),
(322, 'App\\Models\\Admin', 2, 'MyApp', 'a4a3715f0fddec875310baad8a2ca9947f98c111106c9b144cd5d04c64fc0e59', '[\"*\"]', NULL, '2023-04-13 14:58:04', '2023-04-13 14:58:04'),
(325, 'App\\Models\\Admin', 2, 'MyApp', 'a7251eaa94f3f13a7b743b37bf6ed338bbd4a92c3bcf7355d0f22dc050d2d985', '[\"*\"]', NULL, '2023-04-14 20:35:22', '2023-04-14 20:35:22'),
(326, 'App\\Models\\Admin', 2, 'MyApp', 'fb8ed9637c4b8c43f6e901edd38bb7fce0645c7a930a374241e530fb7b702754', '[\"*\"]', NULL, '2023-04-14 20:37:27', '2023-04-14 20:37:27'),
(327, 'App\\Models\\Admin', 2, 'MyApp', '5e421efa14fdebf835b2177d1d21694ea91dd8406488371b78c9a7b4618a55a3', '[\"*\"]', NULL, '2023-04-14 20:59:06', '2023-04-14 20:59:06'),
(328, 'App\\Models\\Admin', 2, 'MyApp', '55de4cc7f40e895394c3521f830b2d644ee747b305d62a74959bf0841d6568ac', '[\"*\"]', NULL, '2023-05-07 16:21:48', '2023-05-07 16:21:48'),
(329, 'App\\Models\\Admin', 2, 'MyApp', '6a833c7310229e828cf4888129c6e65b9c05d2052a00c8c157a3e77f5a02b86e', '[\"*\"]', '2023-05-12 18:32:22', '2023-05-11 14:31:20', '2023-05-12 18:32:22'),
(330, 'App\\Models\\Admin', 2, 'MyApp', 'f073a0582a3120ac90e1bd38fda68f49635937809c92cbc79d63dcb0081aa177', '[\"*\"]', '2023-05-14 19:16:48', '2023-05-14 17:19:43', '2023-05-14 19:16:48'),
(331, 'App\\Models\\Admin', 2, 'MyApp', '5e29c5ea897f094e875da2deffe724acd9bb7ff0ac319cf4b476908071bef755', '[\"*\"]', '2023-05-18 18:10:54', '2023-05-16 15:24:12', '2023-05-18 18:10:54'),
(332, 'App\\Models\\Admin', 2, 'MyApp', 'ca4ebc1b351878f2d4a79a55912605a753970f9ebad0b41149536bba5c52d001', '[\"*\"]', '2023-05-18 20:15:29', '2023-05-18 18:13:01', '2023-05-18 20:15:29'),
(334, 'App\\Models\\Admin', 2, 'MyApp', '20a56d650a76f8d1f09aa20deaa0c4fa1f5f6523bebdcd1c698b04b4db7533af', '[\"*\"]', '2023-05-31 14:52:48', '2023-05-31 14:48:22', '2023-05-31 14:52:48'),
(335, 'App\\Models\\Admin', 2, 'MyApp', 'd05a167396ad3262bd5e4a7e68e5cd0d32391ffe0b3f334de91995276209251d', '[\"*\"]', NULL, '2023-05-31 16:18:28', '2023-05-31 16:18:28'),
(336, 'App\\Models\\Admin', 2, 'MyApp', 'faf5217d2816dbe7a916f5faa6cc85eb336b222ced9e9e23c4454e752656c1ae', '[\"*\"]', '2023-06-01 14:05:38', '2023-06-01 14:04:14', '2023-06-01 14:05:38'),
(337, 'App\\Models\\Admin', 2, 'MyApp', 'c728f6bd71f847f15da5ed25c2572cafa1689875ef75c56ed59b7e4b9576bf14', '[\"*\"]', '2023-06-02 15:56:34', '2023-06-02 15:35:12', '2023-06-02 15:56:34'),
(338, 'App\\Models\\Admin', 2, 'MyApp', '70971ec262d874dca8caaa7188726098db2f84b5885887cd5827856b1d79b01b', '[\"*\"]', NULL, '2023-06-02 16:05:35', '2023-06-02 16:05:35'),
(340, 'App\\Models\\User', 3, 'MyApp', '8c46bfe75aac4118cd3221aba2938d34ec1b9e328a2f322ff156bbd303a37e11', '[\"*\"]', NULL, '2023-06-08 14:50:31', '2023-06-08 14:50:31'),
(342, 'App\\Models\\Admin', 2, 'MyApp', '79714ff8482ef7d3483d8be26072c866183a11daa0021c65f8db6bfe1eaef151', '[\"*\"]', NULL, '2023-06-08 16:29:02', '2023-06-08 16:29:02'),
(344, 'App\\Models\\Admin', 2, 'MyApp', '23c9b843eae0c5584db37e62aad32e6c442c1dbeea328b3adc0dcb2c0b79447c', '[\"*\"]', '2023-06-20 19:16:09', '2023-06-20 14:51:20', '2023-06-20 19:16:09'),
(347, 'App\\Models\\Admin', 2, 'MyApp', '77e0eb34d77f7323651a9ec4609728a08d48897359a3cd7a2204eededa3c90c0', '[\"*\"]', '2023-06-20 20:51:26', '2023-06-20 20:22:49', '2023-06-20 20:51:26'),
(350, 'App\\Models\\Admin', 14, 'MyApp', '3890d7eb38dabc69a5b96596a52b3ddcb0cf529754ef2bf238a17c14aafb0c0c', '[\"*\"]', NULL, '2023-06-22 16:29:32', '2023-06-22 16:29:32'),
(351, 'App\\Models\\Admin', 14, 'MyApp', 'feb24fef118331e846497675de96b9042051830b4be0f6c403ba241f6c8fa1dd', '[\"*\"]', NULL, '2023-06-22 16:30:27', '2023-06-22 16:30:27'),
(352, 'App\\Models\\Admin', 14, 'MyApp', '3a67a25c6c95f8630f3de99ee955542ca0692f403ccf79b1f09a05c516c4ef96', '[\"*\"]', NULL, '2023-06-22 16:32:28', '2023-06-22 16:32:28'),
(356, 'App\\Models\\Admin', 14, 'MyApp', 'ca0b8f903891a8b0b1e3f80a5ddda8f4bf67e3fcce61f0e1c8aace6f475331cf', '[\"*\"]', NULL, '2023-06-22 19:11:33', '2023-06-22 19:11:33'),
(360, 'App\\Models\\Admin', 2, 'MyApp', '71d8cba8a508650b68496d6abfd63a6c59ab4ad57e524603b9305b397c23c2b8', '[\"*\"]', '2023-06-22 17:30:23', '2023-06-22 19:30:03', '2023-06-22 17:30:23'),
(361, 'App\\Models\\Admin', 1, 'MyApp', '5ff1daf823658416899d499ef2b1b57aae4309e6a10e9e66edb650befca71407', '[\"*\"]', '2023-06-22 17:38:41', '2023-06-22 19:38:36', '2023-06-22 17:38:41'),
(363, 'App\\Models\\Admin', 16, 'MyApp', '13caedd77ac616eef1bd31898ef777047e8c9161fa0d3487f424f64ab4c92978', '[\"*\"]', NULL, '2023-06-22 19:57:41', '2023-06-22 19:57:41'),
(369, 'App\\Models\\Admin', 17, 'MyApp', 'd7a81df9e47f1217d5d8cd1da94b400593dd445ed4b61cfdb706ec16ee22f3c4', '[\"*\"]', '2023-06-22 18:03:32', '2023-06-22 20:03:22', '2023-06-22 18:03:32'),
(370, 'App\\Models\\Admin', 2, 'MyApp', 'c257018dafb5c908b4fb15d7e062ceb49bcb77b105b90d48e0569d65e15e189d', '[\"*\"]', '2023-06-23 19:27:07', '2023-06-23 19:26:55', '2023-06-23 19:27:07'),
(371, 'App\\Models\\Admin', 2, 'MyApp', '579e1c562e7b89de1e022d98fff549fa4d9485686d9c743bc1bc5899b8a95a4c', '[\"*\"]', '2023-06-25 16:10:31', '2023-06-25 15:36:57', '2023-06-25 16:10:31'),
(372, 'App\\Models\\Admin', 2, 'MyApp', '63ecec93ef8d6625834d3cf8f95d825c6f4fe18b9edb2c093fa923324429b5c3', '[\"*\"]', '2023-08-08 15:31:29', '2023-08-08 14:33:26', '2023-08-08 15:31:29'),
(373, 'App\\Models\\Admin', 2, 'MyApp', 'b23d8bb7b6992904b5c88e6e79ad9cb299012944c3291f0719d7b44a6bdd603a', '[\"*\"]', '2023-08-13 09:46:38', '2023-08-10 14:52:48', '2023-08-13 09:46:38'),
(374, 'App\\Models\\Admin', 2, 'MyApp', '4585e7a36557d2ffe30c9926b973aa43881cc51ecb971f98ea9a45fe53de58ec', '[\"*\"]', '2023-08-14 10:33:18', '2023-08-14 07:36:26', '2023-08-14 10:33:18'),
(375, 'App\\Models\\Admin', 2, 'MyApp', '581df105c7168b6d1050c0fc853a0557eb4a45b153085053be972c662abb3946', '[\"*\"]', '2023-08-21 18:26:00', '2023-08-16 08:57:04', '2023-08-21 18:26:00'),
(376, 'App\\Models\\Admin', 2, 'MyApp', 'e55f937439acd515df69a82f190d607cd6e2a4b513d2ba658f428cfa07abea27', '[\"*\"]', '2023-08-23 19:03:31', '2023-08-22 17:50:19', '2023-08-23 19:03:31'),
(377, 'App\\Models\\Admin', 2, 'MyApp', 'a5c87f0e6c7543a600959c7d2d90665640c44cbe11975f86cba276d33dd8044f', '[\"*\"]', '2023-11-03 16:51:46', '2023-11-03 16:50:48', '2023-11-03 16:51:46'),
(378, 'App\\Models\\Admin', 2, 'MyApp', '4f508b15026efca533f16691c8d4f504f2ddcd5c57ddfb0397437151c4e65681', '[\"*\"]', '2023-12-04 07:31:48', '2023-11-21 20:09:46', '2023-12-04 07:31:48'),
(379, 'App\\Models\\Admin', 2, 'MyApp', 'ea57fa6cb46a30a4a3d06fcde7457a230fa0ceddc2e4396c61f721f9aa7bbbf1', '[\"*\"]', '2023-12-06 20:30:43', '2023-12-04 07:58:07', '2023-12-06 20:30:43'),
(380, 'App\\Models\\Admin', 2, 'MyApp', '0018d51b51c00520a21f1893d05776126654ad29a687994ff55974b2c2b622a6', '[\"*\"]', NULL, '2023-12-07 12:58:31', '2023-12-07 12:58:31'),
(381, 'App\\Models\\Admin', 2, 'MyApp', '7460706d9bf3c60ddaf02764999c77c4fbba7dfb21043b7d57c8466e3f758331', '[\"*\"]', NULL, '2023-12-07 12:59:22', '2023-12-07 12:59:22'),
(382, 'App\\Models\\Admin', 2, 'MyApp', 'a176930e00775faff77d7ae06430664667838f6fd33b381a748dda1322fb21e1', '[\"*\"]', NULL, '2023-12-07 13:01:08', '2023-12-07 13:01:08'),
(383, 'App\\Models\\Admin', 2, 'MyApp', '5f5e141b81c5c542644019334c2e9f8eff23bda66436ab4cb4ea4eb6881b95ca', '[\"*\"]', NULL, '2023-12-07 13:08:51', '2023-12-07 13:08:51'),
(384, 'App\\Models\\Admin', 2, 'MyApp', '3d6617c3875affe88906410562f05fd33a72837af2ed6cfed2b6e27b1d116b05', '[\"*\"]', NULL, '2023-12-07 13:19:58', '2023-12-07 13:19:58'),
(385, 'App\\Models\\Admin', 2, 'MyApp', '441222b94ec916fc82bfe4051180f0e759e1254fc402ab1367f059bdfe3c2264', '[\"*\"]', NULL, '2023-12-07 13:22:26', '2023-12-07 13:22:26'),
(386, 'App\\Models\\Admin', 2, 'MyApp', 'ca59b9fda97d769f9076387832b4a4dac0dbfc77535bd1574d7a564f7a0fc52a', '[\"*\"]', NULL, '2023-12-07 13:33:48', '2023-12-07 13:33:48'),
(387, 'App\\Models\\Admin', 2, 'MyApp', 'c30a0524dd34ea8054cc131d53887644a4283c252ce4fa6f8f225bd7dd19333b', '[\"*\"]', NULL, '2023-12-07 13:35:41', '2023-12-07 13:35:41'),
(388, 'App\\Models\\Admin', 2, 'MyApp', 'd14fd018c660d8b8c8e0c97c938c986d30d0825428c9c0e1e53a12f83dd3c50f', '[\"*\"]', NULL, '2023-12-07 13:37:22', '2023-12-07 13:37:22'),
(389, 'App\\Models\\Admin', 2, 'MyApp', '333bca568e1c7d4eb851d0dc6deb97d8d43f48b5b6242320f75689bf08392269', '[\"*\"]', NULL, '2023-12-07 13:53:24', '2023-12-07 13:53:24'),
(390, 'App\\Models\\Admin', 2, 'MyApp', 'b5b0e99acf3057649bab92595a076238ac23cccb32ee12bb14e2025fa40847e7', '[\"*\"]', NULL, '2023-12-07 13:55:52', '2023-12-07 13:55:52'),
(391, 'App\\Models\\Admin', 2, 'MyApp', '21d419acc6cb2d086e4b5d8b39552c2d49c41040fd0e9e00480281dc8dc596a2', '[\"*\"]', NULL, '2023-12-07 13:59:19', '2023-12-07 13:59:19'),
(392, 'App\\Models\\Admin', 2, 'MyApp', '098f7f860c65b790996db251642224f7ae69e4ddcb4e766f3880a38ce3ce7330', '[\"*\"]', NULL, '2023-12-07 14:00:54', '2023-12-07 14:00:54'),
(393, 'App\\Models\\Admin', 2, 'MyApp', '81df0f353af9b6c635f0b82f01639292082fdeeb6ac05098ff9846bd73ed5b43', '[\"*\"]', NULL, '2023-12-07 14:08:14', '2023-12-07 14:08:14'),
(394, 'App\\Models\\Admin', 2, 'MyApp', '94c0ca4dd42d2275ec85eca44c360dfbb9af66298904c9c4cdee7a2eeacd9824', '[\"*\"]', NULL, '2023-12-07 14:36:36', '2023-12-07 14:36:36'),
(395, 'App\\Models\\Admin', 2, 'MyApp', '5061b9ce12402da8122fbfe9e4063b4130d1003d9996de89fc35e0c822ed9723', '[\"*\"]', NULL, '2023-12-07 14:37:07', '2023-12-07 14:37:07'),
(396, 'App\\Models\\Admin', 2, 'MyApp', 'cfacb9fc788240c95bbda3a843a984f790c8fd2c5cb429a712571705c48a337f', '[\"*\"]', '2023-12-10 19:38:05', '2023-12-07 14:38:11', '2023-12-10 19:38:05'),
(397, 'App\\Models\\Admin', 2, 'MyApp', 'e10a663bcb454535709b5d82f2ed570187fefcee6a30ad18db529367ce7c1c7d', '[\"*\"]', '2023-12-15 06:19:26', '2023-12-07 15:00:21', '2023-12-15 06:19:26'),
(398, 'App\\Models\\Admin', 2, 'MyApp', 'ffe49b012cd076616d79aa605d2682bafd73e7dada3e619ce177a3c5f874f6ce', '[\"*\"]', NULL, '2023-12-10 19:21:35', '2023-12-10 19:21:35'),
(399, 'App\\Models\\Admin', 2, 'MyApp', 'c7e0034e3145551398a02ed3aaf1b9de8e44367d0fa8f59dc458c987788215c9', '[\"*\"]', NULL, '2023-12-10 19:22:04', '2023-12-10 19:22:04'),
(400, 'App\\Models\\Admin', 17, 'MyApp', '5e5e1a2d5f6242a510f7e6515a73c7cc5dadbb64797229b678dca8bd68f551aa', '[\"*\"]', '2023-12-10 19:24:36', '2023-12-10 19:23:23', '2023-12-10 19:24:36'),
(401, 'App\\Models\\Admin', 17, 'MyApp', 'accb3a61e4515a4fcbf4f44ac1fb887b43c815ac343a69b827242c51cf1a96d1', '[\"*\"]', '2023-12-11 01:36:16', '2023-12-10 19:28:35', '2023-12-11 01:36:16'),
(402, 'App\\Models\\Admin', 17, 'MyApp', '9e7a07948555634bec9b026e53d904b0905bb74fe5123f39d3d88ad32f9a97aa', '[\"*\"]', NULL, '2023-12-10 19:39:41', '2023-12-10 19:39:41'),
(403, 'App\\Models\\Admin', 2, 'MyApp', 'e0006633e356a10b6e2af024484596c871c9200a5f6e9ff4d4120cc4a98669ed', '[\"*\"]', '2023-12-25 18:54:52', '2023-12-10 19:42:38', '2023-12-25 18:54:52'),
(404, 'App\\Models\\Admin', 17, 'MyApp', 'df7b1e50573573a7f95871e8f3e725e80a3127b3d9f501f0231794a313c90c4d', '[\"*\"]', NULL, '2023-12-10 19:44:26', '2023-12-10 19:44:26'),
(405, 'App\\Models\\Admin', 17, 'MyApp', '04b7742b86bc77673983b50e415f9d7a1c2702946d6995cb0de5ed8e092087c4', '[\"*\"]', NULL, '2023-12-10 19:46:11', '2023-12-10 19:46:11'),
(406, 'App\\Models\\Admin', 2, 'MyApp', '5c9e3df383a66f715dbb3089ddcac68230c76f8123c46c6409106ddb54e3d596', '[\"*\"]', '2023-12-12 16:34:12', '2023-12-12 16:34:01', '2023-12-12 16:34:12'),
(407, 'App\\Models\\Admin', 17, 'MyApp', '938c8dbad29f1384a176d482cfb3ea0a358bb5eac3e1f235a6ab28e2722123d2', '[\"*\"]', '2023-12-13 21:55:46', '2023-12-13 21:55:21', '2023-12-13 21:55:46'),
(408, 'App\\Models\\Admin', 2, 'MyApp', 'f46c6a94c924edcad274f7d6feeaed20d64de32372fb373fca76140b07f41db9', '[\"*\"]', '2023-12-15 12:42:04', '2023-12-15 10:29:37', '2023-12-15 12:42:04'),
(409, 'App\\Models\\Admin', 2, 'MyApp', 'e1912c998971428a3d1ceef3fe9bffafcc46a7890d041f1aa07792757e757053', '[\"*\"]', '2023-12-21 22:10:40', '2023-12-15 16:56:32', '2023-12-21 22:10:40'),
(410, 'App\\Models\\Admin', 2, 'MyApp', '45b489fcbe86e7a8c6d3709f04b52cd42347e62b847bea6280c5b66c1225b187', '[\"*\"]', '2023-12-15 16:58:56', '2023-12-15 16:58:31', '2023-12-15 16:58:56'),
(411, 'App\\Models\\Admin', 2, 'MyApp', 'd8065293cd74c5b225afa111825941f1af475686cb9433e6b8e4273f41f650e7', '[\"*\"]', '2023-12-21 13:56:07', '2023-12-21 13:55:22', '2023-12-21 13:56:07'),
(412, 'App\\Models\\Admin', 2, 'MyApp', 'efad2ed267a5bd4ce951e56c87d5f02fa75e210449dc5b70a7c7561a1703646c', '[\"*\"]', '2023-12-21 16:27:55', '2023-12-21 16:26:45', '2023-12-21 16:27:55'),
(413, 'App\\Models\\Admin', 2, 'MyApp', '05cb412945a33ed8c033f135a1f50ef2228e2c2b3ce4366d4b5a1ff1b8503dda', '[\"*\"]', '2023-12-21 16:30:32', '2023-12-21 16:28:13', '2023-12-21 16:30:32'),
(414, 'App\\Models\\Admin', 2, 'MyApp', 'bf9eaf58b5b5a017107be3e081b13e4504aa1cf18d7e47facdd2d00a301e7026', '[\"*\"]', '2023-12-21 17:11:07', '2023-12-21 16:32:48', '2023-12-21 17:11:07'),
(415, 'App\\Models\\Admin', 2, 'MyApp', 'a0caf81293e2df9c9c10630b4474b3c799f579ed549cacf53965015b4ccf42c7', '[\"*\"]', '2023-12-23 21:38:11', '2023-12-23 21:37:56', '2023-12-23 21:38:11'),
(416, 'App\\Models\\Admin', 13, 'MyApp', '55e43f192896a96523c5f92bdd2323996c4d052c30a7e9fca2b73801a56109da', '[\"*\"]', NULL, '2023-12-25 14:14:17', '2023-12-25 14:14:17'),
(417, 'App\\Models\\Admin', 13, 'MyApp', 'ed7ecfa69121a68bcada9fe99c660b2b0982a4828794aa1b5b8674f4b4343dcb', '[\"*\"]', NULL, '2023-12-25 14:21:16', '2023-12-25 14:21:16'),
(418, 'App\\Models\\Admin', 13, 'MyApp', 'd0ede1144544945d0cfa42237162db1d999466449984ecf5e643e37109107d79', '[\"*\"]', NULL, '2023-12-25 14:22:10', '2023-12-25 14:22:10'),
(419, 'App\\Models\\Admin', 13, 'MyApp', 'b195289554f6ad27c8f246b4f898898b850f124f2800341fef2dd0b2f1e4428d', '[\"*\"]', '2023-12-25 19:12:39', '2023-12-25 16:34:07', '2023-12-25 19:12:39');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `productCode` varchar(191) NOT NULL,
  `ProductName` varchar(191) NOT NULL DEFAULT 'none',
  `isQr` tinyint(1) NOT NULL DEFAULT 0,
  `cat` varchar(20) NOT NULL,
  `catName` varchar(191) NOT NULL,
  `price` varchar(191) NOT NULL,
  `qty` varchar(191) NOT NULL,
  `qty_sold` varchar(191) NOT NULL DEFAULT '0',
  `pcs` varchar(191) NOT NULL DEFAULT 'none',
  `total` varchar(191) NOT NULL DEFAULT 'none',
  `fact_price` varchar(191) NOT NULL DEFAULT 'none',
  `fact_total` varchar(191) NOT NULL DEFAULT 'none',
  `img_url` varchar(191) NOT NULL DEFAULT 'none',
  `mult_imgurl` varchar(191) NOT NULL DEFAULT 'none',
  `tags` longtext DEFAULT NULL,
  `active` varchar(191) NOT NULL DEFAULT 'off',
  `subscriber` varchar(50) NOT NULL DEFAULT 'TEALTD',
  `description` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `productCode`, `ProductName`, `isQr`, `cat`, `catName`, `price`, `qty`, `qty_sold`, `pcs`, `total`, `fact_price`, `fact_total`, `img_url`, `mult_imgurl`, `tags`, `active`, `subscriber`, `description`, `created_at`, `updated_at`) VALUES
(1, 'NYOTA', 'none', 0, '1', 'China', '80', '2574', '430', 'none', '205920', 'none', 'none', 'none', 'none', 'NYOTA COMPLAST', 'none', 'TEALTD', 'none', '2022-04-22 02:52:03', '2022-10-27 17:02:37'),
(2, 'KIIKAPU NPL', 'ny', 0, '1', 'China', '50', '57', '0', 'none', '2850', 'none', 'none', 'none', 'none', 'IBIKAPU NPL', 'none', 'TEALTD', 'none', '2022-04-22 02:54:03', '2022-09-20 22:08:49'),
(3, 'BIBERO', 'none', 0, '1', 'China', '110', '120', '0', 'none', '13200', 'none', 'none', 'none', 'none', 'BIBERO YO MU IKARITO PARAS', 'none', 'TEALTD', 'none', '2022-04-22 02:56:36', '2022-10-27 17:08:27'),
(4, 'VICTORIA', 'none', 0, '1', 'China', '43', '425', '0', 'none', '18275', 'none', 'none', 'none', 'none', 'AKADOBO 10L', 'none', 'TEALTD', 'none', '2022-04-22 03:11:13', '2022-10-27 18:00:22'),
(5, 'MELANO', 'none', 0, '1', 'China', '130', '22', '0', 'none', '2860', 'none', 'none', 'none', 'none', 'MELANO', 'none', 'TEALTD', 'none', '2022-04-22 03:11:49', '2022-10-14 22:58:13'),
(6, 'PETIT BASSIN PARAS', 'none', 0, '1', 'China', '65', '40', '0', 'none', '2600', 'none', 'none', 'none', 'none', '135', 'none', 'TEALTD', 'none', '2022-04-22 03:14:26', '2022-10-14 23:46:25'),
(7, 'IGIKOMBE 702', 'none', 0, '1', 'China', '62', '36', '0', 'none', '2232', 'none', 'none', 'none', 'none', 'AGAKOMBE GATO PARAS', 'none', 'TEALTD', 'none', '2022-04-22 03:18:35', '2022-10-27 16:08:12'),
(8, '1101 IGIKOMBE', 'none', 0, '2', 'Kenya', '65', '9', '0', 'none', '585', 'none', 'none', 'none', 'none', 'IGIKOMBE GITO PARAS', 'none', 'TEALTD', 'none', '2022-04-22 03:20:10', NULL),
(9, 'MACON', 'none', 0, '1', 'China', '65', '684', '0', 'none', '44460', 'none', 'none', 'none', 'none', 'MEKA', 'none', 'TEALTD', 'none', '2022-04-22 03:22:15', '2022-10-27 17:03:06'),
(10, '105', 'none', 0, '1', 'China', '65', '102', '0', 'none', '6630', 'none', 'none', 'none', 'none', 'PETIT BASSIN 12DZ PARAS', 'none', 'TEALTD', 'none', '2022-04-22 03:27:50', '2022-10-14 23:43:33'),
(11, 'AKADOBO 5L', 'none', 0, '2', 'Kenya', '55', '20', '0', 'none', '1100', 'none', 'none', 'none', 'none', 'AKADOBO', 'none', 'TEALTD', 'none', '2022-04-22 03:29:27', NULL),
(12, 'TAORMINA', 'none', 0, '2', 'Kenya', '75', '10', '0', 'none', '750', 'none', 'none', 'none', 'none', 'INDOBO COMPLAST', 'none', 'TEALTD', 'none', '2022-04-22 03:32:49', NULL),
(13, 'KABUMBU NPL', 'none', 0, '1', 'China', '50', '88', '0', 'none', '4400', 'none', 'none', 'none', 'none', 'KABUMBU', 'none', 'TEALTD', 'none', '2022-04-22 03:40:51', '2022-10-27 18:03:43'),
(14, 'BOWL 312', 'none', 0, '1', 'China', '35', '60', '0', 'none', '2100', 'none', 'none', 'none', 'none', 'BORE', 'none', 'TEALTD', 'none', '2022-04-22 03:41:41', '2022-09-20 21:25:25'),
(15, 'BOWL 911', 'none', 0, '1', 'China', '55', '113', '0', 'none', '6215', 'none', 'none', 'none', 'none', 'BORE', 'none', 'TEALTD', 'none', '2022-04-22 03:44:10', '2022-10-15 00:04:29'),
(16, 'KATABUGALI', 'none', 0, '2', 'Kenya', '80', '7', '0', 'none', '560', 'none', 'none', 'none', 'none', 'KATABUGALI', 'none', 'TEALTD', 'none', '2022-04-22 03:44:49', NULL),
(17, 'BOWL 712', 'none', 0, '1', 'China', '45', '201', '0', 'none', '9045', 'none', 'none', 'none', 'none', 'BORE', 'none', 'TEALTD', 'none', '2022-04-22 03:50:54', '2022-10-14 23:46:50'),
(18, 'AKAYUNGIRO', 'none', 0, '1', 'China', '85', '53', '0', 'none', '4505', 'none', 'none', 'none', 'none', 'PASOIR Y\'ICYAYI', 'none', 'TEALTD', 'none', '2022-04-22 03:54:10', '2022-10-27 17:09:09'),
(19, '81211', 'none', 0, '1', 'China', '90', '218', '0', 'none', '19620', 'none', 'none', 'none', 'none', 'melamine 81211', 'none', 'TEALTD', 'none', '2022-06-08 00:09:41', '2022-12-13 20:48:49'),
(20, '81207', 'none', 0, '1', 'China', '35', '166', '0', 'none', '5810', 'none', 'none', 'none', 'none', 'melamine bowl 81207', 'none', 'TEALTD', 'none', '2022-06-08 00:11:03', '2022-12-13 20:48:13'),
(21, '2099-8', 'none', 0, '1', 'China', '50', '120', '0', 'none', '6000', 'none', 'none', 'none', 'none', 'melamine bowl 2099-8', 'none', 'TEALTD', 'none', '2022-06-08 00:12:02', '2022-11-16 17:47:28'),
(22, '2388-9', 'none', 0, '1', 'China', '83', '20', '0', 'none', '1660', 'none', 'none', 'none', 'none', 'melamine 2388-9', 'none', 'TEALTD', 'none', '2022-06-08 01:16:51', NULL),
(23, '01-3310', 'none', 0, '1', 'China', '50', '20', '0', 'none', '1000', 'none', 'none', 'none', 'none', 'melamine 01-3310', 'none', 'TEALTD', 'none', '2022-06-08 01:17:37', NULL),
(24, '1009.9', 'none', 0, '1', 'China', '75', '20', '0', 'none', '1500', 'none', 'none', 'none', 'none', 'melamine 1009.9', 'none', 'TEALTD', 'none', '2022-06-08 01:18:59', NULL),
(25, '668-11', 'none', 0, '1', 'China', '80', '20', '0', 'none', '1600', 'none', 'none', 'none', 'none', 'melamine 668-11', 'none', 'TEALTD', 'none', '2022-06-08 01:19:51', NULL),
(26, '2019-07', 'none', 0, '1', 'China', '35', '210', '0', 'none', '7350', 'none', 'none', 'none', 'none', 'melamine bowl 2019-07', 'none', 'TEALTD', 'none', '2022-06-08 01:21:34', '2022-12-13 20:11:10'),
(27, '3111', 'none', 0, '1', 'China', '78', '2', '0', 'none', '156', 'none', 'none', 'none', 'none', 'melamine 3111', 'none', 'TEALTD', 'none', '2022-06-08 01:26:50', NULL),
(28, '2019-110', 'none', 0, '1', 'China', '82', '175', '0', 'none', '14350', 'none', 'none', 'none', 'none', 'melamine 2019-110', 'none', 'TEALTD', 'none', '2022-06-08 01:28:11', '2022-12-13 20:10:08'),
(29, '201907.7', 'none', 0, '1', 'China', '35', '102', '0', 'none', '3570', 'none', 'none', 'none', 'none', 'melamine 201907.7', 'none', 'TEALTD', 'none', '2022-06-08 01:29:30', '2022-10-28 19:33:59'),
(30, '3989', 'none', 0, '1', 'China', '83', '20', '0', 'none', '1660', 'none', 'none', 'none', 'none', 'melamine 3989', 'none', 'TEALTD', 'none', '2022-06-08 01:30:47', NULL),
(31, '5648', 'none', 0, '1', 'China', '83', '20', '0', 'none', '1660', 'none', 'none', 'none', 'none', 'melamine 5648', 'none', 'TEALTD', 'none', '2022-06-08 01:31:38', NULL),
(32, 'A6', 'none', 0, '1', 'China', '35', '180', '0', 'none', '6300', 'none', 'none', 'none', 'none', 'melamine A6', 'none', 'TEALTD', 'none', '2022-06-08 01:33:27', '2022-12-13 20:10:51'),
(33, '5988', 'none', 0, '1', 'China', '83', '20', '0', 'none', '1660', 'none', 'none', 'none', 'none', 'melamine 5988', 'none', 'TEALTD', 'none', '2022-06-08 01:34:38', NULL),
(34, '5728', 'none', 0, '1', 'China', '83', '20', '0', 'none', '1660', 'none', 'none', 'none', 'none', 'melamine 5728', 'none', 'TEALTD', 'none', '2022-06-08 01:35:20', NULL),
(35, '2355-9', 'none', 0, '1', 'China', '83', '20', '0', 'none', '1660', 'none', 'none', 'none', 'none', 'melamine 2355-9', 'none', 'TEALTD', 'none', '2022-06-08 01:36:08', NULL),
(36, '2355-10', 'none', 0, '1', 'China', '98', '20', '0', 'none', '1960', 'none', 'none', 'none', 'none', 'melamine 2355-10', 'none', 'TEALTD', 'none', '2022-06-08 01:37:52', NULL),
(37, '3275-10', 'none', 0, '1', 'China', '54', '20', '0', 'none', '1080', 'none', 'none', 'none', 'none', 'melamine 3275-10', 'none', 'TEALTD', 'none', '2022-06-08 01:38:52', NULL),
(38, '3275-12', 'none', 0, '1', 'China', '65', '20', '0', 'none', '1300', 'none', 'none', 'none', 'none', 'melamine 3275-12', 'none', 'TEALTD', 'none', '2022-06-08 01:40:04', NULL),
(39, '3275-14', 'none', 0, '1', 'China', '60', '45', '0', 'none', '2700', 'none', 'none', 'none', 'none', 'melamine 3275-14', 'none', 'TEALTD', 'none', '2022-06-08 01:41:10', NULL),
(40, '2292-10', 'none', 0, '1', 'China', '75', '10', '0', 'none', '750', 'none', 'none', 'none', 'none', 'melamine 2292-10', 'none', 'TEALTD', 'none', '2022-06-08 01:44:54', NULL),
(41, '2217-10', 'none', 0, '1', 'China', '65', '23', '0', 'none', '1495', 'none', 'none', 'none', 'none', 'melamine 2217-10', 'none', 'TEALTD', 'none', '2022-06-08 01:45:48', NULL),
(42, '11-8.3313', 'none', 0, '1', 'China', '83', '30', '0', 'none', '2490', 'none', 'none', 'none', 'none', 'melamine 11-8.3313', 'none', 'TEALTD', 'none', '2022-06-08 01:47:12', NULL),
(43, '826C', 'none', 0, '1', 'China', '115', '130', '0', 'none', '14950', 'none', 'none', 'none', 'none', 'JAKONI', 'none', 'TEALTD', 'none', '2022-06-08 01:49:10', '2022-12-13 19:40:20'),
(44, 'A002', 'none', 0, '1', 'China', '110', '160', '0', 'none', '17600', 'none', 'none', 'none', 'none', 'BABYBATH', 'none', 'TEALTD', 'none', '2022-06-08 01:52:28', '2022-11-23 17:40:04'),
(45, 'IGISUKURA 3PCS', 'none', 0, '1', 'China', '170', '200', '0', 'none', '34000', 'none', 'none', 'none', 'none', 'IGISUKURA', 'none', 'TEALTD', 'none', '2022-06-08 01:53:46', '2022-12-13 20:49:03'),
(46, 'RHEONA', 'none', 0, '1', 'China', '77', '520', '0', 'none', '40040', 'none', 'none', 'none', 'none', 'RHEONA', 'none', 'TEALTD', 'none', '2022-06-08 01:54:39', '2022-12-13 19:48:57'),
(47, 'IKIYIKO', 'none', 0, '1', 'China', '60', '130', '0', 'none', '7800', 'none', 'none', 'none', 'none', 'IKIYIKO ROUGE', 'none', 'TEALTD', 'none', '2022-06-08 01:55:26', '2022-12-13 21:03:54'),
(48, 'ICYUMA 6cm', 'none', 0, '1', 'China', '85', '20', '0', 'none', '1700', 'none', 'none', 'none', 'none', 'ICYUMA  CY\'IMBAHO 6cm', 'none', 'TEALTD', 'none', '2022-06-08 01:57:10', '2022-10-28 18:19:44'),
(49, 'ICYUMA 7CM', 'none', 0, '1', 'China', '190', '20', '0', 'none', '3800', 'none', 'none', 'none', 'none', 'ICYUMA CY’URUBAHO', 'none', 'TEALTD', 'none', '2022-06-08 01:58:21', '2022-12-23 15:48:09'),
(50, 'KISU 6CM', 'none', 0, '1', 'China', '165', '120', '0', 'none', '19800', 'none', 'none', 'none', 'none', 'KISU CUMA', 'none', 'TEALTD', 'none', '2022-06-08 01:59:42', '2022-12-13 20:49:43'),
(51, 'KISU 7CM', 'none', 0, '1', 'China', '180', '60', '0', 'none', '10800', 'none', 'none', 'none', 'none', 'KISU CUMA 7CM', 'none', 'TEALTD', 'none', '2022-06-08 02:01:20', '2022-12-13 20:50:01'),
(52, 'KISU 9CM', 'none', 0, '1', 'China', '220', '50', '0', 'none', '11000', 'none', 'none', 'none', 'none', 'KISU MUPANGA 9CM', 'none', 'TEALTD', 'none', '2022-06-08 02:02:23', '2022-11-23 20:59:58'),
(53, '1732', 'none', 0, '1', 'China', '170', '106', '0', 'none', '18020', 'none', 'none', 'none', 'none', 'jET DE 3', 'none', 'TEALTD', 'none', '2022-06-08 02:06:11', '2022-12-13 20:21:33'),
(54, '5237', 'none', 0, '1', 'China', '150', '110', '0', 'none', '16500', 'none', 'none', 'none', 'none', 'null', 'none', 'TEALTD', 'none', '2022-06-08 02:08:28', '2022-12-13 20:21:11'),
(55, '3345-3', 'none', 0, '1', 'China', '130', '153', '0', 'none', '19890', 'none', 'none', 'none', 'none', 'HASHI', 'none', 'TEALTD', 'none', '2022-06-08 02:09:11', '2022-12-13 21:07:40'),
(56, '5568', 'none', 0, '1', 'China', '135', '80', '0', 'none', '10800', 'none', 'none', 'none', 'none', 'J4 CASSEROLLE', 'none', 'TEALTD', 'none', '2022-06-08 02:09:37', '2022-12-13 20:18:04'),
(57, '218.3.2L', 'none', 0, '1', 'China', '80', '200', '0', 'none', '16000', 'none', 'none', 'none', 'none', 'TEREMUSI MIFUNIKO MBIRI', 'none', 'TEALTD', 'none', '2022-06-08 02:10:52', '2022-11-23 23:01:01'),
(58, '16812', 'none', 0, '1', 'China', '40', '50', '0', 'none', '2000', 'none', 'none', 'none', 'none', 'IKIRAHURE', 'none', 'TEALTD', 'none', '2022-06-08 02:11:32', '2022-12-13 20:49:28'),
(59, 'HIPPO 45', 'none', 0, '1', 'China', '70', '220', '0', 'none', '15400', 'none', 'none', 'none', 'none', 'KASHIMU', 'none', 'TEALTD', 'none', '2022-06-10 04:14:48', '2022-10-27 17:09:42'),
(60, 'PLATE407', 'none', 0, '1', 'China', '75', '197', '0', 'none', '14775', 'none', 'none', 'none', 'none', 'SAHANI PARAS 407', 'none', 'TEALTD', 'none', '2022-06-10 04:20:45', '2022-10-27 17:13:16'),
(61, 'BASSIN 4546', 'none', 0, '1', 'China', '80', '160', '0', 'none', '12800', 'none', 'none', 'none', 'none', 'NYOTA PIRATE PARAS', 'none', 'TEALTD', 'none', '2022-06-10 04:22:46', '2022-10-27 17:11:44'),
(62, 'PETIT BASSIN 103', 'none', 0, '1', 'China', '30', '160', '0', 'none', '4800', 'none', 'none', 'none', 'none', 'PETIT BASSIN 103', 'none', 'TEALTD', 'none', '2022-06-10 04:25:08', '2022-10-14 23:06:02'),
(63, 'KOPU 1201', 'none', 0, '1', 'China', '70', '13', '0', 'none', '910', 'none', 'none', 'none', 'none', 'IGIKOMBE PARAS 1201', 'none', 'TEALTD', 'none', '2022-06-10 04:29:40', '2022-09-21 19:32:32'),
(64, '3239B-10', 'none', 0, '1', 'none', '75', '10', '0', 'none', '750', 'none', 'none', 'none', 'none', 'MELAMINE 3239B-10', 'none', 'TEALTD', 'none', '2022-09-20 18:32:21', NULL),
(65, '32398-11', 'none', 0, '1', 'China', '83', '20', '0', 'none', '1660', 'none', 'none', 'none', 'none', 'MELAMINE 32398-11', 'none', 'TEALTD', 'none', '2022-09-20 18:33:31', NULL),
(66, '29011', 'none', 0, '1', 'China', '65', '20', '0', 'none', '1300', 'none', 'none', 'none', 'none', 'MELAMINE 29011', 'none', 'TEALTD', 'none', '2022-09-20 18:34:39', NULL),
(67, '9101-12', 'none', 0, '1', 'China', '60', '20', '0', 'none', '1200', 'none', 'none', 'none', 'none', 'MELAMINE 911-12', 'none', 'TEALTD', 'none', '2022-09-20 18:35:35', NULL),
(68, '739010', 'none', 0, '1', 'China', '60', '30', '0', 'none', '1800', 'none', 'none', 'none', 'none', 'MELAMINE 739010', 'none', 'TEALTD', 'none', '2022-09-20 18:40:43', NULL),
(69, '12514', 'none', 0, '1', 'China', '70', '30', '0', 'none', '2100', 'none', 'none', 'none', 'none', 'MELAMINE 12514', 'none', 'TEALTD', 'none', '2022-09-20 18:41:27', NULL),
(70, '80011', 'none', 0, '1', 'China', '90', '30', '0', 'none', '2700', 'none', 'none', 'none', 'none', 'MELAMINE 80011', 'none', 'TEALTD', 'none', '2022-09-20 18:42:18', '2022-09-20 20:13:11'),
(71, '22010', 'none', 0, '1', 'China', '60', '50', '0', 'none', '3000', 'none', 'none', 'none', 'none', 'MELAMINE 22010', 'none', 'TEALTD', 'none', '2022-09-20 18:42:56', '2022-09-20 20:22:34'),
(72, '3301-8', 'none', 0, '1', 'China', '83', '15', '0', 'none', '1245', 'none', 'none', 'none', 'none', 'MELAMINE 3301-8', 'none', 'TEALTD', 'none', '2022-09-20 18:43:45', NULL),
(73, '2099-10.5', 'none', 0, '1', 'China', '72', '30', '0', 'none', '2160', 'none', 'none', 'none', 'none', 'MELAMINE 2099-10.5', 'none', 'TEALTD', 'none', '2022-09-20 18:44:33', NULL),
(74, '2009F', 'none', 0, '1', 'China', '83', '20', '0', 'none', '1660', 'none', 'none', 'none', 'none', 'MELAMINE 2009F', 'none', 'TEALTD', 'none', '2022-09-20 18:45:07', NULL),
(75, '2010F', 'none', 0, '1', 'China', '100', '33', '0', 'none', '3300', 'none', 'none', 'none', 'none', 'MELAMINE 2010F', 'none', 'TEALTD', 'none', '2022-09-20 18:45:42', '2022-12-13 19:55:52'),
(76, '3298-10', 'none', 0, '1', 'China', '75', '26', '0', 'none', '1950', 'none', 'none', 'none', 'none', 'MELAMINE 3298-10', 'none', 'TEALTD', 'none', '2022-09-20 18:46:39', NULL),
(77, '3879', 'none', 0, '1', 'China', '83', '21', '0', 'none', '1743', 'none', 'none', 'none', 'none', 'MELAMINE 3879', 'none', 'TEALTD', 'none', '2022-09-20 18:47:19', NULL),
(78, '3849', 'none', 0, '1', 'China', '83', '5', '0', 'none', '415', 'none', 'none', 'none', 'none', 'MELAMINE 3849', 'none', 'TEALTD', 'none', '2022-09-20 18:47:54', NULL),
(79, '2354-9', 'none', 0, '1', 'China', '83', '20', '0', 'none', '1660', 'none', 'none', 'none', 'none', 'MELAMINE 2354-9', 'none', 'TEALTD', 'none', '2022-09-20 18:48:31', NULL),
(80, '2354-10', 'none', 0, '1', 'China', '75', '20', '0', 'none', '1500', 'none', 'none', 'none', 'none', 'MELAMINE 2354-10', 'none', 'TEALTD', 'none', '2022-09-20 18:49:15', NULL),
(81, 'JAGE 021', 'none', 0, '1', 'China', '115', '100', '0', 'none', '11500', 'none', 'none', 'none', 'none', 'JAGE 021', 'none', 'TEALTD', 'none', '2022-09-20 18:51:37', '2022-11-23 21:59:31'),
(82, '9025', 'none', 0, '1', 'China', '120', '60', '0', 'none', '7200', 'none', 'none', 'none', 'none', 'BOWL KABUMBU 9025', 'none', 'TEALTD', 'none', '2022-09-20 18:53:38', '2022-11-23 22:00:02'),
(83, '5507', 'none', 0, '1', 'China', '150', '67', '0', 'none', '10050', 'none', 'none', 'none', 'none', 'MUKEKA MUTO 5507', 'none', 'TEALTD', 'none', '2022-09-20 18:54:38', '2022-11-23 23:03:46'),
(84, '5509', 'none', 0, '1', 'China', '160', '30', '0', 'none', '4800', 'none', 'none', 'none', 'none', 'MUKEKA MUNINI 5509', 'none', 'TEALTD', 'none', '2022-09-20 18:55:09', '2022-11-16 18:05:59'),
(85, '2019-20', 'none', 0, '1', 'China', '190', '40', '0', 'none', '7600', 'none', 'none', 'none', 'none', '2019-20', 'none', 'TEALTD', 'none', '2022-09-20 18:56:31', '2022-11-23 16:11:08'),
(86, '291', 'none', 0, '1', 'China', '80', '60', '0', 'none', '4800', 'none', 'none', 'none', 'none', 'ROBINET 291', 'none', 'TEALTD', 'none', '2022-09-20 18:57:49', '2022-11-23 22:23:45'),
(87, '0058S', 'none', 0, '1', 'China', '125', '138', '0', 'none', '17250', 'none', 'none', 'none', 'none', 'BOWL 0058S(2889-5)', 'none', 'TEALTD', 'none', '2022-09-20 18:58:26', '2022-12-13 20:20:26'),
(88, '1619-3', 'none', 0, '1', 'China', '120', '191', '0', 'none', '22920', 'none', 'none', 'none', 'none', 'RUKAMBA 1619-3', 'none', 'TEALTD', 'none', '2022-09-20 19:00:45', '2022-12-13 20:02:30'),
(89, '6.5L FOOD KEEPER', 'none', 0, '1', 'China', '210', '100', '0', 'none', '21000', 'none', 'none', 'none', 'none', '6.5L FOOD KEEPER', 'none', 'TEALTD', 'none', '2022-09-20 19:02:57', '2022-11-23 21:04:59'),
(90, '9091 IGIKOMBE', 'none', 0, '1', 'China', '105', '50', '0', 'none', '5250', 'none', 'none', 'none', 'none', 'IGIKOMBE 9091', 'none', 'TEALTD', 'none', '2022-09-20 19:08:18', '2022-11-23 17:03:39'),
(91, '8868 IGIKOMBE', 'none', 0, '1', 'China', '105', '50', '0', 'none', '5250', 'none', 'none', 'none', 'none', 'IGIKOMBE 8868', 'none', 'TEALTD', 'none', '2022-09-20 19:08:51', '2022-11-16 19:20:23'),
(92, '3L ORIGINAL', 'none', 0, '1', 'China', '240', '175', '0', 'none', '42000', 'none', 'none', 'none', 'none', '3L ORIGINAL', 'none', 'TEALTD', 'none', '2022-09-20 19:09:35', '2022-12-13 21:02:57'),
(93, '2L FOOD KEEPER', 'none', 0, '1', 'China', '180', '70', '0', 'none', '12600', 'none', 'none', 'none', 'none', '2L FOOD KEEEPER', 'none', 'TEALTD', 'none', '2022-09-20 19:10:16', '2022-11-23 17:06:56'),
(94, 'ISINIYA 28CM', 'none', 0, '1', 'China', '130', '70', '0', 'none', '9100', 'none', 'none', 'none', 'none', 'ISINIYA 28CM', 'none', 'TEALTD', 'none', '2022-09-20 19:15:55', '2022-12-13 20:36:48'),
(95, 'ISINIYA 30CM', 'none', 0, '1', 'China', '125', '40', '0', 'none', '5000', 'none', 'none', 'none', 'none', 'ISINIYA 30CM', 'none', 'TEALTD', 'none', '2022-09-20 19:16:34', '2022-11-23 22:32:32'),
(96, 'ISINIYA 32CM', 'none', 0, '1', 'China', '130', '60', '0', 'none', '7800', 'none', 'none', 'none', 'none', 'ISINIYA 32CM', 'none', 'TEALTD', 'none', '2022-09-20 19:17:09', '2022-12-13 20:37:13'),
(97, 'ISINIYA 36CM', 'none', 0, '1', 'China', '120', '60', '0', 'none', '7200', 'none', 'none', 'none', 'none', 'ISINIYA 36CM', 'none', 'TEALTD', 'none', '2022-09-20 19:17:47', '2022-12-13 20:37:31'),
(98, 'ISINIYA 40CM', 'none', 0, '1', 'China', '120', '60', '0', 'none', '7200', 'none', 'none', 'none', 'none', 'ISINIYA 40CM', 'none', 'TEALTD', 'none', '2022-09-20 19:18:19', '2022-12-13 20:37:55'),
(99, '18CM UMUFUNIKO', 'none', 0, '1', 'China', '105', '150', '0', 'none', '15750', 'none', 'none', 'none', 'none', '18CM UMUFUNIKO', 'none', 'TEALTD', 'none', '2022-09-20 19:19:47', '2022-12-13 20:01:28'),
(100, '24CM UMUFUNIKO', 'none', 0, '1', 'China', '80', '110', '0', 'none', '8800', 'none', 'none', 'none', 'none', '24CM UMUFUNIKO', 'none', 'TEALTD', 'none', '2022-09-20 19:20:25', '2022-12-13 20:01:52'),
(101, '26CM UMUFUNIKO', 'none', 0, '1', 'China', '90', '95', '0', 'none', '8550', 'none', 'none', 'none', 'none', '26CM UMUFUNIKO', 'none', 'TEALTD', 'none', '2022-09-20 19:21:39', '2022-12-13 20:02:12'),
(102, '18CM SHIMU', 'none', 0, '1', 'China', '200', '120', '0', 'none', '24000', 'none', 'none', 'none', 'none', '18CM SHIMU', 'none', 'TEALTD', 'none', '2022-09-20 19:24:26', '2022-12-13 20:35:11'),
(103, '24CM SHIMU', 'none', 0, '1', 'China', '150', '120', '0', 'none', '18000', 'none', 'none', 'none', 'none', '24CM SHIMU', 'none', 'TEALTD', 'none', '2022-09-20 19:25:13', '2022-12-13 20:35:29'),
(104, '26CM SHIMU', 'none', 0, '1', 'China', '165', '110', '0', 'none', '18150', 'none', 'none', 'none', 'none', '26CM SHIMU', 'none', 'TEALTD', 'none', '2022-09-20 19:25:55', '2022-12-13 20:35:49'),
(105, '22CM PLAT', 'none', 0, '1', 'China', '150', '90', '0', 'none', '13500', 'none', 'none', 'none', 'none', '22CM PLAT', 'none', 'TEALTD', 'none', '2022-09-20 19:27:11', '2022-11-23 22:38:44'),
(106, '3011 IKIRAHURE', 'none', 0, '1', 'China', '50', '20', '0', 'none', '1000', 'none', 'none', 'none', 'none', 'IKIRAHURE 3011', 'none', 'TEALTD', 'none', '2022-09-20 19:27:54', NULL),
(107, '8520.2L', 'none', 0, '1', 'China', '55', '20', '0', 'none', '1100', 'none', 'none', 'none', 'none', 'TEREMUSI 8520.2L', 'none', 'TEALTD', 'none', '2022-09-20 19:33:47', NULL),
(108, '3859', 'none', 0, '1', 'China', '83', '20', '0', 'none', '1660', 'none', 'none', 'none', 'none', 'MELAMINE 3859', 'none', 'TEALTD', 'none', '2022-09-20 19:38:06', '2022-09-20 20:06:12'),
(109, '3939', 'none', 0, '1', 'China', '83', '15', '0', 'none', '1245', 'none', 'none', 'none', 'none', 'MELAMINE 3939', 'none', 'TEALTD', 'none', '2022-09-20 19:40:26', NULL),
(110, '5968', 'none', 0, '1', 'China', '83', '15', '0', 'none', '1245', 'none', 'none', 'none', 'none', 'MELAMINE 5968', 'none', 'TEALTD', 'none', '2022-09-20 19:42:17', NULL),
(111, '7578', 'none', 0, '1', 'China', '83', '30', '0', 'none', '2490', 'none', 'none', 'none', 'none', 'MELAMINE 7578', 'none', 'TEALTD', 'none', '2022-09-20 19:42:48', NULL),
(112, '3L FOOD PIRATE', 'none', 0, '1', 'China', '220', '125', '0', 'none', '27500', 'none', 'none', 'none', 'none', '3L FOOD PIRATE', 'none', 'TEALTD', 'none', '2022-09-20 19:45:37', '2022-12-13 21:03:30'),
(113, '1.8L SORORI', 'none', 0, '1', 'China', '210', '75', '0', 'none', '15750', 'none', 'none', 'none', 'none', '1.8L  SORORI', 'none', 'TEALTD', 'none', '2022-09-20 19:53:41', '2022-11-23 21:07:47'),
(114, 'SORORI 5PCS', 'none', 0, '1', 'China', '155', '194', '0', 'none', '30070', 'none', 'none', 'none', 'none', 'TD 5PCS OR JET DE 5', 'none', 'TEALTD', 'none', '2022-09-20 19:55:32', '2022-12-13 21:07:21'),
(115, 'YUZHANG WHITE', 'none', 0, '1', 'China', '125', '25', '0', 'none', '3125', 'none', 'none', 'none', 'none', 'YUZHANG WHITE', 'none', 'TEALTD', 'none', '2022-09-20 19:56:46', '2022-10-27 15:07:34'),
(116, 'YUZHANG RED', 'none', 0, '1', 'China', '130', '210', '0', 'none', '27300', 'none', 'none', 'none', 'none', 'YUZHANG RED', 'none', 'TEALTD', 'none', '2022-09-20 19:57:13', '2022-11-23 21:51:35'),
(117, 'YUZHANG JAUNE', 'none', 0, '1', 'China', '130', '135', '0', 'none', '17550', 'none', 'none', 'none', 'none', 'YUZHANG JAUNE', 'none', 'TEALTD', 'none', '2022-09-20 19:57:53', '2022-11-23 21:09:30'),
(118, '8822.3.2L', 'none', 0, '1', 'China', '85', '65', '0', 'none', '5525', 'none', 'none', 'none', 'none', 'TEREMUSI 8822.3.2L', 'none', 'TEALTD', 'none', '2022-09-20 19:58:48', '2022-11-23 17:34:03'),
(119, '512.3.2L', 'none', 0, '1', 'China', '85', '65', '0', 'none', '5525', 'none', 'none', 'none', 'none', 'TEREMUSI 512.3.2L', 'none', 'TEALTD', 'none', '2022-09-20 19:59:33', '2022-11-23 17:33:44'),
(120, '9869', 'none', 0, '1', 'China', '135', '126', '0', 'none', '17010', 'none', 'none', 'none', 'none', 'ELEGANCE 9869', 'none', 'TEALTD', 'none', '2022-09-20 20:01:54', '2022-12-13 20:51:22'),
(121, '9951', 'none', 0, '1', 'China', '110', '140', '0', 'none', '15400', 'none', 'none', 'none', 'none', 'ROBINET NTO', 'none', 'TEALTD', 'none', '2022-09-20 20:03:02', '2022-12-13 20:02:49'),
(122, '1685', 'none', 0, '1', 'China', '120', '119', '0', 'none', '14280', 'none', 'none', 'none', 'none', '1685', 'none', 'TEALTD', 'none', '2022-09-20 20:03:47', '2022-12-13 20:50:41'),
(123, '5188', 'none', 0, '1', 'China', '135', '120', '0', 'none', '16200', 'none', 'none', 'none', 'none', 'J2 JAMESPOT', 'none', 'TEALTD', 'none', '2022-09-20 20:05:17', '2022-12-13 20:51:38'),
(124, '2267B-10', 'none', 0, '1', 'China', '75', '10', '0', 'none', '750', 'none', 'none', 'none', 'none', 'MELAMINE 2267B-10', 'none', 'TEALTD', 'none', '2022-09-20 20:08:13', NULL),
(125, '2099-9.5', 'none', 0, '1', 'China', '65', '10', '0', 'none', '650', 'none', 'none', 'none', 'none', 'MELAMINE 2099-9.5', 'none', 'TEALTD', 'none', '2022-09-20 20:09:01', '2022-09-20 20:09:38'),
(126, '2319B-10', 'none', 0, '1', 'China', '75', '10', '0', 'none', '750', 'none', 'none', 'none', 'none', 'MELAMINE 2319B-10', 'none', 'TEALTD', 'none', '2022-09-20 20:12:31', NULL),
(127, '214B-16', 'none', 0, '1', 'China', '50', '50', '0', 'none', '2500', 'none', 'none', 'none', 'none', 'MELAMINE 214B-16', 'none', 'TEALTD', 'none', '2022-09-20 20:14:16', '2022-12-13 19:56:29'),
(128, '214B-19', 'none', 0, '1', 'China', '65', '50', '0', 'none', '3250', 'none', 'none', 'none', 'none', 'MELAMINE 214B-19', 'none', 'TEALTD', 'none', '2022-09-20 20:15:05', '2022-12-13 19:56:41'),
(129, '214B-21', 'none', 0, '1', 'China', '50', '49', '0', 'none', '2450', 'none', 'none', 'none', 'none', 'MELAMINE 214B-21', 'none', 'TEALTD', 'none', '2022-09-20 20:16:30', '2022-12-13 19:57:23'),
(130, '831010', 'none', 0, '1', 'China', '75', '40', '0', 'none', '3000', 'none', 'none', 'none', 'none', 'MELAMINE 831010', 'none', 'TEALTD', 'none', '2022-09-20 20:23:41', '2022-12-13 20:00:08'),
(131, '4311-7', 'none', 0, '1', 'China', '35', '20', '0', 'none', '700', 'none', 'none', 'none', 'none', 'MELAMINE 4311-7', 'none', 'TEALTD', 'none', '2022-09-20 20:24:12', '2022-09-20 20:24:39'),
(132, 'G109', 'none', 0, '1', 'China', '50', '50', '0', 'none', '2500', 'none', 'none', 'none', 'none', 'MELAMINE G109', 'none', 'TEALTD', 'none', '2022-09-20 20:25:37', '2022-12-13 21:00:31'),
(133, '6011', 'none', 0, '1', 'China', '78', '9', '0', 'none', '702', 'none', 'none', 'none', 'none', 'MELAMINE 6011', 'none', 'TEALTD', 'none', '2022-09-20 20:26:23', NULL),
(134, '3298-9', 'none', 0, '1', 'China', '65', '50', '0', 'none', '3250', 'none', 'none', 'none', 'none', 'MELAMINE 3298-9', 'none', 'TEALTD', 'none', '2022-09-20 20:27:05', '2022-12-13 20:31:39'),
(135, '12105.10.5', 'none', 0, '1', 'China', '80', '135', '0', 'none', '10800', 'none', 'none', 'none', 'none', 'MELAMINE 12105', 'none', 'TEALTD', 'none', '2022-09-20 20:28:02', '2022-11-16 17:47:51'),
(136, '3709', 'none', 0, '1', 'China', '75', '50', '0', 'none', '3750', 'none', 'none', 'none', 'none', 'MELAMINE 3709', 'none', 'TEALTD', 'none', '2022-09-20 20:28:27', '2022-12-13 19:43:14'),
(137, '1012', 'none', 0, '1', 'China', '60', '30', '0', 'none', '1800', 'none', 'none', 'none', 'none', 'MELAMINE 1012', 'none', 'TEALTD', 'none', '2022-09-20 20:29:09', NULL),
(138, '800-7', 'none', 0, '1', 'China', '35', '124', '0', 'none', '4340', 'none', 'none', 'none', 'none', 'MELAMINE 800-7', 'none', 'TEALTD', 'none', '2022-09-20 20:32:11', '2022-12-13 20:12:14'),
(139, '1012-95', 'none', 0, '1', 'China', '60', '30', '0', 'none', '1800', 'none', 'none', 'none', 'none', 'MELAMINE 1012-95', 'none', 'TEALTD', 'none', '2022-09-20 20:32:47', NULL),
(140, '1012-11', 'none', 0, '1', 'China', '82', '30', '0', 'none', '2460', 'none', 'none', 'none', 'none', 'MELAMINE 1012-11', 'none', 'TEALTD', 'none', '2022-09-20 20:33:28', NULL),
(141, '12007', 'none', 0, '1', 'China', '35', '160', '0', 'none', '5600', 'none', 'none', 'none', 'none', 'MELAMINE 12007', 'none', 'TEALTD', 'none', '2022-09-20 20:34:20', '2022-12-13 20:46:41'),
(142, '12010', 'none', 0, '1', 'China', '82', '160', '0', 'none', '13120', 'none', 'none', 'none', 'none', 'MELAMINE 12010', 'none', 'TEALTD', 'none', '2022-09-20 20:35:16', '2022-12-13 20:46:58'),
(143, '12011', 'none', 0, '1', 'China', '90', '100', '0', 'none', '9000', 'none', 'none', 'none', 'none', 'MELAMINE 12011', 'none', 'TEALTD', 'none', '2022-09-20 20:35:50', '2022-12-13 20:47:15'),
(144, 'KINGA 702', 'none', 0, '1', 'China', '52', '350', '0', 'none', '18200', 'none', 'none', 'none', 'none', 'IKINGA', 'none', 'TEALTD', 'none', '2022-09-20 20:46:14', '2022-10-27 18:00:48'),
(145, 'MERVEILLE 707B', 'none', 0, '1', 'China', '93', '205', '0', 'none', '19065', 'none', 'none', 'none', 'none', 'MERVEILLE', 'none', 'TEALTD', 'none', '2022-09-20 20:47:08', '2022-10-27 18:01:09'),
(146, '20L AMABARA', 'none', 0, '1', 'China', '83', '159', '0', 'none', '13197', 'none', 'none', 'none', 'none', '20L YAMABARA', 'none', 'TEALTD', 'none', '2022-09-20 20:48:19', '2022-10-27 17:52:17'),
(147, '20L UMWERU', 'none', 0, '2', 'Kenya', '82', '30', '0', 'none', '2460', 'none', 'none', 'none', 'none', '20L YUMWERU', 'none', 'TEALTD', 'none', '2022-09-20 20:49:09', NULL),
(148, '10L UMWERU', 'none', 0, '1', 'China', '55', '40', '0', 'none', '2200', 'none', 'none', 'none', 'none', '10L YUMWERU', 'none', 'TEALTD', 'none', '2022-09-20 20:50:24', '2022-10-27 17:49:32'),
(149, 'AKADOBO 3L IBARA', 'none', 0, '1', 'China', '38', '245', '0', 'none', '9310', 'none', 'none', 'none', 'none', '3L IBARA', 'none', 'TEALTD', 'none', '2022-09-20 20:51:39', '2022-10-15 00:03:37'),
(150, 'KOPU KALISE GT-14', 'none', 0, '1', 'China', '87', '119', '0', 'none', '10353', 'none', 'none', 'none', 'none', 'KOPU KALISE', 'none', 'TEALTD', 'none', '2022-09-20 21:34:49', '2022-10-27 17:07:37'),
(151, 'SISSETTE', 'none', 0, '1', 'China', '75', '60', '0', 'none', '4500', 'none', 'none', 'none', 'none', 'SISSETTE', 'none', 'TEALTD', 'none', '2022-09-20 21:36:42', '2022-10-27 17:08:51'),
(152, 'BASSIN 545', 'none', 0, '1', 'China', '75', '20', '0', 'none', '1500', 'none', 'none', 'none', 'none', 'LIWUWA 545', 'none', 'TEALTD', 'none', '2022-09-20 21:46:58', '2022-10-14 23:45:49'),
(153, 'KIKAPU PARAS', 'none', 0, '1', 'China', '75', '100', '0', 'none', '7500', 'none', 'none', 'none', 'none', 'KIKAPU PARS', 'none', 'TEALTD', 'none', '2022-09-20 21:47:50', '2022-10-27 17:08:09'),
(154, 'ENTENOIR', 'none', 0, '1', 'China', '70', '50', '0', 'none', '3500', 'none', 'none', 'none', 'none', 'ENTENOIR UMUBIRIKIRA', 'none', 'TEALTD', 'none', '2022-09-20 21:50:40', '2022-10-27 18:17:36'),
(155, 'IGITUNGA KENPOLLY', 'none', 0, '1', 'China', '84', '252', '0', 'none', '21168', 'none', 'none', 'none', 'none', 'IGITUNGA KENPOLLY', 'none', 'TEALTD', 'none', '2022-09-20 22:05:30', '2022-10-27 17:55:13'),
(156, 'BASSIN 607', 'none', 0, '1', 'China', '105', '70', '0', 'none', '7350', 'none', 'none', 'none', 'none', 'BASSIN 607', 'none', 'TEALTD', 'none', '2022-09-20 22:10:26', '2022-10-27 18:01:28'),
(157, 'BASSIN 1001 S1', 'none', 0, '1', 'China', '78', '27', '0', 'none', '2106', 'none', 'none', 'none', 'none', 'SUPER ONE 1001', 'none', 'TEALTD', 'none', '2022-09-21 20:45:17', '2022-10-15 00:14:13'),
(158, 'BASSIM 1002 S1', 'none', 0, '4', 'Rwanda', '90', '2', '0', 'none', '180', 'none', 'none', 'none', 'none', 'SUPER  ONE 1002', 'none', 'TEALTD', 'none', '2022-09-21 22:15:42', NULL),
(159, 'BASSIN 1003 S1', 'none', 0, '1', 'China', '60', '70', '0', 'none', '4200', 'none', 'none', 'none', 'none', 'SUPER ONE 1003 KABUMBU', 'none', 'TEALTD', 'none', '2022-09-21 22:16:30', '2022-10-27 18:06:51'),
(160, 'BASSIN 1004 S1', 'none', 0, '1', 'China', '75', '190', '0', 'none', '14250', 'none', 'none', 'none', 'none', 'SUPER ONE 1004', 'none', 'TEALTD', 'none', '2022-09-21 22:18:00', '2022-10-27 18:06:01'),
(161, 'BASSIN 1005 S1', 'none', 0, '1', 'China', '75', '30', '0', 'none', '2250', 'none', 'none', 'none', 'none', 'SUPER ONE 1005', 'none', 'TEALTD', 'none', '2022-09-21 22:18:30', '2022-10-27 18:16:21'),
(162, 'BASSIN 1006 S1', 'none', 0, '1', 'China', '82', '146', '0', 'none', '11972', 'none', 'none', 'none', 'none', 'SUPER ONE 1006', 'none', 'TEALTD', 'none', '2022-09-21 22:19:05', '2022-10-27 18:06:27'),
(163, 'AKADOBO SUPER ONE 1007', 'none', 0, '1', 'China', '58', '210', '0', 'none', '12180', 'none', 'none', 'none', 'none', 'SUPER ONE 1007', 'none', 'TEALTD', 'none', '2022-09-21 22:20:03', '2022-10-27 18:08:25'),
(164, 'SUPER DRUM SUPER ONE 1008', 'none', 0, '1', 'China', '60', '120', '0', 'none', '7200', 'none', 'none', 'none', 'none', 'SUPER ONE 1008', 'none', 'TEALTD', 'none', '2022-09-21 22:20:44', '2022-10-27 18:16:01'),
(165, 'JUG SUPER ONE 1009', 'none', 0, '1', 'China', '40', '83', '0', 'none', '3320', 'none', 'none', 'none', 'none', 'SUPER ONE 1009', 'none', 'TEALTD', 'none', '2022-09-21 22:21:25', '2022-10-27 18:07:58'),
(166, 'IGIKOMBE SUPER ONE 1010', 'none', 0, '1', 'China', '68', '55', '0', 'none', '3740', 'none', 'none', 'none', 'none', 'IGIKOMBE SUPER ONE 1010', 'none', 'TEALTD', 'none', '2022-09-21 22:22:01', '2022-10-27 18:13:49'),
(167, 'IGIKOMBE SUPER ONE 1011', 'none', 0, '4', 'Rwanda', '50', '1', '0', 'none', '50', 'none', 'none', 'none', 'none', 'IGIKOMBE SUPER ONE 1011', 'none', 'TEALTD', 'none', '2022-09-21 22:22:46', NULL),
(168, 'IGIKOMBE SUPER ONE 1012', 'none', 0, '1', 'China', '58', '31', '0', 'none', '1798', 'none', 'none', 'none', 'none', 'IGIKOMBE SUPER ONE 1012', 'none', 'TEALTD', 'none', '2022-09-21 22:23:31', '2022-10-27 18:14:19'),
(169, 'ISAHANI SUPER ONE 1015', 'none', 0, '1', 'China', '80', '178', '0', 'none', '14240', 'none', 'none', 'none', 'none', 'SAHANI SUPER ONE 1015', 'none', 'TEALTD', 'none', '2022-09-21 22:24:04', '2022-10-27 18:17:56'),
(170, 'BONANZA', 'none', 0, '1', 'China', '33', '300', '0', 'none', '9900', 'none', 'none', 'none', 'none', 'BONANZA', 'none', 'TEALTD', 'none', '2022-10-14 22:57:39', '2022-10-27 17:03:32'),
(171, 'BUMBA', 'none', 0, '1', 'China', '110', '70', '0', 'none', '7700', 'none', 'none', 'none', 'none', 'BUMBA', 'none', 'TEALTD', 'none', '2022-10-14 23:53:23', '2022-10-27 17:53:35'),
(172, 'BASSIN 610', 'none', 0, '1', 'China', '45', '12', '0', 'none', '540', 'none', 'none', 'none', 'none', 'BASSIN 610', 'none', 'TEALTD', 'none', '2022-10-14 23:55:34', '2022-10-27 18:04:01'),
(173, 'SIMBA', 'none', 0, '1', 'China', '84', '83', '0', 'none', '6972', 'none', 'none', 'none', 'none', 'SIMBA', 'none', 'TEALTD', 'none', '2022-10-14 23:59:43', '2022-10-27 17:50:30'),
(174, 'TEREMUSI 3810.3L', 'none', 0, '1', 'China', '150', '50', '0', 'none', '7500', 'none', 'none', 'none', 'none', 'TEREMUSI ALWAYS', 'none', 'TEALTD', 'none', '2022-10-15 00:23:00', '2022-12-13 19:34:37'),
(175, 'TEREMUSI 1000T.1L', 'none', 0, '1', 'China', '155', '30', '0', 'none', '4650', 'none', 'none', 'none', 'none', 'TEREMUS ALWAYS 1000T.1L', 'none', 'TEALTD', 'none', '2022-10-15 00:24:53', '2022-11-16 19:17:37'),
(176, 'BENOIR 1803', 'none', 0, '1', 'China', '130', '60', '0', 'none', '7800', 'none', 'none', 'none', 'none', 'BABYBATH 1803', 'none', 'TEALTD', 'none', '2022-10-15 00:51:02', '2022-11-16 19:17:58'),
(177, 'INDOBO Y\'ABANA 3378', 'none', 0, '1', 'China', '130', '50', '0', 'none', '6500', 'none', 'none', 'none', 'none', 'INDOBO 3378', 'none', 'TEALTD', 'none', '2022-10-15 00:52:17', '2022-11-16 19:18:22'),
(178, 'INDOBO Y\'ABANA 3379', 'none', 0, '1', 'China', '130', '20', '0', 'none', '2600', 'none', 'none', 'none', 'none', 'INDOBO 3379', 'none', 'TEALTD', 'none', '2022-10-15 00:53:58', NULL),
(179, 'BENOIR 2021 COFFEE', 'none', 0, '1', 'China', '130', '20', '0', 'none', '2600', 'none', 'none', 'none', 'none', 'BABYBATH COFFEE', 'none', 'TEALTD', 'none', '2022-10-15 00:55:51', NULL),
(180, '5L FOOD KEEPER', 'none', 0, '1', 'China', '190', '60', '0', 'none', '11400', 'none', 'none', 'none', 'none', '5L FOOD KEEPER', 'none', 'TEALTD', 'none', '2022-10-15 01:03:36', '2022-11-23 21:03:45'),
(181, '81210', 'none', 0, '1', 'China', '82', '150', '0', 'none', '12300', 'none', 'none', 'none', 'none', 'MELAMINE 81210', 'none', 'TEALTD', 'none', '2022-10-15 01:13:38', '2022-12-13 20:48:32'),
(182, '5239', 'none', 0, '1', 'China', '130', '81', '0', 'none', '10530', 'none', 'none', 'none', 'none', 'GITUNGURU ORIGINAL', 'none', 'TEALTD', 'none', '2022-10-27 15:19:49', '2022-12-13 20:50:58'),
(183, '3011', 'none', 0, '1', 'China', '130', '90', '0', 'none', '11700', 'none', 'none', 'none', 'none', 'CAROCARO', 'none', 'TEALTD', 'none', '2022-10-27 15:21:28', '2022-12-13 20:21:49'),
(184, '6071', 'none', 0, '1', 'China', '120', '50', '0', 'none', '6000', 'none', 'none', 'none', 'none', 'JUG 6071', 'none', 'TEALTD', 'none', '2022-10-27 15:23:38', '2022-11-23 22:02:30'),
(185, '9961', 'none', 0, '1', 'China', '140', '15', '0', 'none', '2100', 'none', 'none', 'none', 'none', 'FOOD WARMER NINI', 'none', 'TEALTD', 'none', '2022-10-27 15:24:45', '2022-11-16 18:08:45'),
(186, '9962', 'none', 0, '1', 'China', '135', '15', '0', 'none', '2025', 'none', 'none', 'none', 'none', 'FOOD WARMER NTO', 'none', 'TEALTD', 'none', '2022-10-27 15:25:11', '2022-11-16 18:09:08'),
(187, '2978A', 'none', 0, '1', 'China', '125', '20', '0', 'none', '2500', 'none', 'none', 'none', 'none', 'BEGE A', 'none', 'TEALTD', 'none', '2022-10-27 16:21:16', '2022-10-28 19:45:59'),
(188, '2978B', 'none', 0, '1', 'China', '125', '110', '0', 'none', '13750', 'none', 'none', 'none', 'none', 'BEGE B', 'none', 'TEALTD', 'none', '2022-10-27 16:21:47', '2022-12-13 20:03:37'),
(189, 'IGIKOMBE 1308', 'none', 0, '2', 'Kenya', '64', '30', '0', 'none', '1920', 'none', 'none', 'none', 'none', 'IGIKOMBE 1308', 'none', 'TEALTD', 'none', '2022-10-27 17:05:15', NULL),
(190, 'IGIKOMBE 1208', 'none', 0, '2', 'Kenya', '65', '50', '0', 'none', '3250', 'none', 'none', 'none', 'none', 'IGIKOMBE 1208', 'none', 'TEALTD', 'none', '2022-10-27 17:06:29', NULL),
(191, '16L  INDOBO UMWERU', 'none', 0, '2', 'Kenya', '70', '20', '0', 'none', '1400', 'none', 'none', 'none', 'none', '16L INDOBO UMWERU', 'none', 'TEALTD', 'none', '2022-10-27 17:48:50', NULL),
(192, 'BASSIN IMIKONDO HALAL', 'none', 0, '2', 'Kenya', '67', '50', '0', 'none', '3350', 'none', 'none', 'none', 'none', 'BASSIN MAXI HALAL', 'none', 'TEALTD', 'none', '2022-10-27 17:51:29', NULL),
(193, 'igikombe 3313', 'none', 0, '1', 'China', '95', '10', '0', 'none', '950', 'none', 'none', 'none', 'none', 'igikombe 3313', 'none', 'TEALTD', 'none', '2022-10-28 17:38:22', NULL),
(194, 'igikombe 8880', 'none', 0, '1', 'China', '105', '55', '0', 'none', '5775', 'none', 'none', 'none', 'none', 'igikombe 8880', 'none', 'TEALTD', 'none', '2022-10-28 17:39:43', '2022-12-13 20:24:44'),
(195, 'igikombe 1116', 'none', 0, '1', 'China', '95', '40', '0', 'none', '3800', 'none', 'none', 'none', 'none', 'igikombe 1116', 'none', 'TEALTD', 'none', '2022-10-28 17:41:25', '2022-12-13 20:25:02'),
(196, 'IGIKOMBE 8849', 'none', 0, '1', 'China', '105', '35', '0', 'none', '3675', 'none', 'none', 'none', 'none', 'IGIKOMBE8849', 'none', 'TEALTD', 'none', '2022-10-28 17:42:52', '2022-11-23 21:02:25'),
(197, 'GITUNGURU PIRATE 339', 'none', 0, '1', 'China', '170', '52', '0', 'none', '8840', 'none', 'none', 'none', 'none', 'GITUNGURU PIRATE 339', 'none', 'TEALTD', 'none', '2022-10-28 17:55:12', '2022-12-13 20:20:48'),
(198, 'TEREMUSI PIRATE 8810.3.2L', 'none', 0, '1', 'China', '103', '65', '0', 'none', '6695', 'none', 'none', 'none', 'none', 'TEREMUSI PIRATE 8810.3.2L', 'none', 'TEALTD', 'none', '2022-10-28 17:59:30', '2022-12-13 20:52:00'),
(199, '3095', 'none', 0, '1', 'China', '60', '30', '0', 'none', '1800', 'none', 'none', 'none', 'none', 'MELAMINE 3095', 'none', 'TEALTD', 'none', '2022-10-28 18:11:28', NULL),
(200, '3235-15', 'none', 0, '1', 'China', '75', '20', '0', 'none', '1500', 'none', 'none', 'none', 'none', 'MERAMINE 3235-15', 'none', 'TEALTD', 'none', '2022-10-28 18:12:35', NULL),
(201, '2393-11', 'none', 0, '1', 'China', '70', '40', '0', 'none', '2800', 'none', 'none', 'none', 'none', 'MELAMINE 2393-11', 'none', 'TEALTD', 'none', '2022-10-28 18:13:57', NULL),
(202, 'RUSHE NDENDE', 'none', 0, '1', 'China', '140', '30', '0', 'none', '4200', 'none', 'none', 'none', 'none', 'RUSHE NDENDE', 'none', 'TEALTD', 'none', '2022-10-28 19:10:05', '2022-11-23 20:59:28'),
(203, 'RUSHE MATUNDU', 'none', 0, '1', 'China', '155', '20', '0', 'none', '3100', 'none', 'none', 'none', 'none', 'RUSHE MATUNDU', 'none', 'TEALTD', 'none', '2022-10-28 19:11:07', '2022-11-23 20:57:20'),
(204, 'RUSHE YUBURURU', 'none', 0, '1', 'China', '140', '30', '0', 'none', '4200', 'none', 'none', 'none', 'none', 'RUSHE YUBURURU', 'none', 'TEALTD', 'none', '2022-10-28 19:13:20', '2022-11-23 20:58:04'),
(205, '201910', 'none', 0, '1', 'China', '75', '18', '0', 'none', '1350', 'none', 'none', 'none', 'none', 'MELAMINE 201910', 'none', 'TEALTD', 'none', '2022-10-28 19:35:43', NULL),
(206, '201911', 'none', 0, '1', 'China', '82', '20', '0', 'none', '1640', 'none', 'none', 'none', 'none', 'MELAMINE 201911', 'none', 'TEALTD', 'none', '2022-10-28 19:36:39', NULL),
(207, '9810', 'none', 0, '1', 'China', '70', '50', '0', 'none', '3500', 'none', 'none', 'none', 'none', 'MELAMINE 9810', 'none', 'TEALTD', 'none', '2022-10-28 19:37:27', '2022-12-13 19:51:14'),
(208, '21110', 'none', 0, '1', 'China', '80', '50', '0', 'none', '4000', 'none', 'none', 'none', 'none', 'MELAMINE 21110', 'none', 'TEALTD', 'none', '2022-10-28 19:38:19', '2022-12-13 19:54:43'),
(209, '21107', 'none', 0, '1', 'China', '40', '50', '0', 'none', '2000', 'none', 'none', 'none', 'none', 'MELAMINE BOWL 21107', 'none', 'TEALTD', 'none', '2022-10-28 19:39:20', '2022-12-13 19:52:52'),
(210, '320191', 'none', 0, '1', 'China', '60', '50', '0', 'none', '3000', 'none', 'none', 'none', 'none', 'MELAMINE 320191', 'none', 'TEALTD', 'none', '2022-10-28 19:40:36', NULL),
(211, 'IPANU 25CM', 'none', 0, '1', 'China', '40', '10', '0', 'none', '400', 'none', 'none', 'none', 'none', 'IPANU 25CM', 'none', 'TEALTD', 'none', '2022-10-28 19:49:03', NULL),
(212, 'IPANU 27CM', 'none', 0, '1', 'China', '50', '10', '0', 'none', '500', 'none', 'none', 'none', 'none', 'IPANU 27CM', 'none', 'TEALTD', 'none', '2022-10-28 19:49:43', NULL),
(213, '28012', 'none', 0, '1', 'China', '79', '50', '0', 'none', '3950', 'none', 'none', 'none', 'none', 'melamine 28012', 'none', 'TEALTD', 'none', '2022-11-16 17:49:40', NULL),
(214, 'KETTLE 2L', 'none', 0, '1', 'China', '95', '20', '0', 'none', '1900', 'none', 'none', 'none', 'none', 'KETO 2L', 'none', 'TEALTD', 'none', '2022-11-16 17:51:45', NULL),
(215, 'SORORI 18-22', 'none', 0, '1', 'China', '155', '15', '0', 'none', '2325', 'none', 'none', 'none', 'none', 'ROUGE BORDEAU', 'none', 'TEALTD', 'none', '2022-11-16 17:54:10', NULL),
(216, 'SORORI 22-26', 'none', 0, '1', 'China', '150', '15', '0', 'none', '2250', 'none', 'none', 'none', 'none', 'ROUGE BORDEAU 22-26', 'none', 'TEALTD', 'none', '2022-11-16 17:55:32', NULL),
(217, 'TEREMUSI 7150 0.5L', 'none', 0, '1', 'China', '155', '10', '0', 'none', '1550', 'none', 'none', 'none', 'none', 'TEREMUSI ALWAYS 0.5L', 'none', 'TEALTD', 'none', '2022-11-16 18:03:33', NULL),
(218, '20CM SHIMU', 'none', 0, '1', 'China', '200', '60', '0', 'none', '12000', 'none', 'none', 'none', 'none', '20CM SHIMU', 'none', 'TEALTD', 'none', '2022-11-23 16:15:51', '2022-12-13 20:36:10'),
(219, '28CM SHIMU', 'none', 0, '1', 'China', '165', '50', '0', 'none', '8250', 'none', 'none', 'none', 'none', '28CM SHIMU', 'none', 'TEALTD', 'none', '2022-11-23 16:18:04', '2022-12-13 20:36:29'),
(220, 'KISU 8CM', 'none', 0, '1', 'China', '185', '30', '0', 'none', '5550', 'none', 'none', 'none', 'none', 'KISU 8CM', 'none', 'TEALTD', 'none', '2022-11-23 20:51:38', '2022-12-13 20:50:22'),
(221, 'TD-3PCS', 'none', 0, '1', 'China', '255', '20', '0', 'none', '5100', 'none', 'none', 'none', 'none', 'TD-3PCS', 'none', 'TEALTD', 'none', '2022-11-23 20:54:31', '2022-12-13 20:53:14'),
(222, 'IKYIKO JAUNE', 'none', 0, '1', 'China', '70', '90', '0', 'none', '6300', 'none', 'none', 'none', 'none', 'KIJIKO JAUNE', 'none', 'TEALTD', 'none', '2022-11-23 21:23:17', '2022-12-13 21:06:09'),
(223, 'LUNCH BOX NINI 6.5L', 'none', 0, '1', 'China', '155', '10', '0', 'none', '1550', 'none', 'none', 'none', 'none', 'LUNCH BOX NINI 6.5L', 'none', 'TEALTD', 'none', '2022-11-23 22:08:50', NULL),
(224, 'LUNCH BOX NTO 4.5L', 'none', 0, '1', 'China', '145', '15', '0', 'none', '2175', 'none', 'none', 'none', 'none', 'LUNCH BOX NTO 4.5L', 'none', 'TEALTD', 'none', '2022-11-23 22:10:12', NULL),
(225, '20CM SORORI', 'none', 0, '1', 'China', '90', '10', '0', 'none', '900', 'none', 'none', 'none', 'none', '20CM SORORI', 'none', 'TEALTD', 'none', '2022-11-23 22:13:46', NULL),
(226, '22CM SORORI', 'none', 0, '1', 'China', '95', '10', '0', 'none', '950', 'none', 'none', 'none', 'none', '22 CM SORORI', 'none', 'TEALTD', 'none', '2022-11-23 22:14:54', NULL),
(227, '24CM SORORI', 'none', 0, '1', 'China', '80', '20', '0', 'none', '1600', 'none', 'none', 'none', 'none', '24CM SORORI', 'none', 'TEALTD', 'none', '2022-11-23 22:17:52', NULL),
(228, 'AKAYUNGIRO CHINE', 'none', 0, '1', 'China', '100', '20', '0', 'none', '2000', 'none', 'none', 'none', 'none', 'AKAYUNGIRO CHINE', 'none', 'TEALTD', 'none', '2022-11-23 22:29:55', NULL),
(229, 'MY HOME 5PCS', 'none', 0, '1', 'China', '160', '10', '0', 'none', '1600', 'none', 'none', 'none', 'none', 'MY HOME', 'none', 'TEALTD', 'none', '2022-11-23 23:07:52', NULL),
(230, 'TEREMUS 520-2.0L KANYERE', 'none', 0, '1', 'China', '55', '50', '0', 'none', '2750', 'none', 'none', 'none', 'none', 'KANYERE 520 2.0L', 'none', 'TEALTD', 'none', '2022-12-13 19:38:55', NULL),
(231, '3710', 'none', 0, '1', 'China', '85', '30', '0', 'none', '2550', 'none', 'none', 'none', 'none', 'MELAMINE 3710', 'none', 'TEALTD', 'none', '2022-12-13 19:44:15', NULL),
(232, 'KISU NO 9', 'none', 0, '1', 'China', '240', '30', '0', 'none', '7200', 'none', 'none', 'none', 'none', 'KISU MUPANGA NOIRE', 'none', 'TEALTD', 'none', '2022-12-13 19:48:13', NULL),
(233, 'BORE JE5 UMWERU', 'none', 0, '1', 'China', '150', '40', '0', 'none', '6000', 'none', 'none', 'none', 'none', 'BORE UMWERU', 'none', 'TEALTD', 'none', '2022-12-13 19:50:06', NULL),
(234, '1214-12 MELAMINE', 'none', 0, '1', 'China', '65', '60', '0', 'none', '3900', 'none', 'none', 'none', 'none', 'MELAMINE 1214-12', 'none', 'TEALTD', 'none', '2022-12-13 19:58:53', '2022-12-13 20:31:02'),
(235, '26110 MELAMINE', 'none', 0, '1', 'China', '82', '30', '0', 'none', '2460', 'none', 'none', 'none', 'none', 'MELAMINE 26110', 'none', 'TEALTD', 'none', '2022-12-13 20:09:39', NULL),
(236, '2011-10 MELAMINE', 'none', 0, '1', 'China', '65', '30', '0', 'none', '1950', 'none', 'none', 'none', 'none', 'MELAMINE 2011-10', 'none', 'TEALTD', 'none', '2022-12-13 20:14:18', NULL),
(237, '9009 MELAMINE', 'none', 0, '1', 'China', '100', '30', '0', 'none', '3000', 'none', 'none', 'none', 'none', 'MELAMINE 9009', 'none', 'TEALTD', 'none', '2022-12-13 20:15:39', NULL),
(238, '1910 MELAMINE', 'none', 0, '1', 'China', '100', '30', '0', 'none', '3000', 'none', 'none', 'none', 'none', 'MELAMINE 1910', 'none', 'TEALTD', 'none', '2022-12-13 20:16:47', NULL),
(239, '589 MELAMINE', 'none', 0, '1', 'China', '60', '50', '0', 'none', '3000', 'none', 'none', 'none', 'none', 'MELAMINE 589', 'none', 'TEALTD', 'none', '2022-12-13 20:17:29', NULL),
(240, '3635 IGIKOMBE', 'none', 0, '1', 'China', '105', '20', '0', 'none', '2100', 'none', 'none', 'none', 'none', 'IGIKOMBE 3635 MY HOME', 'none', 'TEALTD', 'none', '2022-12-13 20:29:32', NULL),
(241, '2328B-10 MELAMINE', 'none', 0, '1', 'China', '60', '30', '0', 'none', '1800', 'none', 'none', 'none', 'none', 'MELAMINE 2328B-10', 'none', 'TEALTD', 'none', '2022-12-13 20:33:56', NULL),
(242, 'RHEONA 3PCS', 'none', 0, '1', 'China', '75', '40', '0', 'none', '3000', 'none', 'none', 'none', 'none', 'RHEONA 3PCS', 'none', 'TEALTD', 'none', '2022-12-13 20:55:41', NULL),
(243, '2384-9 MELAMINE', 'none', 0, '1', 'China', '75', '30', '0', 'none', '2250', 'none', 'none', 'none', 'none', 'MELAMINE 2384-9', 'none', 'TEALTD', 'none', '2022-12-13 20:58:12', NULL),
(244, '3315-8 MELAMINE', 'none', 0, '1', 'China', '75', '10', '0', 'none', '750', 'none', 'none', 'none', 'none', 'MELAMINE 3315-8', 'none', 'TEALTD', 'none', '2022-12-13 20:59:25', NULL),
(245, '2383-9 MELAMINE', 'none', 0, '1', 'China', '75', '40', '0', 'none', '3000', 'none', 'none', 'none', 'none', 'MELAMINE 2383-9', 'none', 'TEALTD', 'none', '2022-12-13 21:01:21', NULL),
(246, '3302-8 MELAMINE', 'none', 0, '1', 'China', '79', '64', '0', 'none', '5056', 'none', 'none', 'none', 'none', 'MELAMINE 3302-8', 'none', 'TEALTD', 'none', '2022-12-13 21:02:30', '2023-01-25 15:37:45'),
(255, 'viva_1693508831', 'viva', 0, '1', 'China', '40', '200', '160', '20', '8000', 'none', 'none', 'none', 'none', '20', 'on', 'TEALTD', 'on', '2023-08-31 19:07:11', NULL),
(256, 'bebe_1696882154', 'bebe', 0, '1', 'China', '40', '200', '30', '20', '8000', 'none', 'none', 'none', 'none', '20', 'on', 'TEALTD', 'on', '2023-10-09 20:09:14', NULL),
(257, 'bebe_1696882236', 'bebe', 0, '1', 'China', '40', '400', '0', '20', '8000', 'none', 'none', 'none', 'none', '20', 'on', 'TEALTD', 'on', '2023-10-09 20:10:36', NULL),
(258, 'veve_1697829456', 'veve', 0, '1', 'China', '40', '700', '0', '20', '8000', 'none', 'none', 'none', 'none', '20', 'on', 'TEALTD', 'on', '2023-10-20 19:17:36', NULL),
(259, 'bido_1698592481', 'bido', 1, '1', 'China', '50', '500', '0', '20', '20000', 'none', 'none', 'none', 'none', '20', 'on', 'TEALTD', 'on', '2023-10-29 15:14:41', NULL),
(260, 'phonekop_1700726700', 'phonekop', 0, '1', 'China', '30', '500', '0', '20', '20000', 'none', 'none', 'none', 'none', 'phone my model', 'on', 'TEALTD', 'on', '2023-11-23 08:05:00', NULL),
(261, 'webcam_1700726985', 'webcam', 1, '1', 'China', '40', '500', '0', '30', '30000', 'none', 'none', 'none', 'none', 'phone my model', 'on', 'TEALTD', 'on', '2023-11-23 08:09:45', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `promotions`
--

CREATE TABLE `promotions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `uidCreator` varchar(191) NOT NULL,
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `token` varchar(191) NOT NULL DEFAULT 'none',
  `promoName` varchar(191) NOT NULL DEFAULT 'none',
  `promo_msg` varchar(191) NOT NULL DEFAULT 'none',
  `reach` varchar(191) NOT NULL DEFAULT 'none',
  `gain` varchar(191) NOT NULL DEFAULT 'none',
  `type_service` varchar(191) NOT NULL DEFAULT 'none',
  `started_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `ended_date` timestamp NULL DEFAULT current_timestamp(),
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `promotions`
--

INSERT INTO `promotions` (`id`, `uid`, `uidCreator`, `subscriber`, `token`, `promoName`, `promo_msg`, `reach`, `gain`, `type_service`, `started_date`, `ended_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 'kivuBucket_1672353285', 'Kayiranga_1668876519', 'TEALTD', 'none', 'kivuBucket2', 'If you reach 500 i will give you 50 i will give you', '500', '50', 'none', '2023-06-07 10:00:00', '2023-06-23 10:00:00', 'close', '2022-12-29 22:34:45', '2023-06-02 15:56:18'),
(2, 'Nyota_1672353378', 'Kayiranga_1668876519', 'TEALTD', 'none', 'Nyota', 'i will give you 300 nugura ibintu bya 1000$', '1200', '350', 'none', '0000-00-00 00:00:00', '2023-12-29 22:34:45', 'On', '2022-12-29 22:36:18', NULL),
(10, 'promoeric_1683916240', 'kebineericMuna_1668935525', 'TEALTD', 'none', 'promoeric', 'gdgd 300 egeg 10', '300', '10', 'none', '2023-05-12 10:00:00', '2023-05-12 09:00:00', 'close', '2023-05-12 18:30:40', NULL),
(11, 'chito_1683916343', 'kebineericMuna_1668935525', 'TEALTD', 'none', 'Vita', 'i will give you 300 nugura ibintu bya 1000$', '1200', '350', 'none', '2023-05-12 10:00:00', '2023-05-27 10:00:00', 'close', '2023-05-12 18:32:23', '2023-05-13 02:59:33'),
(12, 'test_1685628324', 'kebineericMuna_1668935525', 'TEALTD', 'none', 'test', 'If you reach 40 i will give you 30 i will give you', '40', '30', 'none', '2023-06-01 10:00:00', '2023-06-23 10:00:00', 'close', '2023-06-01 14:05:24', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quickbonuses`
--

CREATE TABLE `quickbonuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quickUid` varchar(191) NOT NULL DEFAULT 'none',
  `productName` varchar(191) NOT NULL DEFAULT 'none',
  `qty` varchar(191) NOT NULL DEFAULT 'none',
  `price` varchar(191) NOT NULL DEFAULT 'none',
  `status` varchar(191) NOT NULL DEFAULT 'on',
  `bonusType` varchar(191) NOT NULL DEFAULT 'none',
  `giftName` varchar(191) NOT NULL DEFAULT 'none',
  `giftValues` varchar(191) NOT NULL DEFAULT 'none',
  `giftPerPcs` varchar(191) NOT NULL DEFAULT '1',
  `giftMin` varchar(191) NOT NULL DEFAULT '1',
  `moneyMin` varchar(191) NOT NULL DEFAULT '1',
  `bonusValue` varchar(191) NOT NULL DEFAULT 'none',
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `description` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quickbonuses`
--

INSERT INTO `quickbonuses` (`id`, `quickUid`, `productName`, `qty`, `price`, `status`, `bonusType`, `giftName`, `giftValues`, `giftPerPcs`, `giftMin`, `moneyMin`, `bonusValue`, `uidCreator`, `subscriber`, `description`, `created_at`, `updated_at`) VALUES
(1, 'nyota_1679509986', 'nyota', '50', '40', 'on', 'Money', '0', '0', '0', '0', '3', '0.04', 'kebineericMuna_1668935525', 'TEALTD', 'If you reach', '2023-03-22 18:33:06', '2023-03-22 18:33:06'),
(2, 'meka_1679510326', 'meka', '40', '40', 'on', 'Gift', 'p0-17', '60', '0.25', '5', '0', '0.25', 'kebineericMuna_1668935525', 'TEALTD', 'If you reach', '2023-03-22 18:38:46', '2023-03-22 18:38:46');

-- --------------------------------------------------------

--
-- Table structure for table `quickbonushists`
--

CREATE TABLE `quickbonushists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quickbosubmithists`
--

CREATE TABLE `quickbosubmithists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quickbosubmits`
--

CREATE TABLE `quickbosubmits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL DEFAULT 'none',
  `quickUid` varchar(191) NOT NULL DEFAULT 'none',
  `uidUser` varchar(191) NOT NULL DEFAULT 'none',
  `productName` varchar(191) NOT NULL DEFAULT 'none',
  `qty` varchar(191) NOT NULL DEFAULT 'none',
  `price` varchar(191) NOT NULL DEFAULT 'none',
  `total` varchar(191) NOT NULL DEFAULT 'none',
  `status` varchar(191) NOT NULL DEFAULT 'on',
  `bonusType` varchar(191) NOT NULL DEFAULT 'none',
  `giftName` varchar(191) NOT NULL DEFAULT 'none',
  `giftPcs` varchar(191) NOT NULL DEFAULT 'none',
  `bonusValue` varchar(191) NOT NULL DEFAULT 'none',
  `totBonusValue` varchar(191) NOT NULL DEFAULT 'none',
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `description` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quickbosubmits`
--

INSERT INTO `quickbosubmits` (`id`, `uid`, `quickUid`, `uidUser`, `productName`, `qty`, `price`, `total`, `status`, `bonusType`, `giftName`, `giftPcs`, `bonusValue`, `totBonusValue`, `uidCreator`, `subscriber`, `description`, `created_at`, `updated_at`) VALUES
(3, 'Quick_1679514059', 'nyota_1679509986', 'viki', 'nyota', '3', '40', '120', 'confirm', 'Money', '0', 'null', '0.04', '0', 'kebineericMuna_1668935525', 'TEALTD', 'none', '2023-03-22 19:40:59', '2023-03-22 19:40:59'),
(5, 'Quick_1679514406', 'nyota_1679509986', 'juma', 'nyota', '555', '40', '22200', 'on', 'Money', '0', 'null', '0.04', '22.2', 'kebineericMuna_1668935525', 'TEALTD', 'none', '2023-03-22 19:46:46', '2023-03-22 19:46:46'),
(6, 'Quick_1679514406', 'meka_1679510326', 'juma', 'meka', '445', '40', '17800', 'on', 'Gift', 'p0-17', '111', '0.25', '111', 'kebineericMuna_1668935525', 'TEALTD', 'none', '2023-03-22 19:47:37', '2023-03-22 23:02:37');

-- --------------------------------------------------------

--
-- Table structure for table `redeemeds`
--

CREATE TABLE `redeemeds` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `status` varchar(191) NOT NULL DEFAULT 'redeemed',
  `balance` varchar(191) NOT NULL DEFAULT '0',
  `bonus` varchar(191) NOT NULL DEFAULT '0',
  `CBalance` varchar(191) NOT NULL DEFAULT 'US',
  `CBonus` varchar(191) NOT NULL DEFAULT 'US',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `description` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `redeemeds`
--

INSERT INTO `redeemeds` (`id`, `uid`, `uidCreator`, `status`, `balance`, `bonus`, `CBalance`, `CBonus`, `subscriber`, `description`, `created_at`, `updated_at`) VALUES
(1, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'redeemed', '400', '0', 'US', 'US', 'none', 'descr', '2023-02-17 19:32:49', NULL),
(2, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'redeemed', '100', '0', 'US', 'US', 'none', 'descr', '2023-02-17 19:35:41', NULL),
(3, 'kebineericMuna_1674592764', 'kebineericMuna_1681471130', 'redeemed', '0', '300', 'US', 'US', 'none', 'descr', '2023-02-17 19:45:10', NULL),
(4, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'redeemed', '0', '300', 'US', 'US', 'none', 'descr', '2023-04-13 08:28:46', NULL),
(5, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'redeemed', '0', '50', 'US', 'US', 'none', 'descr', '2023-04-13 08:32:45', NULL),
(6, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'redeemed', '0', '50', 'US', 'US', 'none', 'descr', '2023-04-13 08:33:24', NULL),
(7, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'redeemed', '0', '50', 'US', 'US', 'none', 'descr', '2023-04-13 08:39:53', NULL),
(8, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'redeemed', '0', '30', 'US', 'US', 'none', 'descr', '2023-04-13 08:40:42', NULL),
(9, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'redeemed', '0', '10', 'US', 'US', 'none', 'descr', '2023-04-13 08:44:08', NULL),
(10, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'redeemed', '0', '10', 'US', 'US', 'none', 'descr', '2023-04-13 08:47:42', NULL),
(11, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'redeemed', '0', '10', 'US', 'US', 'none', 'descr', '2023-04-13 08:48:30', NULL),
(12, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'redeemed', '10', '0', 'US', 'US', 'none', 'descr', '2023-04-13 09:18:17', NULL),
(13, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'redeemed', '0', '10', 'US', 'US', 'none', 'descr', '2023-04-13 10:25:09', NULL),
(14, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'redeemed', '15', '0', 'US', 'US', 'none', 'descr', '2023-04-13 10:25:28', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `repaid_users`
--

CREATE TABLE `repaid_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `uidPaid` varchar(191) NOT NULL DEFAULT 'none',
  `uidReceiver` varchar(191) NOT NULL DEFAULT 'none',
  `amount` varchar(191) NOT NULL DEFAULT 'none',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `systemUid` varchar(191) NOT NULL DEFAULT 'none',
  `signature` varchar(191) NOT NULL DEFAULT 'none',
  `purpose` varchar(191) NOT NULL DEFAULT 'none',
  `temporalData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`temporalData`)),
  `commentData` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `receiverComment` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `repaid_users`
--

INSERT INTO `repaid_users` (`id`, `uid`, `uidPaid`, `uidReceiver`, `amount`, `status`, `subscriber`, `systemUid`, `signature`, `purpose`, `temporalData`, `commentData`, `created_at`, `updated_at`, `receiverComment`) VALUES
(1, 'PID_iy_1703526399', 'mn_1681494921', 'kebineericMuna_1668935525', '120', 'Paid', 'TEALTD', 'PointSales1', 'none', 'none', NULL, 'none', '2023-12-25 17:46:39', NULL, NULL),
(2, 'PID_SG_1703526591', 'mn_1681494921', 'kebineericMuna_1668935525', '10', 'PaidReceived', 'TEALTD', 'PointSales1', '1', 'none', NULL, 'none', '2023-12-25 17:49:51', '2023-12-25 18:05:46', 'Received');

-- --------------------------------------------------------

--
-- Table structure for table `safariproducts`
--

CREATE TABLE `safariproducts` (
  `id` int(11) NOT NULL,
  `safariId` varchar(191) NOT NULL DEFAULT '0',
  `productCode` varchar(191) NOT NULL,
  `price` varchar(191) NOT NULL DEFAULT '0',
  `qty` varchar(191) NOT NULL DEFAULT '0',
  `totQty` varchar(191) NOT NULL DEFAULT '0',
  `TotBuyAmount` varchar(191) NOT NULL DEFAULT '0',
  `SoldOut` varchar(191) NOT NULL DEFAULT '0',
  `TotSoldAmount` varchar(191) NOT NULL DEFAULT '0',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `CommentStatus` varchar(191) NOT NULL DEFAULT 'none',
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `created_at` varchar(191) NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `safariproducts`
--

INSERT INTO `safariproducts` (`id`, `safariId`, `productCode`, `price`, `qty`, `totQty`, `TotBuyAmount`, `SoldOut`, `TotSoldAmount`, `status`, `CommentStatus`, `uidCreator`, `subscriber`, `created_at`) VALUES
(1, 'Mbona_tbSwL_1697829219', 'bido_1698592481', '40', '500', '500', '0', '0', '0', 'Spendproduct', 'Inserting Product', 'kebineericMuna_1668935525', 'TEALTD', '2023-10-29 17:14:41'),
(2, 'Mbona_tbSwL_1697829219', 'phonekop_1700726700', '40', '500', '500', '0', '0', '0', 'Spendproduct', 'Inserting Product', 'kebineericMuna_1668935525', 'TEALTD', '2023-11-23 10:05:00'),
(3, 'Mbona_tbSwL_1697829219', 'webcam_1700726985', '50', '500', '500', '0', '0', '0', 'Spendproduct', 'Inserting Product', 'kebineericMuna_1668935525', 'TEALTD', '2023-11-23 10:09:45');

-- --------------------------------------------------------

--
-- Table structure for table `safaris`
--

CREATE TABLE `safaris` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL DEFAULT 'none',
  `comment` longtext DEFAULT NULL,
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `safaris`
--

INSERT INTO `safaris` (`id`, `uid`, `name`, `comment`, `uidCreator`, `subscriber`, `created_at`, `updated_at`) VALUES
(1, 'amakarito_Xh2J7_1670870702', 'amakarito', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 18:45:02', NULL),
(3, 'Theo_7Rxu7_1670882845', 'Theo', 'hgjgj', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 22:07:25', NULL),
(4, 'idrissachina_5S6kd_1672739176', 'idrissachina', 'jkhhgjkd', 'kebineericMuna_1668935525', 'TEALTD', '2023-01-03 09:46:16', NULL),
(5, 'testcha_T5rVz_1672740035', 'testcha', 'bjdhjbdjg', 'kebineericMuna_1668935525', 'TEALTD', '2023-01-03 10:00:35', NULL),
(6, 'kozi_NINym_1684091771', 'kozi', 'hjh', 'kebineericMuna_1668935525', 'TEALTD', '2023-05-14 19:16:11', NULL),
(7, 'test_BdUVp_1691914881', 'test', 'mutu', 'kebineericMuna_1668935525', 'TEALTD', '2023-08-13 08:21:21', NULL),
(8, 'gizo_SQLVJ_1691915092', 'gizo', 'fskfks', 'kebineericMuna_1668935525', 'TEALTD', '2023-08-13 08:24:52', NULL),
(9, 'kiza_228oF_1691915260', 'kiza', 'jhg', 'kebineericMuna_1668935525', 'TEALTD', '2023-08-13 08:27:40', NULL),
(10, 'popo_v5Kpu_1691916141', 'popo', 'sfsf', 'kebineericMuna_1668935525', 'TEALTD', '2023-08-13 08:42:21', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `safaristocks`
--

CREATE TABLE `safaristocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL DEFAULT 'none',
  `comment` longtext DEFAULT NULL,
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `safaristocks`
--

INSERT INTO `safaristocks` (`id`, `uid`, `name`, `comment`, `uidCreator`, `subscriber`, `created_at`, `updated_at`) VALUES
(1, 'amakarito_Xh2J7_1670870702', 'amakarito', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 18:45:02', NULL),
(3, 'Theo_7Rxu7_1670882845', 'Theo', 'hgjgj', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 22:07:25', NULL),
(4, 'idrissachina_5S6kd_1672739176', 'idrissachina', 'jkhhgjkd', 'kebineericMuna_1668935525', 'TEALTD', '2023-01-03 09:46:16', NULL),
(5, 'testcha_T5rVz_1672740035', 'testcha', 'bjdhjbdjg', 'kebineericMuna_1668935525', 'TEALTD', '2023-01-03 10:00:35', NULL),
(6, 'kozi_NINym_1684091771', 'kozi', 'hjh', 'kebineericMuna_1668935525', 'TEALTD', '2023-05-14 19:16:11', NULL),
(7, 'pepekare_UQuZv_1691612370', 'pepekare', 'Gido', 'kebineericMuna_1668935525', 'TEALTD', '2023-08-09 20:19:30', NULL),
(8, 'pepekare_aAQzV_1691612392', 'Vunja', 'ceka', 'kebineericMuna_1668935525', 'TEALTD', '2023-08-09 20:19:52', '2023-08-09 20:22:28'),
(9, 'gigi_xiCZh_1691916443', 'gigi', 'ghg', 'kebineericMuna_1668935525', 'TEALTD', '2023-08-13 08:47:23', NULL),
(10, 'kisi_z8n9b_1691919597', 'kisi', 'jhghg', 'kebineericMuna_1668935525', 'TEALTD', '2023-08-13 09:39:57', NULL),
(11, 'cece_1x75S_1691919805', 'cece', 'gdgd', 'kebineericMuna_1668935525', 'TEALTD', '2023-08-13 09:43:25', NULL),
(12, 'koko_CvX1Q_169191999', 'koko', 'hgjh', 'kebineericMuna_1668935525', 'TEALTD', '2023-08-13 09:46:38', NULL),
(13, 'Viko_4OHxv_1696880090', 'Bima', 'testa', 'kebineericMuna_1668935525', 'TEALTD', '2023-10-09 19:34:50', '2023-10-09 19:40:25'),
(14, 'Mbona_tbSwL_1697829219', 'Mbona', 'testViko', 'kebineericMuna_1668935525', 'TEALTD', '2023-10-20 19:13:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `safaritest`
--

CREATE TABLE `safaritest` (
  `id` int(11) NOT NULL,
  `SafariId` varchar(191) NOT NULL DEFAULT '0',
  `productId` varchar(191) NOT NULL,
  `price` varchar(191) NOT NULL DEFAULT '0',
  `qty` varchar(191) NOT NULL DEFAULT '0',
  `totQty` varchar(191) NOT NULL DEFAULT '0',
  `TotBuyAmount` varchar(191) NOT NULL DEFAULT '0',
  `SoldOut` varchar(191) NOT NULL DEFAULT '0',
  `TotSoldAmount` varchar(191) NOT NULL DEFAULT '0',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `CommentStatus` varchar(191) NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `safaritest`
--

INSERT INTO `safaritest` (`id`, `SafariId`, `productId`, `price`, `qty`, `totQty`, `TotBuyAmount`, `SoldOut`, `TotSoldAmount`, `status`, `CommentStatus`) VALUES
(5, 'sa1', 'nyota', '40', '0', '400', '0', '400', '25600', 'product', '0'),
(6, 'sa1', 'meka', '20', '300', '300', '0', '0', '0', 'product', '0'),
(7, 'sa2', 'nyota', '40', '90', '140', '0', '50', '3000', 'product', '0');

-- --------------------------------------------------------

--
-- Table structure for table `safari_products`
--

CREATE TABLE `safari_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL DEFAULT 'none',
  `safariuid` varchar(191) NOT NULL DEFAULT 'none',
  `price` varchar(191) NOT NULL DEFAULT 'none',
  `SoldInterest` varchar(191) NOT NULL DEFAULT '5',
  `currency` varchar(191) NOT NULL DEFAULT 'none',
  `exchangeRate` varchar(191) NOT NULL DEFAULT 'none',
  `typeData` varchar(191) NOT NULL DEFAULT 'product',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `qty` varchar(191) NOT NULL DEFAULT 'none',
  `pcs` varchar(191) NOT NULL DEFAULT 'none',
  `size` varchar(191) NOT NULL DEFAULT 'none',
  `comment` longtext DEFAULT NULL,
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `safari_products`
--

INSERT INTO `safari_products` (`id`, `uid`, `safariuid`, `price`, `SoldInterest`, `currency`, `exchangeRate`, `typeData`, `status`, `qty`, `pcs`, `size`, `comment`, `uidCreator`, `subscriber`, `created_at`, `updated_at`) VALUES
(1, 'reona', 'amakarito_Xh2J7_1670870702', '5000', '-1', 'none', 'none', 'product', 'none', '500', '24', 'none', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 18:47:01', '2022-12-12 19:41:19'),
(2, 'transport', 'amakarito_Xh2J7_1670870702', '4000', '5', 'none', 'none', 'spend', 'none', '0', 'none', 'none', 'jkhdgjg', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 20:57:40', NULL),
(3, 'taxe', 'amakarito_Xh2J7_1670870702', '1000', '5', 'none', 'none', 'spend', 'none', '0', 'none', 'none', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 20:57:57', NULL),
(4, 'td j5', 'amakarito_Xh2J7_1670870702', '5000', '15', 'none', 'none', 'product', 'none', '45', '24', 'none', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 21:01:48', '2022-12-12 21:03:14'),
(5, 'Simba', 'cheetah_Gz4aA_1670882548', '62', '5', 'none', 'none', 'product', 'none', '100', '30', 'none', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 22:03:17', NULL),
(6, 'nyota', 'cheetah_Gz4aA_1670882548', '59', '5', 'none', 'none', 'product', 'none', '300', '72', 'none', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 22:04:21', NULL),
(7, 'transport', 'cheetah_Gz4aA_1670882548', '2400', '5', 'none', 'none', 'spend', 'none', '0', 'none', 'none', 'jjhjkhkgd', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 22:05:06', NULL),
(8, 'taxe', 'cheetah_Gz4aA_1670882548', '5000', '5', 'none', 'none', 'spend', 'none', '0', 'none', 'none', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 22:05:24', NULL),
(9, 'Simba', 'Theo_7Rxu7_1670882845', '6200', '5', 'none', 'none', 'product', 'none', '100', '30', 'none', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 22:08:10', NULL),
(10, 'nyota', 'Theo_7Rxu7_1670882845', '23600', '5', 'none', 'none', 'product', 'none', '400', '72', 'none', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 22:08:44', '2022-12-12 22:16:49'),
(11, 'transport', 'Theo_7Rxu7_1670882845', '3000', '5', 'none', 'none', 'spend', 'none', '0', 'none', 'none', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 22:09:02', NULL),
(12, 'taxe', 'Theo_7Rxu7_1670882845', '6000', '5', 'none', 'none', 'spend', 'none', '0', 'none', 'none', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 22:09:17', NULL),
(13, 'bore911', 'Theo_7Rxu7_1670882845', '1900', '3', 'none', 'none', 'product', 'none', '50', 'no pcs set', 'none', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2022-12-12 22:16:01', '2023-05-14 18:39:00'),
(14, 'nyota', 'idrissachina_5S6kd_1672739176', '4500', '-10', 'none', 'none', 'product', 'none', '400', '72', 'none', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2023-01-03 09:47:16', '2023-01-03 09:56:07'),
(15, 'taxe', 'idrissachina_5S6kd_1672739176', '300', '5', 'none', 'none', 'spend', 'none', '0', 'none', 'none', 'jkhdgjk', 'kebineericMuna_1668935525', 'TEALTD', '2023-01-03 09:48:07', NULL),
(16, 'transport', 'idrissachina_5S6kd_1672739176', '200', '5', 'none', 'none', 'spend', 'none', '0', 'none', 'none', 'turi gupakira irubavu', 'kebineericMuna_1668935525', 'TEALTD', '2023-01-03 09:51:00', NULL),
(17, 'Simba', 'kozi_NINym_1684091771', '40', '1', 'none', 'none', 'product', 'none', '45', '40', 'none', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2023-06-25 16:06:43', '2023-06-25 16:10:31'),
(18, 'reona', 'popo_v5Kpu_1691916141', '100', '5', 'none', 'none', 'product', 'none', '45', '45', 'none', 'none', 'kebineericMuna_1668935525', 'TEALTD', '2023-08-17 14:04:39', NULL),
(19, 'vita', 'koko_CvX1Q_1691919998', 'cece', '5', 'none', 'none', 'spend', 'none', '0', 'none', 'none', 'jkjjh', 'kebineericMuna_1668935525', 'TEALTD', '2023-08-17 14:37:21', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `shouts`
--

CREATE TABLE `shouts` (
  `id` int(191) NOT NULL,
  `uid` varchar(191) NOT NULL DEFAULT 'none',
  `productCode` varchar(191) NOT NULL DEFAULT 'none',
  `userId` varchar(191) NOT NULL DEFAULT 'none',
  `qty` varchar(191) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `shouts`
--

INSERT INTO `shouts` (`id`, `uid`, `productCode`, `userId`, `qty`) VALUES
(1, 'O4Pft', 'viva_1693508831', 'kebineericMuna_1668935525', '5'),
(2, 'O4Pft', 'keb', 'kebineericMuna_1668935525', '3');

-- --------------------------------------------------------

--
-- Table structure for table `spents`
--

CREATE TABLE `spents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `safariuid` varchar(191) NOT NULL DEFAULT 'none',
  `price` varchar(191) NOT NULL DEFAULT 'none',
  `comment` longtext DEFAULT NULL,
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `spents`
--

INSERT INTO `spents` (`id`, `safariuid`, `price`, `comment`, `uidCreator`, `subscriber`, `created_at`, `updated_at`) VALUES
(1, 'none', 'none', NULL, 'none', 'none', '2023-04-13 07:59:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sync_offs`
--

CREATE TABLE `sync_offs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `versionCount` varchar(191) NOT NULL DEFAULT '0',
  `subscriber` varchar(191) NOT NULL,
  `actionName` varchar(191) NOT NULL,
  `tableName` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sync_offs`
--

INSERT INTO `sync_offs` (`id`, `uid`, `versionCount`, `subscriber`, `actionName`, `tableName`, `created_at`, `updated_at`) VALUES
(1, 'kebineericMuna_1670115817', '22', 'TEALTD', 'add', 'cards', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sync_ons`
--

CREATE TABLE `sync_ons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `versionCount` varchar(191) NOT NULL DEFAULT '0',
  `subscriber` varchar(191) NOT NULL,
  `actionName` varchar(191) NOT NULL,
  `tableName` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `temp_tables`
--

CREATE TABLE `temp_tables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `uidCreator` varchar(191) NOT NULL,
  `tempData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tempData`)),
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `actionTable` varchar(191) NOT NULL DEFAULT 'none',
  `systemUid` varchar(191) NOT NULL DEFAULT 'none',
  `commentData` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `temp_tables`
--

INSERT INTO `temp_tables` (`id`, `uid`, `name`, `uidCreator`, `tempData`, `status`, `subscriber`, `actionTable`, `systemUid`, `commentData`, `created_at`, `updated_at`) VALUES
(6, 'saveTemp1_1700396580', 'saveTemp1', 'kebineericMuna_1668935525', '{\"data1\":{\"TotTempBuy\":\"0\",\"TotTempSold\":800,\"TempInterest\":800,\"Interest\":-19940,\"SumInterest\":-19140,\"results\":[{\"safariId\":\"Mbona_tbSwL_1697829219\",\"productCode\":\"bido_1698592481\",\"price\":\"40\",\"qty\":\"20\",\"status\":\"gainProduct\",\"TotBuyAmount\":\"0\",\"TotSoldAmount\":800,\"CommentStatus\":\"none\"}]},\"data2\":-19940}', 'none', 'TEALTD', 'SaveCalculatorInterest', 'Point_Sale1', 'commentData', '2023-11-19 12:23:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `testdatas`
--

CREATE TABLE `testdatas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL DEFAULT 'none',
  `json_column` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_column`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `testtable`
--

CREATE TABLE `testtable` (
  `id` int(191) NOT NULL,
  `jsonData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`jsonData`)),
  `testdata` varchar(191) NOT NULL DEFAULT 'none',
  `qty` varchar(191) NOT NULL DEFAULT '0',
  `status` varchar(191) NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `testtable`
--

INSERT INTO `testtable` (`id`, `jsonData`, `testdata`, `qty`, `status`) VALUES
(2, '[\"item1\",\"item2\",\"item3\"]', 'veko', '4', 'none'),
(3, '[{\"name\": \"John Doe\", \"age\": 30}, {\"name\": \"Jane Doe\", \"age\": 25}, {\"name\": \"keb\", \"status\": \"active\"}]', 'keb', '10', 'Out of Stock'),
(9, '[{\"name\":\"Vita\",\"status\":\"sibo\"},{\"name\":\"Veto\",\"status\":\"checka\"}]', 'none', '20', 'none');

-- --------------------------------------------------------

--
-- Table structure for table `testtable1`
--

CREATE TABLE `testtable1` (
  `id` int(191) NOT NULL,
  `testdata` varchar(191) NOT NULL DEFAULT 'none',
  `qty` varchar(191) NOT NULL DEFAULT '0',
  `status` varchar(191) NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `testtable1_hist`
--

CREATE TABLE `testtable1_hist` (
  `id` int(191) NOT NULL,
  `testdata` varchar(191) NOT NULL DEFAULT 'none',
  `qty` varchar(191) NOT NULL DEFAULT '0',
  `status` varchar(191) NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `testtable1_hist`
--

INSERT INTO `testtable1_hist` (`id`, `testdata`, `qty`, `status`) VALUES
(1, 'bk', 'dore', 'none'),
(2, 'bk', 'dore', 'none'),
(3, 'bk', 'dore', 'none'),
(4, 'bk', 'dore', 'none'),
(5, 'bk', 'dore', 'none'),
(6, 'bk', 'dore', 'none'),
(7, 'bk', 'dore', 'none'),
(8, 'bk', 'dore', 'none'),
(9, 'bk', 'dore', 'none'),
(10, 'bk', 'dore', 'none'),
(11, 'bk', 'dore', 'none'),
(12, 'bk', 'dore', 'none'),
(13, 'bk', 'dore', 'none');

-- --------------------------------------------------------

--
-- Table structure for table `topups`
--

CREATE TABLE `topups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `balance` varchar(191) NOT NULL DEFAULT '0',
  `bonus` varchar(191) NOT NULL DEFAULT '0',
  `CBalance` varchar(191) NOT NULL DEFAULT 'US',
  `CBonus` varchar(191) NOT NULL DEFAULT 'US',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `purpose` varchar(191) NOT NULL DEFAULT 'none',
  `description` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `topups`
--

INSERT INTO `topups` (`id`, `uid`, `uidCreator`, `balance`, `bonus`, `CBalance`, `CBonus`, `subscriber`, `purpose`, `description`, `created_at`, `updated_at`) VALUES
(1, 'kebineericMuna_1674160265', 'kebineericMuna_1668935525', '0', '2800', 'US', 'US', 'TEALTD', 'none', NULL, '2023-10-01 18:27:24', '2023-10-01 19:00:43');

-- --------------------------------------------------------

--
-- Table structure for table `topup_histories`
--

CREATE TABLE `topup_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `amount` varchar(191) NOT NULL DEFAULT 'none',
  `action` varchar(191) NOT NULL DEFAULT 'none',
  `balance` varchar(191) NOT NULL DEFAULT '0',
  `bonus` varchar(191) NOT NULL DEFAULT '0',
  `CBalance` varchar(20) NOT NULL DEFAULT 'US',
  `CBonus` varchar(20) NOT NULL DEFAULT 'US',
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `systemUid` varchar(191) NOT NULL DEFAULT 'none',
  `purpose` varchar(191) NOT NULL DEFAULT 'none',
  `description` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `topup_histories`
--

INSERT INTO `topup_histories` (`id`, `uid`, `uidCreator`, `amount`, `action`, `balance`, `bonus`, `CBalance`, `CBonus`, `subscriber`, `systemUid`, `purpose`, `description`, `created_at`, `updated_at`) VALUES
(2, 'kebineericMuna_1668935593', 'kebineericMuna_1668935525', 'none', 'Bonus', '0', '0', 'US', 'US', 'TEALTD', 'none', 'kivuBucket_1672353285', 'gogo', '2023-01-31 22:00:50', NULL),
(3, 'kebineericMuna_1668935593', 'kebineericMuna_1668935525', 'none', 'Bonus', '0', '300', 'US', 'US', 'TEALTD', 'none', 'kivuBucket_1672353285', 'gege', '2023-01-31 22:28:42', NULL),
(4, 'kebineericMuna_1668935593', 'kebineericMuna_1668935525', 'none', 'Bonus', '0', '300', 'US', 'US', 'TEALTD', 'none', 'kivuBucket_1672353285', 'gido', '2023-01-31 22:39:25', NULL),
(5, 'kebineericMuna_1668935593', 'kebineericMuna_1668935525', 'none', 'Bonus', '0', '300', 'US', 'US', 'TEALTD', 'none', 'kivuBucket_1672353285', 'suzuki', '2023-02-05 09:42:05', NULL),
(8, 'kebineericMuna_1674160265', 'kebineericMuna_1668935525', 'none', 'Bonus', '0', '300', 'US', 'US', 'TEALTD', 'none', 'kivuBucket_1672353285', NULL, '2023-02-08 08:10:24', NULL),
(9, 'kebineericMuna_1674160265', 'kebineericMuna_1668935525', 'none', 'Bonus', '0', '100', 'US', 'US', 'TEALTD', 'none', 'kivuBucket_1672353285', NULL, '2023-02-08 08:15:02', NULL),
(10, 'kebineericMuna_1674160265', 'kebineericMuna_1668935525', 'none', 'Bonus', '0', '100', 'US', 'US', 'TEALTD', 'none', 'kivuBucket_1672353285', NULL, '2023-02-16 17:35:22', NULL),
(11, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'none', 'FirstTimeAddNew', '400', '0', 'US', 'US', 'TEALTD', 'none', 'none', 'none', '2023-02-17 18:45:49', NULL),
(12, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'none', 'AddNew', '250', '0', 'US', 'US', 'TEALTD', 'none', 'none', 'Balance of User', '2023-02-17 18:47:48', NULL),
(13, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'none', 'EditedBalance', '300', '0', 'US', 'US', 'TEALTD', 'none', 'none', 'Balance of User', '2023-02-17 18:50:56', NULL),
(14, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'none', 'EditedBalance', '-450', '0', 'US', 'US', 'TEALTD', 'none', 'none', 'Balance of User', '2023-02-17 18:59:04', NULL),
(15, 'kebineericMuna_1674160265', 'kebineericMuna_1668935525', 'none', 'reverse', '0', '-400', 'US', 'US', 'TEALTD', 'none', 'kivuBucket_1672353285', NULL, '2023-02-21 19:44:10', NULL),
(16, 'kebineericMuna_1674160265', 'kebineericMuna_1668935525', 'none', 'reverse', '0', '-200', 'US', 'US', 'TEALTD', 'none', 'kivuBucket_1672353285', NULL, '2023-02-21 20:20:16', NULL),
(17, 'kebineericMuna_1674592764', 'kebineericMuna_1668935525', 'none', 'AddNew', '250', '0', 'US', 'US', 'TEALTD', 'none', 'none', 'Balance of User', '2023-04-13 09:16:11', NULL),
(18, 'kebineericMuna_1674160265', 'kebineericMuna_1668935525', 'none', 'Bonus', '0', '350', 'US', 'US', 'TEALTD', 'none', 'Nyota_1672353378', NULL, '2023-10-01 18:27:24', NULL),
(19, 'kebineericMuna_1674160265', 'kebineericMuna_1668935525', 'none', 'Bonus', '0', '700', 'US', 'US', 'TEALTD', 'none', 'Nyota_1672353378', NULL, '2023-10-01 18:33:34', NULL),
(20, 'kebineericMuna_1674160265', 'kebineericMuna_1668935525', 'none', 'Bonus', '0', '700', 'US', 'US', 'TEALTD', 'none', 'Nyota_1672353378', NULL, '2023-10-01 18:52:44', NULL),
(21, 'kebineericMuna_1674160265', 'kebineericMuna_1668935525', 'none', 'Bonus', '0', '350', 'US', 'US', 'TEALTD', 'none', 'Nyota_1672353378', 'Promotion to reach1200Then Gain Was350Bonus is350', '2023-10-01 18:59:21', NULL),
(22, 'kebineericMuna_1674160265', 'kebineericMuna_1668935525', 'none', 'Bonus', '0', '700', 'US', 'US', 'TEALTD', 'none', 'Nyota_1672353378', 'Promotion to reach  1200Then Gain Was  350Bonus is  700', '2023-10-01 19:00:43', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(191) NOT NULL,
  `carduid` varchar(191) NOT NULL DEFAULT 'none',
  `uidCreator` varchar(191) NOT NULL,
  `subscriber` varchar(191) NOT NULL DEFAULT 'none',
  `photo_url` varchar(191) NOT NULL DEFAULT 'none',
  `name` varchar(191) NOT NULL DEFAULT 'none',
  `email` varchar(191) NOT NULL DEFAULT 'none',
  `password` varchar(191) NOT NULL DEFAULT 'none',
  `Ccode` varchar(191) NOT NULL DEFAULT 'none',
  `phone` varchar(191) NOT NULL DEFAULT 'none',
  `PhoneNumber` varchar(191) NOT NULL DEFAULT 'none',
  `platform` varchar(191) NOT NULL DEFAULT 'none',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `gender` varchar(191) NOT NULL DEFAULT 'none',
  `age` varchar(191) NOT NULL DEFAULT 'none',
  `initCountry` varchar(191) NOT NULL DEFAULT 'none',
  `country` varchar(191) NOT NULL DEFAULT 'none',
  `marital_status` varchar(191) NOT NULL DEFAULT 'none',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `uid`, `carduid`, `uidCreator`, `subscriber`, `photo_url`, `name`, `email`, `password`, `Ccode`, `phone`, `PhoneNumber`, `platform`, `status`, `gender`, `age`, `initCountry`, `country`, `marital_status`, `remember_token`, `created_at`, `updated_at`) VALUES
(3, 'kebineericMuna_1674160265', 'TEALTD_7hEnj_1672352175', 'kebineericMuna_1668935525', 'TEALTD', 'none', 'bebese', 'on@gmail.com', '$2y$10$EYphEKdxGkKhkUR8DHdG4eNpsdYc.xgStBRgAstQzhfpnNJrUIsEm', '+250', '782389359', '+250782389359', '4000', 'none', 'none', 'none', 'none', 'Rwanda', 'none', NULL, '2023-01-19 20:31:05', '2023-02-25 19:50:37'),
(8, 'kebineericMuna_1674592764', 'TEALTD_lN7o8_1672352176', 'kebineericMuna_1668935525', 'TEALTD', 'none', 'gogo', 'on2@gmail.com', '$2y$10$akt4mAwPsPEFuOAoWo.i8u9vqrZsrHzQz/tT7kMRvAbBVIjLsMebu', '243', '0789359', '2430789359', '4000', 'none', 'none', 'none', 'none', 'Rwanda', 'none', NULL, '2023-01-24 20:39:24', '2023-02-25 19:53:45'),
(9, 'kebineericMuna_1675961813', 'TEALTD_7hEnj_1672352175', 'kebineericMuna_1668935525', 'TEALTD', 'none', 'kebine eric Muna', 'on1@gmail.com_1675961813', '$2y$10$ti3hyvh6eHYm5aeCDhBrdep6yX86cOLBCUpsYLBkgYk2bcft0dO8C', '+250', '782389358', '+250782389358', '4000', 'none', 'none', 'none', 'none', 'Rwanda', 'none', NULL, '2023-02-09 16:56:53', NULL),
(10, 'kebineericMuna_1676390572', 'TEALTD_7hEnj_1672352175', 'kebineericMuna_1668935525', 'TEALTD', 'none', 'kebine eric Muna', 'on2@gmail.com_1676390572', '$2y$10$7QViYDyOiM8u1Q7YzJG7TOedCfcI/LMythgC/uWw1Q74gv3sD2CWe', '+250', '7823893587', '+2507823893587', '4000', 'none', 'none', 'none', 'none', 'Rwanda', 'none', NULL, '2023-02-14 16:02:52', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `workers`
--

CREATE TABLE `workers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uidUser` varchar(191) NOT NULL DEFAULT 'none',
  `uidCreator` varchar(191) NOT NULL DEFAULT 'none',
  `amount` varchar(191) NOT NULL DEFAULT 'none',
  `position` varchar(191) NOT NULL DEFAULT 'none',
  `systemUid` varchar(191) NOT NULL DEFAULT 'none',
  `jobContract` varchar(191) NOT NULL DEFAULT 'none',
  `temporalData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`temporalData`)),
  `started_at` varchar(191) NOT NULL DEFAULT 'none',
  `datePaid_at` varchar(191) NOT NULL DEFAULT 'none',
  `paid_at` varchar(191) NOT NULL DEFAULT 'none',
  `status` varchar(191) NOT NULL DEFAULT 'none',
  `commentData` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `worker_payments`
--

CREATE TABLE `worker_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_uid_unique` (`uid`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `Ccode` (`Ccode`),
  ADD KEY `PhoneNumber` (`PhoneNumber`),
  ADD KEY `platform` (`platform`);

--
-- Indexes for table `admnin_records`
--
ALTER TABLE `admnin_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `balance` (`balance`),
  ADD KEY `bonus` (`bonus`),
  ADD KEY `dettes` (`dettes`),
  ADD KEY `status` (`status`),
  ADD KEY `systemUid` (`systemUid`),
  ADD KEY `addBalance` (`addBalance`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `updated_at` (`updated_at`);

--
-- Indexes for table `appname`
--
ALTER TABLE `appname`
  ADD PRIMARY KEY (`id`),
  ADD KEY `systemUid` (`systemUid`);

--
-- Indexes for table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `subscriber` (`subscriber`);

--
-- Indexes for table `cinterests`
--
ALTER TABLE `cinterests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `depenses`
--
ALTER TABLE `depenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `uidUser` (`uidUser`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `status` (`status`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `systemUid` (`systemUid`),
  ADD KEY `purpose` (`purpose`);

--
-- Indexes for table `dettes`
--
ALTER TABLE `dettes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `uidUser` (`uidUser`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `status` (`status`),
  ADD KEY `systemUid` (`systemUid`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `purpose` (`purpose`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orderhistories`
--
ALTER TABLE `orderhistories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `poductCode` (`productCode`),
  ADD KEY `userid` (`userid`),
  ADD KEY `ref` (`ref`),
  ADD KEY `order_creator` (`order_creator`),
  ADD KEY `status` (`status`),
  ADD KEY `permission` (`permission`),
  ADD KEY `SafariId` (`SafariId`),
  ADD KEY `paidStatus` (`paidStatus`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `promotionUid` (`promotionUid`),
  ADD KEY `giftId` (`giftId`);

--
-- Indexes for table `orderhistories_backup`
--
ALTER TABLE `orderhistories_backup`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `poductCode` (`productCode`),
  ADD KEY `userid` (`userid`),
  ADD KEY `ref` (`ref`),
  ADD KEY `order_creator` (`order_creator`),
  ADD KEY `status` (`status`),
  ADD KEY `permission` (`permission`),
  ADD KEY `SafariId` (`SafariId`),
  ADD KEY `paidStatus` (`paidStatus`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `promotionUid` (`promotionUid`),
  ADD KEY `giftId` (`giftId`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `uidUser` (`uidUser`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `paidStatus` (`paidStatus`),
  ADD KEY `Status` (`Status`),
  ADD KEY `systemUid` (`systemUid`),
  ADD KEY `debt` (`debt`),
  ADD KEY `promotionUid` (`promotionUid`);

--
-- Indexes for table `ordertest`
--
ALTER TABLE `ordertest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `poductCode` (`productCode`),
  ADD KEY `userid` (`userid`),
  ADD KEY `ref` (`ref`),
  ADD KEY `order_creator` (`order_creator`),
  ADD KEY `status` (`status`),
  ADD KEY `permission` (`permission`);

--
-- Indexes for table `paid_dettes`
--
ALTER TABLE `paid_dettes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `uidUser` (`uidUser`),
  ADD KEY `uidReceiver` (`uidReceiver`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `paidStatus` (`paidStatus`),
  ADD KEY `status` (`status`),
  ADD KEY `signature` (`signature`),
  ADD KEY `systemUid` (`systemUid`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `purpose` (`purpose`),
  ADD KEY `safeAmount` (`safeAmount`);

--
-- Indexes for table `participateds`
--
ALTER TABLE `participateds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `uidUser` (`uidUser`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `inputData` (`inputData`),
  ADD KEY `token` (`token`),
  ADD KEY `started_date` (`started_date`),
  ADD KEY `ended_date` (`ended_date`),
  ADD KEY `status` (`status`),
  ADD KEY `carduid` (`carduid`);

--
-- Indexes for table `participated_hists`
--
ALTER TABLE `participated_hists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `uidUser` (`uidUser`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `carduid` (`carduid`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `actionName` (`actionName`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `poductCode` (`productCode`),
  ADD KEY `active` (`active`),
  ADD KEY `ProductName` (`ProductName`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `tags` (`tags`(768)),
  ADD KEY `isQr` (`isQr`);

--
-- Indexes for table `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `token` (`token`),
  ADD KEY `promoName` (`promoName`),
  ADD KEY `promo_msg` (`promo_msg`),
  ADD KEY `reach` (`reach`),
  ADD KEY `gain` (`gain`),
  ADD KEY `started_date` (`started_date`),
  ADD KEY `status` (`status`),
  ADD KEY `ended_date` (`ended_date`);

--
-- Indexes for table `quickbonuses`
--
ALTER TABLE `quickbonuses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quickUid` (`quickUid`),
  ADD KEY `productName` (`productName`),
  ADD KEY `status` (`status`),
  ADD KEY `bonusType` (`bonusType`),
  ADD KEY `giftName` (`giftName`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `subscriber` (`subscriber`);

--
-- Indexes for table `quickbonushists`
--
ALTER TABLE `quickbonushists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quickbosubmithists`
--
ALTER TABLE `quickbosubmithists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quickbosubmits`
--
ALTER TABLE `quickbosubmits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `quickUid` (`quickUid`),
  ADD KEY `uidUser` (`uidUser`),
  ADD KEY `productName` (`productName`),
  ADD KEY `status` (`status`),
  ADD KEY `bonusType` (`bonusType`),
  ADD KEY `giftName` (`giftName`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `subscriber` (`subscriber`);

--
-- Indexes for table `redeemeds`
--
ALTER TABLE `redeemeds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `status` (`status`),
  ADD KEY `balance` (`balance`),
  ADD KEY `bonus` (`bonus`),
  ADD KEY `subscriber` (`subscriber`);

--
-- Indexes for table `repaid_users`
--
ALTER TABLE `repaid_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `uidPaid` (`uidPaid`),
  ADD KEY `uidReceiver` (`uidReceiver`),
  ADD KEY `status` (`status`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `systemUid` (`systemUid`),
  ADD KEY `signature` (`signature`),
  ADD KEY `purpose` (`purpose`);

--
-- Indexes for table `safariproducts`
--
ALTER TABLE `safariproducts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `safariId` (`safariId`);

--
-- Indexes for table `safaris`
--
ALTER TABLE `safaris`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `safaris_uid_unique` (`uid`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `subscriber` (`subscriber`);

--
-- Indexes for table `safaristocks`
--
ALTER TABLE `safaristocks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `safaris_uid_unique` (`uid`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `subscriber` (`subscriber`);

--
-- Indexes for table `safaritest`
--
ALTER TABLE `safaritest`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `safari_products`
--
ALTER TABLE `safari_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `safariuid` (`safariuid`),
  ADD KEY `typeData` (`typeData`),
  ADD KEY `status` (`status`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `subscriber` (`subscriber`);

--
-- Indexes for table `shouts`
--
ALTER TABLE `shouts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `spents`
--
ALTER TABLE `spents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `safariuid` (`safariuid`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `subscriber` (`subscriber`);

--
-- Indexes for table `sync_offs`
--
ALTER TABLE `sync_offs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `versionCount` (`versionCount`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `actionName` (`actionName`),
  ADD KEY `tableName` (`tableName`);

--
-- Indexes for table `sync_ons`
--
ALTER TABLE `sync_ons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `versionCount` (`versionCount`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `actionName` (`actionName`),
  ADD KEY `tableName` (`tableName`);

--
-- Indexes for table `temp_tables`
--
ALTER TABLE `temp_tables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `name` (`name`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `status` (`status`),
  ADD KEY `actionTable` (`actionTable`),
  ADD KEY `systemUid` (`systemUid`),
  ADD KEY `subscriber` (`subscriber`);

--
-- Indexes for table `testdatas`
--
ALTER TABLE `testdatas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testtable`
--
ALTER TABLE `testtable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testtable1`
--
ALTER TABLE `testtable1`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testtable1_hist`
--
ALTER TABLE `testtable1_hist`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `topups`
--
ALTER TABLE `topups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `topups_uid_unique` (`uid`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `balance` (`balance`),
  ADD KEY `bonus` (`bonus`),
  ADD KEY `CBalance` (`CBalance`),
  ADD KEY `CBonus` (`CBonus`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `purpose` (`purpose`);

--
-- Indexes for table `topup_histories`
--
ALTER TABLE `topup_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `balance` (`balance`),
  ADD KEY `bonus` (`bonus`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `systemUid` (`systemUid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_uid_unique` (`uid`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `subscriber` (`subscriber`),
  ADD KEY `platform` (`platform`),
  ADD KEY `gender` (`status`),
  ADD KEY `status` (`gender`),
  ADD KEY `age` (`age`),
  ADD KEY `country` (`country`),
  ADD KEY `marital_status` (`marital_status`),
  ADD KEY `Ccode` (`Ccode`),
  ADD KEY `PhoneNumber` (`PhoneNumber`),
  ADD KEY `carduid` (`carduid`);

--
-- Indexes for table `workers`
--
ALTER TABLE `workers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uidUser` (`uidUser`),
  ADD KEY `uidCreator` (`uidCreator`),
  ADD KEY `position` (`position`),
  ADD KEY `systemUid` (`systemUid`),
  ADD KEY `jobContract` (`jobContract`),
  ADD KEY `started_at` (`started_at`),
  ADD KEY `datePaid_at` (`datePaid_at`),
  ADD KEY `paid_at` (`paid_at`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `worker_payments`
--
ALTER TABLE `worker_payments`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `admnin_records`
--
ALTER TABLE `admnin_records`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `appname`
--
ALTER TABLE `appname`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `cinterests`
--
ALTER TABLE `cinterests`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `depenses`
--
ALTER TABLE `depenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dettes`
--
ALTER TABLE `dettes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `orderhistories`
--
ALTER TABLE `orderhistories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orderhistories_backup`
--
ALTER TABLE `orderhistories_backup`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ordertest`
--
ALTER TABLE `ordertest`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `paid_dettes`
--
ALTER TABLE `paid_dettes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `participateds`
--
ALTER TABLE `participateds`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `participated_hists`
--
ALTER TABLE `participated_hists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=420;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=262;

--
-- AUTO_INCREMENT for table `promotions`
--
ALTER TABLE `promotions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `quickbonuses`
--
ALTER TABLE `quickbonuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `quickbonushists`
--
ALTER TABLE `quickbonushists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quickbosubmithists`
--
ALTER TABLE `quickbosubmithists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quickbosubmits`
--
ALTER TABLE `quickbosubmits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `redeemeds`
--
ALTER TABLE `redeemeds`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `repaid_users`
--
ALTER TABLE `repaid_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `safariproducts`
--
ALTER TABLE `safariproducts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `safaris`
--
ALTER TABLE `safaris`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `safaristocks`
--
ALTER TABLE `safaristocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `safaritest`
--
ALTER TABLE `safaritest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `safari_products`
--
ALTER TABLE `safari_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `shouts`
--
ALTER TABLE `shouts`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `spents`
--
ALTER TABLE `spents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sync_offs`
--
ALTER TABLE `sync_offs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sync_ons`
--
ALTER TABLE `sync_ons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `temp_tables`
--
ALTER TABLE `temp_tables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `testdatas`
--
ALTER TABLE `testdatas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `testtable`
--
ALTER TABLE `testtable`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `testtable1`
--
ALTER TABLE `testtable1`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `testtable1_hist`
--
ALTER TABLE `testtable1_hist`
  MODIFY `id` int(191) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `topups`
--
ALTER TABLE `topups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `topup_histories`
--
ALTER TABLE `topup_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `workers`
--
ALTER TABLE `workers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `worker_payments`
--
ALTER TABLE `worker_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
