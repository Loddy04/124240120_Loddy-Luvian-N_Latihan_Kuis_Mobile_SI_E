// =============================================================================
// FILE: main.dart
// PILAR MATERI: Widget (MaterialApp sebagai Root Widget Tree)
// =============================================================================
// File ini adalah TITIK MASUK (entry point) aplikasi Flutter.
//
// Konsep yang diterapkan:
// 1. main() & runApp() -> Fungsi main() adalah titik awal eksekusi program Dart.
//                         runApp() menginisialisasi framework Flutter dan
//                         menjadikan widget yang diberikan sebagai Root Widget.
// 2. MATERIALAPP       -> Widget konfigurasi utama aplikasi (tema, rute, judul).
// 3. HOME PROPERTY     -> Menentukan halaman awal saat aplikasi pertama kali
//                         dijalankan, yaitu LoginScreen().
// =============================================================================

import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

// --- FUNGSI MAIN ---
void main() {
  runApp(const MainApp());
}

// --- ROOT WIDGET ---
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Judul aplikasi pada task manager sistem
      title: 'Menu Resto',

      // Menyembunyikan banner 'DEBUG' di pojok kanan atas
      debugShowCheckedModeBanner: false,

      // --- TEMA APLIKASI (Material 3) ---
      theme: ThemeData(
        colorSchemeSeed: Colors.orange,
        useMaterial3: true,
      ),

      // --- HALAMAN AWAL: LoginScreen ---
      // Pengguna pertama kali diarahkan ke halaman login untuk autentikasi
      home: const LoginScreen(),
    );
  }
}
