// =============================================================================
// FILE: screens/profile_screen.dart
// PILAR MATERI: Widget, State & Data (GestureDetector & setState), Navigation
// =============================================================================
// Halaman Profil (Variasi A - Soal Kuis Pokemon [25 pts]) dengan fitur:
// 1. Foto profil default dari local assets (assets/male.jpg) [5 pts]
// 2. Tampilkan username yang sedang login [5 pts]
// 3. Teks sumpah kejujuran wajib kuis [5 pts]
// 4. 2 Tombol bergambar (Male & Female) via GestureDetector [5 pts]
// 5. Tombol Logout dengan Navigator.pushAndRemoveUntil [5 pts]
// =============================================================================

import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  // Menerima data username (Nama) & password (NIM) dari LoginScreen via RootScreen
  final String username;
  final String password;

  const ProfileScreen({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ===========================================================================
  // DATA GAMBAR ASSET LOKAL (Terdaftar di pubspec.yaml)
  // ===========================================================================
  // Menggunakan file gambar lokal di folder assets/ agar tidak terhambat CORS/offline.
  // Catatan: Link URL internet dari lembar soal kuis:
  // - Male   : https://archives.bulbagarden.net/media/upload/1/1f/Sword_Shield_Victor.png
  // - Female : https://archives.bulbagarden.net/media/upload/c/cd/Sword_Shield_Gloria.png
  static const String _maleImagePath = 'assets/male.jpg';
  static const String _femaleImagePath = 'assets/female.jpg';

  // --- STATE: Path Gambar Profil Aktif ---
  // Default pertama kali menggunakan Male Character
  late String _currentProfileImage;

  @override
  void initState() {
    super.initState();
    _currentProfileImage = _maleImagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- APPBAR ---
      appBar: AppBar(
        title: const Text(
          'Profil Karakter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
      ),

      // SingleChildScrollView mencegah render overflow saat layar kecil
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // =================================================================
            // 1. AVATAR PROFIL UTAMA (Dinamis sesuai gambar yang dipilih) [5 pts]
            // =================================================================
            CircleAvatar(
              radius: 65,
              backgroundColor: Colors.orange.shade100,
              // Gambar avatar lokal dari folder assets
              backgroundImage: AssetImage(_currentProfileImage),
            ),
            const SizedBox(height: 16),

            // =================================================================
            // 2. TOMBOL GANTI KARAKTER (GestureDetector dengan onTap [5 pts])
            // =================================================================
            const Text(
              'Pilih Karakter Profil (Klik untuk Mengubah):',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),

            // Baris 2 tombol pilihan bergambar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // --- TOMBOL 1: MALE CHARACTER ---
                _buildCharacterButton(
                  imagePath: _maleImagePath,
                  label: 'Male',
                  isSelected: _currentProfileImage == _maleImagePath,
                  onTap: () {
                    // Logika setState: mengubah gambar avatar ke karakter pria
                    setState(() {
                      _currentProfileImage = _maleImagePath;
                    });
                  },
                ),
                const SizedBox(width: 24),

                // --- TOMBOL 2: FEMALE CHARACTER ---
                _buildCharacterButton(
                  imagePath: _femaleImagePath,
                  label: 'Female',
                  isSelected: _currentProfileImage == _femaleImagePath,
                  onTap: () {
                    // Logika setState: mengubah gambar avatar ke karakter wanita
                    setState(() {
                      _currentProfileImage = _femaleImagePath;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // =================================================================
            // 3. NAMA & NIM (Dinamis dari _correctUsername & _correctPassword) [5 pts]
            // =================================================================
            Text(
              widget.username,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            Text(
              widget.password, // Menampilkan Password login sebagai NIM
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),

            // Badge status
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
            const SizedBox(height: 20),

            // =================================================================
            // 4. TEKS SUMPAH KEJUJURAN WAJIB KUIS POKEMON [5 pts]
            // =================================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.verified_user, color: Colors.blue.shade700, size: 24),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      '“Saya bersumpah mengerjakan soal kuis ini dengan cara yang jujur dan tidak curang dengan cara apapun”.',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // =================================================================
            // 5. TOMBOL LOGOUT (Navigator.pushAndRemoveUntil) [5 pts]
            // =================================================================
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Dialog konfirmasi sebelum keluar
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

                              // Reset stack navigasi dan kembali ke LoginScreen
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false,
                              );

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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // HELPER WIDGET: Tombol Karakter Bergambar (GestureDetector)
  // ===========================================================================
  // Membungkus Image.asset dengan GestureDetector agar bisa diklik (onTap)
  Widget _buildCharacterButton({
    required String imagePath,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange.shade100 : Colors.grey.shade100,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.orange.shade700 : Colors.grey.shade300,
                width: isSelected ? 2.5 : 1.0,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, color: Colors.grey);
                },
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.orange.shade800 : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
