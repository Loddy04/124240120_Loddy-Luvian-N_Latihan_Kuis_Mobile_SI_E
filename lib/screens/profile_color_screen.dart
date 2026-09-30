// =============================================================================
// FILE: screens/profile_color_screen.dart
// PILAR MATERI: Widget, State & Data (Color State & setState), Navigation
// =============================================================================
// Halaman Profil (Variasi 2 - Bobot 35 pts) dengan fitur:
// 1. CircleAvatar dengan warna background default hijau (Colors.green) [5 pts]
// 2. Menampilkan username yang sedang login [10 pts]
// 3. Teks sumpah kejujuran wajib kuis [2.5 pts]
// 4. Tombol Logout dengan Navigator.pushAndRemoveUntil [7.5 pts]
// 5. Terintegrasi dengan BottomNavigationBar [2.5 pts]
// 6. 3 Tombol Warna (Biru, Merah, Ungu) yang mengubah warna background avatar
//    dan tombol logout secara bersamaan saat diklik [7.5 pts]
// =============================================================================

import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileColorScreen extends StatefulWidget {
  // Menerima data username (Nama) & password (NIM) dari LoginScreen
  final String username;
  final String password;

  const ProfileColorScreen({
    super.key,
    required this.username,
    this.password = '124240120',
  });

  @override
  State<ProfileColorScreen> createState() => _ProfileColorScreenState();
}

class _ProfileColorScreenState extends State<ProfileColorScreen> {
  // ===========================================================================
  // STATE: Warna Tema Avatar & Tombol Logout [5 pts & 7.5 pts]
  // ===========================================================================
  // Sesuai soal: Warna background default CircleAvatar adalah HIJAU (Colors.green)
  Color _themeColor = Colors.green;

  // Daftar 3 opsi warna sesuai soal: Biru, Merah, dan Ungu
  final List<Map<String, dynamic>> _colorOptions = const [
    {'name': 'Biru', 'color': Colors.blue},
    {'name': 'Merah', 'color': Colors.red},
    {'name': 'Ungu', 'color': Colors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- APPBAR ---
      appBar: AppBar(
        title: const Text(
          'Profil Pengguna',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          children: [
            // =================================================================
            // 1. CIRCLEAVATAR DENGAN BACKGROUND DINAMIS (Default Hijau) [5 pts]
            // =================================================================
            // Warna background mengikuti variabel state _themeColor.
            // Saat tombol warna diklik, warna avatar akan berubah otomatis.
            CircleAvatar(
              radius: 55,
              backgroundColor: _themeColor,
              child: const Icon(
                Icons.person,
                size: 65,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // =================================================================
            // 2. USERNAME YANG SEDANG LOGIN [10 pts]
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

            // Menampilkan NIM mahasiswa
            Text(
              widget.password,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 20),

            // =================================================================
            // 3. 3 TOMBOL WARNA (Biru, Merah, Ungu) [7.5 pts]
            // =================================================================
            const Text(
              'Pilih Warna Tema (Avatar & Logout):',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),

            // Baris 3 tombol pilihan warna
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _colorOptions.map((item) {
                final Color color = item['color'] as Color;
                final String name = item['name'] as String;
                final bool isSelected = _themeColor == color;

                // Membungkus kotak warna dengan GestureDetector untuk menangani onTap
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      // =======================================================
                      // STATE & DATA: setState()
                      // =======================================================
                      // Mengubah warna tema aktif. Pemanggilan setState() memicu
                      // rebuild widget sehingga CircleAvatar dan tombol Logout
                      // berubah warna secara serentak seketika!
                      setState(() {
                        _themeColor = color;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? Colors.black87 : Colors.transparent,
                              width: 3.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: color.withValues(alpha: 0.4),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: isSelected
                              ? const Icon(Icons.check, color: Colors.white, size: 24)
                              : null,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 28),

            // =================================================================
            // 4. TEKS SUMPAH KEJUJURAN WAJIB KUIS [2.5 pts]
            // =================================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade300),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.gavel, color: Colors.amber.shade900, size: 28),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      '“Saya bersumpah mengerjakan soal kuis ini dengan jujur dan tidak melakukan kecurangan apapun itu”.',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // =================================================================
            // 5. TOMBOL LOGOUT (Warna Berubah Sesuai Pilihan) [7.5 pts]
            // =================================================================
            // Sesuai soal: Tombol logout memiliki warna background yang ikut
            // berubah sesuai dengan tombol warna yang diklik (_themeColor).
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Dialog konfirmasi logout
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

                              // Navigasi pushAndRemoveUntil untuk kembali ke login
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
                  // WARNA IKUT BERUBAH MENGIKUTI _themeColor
                  backgroundColor: _themeColor,
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
}
