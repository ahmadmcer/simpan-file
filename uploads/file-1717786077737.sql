-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 07 Jun 2024 pada 20.01
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project_manajement`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_jasa`
--

CREATE TABLE `barang_jasa` (
  `id` int(11) NOT NULL,
  `id_proposal` int(11) DEFAULT NULL,
  `nama` varchar(100) NOT NULL,
  `harga` bigint(25) NOT NULL,
  `kategori` enum('Barang','Jasa') NOT NULL,
  `deskripsi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `barang_jasa`
--

INSERT INTO `barang_jasa` (`id`, `id_proposal`, `nama`, `harga`, `kategori`, `deskripsi`) VALUES
(3, 2, 'Pembuatan Front-End', 150000, 'Jasa', 'Pengerjaan pembuatan Front-End untuk website pencatatan'),
(4, 3, 'Pembuatan Back-End', 150000, 'Jasa', 'Pengerjaan pembuatan Front-End untuk website pencatatan'),
(5, 2, 'Pembuatan Back-Ended', 150000, 'Jasa', 'Pengerjaan pembuatan Front-End untuk website pencatatan'),
(6, 2, 'Pembuatan Back-Endeded', 150000, 'Jasa', 'Pengerjaan pembuatan Front-End untuk website pencatatan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `karyawan`
--

CREATE TABLE `karyawan` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `nomer_telepon` varchar(15) NOT NULL,
  `keahlian` varchar(255) NOT NULL,
  `posisi` enum('Ketua','Anggota') NOT NULL DEFAULT 'Anggota',
  `id_tim` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `karyawan`
--

INSERT INTO `karyawan` (`id`, `nama`, `email`, `nomer_telepon`, `keahlian`, `posisi`, `id_tim`) VALUES
(1, 'Aaliyah Khalif Handoyo', '20104003@ittelkom-pwt.ac.id', '098098098', 'Back-end Web Developer', 'Ketua', 1),
(2, 'Aris Cahyadi', 'aris@gmail.con', '098098772', 'Front-end Web Developer', 'Anggota', 1),
(4, 'Aal', 'aal@mail.com', '088754453', 'Back-end Programmer', 'Anggota', 2),
(5, 'Aaliah', 'aaliah@mail.com', '088754453', 'Back-endeded Programmer', 'Anggota', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kegiatan`
--

CREATE TABLE `kegiatan` (
  `id` int(11) NOT NULL,
  `id_proposal` int(11) DEFAULT NULL,
  `nama_kegiatan` varchar(255) DEFAULT NULL,
  `penanggung_jawab` varchar(50) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `status` enum('Belum Selesai','Selesai') DEFAULT 'Belum Selesai'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kegiatan`
--

INSERT INTO `kegiatan` (`id`, `id_proposal`, `nama_kegiatan`, `penanggung_jawab`, `deskripsi`, `status`) VALUES
(1, 2, 'Pengerjaan Front-end', 'A K H', 'pengerjaan Front-end untuk website menggunakan react', 'Selesai'),
(2, 2, 'Pengerjaan Back-end', 'A K H', 'pengerjaan Back-end untuk website menggunakan react', 'Selesai'),
(3, 2, 'Pengerjaan Desain UI', 'A K H', 'pengerjaan Desaain UI untuk website menggunakan Figma', 'Selesai');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kwitansi`
--

CREATE TABLE `kwitansi` (
  `id` int(11) NOT NULL,
  `id_proposal` int(11) DEFAULT NULL,
  `judul` varchar(255) DEFAULT NULL,
  `purchase_order` varchar(100) DEFAULT NULL,
  `tanggal_pembuatan` date DEFAULT NULL,
  `tanggal_jatuhtempo` date DEFAULT NULL,
  `catatan` text DEFAULT NULL,
  `total_nominal` bigint(25) NOT NULL,
  `status` enum('Belum Lunas','Lunas') DEFAULT 'Belum Lunas'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kwitansi`
--

INSERT INTO `kwitansi` (`id`, `id_proposal`, `judul`, `purchase_order`, `tanggal_pembuatan`, `tanggal_jatuhtempo`, `catatan`, `total_nominal`, `status`) VALUES
(17, 3, 'Percobaan pembuatan kwitansi', '001-pembayaran-percobaan', '2024-09-24', '2024-10-25', 'ini percobaan untuk kwitansi', 2500000, 'Lunas'),
(18, 3, 'Percobaan pembuatan kwitansi', '001-pembayaran-percobaan', '2024-09-24', '2024-10-25', 'ini percobaan untuk kwitansi', 2500000, 'Belum Lunas'),
(20, 2, 'percobaan kedua menggunakan tampilan', '001-224', '2024-01-02', '2024-04-02', 'ini merupakan percobaan pembuatan kwitansi', 250000, 'Belum Lunas'),
(25, 8, 'percobaan kedua menggunakan tampilan', '001-223', '2024-01-01', '2024-04-01', 'ini merupakan percobaan pembuatan kwitansi', 2345000, 'Belum Lunas');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `nomer_telepon` varchar(16) NOT NULL,
  `nomer_bisnis` varchar(50) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `kota_kabupaten` varchar(255) DEFAULT NULL,
  `kode_pos` varchar(20) DEFAULT NULL,
  `provinsi` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pelanggan`
--

INSERT INTO `pelanggan` (`id`, `nama`, `email`, `nomer_telepon`, `nomer_bisnis`, `keterangan`, `alamat`, `kota_kabupaten`, `kode_pos`, `provinsi`, `is_deleted`) VALUES
(1, 'Percobaan lol', 'email@mail.com', '08772019923', '09809877', 'percobaan', 'jalan percobaan no.29', 'kota percobaan', '40122', 'provinsi percobaan', 0),
(2, 'Aris', 'percobaan2@mail.com', '0887099899', '40123', 'ini data dummy ke-2', 'jln.percobaan-2', 'purwokerto', '40223', 'Jawa Tengah', 1),
(3, 'percobaan3', 'percobaan3@mail.com', '7087798723', '40124', 'ini percobaan data dummy ke 3', 'jln.percobaan3', 'percobaan3', '401243', 'Jawa Tengah', 1),
(5, 'percobaan4', 'percobaan4@mail.com', '087798723', '40125', 'ini percobaan data dummy ke 4', 'jln.percobaan4', 'percobaan4', '401244', 'Jawa Timur', 1),
(6, 'Aaliyah Khalif H', 'aalkh@20roll.net', '087720879898', '40122', 'Pelanggan Pertama', 'JL. Percobaan no 5', 'Purwokerto', '53131', 'Jawa Tengah', 1),
(7, 'Ahmad Nawawi', 'percobaan@mail.com', '087720879898', '40122', 'Pelanggan Kedua', 'JL. Percobaan no 6', 'Purwokerto', '53434', 'Jateng (Jawa Tengah)', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id` int(11) NOT NULL,
  `id_kwitansi` int(11) DEFAULT NULL,
  `no_kwitansi` varchar(255) NOT NULL,
  `bukti` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pembayaran`
--

INSERT INTO `pembayaran` (`id`, `id_kwitansi`, `no_kwitansi`, `bukti`) VALUES
(4, 17, '002-005-2024', 'pembayaran3.jpeg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `proposal`
--

CREATE TABLE `proposal` (
  `id` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `id_pelanggan` int(11) DEFAULT NULL,
  `id_tim` int(11) DEFAULT NULL,
  `tanggal_mulai` date DEFAULT NULL,
  `tanggal_selesai` date DEFAULT NULL,
  `nama_file` varchar(255) DEFAULT NULL,
  `link_proposal` varchar(255) DEFAULT NULL,
  `tipe_pembayaran` enum('Diawal','Diakhir') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `proposal`
--

INSERT INTO `proposal` (`id`, `judul`, `id_pelanggan`, `id_tim`, `tanggal_mulai`, `tanggal_selesai`, `nama_file`, `link_proposal`, `tipe_pembayaran`) VALUES
(2, 'Proyek B', 1, 1, '2024-05-27', '2024-09-25', 'proposal_C.pdf', 'http://example.com/proposal_C', 'Diakhir'),
(3, 'Proyek C', 3, 2, '2024-08-21', '2024-10-21', 'proposal_c.pdf', 'http://example.com/proposal_c', 'Diakhir'),
(4, 'Proyek A', 1, 1, '2024-05-21', '2024-06-21', 'proposal_a.pdf', 'http://example.com/proposal_a', 'Diakhir'),
(5, 'Proyek A', 1, 1, '2024-05-21', '2024-06-21', 'proposal_a.pdf', 'http://example.com/proposal_a', 'Diakhir'),
(6, 'Proyek A', 1, 1, '2024-05-21', '2024-06-21', 'proposal_a.pdf', 'http://example.com/proposal_a', 'Diakhir'),
(7, 'percobaan pertama menggunakan tampilan', 1, 2, '2024-05-24', '2024-10-23', 'C:\\fakepath\\myfile (9).pdf', 'asasdadsasd', 'Diawal'),
(8, 'percobaan pertama menggunakan tampilan', 2, 1, '2024-05-24', '2024-10-23', 'C:\\fakepath\\myfile (9).pdf', 'asasdadsasd', 'Diawal');

-- --------------------------------------------------------

--
-- Struktur dari tabel `purchase_order`
--

CREATE TABLE `purchase_order` (
  `id` int(11) NOT NULL,
  `id_proposal` int(11) DEFAULT NULL,
  `no_po` varchar(100) NOT NULL,
  `total` bigint(20) NOT NULL,
  `tanggal_mulai` date DEFAULT NULL,
  `tanggal_akhir` date DEFAULT NULL,
  `catatan` text DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `purchase_order`
--

INSERT INTO `purchase_order` (`id`, `id_proposal`, `no_po`, `total`, `tanggal_mulai`, `tanggal_akhir`, `catatan`, `file`) VALUES
(2, 2, '001', 1450000, '2024-07-19', '2024-10-20', 'pendataan proposal mengenai pembuatan website', 'proposal-percobaan-yang-diubah.pdf'),
(3, 2, '002', 1450000, '2024-07-24', '2024-08-25', 'pendataan proposal mengenai pembuatan website', 'proposal-percobaan.pdf'),
(4, 2, '002', 1450000, '2024-07-24', '2024-08-25', 'pendataan proposal mengenai pembuatan website', 'proposal-percobaan.pdf'),
(5, 2, '002', 1450000, '2024-07-24', '2024-08-25', 'pendataan proposal mengenai pembuatan website', 'proposal-percobaan.pdf'),
(6, 2, '002', 1450000, '2024-07-24', '2024-08-25', 'pendataan proposal mengenai pembuatan website', 'proposal-percobaan.pdf');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tim`
--

CREATE TABLE `tim` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tim`
--

INSERT INTO `tim` (`id`, `nama`) VALUES
(1, 'Aaliyah'),
(2, 'percobaan-pembuatan-tim'),
(4, 'Tim Ahmad'),
(5, 'Tim 32');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang_jasa`
--
ALTER TABLE `barang_jasa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_proposal` (`id_proposal`);

--
-- Indeks untuk tabel `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tim` (`id_tim`);

--
-- Indeks untuk tabel `kegiatan`
--
ALTER TABLE `kegiatan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_proposal` (`id_proposal`);

--
-- Indeks untuk tabel `kwitansi`
--
ALTER TABLE `kwitansi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_proposal` (`id_proposal`);

--
-- Indeks untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_kwitansi` (`id_kwitansi`);

--
-- Indeks untuk tabel `proposal`
--
ALTER TABLE `proposal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pelanggan` (`id_pelanggan`),
  ADD KEY `fk_id_tim` (`id_tim`);

--
-- Indeks untuk tabel `purchase_order`
--
ALTER TABLE `purchase_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_proposal` (`id_proposal`);

--
-- Indeks untuk tabel `tim`
--
ALTER TABLE `tim`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `barang_jasa`
--
ALTER TABLE `barang_jasa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `karyawan`
--
ALTER TABLE `karyawan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `kegiatan`
--
ALTER TABLE `kegiatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `kwitansi`
--
ALTER TABLE `kwitansi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `proposal`
--
ALTER TABLE `proposal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `purchase_order`
--
ALTER TABLE `purchase_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `tim`
--
ALTER TABLE `tim`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `barang_jasa`
--
ALTER TABLE `barang_jasa`
  ADD CONSTRAINT `barang_jasa_ibfk_1` FOREIGN KEY (`id_proposal`) REFERENCES `proposal` (`id`);

--
-- Ketidakleluasaan untuk tabel `karyawan`
--
ALTER TABLE `karyawan`
  ADD CONSTRAINT `karyawan_ibfk_1` FOREIGN KEY (`id_tim`) REFERENCES `tim` (`id`);

--
-- Ketidakleluasaan untuk tabel `kegiatan`
--
ALTER TABLE `kegiatan`
  ADD CONSTRAINT `kegiatan_ibfk_1` FOREIGN KEY (`id_proposal`) REFERENCES `proposal` (`id`);

--
-- Ketidakleluasaan untuk tabel `kwitansi`
--
ALTER TABLE `kwitansi`
  ADD CONSTRAINT `kwitansi_ibfk_1` FOREIGN KEY (`id_proposal`) REFERENCES `proposal` (`id`);

--
-- Ketidakleluasaan untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_kwitansi`) REFERENCES `kwitansi` (`id`);

--
-- Ketidakleluasaan untuk tabel `proposal`
--
ALTER TABLE `proposal`
  ADD CONSTRAINT `fk_id_tim` FOREIGN KEY (`id_tim`) REFERENCES `tim` (`id`),
  ADD CONSTRAINT `proposal_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id`);

--
-- Ketidakleluasaan untuk tabel `purchase_order`
--
ALTER TABLE `purchase_order`
  ADD CONSTRAINT `purchase_order_ibfk_1` FOREIGN KEY (`id_proposal`) REFERENCES `proposal` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
