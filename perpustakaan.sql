-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 30 Jul 2024 pada 06.49
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `perpustakaan`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_jumlah_buku_tahun` (IN `p_tahun_terbit` YEAR, OUT `p_jumlah_buku` INT)   BEGIN
SELECT COUNT(*) INTO p_jumlah_buku
FROM buku
WHERE tahun_terbit = p_tahun_terbit;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_all_buku` ()   BEGIN
SELECT * FROM buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_buku_tahun_terbit` (IN `tahun` INT)   BEGIN
SELECT * FROM buku WHERE tahun_terbit = tahun;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_buku` (IN `judul_buku` VARCHAR(100), IN `pengarang_buku` VARCHAR(100), IN `tahun_buku` YEAR, IN `halaman_buku` INT)   BEGIN
INSERT INTO buku (judul, pengarang, tahun_terbit, jumlah_halaman)
VALUES (judul_buku, pengarang_buku, tahun_buku, halaman_buku);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `id_buku` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `pengarang` varchar(255) NOT NULL,
  `tahun_terbit` year(4) NOT NULL,
  `jumlah_halaman` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`id_buku`, `judul`, `pengarang`, `tahun_terbit`, `jumlah_halaman`) VALUES
(1, 'Pemrograman Web dengan PHP', 'John Doe', '2018', 400),
(2, 'Basis Data MySQL', 'Jane Smith', '2015', 215),
(3, 'Kecerdasan Buatan', 'Arnold Walker', '2020', 134),
(4, 'Data Mining', 'Donald Philips', '2021', 234),
(5, 'Algoritma', 'Dedi', '2018', 150),
(6, 'Algoritma', 'Dedi', '2018', 150);

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `peminjam` varchar(255) NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_kembali` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_buku`, `peminjam`, `tanggal_pinjam`, `tanggal_kembali`) VALUES
(1, 1, 'Alice', '2021-07-01', '2021-07-10'),
(2, 2, 'Bob', '2021-07-02', '2021-07-12'),
(3, 4, 'Charles', '2021-07-03', '2021-07-13'),
(4, 1, '', '2024-01-01', '2024-01-07'),
(5, 1, '', '2024-02-01', '2024-02-07'),
(6, 1, '', '2024-03-01', '2024-03-07'),
(7, 3, '', '2024-01-01', '2024-01-10'),
(8, 3, '', '2024-02-01', '2024-02-10'),
(9, 3, '', '2024-03-01', '2024-03-10'),
(10, 3, '', '2024-04-01', '2024-04-10');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_buku`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_buku` (
`judul` varchar(255)
,`pengarang` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_buku_tertebal`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_buku_tertebal` (
`judul` varchar(255)
,`pengarang` varchar(255)
,`jumlah_halaman` int(11)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `view_buku`
--
DROP TABLE IF EXISTS `view_buku`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_buku`  AS SELECT `buku`.`judul` AS `judul`, `buku`.`pengarang` AS `pengarang` FROM `buku` WHERE `buku`.`tahun_terbit` >= 2020 ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_buku_tertebal`
--
DROP TABLE IF EXISTS `view_buku_tertebal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_buku_tertebal`  AS SELECT `buku`.`judul` AS `judul`, `buku`.`pengarang` AS `pengarang`, `buku`.`jumlah_halaman` AS `jumlah_halaman` FROM `buku` WHERE `buku`.`jumlah_halaman` = (select max(`buku`.`jumlah_halaman`) from `buku`) ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indeks untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`),
  ADD KEY `id_buku` (`id_buku`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
