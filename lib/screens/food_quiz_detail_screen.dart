// =============================================================================
// FILE: screens/food_quiz_detail_screen.dart
// PILAR MATERI: Widget, Navigation (pop & passing data), OOP
// =============================================================================
// Halaman Detail Kuis Kuliner (Variasi B):
// 1. Menampilkan Kategori + Nama Kuliner pada AppBar (sesuai format Kuis Mobil) [10 pts]
// 2. Menampilkan semua atribut: Gambar, Asal Daerah, Tahun, Types, Harga, Deskripsi [15 pts]
// 3. Tombol "Kembali" khusus di bagian bawah untuk kembali ke Home (sesuai format Kuis Pokemon) [10 pts]
// =============================================================================

import 'package:flutter/material.dart';
import '../models/food_quiz_item.dart';

class FoodQuizDetailScreen extends StatelessWidget {
  // Menerima data objek FoodQuizItem melalui constructor
  final FoodQuizItem item;

  const FoodQuizDetailScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =======================================================================
      // 1. APPBAR: MEREK/KATEGORI + NAMA (Sesuai Soal Mobil [10 pts])
      // =======================================================================
      appBar: AppBar(
        title: Text(
          '${item.category} - ${item.name}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // =================================================================
            // 2. GAMBAR KULINER BANNER BESAR
            // =================================================================
            Image.network(
              item.imageUrl,
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

            // =================================================================
            // 3. DETAIL SEMUA ATRIBUT (Sesuai Soal [15 pts])
            // =================================================================
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Kuliner & Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              item.rating.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Kategori & Asal Daerah
                  Text(
                    '${item.category} • ${item.origin}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Tag Karakteristik Rasa (Types seperti Kuis Pokemon)
                  Wrap(
                    spacing: 8,
                    children: item.types.map((type) {
                      return Chip(
                        label: Text(
                          type,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange.shade900,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        backgroundColor: Colors.orange.shade50,
                        side: BorderSide(color: Colors.orange.shade200),
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Baris Harga & Tahun
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Harga',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Rp ${item.formattedPrice}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange.shade800,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Tahun Populer',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Sejak ${item.year}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Deskripsi
                  const Text(
                    'Deskripsi Kuliner:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ===========================================================
                  // 4. TOMBOL "KEMBALI" KHUSUS (Sesuai Soal Pokemon [10 pts])
                  // ===========================================================
                  // Tombol kembali khusus di bagian bawah yang memanggil Navigator.pop
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Kembali ke halaman Home
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      label: const Text(
                        'Kembali ke Beranda',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade700,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
