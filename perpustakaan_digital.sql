-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 30 Jul 2024 pada 06.43
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
-- Database: `perpustakaan_digital`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getBukuByPenulis` (IN `penulis` VARCHAR(100))   BEGIN
    SELECT 
        id_buku, 
        judul, 
        tahun_terbit 
    FROM 
        buku 
    WHERE 
        penulis = penulis;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getJumlahPeminjamanByBuku` (IN `id_buku` INT, OUT `jumlah_peminjaman` INT)   BEGIN
    SELECT 
        COUNT(*) 
    INTO 
        jumlah_peminjaman 
    FROM 
        peminjaman 
    WHERE 
        id_buku = id_buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPeminjamanByTanggal` (IN `start_date` DATE, IN `end_date` DATE, OUT `total_peminjaman` INT)   BEGIN
    SELECT 
        COUNT(*) 
    INTO 
        total_peminjaman 
    FROM 
        peminjaman 
    WHERE 
        tanggal_pinjam BETWEEN start_date AND end_date;
END$$

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
-- Struktur dari tabel `anggota`
--

CREATE TABLE `anggota` (
  `id_anggota` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `alamat` text NOT NULL,
  `tanggal_daftar` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `anggota`
--

INSERT INTO `anggota` (`id_anggota`, `nama`, `alamat`, `tanggal_daftar`) VALUES
(1, 'John Doe', 'Jl. Merdeka No. 10', '2023-07-20'),
(2, 'Jane Smith', 'Jl. Kemerdekaan No. 5', '2023-07-21');

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
(1, 'Pemrograman Web dengan PHP', 'John Doe', '2018', 157),
(2, 'Basis Data MySQL', 'Jane Smith', '2015', 215),
(3, 'Flutter Mobile Programming', 'Stones David', '2020', 150),
(4, 'Big Data Analysis', 'Amy Watson', '2020', 198),
(5, 'Data Engineering: from A to Z', 'Fred Lincoln', '2021', 298),
(6, 'Algoritma', 'Dedi', '2018', 150);

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman_anggota`
--

CREATE TABLE `peminjaman_anggota` (
  `id_peminjaman_anggota` int(11) NOT NULL,
  `id_anggota` int(11) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_kembali` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `peminjaman_anggota`
--

INSERT INTO `peminjaman_anggota` (`id_peminjaman_anggota`, `id_anggota`, `id_buku`, `tanggal_pinjam`, `tanggal_kembali`) VALUES
(1, 1, 1, '2023-07-22', '2023-07-29'),
(2, 2, 2, '2023-07-23', '2023-07-30');

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
-- Indeks untuk tabel `anggota`
--
ALTER TABLE `anggota`
  ADD PRIMARY KEY (`id_anggota`);

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indeks untuk tabel `peminjaman_anggota`
--
ALTER TABLE `peminjaman_anggota`
  ADD PRIMARY KEY (`id_peminjaman_anggota`),
  ADD KEY `id_anggota` (`id_anggota`),
  ADD KEY `id_buku` (`id_buku`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `anggota`
--
ALTER TABLE `anggota`
  MODIFY `id_anggota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `peminjaman_anggota`
--
ALTER TABLE `peminjaman_anggota`
  MODIFY `id_peminjaman_anggota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `peminjaman_anggota`
--
ALTER TABLE `peminjaman_anggota`
  ADD CONSTRAINT `peminjaman_anggota_ibfk_1` FOREIGN KEY (`id_anggota`) REFERENCES `anggota` (`id_anggota`),
  ADD CONSTRAINT `peminjaman_anggota_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
