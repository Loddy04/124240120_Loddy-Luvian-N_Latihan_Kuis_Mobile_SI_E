# 📱 PANDUAN LENGKAP & CHEAT SHEET KUIS PRAKTIKUM MOBILE PROGRAMMING

Dokumen ini disusun sebagai **buku panduan induk (master guide)**, referensi logika, aturan penulisan, dan arsitektur kode Flutter untuk menghadapi Kuis Praktikum Pemrograman Mobile.

---

## 📑 DAFTAR ISI
1. [Arsitektur & Peta Alur Aplikasi](#1-arsitektur--peta-alur-aplikasi)
2. [Aturan Per-Import-an (Kaidah & Jalur File)](#2-aturan-per-import-an-kaidah--jalur-file)
3. [4 Pilar Materi Utama & Cara Kerjanya](#3-4-pilar-materi-utama--cara-kerjanya)
   - [Pilar 1: OOP (Object-Oriented Programming)](#pilar-1-oop-object-oriented-programming)
   - [Pilar 2: Widget & Hierarki Tampilan](#pilar-2-widget--hierarki-tampilan)
   - [Pilar 3: State & Data Management](#pilar-3-state--data-management)
   - [Pilar 4: Navigasi (Tumpukan Stack)](#pilar-4-navigasi-tumpukan-stack)
4. [Kompilasi Logika Fitur Soal Kuis](#4-kompilasi-logika-fitur-soal-kuis)
   - [A. Autentikasi Login & Validasi Error](#a-autentikasi-login--validasi-error)
   - [B. Daftar Menu & Perhitungan Porsi/Harga](#b-daftar-menu--perhitungan-porsiharga)
   - [C. Ganti Avatar Profil (GestureDetector & Assets)](#c-ganti-avatar-profil-gesturedetector--assets)
   - [D. Ganti Warna Tema Dinamis](#d-ganti-warna-tema-dinamis)
   - [E. Logout Bersih (Clear Stack)](#e-logout-bersih-clear-stack)
5. [Aturan Konfigurasi Gambar (Assets vs Network)](#5-aturan-konfigurasi-gambar-assets-vs-network)
6. [Langkah Taktis Mengerjakan Kuis dari Nol](#6-langkah-taktis-mengerjakan-kuis-dari-nol)
7. [Daftar Jebakan & Kesalahan Umum (Troubleshooting)](#7-daftar-jebakan--kesalahan-umum-troubleshooting)

---

## 1. Arsitektur & Peta Alur Aplikasi

### Struktur Direktori Standar:
```text
lib/
├── main.dart                       ← Titik masuk (Entry Point) & Tema Global
├── models/                         ← [OOP] Blueprint Data Class
│   ├── food_item.dart              ← Model Menu Resto & Hitung Porsi
│   └── food_quiz_item.dart         ← Model Kuis Kuliner Nusantara
└── screens/                        ← [UI & Logika Layar]
    ├── login_screen.dart           ← Form Login & Validasi
    ├── root_screen.dart            ← Shell Navigasi (BottomNavigationBar)
    ├── home_screen.dart            ← Beranda Menu Resto (Hitung Porsi)
    ├── detail_screen.dart          ← Detail Edit Porsi (TextField Angka)
    ├── food_quiz_screen.dart       ← Beranda Kuis Kuliner (ListView Card)
    ├── food_quiz_detail_screen.dart← Detail Kuis Kuliner
    ├── profile_screen.dart         ← Profil Variasi A (Ganti Avatar)
    └── profile_color_screen.dart   ← Profil Variasi B (Ganti Warna Tema)
```

### Diagram Alur Navigasi:
```text
main.dart
  └── MaterialApp(home: LoginScreen)
        │
        │ [Klik 'Login' & Kredensial Valid]
        │ Navigator.pushReplacement()
        ▼
     RootScreen (Wadah BottomNavigationBar 4 Tab)
        ├── Tab 0: HomeScreen (Daftar Menu Restoran)
        │     │  [Tap Kartu Makanan]
        │     │  Navigator.push()
        │     ▼
        │   DetailScreen (Input Porsi TextField -> Simpan -> Navigator.pop())
        │
        ├── Tab 1: FoodQuizScreen (Daftar Kuis Kuliner)
        │     │  [Tap Kartu Kuis]
        │     ▼
        │   FoodQuizDetailScreen
        │
        ├── Tab 2: ProfileScreen (Kuis Pokemon - Ganti Foto Karakter)
        │
        └── Tab 3: ProfileColorScreen (Kuis Mobil - Ganti Warna Tema)
              │
              │ [Klik 'Logout' di Profil A / B]
              │ Navigator.pushAndRemoveUntil()
              ▼
            LoginScreen (Kembali ke awal, history dihapus total)
```

> **Mengapa Login mengarah ke `RootScreen`, bukan langsung `HomeScreen`?**  
> `RootScreen` adalah **"Bingkai"** tempat menempelnya `BottomNavigationBar`. Jika langsung ke `HomeScreen`, menu tab bawah tidak akan muncul atau harus ditulis berulang kali di setiap screen. Di dalam `RootScreen`, tab awal yang langsung ditampilkan di layar tetaplah `HomeScreen` (indeks 0).

---

## 2. Aturan Per-Import-an (Kaidah & Jalur File)

> **Aturan Emas:**  
> *"Kamu hanya meng-import file jika di dalam filemu tertulis nama Class, Widget, atau Fungsi yang berasal dari file tersebut."*

### 1) Import Wajib di Setiap File UI:
```dart
import 'package:flutter/material.dart';
```
*Mengapa?* Karena semua widget dasar (`StatelessWidget`, `StatefulWidget`, `Scaffold`, `Text`, `Column`, `Row`, `Colors`, dll.) berasal dari package ini.

### 2) Menentukan Jalur Relatif (Relative Path):
* **Satu Folder yang Sama:** Langsung sebut nama filenya.  
  *Contoh:* Dari `login_screen.dart` ingin memanggil `RootScreen`:
  ```dart
  import 'root_screen.dart';
  ```
* **Beda Folder (Naik/Keluar 1 Folder):** Gunakan `../`  
  *Contoh:* Dari `home_screen.dart` (di folder `screens/`) ingin memanggil model `FoodItem` (di folder `models/`):
  ```dart
  import '../models/food_item.dart';
  ```

### 💡 Shortcut Sakti IDE (Auto-Import):
Ketik nama class-nya (misal `DetailScreen`), jika bergaris bawah merah, klik kata tersebut lalu tekan:
* **`Ctrl + .`** (Control + Titik) di Windows.
* Pilih opsi **"Import library ..."** — file akan otomatis di-import tanpa salah ketik!

---

## 3. 4 Pilar Materi Utama & Cara Kerjanya

### Pilar 1: OOP (Object-Oriented Programming)
Model data digunakan untuk memisahkan logika data dari tampilan UI.

```dart
class FoodItem {
  // 1. Enkapsulasi / Immutability
  final String name;
  final String imageUrl;
  final int price;

  // 2. Mutable field (bisa diedit di aplikasi)
  int quantity;

  // 3. Constructor dengan named parameter wajib
  FoodItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  // 4. Getter (Kalkulasi Otomatis / Computed Property)
  int get totalPrice => quantity * price;

  String get formattedPrice => formatPrice(price);
  String get formattedTotal => formatPrice(totalPrice);

  // 5. Static Member (Data bawaan tanpa perlu instansiasi)
  static final List<FoodItem> sampleData = [ ... ];
}
```

---

### Pilar 2: Widget & Hierarki Tampilan

1. **`child` vs `children`**:
   * `child`: Untuk widget yang **hanya punya 1 anak** (contoh: `Center`, `Container`, `Padding`, `Card`, `SizedBox`, `Expanded`).
   * `children`: Untuk widget yang **punya daftar banyak anak / List** (contoh: `Column`, `Row`, `ListView`, `Wrap`, `Stack`).

2. **Struktur Dasar Tampilan (Scaffold Tree)**:
   ```text
   Scaffold
     ├── appBar: AppBar(...)
     └── body: SingleChildScrollView (Anti Render Overflow saat keyboard muncul)
           └── Column(
                 children: [
                   Row(...),
                   TextField(...),
                   ElevatedButton(...),
                 ],
               )
   ```

3. **`ListView.builder`**:
   Gunakan untuk menampilkan daftar data panjang secara dinamis dan hemat memori (hanya me-render yang tampil di layar).
   ```dart
   ListView.builder(
     itemCount: dataList.length,
     itemBuilder: (context, index) {
       final item = dataList[index];
       return Card(child: ListTile(title: Text(item.name)));
     },
   )
   ```

---

### Pilar 3: State & Data Management

#### Perbedaan `StatelessWidget` vs `StatefulWidget`:
* **`StatelessWidget`**: Tampilan statis, tidak ada data internal yang berubah setelah dirender (contoh: teks keterangan, icon).
* **`StatefulWidget`**: Tampilan dinamis, memiliki objek `State` yang menyimpan nilai yang bisa berubah kapan saja (contoh: form input, pilihan tab, ganti warna, counter porsi).

#### Kapan Memanggil `setState()`?
`setState()` memberi tahu Flutter: *"Data telah berubah, tolong gambar ulang (rebuild) tampilan yang berhubungan dengan data ini!"*
```dart
setState(() {
  _themeColor = Colors.blue; // Nilai baru
});
```

#### Penggunaan `TextEditingController`:
Wajib dipasangkan pada `TextField` untuk membaca teks input pengguna.
```dart
class _MyScreenState extends State<MyScreen> {
  // 1. Deklarasi
  final TextEditingController _nameController = TextEditingController();

  // 2. Lifecycle initState (jika perlu isi nilai awal)
  @override
  void initState() {
    super.initState();
    _nameController.text = 'Nilai Awal';
  }

  // 3. Lifecycle dispose (WAJIB untuk mencegah kebocoran memori!)
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // 4. Membaca teks input
  void _submit() {
    String hasil = _nameController.text.trim();
  }
}
```

---

### Pilar 4: Navigasi (Tumpukan Stack)

Bayangkan navigasi sebagai **tumpukan piring**:

| Method | Fungsi | Kapan Dipakai di Kuis? |
| :--- | :--- | :--- |
| `Navigator.push()` | Menaruh halaman baru di atas tumpukan (ada tombol *back* otomatis) | Beranda ➔ Detail Makanan |
| `Navigator.pop()` | Mengambil/menghapus halaman paling atas dan kembali ke halaman sebelumnya | Detail Makanan ➔ Kembali ke Beranda |
| `Navigator.pushReplacement()` | Mengganti halaman aktif (halaman sebelumnya dibuang dari tumpukan) | Login ➔ Masuk ke RootScreen (agar tidak bisa *back* ke login) |
| `Navigator.pushAndRemoveUntil()` | Menghapus **SELURUH** tumpukan riwayat halaman | Tombol **Logout** di Profil ➔ Kembali ke Login |

#### Mengirim Data (Data Passing):
* **Dari Halaman A ke B:** Lewat parameter Constructor.
  ```dart
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DetailScreen(item: selectedItem)),
  );
  ```
* **Menerima di Halaman B:**
  ```dart
  class DetailScreen extends StatefulWidget {
    final FoodItem item; // Menerima di sini
    const DetailScreen({super.key, required this.item});
  }
  ```
* **Rebuild Beranda setelah kembali dari Detail (`.then()`):**
  ```dart
  Navigator.push(...).then((_) {
    setState(() {}); // Rebuild Beranda agar total harga terupdate!
  });
  ```

---

## 4. Kompilasi Logika Fitur Soal Kuis

### A. Autentikasi Login & Validasi Error
* **Kebutuhan:** Input Username & Password. Jika benar pindah ke Beranda. Jika salah, muncul SnackBar & border TextField berwarna merah.
* **Logika Inti:**
  ```dart
  bool _isLoginFailed = false;

  void _login() {
    if (_userCtrl.text == 'Admin' && _passCtrl.text == '123') {
      setState(() => _isLoginFailed = false);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RootScreen()));
    } else {
      setState(() => _isLoginFailed = true); // Memicu border merah
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Gagal!'), backgroundColor: Colors.red),
      );
    }
  }
  ```

### B. Daftar Menu & Perhitungan Porsi/Harga
* **Aturan Bisnis:** Total harga di Beranda **HANYA** berubah saat tombol "Simpan Pemesanan" di halaman Detail ditekan.
* **Logika Inti:**
  Di Detail Screen, kalkulasi lokal dihitung sementara untuk preview:
  ```dart
  int get _enteredQuantity => int.tryParse(_quantityController.text) ?? 0;
  int get _previewTotal => _enteredQuantity * widget.item.price;

  void _saveOrder() {
    widget.item.quantity = _enteredQuantity; // Mutasi objek asli
    Navigator.pop(context);                  // Kembali ke Beranda
  }
  ```

### C. Ganti Avatar Profil (GestureDetector & Assets)
* **Kebutuhan:** Klik tombol/gambar Male atau Female untuk mengganti avatar utama seketika.
* **Logika Inti:**
  ```dart
  String _currentImage = 'assets/male.jpg';

  GestureDetector(
    onTap: () {
      setState(() {
        _currentImage = 'assets/female.jpg'; // Ganti string path & setState
      });
    },
    child: Image.asset('assets/female.jpg'),
  )
  ```

### D. Ganti Warna Tema Dinamis
* **Kebutuhan:** Memilih salah satu tombol warna (Biru/Merah/Ungu) akan mengubah warna background CircleAvatar dan tombol Logout secara bersamaan.
* **Logika Inti:**
  ```dart
  Color _themeColor = Colors.green; // Default

  // Pada tombol pilihan:
  GestureDetector(
    onTap: () => setState(() => _themeColor = Colors.blue),
    child: Container(color: Colors.blue),
  )

  // Pada Avatar & Tombol Logout:
  CircleAvatar(backgroundColor: _themeColor)
  ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: _themeColor), ...)
  ```

### E. Logout Bersih (Clear Stack)
* **Logika Inti:**
  ```dart
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    (route) => false, // Menghapus seluruh history halaman
  );
  ```

---

## 5. Aturan Konfigurasi Gambar (Assets vs Network)

| Tipe Gambar | Widget yang Dipakai | Syarat Tambahan |
| :--- | :--- | :--- |
| **URL Internet** | `Image.network(url)` | Butuh koneksi internet. Tidak perlu mendaftarkan file di `pubspec.yaml`. |
| **File Lokal** | `Image.asset(path)` | Wajib didaftarkan di file `pubspec.yaml`! |

### Contoh Pendaftaran di `pubspec.yaml`:
```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/male.jpg
    - assets/female.jpg
```
*(Perhatikan indentasi spasi: `assets:` menjorok 2 spasi dari `flutter:`).*

---

## 6. Langkah Taktis Mengerjakan Kuis dari Nol

Jika kamu diberikan soal baru saat ujian, ikuti urutan kerja ini agar tidak bingung:

1. **Step 1 - Siapkan Model OOP lebih dulu (`lib/models/`)**:
   Buat class data, konstruktor, dan properti hitungan (getter).
2. **Step 2 - Daftarkan Assets (jika ada file lokal)**:
   Masukkan file ke folder `assets/` dan daftarkan di `pubspec.yaml`. Jalankan `flutter pub get`.
3. **Step 3 - Buat Screen Wadah / BottomNavigationBar (`root_screen.dart`)**:
   Siapkan kerangka tab bawah untuk berpindah antar halaman Beranda dan Profil.
4. **Step 4 - Buat Halaman Beranda (`home_screen.dart`)**:
   Pasang `ListView.builder` dan `Card` untuk menampilkan daftar data dari Model.
5. **Step 5 - Buat Halaman Detail (`detail_screen.dart`)**:
   Terima objek via constructor, pasang input controller, dan buat fungsi simpan + `Navigator.pop()`.
6. **Step 6 - Buat Halaman Profil (`profile_screen.dart`)**:
   Pasang data user, interaksi klik (ganti avatar / warna), dan tombol logout.
7. **Step 7 - Pasang Halaman Login & Hubungkan ke `main.dart`**:
   Bungkus `TextField` dengan controller, validasi, dan arahkan ke `RootScreen` via `pushReplacement`.

---

## 7. Daftar Jebakan & Kesalahan Umum (Troubleshooting)

1. **Garis-Garis Kuning-Hitam di Layar (Bottom Overflow)**:  
   *Sebab:* Keyboard virtual HP muncul dan memakan ruang layar.  
   *Solusi:* Bungkus `Column` dengan `SingleChildScrollView`.
2. **Lupa `dispose()` Controller**:  
   *Sebab:* Controller tidak dibersihkan saat pindah halaman sehingga terjadi memory leak.  
   *Solusi:* Selalu tulis `@override void dispose() { ctrl.dispose(); super.dispose(); }`.
3. **Data Tidak Berubah di Tampilan Padahal Variabel Berubah**:  
   *Sebab:* Kamu mengubah variabel tetapi lupa membungkusnya dengan `setState(() { ... })`.
4. **Error Gambar Aset Tidak Ditemukan (`AssetNotFoundException`)**:  
   *Sebab:* Lupa mendaftarkan file di `pubspec.yaml`, salah ketik ekstensi file (misal `.png` padahal `.jpg`), atau lupa menjalankan `flutter pub get`.
5. **Kembali dari Detail Tapi Beranda Tidak Ter-update**:  
   *Sebab:* Di Beranda kamu tidak memasang `.then((_) { setState(() {}); })` setelah `Navigator.push()`.

---

*Disiapkan khusus sebagai panduan komprehensif praktikum & ujian pemrograman mobile.*
