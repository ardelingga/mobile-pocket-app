-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 14, 2021 at 04:26 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_mobile_pocket_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_dompet`
--

CREATE TABLE `tbl_dompet` (
  `id` int(11) NOT NULL,
  `nama` varchar(25) NOT NULL,
  `referensi` bigint(20) NOT NULL,
  `deskripsi` varchar(100) NOT NULL,
  `status_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_dompet`
--

INSERT INTO `tbl_dompet` (`id`, `nama`, `referensi`, `deskripsi`, `status_id`) VALUES
(2, 'Dompet Arde', 324235343, 'Test Deskripsi', 2),
(3, 'Dompet Utama', 324235343, 'Test Deskripsi', 2),
(4, 'Dompet Ardelingga', 324235343, 'Test Deskripsi', 1),
(5, 'Chchch Dompet', 586866, 'jffufu', 2),
(6, 'Dompet Abadi', 5656525535335, 'arde', 2),
(7, 'Dompet Gopay', 28558588665, 'Untuk jajan', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_dompet_status`
--

CREATE TABLE `tbl_dompet_status` (
  `id` int(11) NOT NULL,
  `nama` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_dompet_status`
--

INSERT INTO `tbl_dompet_status` (`id`, `nama`) VALUES
(1, 'Aktif'),
(2, 'Tidak  Aktif');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_kategori`
--

CREATE TABLE `tbl_kategori` (
  `id` int(11) NOT NULL,
  `nama` varchar(25) NOT NULL,
  `deskripsi` varchar(30) NOT NULL,
  `status_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_kategori`
--

INSERT INTO `tbl_kategori` (`id`, `nama`, `deskripsi`, `status_id`) VALUES
(1, 'Pemasukan', 'Kategori uang pemasukan', 1),
(2, 'Pengeluaran', 'Kategori uang pengeluaran', 1),
(4, 'Other', 'sfssg jgjg jgk', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_kategori_status`
--

CREATE TABLE `tbl_kategori_status` (
  `id` int(11) NOT NULL,
  `nama` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_kategori_status`
--

INSERT INTO `tbl_kategori_status` (`id`, `nama`) VALUES
(1, 'Aktif'),
(2, 'Tidak  Aktif');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_transaksi`
--

CREATE TABLE `tbl_transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `id` bigint(11) NOT NULL,
  `kode` varchar(20) NOT NULL,
  `deskripsi` varchar(100) NOT NULL,
  `tanggal` date NOT NULL,
  `nilai` bigint(20) NOT NULL,
  `transaksi_status_id` int(11) NOT NULL,
  `dompet_id` int(11) NOT NULL,
  `kategori_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_transaksi`
--

INSERT INTO `tbl_transaksi` (`id_transaksi`, `id`, `kode`, `deskripsi`, `tanggal`, `nilai`, `transaksi_status_id`, `dompet_id`, `kategori_id`, `status_id`) VALUES
(4, 2100000008, 'WIN000004', 'Masak Banyuhhh', '2021-10-14', 80000, 1, 4, 2, 2),
(5, 2100000005, 'WIN000005', 'Des3', '2021-10-14', 17000, 1, 3, 2, 2),
(6, 2100000006, 'WIN000006', 'Nex desc', '2021-10-14', 113000, 1, 3, 4, 1),
(7, 2100000009, 'WOUT000009', 'Desc 1 Dompet keluar', '2021-10-14', 2500000, 2, 6, 1, 1),
(8, 2100000010, 'WOUT000010', 'Desc2', '2021-10-14', 6000000, 2, 3, 1, 1),
(9, 2100000011, 'WIN000011', 'Desc 1', '2021-10-14', 7000000, 1, 3, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_transaksi_status`
--

CREATE TABLE `tbl_transaksi_status` (
  `id` int(11) NOT NULL,
  `nama` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_transaksi_status`
--

INSERT INTO `tbl_transaksi_status` (`id`, `nama`) VALUES
(1, 'Masuk'),
(2, 'Keluar');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_dompet`
--
ALTER TABLE `tbl_dompet`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_dompet_status`
--
ALTER TABLE `tbl_dompet_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_kategori`
--
ALTER TABLE `tbl_kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_kategori_status`
--
ALTER TABLE `tbl_kategori_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_transaksi`
--
ALTER TABLE `tbl_transaksi`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- Indexes for table `tbl_transaksi_status`
--
ALTER TABLE `tbl_transaksi_status`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_dompet`
--
ALTER TABLE `tbl_dompet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_dompet_status`
--
ALTER TABLE `tbl_dompet_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_kategori`
--
ALTER TABLE `tbl_kategori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_kategori_status`
--
ALTER TABLE `tbl_kategori_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_transaksi`
--
ALTER TABLE `tbl_transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_transaksi_status`
--
ALTER TABLE `tbl_transaksi_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
