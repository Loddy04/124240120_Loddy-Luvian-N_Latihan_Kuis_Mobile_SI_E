// =============================================================================
// FILE: models/food_quiz_item.dart
// PILAR MATERI: OOP (Object-Oriented Programming)
// =============================================================================
// Model data untuk Beranda Variasi B (Kuis Kuliner Nusantara).
// Menggabungkan atribut dari Kuis Mobil (Brand/Kategori, Nama, Tahun, Harga)
// dan Kuis Pokemon (Gambar, Nama, Types/Karakteristik rasa).
// =============================================================================

class FoodQuizItem {
  final String name;
  final String category; // Analog dengan "Brand" pada Kuis Mobil
  final String origin;   // Asal daerah kuliner
  final int year;        // Tahun tradisi / populer (analog dengan "Tahun" Kuis Mobil)
  final int price;       // Harga
  final String imageUrl; // URL gambar
  final String description;
  final List<String> types; // Tag rasa (analog dengan "Types" pada Kuis Pokemon)
  final double rating;

  FoodQuizItem({
    required this.name,
    required this.category,
    required this.origin,
    required this.year,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.types,
    required this.rating,
  });

  // Helper format harga ke rupiah
  String get formattedPrice {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+$)'),
          (m) => '${m[1]}.',
        );
  }

  // Dataset dummy kuliner kuis
  static final List<FoodQuizItem> sampleQuizData = [
    FoodQuizItem(
      name: 'Rendang Daging',
      category: 'Minang Heritage',
      origin: 'Padang, Sumatera Barat',
      year: 1945,
      price: 45000,
      imageUrl:
          'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&q=80&auto=format&fit=crop',
      description:
          'Daging sapi empuk yang dimasak berjam-jam dengan santan kelapa murni dan aneka rempah rempah khas Minangkabau hingga berwarna gelap dan kaya rasa.',
      types: ['Pedas', 'Gurih', 'Rempah'],
      rating: 4.9,
    ),
    FoodQuizItem(
      name: 'Soto Betawi',
      category: 'Betawi Authentic',
      origin: 'DKI Jakarta',
      year: 1972,
      price: 35000,
      imageUrl:
          'https://images.unsplash.com/photo-1572656631137-7935297eff55?w=800&q=80&auto=format&fit=crop',
      description:
          'Soto khas Jakarta dengan kuah santan dan susu yang gurih nikmat, disajikan dengan potongan daging sapi, tomat segar, emping melinjo, dan sambal cabai rawit.',
      types: ['Kuah', 'Gurih', 'Susu'],
      rating: 4.8,
    ),
    FoodQuizItem(
      name: 'Gudeg Komplit',
      category: 'Jogja Signature',
      origin: 'DI Yogyakarta',
      year: 1950,
      price: 30000,
      imageUrl:
          'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800&q=80&auto=format&fit=crop',
      description:
          'Olahan nangka muda khas Yogyakarta yang dimasak manis dengan gula aren dan santan, disajikan bersama krecek pedas gurih, telur pindang, dan ayam kampung suwir.',
      types: ['Manis', 'Tradisional', 'Khas'],
      rating: 4.7,
    ),
    FoodQuizItem(
      name: 'Sate Ayam Madura',
      category: 'Madura Special',
      origin: 'Madura, Jawa Timur',
      year: 1968,
      price: 28000,
      imageUrl:
          'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800&q=80&auto=format&fit=crop',
      description:
          'Tusukan daging ayam pilihan yang dibakar sempurna dengan aroma arang harum, disiram saus kacang kental legit, kecap manis, irisan bawang merah, dan cabai.',
      types: ['Bakar', 'Kacang', 'Manis Gurih'],
      rating: 4.8,
    ),
    FoodQuizItem(
      name: 'Pempek Kapal Selam',
      category: 'Palembang Pride',
      origin: 'Palembang, Sumatera Selatan',
      year: 1960,
      price: 25000,
      imageUrl:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800&q=80&auto=format&fit=crop',
      description:
          'Kuliner khas berbahan dasar ikan tenggiri segar dengan isian telur utuh di dalamnya, disajikan dengan kuah cuko hitam pedas manis asam yang menyegarkan.',
      types: ['Ikan', 'Pedas Asam', 'Cuko'],
      rating: 4.9,
    ),
  ];
}
