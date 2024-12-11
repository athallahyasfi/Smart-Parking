**Smart Parking - Sistem Parkir Pintar**

Smart Parking adalah aplikasi parkir berbasis Flutter yang dirancang untuk memudahkan pengguna dalam menemukan dan memesan lokasi parkir. Aplikasi ini dilengkapi dengan fitur autentikasi pengguna, penentuan lokasi parkir, serta riwayat penggunaan parkir.

*Fitur Utama*
1. Login dan Autentikasi
- Pengguna harus login dengan nama pengguna dan sandi sebelum mengakses aplikasi.
- Nama pengguna: palmer
- Sandi: 1234

2. Pemetaan Lokasi Parkir
- Tampilkan marker pada lokasi parkir di peta.
- Marker memiliki label kecil dengan nama singkat lokasi.
- Lokasi parkir yang sedang digunakan akan ditandai dengan warna hijau.

3. Sistem Parkir
- Pengguna dapat memilih lokasi parkir dari peta.
- Slot parkir tersedia dengan kategori kosong dan terisi.
- Konfirmasi parkir termasuk memasukkan data plat nomor.

4. Profil Pengguna
Halaman profil menampilkan informasi:
- Nama pengguna
- Tipe kendaraan
- Plat nomor kendaraan

5. Riwayat Parkir
- Pengguna dapat melihat riwayat parkir, termasuk lokasi dan waktu parkir.

6. Logout dan Keluar Parkir
- Pengguna dapat logout dari aplikasi melalui halaman login.
- Tombol konfirmasi keluar parkir tersedia untuk menghapus status parkir aktif.

*Mekanisme Aplikasi*
1. Login
- Pengguna memasukkan nama pengguna dan sandi di halaman login untuk mengakses aplikasi. Nama pengguna dan sandi yang valid adalah palmer dan 1234.

2. Beranda (Home)
- Tampilkan peta lokasi parkir dengan marker untuk setiap lokasi.
- Pengguna memilih lokasi dengan mengetuk marker.
- Setelah memilih lokasi, pengguna diarahkan ke halaman slot parkir.

3. Pilih Slot Parkir
- Pengguna dapat memilih slot parkir kosong yang ditampilkan.
- Konfirmasi parkir membutuhkan data plat nomor kendaraan.

4. Profil Pengguna
- Pengguna dapat melihat informasi pribadi di halaman profil.

5. Riwayat Parkir
- Riwayat parkir mencakup waktu, lokasi, dan status parkir.

6. Keluar Parkir
- Pengguna dapat keluar dari lokasi parkir melalui tombol "Keluar Parkir" di halaman beranda.
- Setelah keluar parkir, status marker lokasi akan kembali ke warna biru.

*Struktur Direktori*
lib/
├── main.dart               # Titik awal aplikasi
├── models/
│   └── parking_data.dart   # Model data untuk riwayat parkir
├── pages/
│   ├── firstpage.dart      # Halaman awal aplikasi
│   ├── history.dart        # Halaman riwayat parkir
│   ├── home.dart           # Halaman utama dengan peta
│   ├── login.dart          # Halaman login pengguna
│   ├── mark.dart           # Halaman detail lokasi parkir
│   ├── marker.dart         # Halaman peta parkir yang interaktif
│   ├── profile.dart        # Halaman profil pengguna
│   └── parkslot.dart       # Halaman slot parkir

*Teknologi yang Digunakan*
1. Flutter: Framework utama untuk membangun aplikasi.
2. Dart: Bahasa pemrograman inti.
3. Material Design: Untuk desain UI yang responsif dan modern.

*Cara Menjalankan*
1. Pastikan Anda sudah menginstal Flutter di komputer Anda.
2. Clone repository ini: git clone https://github.com/username/smart-park.git
3. Masuk ke direktori proyek: cd smart-park
4. Jalankan perintah berikut untuk mendapatkan dependensi: flutter pub get
5. Jalankan aplikasi: flutter run

*Catatan*
1. Aplikasi ini dirancang untuk keperluan demonstrasi dan dapat disesuaikan sesuai kebutuhan.
  
2. Nama pengguna dan sandi default adalah:
- Nama Pengguna: user
- Sandi: 1234

*Anggota Kelompok*
1. M. Archi Daffa Danendra (09031282227094)
2. M. Yasir al-Ghifari (09031282227102)
3. Athallah Yasyfi Imran (09031282227102)
4. Mahendi Alvines (09031382227143)
