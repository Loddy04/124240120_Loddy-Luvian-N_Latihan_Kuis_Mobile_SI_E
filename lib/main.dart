// =============================================================================
// FILE: main.dart
// PILAR MATERI: Widget (MaterialApp sebagai root widget tree)
// =============================================================================
// File ini adalah TITIK MASUK (entry point) aplikasi Flutter.
//
// Konsep yang diterapkan:
// 1. main() & runApp() -> Fungsi main() adalah titik awal eksekusi Dart.
//                         runApp() memulai framework Flutter dan menjadikan
//                         widget yang diberikan sebagai ROOT dari widget tree.
// 2. MATERIALAPP       -> Widget konfigurasi utama yang menyediakan fitur-fitur
//                         Material Design (tema, navigasi, dll) ke seluruh
//                         aplikasi.
// 3. STATELESS WIDGET  -> MainApp tidak memiliki state yang berubah, sehingga
//                         cukup menggunakan StatelessWidget.
// =============================================================================

import 'package:flutter/material.dart';
import 'screens/root_screen.dart';

// --- FUNGSI MAIN ---
// Titik masuk eksekusi aplikasi. runApp() menerima satu widget sebagai
// root dari seluruh pohon widget (widget tree) aplikasi.
void main() {
  runApp(const MainApp());
}

// --- ROOT WIDGET ---
// MainApp adalah widget paling atas di widget tree.
// Menggunakan StatelessWidget karena konfigurasi aplikasi tidak berubah.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Judul aplikasi (muncul di task switcher OS)
      title: 'Menu Resto',

      // Menyembunyikan banner "DEBUG" di pojok kanan atas
      debugShowCheckedModeBanner: false,

      // --- TEMA APLIKASI ---
      // ThemeData mengatur tampilan visual global aplikasi.
      // colorSchemeSeed menghasilkan skema warna otomatis dari satu warna dasar.
      theme: ThemeData(
        colorSchemeSeed: Colors.orange,
        useMaterial3: true,
      ),

      // --- HALAMAN AWAL ---
      // 'home' menentukan widget yang pertama kali ditampilkan.
      // RootScreen berisi BottomNavigationBar yang menampung
      // HomeScreen dan ProfileScreen.
      home: const RootScreen(),
    );
  }
}
