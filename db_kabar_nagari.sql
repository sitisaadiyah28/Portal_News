-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 28 Jul 2020 pada 15.29
-- Versi Server: 10.1.29-MariaDB
-- PHP Version: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_kabar_nagari`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_berita`
--

CREATE TABLE `tb_berita` (
  `id_berita` int(11) NOT NULL,
  `judul_berita` varchar(191) NOT NULL,
  `deskripsi` text NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `images_berita` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_berita`
--

INSERT INTO `tb_berita` (`id_berita`, `judul_berita`, `deskripsi`, `id_kategori`, `id_user`, `created_at`, `images_berita`) VALUES
(1, 'Berburu Nasi Kapau di Festival Budaya Luhak Nan Tigo', 'Mungkin Anda sudah awam mendengar dan menemukan nasi padang di Jakarta dan kota lain. Tapi, pernahkah Anda mendengar makanan khas Sumatera Barat lainnya yang bernama nasi kapau? Nasi kapau dan nasi padang secara kasat mata terlihat mirip karena komponen lauk-pauknya yang serupa.\r\n\r\nJarang diketahui, nasi kapau ternyata berbeda dengan nasi padang. Perbedaan ini dimulai dari beberapa jenis lauk dan proses penyajiannya. Saat ini, Anda dapat menemukan nasi kapau di Festival Budaya Luhak Nan Tigo 2019 yang sedang berlangsung di Lapangan Bola Masjid Al Azhar,  Kebayoran Baru, Jakarta Selatan.\r\n\r\nFestival budaya ini diselenggarakan oleh Komunitas Muda Mudi Minangkabau dengan menghadirkan berbagai penampilan kesenian, talkshow hingga bazar kuliner khas Minangkabau. Sejumlah bintang tamu seperti Elly Kasim, Ernie Djohan, Arzeti Bilbina, Dorce Gamalama, dan lain-lain juga turut meramaikan acara ini.\r\n\r\n\"Tujuan acara ini adalah memperkenalkan kesenian kebudayaan Minang mulai dari musik, tari, permainan tradisional serta berbagai kuliner yang jarang ditemukan di perantauan ini,\" kata Bobi Haryanto, Ketua Komunitas Muda Mudi Minangkabau pada Sabtu, 24 Agustus 2019.\r\n\r\nTerdapat total 60 tenant makanan yang menyediakan makanan khas Minangkabau dan peranakan. Salah satu yang menarik perhatian adalah nasi kapau yang jarang ditemui di ibu kota.\r\n\r\nMakanan ini dinamakan nasi kapau karena nasi ramas tersebut berasal dari daerah Kapau, Bukittinggi. Berbagai jenis sayur dan lauk gulai nangka, dendeng balado, belut goreng, menjadi pelengkap dari nasi ini.', 4, 3, '2020-07-25 01:37:48', 'nasikapau.jpg'),
(4, 'Pemlihan Gubernur dan Wakil Gubernur Sumatera Barat', 'Pemilihan Gubernur Sumatere Barat akan dilaksanakan  dalam waktu dekat', 1, 3, '2020-07-27 08:13:33', 'pilkada3.jpg'),
(6, 'Berita Ranah Minang 1', 'Berita Ranah Minang 1', 2, 3, '2020-07-28 12:22:19', 'pnpp1.jpg'),
(9, 'Berita Terkini Ranah Minang', 'Berita Terkini Ranah Minang', 2, 3, '2020-07-28 12:27:18', 'image_picker601779253884196386.jpg'),
(11, 'aaaaaaaaaaaaaaa', 'aaaaaaaaaaaaaaaaaa', 5, 3, '2020-07-28 12:54:51', 'image_picker6628266068627766758.jpg'),
(12, 'bbbbbbbbb', 'bbbbb', 5, 3, '2020-07-28 13:23:18', 'image_picker1934844023708867639.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_kategori`
--

CREATE TABLE `tb_kategori` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(191) NOT NULL,
  `images` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_kategori`
--

INSERT INTO `tb_kategori` (`id_kategori`, `nama_kategori`, `images`) VALUES
(1, 'Olahraga', 'bola.png'),
(2, 'Hukum', 'hukum.png'),
(3, 'Kesehatan', 'kesehatan.png'),
(4, 'Adat', 'cincin.png'),
(5, 'Ekononmi', 'ekonomi.png');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_user`
--

CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL,
  `nama_user` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `notelp` varchar(15) NOT NULL,
  `photo_user` text NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_user`
--

INSERT INTO `tb_user` (`id_user`, `nama_user`, `email`, `notelp`, `photo_user`, `password`) VALUES
(1, 'siti saadiyah', 'sitisaadiyahap16@gmail.com', '082172902139', '', '4297f44b13955235245b2497399d7a93'),
(2, 'Ahmad ', 'ahmad@gmail.com', '082170087869', '', '4297f44b13955235245b2497399d7a93'),
(3, 'Irfan', 'irfan@gmail.com', '082170087869', 'irfan.jpg', '4297f44b13955235245b2497399d7a93'),
(4, 'Arsyad Hamidi', 'arsyad@gmail.com', '08212192192', '', '4297f44b13955235245b2497399d7a93');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_berita`
--
ALTER TABLE `tb_berita`
  ADD PRIMARY KEY (`id_berita`);

--
-- Indexes for table `tb_kategori`
--
ALTER TABLE `tb_kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_berita`
--
ALTER TABLE `tb_berita`
  MODIFY `id_berita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tb_kategori`
--
ALTER TABLE `tb_kategori`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
