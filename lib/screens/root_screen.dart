// =============================================================================
// FILE: screens/root_screen.dart
// PILAR MATERI: Navigation (BottomNavigationBar), State & Data
// =============================================================================
// Root Screen bertindak sebagai wadah (shell) yang menampung navigasi tab
// bawah (BottomNavigationBar) untuk mengakses seluruh variasi soal kuis:
// - Tab 1: Beranda A (Menu Resto & Hitung Porsi Pesanan)
// - Tab 2: Beranda B (Kuis Kuliner & Detail + Tombol Kembali)
// - Tab 3: Profil A (Ganti Avatar Karakter Pokemon via GestureDetector)
// - Tab 4: Profil B (Ganti Warna Tema Hijau/Biru/Merah/Ungu & Sumpah Kejujuran)
// =============================================================================

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'food_quiz_screen.dart';
import 'profile_screen.dart';
import 'profile_color_screen.dart';

class RootScreen extends StatefulWidget {
  // Menerima data username & password dari LoginScreen melalui constructor
  final String username;
  final String password;

  const RootScreen({
    super.key,
    this.username = 'Loddy Luvian Nugraha',
    this.password = '124240120',
  });

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  // --- STATE: Index Tab Aktif ---
  // Menyimpan indeks tab yang sedang aktif (0 s/d 3)
  int _selectedIndex = 0;

  // --- METHOD: Ganti Tab ---
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // --- DAFTAR SELURUH HALAMAN VARIASI KUIS ---
    final List<Widget> screens = [
      // 1. Beranda A: Menu Restoran & Hitung Porsi (Latihan Kuis Resto)
      HomeScreen(username: widget.username),

      // 2. Beranda B: Kuis Kuliner & Atribut Lengkap (Format Kuis Mobil & Pokemon)
      FoodQuizScreen(username: widget.username),

      // 3. Profil A: Avatar Karakter Pokemon Victor/Gloria (Kuis Pokemon 25 pts)
      ProfileScreen(
        username: widget.username,
        password: widget.password,
      ),

      // 4. Profil B: Avatar Hijau & Ganti Warna Tema (Kuis Mobil 35 pts)
      ProfileColorScreen(
        username: widget.username,
        password: widget.password,
      ),
    ];

    return Scaffold(
      // Body menampilkan halaman berdasarkan tab yang sedang aktif
      body: screens[_selectedIndex],

      // --- BOTTOM NAVIGATION BAR (4 Tab Lengkap) ---
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Memastikan 4 tab terlihat rapi
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.orange.shade800,
        unselectedItemColor: Colors.grey.shade600,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        items: const [
          // Tab 1: Menu Resto
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Resto',
          ),
          // Tab 2: Kuis Kuliner
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Kuis',
          ),
          // Tab 3: Profil Karakter (Variasi A)
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: 'Karakter',
          ),
          // Tab 4: Profil Warna Tema (Variasi B)
          BottomNavigationBarItem(
            icon: Icon(Icons.palette),
            label: 'Tema Warna',
          ),
        ],
      ),
    );
  }
}
