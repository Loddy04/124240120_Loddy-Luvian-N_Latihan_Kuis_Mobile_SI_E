// =============================================================================
// FILE: screens/profile_screen.dart
// PILAR MATERI: Widget (StatelessWidget), Layouting, Navigation (pushAndRemoveUntil)
// =============================================================================
// Halaman Profil yang menampilkan informasi identitas pelanggan serta tombol
// Logout untuk keluar dari aplikasi dan kembali ke halaman Login.
//
// Konsep yang diterapkan:
// 1. STATELESS WIDGET         -> Halaman ini menggunakan StatelessWidget karena
//                                datanya bersifat statis dan tidak memerlukan setState().
// 2. DATA PASSING             -> Menerima parameter 'username' dari RootScreen
//                                melalui constructor widget.
// 3. PUSHANDREMOVEUNTIL       -> Navigator.pushAndRemoveUntil() untuk fitur Logout,
//                                menghapus semua riwayat stack navigasi agar pengguna
//                                tidak bisa kembali ke halaman utama setelah logout.
// =============================================================================

import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  // Menerima data username hasil passing data dari LoginScreen -> RootScreen
  final String username;

  const ProfileScreen({
    super.key,
    this.username = 'Loddy Luvian Nugraha',
  });

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
      // SingleChildScrollView mencegah render overflow saat layar kecil/orientasi berubah
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // --- AVATAR PROFIL ---
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

            // --- NAMA PELANGGAN (Dari Parameter Login) ---
            Text(
              username,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            // --- NIM MAHASISWA ---
            Text(
              '124240120',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),

            // --- LABEL STATUS PELANGGAN ---
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
            const SizedBox(height: 28),

            // --- KARTU INFORMASI RESTORAN (Reusable Widget) ---
            _buildInfoCard(
              icon: Icons.restaurant_menu,
              title: 'Menu Resto',
              subtitle: 'Pesan makanan favorit Anda dari daftar menu.',
            ),
            _buildInfoCard(
              icon: Icons.shopping_cart,
              title: 'Pemesanan',
              subtitle: 'Jumlah dan harga pesanan dihitung otomatis.',
            ),
            const SizedBox(height: 24),

            // =================================================================
            // FITUR LOGOUT: pushAndRemoveUntil (Materi Modul 4)
            // =================================================================
            // Navigator.pushAndRemoveUntil() menghapus SELURUH riwayat halaman
            // di dalam stack navigasi (ditandai dengan: (route) => false).
            // Setelah logout dan dialihkan ke LoginScreen, tombol back HP tidak
            // akan membawa pengguna kembali ke dalam aplikasi resto.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Tampilkan dialog konfirmasi logout
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: const Text('Konfirmasi Logout'),
                          content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              child: const Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(dialogContext); // Tutup dialog

                                // Pindah ke LoginScreen dan reset seluruh tumpukan navigasi
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                  (route) => false, // Hapus seluruh stack navigasi
                                );

                                // Berikan notifikasi SnackBar berhasil logout
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Anda telah berhasil logout.'),
                                    backgroundColor: Colors.blueGrey,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade700,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Logout'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // --- HELPER METHOD: Reusable Card ---
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
