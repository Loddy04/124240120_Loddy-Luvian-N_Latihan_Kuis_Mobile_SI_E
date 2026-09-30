// =============================================================================
// FILE: screens/food_quiz_screen.dart
// PILAR MATERI: Widget, State & Data, Navigation (push)
// =============================================================================
// Halaman Beranda Variasi B (Kuis Kuliner):
// Mengadopsi struktur soal ujian resmi:
// 1. Menyapa username pada AppBar: "Halo, $username" (Kuis Mobil [10 pts])
// 2. Menampilkan daftar data dengan ListView.builder (Kuis Mobil & Pokemon [10 pts])
// 3. Menampilkan gambar, kategori, nama, types/karakteristik, dan tahun [10 pts]
// 4. Klik item untuk navigasi ke halaman Detail via Navigator.push [10 pts]
// =============================================================================

import 'package:flutter/material.dart';
import '../models/food_quiz_item.dart';
import 'food_quiz_detail_screen.dart';

class FoodQuizScreen extends StatefulWidget {
  final String username;

  const FoodQuizScreen({
    super.key,
    this.username = 'Loddy Luvian Nugraha',
  });

  @override
  State<FoodQuizScreen> createState() => _FoodQuizScreenState();
}

class _FoodQuizScreenState extends State<FoodQuizScreen> {
  // Sumber data dummy kuis kuliner
  final List<FoodQuizItem> _quizList = FoodQuizItem.sampleQuizData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =======================================================================
      // 1. APPBAR MENYAPA USERNAME (Sesuai Soal Mobil [10 pts])
      // =======================================================================
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
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.explore, color: Colors.white),
        ),
      ),

      // =======================================================================
      // 2. LISTVIEW.BUILDER DAFTAR KULINER (Sesuai Soal [10 pts])
      // =======================================================================
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: _quizList.length,
        itemBuilder: (context, index) {
          final item = _quizList[index];

          // ===================================================================
          // 3. NAVIGASI KE DETAIL (Navigator.push [10 pts])
          // ===================================================================
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodQuizDetailScreen(item: item),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 12.0),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  // --- GAMBAR ITEM ---
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      item.imageUrl,
                      width: 105,
                      height: 105,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 105,
                          height: 105,
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 105,
                          height: 105,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        );
                      },
                    ),
                  ),

                  // --- INFORMASI (Kategori, Nama, Types, Asal) ---
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Kategori & Asal (Brand / Kategori)
                          Text(
                            '${item.category} • ${item.origin}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.orange.shade800,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),

                          // Nama Kuliner
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Types chips (Karakteristik rasa, seperti kuis Pokemon)
                          Wrap(
                            spacing: 4,
                            children: item.types.take(2).map((type) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Colors.orange.shade200,
                                  ),
                                ),
                                child: Text(
                                  type,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.orange.shade900,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 4),

                          // Harga & Tahun
                          Text(
                            'Rp ${item.formattedPrice} (Sejak ${item.year})',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Ikon panah ke detail
                  const Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
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
