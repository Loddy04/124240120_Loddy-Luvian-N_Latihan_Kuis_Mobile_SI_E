// =============================================================================
// FILE: screens/home_screen.dart
// PILAR MATERI: Widget, State & Data, Navigation (push)
// =============================================================================
// Halaman Beranda yang menampilkan daftar menu makanan restoran.
//
// Konsep yang diterapkan:
// 1. STATEFUL WIDGET  -> Karena data 'quantity' bisa berubah, maka halaman ini
//                        harus menggunakan StatefulWidget agar bisa rebuild UI
//                        saat data berubah melalui setState().
// 2. WIDGET TREE      -> Scaffold > AppBar + ListView.builder > Card > Row/Column
// 3. NAVIGATION       -> Navigator.push() ke halaman Detail, lalu .then() untuk
//                        menjalankan setState() saat user kembali (pop).
// 4. DATA PASSING     -> Mengirim objek FoodItem ke halaman Detail via constructor.
// =============================================================================

import 'package:flutter/material.dart';
import '../models/food_item.dart';
import 'detail_screen.dart';

// --- STATEFUL WIDGET ---
// HomeScreen menggunakan StatefulWidget karena data daftar makanan (khususnya
// field 'quantity') bisa berubah setelah user mengedit porsi di halaman Detail.
// Ketika data berubah, kita perlu memanggil setState() agar UI ter-rebuild
// dan menampilkan data terbaru.
class HomeScreen extends StatefulWidget {
  // Menerima parameter username dari RootScreen untuk menyapa pengguna di AppBar
  final String username;

  const HomeScreen({
    super.key,
    this.username = 'Loddy Luvian Nugraha',
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- STATE: Daftar Data Makanan ---
  // Mengambil data dari static member FoodItem.sampleData (konsep OOP).
  // Variabel ini disimpan di State agar persisten selama widget hidup.
  final List<FoodItem> _foodList = FoodItem.sampleData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- APPBAR (Menyapa username pengguna yang login [10 pts]) ---
      appBar: AppBar(
        title: Text(
          'Halo, ${widget.username}!',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
        // Ikon dekoratif di sebelah kiri judul
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.restaurant_menu,
            color: Colors.white,
          ),
        ),
      ),

      // --- BODY: ListView.builder ---
      // ListView.builder membangun item secara LAZY (hanya yang terlihat di layar).
      // Ini lebih efisien dibanding ListView biasa untuk daftar panjang.
      // 'itemCount' menentukan jumlah item, dan 'itemBuilder' membangun
      // widget untuk setiap index.
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: _foodList.length,
        itemBuilder: (context, index) {
          // Mengambil objek FoodItem pada index tertentu dari list
          final item = _foodList[index];

          // --- GESTURE DETECTOR (Interaksi) ---
          // GestureDetector membungkus Card agar bisa merespons ketukan (onTap).
          // Saat di-tap, akan melakukan navigasi ke halaman Detail.
          return GestureDetector(
            onTap: () {
              // =============================================================
              // NAVIGATION: Navigator.push()
              // =============================================================
              // Navigator.push() menambahkan halaman baru ke atas tumpukan
              // (stack) navigasi. MaterialPageRoute membungkus halaman tujuan
              // dengan animasi transisi Material Design.
              //
              // DATA PASSING: Objek 'item' dikirim ke DetailScreen melalui
              // constructor (parameter). Karena objek dikirim secara referensi,
              // perubahan 'quantity' di DetailScreen juga mengubah data aslinya.
              //
              // .then() : Callback yang dijalankan SETELAH user kembali
              // dari DetailScreen (setelah Navigator.pop()). Di sinilah kita
              // panggil setState() untuk merefresh UI Beranda agar menampilkan
              // data quantity & totalPrice yang sudah diperbarui.
              // =============================================================
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(item: item),
                ),
              ).then((_) {
                // STATE: Memanggil setState() agar widget melakukan rebuild
                // dan menampilkan perubahan data terbaru pada daftar menu.
                setState(() {});
              });
            },

            // --- CARD WIDGET ---
            // Card memberikan efek elevasi (bayangan) dan sudut melengkung,
            // membuat tampilan lebih rapi dan modern.
            child: Card(
              margin: const EdgeInsets.only(bottom: 12.0),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  // --- GAMBAR MAKANAN ---
                  // ClipRRect memotong sudut gambar agar sesuai bentuk Card.
                  // Image.network memuat gambar dari URL internet.
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      item.imageUrl,
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      // Placeholder loading saat gambar belum selesai dimuat
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 110,
                          height: 110,
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                      // Placeholder error jika gambar gagal dimuat
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 110,
                          height: 110,
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),

                  // --- INFORMASI MAKANAN (Tengah) ---
                  // Expanded memastikan bagian ini mengisi sisa ruang horizontal
                  // yang tersedia di dalam Row.
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama makanan (font tebal)
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),

                          // Deskripsi makanan (warna abu-abu, max 2 baris)
                          Text(
                            item.description,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),

                          // Jumlah porsi saat ini
                          Text(
                            '${item.quantity} porsi',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),

                          // Harga satuan per porsi (menggunakan getter OOP)
                          Text(
                            'Rp ${item.formattedPrice} / porsi',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- INFO TOTAL HARGA DI BAGIAN KANAN ---
                  // Sesuai soal: "total harga yang akan berubah ketika porsinya berubah dibagian kanan"
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0, left: 6.0),
                    child: Text(
                      'Rp ${item.formattedTotal}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: item.quantity > 0
                            ? Colors.green.shade700
                            : Colors.grey.shade500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
