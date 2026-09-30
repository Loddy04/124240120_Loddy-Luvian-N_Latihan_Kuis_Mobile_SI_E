// =============================================================================
// FILE: screens/root_screen.dart
// PILAR MATERI: Navigation (BottomNavigationBar), State & Data
// =============================================================================
// Root Screen adalah "shell" atau wadah utama yang menampung navigasi tab
// bawah (BottomNavigationBar) untuk berpindah antara halaman Beranda dan Profil.
//
// Konsep yang diterapkan:
// 1. STATEFUL WIDGET     -> Diperlukan karena tab yang aktif (_selectedIndex)
//                           berubah saat user mengetuk item navigasi bawah.
// 2. BOTTOMNAVIGATIONBAR -> Widget bawaan Flutter untuk navigasi tab di bawah
//                           layar. Menggunakan indeks (0, 1, ...) untuk
//                           menentukan tab yang sedang aktif.
// 3. INDEXED NAVIGATION  -> Perpindahan tab berbasis indeks, BUKAN stack
//                           push/pop. Ini berbeda dengan Navigator.push().
//                           Tab tidak ditumpuk, melainkan diganti di tempat.
// =============================================================================

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  // --- STATE: Index Tab Aktif ---
  // Variabel ini menyimpan indeks tab yang sedang ditampilkan.
  // 0 = Beranda, 1 = Profil.
  // Nilainya berubah saat user mengetuk BottomNavigationBarItem.
  int _selectedIndex = 0;

  // --- DAFTAR HALAMAN ---
  // List berisi widget halaman yang sesuai dengan setiap tab.
  // Indeks list ini berkorelasi dengan indeks BottomNavigationBarItem.
  // Menggunakan 'const' untuk halaman yang tidak berubah (optimasi).
  final List<Widget> _screens = const [
    HomeScreen(),     // index 0: Tab Beranda
    ProfileScreen(),  // index 1: Tab Profil
  ];

  // --- METHOD: Handler Pergantian Tab ---
  // Dipanggil saat user mengetuk salah satu item di BottomNavigationBar.
  // Parameter 'index' adalah indeks item yang di-tap.
  void _onTabTapped(int index) {
    // setState() memicu rebuild widget.
    // Body di Scaffold akan menampilkan halaman sesuai _selectedIndex baru.
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- BODY ---
      // Menampilkan halaman dari list _screens berdasarkan _selectedIndex.
      // Saat _selectedIndex berubah (via setState), body akan menampilkan
      // widget yang berbeda tanpa navigasi stack.
      body: _screens[_selectedIndex],

      // --- BOTTOM NAVIGATION BAR ---
      // Widget navigasi tab di bagian bawah layar.
      // 'currentIndex' menentukan tab mana yang aktif (ter-highlight).
      // 'onTap' adalah callback yang dipanggil saat item di-tap.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.orange.shade700,
        unselectedItemColor: Colors.grey,
        items: const [
          // Item Tab 1: Beranda
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          // Item Tab 2: Profil
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
