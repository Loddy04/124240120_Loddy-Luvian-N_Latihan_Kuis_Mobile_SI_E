// =============================================================================
// FILE: screens/detail_screen.dart
// PILAR MATERI: Widget, State & Data (TextEditingController), Navigation (pop), OOP
// =============================================================================
// Halaman Detail/Edit yang menampilkan informasi lengkap satu item makanan
// dan menyediakan input TextField angka untuk mengubah jumlah porsi pesanan.
//
// Konsep yang diterapkan:
// 1. STATEFUL WIDGET        -> Diperlukan untuk mengelola lifecycle controller
//                              dan kalkulasi preview total harga secara real-time.
// 2. TEXTEDITINGCONTROLLER  -> Materi Modul 3: Controller untuk mengontrol dan
//                              mengambil nilai input teks dari TextField.
// 3. DATA PASSING           -> Menerima objek FoodItem dari HomeScreen via constructor.
// 4. NAVIGATION (pop)       -> Navigator.pop() kembali ke halaman sebelumnya.
// 5. MUTASI DATA (OOP)      -> Objek FoodItem HANYA diperbarui saat tombol
//                              "Simpan Pemesanan" ditekan. Jika user kembali tanpa
//                              menekan tombol simpan, data porsi tidak berubah.
// =============================================================================

import 'package:flutter/material.dart';
import '../models/food_item.dart';

class DetailScreen extends StatefulWidget {
  // --- DATA PASSING via CONSTRUCTOR ---
  // Objek FoodItem dikirim dari HomeScreen melalui Navigator.push().
  final FoodItem item;

  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // ===========================================================================
  // STATE & DATA: TextEditingController (Materi Modul 3)
  // ===========================================================================
  // TextEditingController digunakan untuk membaca, mengubah, dan memantau
  // teks yang diinputkan pengguna pada widget TextField.
  late final TextEditingController _quantityController;

  // --- LIFECYCLE: initState() ---
  // Dipanggil sekali saat widget dibuat.
  // Inisialisasi controller dengan nilai quantity awal dari objek FoodItem.
  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(
      text: widget.item.quantity.toString(),
    );
  }

  // --- LIFECYCLE: dispose() ---
  // Sangat penting: controller harus di-dispose saat widget dihancurkan
  // untuk mencegah kebocoran memori (memory leak).
  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  // --- GETTER LOKAL: Hitung Porsi & Preview Total Harga ---
  // Mengambil angka dari input text field secara aman.
  // Jika input kosong atau bukan angka valid, default bernilai 0.
  int get _enteredQuantity {
    final text = _quantityController.text.trim();
    return int.tryParse(text) ?? 0;
  }

  // Menghitung estimasi total harga di halaman detail:
  // porsi_diinput * harga_satuan_item
  int get _previewTotalPrice => _enteredQuantity * widget.item.price;

  // ===========================================================================
  // METHOD: Simpan Pemesanan & Kembali
  // ===========================================================================
  // Sesuai aturan: Total harga dan kuantitas pada model asli BARU BERUBAH
  // saat tombol "Simpan Pemesanan" ditekan.
  void _saveOrderAndPop() {
    final int newQuantity = _enteredQuantity;

    // Validasi aturan bisnis: porsi tidak boleh bernilai negatif
    if (newQuantity < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Jumlah porsi tidak boleh kurang dari 0'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // --- MUTASI DATA OOP ---
    // Di sinilah nilai quantity pada objek FoodItem resmi diperbarui.
    // Karena objek dikirim secara referensi dari HomeScreen, perubahan ini
    // akan langsung memutasi objek aslinya.
    widget.item.quantity = newQuantity;

    // --- NAVIGATION: Navigator.pop() ---
    // Menghapus halaman detail dari tumpukan (stack) navigasi dan kembali
    // ke HomeScreen. Di HomeScreen, callback .then() akan menjalankan
    // setState() sehingga UI beranda ter-update dengan total harga baru.
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- APPBAR ---
      appBar: AppBar(
        title: Text(
          widget.item.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // --- BODY DENGAN SCROLL ---
      // SingleChildScrollView mencegah render overflow saat keyboard HP muncul
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- GAMBAR MAKANAN BANNER BESAR ---
            Image.network(
              widget.item.imageUrl,
              height: 240,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 240,
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.orange),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 240,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                );
              },
            ),

            // --- KONTEN FORM DETAIL ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Nama Menu
                  Text(
                    widget.item.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // 2. Harga Satuan per porsi
                  Text(
                    'Rp ${widget.item.formattedPrice} / porsi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 3. Deskripsi Menu
                  Text(
                    widget.item.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 4. INPUT TEXTFIELD UNTUK JUMLAH PORSI (Sesuai Soal Latihan Kuis)
                  // Menggunakan TextField dengan TextEditingController dan keyboard angka.
                  TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.receipt_long,
                        color: Colors.orange.shade700,
                      ),
                      hintText: 'Masukkan jumlah porsi',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.orange.shade700, width: 2.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical: 12.0,
                      ),
                    ),
                    // Rebuild UI lokal agar teks "Total" di bawah ikut ter-update secara real-time
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 18),

                  // 5. BARIS TOTAL HARGA (Preview sebelum disimpan)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Rp ${formatPrice(_previewTotalPrice)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _previewTotalPrice > 0
                              ? Colors.black87
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 6. TOMBOL "SIMPAN PEMESANAN"
                  // Saat diklik, porsi resmi disimpan ke FoodItem dan kembali ke Beranda.
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _saveOrderAndPop,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade700,
                        foregroundColor: Colors.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Simpan Pemesanan',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
