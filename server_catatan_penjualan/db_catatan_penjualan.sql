-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Waktu pembuatan: 27 Okt 2019 pada 23.55
-- Versi server: 10.4.8-MariaDB
-- Versi PHP: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_tes_catatan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `barcode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_barang` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga_beli` double NOT NULL,
  `harga_jual` double NOT NULL,
  `stok` int(11) NOT NULL DEFAULT 0,
  `created_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`id_barang`, `id_user`, `barcode`, `nama_barang`, `kategori`, `harga_beli`, `harga_jual`, `stok`, `created_date`) VALUES
(4, 0, '812919233213212', 'NASI GORENG 12 PORSIX', 'Makanan', 10000, 15000, 0, '2019-10-01 09:51:51'),
(6, 0, '938383883888', 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 'Makanan', 10000, 12000, 0, '2019-10-01 14:24:44'),
(7, 0, '938388383888', 'BUBUR AYAM AGAK JAUH', 'Makanan', 7000, 8000, 0, '2019-10-01 14:28:27');

-- --------------------------------------------------------

--
-- Struktur dari tabel `keranjang`
--

CREATE TABLE `keranjang` (
  `id_keranjang` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `qty` int(11) NOT NULL DEFAULT 0,
  `total_harga` double NOT NULL DEFAULT 0,
  `status` enum('PENDING','TERJUAL') COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `keranjang`
--

INSERT INTO `keranjang` (`id_keranjang`, `id_user`, `qty`, `total_harga`, `status`, `date`) VALUES
(1, 0, 14, 197000, 'TERJUAL', '2019-10-03 07:50:30'),
(3, 5, 0, 200000, 'TERJUAL', '2019-10-03 09:09:55'),
(14, 5, 0, 1280000, 'TERJUAL', '2018-08-07 09:32:06'),
(19, 0, 35, 416000, 'TERJUAL', '2019-10-04 16:49:00'),
(20, 0, 1, 12000, 'TERJUAL', '2019-04-10 16:11:45'),
(21, 0, 1, 12000, 'TERJUAL', '2019-09-25 16:13:26'),
(24391, 0, 1, 12000, 'TERJUAL', '2019-10-03 18:49:31'),
(24392, 0, 90, 1344000, 'TERJUAL', '2019-09-30 17:41:36'),
(24393, 0, 1, 12000, 'TERJUAL', '2019-10-05 22:59:23'),
(24394, 9, 0, 0, 'PENDING', '2019-10-04 02:31:01'),
(24395, 0, 1, 12000, 'TERJUAL', '2019-10-06 07:27:23'),
(24396, 5, 0, 0, 'PENDING', '2019-10-04 02:37:13'),
(24397, 0, 1, 8000, 'TERJUAL', '2019-10-06 07:34:03'),
(24398, 0, 11, 132000, 'TERJUAL', '2019-10-06 07:40:06'),
(24403, 0, 10, 150000, 'TERJUAL', '2019-10-06 07:29:03'),
(24417, 0, 1, 8000, 'TERJUAL', '2019-10-06 10:05:38'),
(24424, 0, 1, 8000, 'TERJUAL', '2019-10-06 10:32:35'),
(24427, 0, 1, 12000, 'TERJUAL', '2019-10-06 10:35:04'),
(24428, 0, 1, 8000, 'TERJUAL', '2019-10-06 10:37:53'),
(24429, 0, 1, 12000, 'TERJUAL', '2019-10-07 11:20:49'),
(24430, 0, 1, 8000, 'TERJUAL', '2019-10-07 11:21:15'),
(24431, 0, 11, 132000, 'TERJUAL', '2019-10-07 11:21:41'),
(24432, 0, 1, 8000, 'TERJUAL', '2019-10-07 11:22:58'),
(24433, 0, 1, 12000, 'TERJUAL', '2019-10-07 11:28:23'),
(24434, 0, 0, 0, 'PENDING', '2019-10-07 04:28:23');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penjualan`
--

CREATE TABLE `penjualan` (
  `id_penjualan` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_keranjang` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `nama_barang` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty` int(11) NOT NULL,
  `harga_beli` double NOT NULL,
  `harga_jual` double NOT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `penjualan`
--

INSERT INTO `penjualan` (`id_penjualan`, `id_user`, `id_keranjang`, `id_barang`, `nama_barang`, `qty`, `harga_beli`, `harga_jual`, `created_date`) VALUES
(6, 0, 1, 7, 'BUBUR AYAM AGAK JAUH', 1, 7000, 8000, '2019-10-03 13:26:44'),
(7, 0, 1, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 13:29:01'),
(14, 0, 1, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 14:17:27'),
(16, 0, 1, 4, 'NASI GORENG 12 PORSIX', 11, 10000, 15000, '2019-10-03 15:17:21'),
(19, 0, 19, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 16:26:02'),
(20, 0, 19, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 16:29:01'),
(21, 0, 19, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 16:33:54'),
(22, 0, 19, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 16:33:56'),
(23, 0, 19, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 16:33:56'),
(24, 0, 19, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 16:33:57'),
(25, 0, 19, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 16:33:57'),
(26, 0, 19, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 16:33:57'),
(27, 0, 19, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 16:34:11'),
(28, 0, 19, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 16:34:13'),
(29, 0, 19, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 16:36:12'),
(30, 0, 19, 7, 'BUBUR AYAM AGAK JAUH', 1, 7000, 8000, '2019-10-03 16:38:14'),
(31, 0, 19, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 16:39:25'),
(32, 0, 19, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 10, 10000, 12000, '2019-10-03 16:40:13'),
(33, 0, 20, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 18:47:45'),
(34, 0, 21, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 18:49:18'),
(36, 0, 24391, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 18:51:34'),
(37, 0, 24392, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-03 18:51:54'),
(39, 0, 19, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 12, 10000, 12000, '2019-10-04 02:33:51'),
(40, 0, 24392, 4, 'NASI GORENG 12 PORSIX', 88, 10000, 15000, '2019-10-04 02:36:24'),
(41, 0, 24392, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-05 09:31:46'),
(42, 0, 24393, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-05 15:59:20'),
(43, 0, 24395, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-06 00:27:20'),
(45, 0, 24403, 4, 'NASI GORENG 12 PORSIX', 10, 10000, 15000, '2019-10-06 00:28:57'),
(46, 0, 24397, 7, 'BUBUR AYAM AGAK JAUH', 1, 7000, 8000, '2019-10-06 00:34:01'),
(47, 0, 24398, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 11, 10000, 12000, '2019-10-06 00:40:02'),
(58, 0, 24417, 7, 'BUBUR AYAM AGAK JAUH', 1, 7000, 8000, '2019-10-06 03:05:36'),
(63, 0, 24424, 7, 'BUBUR AYAM AGAK JAUH', 1, 7000, 8000, '2019-10-06 03:32:26'),
(66, 0, 24427, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-06 03:34:07'),
(67, 0, 24428, 7, 'BUBUR AYAM AGAK JAUH', 1, 7000, 8000, '2019-10-06 03:37:48'),
(68, 0, 24429, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-07 04:20:41'),
(69, 0, 24430, 7, 'BUBUR AYAM AGAK JAUH', 1, 7000, 8000, '2019-10-07 04:21:09'),
(70, 0, 24431, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 11, 10000, 12000, '2019-10-07 04:21:35'),
(71, 0, 24432, 7, 'BUBUR AYAM AGAK JAUH', 1, 7000, 8000, '2019-10-07 04:22:56'),
(72, 0, 24433, 6, 'NASI PADANG DEPAN SEBERANG JALAN KALAU GA SALAH', 1, 10000, 12000, '2019-10-07 04:28:19');

--
-- Trigger `penjualan`
--
DELIMITER $$
CREATE TRIGGER `delete item penjualan` AFTER DELETE ON `penjualan` FOR EACH ROW UPDATE keranjang SET qty = keranjang.qty - old.QTY, total_harga = keranjang.total_harga - (old.QTY * old.harga_jual) WHERE keranjang.id_user = old.id_user AND keranjang.id_keranjang = old.id_keranjang
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hp` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id_user`, `username`, `email`, `password`, `hp`, `create_date`) VALUES
(0, 'guest', 'guest@rizal.com', '$2y$10$ZrZOzLGryqRRKjsJPCJZz.QX4xRUPmUT6gIXxCN6sQI', '012398238323', '2019-10-01 09:51:17'),
(5, 'rizal', 'syahrizalakbar1@gmail.com', '$2y$10$ZrZOzLGryqRRKjsJPCJZz.QX4xRUPmUT6gIXxCN6sQI', '083813963166', '2019-09-30 08:54:51'),
(6, 'admin', 'admin@rizal.com', '$2y$10$8ekfnUTmPti9GM.N8NLVluY.SqyTrGTCE6vtGXwTnr/', '012390128912', '2019-09-30 09:02:38'),
(8, 'rizal3', 'rizal3@gmail.com', '$2y$10$Wie3SyRIBIAgQsy/.nC7uensD7f7zxclQwhqHMGdm6Z', '098282', '2019-10-04 02:28:37'),
(9, 'rizal4', 'rizal4@gmail.com', '$2y$10$IrmHDdTlgEqBbxqq5ZQ3LuRV3dWgOWd2feM9wFzq4TV', '083747478339', '2019-10-04 02:30:39');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `keranjang`
--
ALTER TABLE `keranjang`
  ADD PRIMARY KEY (`id_keranjang`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`id_penjualan`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `penjualan_ibfk_3` (`id_keranjang`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `keranjang`
--
ALTER TABLE `keranjang`
  MODIFY `id_keranjang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24435;

--
-- AUTO_INCREMENT untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  MODIFY `id_penjualan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `keranjang`
--
ALTER TABLE `keranjang`
  ADD CONSTRAINT `keranjang_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `penjualan_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON UPDATE CASCADE,
  ADD CONSTRAINT `penjualan_ibfk_2` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`) ON UPDATE CASCADE,
  ADD CONSTRAINT `penjualan_ibfk_3` FOREIGN KEY (`id_keranjang`) REFERENCES `keranjang` (`id_keranjang`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
