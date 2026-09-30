// =============================================================================
// FILE: screens/login_screen.dart
// PILAR MATERI: Widget, State & Data (TextEditingController), Navigation
// =============================================================================
// Halaman Login untuk autentikasi pengguna ke dalam aplikasi resto.
//
// Konsep yang diterapkan:
// 1. STATEFUL WIDGET        -> Diperlukan karena terdapat perubahan state:
//                              - Status error login (isLoginFailed)
//                              - Toggle sembunyikan/tampilkan password
// 2. TEXTEDITINGCONTROLLER  -> Mengambil dan mengontrol teks input pengguna
//                              dari TextField (username & password).
// 3. ERROR HANDLING         -> Validasi kredensial login dengan menampilkan
//                              SnackBar dan border merah dinamis saat gagal.
// 4. NAVIGATION             -> Navigator.pushReplacement() untuk berpindah ke
//                              RootScreen tanpa bisa kembali ke halaman login.
// =============================================================================

import 'package:flutter/material.dart';
import 'root_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // --- CONTROLLER (Materi Modul 3: State & Data) ---
  // TextEditingController digunakan untuk membaca teks dari TextField
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // --- STATE VARIABEL ---
  // isLoginFailed: penanda apakah login sebelumnya gagal (untuk styling merah)
  bool _isLoginFailed = false;

  // obscurePassword: untuk menyembunyikan atau melihat teks password
  bool _obscurePassword = true;

  // --- KREDENSIAL RESMI ---
  // Data akun login yang ditentukan:
  // Username : Loddy Luvian Nugraha
  // Password : 124240120
  final String _correctUsername = 'Loddy Luvian Nugraha';
  final String _correctPassword = '124240120';

  @override
  void dispose() {
    // Membebaskan controller dari memori ketika widget dihancurkan
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- METHOD LOGIN (Logika Validasi & Error Handling) ---
  void _login() {
    final String enteredUsername = _usernameController.text.trim();
    final String enteredPassword = _passwordController.text.trim();

    // Pengecekan kecocokan data input dengan kredensial yang valid
    if (enteredUsername == _correctUsername && enteredPassword == _correctPassword) {
      // 1. Reset status error jika sebelumnya gagal
      setState(() {
        _isLoginFailed = false;
      });

      // 2. Tampilkan pesan feedback berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selamat datang, $enteredUsername!'),
          backgroundColor: Colors.green.shade600,
          duration: const Duration(seconds: 2),
        ),
      );

      // =========================================================================
      // NAVIGATION: pushReplacement (Materi Modul 4)
      // =========================================================================
      // Menggantikan halaman Login dengan RootScreen di tumpukan (stack) navigasi.
      // Setelah masuk, user tidak bisa menekan tombol 'Back' untuk kembali ke login.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RootScreen(username: enteredUsername),
        ),
      );
    } else {
      // =========================================================================
      // ERROR HANDLING & DYNAMIC STYLING (Materi Modul 3)
      // =========================================================================
      // 1. Set state error agar border TextField berubah menjadi merah
      setState(() {
        _isLoginFailed = true;
      });

      // 2. Tampilkan SnackBar notifikasi pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Gagal: Username atau Password salah!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar halaman login
      appBar: AppBar(
        title: const Text(
          'Login Resto',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
      ),

      // SingleChildScrollView agar form tidak overflow saat keyboard virtual HP muncul
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- IKON / LOGO RESTORAN ---
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.orange.shade100,
                child: Icon(
                  Icons.restaurant,
                  size: 50,
                  color: Colors.orange.shade700,
                ),
              ),
              const SizedBox(height: 20),

              // Judul & subjudul sambutan
              const Text(
                'Selamat Datang',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Silakan login untuk memesan hidangan favorit',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 32),

              // =================================================================
              // 1. INPUT USERNAME
              // =================================================================
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: Icon(
                    Icons.person,
                    color: _isLoginFailed ? Colors.red : Colors.orange.shade700,
                  ),
                  // Dynamic border color: merah saat error, abu-abu/oranye saat normal
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: _isLoginFailed ? Colors.red : Colors.grey.shade400,
                      width: _isLoginFailed ? 2.0 : 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: _isLoginFailed ? Colors.red : Colors.orange.shade700,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // =================================================================
              // 2. INPUT PASSWORD
              // =================================================================
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Masukkan password (NIM)',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: _isLoginFailed ? Colors.red : Colors.orange.shade700,
                  ),
                  // Tombol mata untuk melihat / menyembunyikan teks password
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: _isLoginFailed ? Colors.red : Colors.grey.shade400,
                      width: _isLoginFailed ? 2.0 : 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: _isLoginFailed ? Colors.red : Colors.orange.shade700,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26),

              // =================================================================
              // 3. TOMBOL SUBMIT LOGIN
              // =================================================================
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
