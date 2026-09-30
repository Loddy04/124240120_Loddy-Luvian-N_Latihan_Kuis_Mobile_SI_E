// =============================================================================
// FILE: screens/root_screen.dart
// PILAR MATERI: Navigation (BottomNavigationBar), State & Data
// =============================================================================
// Root Screen bertindak sebagai wadah (shell) yang menampung navigasi tab
// bawah (BottomNavigationBar) untuk berpindah antara halaman Beranda dan Profil.
//
// Konsep yang diterapkan:
// 1. STATEFUL WIDGET     -> Diperlukan karena tab aktif (_selectedIndex)
//                           berubah saat user mengetuk item navigasi bawah.
// 2. BOTTOMNAVIGATIONBAR -> Widget bawaan Flutter untuk navigasi tab di bagian
//                           bawah layar berbasis indeks (Indexed Navigation).
// 3. DATA PASSING        -> Menerima data username dari LoginScreen melalui
//                           constructor, lalu meneruskannya ke ProfileScreen.
// =============================================================================

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class RootScreen extends StatefulWidget {
  // Menerima data username dari LoginScreen melalui constructor
  final String username;

  const RootScreen({
    super.key,
    this.username = 'Loddy Luvian Nugraha',
  });

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  // --- STATE: Index Tab Aktif ---
  // Variabel untuk menyimpan indeks halaman yang sedang aktif.
  // Indeks 0 = Beranda (HomeScreen)
  // Indeks 1 = Profil (ProfileScreen)
  int _selectedIndex = 0;

  // --- METHOD: Ganti Tab ---
  // Mengubah indeks tab yang dipilih dan memicu rebuild widget via setState().
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // --- DAFTAR HALAMAN ---
    // List berisi widget halaman yang ditampilkan sesuai tab yang dipilih.
    // Data username diteruskan ke ProfileScreen melalui constructor.
    final List<Widget> screens = [
      const HomeScreen(),
      ProfileScreen(username: widget.username),
    ];

    return Scaffold(
      // Body menampilkan halaman berdasarkan tab yang sedang aktif
      body: screens[_selectedIndex],

      // --- BOTTOM NAVIGATION BAR (Indexed Navigation) ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.orange.shade700,
        unselectedItemColor: Colors.grey,
        items: const [
          // Item Tab 1: Menu Resto
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          // Item Tab 2: Profil Pengguna
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
