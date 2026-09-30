// =============================================================================
// FILE: models/food_item.dart
// PILAR MATERI: OOP (Object-Oriented Programming)
// =============================================================================
// File ini berisi class FoodItem yang merupakan MODEL DATA (blueprint) untuk
// merepresentasikan sebuah item makanan/minuman di dalam aplikasi.
//
// Konsep OOP yang diterapkan:
// 1. CLASS         -> FoodItem adalah class (cetak biru objek).
// 2. CONSTRUCTOR   -> Named constructor dengan 'required' parameter.
// 3. ENCAPSULATION -> Field 'final' (immutable) & field 'quantity' (mutable).
// 4. GETTER        -> totalPrice, formattedPrice, formattedTotal menghitung
//                     nilai turunan tanpa menyimpan data redundan.
// 5. STATIC MEMBER -> sampleData menyediakan data dummy tanpa perlu instansiasi.
// =============================================================================

class FoodItem {
  // --- PROPERTI (Atribut objek) ---
  // 'final' berarti nilai tidak bisa diubah setelah diinisialisasi (immutable).
  // Ini menerapkan prinsip ENCAPSULATION: melindungi data dari perubahan
  // yang tidak diinginkan.
  final String name;
  final String description;
  final String imageUrl;
  final int price;

  // 'quantity' TIDAK final, karena nilainya akan diubah oleh user
  // saat mengedit jumlah porsi di halaman detail.
  int quantity;

  // --- CONSTRUCTOR ---
  // Named parameter dengan keyword 'required' memastikan semua data wajib
  // diisi saat membuat objek FoodItem baru.
  FoodItem({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  // --- GETTER ---
  // Getter adalah cara OOP untuk menghitung nilai turunan secara otomatis.
  // UI tidak perlu menghitung manual, cukup panggil item.totalPrice.

  /// Menghitung total harga = jumlah porsi x harga satuan
  int get totalPrice => quantity * price;

  /// Format harga satuan ke string dengan pemisah ribuan (misal: "15.000")
  String get formattedPrice => formatPrice(price);

  /// Format total harga ke string dengan pemisah ribuan
  String get formattedTotal => formatPrice(totalPrice);

  // --- STATIC MEMBER ---
  // 'static' berarti data ini milik CLASS, bukan milik instance/objek tertentu.
  // Bisa diakses langsung: FoodItem.sampleData (tanpa membuat objek).
  static final List<FoodItem> sampleData = [
    FoodItem(
      name: 'Nasi Goreng',
      description: 'Nasi goreng spesial dengan telur, ayam, dan kerupuk.',
      imageUrl:
          'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800&q=80&auto=format&fit=crop',
      quantity: 0,
      price: 15000,
    ),
    FoodItem(
      name: 'Mie Goreng',
      description: 'Mie goreng jawa dengan bumbu khas dan sayuran segar.',
      imageUrl:
          'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?w=800&q=80&auto=format&fit=crop',
      quantity: 0,
      price: 12000,
    ),
    FoodItem(
      name: 'Ayam Bakar',
      description: 'Ayam bakar bumbu kecap disajikan dengan sambal dan lalapan.',
      imageUrl:
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&q=80&auto=format&fit=crop',
      quantity: 0,
      price: 25000,
    ),
    FoodItem(
      name: 'Es Teh',
      description: 'Teh manis dingin yang menyegarkan.',
      imageUrl:
          'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=800&q=80&auto=format&fit=crop',
      quantity: 0,
      price: 5000,
    ),
    FoodItem(
      name: 'Es Jeruk',
      description: 'Jeruk peras asli dingin dengan es batu.',
      imageUrl:
          'https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=800&q=80&auto=format&fit=crop',
      quantity: 0,
      price: 6000,
    ),
  ];
}

// --- FUNGSI UTILITAS (di luar class) ---
// Fungsi helper untuk memformat angka menjadi format ribuan Indonesia.
// Contoh: 15000 -> "15.000"
String formatPrice(int value) {
  return value.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'),
        (m) => '${m[1]}.',
      );
}
