// =============================================================================
// FILE: screens/profile_screen.dart
// PILAR MATERI: Widget (StatelessWidget), Layouting
// =============================================================================
// Halaman Profil yang menampilkan informasi identitas pelanggan.
//
// Konsep yang diterapkan:
// 1. STATELESS WIDGET -> Halaman ini menggunakan StatelessWidget karena
//                        kontennya bersifat STATIS (tidak berubah selama
//                        aplikasi berjalan). Tidak ada data yang dimutasi,
//                        sehingga tidak perlu setState().
// 2. WIDGET TREE      -> Scaffold > AppBar + Column > CircleAvatar, Text, Card
// 3. LAYOUTING        -> Column (vertikal), Row (horizontal), Padding, SizedBox
// =============================================================================

import 'package:flutter/material.dart';

// --- STATELESS WIDGET ---
// StatelessWidget digunakan ketika sebuah halaman/widget tidak memiliki
// state internal yang berubah. Semua data yang ditampilkan bersifat tetap
// (hardcoded atau dari parameter constructor yang tidak berubah).
// Widget ini hanya memiliki satu method build() tanpa setState().
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- APPBAR ---
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
      ),

      // --- BODY ---
      // SingleChildScrollView membungkus konten agar bisa di-scroll
      // jika konten melebihi tinggi layar (menghindari overflow).
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // --- AVATAR PROFIL ---
            // CircleAvatar menampilkan gambar atau ikon dalam bentuk lingkaran.
            // 'radius' mengatur ukuran lingkaran.
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.orange.shade100,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.orange.shade700,
              ),
            ),
            const SizedBox(height: 16),

            // --- NAMA PELANGGAN ---
            // Ganti dengan nama lengkap mahasiswa sesuai instruksi soal.
            const Text(
              'Loddy Luvian N',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            // --- NIM ---
            Text(
              '124240120',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),

            // --- LABEL STATUS ---
            // Container dengan dekorasi digunakan untuk membuat badge/label.
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Pelanggan Resto',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- KARTU INFORMASI ---
            // Card digunakan untuk mengelompokkan informasi terkait
            // dalam satu kotak dengan efek elevasi (bayangan).
            // Berikut adalah beberapa kartu info restoran:

            // Kartu 1: Info Menu Resto
            _buildInfoCard(
              icon: Icons.restaurant_menu,
              title: 'Menu Resto',
              subtitle: 'Pesan makanan favorit Anda dari daftar menu.',
            ),

            // Kartu 2: Info Pemesanan
            _buildInfoCard(
              icon: Icons.shopping_cart,
              title: 'Pemesanan',
              subtitle: 'Jumlah dan harga pesanan dihitung otomatis.',
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- HELPER METHOD ---
  // Method pembantu untuk membuat kartu info yang konsisten.
  // Ini menerapkan prinsip REUSABLE WIDGET: satu template widget yang
  // bisa dipanggil berulang kali dengan data yang berbeda.
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          // ListTile adalah widget bawaan yang menyusun leading, title,
          // dan subtitle secara otomatis dalam layout standar Material.
          leading: CircleAvatar(
            backgroundColor: Colors.orange.shade50,
            child: Icon(icon, color: Colors.orange.shade700),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
